Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F481182D8
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 20:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722457536; cv=none; b=Y6RbKN6PwgXJn0vkvxLiCqjr/j3ISiZHrAmmjg8JQE+zqczRgUWfXDrTY0rvYmFmMAj1KbOpJTSON4rqhLoieQMm1rZf7ozHdjmImymidwWaip78oXlYfRfpEZsqtHiJW9Mg+bxUY7Fmm24zqFyeDDoC/J1TeMeThl8OtRkE8Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722457536; c=relaxed/simple;
	bh=87d0Ob1t4lbKAwqEu/49A3u1h0HpE6qOz7uFf7voArI=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=k20OlgijSNmrKaUTxVtNyf4LESlQbHp6sfTJumu2eUQTgFf9392nDvPFHCQP0upuaWtMrfjYv/kSFa+ibqKtNtDmErZvjS0AoyThIO/tvsWB8vQXiAlTErMXXdPQDUZeExPvZYfjVj61e+28OrzwgQBEYg2j5JH/OY5oGjwVQcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 46VKPOBu3313797
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jul 2024 20:25:24 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>
Cc: "'Patrick Steinhardt'" <ps@pks.im>, <git@vger.kernel.org>,
        "=?utf-8?Q?'Ren=C3=A9_Scharfe'?=" <l.s.r@web.de>,
        "'Kyle Lippincott'" <spectral@google.com>,
        "'Phillip Wood'" <phillip.wood@dunelm.org.uk>,
        "'Josh Steadmon'" <steadmon@google.com>
References: <cover.1722415748.git.ps@pks.im> <xmqq7cd18srf.fsf@gitster.g>	<008901dae362$386ae280$a940a780$@nexbridge.com> <xmqqfrrp7bbu.fsf@gitster.g>
In-Reply-To: <xmqqfrrp7bbu.fsf@gitster.g>
Subject: RE: [RFC PATCH 0/3] Introduce clar testing framework
Date: Wed, 31 Jul 2024 16:25:18 -0400
Organization: Nexbridge Inc.
Message-ID: <00a901dae387$c68f6f70$53ae4e50$@nexbridge.com>
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
Content-Language: en-ca
Thread-Index: AQE2Q9x0fuag13GoRDOLG7kBaq5wcQG2RBBYApODSOMCbGq0BbMk1bAQ

On Wednesday, July 31, 2024 12:53 PM, Junio C Hamano wrote:
><rsbecker@nexbridge.com> writes:
>
>> I'm sorry for being so behind the curve... what is clar and where =
does it run?
>
>We have t/unit-test/test-lib.[ch] that are our home-grown unit test =
framework.  A
>handful of tests have been written to use it, when you say "make test", =
or "(cd t &&
>make)", unit tests binaries linked with the home-grown unit test =
framework run.
>
>clar is a _potential_ replacement for our home-grown framework, =
suggested here
>because it would be nicer if we can use off-the-shelf component instead =
of having
>to enhance and maintain our own.
>
>Where and how it runs does not change even after clar turns out to be =
good enough
>for our purpose and we commit to replace our home-grown unit test =
framework
>with it.

Well... I would like to be able to see whether this can be built/used on =
NonStop just
so I can stay ahead of the curve or be far enough in advance of it to =
request any
required fixes to make it work on platform.


