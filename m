Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBD5184549
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 13:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722520450; cv=none; b=eh/Qkkxo6CwbA7PkomqJkau4g8cEDeEmR9RulPtCdJgUhcgyCoMcxLTcHzh9MVKHP5ja7ND9lL1YYQmYLIMefCPnqR0c2X3OEcE3p51axu4GQbjVcFfQBa5lmE9Ub1scMXP/oGNHzgPiOlmyAY3XdOYOP1HwihwM2yBZVOzkEds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722520450; c=relaxed/simple;
	bh=ao5QY0LxGKvOzwhO3FOJJGJqwHMcRcg6qJ+2EbaEUm0=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=sGwOe/4Cteg6bGoBxcHvx2xZbvAMErGlb/4y1vcPHkUawF71VnftQ+Eq7WluOMJulJi2ZN/N8q0zM4IwNX4dbpWZzL/+WLlsiBhvflyiPIlFuphhOXmqQV04hF0XMUfcTl+9zAvQING3D2fw3U262jAAZxu/0Q/RPnpwY08R1SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 471DrwJY3445207
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 1 Aug 2024 13:53:58 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Patrick Steinhardt'" <ps@pks.im>
Cc: "'Josh Steadmon'" <steadmon@google.com>, <git@vger.kernel.org>,
        "=?iso-8859-1?Q?'Ren=E9_Scharfe'?=" <l.s.r@web.de>,
        "'Junio C Hamano'" <gitster@pobox.com>,
        "'Kyle Lippincott'" <spectral@google.com>,
        "'Phillip Wood'" <phillip.wood@dunelm.org.uk>
References: <cover.1722415748.git.ps@pks.im> <b3db953e88ece99b441993c9248223cc0ecc6be8.1722415748.git.ps@pks.im> <463oz7j4btei57brq42zlnsydguu74n2n22rhdq7iwjk4y2bei@6r32nghurrmr> <00a801dae384$de2780d0$9a768270$@nexbridge.com> <ZqtWDtqkXzjz2A8u@tanuki> <01c201dae40c$821ab5e0$865021a0$@nexbridge.com> <024601dae411$faab2cb0$f0018610$@nexbridge.com> <ZquPfiAWgYjIPGRB@tanuki> <025f01dae419$636bb790$2a4326b0$@nexbridge.com> <ZquSkkR_aw2IUdX2@ncase>
In-Reply-To: <ZquSkkR_aw2IUdX2@ncase>
Subject: RE: [RFC PATCH 1/3] t: import the clar unit testing framework
Date: Thu, 1 Aug 2024 09:53:52 -0400
Organization: Nexbridge Inc.
Message-ID: <027301dae41a$41ea7ce0$c5bf76a0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQE2Q9x0fuag13GoRDOLG7kBaq5wcQE8qfSQAlNXoAsBzj75QwLkmT4KAVwZTGUB2+aESgLXgUnWAYAIFx0B/s5jobLNIsUA

On Thursday, August 1, 2024 9:50 AM, Patrick Steinhardt wrote:
>On Thu, Aug 01, 2024 at 09:47:38AM -0400, rsbecker@nexbridge.com wrote:
>> On Thursday, August 1, 2024 9:37 AM, Patrick Steinhardt wrote:
>> >As mentioned in another mail, we do not use its Makefile at all. Did
>> >you
>> check
>> >whether the version I have proposed here works when running `make test`?
>>
>> That is the commit I have been trying to use. make test in clar or git?
>
>In Git itself. `make test` builds and runs our unit tests, and that now
also includes
>unit tests based on clar with this patch series. The clar Makefile exists
only because I
>did a 1:1 import of the upstream dependency. We could just as well remove
it
>altogether, including other bits that we don't end up using.

I see. Well, the 2.46.0 test passes. I ran 'seen' 5 days ago and 'next' is
going now. Would that catch it?

