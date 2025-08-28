Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA342882AF
	for <git@vger.kernel.org>; Thu, 28 Aug 2025 20:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756412826; cv=none; b=RjZvd6ZSn0qYUEP2J5MXHX3updGOhH4N3EAJ2nsdAyIbgM8iGN428jIDg54CwoR4ylCqeE9fEjSs629aHNVDv1jXqPVQhEeJvKDGK31DSqILByD2AJqGXJCfQox55L5SN/0yij5UHPkSyPr8HJLcdbQCp0+wh4ynFjxme2C0384=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756412826; c=relaxed/simple;
	bh=B/Ppjmjrt2hW7AnlsfKX1oYi0KxIURTdRvHfP8VH9Cw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JM8sOLG994Fbux6TAB+bzEHNwhnFj9EB4bmQ6GAZ1vlSftK8Hhk2Iu1BtVa6xr5wtRYqSq7eAbw3mBJfp0NKLJTAraWAhuyOolxveTXb5WFe3woG//T+TzhYUYSgyhxCRLlRyHFWO+I+i5t8zf1P+BaB+yGFDn5uo/xIFyFmcRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YGGIDOJ8; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGGIDOJ8"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45b7c01a8c1so8424075e9.2
        for <git@vger.kernel.org>; Thu, 28 Aug 2025 13:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756412823; x=1757017623; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QfazVU9uhHdjWyfzsx0cU+pWsjycVh5HDiHo6YtbbG4=;
        b=YGGIDOJ8FJb+yoLGwQTZmy3GhEm4csUGMcjrVSUTFIVJo6LgM/YIhF40QjrT6apDQd
         mzWwtVjh1pgqxFr9+YbLfGIt+7VSmWvBNOeLtDCA2PazdKgPaziGc5g9PLfg4R8IBYf5
         uuvpoLK9vwaVrsnXhjb/vKOV109vHYb6cLSx7YpXAJ7njik0qEIs/T5ZfiLvIAk7yebh
         MFxmrrciAOi8LYxPccxIuxdYMoGE0lzutRKw4mO1MuWhKifec4DJZ8v+ol1qZpH+VIY1
         3oTCw5mQ2FFO15lM3lBM8NfD0EHfXnW4kZU0AH9U5yyJi5n1QxOegvLylwR45danKJKr
         ht5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756412823; x=1757017623;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QfazVU9uhHdjWyfzsx0cU+pWsjycVh5HDiHo6YtbbG4=;
        b=myp/YXv9LdG/V2rqPgiucwNLayemolMnvMHy+luYE2X2KymwwWur5KhiswE81ULodX
         qsLtdQ0uv0GsOVYikN/cnbY0k4esRFgY/liWRgWFEJS3cjsB+Qd5iC2f5ux8LyaNHSmd
         bAFZ5/JqKUTL9qCVK6ox6UqhjHO4uCYjtnZhXoxhS+lFUTxf1huH7GiclbPzQ8nbwt4a
         kE9ZAS/uaxlpeGxrpubPCZShdKk/bRvbwRIpAdeGzEbRaq1azBVIk7Yc6DoCVi+ELni7
         eMhJPnZPH4QI+YNQF20YJKzwVSh+jZMKwIrQEDEXvErCFDfFwkZfTviamDteVKB9czdi
         RG4A==
X-Forwarded-Encrypted: i=1; AJvYcCX4qqTBEJy6cPC57NQF3EC95OBHV6Tp6NL9lbB3Qcm/+5DEnNqoY/dqaECqNX27xNMsj7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK2FzzT2cp4LPWIi8fu/aKjPGwnxNUJczx/8y5fGAL8NoJPXDm
	dXJtk/R1y6BezzfaTNbqPe08GMY032as2buUCFd9qMtcCsSO7Pc9D0uswIVxJw==
X-Gm-Gg: ASbGncvfJEAtb+Yuoq7rLQGGK1V46VEtDFRJIiOF1wsW/Sc8nuZPwh6lgtuSFD21O4W
	PF96krwGbhqb0LEfgBtFlQUTBwKX4pQrov6uvmALujfA/xcNFCDJPhnsDMPcoeoLDObYbxdHrpo
	LcWQsruBC45LlyvLEklL6a1wkE96xMs0iiiFHT9PVp3ENZ4U02HAqjCCOkwFUe8NHebzLGWHmAq
	yYtUqyPsHIsic/UEE8MU211sV+Id6ofVLDmaHmrXMlfcFusesu9UXGxNVHQ9rOw4kFoaxMJMDwR
	EDHjV3q55Yy5r8oE3bttCX7ytVz3BdJIqY5S2cptt5YUxfdFEwADqyL9nyFdf1h1MXQXi0NtuKn
	7kmgRE16NZefcmCknVZdMlyaSuOREWyILZ3i9cwi6iQwgB+a+TvLpXKwsHkzlPxM=
X-Google-Smtp-Source: AGHT+IHnODqbKdi+PgQ7dNVl2LWIo0FEnnpYMh84+yXDCs6teEXbIE+7SNS/5CwnWJRaLELncO7mKg==
X-Received: by 2002:a05:600c:4747:b0:45b:627a:60cf with SMTP id 5b1f17b1804b1-45b627a62cbmr149555195e9.24.1756412822714;
        Thu, 28 Aug 2025 13:27:02 -0700 (PDT)
Received: from localhost (78-131-14-115.pool.digikabel.hu. [78.131.14.115])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b661200e8sm67196985e9.0.2025.08.28.13.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 13:27:02 -0700 (PDT)
Date: Thu, 28 Aug 2025 22:27:01 +0200
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/4] line-log: avoid unnecessary tree diffs when
 processing merge commits
Message-ID: <aLC7lQQWfdB/QUk3@szeder.dev>
References: <20250824190644.2573279-1-szeder.dev@gmail.com>
 <20250824190644.2573279-2-szeder.dev@gmail.com>
 <xmqqms7ntnvq.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqms7ntnvq.fsf@gitster.g>

On Mon, Aug 25, 2025 at 08:35:53AM -0700, Junio C Hamano wrote:
> SZEDER Gábor <szeder.dev@gmail.com> writes:
> 
> > @@ -1209,7 +1202,6 @@ static int process_ranges_ordinary_commit(struct rev_info *rev, struct commit *c
> >  static int process_ranges_merge_commit(struct rev_info *rev, struct commit *commit,
> >  				       struct line_log_data *range)
> >  {
> > -	struct diff_queue_struct *diffqueues;
> >  	struct line_log_data **cand;
> >  	struct commit **parents;
> >  	struct commit_list *p;
> > @@ -1220,20 +1212,19 @@ static int process_ranges_merge_commit(struct rev_info *rev, struct commit *comm
> >  	if (nparents > 1 && rev->first_parent_only)
> >  		nparents = 1;
> >  
> > -	ALLOC_ARRAY(diffqueues, nparents);
> >  	CALLOC_ARRAY(cand, nparents);
> >  	ALLOC_ARRAY(parents, nparents);
> >  
> >  	p = commit->parents;
> >  	for (i = 0; i < nparents; i++) {
> > +		struct diff_queue_struct diffqueue = DIFF_QUEUE_INIT;
> > +		int changed;
> >  		parents[i] = p->item;
> >  		p = p->next;
> > -		queue_diffs(range, &rev->diffopt, &diffqueues[i], commit, parents[i]);
> > -	}
> > +		queue_diffs(range, &rev->diffopt, &diffqueue, commit, parents[i]);
> >  
> > -	for (i = 0; i < nparents; i++) {
> > -		int changed;
> > -		changed = process_all_files(&cand[i], rev, &diffqueues[i], range);
> > +		changed = process_all_files(&cand[i], rev, &diffqueue, range);
> > +		diff_queue_clear(&diffqueue);
> >  		if (!changed) {
> >  			/*
> >  			 * This parent can take all the blame, so we
> 
> This is surprisingly small change that eliminates quite a lot of
> waste.  Nicely done.

It's funny you say that...

This patch series just turned 6 years old this weekend, and up until
Sunday morning this first patch was actually two, because the
optimization and the removal of the now unnecessary diffqueues array
were two separate patches that I finally decided to squash together.

Here is the diff of that optimization-only patch :)

  ---- >8 ----

 line-log.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/line-log.c b/line-log.c
index 07f2154e84..b3766c67ea 100644
--- a/line-log.c
+++ b/line-log.c
@@ -1220,19 +1220,17 @@ static int process_ranges_merge_commit(struct rev_info *rev, struct commit *comm
 	if (nparents > 1 && rev->first_parent_only)
 		nparents = 1;
 
-	ALLOC_ARRAY(diffqueues, nparents);
+	CALLOC_ARRAY(diffqueues, nparents);
 	CALLOC_ARRAY(cand, nparents);
 	ALLOC_ARRAY(parents, nparents);
 
 	p = commit->parents;
 	for (i = 0; i < nparents; i++) {
+		int changed;
 		parents[i] = p->item;
 		p = p->next;
 		queue_diffs(range, &rev->diffopt, &diffqueues[i], commit, parents[i]);
-	}
 
-	for (i = 0; i < nparents; i++) {
-		int changed;
 		changed = process_all_files(&cand[i], rev, &diffqueues[i], range);
 		if (!changed) {
 			/*
