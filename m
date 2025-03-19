Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D29E7E1
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 22:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742423281; cv=none; b=NsKMyv0ifw+DPeIk2k6BON/BUHj0g3C2raAl6cmFFyayZPALhV/fzyunxUdbFnHb9DLMykdnMKXcNl4ec0334AmfUjddb7G9niopiWkDDEtL3TvZWKUje2+6Don7btJIJa2e7v4xeavHf0AvtIegACuKeop/kGXkMV0tbWniSxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742423281; c=relaxed/simple;
	bh=0uz+/uPnPyn+HVfu0YEFJxl6CjrHBVjG+7hSVIFyoyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b0JeoRjYfBg+H2geTfQgB4oPeg01AYchshJdHc02fYPp8oEOwNravbsfgFwRnIIWDp3Nyg0X+nauqhUHX0A6xFN0ACTQp28l+I2vBcv+qiNUS7uAyvWOTyHFKO/DdqAI3GGDXn2uolupQoUc0HrpXcgBvr/w/G5b1kqFcV4T564=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=OUiK4e3d; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="OUiK4e3d"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-476805acddaso2297801cf.1
        for <git@vger.kernel.org>; Wed, 19 Mar 2025 15:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1742423278; x=1743028078; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hfhlSb6HDynTXMhi2DSol/ilE88b+Ze5KUz24ysaZ14=;
        b=OUiK4e3deBbK6bexDdM1PSSr1z8Lj/L8iOzABj4HZGns3tjNKWW/QcEzDUHczF9dsV
         WPWZQI46X8EG6s/wWjo0z1bC82oAo+eculTztE3kytj/QmXSwPbBtzbqFkeUrzMR51tD
         aWPsOKMigd5M2c2H5lhly9ABk5ov4iIQqeFhJXirnaTBqgIc5k+o0nt2o5oT1uhTOBgu
         Xn2gOFvtBNm8LxyU5XPbWNz/TVATynQvb0q9q3Jjz0RHvqjj3aZkVa45nguedL6SHK6r
         tflpl6wT1X3yG5dl2rcqAh4KsC6Y484T91agiOo4xTzd4csvvP9jFx6P0atvk6zz8TGp
         vapA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742423278; x=1743028078;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hfhlSb6HDynTXMhi2DSol/ilE88b+Ze5KUz24ysaZ14=;
        b=bpIhkSYtEQ012IkrvlVGDIS+diJl03emshkTUFLWYEbfsTRHJ00Mzanb8+f4Rkk4Te
         JPInG7x34nbKC0Ti4biogK4Iw6/CjanOAg2xZrkQw97Ydjkr1bj1eUr7FRnsy6OqbxES
         RCvY+9FHFySG5qxEH9cpYL292WOWaaKjCaCVx35Pi59Bsug5Bq/AAz5B2HrH123ZGN5e
         yrs8tYLHIxFIbW8Kwyqbr5Yzxq+0smu/KWLjNTm5ltSAYb3pjuVMNEbzhLGtnCIuHdr8
         40/9H9c7XiTqm/D4HChop0MLOp3v2/1Z5WetSqEIxlOMWiAAgp1g+Gkajbr0IejHozb1
         kqcA==
X-Gm-Message-State: AOJu0YxgvwcVFVotShnU/GPJbXVLu52v6TYwvsaMPu26RBKDIN9kNXkM
	TjHgSnJUCneUoR+lGdJvtby0qvUcK+GfYcKh+f9Hz99WbU8uvMBfX0GFz/S1v44=
X-Gm-Gg: ASbGncsQhZJJoRfD1v0UsqGPg7Rr93AyTVFhqEzynJwMs2tIjRGcBfJ3xHTHD7WadTX
	QNuZcUL3n4u+HttBLl13bF6t0wXWBf8VX+oGGd1fGaMQbtY/KN80xtYAuyxKNZEBp1xfvFcG+Ur
	S64P8cApu79adMwzecaTIdzlgu0pVdvwDWTF6DUTwSExkh4figjaFi95rUyI5+/QHlSG+x3dWGQ
	s8qeaq/3rAc4su2KBD+YrUahkZ/HlWQndvo8aUnhCYvFxfbKWi0qe4Iaalwhi3Z4QF6OdU906uO
	H4DA8lyKEtWOcFrvsfZltCKRcDAKyy2fEDQM6W4a8OqrfFRKHRiQqtDdYsYJsZOn6axFwQcM06+
	S1XN606dmFljyMGGEneFMCMVA8dI=
X-Google-Smtp-Source: AGHT+IGxGJxbaGl8AK87OSN/dkt06pu902Dxty7XcwyDOaFel4iOqNFuQi7yxdHwf7BPE0eiBvfDOw==
X-Received: by 2002:a05:622a:17c9:b0:476:8f9e:44af with SMTP id d75a77b69052e-47710d4cccfmr22599011cf.29.1742423278293;
        Wed, 19 Mar 2025 15:27:58 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-476bb82bc80sm84704061cf.76.2025.03.19.15.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 15:27:58 -0700 (PDT)
Date: Wed, 19 Mar 2025 18:27:56 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3 0/3] Add a static analysis job to prevent assertions
 with side effects
Message-ID: <Z9tE7Bo6uVkXUaEC@nand.local>
References: <pull.1881.v2.git.1742107322.gitgitgadget@gmail.com>
 <pull.1881.v3.git.1742401378.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1881.v3.git.1742401378.gitgitgadget@gmail.com>

On Wed, Mar 19, 2025 at 04:22:55PM +0000, Elijah Newren via GitGitGadget wrote:
> Changes since v1:
>
>  * Tweaked commit message for patch 2 Changes since v2:
>  * Rename BUT_IF_NOT() -> ASSERT(). Didn't have a strong opinion on the set
>    of alternatives Junio gave, so went with Taylor's small preference. If
>    anyone has a strong preference here, I can pick a different alternative.
>  * Fixed shell style issues (indentation, multi-line pipes, multiple lines
>    with stderr redirects) in patch 2
>
> Elijah Newren (3):
>   git-compat-util: introduce ASSERT() macro
>   ci: add build checking for side-effects in assert() calls
>   treewide: replace assert() with ASSERT() in special cases
>
>  Makefile                      |  4 ++++
>  ci/check-unsafe-assertions.sh | 18 ++++++++++++++++++
>  ci/run-static-analysis.sh     |  2 ++
>  diffcore-rename.c             |  2 +-
>  git-compat-util.h             |  8 ++++++++
>  merge-ort.c                   |  4 ++--
>  merge-recursive.c             |  2 +-
>  object-file.c                 |  2 +-
>  parallel-checkout.c           |  2 +-
>  scalar.c                      |  4 ++--
>  sequencer.c                   |  2 +-
>  11 files changed, 41 insertions(+), 9 deletions(-)
>  create mode 100755 ci/check-unsafe-assertions.sh

Thanks, this version LGTM.

Thanks,
Taylor
