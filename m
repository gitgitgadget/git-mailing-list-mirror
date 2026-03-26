Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746413AF66B
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 06:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774506405; cv=none; b=jh9PxHLa2L+oiEgvNKDof6Citf1J2NI1CUA+62efwmxoD8FM0tEttB9cBCauWiHn0kJfD+pm4yeq8cI0S9zeWmmstw0euPwzZdmHSLN43TQAd8+EZBOuH1POPk0M2Urfs5+EDp9jQxqkSPKXDd5WZ4XwJCYbyoM8QZsCmIEkMWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774506405; c=relaxed/simple;
	bh=y2bubOC76GA8Ay0w8mUCubS+U11l2psODkqpxyB56ZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YJAxTXDqQ1LzyQ+E1P1Z9mJTB2Y1oG3o3sVLDzQLBkn5EYlVLd3aT25OptzvXy7xIuEO/WURCj+0L2hwCiEWEXnAlMtY1LmHbGqR8kQxSmZU7I/Gdczb2oyxBu27kowKXcCxcekjtjOmG+JIf8dFjMySX945A0oyeukBTttxq4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r3v+4BfX; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r3v+4BfX"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-486fc4725f0so4747995e9.1
        for <git@vger.kernel.org>; Wed, 25 Mar 2026 23:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774506402; x=1775111202; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=73ceobk00cSKVr2bY5NjvNmYuERMPOZgRTwjTBxc5LQ=;
        b=r3v+4BfXUat3CUwjRknbYmVK+NYbhUlWYNz1D+uQOufrza+SfU6kLFRRmgbKi0yxYo
         KOuZtKRKniDhWpdwqmrOZ52seNgrh1ZxefgML5t5vbH2j8c8Qv1804FFgtKL2wJqtZKr
         d2LGRiXy0Q2blM3mtcTepuaVKcA8f62fUaxq6ZkyZzaZCEutybhgDs8OvSy02OCnMEFH
         39TCea5xWgiVXWXaWXZhqdO1S/DfEz4wpQygiY07733w8GwabF19RSYe6oOTD/6COtcw
         lU0K4c0XjNXVOmRB8a+GclgEM9nn5nF5R3/SDWt4dWMYSVuju6bGMbb9UoT1Qvb41WTL
         Nn9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774506402; x=1775111202;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=73ceobk00cSKVr2bY5NjvNmYuERMPOZgRTwjTBxc5LQ=;
        b=P1MTyNQekPnWMackN3/SOYM9zwtGNvMAyKntemWNCdStZT2BTLlHU4Ijy60AQEBQ5c
         nLzEibka39FtZFg78dpkSwAJlkRQrHvLjEICpTwsDmqcyE7ZHr70lwd6IbRr5jxTBOxw
         +F22KJp/LHqGzvoDqxwT7KwPa2awoirGkIlJOeSUW3ev/2Ic2WXbs9aPefxTBMyqK842
         ITZZbxSGT8xyqAQGpTa2W3YVRB+h7sAT8JGcF0JYgRlxCcLgdhC02/SbnDXQzgvIcIgj
         GjGIXG4junBkhL+SVrMvTUxM4vZtTnrTG9dn3yGo4SK8gkNJ8NvYc7kt23jDzYhqD+OV
         G+fA==
X-Gm-Message-State: AOJu0YzDuNgDx1SJ/Jqe+4Mx0i56JoThRgITco0FHZ/ASWcD5aUyjScb
	7CgK4dgFZzIy0R2B+kVuhEP6VCX/6g+2pllyk4uqUlo+TRzZIxoR0U1E
X-Gm-Gg: ATEYQzw762ea+vDtpBG55YAxdRnEZtGK5PAA0fJ5hcIs2UWwzEL1VRf16i/xjv8GjGO
	U5gM140YrjpDRDk+m+uCRE/LRS99C7yvFjdVHfvAR4+wNmsSh9fQZcm/tdDSs8/bN9xVgOFzUGv
	NwopLLlAm7pfaw4N5m5TwnMxvZPhX70JbqzrU+/mXZHKa4MhP4lUoAESxgsdxd0l4oPyhUW7mdp
	lEuA1V4M5HlpngcONOwDGEbVP0nxWHUzml9QoaqTn0tGvY3JJL0eV1EUXpKViwxA3zW5rYP32Cj
	zdO0fSFim2VIXq/VLMfIcoxPxYLDDvqTqC7ZlSkjwle7RJrsbvFlWkctvmixeIFZ91jKT2oi9Ua
	8kNkoYCulbmukVAZRukluzqmHBmhdzQk/SSEhEInIYpiCPbnhftaTremxvKTMy+K4zaLh9X+sf0
	QhKNKQqUOH154YF79wlGxbRP1n0lfi4/uSVv2z8LfkQYKIDV3IG5jqsor1Y5iVnm/AkFdl0KKh4
	hnMBa2X42CZ
X-Received: by 2002:a05:600c:3ba1:b0:46e:59bd:f7e2 with SMTP id 5b1f17b1804b1-48722bdfeebmr5516445e9.11.1774506401554;
        Wed, 25 Mar 2026 23:26:41 -0700 (PDT)
Received: from localhost (20014C4D24C038005579661748639A82.dsl.pool.telekom.hu. [2001:4c4d:24c0:3800:5579:6617:4863:9a82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722d236a9sm20455905e9.11.2026.03.25.23.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 23:26:41 -0700 (PDT)
Date: Thu, 26 Mar 2026 07:26:11 +0100
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Yee Cheng Chin <ychin.git@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Jeff King <peff@peff.net>, "D. Ben Knoble" <ben.knoble@gmail.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH v2 0/5] Xdiff cleanup part 3
Message-ID: <acTRg4+8/c/BfE7d@szeder.dev>
References: <pull.2156.git.git.1767379944.gitgitgadget@gmail.com>
 <pull.2156.v2.git.git.1774473065.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <pull.2156.v2.git.git.1774473065.gitgitgadget@gmail.com>

On Wed, Mar 25, 2026 at 09:11:00PM +0000, Ezekiel Newren via GitGitGadget wrote:
> v2 is a radical departure from v1 Changes in v2:
> 
>  * make the flow of xdl_cleanup_records() easier to follow
> 
> There is no performance or behavioral change introduced in this patch
> series.
> 
> === original cover letter bellow ===
> 
> Patch series summary:
> 
>  * patch 1: Introduce the ivec type
>  * patch 2: Create the function xdl_do_classic_diff()
>  * patches 3-4: generic cleanup
>  * patches 5-8: convert from dstart/dend (in xdfile_t) to
>    delta_start/delta_end (in xdfenv_t)
>  * patches 9-10: move xdl_cleanup_records(), and related, from xprepare.c to
>    xdiffi.c
> 
> Things that will be addressed in future patch series:
> 
>  * Make xdl_cleanup_records() easier to read
>  * convert recs/nrec into an ivec
>  * convert changed to an ivec
>  * remove reference_index/nreff from xdfile_t and turn it into an ivec
>  * splitting minimal_perfect_hash out as its own ivec
>  * improve the performance of the classifier and parsing/hashing lines
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

Please make sure that each commit in this series can be built with
DEVELOPER=1, which enables a bunch of additional compiler warnings.
While the last commit can be built with all those warnings, the three
in the middle fail with sign comparison errors.

> Ezekiel Newren (5):
>   xdiff/xdl_cleanup_records: delete local recs pointer
>   xdiff/xdl_cleanup_records: make limits more clear

        CC xdiff/xprepare.o
    xdiff/xprepare.c: In function ‘xdl_cleanup_records’:
    xdiff/xprepare.c:307:54: error: comparison of integer expressions of different signedness: ‘long int’ and ‘size_t’ {aka ‘long unsigned int’} [-Werror=sign-compare]
      307 |                 action1[i] = (nm == 0) ? DISCARD: nm >= mlim1 ? INVESTIGATE: KEEP;
          |                                                      ^~
    xdiff/xprepare.c:314:54: error: comparison of integer expressions of different signedness: ‘long int’ and ‘size_t’ {aka ‘long unsigned int’} [-Werror=sign-compare]
      314 |                 action2[i] = (nm == 0) ? DISCARD: nm >= mlim2 ? INVESTIGATE: KEEP;
          |                                                      ^~
    cc1: all warnings being treated as errors
    make: *** [Makefile:2923: xdiff/xprepare.o] Error 1

>   xdiff/xdl_cleanup_records: make setting action easier to follow

      CC xdiff/xprepare.o
  xdiff/xprepare.c: In function ‘xdl_cleanup_records’:
  xdiff/xprepare.c:309:29: error: comparison of integer expressions of different signedness: ‘long int’ and ‘size_t’ {aka ‘long unsigned int’} [-Werror=sign-compare]
    309 |                 else if (nm < mlim1)
        |                             ^
  xdiff/xprepare.c:321:29: error: comparison of integer expressions of different signedness: ‘long int’ and ‘size_t’ {aka ‘long unsigned int’} [-Werror=sign-compare]
    321 |                 else if (nm < mlim2)
        |                             ^
  cc1: all warnings being treated as errors
  make: *** [Makefile:2923: xdiff/xprepare.o] Error 1

>   xdiff/xdl_cleanup_records: simplify INVESTIGATE handling for clarity

Same error as the last one.

>   xdiff/xdl_cleanup_records: use unambiguous types

Good.

> 
>  xdiff/xprepare.c | 89 ++++++++++++++++++++++++++++++++----------------
>  1 file changed, 59 insertions(+), 30 deletions(-)
