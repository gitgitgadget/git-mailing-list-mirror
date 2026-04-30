Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC323FFADC
	for <git@vger.kernel.org>; Thu, 30 Apr 2026 13:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777556156; cv=none; b=BTWvRoB8bK/d5++z4TcPP+o7bbvC9b2eCr/MPRFUs0LiljXuWkFTEOUnQhHuE6HG1tYKI4JtYDr458e11a6YEf8hnhJXhfpZB7IYByGwkYU2TC2Szh2B+6f4ZWZeUYzHsWWlN8oPqggUui8PpuIBpGZzJTsvKwHoH6ie7mUgEvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777556156; c=relaxed/simple;
	bh=qOEeJkWgo0R+an26zqAGtwrHvluxPZFRfl/cvSuz4lo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=eSdhQB+Bu5zwlt5H8hlytBAvJxqgpsuA3jLaoFn9QNDihoYTp9xJdKbZRE69Q8Xh+Ua33sk/ZMISCxeQuZU5jqOwaLhH/w5S5WNpLz49c/62+JEzrrj3q5Qsaj5FDQm3E82KsER9Tn6RcFV8XvxOz784xfNSsB8UeFFFsKL7Q2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VRYwGH8N; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VRYwGH8N"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43d6fbd0954so744534f8f.1
        for <git@vger.kernel.org>; Thu, 30 Apr 2026 06:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777556153; x=1778160953; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MMhjoLhyX+qmIo5Tx3RVJVdaaoyLnKX7iOh0Yb+5Pzs=;
        b=VRYwGH8NaFiVL/08+dSPYgMaTCpZiFZ0/f8d9mtqGTirclJGOeFideqcC3F7PmzBEq
         urGG4zzdGKGIJRgMxGWCyy767WDRlVCB7/N+HVcMxvSTm91wnhe+g/vi0dkHucEybiTn
         Egw9gz0aNQuvzXjX5oL31laIx7sk2VKkWMDtbCOvq5cdf7QhE/teGEn7YbVpJM1QPC13
         3ek/bc/rON5Z28Brv3/prjiqjE/wXSi0FU+ZfkB041orFwXTeHB/uKlEa6v0kcWtfW4n
         DdgaO7QsbbUd3BEMCSWPFg6exe5b2NyAdCCZWY+DvwOOYABSzj3m068BuO2Fkq8wscjs
         vPqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777556153; x=1778160953;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MMhjoLhyX+qmIo5Tx3RVJVdaaoyLnKX7iOh0Yb+5Pzs=;
        b=VGZ+1C6gianTTACaNT5rZLSIM9BTgabKBJP6NH96mw/vqDHu5MxzZSufjbE1M94ZSv
         BzA8ZWJfRoEqsAtcX7aw6IW2yu22pNeXYtatXB92ofnQtkratIjwp2kio8SsGUWB5yRW
         eus7HhPq7OxNrIIx4y8nf1o/Vna5EGjYu78Hf4TpYrzDX7tDhcD9k9hdijel34QFsxSA
         tg40AgXVTJohLr5fSooEN6K7++RMZEcsMDaVfJaaX06PnepP/3xRPHznfqgpwaLHGhT+
         iXTV3FF32XnX7qxjY0FsN4qKXFGkhLxOJYM1M2sR1TdMXGBLpgPkBPibRFeUT54mO1Wy
         8dOg==
X-Forwarded-Encrypted: i=1; AFNElJ+houRZeHrzFs0PYMTomiocLif80z4B7dMGLVVQ91l6i6ORfe0Er7YxeL+0QX7auTw4SkI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz1kv4MWJN+eJn1oW2tIZAKv290MkVP+S85qhE2K17IRp4Vw9g
	Za6dgovNon5fDg8g09/VHJOvIHx5NB7l84XGL/cui14r+tzxTkw6CqZP
X-Gm-Gg: AeBDieuPVjfkodpfz9vvC1pelU6b1TIDQwbBRG3dHf4MT1e84lOGwpDr3/Os3tP5NvX
	zovfH1rrZ+9AqC84MfH7rQHi/KKHNuuKZWs1uv5Rl4nDzd5soGycoHxXnut+kLDHLx5sSAyVm6k
	9Yz+S4UTkh9vJpQ5HRD7cwVvk6KRmlpCqI4Kf45A5Ty1nnrofoZhWJV1ivr8x5edTbBv1OLyWu4
	W2imr/B1Rg/DZ4PL4zFORG04EmIewKPAXaL/+VryEXearpvnVS1rPCy14qyvORMyWP9ivyGzTsl
	4xnofPuTQxp4T3ngd7ZO9hd02puIEz2WhoX4r/GTZpWCQA9ZNlCEpC0j2qF5ncM/LYATrfwM1+t
	3sZnGI//ciFhLPBo3bwms6WdaybbvfmrTfV/eIc+FjJ32d9V0h4qTk3C+mBvOuu0fRzQAQD9i9Z
	EJ5gz+2+4tN3Jq+jJd6iDlM0N/dfpDoSHJSRrZWuX+q2HNkj3bbdOgcdt+co+xWEFtMi2Lrvs79
	PN2ZPVjC6MLsg==
X-Received: by 2002:a05:6000:2f8a:b0:43f:e266:4c9c with SMTP id ffacd0b85a97d-4493cb42f8emr5082081f8f.3.1777556152352;
        Thu, 30 Apr 2026 06:35:52 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f? ([2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b4216ed6sm14347293f8f.16.2026.04.30.06.35.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2026 06:35:51 -0700 (PDT)
Message-ID: <c8b48c6a-5a20-4981-9cd4-999b40c618fc@gmail.com>
Date: Thu, 30 Apr 2026 14:35:49 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v6 0/6] Xdiff cleanup part 3
To: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Yee Cheng Chin <ychin.git@gmail.com>, =?UTF-8?Q?Ren=C3=A9_Scharfe?=
 <l.s.r@web.de>, Jeff King <peff@peff.net>,
 "D. Ben Knoble" <ben.knoble@gmail.com>, =?UTF-8?Q?SZEDER_G=C3=A1bor?=
 <szeder.dev@gmail.com>, Ezekiel Newren <ezekielnewren@gmail.com>
References: <pull.2156.v5.git.git.1775679988.gitgitgadget@gmail.com>
 <pull.2156.v6.git.git.1777500495.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <pull.2156.v6.git.git.1777500495.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ezekiel

On 29/04/2026 23:08, Ezekiel Newren via GitGitGadget wrote:
> Changes in v6:
> 
>   * implement suggestions by Phillip Wood [1,2]
> 
> Phillip's second "if" in [1] differs from his first one. In my changes I
> made both of them structurally the same.

I was in two minds about whether to do that or not, all the changes here 
look good to me.

Juino - are you happy to rebase pw/xdiff-shrink-memory-consumption, or 
do you want be to send a re-roll?

> Something I'm confused by is the range-diff of patch 5. I'm confused why
> range-diff states that this is different at all. I don't think this is a
> problem, I just don't like not being able to explain a difference pointed
> out by range-diff.

The context line below the insertion of "action1[i] = INVESTIGATE;" has 
changed do to the changes to patch 4. It would be nice if there was a 
way to tell range-diff to ignore hunks where only the context lines have 
changed but nobody has implemented that yet.

Thanks

Phillip

> 5: 88c68fa89a ! 5: 099b08c33f xdiff/xdl_cleanup_records: make setting action easier to follow
 > @@ xdiff/xprepare.c: static int xdl_cleanup_records(xdlclassifier_t 
cf, xdfile_t *
 >  +			action1[i] = > INVESTIGATE;
 >   	}>
> - 	for (i = xdf2->dstart; i <= xdf2->dend; i++) {
> + 	if (need_min) {
> +@@ xdiff/xprepare.c: static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
>              size_t mph2 = xdf2->recs[i].minimal_perfect_hash;
>              rcrec = cf->rcrecs[mph2];
>              nm = rcrec ? rcrec->len1 : 0;
> 
> 
> [1] limits
> https://lore.kernel.org/git/d88af7e1-e8dd-4423-9c6c-977e1f1dc074@gmail.com/
> [2] action execution
> https://lore.kernel.org/git/df244360-e9a9-44c0-946d-29288e6dd269@gmail.com/
> 
> Changes in v5:
> 
>   * drop commit "xdiff/xdl_cleanup_records: simplify INVESTIGATE handling for
>     clarity".
>   * add braces around the else clause
> 
> I didn't see a better way to rewrite how action is used so I reverted to
> what it used to be.
> 
> Changes in v4:
> 
>   * Change SIZE_MAX to PTRDIFF_MAX.
> 
> Changes in v3:
> 
>   * run make DEVELOPER=1 on each commit and fix all compiler issues
> 
> v2 is a radical departure from v1 Changes in v2:
> 
>   * make the flow of xdl_cleanup_records() easier to follow
> 
> There is no performance or behavioral change introduced in this patch
> series.
> 
> === original cover letter bellow ===
> 
> Patch series summary:
> 
>   * patch 1: Introduce the ivec type
>   * patch 2: Create the function xdl_do_classic_diff()
>   * patches 3-4: generic cleanup
>   * patches 5-8: convert from dstart/dend (in xdfile_t) to
>     delta_start/delta_end (in xdfenv_t)
>   * patches 9-10: move xdl_cleanup_records(), and related, from xprepare.c to
>     xdiffi.c
> 
> Things that will be addressed in future patch series:
> 
>   * Make xdl_cleanup_records() easier to read
>   * convert recs/nrec into an ivec
>   * convert changed to an ivec
>   * remove reference_index/nreff from xdfile_t and turn it into an ivec
>   * splitting minimal_perfect_hash out as its own ivec
>   * improve the performance of the classifier and parsing/hashing lines
> 
> === before this patch series typedef struct s_xdfile { xrecord_t *recs;
> size_t nrec; ptrdiff_t dstart, dend; bool *changed; size_t *reference_index;
> size_t nreff; } xdfile_t;
> 
> typedef struct s_xdfenv { xdfile_t xdf1, xdf2; } xdfenv_t;
> 
> === after this patch series typedef struct s_xdfile { xrecord_t *recs;
> size_t nrec; bool *changed; size_t *reference_index; size_t nreff; }
> xdfile_t;
> 
> typedef struct s_xdfenv { xdfile_t xdf1, xdf2; size_t delta_start,
> delta_end; size_t mph_size; } xdfenv_t;
> 
> Ezekiel Newren (6):
>    xdiff/xdl_cleanup_records: delete local recs pointer
>    xdiff: use unambiguous types in xdl_bogo_sqrt()
>    xdiff/xdl_cleanup_records: use unambiguous types
>    xdiff/xdl_cleanup_records: make limits more clear
>    xdiff/xdl_cleanup_records: make setting action easier to follow
>    xdiff/xdl_cleanup_records: make execution of action easier to follow
> 
>   xdiff/xdiffi.c   |  2 +-
>   xdiff/xprepare.c | 97 ++++++++++++++++++++++++++++++++++--------------
>   xdiff/xutils.c   |  4 +-
>   xdiff/xutils.h   |  2 +-
>   4 files changed, 73 insertions(+), 32 deletions(-)
> 
> 
> base-commit: ca1db8a0f7dc0dbea892e99f5b37c5fe5861be71
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2156%2Fezekielnewren%2Fxdiff-cleanup-3-v6
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2156/ezekielnewren/xdiff-cleanup-3-v6
> Pull-Request: https://github.com/git/git/pull/2156
> 
> Range-diff vs v5:
> 
>   1:  b31924a949 = 1:  b31924a949 xdiff/xdl_cleanup_records: delete local recs pointer
>   2:  1822166fef = 2:  1822166fef xdiff: use unambiguous types in xdl_bogo_sqrt()
>   3:  85aa0da90c = 3:  85aa0da90c xdiff/xdl_cleanup_records: use unambiguous types
>   4:  fec2b0f38a ! 4:  51c62ed454 xdiff/xdl_cleanup_records: make limits more clear
>       @@ Commit message
>              * The additional condition `!need_min` is redudant now, remove it.
>            Best viewed with --color-words.
>        
>       +    Helped-by: Phillip Wood
>            Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
>        
>         ## xdiff/xprepare.c ##
>       @@ xdiff/xprepare.c: static bool xdl_clean_mmatch(uint8_t const *action, ptrdiff_t
>         	uint8_t *action1 = NULL, *action2 = NULL;
>         	bool need_min = !!(cf->flags & XDF_NEED_MINIMAL);
>        @@ xdiff/xprepare.c: static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
>       - 		goto cleanup;
>       - 	}
>       -
>       -+	if (need_min) {
>       -+		/* i.e. infinity */
>       -+		mlim1 = PTRDIFF_MAX;
>       -+		mlim2 = PTRDIFF_MAX;
>       -+	} else {
>       -+		mlim1 = XDL_MIN(xdl_bogosqrt(xdf1->nrec), XDL_MAX_EQLIMIT);
>       -+		mlim2 = XDL_MIN(xdl_bogosqrt(xdf2->nrec), XDL_MAX_EQLIMIT);
>       -+	}
>       -+
>         	/*
>         	 * Initialize temporary arrays with DISCARD, KEEP, or INVESTIGATE.
>         	 */
>        -	if ((mlim = (long)xdl_bogosqrt((uint64_t)xdf1->nrec)) > XDL_MAX_EQLIMIT)
>        -		mlim = XDL_MAX_EQLIMIT;
>       ++	if (need_min) {
>       ++		/* i.e. infinity */
>       ++		mlim1 = PTRDIFF_MAX;
>       ++	} else {
>       ++		mlim1 = xdl_bogosqrt((uint64_t)xdf1->nrec);
>       ++		if (mlim1 > XDL_MAX_EQLIMIT)
>       ++			mlim1 = XDL_MAX_EQLIMIT;
>       ++	}
>         	for (i = xdf1->dstart; i <= xdf1->dend; i++) {
>         		size_t mph1 = xdf1->recs[i].minimal_perfect_hash;
>         		rcrec = cf->rcrecs[mph1];
>       @@ xdiff/xprepare.c: static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *
>         
>        -	if ((mlim = (long)xdl_bogosqrt((uint64_t)xdf2->nrec)) > XDL_MAX_EQLIMIT)
>        -		mlim = XDL_MAX_EQLIMIT;
>       ++	if (need_min) {
>       ++		/* i.e. infinity */
>       ++		mlim2 = PTRDIFF_MAX;
>       ++	} else {
>       ++		mlim2 = xdl_bogosqrt((uint64_t)xdf2->nrec);
>       ++		if (mlim2 > XDL_MAX_EQLIMIT)
>       ++			mlim2 = XDL_MAX_EQLIMIT;
>       ++	}
>         	for (i = xdf2->dstart; i <= xdf2->dend; i++) {
>         		size_t mph2 = xdf2->recs[i].minimal_perfect_hash;
>         		rcrec = cf->rcrecs[mph2];
>   5:  88c68fa89a ! 5:  45ad2ae62d xdiff/xdl_cleanup_records: make setting action easier to follow
>       @@ xdiff/xprepare.c: static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *
>        +			action1[i] = INVESTIGATE;
>         	}
>         
>       - 	for (i = xdf2->dstart; i <= xdf2->dend; i++) {
>       + 	if (need_min) {
>       +@@ xdiff/xprepare.c: static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
>         		size_t mph2 = xdf2->recs[i].minimal_perfect_hash;
>         		rcrec = cf->rcrecs[mph2];
>         		nm = rcrec ? rcrec->len1 : 0;
>   6:  699e198fa9 ! 6:  a5174802f4 xdiff/xdl_cleanup_records: put braces around the else clause
>       @@ Metadata
>        Author: Ezekiel Newren <ezekielnewren@gmail.com>
>        
>         ## Commit message ##
>       -    xdiff/xdl_cleanup_records: put braces around the else clause
>       +    xdiff/xdl_cleanup_records: make execution of action easier to follow
>        
>       +    Helped-by: Phillip Wood
>            Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
>        
>         ## xdiff/xprepare.c ##
>        @@ xdiff/xprepare.c: static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
>       - 		    (action1[i] == INVESTIGATE && !xdl_clean_mmatch(action1, i, xdf1->dstart, xdf1->dend))) {
>       + 	 */
>       + 	xdf1->nreff = 0;
>       + 	for (i = xdf1->dstart; i <= xdf1->dend; i++) {
>       +-		if (action1[i] == KEEP ||
>       +-		    (action1[i] == INVESTIGATE && !xdl_clean_mmatch(action1, i, xdf1->dstart, xdf1->dend))) {
>       ++		uint8_t action = action1[i];
>       ++
>       ++		if (action == INVESTIGATE) {
>       ++			if (!xdl_clean_mmatch(action1, i, xdf1->dstart, xdf1->dend))
>       ++				action = KEEP;
>       ++			else
>       ++				action = DISCARD;
>       ++		}
>       ++
>       ++		if (action == KEEP) {
>         			xdf1->reference_index[xdf1->nreff++] = i;
>       - 			/* changed[i] remains false, i.e. keep */
>       +-			/* changed[i] remains false, i.e. keep */
>        -		} else
>       -+		} else {
>       ++			/* changed[i] remains false */
>       ++		} else if (action == DISCARD) {
>         			xdf1->changed[i] = true;
>       - 			/* i.e. discard */
>       +-			/* i.e. discard */
>       ++		} else {
>       ++			BUG("Illegal state for action");
>        +		}
>         	}
>         
>         	xdf2->nreff = 0;
>       -@@ xdiff/xprepare.c: static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
>       - 		    (action2[i] == INVESTIGATE && !xdl_clean_mmatch(action2, i, xdf2->dstart, xdf2->dend))) {
>       + 	for (i = xdf2->dstart; i <= xdf2->dend; i++) {
>       +-		if (action2[i] == KEEP ||
>       +-		    (action2[i] == INVESTIGATE && !xdl_clean_mmatch(action2, i, xdf2->dstart, xdf2->dend))) {
>       ++		uint8_t action = action2[i];
>       ++
>       ++		if (action == INVESTIGATE) {
>       ++			if (!xdl_clean_mmatch(action2, i, xdf2->dstart, xdf2->dend))
>       ++				action = KEEP;
>       ++			else
>       ++				action = DISCARD;
>       ++		}
>       ++
>       ++		if (action == KEEP) {
>         			xdf2->reference_index[xdf2->nreff++] = i;
>       - 			/* changed[i] remains false, i.e. keep */
>       +-			/* changed[i] remains false, i.e. keep */
>        -		} else
>       -+		} else {
>       ++			/* changed[i] remains false */
>       ++		} else if (action == DISCARD) {
>         			xdf2->changed[i] = true;
>       - 			/* i.e. discard */
>       +-			/* i.e. discard */
>       ++		} else {
>       ++			BUG("Illegal state for action");
>        +		}
>         	}
>         
> 

