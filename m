Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709CA1FC7D5
	for <git@vger.kernel.org>; Wed,  5 Feb 2025 16:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738774235; cv=none; b=Yee6FAqBDesThphMSREdtPge+7DQnbnZsmPODFZ8FmsK4swuxOWFuE8wCfZKbrIVuu5Jfhqm6gBHc/8LLcrzT/Rku4hRkf8R8DrBnnACSx3gFsDJcWIGD1WgTnkKVJ5Minc4i+ufEiXDRIqZExyol5t46VaupzFDwMwi8CSI8Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738774235; c=relaxed/simple;
	bh=0WZXRl9u3dVi/0brAAPBh4JOB34Qkxoqjt1r8cbze5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mb2vR3Ngb/SzPUWB024B9+CYZ9earBlLUNStaJ7OuYCugYZsBfWHg/Fqhndlhaba0sZNBhmdll/GTHthigtVwYsnkhEc2AaeB1A7JGKp8eaPesjDEg26rlQAjIy9wEsfXTBC4m9fHKIIOA5lw7sCxk7I09194+DqSkC7td13Vrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UOEL1Qnk; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UOEL1Qnk"
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-21f1d4111d4so576695ad.0
        for <git@vger.kernel.org>; Wed, 05 Feb 2025 08:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738774232; x=1739379032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sBI63KubmDApz6Owy+FAYbDekd05oMeysl32ttxvTjY=;
        b=UOEL1Qnk9KPI54z1bSAvLF6v5Cg05KfDRt/3JPyfJa0sv/JTT60W2oEYIpB8a48dmv
         /n1yK0cbWBuw8Ay45mvQcTlVrzQ/dLcFXdMC4Dg+51VPq+DrrUXcswvPSnAQbScFzQ8s
         JbBA3nak5wFx1yVU5kAt9wctG7dXnuGO2zGD8cMGAtn+pqP5n+1W9r87lvL12cnP3TB8
         wDjRrDMq8xjPZ2VdaQF9qLggl1qpGi2NqRvJxYNzotVBCoyavyOB/8OooWaPUaaYX+Pt
         K+l8d2Mvu3189Lf/8BziMHoinMLKnh3olhgUjXzQ/mf5zfzMyO2wwmqsKWh3jEVxu+pN
         DTvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738774232; x=1739379032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sBI63KubmDApz6Owy+FAYbDekd05oMeysl32ttxvTjY=;
        b=OmbISSj8dOoJJ5ijhdGjFkQ2peie9OiRk9a32jJQwiquVMbAiGTO+h24lh4t8ajGIL
         gYqeImr3XHyluKD2UtGwbRd9sx0mLYlTqSt4DibhawUY344Ty6oe4WgK1PSmIMzsnbM8
         Kz62ATbNjLVJLprUsyAktGYhi0y6cNIUb3maZTJeFbIAERNsGqPCM3j0c8AbyFVAIz3q
         GjoAyxMDP27MhiDhv5emDIYHVwrQKyC/BcUZg12JUjPDY+uChd4y0TIr1Zzobt0IOVNO
         kwbmJJIgaFos1qRwz4rICKuzdoB6jJEUmWUSxXlqSfLDkTs0iC8KA+MZGB82ziW0U1Jq
         p9YA==
X-Gm-Message-State: AOJu0YyfH0skErvutb4DvbdQVYzwkWn1EBcGF5SO4MfHw3fpTd+dPnVm
	+UeHmT5K8sXpNaxZIHrRPEaqllKLZcJGcC/ef9R9UGSd1O2oA8fE
X-Gm-Gg: ASbGncuL6Jf0OZS7ToX3/Kg6aIXzEwuGysihymvdr4d3Og8+wEDEIM4w/3zUYJ1Y/Hj
	vfH+p8ejoRAaZ6UjfeF86CAgTgPQ0zov5ARUnHUiP9bt1ayxdwRQokLU1k7Rqtw4MGZPf4OPtrG
	SmdfThwecZ0H4bzQ8myKPKBPHOoibaTSqrQAlf95QNJEGSKAjgnCxPb34t+SKGUn6wYrfq1MH+x
	2pjGXTleaOMa7uEQ/9a+giuj1s/PlkDs+ESSe1x3yexYmQePm/hxIUV1neBJC0Wzc8yG9CIIT7u
	ferE1rIUGvBwL9p2u622xLMo+LdwHO0WjRHRdukzTzgM8em5WYelXXirch7jBNc38HU9Dq2Gh+b
	h429gaz54qXRexFODTDH4T3GS5KLFhaM=
X-Google-Smtp-Source: AGHT+IGyMeg97cDqimCKkL7ErRmAEdbmwLJ90jJuk20dTFoaly9c8+vsezJU17bHJqcb+ppkf95o6g==
X-Received: by 2002:a17:903:2346:b0:215:a179:14d2 with SMTP id d9443c01a7336-21f17ed2e02mr44549315ad.50.1738774232422;
        Wed, 05 Feb 2025 08:50:32 -0800 (PST)
Received: from Ubuntu-ROG-Strix-G512LV.. (ec2-18-162-44-43.ap-east-1.compute.amazonaws.com. [18.162.44.43])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de331f8easm115949055ad.218.2025.02.05.08.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 08:50:31 -0800 (PST)
From: Zejun Zhao <jelly.zhao.42@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	jelly.zhao.42@gmail.com,
	newren@gmail.com,
	ps@pks.im
Subject: Re: [GSOC][PATCH] apply: address -Wsign-comparison warnings
Date: Wed,  5 Feb 2025 16:49:47 +0000
Message-ID: <20250205164947.281934-1-jelly.zhao.42@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <xmqqh658r1im.fsf@gitster.g>
References: <xmqqh658r1im.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thank you for reviewing this patch.

On Wed, Feb 05 2025 04:58:57 -0800, Junio C Hamano wrote,
> > @@ -1087,11 +1086,11 @@ static int gitdiff_index(struct gitdiff_data *state,
> >  	 * and optional space with octal mode.
> >  	 */
> >  	const char *ptr, *eol;
> > -	int len;
> > -	const unsigned hexsz = the_hash_algo->hexsz;
> > +	size_t len;
> > +	const size_t hexsz = the_hash_algo->hexsz;
> 
> I thought that I already saw this discussed in another thread.
> 
> The .hexsz of any hash algorithm would never be larger than what a
> platform natural "unsigned" integer type can hold, so using size_t
> for the member _is_ the wrong thing to do and the fix may be the
> other way around, no?

Sorry I didn't saw the comment at [1]. You are right about this. I 
prefer changing types of the `git_hash_algo::*sz` family to `unsigned`.

[1] https://lore.kernel.org/git/xmqqttaqw2eb.fsf@gitster.g/


> >  	ptr = strchr(line, '.');
> > -	if (!ptr || ptr[1] != '.' || hexsz < ptr - line)
> > +	if (!ptr || ptr[1] != '.' || hexsz < (size_t) (ptr - line))
> 
> Is this about -Wsign-compare complaining about size_t vs ptrdiff_t?
> 
> > @@ -1207,7 +1206,7 @@ static char *git_header_name(int p_value,
> >  		cp = skip_tree_prefix(p_value, second, line + llen - second);
> >  		if (!cp)
> >  			goto free_and_fail1;
> > -		if (line + llen - cp != first.len ||
> > +		if ((size_t) (line + llen - cp) != first.len ||
> 
> Ditto.
> 
> > -			if (len < second - name &&
> > +			if (len < (size_t) (second - name) &&
> 
> Ditto.

Yes it's comparing unsigned (`size_t`) with signed (`ptrdiff_t`).

> I said this before, but I am not sure if being strict about
> "-Wsign-compare" is really buying us much.  If we are getting so
> many false positives that need to be squelched by churning the code
> with so many typecasts in order to find a new and real problem,
> is it really worth it?

Well, I contributed most before to a Rust OS kernel project so 
honestly I'm used to the idea of explicit type casting when necessary 
to avoid possible bugs. However, this is non-trivial. People should 
understand each relevant variable's semantics to decide what its type 
should be and do typecast on top of that. Even if it's already made a 
gradual process, it may still cost much from both the contributors and 
the reviewers but brings benefits that do not match up. Maybe a clear 
commit message that states why each type cast/change makes sense can 
help with the iteration? I'm not quite sure about that.
