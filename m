Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF94023AE62
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 21:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759874279; cv=none; b=lFsreOCKvysD8o5VC/85HCDP6lpKl9Ykn0MwdklDJWZf5eiZrf/c2sJhXyGPKWkVFFjQAATckoGeTPnwDt8Egcc8wKG/p1btJ833cvqDT+g+cexvm2ESTGBqdAnEeE2Kl15YoGt9ZM7jW7WG0HrpGmJfVRHGxUoBUZNFDty7rtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759874279; c=relaxed/simple;
	bh=2xr6QcZM5NwHiPEbLsm/2qNWeYGOhhoo76W+KuW9ee0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i1nIMBoMrlh9NJGPbQ/RKA5pymLbTxDiblO7kAIev39n4Uf/npPLiDxmJVbIOUcpZMLCBRwo9BtUoDl7NqrAAPyXv7g1+SPexhuRgKbEMkq1WBVlYOOUw0kNK4M5gF33mOHbmpDYVcSE/a7jpU/auFwDiMMLb6FKFG9uzYNU4uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=PMONUUEz; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="PMONUUEz"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-42f5e9e4314so50511785ab.0
        for <git@vger.kernel.org>; Tue, 07 Oct 2025 14:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759874277; x=1760479077; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vAEs4eiJpEcrG/vPMlh/Ip7Gxnd8H1ocQsWxtrCsaJw=;
        b=PMONUUEzYZk60eRhW5asnJLIlmvkehWiVQtVh8b0CGp8xDAourfGKBnW0kScaZ/BXL
         lWngBxds199wC4Pj947utiACKqPwF8ZEIlu4jm73+o+jZExB92xqPkYWk5cLPSb78BOa
         5wVI2b73mVgO4Vkudc43ruT8zLqzh+UaHfz5XuVLtknnGrh+iVD8kQGrF7UJY8reYIIQ
         WsUBNOXJIAkYk4NxPydccyuSX6TWJ74xoweOI0oZMmrl4N6lME/p1kqTNum6S/ED7FKk
         YjFD/cXflUV0a5j2o6ZgR96gZWJwYWc8ROC0WoM2sRYizR2g3OSCR3Mo5hEEVEFn74Aq
         itfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759874277; x=1760479077;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vAEs4eiJpEcrG/vPMlh/Ip7Gxnd8H1ocQsWxtrCsaJw=;
        b=T0d8e+PgYnNI4U1hUDxRjLSFHVGW/7uDwiyYvEOsYXtgOUMNO+Fzd6QD/QVYVxBhp/
         K5EmnxGl+mxxEDOnlPdCCei0viI1t7IDgK9BQ14zJ3ish5MTgVd3fkA1UOPETb9Y3/Ni
         BOKQT8H0+hxmze1Slraynd4e650PklqqvOdf8+mUqLenlN+8Sku1oVBi0pcBJyNrz0Rv
         H4kOTNyJEJIxzggw0H7bt7qHwdVMlYVUtlQqbbR/PP45QBy0zHUkDl4wKX2twMphKnRh
         Rwsa2qZAvGwKLljBtkITF0fZCLawCHX20+8d7Lc+zVwACj2yki//TbNx8T2D/KebLkuN
         mk2Q==
X-Gm-Message-State: AOJu0Yz9Ito7FZDnRlXK5pi9D7za9Xa8ksJGJNJafXE2wX7eEfViK/jA
	4ljjO1Xo4tPMlPKR23oCnf70zGrAMcsJk2dhyH3QwuHXTUK8skrifdOa0TQTGq6bahn150EV/IK
	B3X5Ct/sp1Q==
X-Gm-Gg: ASbGncvlEuvYCJO4idoElfC77On6TeaevTpFBgbs6GZFf5Zjge8ozegp4QwQRN7zOMZ
	dSDlRGMmHdlmKJ9h6Yr0a6I5l2Eu0nrWy3FpOjnrJk7sztkubE3it7Y+BYYVFvkjVNul4LPpU50
	kGPuWN9/R13c5F03EKiSMZT4oYVLayJJ3zFsEh4qn0TCWgHQGvCagEpvWHuKHJaAWoG/M5QE/iG
	5YX/3yQ27UOhPZ8/LWttP3F4toMJQU/OvjeQhbBkHwDlR7see34vh6p/KcbnlXkpSqfL3WLszTj
	6p/6TCxZIn9apCcr92JvLBxfwas1V1nzx9dh9oiGelDN5U691UdJa4IBMqbKOP1c8GtIEbSLaKi
	Qmiodytlj8CUw3ZSETzUYaHFVU9+/6p9QWDD0ZFrmEJrkjarNUJM4hEF3HVqOggOfdZiaiatPA2
	lenx743WsLwByTz91O1q+Ll0hYqm6QdNlXhXI5ij84QMiUOSkpaA==
X-Google-Smtp-Source: AGHT+IGnLaUO2JSwrmzOCgpuKxSov2XEBDgZuRFoE1u1cM4fvS9w+fqmZU/vXNooIJLtcvDUh0ce3g==
X-Received: by 2002:a05:6e02:180e:b0:42d:86f3:a2d1 with SMTP id e9e14a558f8ab-42f873fa208mr9490705ab.25.1759874276717;
        Tue, 07 Oct 2025 14:57:56 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 8926c6da1cb9f-57b5ebc83basm6503056173.49.2025.10.07.14.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 14:57:56 -0700 (PDT)
Date: Tue, 7 Oct 2025 17:57:55 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 02/13] refs: introduce `.ref` field for the base iterator
Message-ID: <aOWM48xFTql8OkNR@nand.local>
References: <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-0-916cc7c6886b@pks.im>
 <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-2-916cc7c6886b@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-2-916cc7c6886b@pks.im>

On Tue, Oct 07, 2025 at 12:58:39PM +0200, Patrick Steinhardt wrote:
> ---
>  refs.c                  |  8 ++++----
>  refs/debug.c            |  8 +++-----
>  refs/files-backend.c    | 47 +++++++++++++++++++++--------------------------
>  refs/iterator.c         | 39 ++++++++++++---------------------------
>  refs/packed-backend.c   | 46 +++++++++++++++++++++++-----------------------
>  refs/ref-cache.c        | 10 +++++-----
>  refs/refs-internal.h    |  5 +----
>  refs/reftable-backend.c | 12 ++++++------
>  8 files changed, 75 insertions(+), 100 deletions(-)

Besides the couple of typos that Justin and Karthik mentioned in their
respective replies to this message, this change makes sense and looks
good to me.

Thanks,
Taylor
