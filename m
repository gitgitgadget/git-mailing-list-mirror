Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E15136349
	for <git@vger.kernel.org>; Mon, 12 Aug 2024 20:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723496357; cv=none; b=n7FD/jeWVkiZZiQbELy1xiooWrkkGMMcdi1VTekLFlQcJC0Hw1ovD8zFDgahCKQgiWHLpNmhs/apgT63MOPTbUpjwV+81RuPUCkeA5QpST3G6siROj+iWu6t1y0eeBhYReo5ufROv7ggWi9LP6vnzfJv1UB/j+rJWIm7L38fgI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723496357; c=relaxed/simple;
	bh=Ry7Y9T+BMSMS9SGfEJflGXg/UowtxWCZsHnHZ2QGvIA=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=q9EzFH/ppVyj0s89bVDsLpanWvwpXnjwRPd57parBd+9u5hKgC/NzliaG4c6t+RxtHAP2fgDnGUqrM2yVADtQo+mlgKcpZGhhXKKoazp+iWFWzgD72KlX3cp8m6tdPtkRhZuKB1Fjx23GwVUgOnJbFMLHlqPxEBOXhqnRQZVeIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 47CKx32Z1524516
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Aug 2024 20:59:04 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>,
        "'Josh Steadmon'" <steadmon@google.com>
Cc: "'Patrick Steinhardt'" <ps@pks.im>, <git@vger.kernel.org>,
        "=?utf-8?Q?'Ren=C3=A9_Scharfe'?=" <l.s.r@web.de>,
        "'Kyle Lippincott'" <spectral@google.com>,
        "'Phillip Wood'" <phillip.wood@dunelm.org.uk>,
        "'Edward Thomson'" <ethomson@edwardthomson.com>
References: <cover.1722415748.git.ps@pks.im> <cover.1723095269.git.ps@pks.im>	<k6uar46lu7ffbnboguca65afwegpcpfrivzfm7gspcorfefxnw@csqkd7wsoggk> <xmqqy151zcsc.fsf@gitster.g>
In-Reply-To: <xmqqy151zcsc.fsf@gitster.g>
Subject: RE: [RFC PATCH v3 0/7] Introduce clar testing framework
Date: Mon, 12 Aug 2024 16:58:58 -0400
Organization: Nexbridge Inc.
Message-ID: <033401daecfa$773fa5d0$65bef170$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQE2Q9x0fuag13GoRDOLG7kBaq5wcQJKqFjGAgrSzsgCGILDebM5/NjQ
Content-Language: en-ca

On Monday, August 12, 2024 4:50 PM, Junio C Hamano wrote:
>Josh Steadmon <steadmon@google.com> writes:
>
>> I'm generally in favor of this change, but I'm still unsure what our
>> plan is for importing this from upstream clar. Are we going to vendor
>> our own copy here and (hopefully) someone will pay attention to
>> upstream fixes and apply them to our copy? Or will we replace this
>> with a submodule?
>
>As long as we do not have to make any changes to the "vendored" code =
ourselves,
>that would not matter.  We will not randomly update the gitlink that =
specifies "we
>want to use _this_ version and not other version of upstream clar" =
without good
>reasons if you are using it as a submodule, and we would need to =
justify why we
>are updating the hierarchy if we import the hierarchy as vendored =
source.  So the
>hassle of "updating from upstream" is pretty much the same.
>
>For something as small as "clar", I think it is fine to start with the =
currently proposed
>layout and see what happens.  If we can keep going without touching the =
imported
>part of the sources at all, and the system proves to be useful and =
stable, that is a
>good time to suggest moving it out and binding the selected version of =
the
>upstream as a submodule.

I think we already have a copy customized for git's use. The main clar =
repo on its own
has portability issues. I have contributed a few fixes, but they need =
work.

