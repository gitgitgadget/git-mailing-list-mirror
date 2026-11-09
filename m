Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794253510;
	b=ZWBFq552gjb1DBJi5DhnFChxvW5gzrRmPaAO/JfVgoZ2vULIktcAw7YhX32qhaSsyDgE
	 epoq3C6Ekthpmki9XqD/UUmLbleuAJWxqzJKH7cInleuyv3PgrdnBDN66ihtDDIqiRlyl
	 LtI/2ZfOfYUVLXXhaS9Hpv5YWPG2WZ8DAe53XCk5YcYmfgInxjJBAurf0yVWvucsyE6bw
	 vLS/5ywhcG/LwPG4Y395yBZPt6ej4TRMNVKUesQ7FDlq0N0L0ZMMXcPZB8dBNjinP7oDb
	 RV5sP7pMiwDO7ojuqeu59bxsGVgJftbYbTnBt27orE/N0n8FC6mE23xili10NL3eHWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794253510;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=gR8JzHaW46TTd+V9xVdbtJZMvhb7eRMb31zrv7U+8H4=;
	b=MiQTzpV3C0yt1gaAb/ui22BO1XsDvzdC2TmsjrQhAgUMTeIwJcH4NQhZr6dgTharTFy6
	 M/9wPoKoXRGCVdKFcBacC4/vCKhYmaJZsxN+iKbQLxGNGAKY11SU1iHCumqZoAkw+ypZK
	 9EjjGeVhoI1TLBwiXnYlKYHfXluZJE2Zp5JWNFCDqtEIhdfgfSUhwoUhEjGwPIfvtVlaH
	 tv8Ya3mbIREC1OYcEPUSV5xOr8jnykfeDdcECt/2mGFCSebjyiVbYt8Bg8T97VRYiE8nv
	 /D7zp2KHhg8JAnZV6QKnQoyCDwvfakJpL0VPY6G7XfK/DUYXU8BzHhzTBg478VOsm1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=NQDz1gfI;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="hZoChe/L";
	arc=none smtp.remote-ip=103.168.172.156
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D146D606A32A
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 19:45:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D146D606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=NQDz1gfI;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=hZoChe/L
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 197531400159
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 14:45:09 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 09 Nov 2026 14:45:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794253509; x=1794339909; bh=gR8JzHaW46
	TTd+V9xVdbtJZMvhb7eRMb31zrv7U+8H4=; b=NQDz1gfICbFb2/lUxxxyxMDXCb
	+inthIsm2yIQHiryV43KgVJUqFanIcdh2eSx0lxEy5KnWCch46CgEVbIfRcveoCv
	Ni/sRkEqUDmbqUPggME9lgrwlEp07rIdW0i5YFG5TLyGDnxWMAeJH0UWxjQIgBh5
	153VoF7JansheD8Wqj8uCVdkUCxrXHQOOcG65v/PNOU9d4ROtbOZ/Z4PcG1dzeC2
	cUmMzMY0GEjl9uUS2dSoEOG+NUMetGKud5DqpWQpX7uo//sUkzG4qFcQBzTgjvry
	KhDjVc2TwMXO9ieQhx5aDMBXLEc19SfLjtVtMKaqD/hjQu8VAulsJGCyo1ow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794253509; x=1794339909; bh=gR8JzHaW46TTd+V9xVdbtJZMvhb7eRMb31z
	rv7U+8H4=; b=hZoChe/LTfbBR89xbiFoU0Mkb8j4zrBVo2USHRWrjsSGTwYlZWn
	+FAoSNh7FC2tm/LV7T4w3n21+1UGhnsk5cMW1zCPLQN2S2H3vm1baPumDKiAfg2q
	ggJQNXyVAaLC53YM8SsJ7qxtMfwg5Xl2VqNGwXA3j8RrRpt5b4Pw5zRwKxFt7ZOt
	+Db+fUry52+LCoSwjpR7kYL3qBntarcnpgtvaOykh6jnrPokQtNhfAyg9n5opM8X
	F2P1tmwJAUuduE+oNCOxUi8vMHoKnylyUdY4L0cwgGuYVikwD4uPraTZX0yCzay2
	5pgfRztytMJmbsk81ass32nR3OJ66yvQV+w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794253509; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:cPyUqUuefZ/j5RyPt5woFSPaCeWeUKWQkzloDgo8L2BinVe
	EoXqC5zvNUYN+5afJdtianUpkRI2llmcPssoHuKZfy1wJ0ODntyAk1YuJlKecnbF
	bR4lviyuLJn8I5ucsn/n6m3UPJCS1F/QEA6AUpqq+yQplt2fRnBoE2ySos5shuBL
	PR9DlYhGiO1/bMzi/ZCY2x2+99C7a88ba3xeuR7X0/KtIYt8Slb98RhWI1IJjZlI
	dYurmscyrqB8BRRkTg4KsyEc1KRPz2WmlqfHnH92Ooi0/ulwUga4349+tPYgUcrA
	pXc4MrCvphd/n69wz97jNfqgQquXPLfwp9X4k7g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:7UDSm7yyQRPlqGl1c+DqMVSgA/WTp3GdU+2YC4yIRw8=:IfiTk6tYe+HpTmnzLLm5QBk0dEfGQeuHb98yZrwQciU=;
X-ME-Sender: <xms:xCLyampVICBXvbmz1DNpCyveTzCRJ7areb34xFYtoT1F-FeHaTEjiQ>
    <xme:xCLyavCubusVRj5dA-HZxtkgVzT2MKPSDPDQR1GIpsHAL7r4Nk-6SJjnbakoA48eg
    ODTUYCa0ZO2SRcSUhh4_P78iLo8F_tYAmr9rU1S7wZnRkimusr4tA>
X-ME-Received: <xmr:xCLyahW8UsHe0rdpiY0yBF4gyR0Sj7GI39zagFpvrFDXzNZxyXEAz3bc_fmhzxI4JN27qhaV-rYO25t4OhwQ8FRqX4h-KKMW3mi_>
X-ME-Proxy-Cause: dmFkZTGbfp5CZuOaMnf025Si/tazxoAY+SOKGqnwkSYiU9aMWZqURTvniOEPhgPnr+nhsX
    wlzfS+S9yM6Q53NryzbhFQkWC47uwkUM7anS4su/HhX4vZORxOIVeZFVopMySiwiQ4qKDK
    LIfdfLCt1M74TAbrLydoFyuLMCCZO9uPk96VYKxaOljSfPj46KvFieSWhVGsl8efXSeHZU
    MvzSbuxYJfE0ur35z+JjUWE+Fth2n7ofHtYhx/LD/flZNq1v7o7Pr7JgDPEJkeeGrFDX0I
    hFSHyxWxdKnpFF15TMvAv3G14O/r65e4z9ZLfsrO6wsS3Dl6sgAf/sF9/TUW9E2QLF9LO3
    v5U1LYswZa7BbC/gYXAqNRa1fsYO+4fL39wUH9HK/gEIFH8i/weajLkKV7yh6vo57Lbdav
    RjHQh2r84jM1zHjK+0cBjDy5LQXUZws6b1DVgbm+4wpusS1ukjNuI9GG0DbjvkgDGhtPtJ
    qN1IhkvlUZ/DJsrR4Mo+p60MpdbT+1XTFakN3d8rAyJc0odiu9LQEYbAGPu6IJFmAQInTz
    WHby+LJrrTgXiTF9ag52jasxIrwk6+/sRkbHIGec2IYXOS/6bO9s0ihXM+SSj3W0axEuMU
    AS23ne0B8Fn5Nuersaxrmti2fJPNXBuClLnOVkUkKbA7rJfxTJPXW6OCzcYw
X-ME-Proxy: <xmx:xCLyahAX-Fn7kYl8i0NnYRkIgzOjD8AKsMZgB4gez8E4zQEHnRVg9w>
    <xmx:xCLyauc2Req8lHIMUXJv6k7pp6O-_YdIDpv4wEucydo76argMgdlNQ>
    <xmx:xCLyaopdahFuOhJkZxKjZcfpFg7aPVpbMg42mT2KK3Nk8nGlwlp2hg>
    <xmx:xCLyavQ_b0IUJGjBFCSywgCqmB4OgXnZmXx9V399rjXXrGC2wRZJfQ>
    <xmx:xSLyaiwSroC5VnnwqYk1ywwBnx9Jk4bC1rqMAHY2VtRnT0XPCswVxP9I>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Nov 2026 14:45:07 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Thomas Bachem via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Phillip Wood <phillip.wood@dunelm.org.uk>,  Jeff
 King <peff@peff.net>,  Taylor Blau <me@ttaylorr.com>,  Derrick Stolee
 <stolee@gmail.com>,  Patrick Steinhardt <ps@pks.im>,  Colin Hinton
 <colinlewishinton@gmail.com>,  Matt Hunter <m@lfurio.us>,  Johannes
 Schindelin <Johannes.Schindelin@gmx.de>,  Usman Akinyemi
 <usmanakinyemi202@gmail.com>,  Miklos Vajna <vmiklos@collabora.com>,
  Thomas Bachem <mail@thomasbachem.com>
Subject: Re: [PATCH 01/15] rebase -i: handle NULL value for
 rebase.missingCommitsCheck
In-Reply-To: <226aff79-b0b8-41b1-92ce-78554f6b2f8b@gmail.com> (Phillip Wood's
	message of "Mon, 9 Nov 2026 15:07:19 +0000")
References: <pull.2297.git.1794040967.gitgitgadget@gmail.com>
	<a9a3f4b705f98f0957bc9645395f4c68875b2896.1794040967.git.gitgitgadget@gmail.com>
	<226aff79-b0b8-41b1-92ce-78554f6b2f8b@gmail.com>
Date: Mon, 09 Nov 2026 11:45:06 -0800
Message-ID: <xmqqa4nhzt4t.fsf@gitster.g>
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

Phillip Wood <phillip.wood123@gmail.com> writes:

>> A rebase.missingCommitsCheck without a value, as in
>> 
>>    [rebase]
>>    missingCommitsCheck
>> 
>> or "git -c rebase.missingCommitsCheck", makes "git rebase -i"
>> segfault as it writes the todo list: get_missing_commit_check_level()
>> passes the NULL value to strcasecmp().
>> 
>> The setting takes "ignore", "warn" or "error", not a bool. Read it
>> with repo_config_get_string_tmp(), which rejects a missing value with
>> config_error_nonbool(), as ba176db511 (config: handle NULL value when
>> parsing non-bools, 2023-12-07) did for other settings.
>
> If the user sets an invalid value for this config option then we print a 
> warning and default to "ignore". It would seem reasonable to me to do 
> the same for a missing value rather than erroring out.

Interesting point.  I think ignoring a textual invalid value is
mostly for future-proofing (a configuration item written for newer
version of Git added while trying it out is seen by the version of
Git the user regularly uses).  It may be arguable if warn-and-ignore
is the most sensible option, but I fully agree with you that
behaving exactly the same way on valueless true, which is not a
valid setting for the current version of Git, would be a sensible
thing to do.

It seems with your and Derrick's review, this is the only thing that
needs to be updated in v2?

Thanks.

