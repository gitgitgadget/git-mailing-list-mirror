Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46346EB67
	for <git@vger.kernel.org>; Fri, 24 May 2024 21:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716586437; cv=none; b=JDJ+hPyaMRTH7CMpzy/K146Ogi2V478R/Pxy2KL3CWYuqA0WqYKQe5HQv9zE8HB5TBxt7tsM1mxXmCuQeJSCyB0HpPB7Y70PznY3nmzATQHbwm9wifPtMHODnsgzFMami6rMbzdYcI35ZuZkyf81dVQ/1lHrPq32qTpVwZ3WpeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716586437; c=relaxed/simple;
	bh=oxXLMMw28tZcVb3fsdCjQhLawiZ+oCSbXUWq9Kh2Ggw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZPebfGaoQ3NvWtIHL+3CsGjulu61yDsF02mXdCJK8Q65dd3nHuyR4kpAx/5zxelJtB9I81O1Uz6mxh9tNF3eXWjzSUoKJwuIZdYdNXvDflJ1HD+zfae/5dq5WuaLsnAyjlUL2wRqgWeFEyoRDyqd81EMHasb6YdFjXstWcskS4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nw7pjkZ+; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nw7pjkZ+"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-24c0dbd2866so2812755fac.0
        for <git@vger.kernel.org>; Fri, 24 May 2024 14:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716586435; x=1717191235; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/KjI+1w7vm6ICzsB+ZfA31tJFfEz8fYZ+TJBFddg3Xw=;
        b=Nw7pjkZ+kHWzNDWNoSTG0cNr5DIB+gj0RnlnHaR6rcn5GNnu5DzAc/A98JBonVGdeg
         uKVAlP0joADvODTpo/IMxs2z5MYbbcL5IFIRsXxi0kuSVTK0pCT2SC1PQ7vrnxu9p5vF
         4veu2H+iHOi5vJYgydatOPfkZn101FrVEiWMq8rwEftC04MjYxEblGnHqsE266GaCszr
         pYYbTkAZcaVfBg715Rg0qFs9YWbXYvTDEux6l/1YusNLvEgwWupkbf1OVXcby+FvN2Vt
         X3aO4riwoeCGhWd18f8EeCPy//SgOh0PJbtz/AJvFmWQyqu1swre1qQK8IRZ1RguKbNq
         2XHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716586435; x=1717191235;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/KjI+1w7vm6ICzsB+ZfA31tJFfEz8fYZ+TJBFddg3Xw=;
        b=wXqgStwMClNSovBjG6CkKDU3ljOh8rX1AMuKkFxFHzkH1WIZec6YkruCcjBxlXdNSK
         XglWqiAUuoeNmFh69s7eRWywpR5p9xxf9oDD7i/UObXAarKMVhtN7Nny6A3Lxs3XBt+L
         I/uONCg5PtV3F2KugkZ2raRkvhAPMu161W/RrRIpKQlhJ6yvvecmcx9l9/u4cTGZYDO9
         whncOVZzIPkS+toJEwYCvmNdm2PTWMneZVRYs0rtE0ruSKZIVa/TA9hXrNK2Fv1y4vGX
         LAmB/j0XxCO2g09RtHlblRW4gYmRTwHr73+m3dsgpDXKGcQbRi25+g+rv5+U5zuxn6Vx
         m4tw==
X-Gm-Message-State: AOJu0Yy5ZJ8t2hCrJ6NyWGNwU62KvksSGm+QjEtJx3cgFodLtiowVB+9
	slO/FtFPVIZb6oEJxi4Gxdp9qtNPL4Rx7fUBNBiTU4pu7gpD9/KE
X-Google-Smtp-Source: AGHT+IERPf22Wf37G5NHCjQz8JK/NGzGDwHX+is4+MPHZpyEtagBwdts+fPz5fnPSH6HqfSucDrNFQ==
X-Received: by 2002:a05:6870:2cc:b0:24c:54cf:f39 with SMTP id 586e51a60fabf-24ca1471c9bmr3386018fac.52.1716586434747;
        Fri, 24 May 2024 14:33:54 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-24ca27a41afsm548733fac.52.2024.05.24.14.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 14:33:54 -0700 (PDT)
Date: Fri, 24 May 2024 16:33:51 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>, 
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/9] setup: unset ref storage when reinitializing
 repository version
Message-ID: <yl4wqgtcfapjxuknb57sevnoi4jbcjnp3l6vqa7criqv2upq5p@x4hm33ymxukk>
References: <cover.1716451672.git.ps@pks.im>
 <cover.1716545235.git.ps@pks.im>
 <8b11127daf4c1d06eed4a0c83dd3dc981ffdc728.1716545235.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b11127daf4c1d06eed4a0c83dd3dc981ffdc728.1716545235.git.ps@pks.im>

On 24/05/24 12:14PM, Patrick Steinhardt wrote:
> When reinitializing a repository's version we may end up unsetting the
> hash algorithm when it matches the default hash algorithm. If we didn't
> do that then the previously configured value might remain intact.
> 
> While the same issue exists for the ref storage extension, we don't do
> this here. This has been fine for most of the part because it is not
> supported to re-initialize a repository with a different ref storage
> format anyway. We're about to introduce a new command to migrate ref
> storages though, so this is about to become an issue there.

Ah, so this would be important in the context of migrating a repository
from "reftable" to "files".

> Prepare for this and unset the ref storage format when reinitializing a
> repoistory with the "files" format.

s/repoistory/repository/

-Justin
