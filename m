Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794596357;
	b=vBssrEOUj1r4ngBPejEf2mo5FhyMIXTBZMZ9QNLqBbuzq0hxLf9zvZ6xMBKNqrXfx1jT
	 doRTabvaB9C3XsF61CrvTScCe5165EAv/CjmkODJE9zDdEtxyw7ItaOW1ygFPWqqXmCFV
	 FplLASGYAG42LZbSox2mP2viv5gJFf8A61gZC5wixyQX8lDf2diuHeGfXI4eMpFvbCOxT
	 3IlK05qn+1kXs3dzDjKn7REpzvHKdvzI4YIuK3P1IVEpQwo9kuk/HCvS/5krjT7aoBSpj
	 5bCaf/7bVsV3zg55s+yMitYype+wR0kwBELJFFyNYhU8ajVU+RUtfHmzGiIKlGGs+5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794596357;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=5H0PhkGnQQ9kntsZTJKQXyxqS2pRUxqyf3xRnUiwOjc=;
	b=x8fDngeW3Xc/r3lOLa8prhnRSYIUEFKBSYh9JSynYxpKkX/2HjeJs65vyA2V5MJKWaD/
	 ouWlcZUR6oQnHLxjxfpWHzhBcmpv0OEaH4vEctBCDRrgVlB6ioyF0x073SPAG2qezW12G
	 vMqt+UMDr1mqTMxmBTUq9I7cR4lRiuxAkQvfG+3Y+47+qhgD4wpml193o48ATEXApHKQe
	 RIWX3xzvUC289qVzByrDyavbmZxINyL6qvzQCAVpiWquBcIU32Ax1xXVGJ5ncI6yrPA+V
	 AIPop1I2ccmCPbY/BlhAEWbmbBai5MoNl9vYfUbPa+yuWauuIL95qYIQ3qqhP473jTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=fCnyNl+F;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=S8FM9hhB;
	arc=none smtp.remote-ip=202.12.124.152
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0A3606A8B5
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 18:59:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D0A3606A8B5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=fCnyNl+F;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=S8FM9hhB
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 697F37A00DE
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 13:59:16 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Fri, 13 Nov 2026 13:59:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794596356; x=1794682756; bh=5H0PhkGnQQ
	9kntsZTJKQXyxqS2pRUxqyf3xRnUiwOjc=; b=fCnyNl+FVJRxZMRHX0uPpW0kz3
	wG1BmbG/lsWT24+AX3EgtuQ//hNG1R+2XIfAG4ui+Po+aar4yz3Ni8HlYdY0MPhk
	HJynSjrUwZQD1Lw+6vwJqMW8oIMqHaP/JlmUQiYWJTXTrvvayXmnNk5mX+XPUArB
	WYiw0+EMViQpmXKF9IBQ+SdglhUDOLXxmEDPGPiAyJ+tVEsX/I9qbPraHrGSSTf/
	jIMRQ1Ku76tfFfFbREgNy39HHNY6DNQqFeVA4GJm6Iza7sKQurCLro+SYoOIfXeO
	GINSCwQj3F9qjO6oGMXJ3kj2M1MfD3M1NiCP4Estez+KYS3pGqRuGhcXkzDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794596356; x=1794682756; bh=5H0PhkGnQQ9kntsZTJKQXyxqS2pRUxqyf3x
	RnUiwOjc=; b=S8FM9hhB8d8T0a/mQ/YPz7otlMSzEUjc5ek2McLe0g3kU2YrEST
	+95EHio0fQU2D/wYNrtF0lMC+Qe3ccMEpD7YR6tfOnBBfqi+DxxZcGyViEl0sGyO
	53HYZsA+e1Fe5mmzTYW+TZF6y+DZj61jvBQheWVLa0UQroGoOBT8HlGhAIDAg9Xx
	yDB9LsjjGXKJqVj+nA8Ny/JqEv9Pa1L5DiwG4yxdvn5T3/O16Atk5yUZqDNWK+HB
	fUOB2patMJ1PHffLRDbRFWskOhsiz3ibt0Upln4anySuB6TaCS4zXpS9BecJLBnO
	R9qc0vXc0xKUeJ+B4t6Du9/NT/WMdHlnZ9A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794596356; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:kOvppGAwTfErINwbMsZe7hRaxBlbtvixlGCO67aDGtVE2ux
	1tf8gRDE84YW3J/k1RyPxq9z9LopC5tDVoFYudEH+Srvczz+VgAtogj7Kr4q2rwS
	MVvucr89SN/DLYglfZqTroJuaa+JMBqC9Mzzm6oKe73n3OujrLGTsggZPrDgohJN
	iEQsxWSqy7ye2OMLhAm1uisX2audX7oe5850VJC0kM0JAA8h6ce5xhanK7/c6JSS
	0WWBCfN7h6gl46IReDVBP9dKPBJaDej6lggzwlbfkU4MafIbYQSE2KSfJrH8sWPg
	SL/xC5+HMF014phNBFrPEQJ/gTPo5g3sImfYmkQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:YjDfYlwQGrZsLrAJW28eIAFXfuOSGLCfwQ4vzNW9TmQ=:r9H9KBlkwaTw+tApn4uXffuJJPjF0s3m+oL9yDPo6Uo=;
X-ME-Sender: <xms:A173amT2tUCN9qxQMmxsTcEJo-c6emKQBYpK2f1UicyqPQWt00Rz1g>
    <xme:A173aq27cHPR-N4HvLP4zVVt2Y2nI7LPBsbwxu7-81l_Hggc92pyWYEy0iMb-IX-X
    xYfSITVDDqZKgQtQ0wAR5hj1k2Ywptp3MZrWhAFoFZhluAk7acslhI>
X-ME-Received: <xmr:A173aqAUpgyjBwtjlRqO8_DTf6l3Ecctd7tMDeU8hkUGoK0r0M6ykFISnKgC2EOK12b4NANsiTt1bYZ2k6UfTFiY6zLIIuKj0Xxy>
X-ME-Proxy-Cause: dmFkZTFuofCbhVylfs6JYFNYzed0iY39/e0GrD93kicZ0hgGemT4sxvOVtgseOzsNPpAT3
    3RgB7tyXgrZehDC9AZVfgjY9IB805Num20LgWiAQ2NZwxmxw2EN4MrIN3NtmhxNm8BQyKw
    HSAgK5esSVPIjzWrg92czY8KfG/CSsE8CQPne5P9Ch2CIAR+joHTlcWb41hHGx8xVsTC5K
    jHePIR1xFJE/w8heh1WZjL5YXZliZGiCoRU+JkruadjxcUMBvn2P/7odbjhEYsRaUILjDE
    ePZa3gHIlK/jyNb5GJf7W5dmPX24VsG5ZInTdZY3f3HUzark4HyEWK9icVPpyJ4J9d8BCh
    59qB5wQhdvNt+v/LUrSgpEZbcEjQsWexMvxf6e04ZCDGm+B5PPvN/o3p4a7tuw68Dg6htl
    LJxjvd3KC+f2pVe0XE/jGZI+VC6JyU+D2YVe6uT2d1/y02U2gijkWTdAeSDbt2gt/3RLgX
    y93je5Q1jKdGiLManmhdXsksv4ZZwVoxKNP0Bljx4rkFNWUwO8pEZiOnHA5e0wy5YWk33K
    Oz8T9WEEP+nEf1FMVIHpVTt27oa4zy1pPBjkxun4j5k40sbOXHV5+AxzcsqvwrZPA2S1RI
    gIbg0IyPrkTnksuemSqTh+YVzBFDFPumbmTiviqrm66VulVw4qUlIGzqcVKw
X-ME-Proxy: <xmx:A173auilp9GdQcOoj-5VwivRRg1yrPWTHEPmBBOvrkcN-s_IV0K1qg>
    <xmx:A173akOiji3OAN39wsE_nwFQfav2NBZW4-nMRUMB3vJSPosQygQxXQ>
    <xmx:A173am9G_xuBeevKK-XQkbXCPpAZsSMr6upqP8avgsaHD2I6fWGnFw>
    <xmx:A173atcHEPgBUmSyp6SZq-_yirFvcjQdt2k4NhNyNyDw7RSMjHyaCA>
    <xmx:BF73al3IYwFOZcudyH1GKPrK8gUI8OSYtShOAieUbzpE0BLWply0UGXD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Nov 2026 13:59:15 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jasper Mayone <me@jaspermayone.com>
Cc: git@vger.kernel.org,  phillip.wood123@gmail.com,
  sunshine@sunshineco.com,  kristofferhaugsbakk@fastmail.com,
  ben.knoble@gmail.com,  haraldnordgren@gmail.com
Subject: Re: [PATCH v5 3/5] ref-filter: name the worktree of a branch being
 rebased or bisected
In-Reply-To: <20261111152811.99986-4-me@jaspermayone.com> (Jasper Mayone's
	message of "Wed, 11 Nov 2026 10:28:08 -0500")
References: <20261102182930.3511-1-me@jaspermayone.com>
	<20261111152811.99986-1-me@jaspermayone.com>
	<20261111152811.99986-4-me@jaspermayone.com>
Date: Fri, 13 Nov 2026 10:59:14 -0800
Message-ID: <xmqqwlqgblrx.fsf@gitster.g>
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

Jasper Mayone <me@jaspermayone.com> writes:

> branch.c already knows the answer, as prepare_checked_out_branches()
> records the branch that each worktree has checked out, is rebasing or
> is bisecting. Record those branches in a map as well, add
> branch_checked_out_worktree() to look a branch up in it, and use that
> for %(worktreepath) in place of the map that ref-filter.c builds from
> the HEAD of each worktree.
> ..
>  Documentation/git-branch.adoc       |  6 ++-
>  Documentation/git-for-each-ref.adoc |  5 +-
>  branch.c                            | 10 ++++
>  branch.h                            |  9 ++++
>  ref-filter.c                        | 74 ++--------------------------

Nice loss of duplicated logic.

> +const char *branch_checked_out_worktree(const char *refname)
> +{
> +	prepare_checked_out_branches();
> +	return strmap_get(&checked_out_worktrees, refname);
> +}

Yes, this is related to what I asked while reading [1/5].  Doesn't
what the prepare_checked_out_branches() function in branch.c knows
overlap with the new function added there, and shouldn't we look
into reusing it in the new code path if it is the case?
