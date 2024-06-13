Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72FE1369AF
	for <git@vger.kernel.org>; Thu, 13 Jun 2024 23:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718319862; cv=none; b=a/NCDJw5PEsBf6RExlHI5MpvmK+Mn/bEOTu4gnjyIfIrWmC+ZGKlCpnC27LrgJNAjfUIzhymqWNHz06mzYKja/C/GG7xSYTbjZHbq4YKmY2uy+BPn3+X5C+QJBwNDKUrBDzYj6tck3Vok5ZhjxfTKfAEx+ByBqXxMh/Tu2bohmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718319862; c=relaxed/simple;
	bh=ALColgANZr6Nb4eEbikmzhj6ypWHWfH3dd8b8BUsZ3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gj8PyJHboCj0H+YmIZxRg6iIQHVEFlLrVyCwLkXamEpLIrLPGCDqREXvAHrB8dXKxDSZCGrOdg+ardU6QF2D9nbSzjKmLHQhB/IRYvgcRrTs73+lyA9/LkzzJlNoVkDjvh5hvGlJLXk7KNmo+g7R8mC6G8gHc5wvgVudmxF8sKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=TYlGJVD1; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="TYlGJVD1"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-43ff9d1e0bbso9031941cf.3
        for <git@vger.kernel.org>; Thu, 13 Jun 2024 16:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1718319859; x=1718924659; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/Vj4MMD8iQUjkb8t9xe3xZO4pL92lnBisrXRCIQJPqM=;
        b=TYlGJVD1M8QvWtrShmUb+owzHks1erPXtQywbF/lbeiytVmOcegDex686HjG4pOyX8
         O1Kf3bdNVkv5Mw8MoYdWSYU3tDp45AeZkl6iUHD0Cd75R4TXaFgcutUYJvdGIJajnmMb
         EGAP7lGiD+Z+d+k1oB+ZnmM/gAK7EhDl/7eddEEqTO4zkYnzvJFUvtCoHpiUv++O4e7Q
         jM7xNgxhiuGLpsCLr3U9VOYaqSV+Fa+4Rj/YhC1wQHppocpBqsKE9kC5fQvN9XgHKgiI
         cjDGQuNTdP7Pd1ebtTJb+4WNSnIa+iTY7qo6RBUZVTx0mCA2qipCjenbEng71BqS87IE
         r1tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718319859; x=1718924659;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Vj4MMD8iQUjkb8t9xe3xZO4pL92lnBisrXRCIQJPqM=;
        b=J7GqeUui+miy9c+rII5a9XXBPePImefgBAEowF96G2hPZqLembCrC0LfT6q52m2lh7
         mQFMvwzrHHESdZpD+PZEY6/IzplQ4QBy5CHVCcsQfu+KKNnRWCxqDzfkcqM82wwLk2Vx
         zwygtHNNRFaB8khcVKqua/CJ7Ohn2zfl0CYDQBdnwcoU/yoq+4vsOfQEWt6lmK8A6SmA
         QB9hsG5ApTqPwMc7BEuUW9iXR2Iy4q5MA+e1CS0Ewn/P4+zq4C8uLtRtufjJipbDbLT2
         nFWsvS5gOvULVeL70veER5YlyuvDio+r6OiVyy14tt0I8k9Ucttv8b1s43kSHxqDw/WX
         exng==
X-Gm-Message-State: AOJu0YzBVEgZI+rLH55h/8xxniBVDDf9UVVB1WjBnSMAy3CLOY6LXC97
	Q2vJkaQGLDHOl/NhshH9bqL0vW2b2TCglQqdAEiGtwRBbkw/EZnNwOh23RaHAmo=
X-Google-Smtp-Source: AGHT+IF/YmAJv8XXc0RQAS4789VClzNhNt//xVkxUaJ+fMiNC1//CSroFIPFIJ20U2xuIj27w0mSUA==
X-Received: by 2002:a05:622a:148d:b0:440:5fff:50d7 with SMTP id d75a77b69052e-44216b394f6mr10232291cf.62.1718319859459;
        Thu, 13 Jun 2024 16:04:19 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44212efe609sm6587011cf.52.2024.06.13.16.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 16:04:19 -0700 (PDT)
Date: Thu, 13 Jun 2024 19:04:17 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 0/7] Fix and improve some error codepaths in merge-ort
Message-ID: <Zmt68bR3v6+kxrfN@nand.local>
References: <pull.1748.git.1718310307.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1748.git.1718310307.gitgitgadget@gmail.com>

On Thu, Jun 13, 2024 at 08:25:00PM +0000, Elijah Newren via GitGitGadget wrote:
> Elijah Newren (7):
>   merge-ort: extract handling of priv member into reusable function
>   merge-ort: maintain expected invariant for priv member
>   merge-ort: fix type of local 'clean' var in handle_content_merge()
>   merge-ort: clearer propagation of failure-to-function from
>     merge_submodule
>   merge-ort: loosen commented requirements
>   merge-ort: upon merge abort, only show messages causing the abort
>   merge-ort: convert more error() cases to path_msg()
>
>  merge-ort.c           | 167 +++++++++++++++++++++++++++++++-----------
>  t/t6406-merge-attr.sh |  42 ++++++++++-
>  2 files changed, 164 insertions(+), 45 deletions(-)

Very nice. I had a couple of minor thoughts on the earlier patches, but
I agree with the substantive ones that printing only messages related to
paths that we were processing when something went horribly wrong is a
good idea.

I don't think that either of my comments alone merit a reroll, and I'd
be happy to see this version move along as-is. But I'm equally happy if
you want to fix a typo here or there or do some bikeshedding ;-).

Thanks for fixing this issue.

Thanks,
Taylor
