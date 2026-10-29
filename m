Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793296102;
	b=ETJRVaark1SFqE86PHh+SsGIfJ6SU/LgkFa85/GTW2/FbBQ05LNMBQtM70j1z57ApGcN
	 UwyT73SRzN0sFTQ3LaEmPcqxelX3+w86HlPvs3jila2OF3gsmEJRLZKL+6MUe5nZV7NCJ
	 AWTApzuoSthdGUozbc2o3h1P4rJtlCmu/r+Y88VLOKgeo8tXtkgWHspprwlbDofkx2Fjy
	 1160jY0uF9W4CG5e2fmEv2UdWrJ/Wv+tJYEqNeMuBcfcNLoBLWlOesZ9IdrrYCLdGWEvg
	 961XGPCZR1nAbjsTmaCKuehYhbgtr0uLmGbU9zc716aeYU8XrcHUuB9k5WT9L35FY1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793296102;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=8RkCdQxDrWq3RBBwpVNXvxw9zQKHOiPCEhMJcTyaTQ0=;
	b=KZG0oeJSmUgnVglzEXepqIOWE3xWKuXvesBp8xIgfG4uMUooF0tj+/cnl2pxai6u3uNr
	 PGPhtom0p79LQg2jg+Rm0dlsS5bqbypXpCC8XTFgzIdqWYunq1XnnOCDnnPh6Y8ZkltPT
	 khhHCMCbM2d7neoxh/QUMtTgb2MmtoqjEv2iHb0ntOoGCjyMsd+tf1yovPgg21Rfo3RrT
	 FnFTIQ7HEJAxjJUTDwTox4Xtj2bZtEseE9TwspF/n7VVgC03bEZe/f6OhENB/b84jWT8b
	 IuseLlLWkWY0huYLCfitIeaCUZqdxFLzu4B+Gp32sqWH1Z4hi42Jy1BKmJmz//DdlXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=ZhdqIl9S;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=fUHO5ORn;
	arc=none smtp.remote-ip=202.12.124.144
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD416606A31C
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 17:48:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD416606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=ZhdqIl9S;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=fUHO5ORn
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 2AF581D000C8
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 13:48:21 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 29 Oct 2026 13:48:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793296100; x=1793382500; bh=8RkCdQxDrW
	q3RBBwpVNXvxw9zQKHOiPCEhMJcTyaTQ0=; b=ZhdqIl9S3rLNBkfwT5pWhoWg6D
	uLz+S4EJgdhh8Dj7rCBpas2Xxd1NMVcQFjGwHLELcXYPzBfbxee630T+LJjTL+oX
	vwm39k8y/sqaomwbSZlWNJ7C+dy7qTPKWwze5XrMypclve0tW4aikykYILVWmuCO
	bXWdKX86R4LQVl/XP965xhN/UyzFIxGoG+SYKkYR5AZB/Urmqx7PLbtg7pJhdoV1
	KJv+0zCyZpQTuSIiKxPM0A6U/VIvA4HwW4SW8RSJEPykl8GHZD7SIswnBuTj2mFD
	0jnvg3T8LopKOyM4TI8TI+sIX4KmX6m/SpewcLxFEM1f8PyLBB2+xJ+fTN+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793296100; x=1793382500; bh=8RkCdQxDrWq3RBBwpVNXvxw9zQKHOiPCEhM
	JcTyaTQ0=; b=fUHO5ORnLLU0LOaoiVf5Ah8cWuVJxjJpuQ7mKnkujeaf1IFgq1f
	hLVn6B71Uc8+TwJNoOVM9/ECb/79bNHw+lGvGEh6WcDJAJTEoa9AU53CgMDXe4lh
	Dm50WmzO2tD583La3D/hOFGQbg7m+Cd8wkM3pK91DoZtRf7G3mqxw14DTPOD0P5k
	uUOVgh7z2nvm48YlLE8d6DzxBeAZgG2mHQWOpMLlqaNNW3Z70wqWxArYzxYgAYC9
	5beTs3Z+XE+HAnp0374quYDNpJ4Y96hMskvpk0r938pGgw030aelngm+6O0eUn+f
	hBcEOJ0m5BB+0JOoMyYZTnAzt/rO2grtHYQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793296100; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:CNkdR9/Bsp944WgAJ3N+UydoT77fevpM9F8Yv93Lnr8J+aD
	R2KtEgvHvgvmStHdbl1zDzEhQU36JcklUfMXUyYmjv44C7Bz845/Paze3hPA3MUV
	azFus+4Kz1544OtF1ije6TQpaf1MqvTTKEyoMWJXfdn8/lVxy79A6wKT455+Ty8P
	/Y8WFMzwroPUmJhrZB3TXI/82Wk2o0LOb/rwWp7F/PEfyYIx/oUVfDS/4nH6sCLa
	AHeA3btBSSTZMvIejBCNaMCouearN4QhOXmLj7D4JybnT6o/XKQ3XuJ8jGAwF85L
	tah3sagfnkw0FgPuIEwqhAV6jldoiGD2o0M92Gg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:c5Qz5YW4UJJHf0Of++jNwFLkUoj3tVmk5URVrrR85LQ=:vPmdVNWVSr1g4EEfeLfJ7MP5+l1iWpxRwtFVuYYiNPI=;
X-ME-Sender: <xms:5Ibjak7_yPkeFEEsnvUnhOTrV3gZs5WtpXD5UTwgzOenu16pBwOH4g>
    <xme:5IbjasyuCQtn2zP_Tb8BLPDheWMeXglEGULRl8E5JanIqaiNuza1Es4jslNnTmMoa
    3Qs6ZQjklfRlTEC3tBGnxkB7ZJU7NulWQYyu399ry3Pfbw8VSAaIh8>
X-ME-Received: <xmr:5IbjarxHTRWggsYF-l9xjRP24v_uIGYtNvqxS0EIPqPvHCqlZplfkpwHQ37SoLhj1iqKR2z98HxPQ8diIAELMuSRowQ518ySa6bD>
X-ME-Proxy-Cause: dmFkZTF8zOax3GMJ7/bx0O+Yf4mLm97eU24VYbnykPAjQyQkHUXOx2+uxPZJgtHZrpOhAS
    29O6kPAqghGDH8CCToyWDOyfCFS6m17l3J1MW2Wf+3FwAAFhoqDESe/R8Z0+34wKAQHwFi
    0U33GpcvNzHlWB1pGou8k9lJp8Qk922g1dk6RqDQYjK1LuZjdUINAqwADgUFHsTex4c0xU
    g4GxGFj6ufiTdpgKpz9tsiXYnZbXKjc38pc0upP0ErZSDeyAlhLmJGBPemO36inBRGiZI+
    ojWRwOOygWHl5XWCyr53dT94soIoK2slfSSv8Q1CLXoSVvMguPe5/sFLj89rmo5ryWYrsr
    Z0itoP1L3JG+8lIJymYtXVia1tANgjFtoBFix9MCNbzYC9eEiAHUd2WVUAyBVouwH3NNGE
    z2+NARDpGW2rFGJKUbNziMQ8LetzvxP73c8HcL70hzR12HsuEDWpylcpeALufV+CvXtjB5
    pfISLB5xLmNmYsa1mldAdWW5XUk2dTQjlaLu1VoNc9C9OQR8vyme42nt9XIaY2I/5MKKp+
    yDAPowYrce7Z5uNVVZ5wbTzBmsIkaTElnNkFnyqmYMhWoteV7TXp62obpUhv8VDWaRlZPX
    1TgY7YG4dg/jSvS1vfm5pc9lrgHC66811SOIxse8vBlvTwCfbCkLxeEqOGLQ
X-ME-Proxy: <xmx:5IbjakydSy8ifYN4T_34X4nJWN0MOO5B7uvmhG_tVZ3xmbRruVxjHg>
    <xmx:5Ibjalb-qTFUVr04cfDY_Anx5ogz_RYf-VJ_GiC3tEo31dWk4EpXNg>
    <xmx:5IbjalXoJu9DO7f8tpNHbvUgiIIxCkx8akoXtQAj_opO4qMbniAS2A>
    <xmx:5IbjajiS4gLKKxgVkQwQwqeNrH1s3HwEOyMtOPlzAU-rhLYHsmDVDA>
    <xmx:5IbjaoAWS523Rs2fM39EpPQHzKdN78WGGvhgyX_vEk6y4SCuGarBDptK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Oct 2026 13:48:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH] remote: resolve "simple" @{push} when pushing to
 another remote
In-Reply-To: <CALnO6CBxMrv01NMqEPCLbGbCPXX9T2Jgjax-L5s2z9s-eUpNDQ@mail.gmail.com>
	(D. Ben Knoble's message of "Wed, 28 Oct 2026 18:24:51 -0400")
References: <pull.2466.git.git.1793105039624.gitgitgadget@gmail.com>
	<CALnO6CBxMrv01NMqEPCLbGbCPXX9T2Jgjax-L5s2z9s-eUpNDQ@mail.gmail.com>
Date: Thu, 29 Oct 2026 10:48:18 -0700
Message-ID: <xmqq8q3g4cv1.fsf@gitster.g>
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

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

>> diff --git a/remote.c b/remote.c
>> index 49ee2ea318..fd434a3a10 100644
>> --- a/remote.c
>> +++ b/remote.c
>> @@ -2016,6 +2016,10 @@ static char *branch_get_push_1(struct repository *repo,
>>                         const char *up;
>>                         char *cur;
>>
>> +                       if (strcmp(remote->name,
>> +                                  remotes_remote_for_branch(remote_state, branch, NULL)))
>> +                               return tracking_for_push_dest(repo, remote, branch->refname, err);
>
> This certainly matches the logic described in the log message, and I
> think it's probably right based on that description. One thing I can't
> decide is whether it should come before or after the current set of
> cases, and I'm undecided. On one hand, it's a new case, so I would
> think it should come after. OTOH, it's a fairly straightforward case,
> and I usually like discharging those early so I can focus on the
> complex stuff.

I actually wondered if the existing case for "simple" becomes a
subset of this new code?  After all, tracking_for_push_dest() asks
where the thing gets pushed to, no?

In any case, all the case arms in this function is getting a bit
unmanageably long and this block is, with an extra artificial block,
unnecessarily deeply nested by one extra level.  I wonder if we can
move the code for "case PUSH_DEFAULT_SIMPLE" case to a separate
function and make it a bit more readable?

I agree that the end result the commit wants to see is sensible and
consistent with the earlier "what should happen with 'simple' when
triangular?" topic.

Thanks.
