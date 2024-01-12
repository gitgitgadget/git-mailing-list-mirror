Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC1815AFA
	for <git@vger.kernel.org>; Fri, 12 Jan 2024 21:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZzPuQIGv"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id C7F71284F0;
	Fri, 12 Jan 2024 16:19:11 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=k2poATydJzfczuFS9Vlbm4D5FVXq7uiY5JWVCa
	8M5ZE=; b=ZzPuQIGvbqH4f/Ut5TP8Bjftqgob5PIZJ9kPXyrJnaCfZH2EJcjv0Y
	nnYieeDFt3bkgDghJ79KW9LgRl2niPRw5MWx1FY05tXiD/xYzYXYdeWtFwa4NASF
	gaKQiuttvMaydQB1J8TblRXX2qd7A3Irfxe1xOE4OKaBhoMBQfsHI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id AEEFC284EE;
	Fri, 12 Jan 2024 16:19:11 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E4B96284EB;
	Fri, 12 Jan 2024 16:19:07 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] advice: fix an unexpected leading space
In-Reply-To: <xmqqsf32bfsn.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	12 Jan 2024 09:52:08 -0800")
References: <04c3556f-0242-4ac3-b94a-be824cd2004a@gmail.com>
	<4aedc15c-4b3f-4f5e-abea-581b501600f8@gmail.com>
	<d5fbdb05-d16a-4390-946e-22a5a7a1b56a@gmail.com>
	<xmqqa5pbcpnx.fsf@gitster.g>
	<60a90f4e-b22c-46cb-a79f-a0e01e711732@gmail.com>
	<xmqqsf32bfsn.fsf@gitster.g>
Date: Fri, 12 Jan 2024 13:19:06 -0800
Message-ID: <xmqqcyu69rn9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 38AFC426-B190-11EE-BB82-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> ...  How about doing it in the pre-commit hook?

Sorry, as it runs before obtaining the proposed commit log message
and making a commit, pre-commit is a wrong one to use.  I meant to
say commit-msg hook that is used to verify the contents of the
proposed commit log message.


