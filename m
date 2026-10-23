Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792772314;
	b=FwxfTFvTyBxqj+UGKQzgeg/I8MayxaLnic8KmL8leDX/ek4eNQ3Gnk4iQtonhVyPIgjt
	 LCrbsCWJX8XZcJJOGMU+qlXizq0BZJCmAD+ya5rZqV/+L+5gMT2KygmLxpdHjRUjGj/6j
	 YSPBnaYQkvpkozIx4qei1QieKT3r5Y3u/i1eN7UKRM+FGkwpAfrdxyDCwni7+tt4fksQx
	 htCW0GdhWowIlCXMkai4tzViLKNextcn/vTeAOmz6Oq/5ryvYYiPakBhWzVcXz8y4rrLW
	 ebgO2egNYYxxwWnFBREgr1B9de5uL5nPcR4OezmHxol5wX0DNk+o2wk9QLUH2ixBepw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792772314;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=HjWw8lfI0COUelj6k0DZzp41h3uCYZlwIlfjftJzSEw=;
	b=Mc6YeccJjFCxP/0dq1UKriDLB9G/ecOnisCB6pTJWIr+OMuizIhm5aPz1yiYbAWJGRkc
	 vNqs4lrwvG7EOu6hcKeIbT3orSO/c9aIdpkRerL4+9AB2wNghknmXFRab82pmn7JdLQAh
	 7ODM90NhgFW9sxl4jMbFHuTlDgEqt1LSoeTsF7rpOFKmisgY0Oeg2kEezBauKbwyqYigf
	 S8Wi0+T2Wasxb50cnP5sxWMIo1sne6KqkvgPFuDOWHIaO4hWU+zESKo8ddmiEZPpqr/YH
	 2OHB3HcdKFb/LsKcV7dDekAsmzI79WlqqT+QaDQGFNONEV67NEMo2mBqV+0TX07rx9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=mhOwLekw;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ELvu05Ew;
	arc=none smtp.remote-ip=103.168.172.155
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6E7606A31A
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 16:18:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF6E7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=mhOwLekw;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ELvu05Ew
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 208741400133
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 12:18:33 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Fri, 23 Oct 2026 12:18:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792772313; x=1792858713; bh=HjWw8lfI0C
	OUelj6k0DZzp41h3uCYZlwIlfjftJzSEw=; b=mhOwLekwzvaiuovXXH7iImzMfO
	fa36w9ZdLQ49DK5l43GGnezy2+ppuUBfMq7MYZEV/cqbaLSPXPbABrmM4NFRUC5z
	yeprFZdGRL2fELA4Xb0kSIUvfgH0A9SrD3SFavnS48ZQ3UmGYom7/aoN2e0DwAhw
	RW5O3/1GxO4xEhEvYX+DeGHexkBfuN9gicjJtgi34eRLeGX18wyOchBGtFs+/l4v
	loKpOKx6JK6J3qgW9Lkn7dqjeM9Fh7QDzEtMIbCjZiIqskq5vAQrlIeEBSzsCPvk
	orZ9Qynav555W+sW+OcmCONHYrHqs8XnjTnGEubusB9qQmn9Rr+Gu6DYgBcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792772313; x=1792858713; bh=HjWw8lfI0COUelj6k0DZzp41h3uCYZlwIlf
	jftJzSEw=; b=ELvu05EwB4GUc1qliiF5MfJZvoQf1vrC9L5XMSa/U+pur1z+zVN
	u7qwirfZLqSEKo+hK0iuKsqTFHYroEjM8pRiK/Zq5xeJd8Wd0AfX/963SjCr4cLT
	8faI0xHMvR0hQKyZwDpQtM3YvLHG9juvv0GYbheMQkgv2aedbANwjKUQsFnNd1hT
	IWkaz0rO/+o2MyqYUfsvgyaAks35Oz8RmSy0f86VI8MUpeb63HLME7zkpqkTCcJL
	V2KYXWO1whNH1yZIhkBWUGMj5BqWR9hdsPZmwOP3KgneGj8mNOVRQDCBJ04JxLmr
	syww6gmnmca/XMqNtKejGuvl628e2S4Rhbw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792772313; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:IqaD9vfIuuseiG3aiBcfwykSWx/rvbH3AJmpBhoj/31YMN7
	SFpTd2LtpdDs+QYpvPcWfjElVhVZX3VfL/q4VP+ieIrLPlsOuczhGNMbVTi1dkgw
	pH45aNqMpEEnF8Ou8E/uo8GRU91LHQL3GY0vZBtslfB9cExDawphcMFsmyJlkI6Q
	lpKgUSJYtZ1LDPs79YVBddEApZBwqreYuMSpG3M/vZBNP7jtKjMkbEd+cCxR8GHV
	AZ0DESiKzXHzQe4yrUa562iUOlaf0BeV/CnJGfmwG8FY5KpdXwH8GoRN6sJi/RNO
	3OzfkcuTW/CAPCh0VheP1QcUM8L//LNR5Q7/iIQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:EO2FLhKKxNjDtbaiBG5qaW947Xj5/fsUTqYkofnDRw8=:LYsckPRGgxW/HHpoVPHxXbcQxvyaRxlgo6bXHU/vo8U=;
X-ME-Sender: <xms:2Ijbaoon1zNR8da7Y4VpLSBSmlDdQF4ASUOZV9dN153HyWWLn4za0w>
    <xme:2Ijbag7WJ37qX3cy62RUWy8B5XJFAzZ866Ss8rKh8orVVrWNAze_EP3mNh1MsMG2A
    mdZHS0Iq4P20eJV6rGkSyBX6qUAw9Qf2TJ2YWMkjesmwKLsJ73kCQ>
X-ME-Received: <xmr:2IjbaveTcuWcf7EmWrHeLb909GiIohTyf5MsEiLoNswL7i8xVklUBqcOKXNgB0FIdpfnaa0ZACw9i1MdMjIYlb1Gf2T85xycJ80g>
X-ME-Proxy-Cause: dmFkZTE8uXwzGWjiKc2tWfnEO0CUcrKtxxAKGll/o+66TmfRa/cMRDtv/M8zSGQA8DwdeM
    k914k6vdWeAt+u1uHCtB227cmIQhZ2CIna83FkRh6F7oyGGH/Q9pFvxm5V273+zSAn8L32
    Hq4D2i/E0ppLkycO9oyJvcvsJ6H+eXRK63WTAN2mi+vsm+yhiUty9E8i48frCIHjC9O1qf
    un7BVXI6x7+NAnqHBo01uQ8tYfoj8h6JsLF+9H41eKpM1HIJSIHhl4tgpWkvZjpJLngz71
    2xYH0AiPaOTh7KhGRkFXGQbefe1TES0kdm6ncp+dWWr5GMpJX7XtNEYcCkhn/YxZFyIobe
    X4ZHptZZloPrpYUOE+8/vQ6RJTgKqfwRsi9gCcLR0cP/7LVNUB7mz2/unicCCR0GGBZzTf
    v1uEbCUTYx+VYgAgFamfHemsEbxUpQXLWgYEBrypzGFQ8B7rluVCoc0D1Pd4fYQyQQHumY
    zngRuNJGsQsMNeeeoKiEzkmHF/zKSg7U4GLriIA5Y7gz3RLy2s33v+3sykh/5PJgqRk8nZ
    NupnOy/KQWlCZk48BrSmi5Xl+WvPlu9IWLyi59m9u5KyoWyI1J5jF800vMbhwbKHi12Q9T
    CesELNt5qwtUTU1V2kMRQDdgaAVImNRJAaCoubZKcyrkagcjySdDgHR7xDCw
X-ME-Proxy: <xmx:2Ijbal5YHMszMW_2-tEAfMUP8ROUIzE97jyeDVEqPZDKtqxcLPE6nA>
    <xmx:2Ijbamvo0jQmT4kzH-JTvdxTdr4BKyisUJGiuCgd8klz05krbc4VmA>
    <xmx:2Ijbalh3jlnF4pKVu3kj11F93xS5oW0zmRveAQowloLGk41YAp8H-g>
    <xmx:2Ijbaho83On6RbYNiuX4EUjazsLOJj-j9xWR1QCyirp__K0hpgg0nA>
    <xmx:2Yjbas9q1WRasYTWxQrAfJW5E6SmpE8VVrHm7_sIx_2dhqzMGjZQzh4P>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Oct 2026 12:18:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  Jeff King <peff@peff.net>,  "D. Ben
 Knoble" <ben.knoble@gmail.com>,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v4 0/6] [doc] Add new page on merge conflicts
In-Reply-To: <xmqqh5ic9zas.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	23 Oct 2026 09:06:35 -0700")
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
	<pull.2237.v4.git.1792764293.gitgitgadget@gmail.com>
	<xmqqh5ic9zas.fsf@gitster.g>
Date: Fri, 23 Oct 2026 09:18:31 -0700
Message-ID: <xmqqcxt09yqw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> Handling merge conflicts is difficult, and currently Git's guidance on merge
>> conflicts isn't giving users the information they need to navigate the
>> process. As usual, the process I used to write this was to collect comments
>> from Git users on the existing documentation, and then address those issues.
>> I listed the specific issues we're aiming to solve in the first commit
>> message in the series.
>
> $ make check-docs
> GIT_VERSION=2.56.0.rc2.6.gf97f562a2c
> make -C Documentation lint-docs
> make[1]: Entering directory '/home/gitster/w/git/Documentation'
>     LINT MAN SEC gitmergeconflicts.adoc
> gitmergeconflicts.adoc:339: has no required 'SYNOPSIS' section!

Ah, nevermind. Merge to 'seen' is (and has been) taking care of this
already.

