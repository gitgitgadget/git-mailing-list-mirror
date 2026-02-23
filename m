Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB1031578E
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 16:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771865345; cv=none; b=nsi3odpSMIdsAo2lp1K+Ff3+ZJMKbBfDDoHj61In2U5Bx2wL+zmD/OxxPgrOFPD+xh9pWJQcnSQURR1yd8VxsatEwRpNH7At+TucsakeFbA9VJ/jEiWgwSRgitPt6hGnb4WK7jaHLpzoQ8DyZ8g3z/jkfOEIiUndQoLDafAUnAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771865345; c=relaxed/simple;
	bh=kN0TugSOI2gMe3Zaax348xPi/m6pHB14uiVvGdUtcbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BGJH6+nNqHerEkyysFMGIhcycXt2lcOvLVrGd0VCmoWFxj3pCqAzn4odXaAJZrYJsen5f+tknkHNL9CcOosz3NtQ8giMQNEe1Q1oiWyNlUP22m4RXICRgZ0JfgpWuAkeQoiE8qMEsDz7pykgwaRV5qISMiMfR6lz11/ZR8j+4rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JsDB2RPh; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JsDB2RPh"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-40ee9b945d5so2717264fac.0
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 08:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771865342; x=1772470142; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DV+0AaRRHR3DN8PfFkvdurRkTykBU7sLSPH0ruip+/g=;
        b=JsDB2RPhh2Nf2c2C52MEJG/ZJ6rn3C2S+T1L1BVm+q+utvNsflJBhhs9SPdZQTIt2h
         asJE0zmHhybldIA/8fS7gR8HzvpzGa8cq76debE3lnx2YJa7f+NijCy0e45g0xKV9DzF
         ye59LBz84W4DuLGN6K7RRA8aad9DXk4baf85dA6qf6KQDdWCQfaFiFn/8MspQDyjFwqi
         TMvPtWJiCgjES6cNioO/dn72q9odPOoH/rO57PfrxuXmUaa0bo+NbtfWOHSkcBUJp5a9
         c/H6B5CzrAzct6VAD342ikDeZHDMQwfN42ta3YQTVFAxin2MXhcM1BByFS3qUNVd8/3x
         jRvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771865342; x=1772470142;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DV+0AaRRHR3DN8PfFkvdurRkTykBU7sLSPH0ruip+/g=;
        b=EApRMX9ZLMRYSmjFn89Nq39gJd23ue/jL4zo+Im5DS9wCRQ0TgDblTicZhbgpgPOf0
         OqmD+Ym7ihCu5ZekXuKKFoCEpuKNhCpV86U4+EpItS4upxiJj9y/mGoyuSk6aQl5HiBZ
         IKUS61x5JS+u8r4u2RSfuP4VKRvPq5Ub1mjObDSi6y8Jay3lD+R2NSOJEHypT4xz6UX6
         XvfDu7Dlbh/hcA1eLkkTY9pjoIOVJ09UUzqWMgd2uOrAgoJu4FZiXdQb7jBgyRNhU23Q
         bHZ9lyh5eKA/wB1k9QuDqvcRF6Iifu2DwybpUfkDggl1poAoTffzDxXeFjAc89Djfxlp
         ItAA==
X-Gm-Message-State: AOJu0Yx5XWsuQXHdLYwRu8+hVDfnAQ3Ka32IBRZkmdgu4g78Hu2PHOL8
	mzPViEALvLE83h+led5kVSV2a06yfkV5TGnni80QyD7+eomaR5nc1iwg
X-Gm-Gg: ATEYQzzJEQrXaNy+gHOKQQgSlGNM79K6YHtGqRfPP+kmv5KpJCCvDL2MSUao+9kf0c+
	X+HbyXlfrEELtMkeJwPN39XAWfwkjjfEgH6gy/+BJUHOLp/2nvRpGbI8Gkh6nY8bnDv/m6kRnXZ
	Am2OjLY6WY3QVyzy6eJvfDy+rOYHqYst1KOzF9areS06Zgu1Gr1MK7sWvLY4eaJmQKSV166nfo5
	bkN7ei6DkdwMCWpgNWrpFIIuBl/2CFsfhCwN3WgSsdWl+BKTM27dgIlhRF0k+1jQwvSrVMKeeYp
	6PiYcctwzIFP80lRa1g6uGkLG3cWsO/15CtRLXhKBJQC7NU39zIM7WlU2wnyj5pLkbtMqvMQ6dO
	YoiS4cbVb7gszrLQcOgQ06LciaXKHgGxuwXtMBHGpRfuMepV65DiGSB4lfJm9KsR8oEgRIinfEw
	LshfbSUORLFIZ8GMi+
X-Received: by 2002:a05:6870:328c:b0:409:5ef5:be0c with SMTP id 586e51a60fabf-4157ac67e02mr3900007fac.12.1771865342368;
        Mon, 23 Feb 2026 08:49:02 -0800 (PST)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4157cf9f666sm7695267fac.7.2026.02.23.08.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 08:49:01 -0800 (PST)
Date: Mon, 23 Feb 2026 10:48:59 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 8/8] builtin/maintenance: use "geometric" strategy by
 default
Message-ID: <aZyAOsRX5484naIU@denethor>
References: <20260220-b4-pks-maintenance-default-geometric-strategy-v1-0-faeb321ad13b@pks.im>
 <20260220-b4-pks-maintenance-default-geometric-strategy-v1-8-faeb321ad13b@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260220-b4-pks-maintenance-default-geometric-strategy-v1-8-faeb321ad13b@pks.im>

On 26/02/20 11:15AM, Patrick Steinhardt wrote:
> The git-gc(1) command has been introduced in the early days of Git in
> 30f610b7b0 (Create 'git gc' to perform common maintenance operations.,
> 2006-12-27) as the main repository maintenance utility. And while the
> tool has of course evolved since then to cover new parts, the basic
> strategy it uses has never really changed much.
> 
> It is safe to say that since 2006 the Git ecosystem has changed quite a
> bit. Repositories tend to be much larger nowadays than they have been
> almost 20 years ago, and large parts of the industry went crazy for
> monorepos (for various wildly different definitions of "monorepo"). So
> the maintenance strategy we used back then may not be the best fit
> nowadays anymore.
> 
> Arguably, most of the maintenance tasks that git-gc(1) does are still
> perfectly fine today: repacking references, expiring various data
> structures and things like tend to not cause huge problems. But the big
> exception is the way we repack objects.
> 
> git-gc(1) by default uses a split strategy: it performs incremental
> repacks by default, and then whenever we have too many packs we perform
> a large all-into-one repack. This all-into-one repack is what is causing
> problems nowadays, as it is an operation that is quite expensive. While
> it is wasteful in small- and medium-sized repositories, in large repos
> it may even be prohibitively expensive.
> 
> We have eventually introduced git-maintenance(1) that was slated as a
> replacement for git-gc(1). In contrast to git-gc(1), it was much more
> flexible as it is structured around configurable tasks and strategies.
> And while it knows about the "incremental" strategy that we may use for
> scheduled maintenance when configured via Scalar, its default still is
> to use git-gc(1) in the background.

I'm a tad bit confused here. git-gc(1) by default uses an
"incremental/all-into-one" strategy and it is my understanding that this
is what git-maintenance(1) is currently using. Is there also another
"incremental" strategy for git-maintenance(1)?

> The "incremental" strategy isn't really a full replacement for git-gc(1)
> though, as it doesn't know to expire unused data structures. In Git 2.52
> we have thus introduced a new "geometric" strategy that is a proper
> replacement for the old git-gc(1).
> 
> In contrast to the incremental/all-into-one split used by git-gc(1), the
> new "geometric" strategy maintains a geometric progression of packfiles,
> which significantly reduces the number of all-into-one repacks that we
> have to perform in large repositories. It is thus a much better fit for
> large repositories than git-gc(1).
> 
> Note that the "geometric" strategy isn't perfect though: while we
> perform way less all-into-one repacks compared to git-gc(1), we still
> have to perform them eventually. But for the largest repositories out
> there this may not be an option, as client machines might not be
> powerful enough to perform such a repack in the first place. These cases
> would thus still be covered by Scalar's "incremental" strategy.

So the "problem" is the "all-into-one" repack. This ultimately occurs
for both the "gc" and "geometric" strategies so changing the default
strategy shouldn't make anything worse. Geometric repacking should in
fact delay the costly "all-into-one" repacks which is good.

> Switch the default strategy away from "gc" to "geometric", but retain
> the "incremental" strategy configured by Scalar.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/gc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/builtin/gc.c b/builtin/gc.c
> index 4390eee6ec..fb329c2cff 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -1980,7 +1980,7 @@ static void initialize_task_config(struct maintenance_run_opts *opts,
>  		strategy = none_strategy;
>  		type = MAINTENANCE_TYPE_SCHEDULED;
>  	} else {
> -		strategy = gc_strategy;
> +		strategy = geometric_strategy;

Looks good.

-Justin
