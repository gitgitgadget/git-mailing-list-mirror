Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F273269CF2
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 16:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741884328; cv=none; b=i2/4b+B5ImpLaXhsoAQ5xJq+ogMyyMuHH9xBHvCVwh/lvjr6VyL6QLC2rVO0m9cgAL34brD5SJi/PI5frPBvG3b/KKwgLC4+GjWeY+HwIvDJERRDj9jJ9heNsTPfEKFzHvhSltchCUqcoTlqkCO3l0vz3emwI4Gie502efwm3a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741884328; c=relaxed/simple;
	bh=zIakTqTOyaYDs7w7qngTWCMPkCfJFBBmGHwnPLDNd5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KYAnrtsDlbR+rdoQ6m2Iw4a1qW2AlhJGpGGFFqh11mC7WUnAbiMVbZ3USgjGbo/0rUenBiu7McMCCZ6MMd529k7tZA9duC3ZeBmud2iBVCmQIcZfF+dO40MJZ5eKhuz2Oe1eQx/zbkJe5WNactIXhY7xWtnOE6p6cz3dZmvdu+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jFCq8tTp; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jFCq8tTp"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3fbc00143d6so776439b6e.3
        for <git@vger.kernel.org>; Thu, 13 Mar 2025 09:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741884326; x=1742489126; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fQhsnLtnh1QTJKAufF/8VC1yOfjWIlsa4NIp4B2goo8=;
        b=jFCq8tTpzAZ4bc7DQYQekO2F+jIeS0+p8lT6H7m6GRYn5f0fVTMUQCef6OxjdmOKzQ
         PuNFlm0WzaR6jlcEUnF45xxwfRrF3hZitk3cnkZYd6sVu2dENR9jze8YvLjQE7IoThYf
         Z+jyI4rkzB73yii2G2HwLsPsy4sC5NSmJ5vVEesMP9w40kl9szsofqVi/sAh7C86a8nL
         TMclFzx5ryGy41pdguy1YD5NozNXFoLKNfnPLBI2o53eCvim6AfF7gFb3uU6qyf60c2f
         Dq9wff7/jv8tid5jB/qofVqRQZbc8bmQGnP0C63GicWzOwKN6Drxt35s76ZCkmiIOn5Z
         kN3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741884326; x=1742489126;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fQhsnLtnh1QTJKAufF/8VC1yOfjWIlsa4NIp4B2goo8=;
        b=goWEp2C2Sp/fLbKPpQ1XNKIkjTmgYZkpG1pw1lvO9AXJlCK7zAJaqQWrgReJ8XNOOB
         SUth21gOJh7cRTfNuabB2bm9vgMa0v8e0VLxcV3svb2ryg2lDRU8FRGGFJGlnD3FxU6A
         Qp4HrJnvIzyQXZFbidXaM1hK3rZvp6AoAY5PmEROLqhv8OjJyAGmBhqPsbn1H+Z9GwLt
         9x2edcQ1qiJ66iSeSFI6tKNrLLoDdDgN4cNUHRsRi2d4+B40NlEza9R5Fei99uo6oD06
         fp0igORgUsDv5W82qj+HreRwycEnmED+A5cn94Q8rtR1IMH+LuZXYtmoSmAyKNGi60/B
         Lfsg==
X-Gm-Message-State: AOJu0YyVFm0BTCkdycTZAns9o5MK+XUweSH+ZJwQ/mCaDa0lkV7V7BnA
	hnfpTJw2/gG2JugSmNv8Mv4lr61JEVxxZejZ6O35ICTqnYM3js4U
X-Gm-Gg: ASbGncv4IUb9xKTsSHy2lbEgQma9XOTB2POjpbscAWWbGS+OdIGd9L9+BS/UZ/8pxDz
	AZTST4+sxwFoj8dAXalTmRO1zJ873ihKt11O3A0FOEoTjhbInotxtjPDsr8QHq0f7uCE1YZZdSI
	906Xj6773dwdN7B2H+ba0jGkAdaBH2+x1AU2fc3R14s/Dre8WG5EcZZgsM6YfAkJaSyyT1qb+I8
	cZEIakg1jqX65GeALmaO1ctll6/UYc3ThJQ9uZ7Wl8yiXLsvZ38g6nCAJdx8giqdvgrLngMVCeu
	Mt+R/o4tO+9PY4UG+pQz27b30c6eaU1NGLmiJPjM9P542ZOF
X-Google-Smtp-Source: AGHT+IH1t+1yUY9LbMdfS3PH/cR+tXf+Ps86us6x1wacpj2S3Wrpxfk3KBYQue4+lBaOIs9Z8imiNw==
X-Received: by 2002:a05:6808:1396:b0:3fc:105c:430 with SMTP id 5614622812f47-3fda382badfmr166821b6e.39.1741884325859;
        Thu, 13 Mar 2025 09:45:25 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-3fcd5bfff69sm295063b6e.39.2025.03.13.09.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 09:45:25 -0700 (PDT)
Date: Thu, 13 Mar 2025 11:41:56 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, ps@pks.im, christian.couder@gmail.com
Subject: Re: [PATCH 0/4] rev-list: introduce NUL-delimited output mode
Message-ID: <qapd7sijizopaefpxh3slgn7g2ecwdtyhzqzufcypciyv6n3qm@turmldwzipwe>
References: <20250310192829.661692-1-jltobler@gmail.com>
 <20250311235720.GA73755@coredump.intra.peff.net>
 <sm5xvh7bipyrlpw45bptlctbuhey7v3qktpskal5dzexomt34f@wgfziyhcf3t6>
 <20250313053329.GC94015@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313053329.GC94015@coredump.intra.peff.net>

On 25/03/13 01:33AM, Jeff King wrote:
> > Furthermore, revision and pathspec argument parsing is all handled in
> > `setup_revisions()` so if we want to NUL-delimit arguments parsed on
> > stdin with -z, we would still need to parse the option early anyway. I
> > think it should be fine to leave the early -z option parsing as-is.
> 
> Makes sense. And I guess we might not want to have setup_revisions() do
> that handling of "-z" for input, as that would make:
> 
>   git log --stdin --raw -z
> 
> behave differently (since it does not currently change stdin handling,
> only the diff output). 

Yes, we won't want to include this '-z' parsing directly in
`setup_revisions()` or else it would change the behavior of other
commands.

In version two of this series, NUL-delimited stdin handling for
`setup_revisions()` is triggered by setting a `nul_delim_stdin` field in
`setup_revision_opt`. This gives the `setup_revisions()` caller the
ability to control the parsing delimiter itself. 

Only in git-rev-list(1) does the stdin parsing behavior change if '-z'
is also present. The behavior stdin parsing for `git log -z --stdin`
remains unchanged.

> Though that does mean that these two commands
> will behave differently:
> 
>   git log --stdin -z
>   git rev-list --stdin -z
> 
> which seems...not great. My earlier suggestion to tie "-z" to stdin
> handling was for consistency with other tools like grep. But if we
> already have cases where "-z" is only for output, maybe it is better to
> stay consistent with other parts of git. I.e., I was worried about us
> painting ourselves into a corner with your patches, but we may have
> already done so years ago. ;)

I think to some extent Git is already inconsistent here. IMO it would be
preferable for both input and output to use NUL as the delimiter when
machine parsing in git-rev-list(1) as that is the behavior I would
personally expect. I also agree with Patrick's reasoning else where in
this thread[1].

I'm open to discuss further though :)

Thanks,
-Justin

[1]: <Z9KNQ8XliWrrYgAT@pks.im>
