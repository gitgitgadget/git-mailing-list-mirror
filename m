Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792443948;
	b=tTjDfu3zwfdYMLgkVd1HKw67nQrfJkyOLbyzoY1iGn5HpgHJh8WJZ3DRkBQr32//1g95
	 XpS89J1d5KiV7bv5/1wQse4vTEkioowAVCpRcGnGKfRoNRPQXM16MRy2vzZqDy0mXYt8/
	 m9SEPlNdnvhEE0WlRnqa7nXAFtaL2bIO2SeiJ1QBbMnuiMzdQJkLcuOW6G8UdIND/DKlG
	 EpoRpoa9TSIJjAeyz9DFChHhB0y3aU1Jr4TkbwM1OUgrzkC4j7C+pHKeutdDfTBlT7Ljq
	 HiSOiOvgHop9a5xeN6IiP13xz6pz7v599rsBGmqhIvKlvXNJFp3VZ8h2GUejaXMBTVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792443948;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=cGg+jreY3RO3dgyFt62I3vuyVeuEydRDXul7Br50lv8=;
	b=ehtiakT4QwO+F4BJiYkMWy7nJ/bd/HsgQU7SoSBc1SzIyi9xyD+uQDn4ZOaHVJcoJWGY
	 JID9W3bQzrsBwdKWXoE07x0AiQmxSQSqFZillWnMxAFTyMpmUWbjDIUFs0dKSPLIiryJF
	 qFH1AbdhyNNRSkeP5teYWB6+4u7WB8quYGwNTJb23jMyRKdy4voyJB+80t39Jjfg+3SvZ
	 ysAVGAED/0lo8rTJ0loLq4GMcEbGloQjvinHA6gFkkd0c4ZbDj5Yt0WG3s2D7QPwYtZj4
	 xrONinZGqytB6y4IbY2jecNa4YVQUDL0kquNknwY6Psm2H55V3vjSw9RDHS1ZTr+LBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=n5+m81pa;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ohbPiNHi;
	arc=none smtp.remote-ip=103.168.172.153
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6FE606A31A
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 21:05:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D6FE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=n5+m81pa;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ohbPiNHi
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6AFBD14000CF
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 17:05:47 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Mon, 19 Oct 2026 17:05:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792443947; x=1792530347; bh=cGg+jreY3R
	O3dgyFt62I3vuyVeuEydRDXul7Br50lv8=; b=n5+m81paQ7Nn6GmUnRkOch0A8g
	1YNZ6Jr42742nyQU7GUXWc0vvjwLbJVNZWWNa7j21v+YYuCc02nOoEMEmkg3N5k4
	uhRpspz+6z7TAQKCsgTt7YVwL/WwwcwJ8eZgAVbioT2t9u95fiemjOM1eP6qYmJ6
	zOn7X9fmny9zZI4gk301hSGxjJN13ZAqmyLW8HtLH/UFLDPP86VgEkDZuTbAVW0r
	rLvq6ItXF2Yg4MP4Cu1TCSJrrgeRjlEo080wCLKxyAQ8C2s8M94SamdVjq+stT5D
	477W9Wea1nibFTGuPd4EzkF8CNnagMnh/Bckcc6y2s9VDKBd+zRQov5PsGTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792443947; x=1792530347; bh=cGg+jreY3RO3dgyFt62I3vuyVeuEydRDXul
	7Br50lv8=; b=ohbPiNHi8b2fZoE9FRb6ih4DG6P+LrszPY/zFjbPysb+2+B3es6
	lLUKM0po6ZWv55X6aGUOU6M1lOO30on9RpmHYURIVN2T/38ENJRWcY/QeD/kwb65
	5zDueSQ3CcpBXzhUJ7quq7vzscN6Hsgm6V4JBOlHf2Jal6o4kClhy7qXhRNSP/NK
	CfBdjKmnMMf+HRU8cYGcw0gmKNm8MHYHhroUWhQdZfpQLydkiTyST9HWOpE24uIp
	XFryFgW+JHr4W2il2HQ1uWk/YnNkaiNC0punrDSeeksiGsPCw6SU/wLWQRmz3o02
	OcL2er+dX36VgVPrF1wAagVul5XkEZ/oY6A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792443947; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:oA6Ut7KNv9UJYpPz9hYxFqxrk258yY0UTbuQVECuAXdQ06T
	+to4i7zQNod+i5qdJYPuGQDmWxPuAZVa1FhDhUQzvKTwYaj7DljzuB1Jxngg/E4x
	1q5vyw3tO478O1q+Os03kV7iMf7g5XvqpNOtojwhDjpxAkmnoWVW+SsyAjrvuuYk
	LYoxzivRfcw+Q0XTVvFOpdVHPtSDe4spkK/FGm/CVWPtDBMyPNgFMOL8toSobv9j
	j6tzhmeXVfGphiM16p9u4JI0kZ0dIjP41fGQDvBxzhLyxhtjpytQewRMutBaQ1iA
	2W/goVX/Z+bGuivpD4AiiDEslrr++Ec8oPV++zg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:jGW/mqRVI5JY9wxjsbbOOQD4xyAAxXiyaYccaiwIYPE=:HnL3GTxuQzWdlRzEzTACMVnK0FIHiykP2iGZ0aiwupI=;
X-ME-Sender: <xms:K4bWav_WgjjXXydm5iyxZfMftHjZVXI-gVVmdfS32H8fsa92_4nmAA>
    <xme:K4bWauSEpiQ-Md_OGZd11cOgNNLVxoLu3BliRGDAcbOj5Tb1qmJXDCBh1joZypumP
    QoLD1VAMiLfrgp-xfXkCDeDokDe5HWZbhIr8GqmxjW2jSbvzYkIkg>
X-ME-Received: <xmr:K4bWagpCmffzY8NiCkIUdJY06zylwkVOgDNmA3azbB1SF3HnEs15lkRHvm9WLOOdC2WgdEXt7Ox8Rw49fj4eMqZVsK0gY1rCvtOH>
X-ME-Proxy-Cause: dmFkZTFwlE3H7kbT/V485eileJjwQYgOFISOh0KBDOUeYYUyi9uz4cbZyV0CBvCm81r+9P
    ed7dYfpjeRBC7/grNbqcwSK8sBcHyZ9QXI19Bvwnm/FqtbPEMV7GXWDvT2a/A/KVRIyt2P
    XFyVRVthSQlp1TZK387n+ehjgygoUl4dOQKSFRKkAKRKxyuYYh6jdJffaQ6a7p1zywAQxF
    g8naZR2AV45ZsZDbDOB0d6E4p7h2TmFcU5LQd3R/hqhfdcAVxXbFYOLhnfmWsiwfQZ7SjM
    Whh/0DJhsghK1g5HwHsiCK6bkcx/R2+OyLipwRedeo2BHvJFJQ0wGWZHC1r2xyWhUvbVsz
    ++tXRpvxFfnybvNpSzxPvK9dgPTQMVizlA9yyXBIHq4m472HP6etQKOcQ2tKxhryVo6Hql
    jRJk6RtQn+A9EiFGhy+vWdy5Q7WEFoqGCoxw5QC/jApNa4DZc5RSs5eqd/A2zWZx+Vr3QD
    Vd4T9+VXGMhXLX6YnN3YIoSJQLk8b0LmXnnPncudK4CRf1uyVZbUCcFoVFZd+7Z4bDYBxE
    f5qAb7H/l6NS3AKvTJO000XLj9ngSxW8bPRvQB4w01qasecnrsulPY0881kFlf4xUXzRvE
    cHfoBAuROebYj/HHBnVbCQhy4JMuhAq3Kk9nRmR7n4018dKZsG3JRD9KfaPg
X-ME-Proxy: <xmx:K4bWarnPWrjaGu5K1ob0mMhTvmnLf4s1L_p5cSlm8WpT9Tw_ZAcH7w>
    <xmx:K4bWapfXVoNtFH6dJnoI1m5szookIYxzYj0NsHCbz5_8GsEJ0RJ5XA>
    <xmx:K4bWanorgbQ9WTqpbTVCCmVkxdeUAY3phKf_QCJlv5XKLN9iESPkNA>
    <xmx:K4bWajMbjpHHSNI_CPM4Swd7Kpn2I_Qyu6DmyzBHaMXW7gwzXo8wig>
    <xmx:K4bWalaOpri9VMaA8RXKUYOf3e1SDSfAcGHwZ-z1FUUsn-IJ_-6m8u5X>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Oct 2026 17:05:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Shashank S <shashu8660@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  Shashank S via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Kaartic Sivaraam
 <kaartic.sivaraam@gmail.com>,  Christian Couder
 <christian.couder@gmail.com>,  Siddharth Asthana
 <siddharthasthana31@gmail.com>,  Usman Akinyemi
 <usmanakinyemi202@gmail.com>
Subject: Re: [PATCH] prune-packed: remove USE_THE_REPOSITORY_VARIABLE
In-Reply-To: <CANHmUQTj8nR1GmPD2FW3+yfsgdgNh_vwRCcxRhS8GcY4VHDb8g@mail.gmail.com>
	(Shashank S.'s message of "Mon, 19 Oct 2026 22:08:54 +0530")
References: <pull.2266.git.1792341073005.gitgitgadget@gmail.com>
	<atXCFxxe3Lg7fV2W@pks.im>
	<CANHmUQTj8nR1GmPD2FW3+yfsgdgNh_vwRCcxRhS8GcY4VHDb8g@mail.gmail.com>
Date: Mon, 19 Oct 2026 14:05:45 -0700
Message-ID: <xmqqqzhl2yfq.fsf@gitster.g>
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

Shashank S <shashu8660@gmail.com> writes:

>> The question isn't really whether we can safely remove the UNUSED macro.
>> The question is rather whether we can assume that `repo` always points
>> to a proper repository. And for that you need to research whether these
>> commands can be invoked outside of a repository, because if so the repo
>> may be `NULL`.
>
> I have checked git.c file in that file I went through this commands .
> prune , prune-packed and repack which are .
> { "prune", cmd_prune, RUN_SETUP },
> { "prune-packed", cmd_prune_packed, RUN_SETUP },
> { "repack", cmd_repack, RUN_SETUP },
> All this commands are all registered with a special flags '
> RUN_SETUP'. This flags search for .git folder . If it finds a .git
> folder Git successfully initializes the repo struct and passes that to
> valid pointer to your builtin . If it does not find a .git folder (if
> they ran it outside the repository) Git immediately stops and shows
> the error . It never run the code .

The analysis is not entirely correct.  Assuming that your system
administrator is not insane enough and did not make the entire
filesystem as a working tree of a repository,

    $ cd / && git repack -h

does call cmd_repack() with "repo" set to NULL.

The call to parse_options() will give the short help and exit.
Becaues the references to "repo" you added all happen after the code
already called parse_options(), your update will not make the code
dereference NULL.  Some subcommands with tricky call sequence into
parse_options() _may_ have to be a bit more careful than just
checking "are we using RUN_SETUP?".  Of course RUN_SETUP_GENTLY is
an explicit sign that you have to be prepared to see NULL in "repo".

Thanks.



