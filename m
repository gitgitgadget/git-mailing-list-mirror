Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792800192;
	b=nEPc4JsWD8Y+vZdy8UC73CTfVlPr15xxDx6tL41+ghG8bcap0AZH7si0ITYyJfpFPvlD
	 8/Jfo1xkbGDMxsyJY4iQaJtHTlFkhbAShQ6d3EDtAJbV3BkCXy3bjD3u3Q8bbNAFCtBmg
	 VYR+yTE/Rkjfkm5ajVmnNS4TclOuSLd41xPCOEYq7dKpzeNTRK+JgqbQaWICy4uq4MnEC
	 0Qr5TA8vsyi0UGOgL5rIdxVB/prSsddfdeElA/O0VMZpWBL98Uh3ePwNksuNmG0+T4nWM
	 lf5l4rwaUKMhpbmgCwT1CyagzzMpxCwUANVt6iX4ruGSV+Pzz1/gWU7kK5uyF1GWVQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792800192;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=Vn7yHmFigTxkhft6z+c2+yrQLtd+FOQqc8J+CSNmRjU=;
	b=Fkcm2Lgd5w3YoZ8SZbLviZs3CKQJljSJtj+9vyTJW9U4GJ4zYuYPIi4EuXn5r5Z/vT/+
	 RlgGZTyJJjvtG5f1/xrZqUKE5gI3MbLCyMKEkpJSLpovGJcE5Ym9+wANM2G44QGIv/ipt
	 rEkTTOTGQzXdrItCPOXMcov/8EApwsXDaa52NyGc9EqjmOcp4sH1Uh/ZawHuG0kSwDq0+
	 IhfOHVvw3WGlpuKJD+dt+tz7OLH4UYyXqvvNlJJX4G0z5II3SDNAS91dnJSJBsmBJTa3g
	 R9gfM0eot+O4hMHTnlbYoy/ZCSaULUcucOzHRJj0Y83oR6iZweIxorojiUVEBIku2hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=openai.com;
	spf=pass smtp.mailfrom=openai.com;
	dkim=pass header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=GQGXQ3JF;
	arc=none smtp.remote-ip=209.85.219.49
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F34606A31A
	for <git@vger.kernel.org>; Sat, 24 Oct 2026 00:03:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2F34606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=GQGXQ3JF
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-91b834592afso15442806d6.0
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 17:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1792800191; x=1793404991; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Vn7yHmFigTxkhft6z+c2+yrQLtd+FOQqc8J+CSNmRjU=;
        b=GQGXQ3JFzTy0DM695rl1fkvEqsFK/VwOZcWtiz8lfQ+xpeZQ/d1qqitcN+TmZ5AK5M
         CEYRB9VsnMCcMdg82ZEdFz2+D9H+fly1rVgPikOy19GUWvBweLdjeu9oUWCpVJq/Kd4e
         btLbRwDrTYmPIXZ6CcDZtlE0EKMzL+AeidpSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792800191; x=1793404991;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vn7yHmFigTxkhft6z+c2+yrQLtd+FOQqc8J+CSNmRjU=;
        b=yOcJJksMO8BLs58Yv78R/hepQaezgqb9hsHMMhz4cn9CUSTg2MB9YxRG6m0AD+HTgY
         CM/Ts/Hg/FcYBQwlyq0ntN3TYrqZJyRcAxNR/a1UyToj7bn8sbB/9Y1MtddE3qOpUTgb
         Z6Ad1XJgemj7i0y0yg/7pw4XlqV/oy8Ys+heX4VuF1T/CF8mSQsmqrrOyB976J+3TnY8
         XK7kxUQwziS0CGCpqimusSIFaobuXOBMSDxs0hJKA6WVtgRBVLUr/77SROiS6L98hp9n
         YBVhrNI4oKZVjxGvE7FlasT4ewRih6PJn+arGbOQv9tkpLMMn5kyAZcQRZeIZmDRUg8g
         I/RA==
X-Gm-Message-State: AFq9FYLMjOZmWbqCOuf4OKgi8SlYe4Ii3MKpZ+7rxLjgsUGUsY127S0e
	KWAzo6bWsonDApJAi6MUs6FC/C8r43e0ouGYfKXW7YMkDOO5VLCMeyPU3LRedP3mdz4=
X-Gm-Gg: AYBFou17W8Grizgb2B6US8l/HYCrjbIpl9+/PgP/FwzCK22fqydEFxJ31VXG/sSSe6i
	emJVNvTwpQ9vIxtNU8VKKgOUC1ub1RrP6kvmUT50oKsE3SKS/KtCouiSnGjaMD6dmBILt4oC/oG
	VPKiChfCJB6w2d7Ge89W8Rd9dznijeg/480620DMBG7TGicpXNC3rSivKB0RHZnS5Yh7G6NqL59
	Hgv80JSC5cktBZg4zBkBN2jX4DO+xYSSALKGLwi7Qd4doPwpp2SxxjPvSnYg9Rbvsy2PLbvy2Fs
	VwQdP1g42lKXik6Y5cFO0R+zbcO//d8OR8pxhtF2teTINgSwDL/RL/fEagLC2k9/L2NxKXKd7Zs
	pFLmHPszjwLfcyaoRJ0IK0U2Wj2RBYhsDG442rP0vycnS1rfDLZeTYZl7btMPaWsk+4cUggQ2Iu
	3jGeddSiCWOWOsxpL+qzgvSXQKXxm9y7UlxjSpjCmeeQPxtCWb0pQA44FyVScAEtVIdOmHwoEW6
	OaBalRtMfjzg6CrPH4jENt/R7oFPNUJdPxyfFZmcIOcngqIGj99X6bssMROHur0V7tU0J7M9xwA
	ehVhskspupGNXJJYU4jr2zpblU7dxvaAvrX/mmTQlM37vdg+r6R3KKBQ+XKfsKR1+a9s
X-Received: by 2002:a05:6214:2627:b0:91b:5d3a:4fcc with SMTP id 6a1803df08f44-91c48ee12f0mr10214756d6.57.1792800190581;
        Fri, 23 Oct 2026 17:03:10 -0700 (PDT)
Received: from com-79390 (vpn-eastus-02.tradc-corp.com. [20.102.114.220])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c47c4399fsm7575356d6.22.2026.10.23.17.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 17:03:10 -0700 (PDT)
Date: Fri, 23 Oct 2026 19:03:04 -0500
From: Taylor Blau <ttaylorr@openai.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>, Elijah Newren <newren@gmail.com>,
	Jonathan Tan <jonathantanmy@fastmail.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Derrick Stolee <stolee@gmail.com>, Ted Nyman <tnyman@openai.com>,
	Daniel Reynaud <dreynaud@openai.com>,
	Aaron Friel <friel@openai.com>
Subject: Re: [PATCH v2] negotiator/skipping.c: parse parents before queueing
Message-ID: <atv1uK2ZIupPgrES@com-79390>
References: <dc3dfa3647c42da9170bf3289f4e8a4a8a55c8e2.1792441003.git.me@ttaylorr.com>
 <9e9ae442333b5e2ccc0905c44c2c3e16c49481a7.1792704069.git.me@ttaylorr.com>
 <xmqqld7pcqku.fsf@gitster.g>
 <atqSs0yzXw0cf3cH@com-79390>
 <xmqqh5icbial.fsf@gitster.g>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh5icbial.fsf@gitster.g>

On Fri, Oct 23, 2026 at 07:30:58AM -0700, Junio C Hamano wrote:
> Taylor Blau <ttaylorr@openai.com> writes:
>
> > On Thu, Oct 22, 2026 at 03:34:25PM -0700, Junio C Hamano wrote:
> >> Perhaps rev_list_push() should mark the commit as 'SEEN' only after
> >> repo_parse_commit() succeeds?
> >
> > I considered this but ultimately decided against it, since the default
> > negotiator does:
> > ...
> > There are various callers of rev_list_push() in the default negotiator,
> > but all include SEEN in the provided 'mark'.
>
> It is understandable that we do not want to widen the scope of the
> patch by adding a preparatory "fix the existing ones" step, but I do
> not think "the existing ones make the same mistake" is particularly
> a good excuse to add new one.

I think that's fair. For what it's worth, when writing it my thought
process was "let's be as consistent as possible with the most
battle-tested negotiator" as opposed to "this is broken, let's repeat
the breakage elsewhere".

But looking at it more closely, I think you're right that there is a bug
here in the default negotiator. So...

> Would a hybrid approach to (1) avoid copying a mistake to new code and
> (2) document near the new code and/or in the log message that the
> difference is deliberate and fixing existing ones are #leftoverbits
> and not addressed in this commit?

I think a hybrid approach is fine, though I am happy to fix the default
negotiator alongside this series. I have a patch for it locally, but I'm
happy to send either depending on your preference.

Thanks,
Taylor
