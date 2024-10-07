Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAA63C2F
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 04:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728274356; cv=none; b=AzjpEuSHr8/DBQdjbheC4/IaXx/aSQ6O/ADZL1qZ7y61wIGIKkhtTF2U+synjT7fa3lx1m/VfBdOoh6UVNr2CVl24uG6d7vcyQX7R0CikfEzzEfXSREoOt7lvn81mOLm0seVEHSLwldrbEB2hk59wtiQrttmw/kLcHeQctaMRiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728274356; c=relaxed/simple;
	bh=0ET/U4xUvYvXwzxZc5k7sI9BtSVccyJ9i/EeVyQJCc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ByBBybZdIzAoBw/F5uWVNuZTJNv0ywPcLeWEHJDsQ69Xb33OMOjrG9X82tNd2tvDON00HpKTPkrV6uE2Zvt+1FqC5KfNh0fK95sDJmLykQYuChR3SWL7OITMbNqJ6f0BiYzicYJNTlzaV2v/lKkPoJnLo0kEwmxRIbzEQ1pCE5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q5XFgRT3; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q5XFgRT3"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3a1a3090f39so15477335ab.3
        for <git@vger.kernel.org>; Sun, 06 Oct 2024 21:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728274354; x=1728879154; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sZ20qvMbAUtcQUFi8w4QB44ESrorVT1rIv1+BqYpSQ0=;
        b=Q5XFgRT3wVM2Ul07LI5s2er6SJZXnATkgoSAqGNGrvTkQ7kP2p2WOVVnTKXiwSixsQ
         +R11HJx45Ak5FxUqE8/q2FaBPyDwGnGcfqJHuhs/xlcLwzCgMdAvEfsMhJPQ5okiKYUv
         l9X1L2MpINrwVrqc3GD5ftx2UpNwwdit1/pTfzo9ynSvsjLi7THvjAE3SAwLG5hv+tTj
         0MI3yKA2NqNgtdbR5LmCBzCEqlXkFNsx+sFzYGrYe8LdmxJpWcAAju4/zTrGchKyyunm
         Ky3bt9DiAWr8mYjokZgBmJ5s3UBDxukLJ2CH/paFC/sOpllUM5YCdIK8bZzg+iK2s5xw
         6JiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728274354; x=1728879154;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sZ20qvMbAUtcQUFi8w4QB44ESrorVT1rIv1+BqYpSQ0=;
        b=X+X0Gv3gsUP6s9VG6T2AcSau4tHHkgeu64JIK592CU+FgFMJO5tV/nH77XfpyRZVLX
         gGflfouQQg+SkWLHQ8dT5hcCoKXqETtQiuvmO3PBjdrr8HQHFxto881XD0bhSsguD8xH
         rcsk7g9WtaLXDO0F+MGm70BCSLr32mAgXrOJAMpwcWOExBR4ccQ7Virpl1H6zQCqdfUC
         N/7ex3vcnh+WxLH1JYLGu/oBCWOo/EDpa8z5zc1ab1RfR2isqAUTIbo0elwq97cYtXlD
         1PKYoJMLRItHNblGrsPu1IlKhfL7SBNN2pBbbm7fJO/y/4BjdgDrNBbbF3h7rgC0POh6
         8C5g==
X-Forwarded-Encrypted: i=1; AJvYcCUM2XSScOSSRH53eqeNaksjgSuEGc1RSP0vMDaOCaW7EYCePNeVAI2ok0oNTm8Uon5a5F4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO+ePc1ydE251QHWn+Iyn3xJxUVFUoDppLOiwMcL1Mri2gZ9kP
	6Df49dsHC4Gisn1sLFbijGJ/8Tir1mr5p9uguIaum+mwQNBVXgqi
X-Google-Smtp-Source: AGHT+IE+e2oHUMaPl333d2fwgiXK7EPP4borIMF9mtlINCwL+WiF4+R9TEH8MeJc/ny8TQIAn7Abwg==
X-Received: by 2002:a05:6e02:12c7:b0:3a2:4cc4:cfd with SMTP id e9e14a558f8ab-3a375b975a9mr92541805ab.14.1728274354157;
        Sun, 06 Oct 2024 21:12:34 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9f6833ef2sm3943770a12.47.2024.10.06.21.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 21:12:33 -0700 (PDT)
Date: Mon, 7 Oct 2024 12:12:40 +0800
From: shejialuo <shejialuo@gmail.com>
To: Caleb White <cdwhite3@pm.me>
Cc: Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 1/4] worktree: refactor infer_backlink() to use *strbuf
Message-ID: <ZwNfuLoVn4aU4mgQ@ArchLinux>
References: <20241006060017.171788-1-cdwhite3@pm.me>
 <20241006060017.171788-2-cdwhite3@pm.me>
 <ZwKoNg-HYGaohvCd@ArchLinux>
 <CAPig+cQC45_Pofw31h2RSydj_CjqpfajLLa5O_sR9m0AQh5OVw@mail.gmail.com>
 <o7jQV4JUYr2iQtErKFhCrjCySiGn7_I18gmdInKbOC9TAsvqazG0O_fPUtiWZ5UfiGLr25OZ5xvqIhfOIwCG-s1RGgri-BJIdHqiokIw4z0=@pm.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <o7jQV4JUYr2iQtErKFhCrjCySiGn7_I18gmdInKbOC9TAsvqazG0O_fPUtiWZ5UfiGLr25OZ5xvqIhfOIwCG-s1RGgri-BJIdHqiokIw4z0=@pm.me>

On Mon, Oct 07, 2024 at 02:26:51AM +0000, Caleb White wrote:
> On Sunday, October 6th, 2024 at 13:41, Eric Sunshine <sunshine@sunshineco.com> wrote:
> > I found the name "git_contents" clear enough and understood its
> > purpose at-a-glance, so I think it's a reasonably good choice. A
> > slightly better name might be "gitfile_contents" or perhaps
> > "dotgit_contents" for consistency with other similarly-named variables
> > in this function.
> 
> I will rename to `dotgit_contents`.
> 
> > It certainly makes sense to check whether "git_contents" is NULL
> > before trying to copy it into the "backlink" strbuf, however, if
> > "git_contents" is NULL here, then what does that mean? What does it
> > mean to leave "backlink" empty? The only way (presumably) we get this
> > far is if read_gitfile_gently() succeeded, so (presumably)
> > "git_contents" should not be NULL. Thus, rather than conditionally
> > copying into "backlink", we should instead indicate clearly via BUG()
> > that it should be impossible for "git_contents" to be NULL. So, rather
> > than making this part of the existing if-else-cascade, we should do
> > this as a standalone `if`:
> > 
> 
> > if (!git_contents)
> > BUG(...);
> > strbuf_addstr(&backlink, git_contents);

I agree with the idea that Eric proposed. It's truly we should raise a
bug here. That's would be much more clear.

> We can't use BUG because this is handled as part of the err
> conditions. The contents can be NULL and `backlink` could be
> filled with the inferred backlink. I moved this to the top
> and I think it reads better.

That's not correct. It is true that the contents can be NULL and
`backlink` could be filled with the infer_backlink. But do you notice
that if `backlink` was filled with the infer_backlink, it will jump
to the "done" label.

What Erie means is the following:

    git_contents = read_gitfile_gently(...);
    if (err) {
        if (...) {

        } else if (err == RAED_GITFILE_ERR_NOT_A_REPO) {
            // handle backlink
            goto done;

        }
    }

    if (!git_contents)
        BUG(...);
    strbuf_addstr(&backlink, git_contents);

    done:
        // cleanup operations

Thanks,
Jialuo
