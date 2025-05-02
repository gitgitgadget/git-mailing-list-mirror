Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A43F262FCF
	for <git@vger.kernel.org>; Fri,  2 May 2025 23:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746228678; cv=none; b=owBLqKRKPnaFoCFocdrfF0jbRZFClBCdOGLTTDXAPNFtlrHp5mCaD5R6drsQD21eIeIB+1289XjpjG/nkD6CjR2qxoTufQyVbIFrqIsW/rH0KjzbfLMf1OzEx8/oGKllbpDAtn6pRuK5plS5ubkHqthF5hX20ude2V+dMWnX6ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746228678; c=relaxed/simple;
	bh=rllFThZF6s+TJyMbY3ct/IDYgqgornKyJh9a9VB2mEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=unnw9Jvvwwg5hLoUpDbVu4aiiualMBxUj55mxi6ddo0FfFXvofQZqlaX0NrWA2a0dUUeOYVGdEen70Ak+nxviebNQU4gQyCgr+mhQRYlgjmVuiNic9mQgOY9ocnc0GWLivN76cr0pQEGdf/B8fL0FTBkscivJPzKX9MX4rQupD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=dEmSU3ro; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="dEmSU3ro"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c5568355ffso229094385a.0
        for <git@vger.kernel.org>; Fri, 02 May 2025 16:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1746228674; x=1746833474; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kOUj0WVtTCtkFpVldueQ/s7gO+j5EL1+WE3BhGVNR24=;
        b=dEmSU3roD+MDF++Jo4vxTQ39Ti83RcpCHm39aa/wv6BmPqjzycsh44bDrPdcoubS6W
         LSBa9kuGzoUAhH3lyEE/VYdwqIKQw4fPlaM9AysvRCiygBho5r/nod4C0v+w+KTQjGVl
         AwbIeXLjWEBzqLIB8SgA/krqRKbG58QmQjsOzhfuX9yZdyCZZd8wSp07EKPpruGfuCX4
         qwa+ycVxicrETRSGtoAcO/fOu330a4pYHNueRuX9WEqn6B1XK7+Rf9+bzK/qLZWWvAge
         zQ68NdKOGAUY0nRs4OqdFltWQBVZNPwq6wk+9SwkGKfksZCSp4Fw2sDi4pXwV+KD5fWy
         UXkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746228674; x=1746833474;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kOUj0WVtTCtkFpVldueQ/s7gO+j5EL1+WE3BhGVNR24=;
        b=eHMOxF/uTsMUHc1YyTVUJVizi5j7VRm9tEEW8JvoELY+my7h9mQqUfhCs1TGhRio1T
         zLFEki//BRS4r4bthfyPA1apPOj58hxcZxnv+FDNGXyoBAFde+OgyVFSJM0bPuZ6/rMS
         xDT7Qw+mvaZ5KDWr6oknsKfbchV+WjQWHBvSDjKcwvUiD6qeO8IhjXZGNxtyNoDzrYuP
         Y0JCKV+eokWyMRCsub3Dhpy5B63JZQZXCGb/O0DckeDktSneCHe6OFLLBKp+M7C/OMAe
         AXgKJNghYfsqujRBCXe1shZFdr6q3YWTqhfgI/FSVGoeuJ13dmZY/sbrpbY3RHUyq2bj
         GVWg==
X-Gm-Message-State: AOJu0YyZHOboDmrcRjx28cX76oQSw3ww7EIfm6UmYlJ/FrCbGTulRjLY
	MCZTmE5yfLDA5ATEaeuicr8a9JzR1qDsPwWCr5N3AV6Dhxp1GvIWi9WeruYLPFQ=
X-Gm-Gg: ASbGncsXulkNjlS5R5OWjMHIU5sN3tDlSPGrQrSyy6ux2ClZuMm9aacjsZLyt3RjO3X
	XC/jpUjyc/TQER2hex2zm64qc6fCnap7bCQATH6OU2f6iz+sO9eDJj/L8XsKFKr5GksBf5R1Si3
	U+S+Yx0278z0blqcVZ1fNU3NPsl76eOBBw1jZq3yW9i1/VVuNKnpUnYrfcYec0xVDTfbWOzeJAn
	wPDJzwHfs3WL08kmjB6cAuvFIOzCUz3p+W1CkTnw4kGRWjnNPQ6vrQJ1ueDBijrSAE+MJp69yBK
	iz+Hv4tMoJJtgCHVd2esGZwOyvQXoaSigZrxX6VGFlqnLTTtRxT+lV57bIek5szMiP4YxNvmKKk
	d6nPkj1wavOZc5byZrJm3pIk=
X-Google-Smtp-Source: AGHT+IFQO/yBKJtYN1GoZJ5fMFs9kDOYgNJDgp+6DdR4yaOkKN/aQAizwmj335+BGSdCZSyWXPYjrA==
X-Received: by 2002:a05:620a:f0c:b0:7c7:a184:7cb1 with SMTP id af79cd13be357-7cad5b20743mr605108785a.9.1746228673931;
        Fri, 02 May 2025 16:31:13 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7cad23b5c40sm255208185a.23.2025.05.02.16.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 16:31:13 -0700 (PDT)
Date: Fri, 2 May 2025 19:31:12 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com,
	johannes.schindelin@gmx.de, johncai86@gmail.com,
	jonathantanmy@google.com, karthik.188@gmail.com,
	kristofferhaugsbakk@fastmail.com, newren@gmail.com, peff@peff.net,
	ps@pks.im, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 05/13] pack-objects: introduce GIT_TEST_PACK_PATH_WALK
Message-ID: <aBVVwCZ0NZT3KLB/@nand.local>
References: <pull.1819.git.1741571455.gitgitgadget@gmail.com>
 <pull.1819.v2.git.1742829769.gitgitgadget@gmail.com>
 <0d49bb3d30add66676280ec7fabed12351d5b3ac.1742829770.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0d49bb3d30add66676280ec7fabed12351d5b3ac.1742829770.git.gitgitgadget@gmail.com>

On Mon, Mar 24, 2025 at 03:22:41PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <stolee@gmail.com>
>
> There are many tests that validate whether 'git pack-objects' works as
> expected. Instead of duplicating these tests, add a new test environment
> variable, GIT_TEST_PACK_PATH_WALK, that implies --path-walk by default
> when specified.

I normally dislike adding new GIT_TEST_* environment variables, because
I don't think we (myself included) are great about remembering to get
rid of them. But in this case I think it does make sense to add one.

> This was useful in testing the implementation of the --path-walk
> implementation, especially in conjunction with test such as:

I am not quite following... this sentence sets up a list of tests which
I was expecting to show some demonstration of how they uniquely
exercised the path-walk feature. But instead it looks like it describes
tests that are sensitive to object ordering within packs and thus had to
have the new GIT_TEST_PACK_PATH_WALK variable unset/set to zero.

>  - t0411-clone-from-partial.sh : One test fetches from a repo that does
>    not have the boundary objects. This causes the path-based walk to
>    fail. Disable the variable for this test.
>
> [...]

Thanks,
Taylor
