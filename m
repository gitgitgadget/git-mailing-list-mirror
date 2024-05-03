Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5992B1514E5
	for <git@vger.kernel.org>; Fri,  3 May 2024 15:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714750119; cv=none; b=c4YL2MmqxdE8Tq/HdeHbiyuPO5ExNmD+WEJZEtj/P1FgCelDDWBjHcaHmoa+omrwRKUKexvA+UeqikGKnzHh5lw1ePP6lBvHtH0cfFIO0+w1/MqiB9sZaNTQDugzkPSGAX97xzWSdRAYT0SdGlO2PFcw+IqMPk0S5AN9W8ds3KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714750119; c=relaxed/simple;
	bh=4UM0SxZq4uCVyLfPq1CAbYD28CwNjP2R3FBPgMJf4WU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uwgGyfkzIltZoxAya2bW0jjKIzXiPSwS11gWt2YW46a3xz9uVSzuKthWta0dKE2eoVTa2M4orSqo42X9O4xHL40q6BL0NPA0d8r0ZKINwZDOy/gn4vo+MAuIEsNRa9+xCKxPXpTMRvxZu7h0bGI/QqCtq10kiwty38uOQHymZVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VXPQS5xL; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXPQS5xL"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5aa27dba8a1so5421796eaf.0
        for <git@vger.kernel.org>; Fri, 03 May 2024 08:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714750117; x=1715354917; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1wZM1oCx2IyO8rz14jADmL4Y0h4uL0FbeJofUT6cBjE=;
        b=VXPQS5xLS4r8ev/jRsQW8J2TRuP4RRqQDXoY9RoDDGWO3oxatinWSO2q7FI6Oij0LX
         AMvppABpby5YbJ1JIcSJsmNh27TfOOnW2I5ry/M+Dlepvmrjj6ijGsleJNm+E0GDvsQy
         4APd+9GSPMqQnVnSG4sm4P33DEZ8R+1ohIBihJUkMQrFskGz61JDRMSlM9mv2/rG2HRk
         /qSIsxxwtTr2teUfogM0HH7pxy2KKgEedPpczyYQLCcvWb5V09bAakiyF0Zxx4Pel/Lv
         PjhW8ZGNohPcj9zC/3mWI+7XY7a/g6aSfdjZUHsuODcaNsGGi4+ec9+e78+LpiUEONp4
         40sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714750117; x=1715354917;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1wZM1oCx2IyO8rz14jADmL4Y0h4uL0FbeJofUT6cBjE=;
        b=M3W3M96XMxK+XwMuxxodGFpbWRalQZyp7oUmc+DMlPMz2eWswtNSunOuutq2ptsN7i
         BL6wS8qiFgJUHUAHFLqciYx0p/Mfp890/krtpiQOnKDBsT3O1TRNJN0GBcdAd6mm03mo
         QRKM9jAiIcrGvHREOubiz2om4n37LW9QVm5HIbSkn+cqYPeZ49pUYGV1phUGKJrFb0H7
         fjQkgWfbM1wXK5KayfgRG/mCZBqU8xZG/t+UXllJD/xWvhHcSk3gcJ6tsetwl+J/9R2M
         yFeDZ6Ons+OuEKaqChrhr47eaqc2N0+qoKOYSHArN6+74MtMJHEJMnGSimKd+/vZMmnx
         0kDg==
X-Gm-Message-State: AOJu0YzA/iOe/sAtkOgxb/DXpLytDzeyZQp6zIAP3gGK5Oba1TWZ8zVG
	Mbk2esRkX79ReB0LENO4eKCI904qb8rWq1x+KAJKd62CzLMlCZ5+YrtcCA==
X-Google-Smtp-Source: AGHT+IGnCVfc153FyblIJi4jTKQiUT2ocrf4FPC7puYjZU+gfU6uJtzL4CcZa/7H3cb8TLbOGPSdfA==
X-Received: by 2002:a4a:ad41:0:b0:5aa:3e8e:e1f with SMTP id s1-20020a4aad41000000b005aa3e8e0e1fmr3305446oon.5.1714750117341;
        Fri, 03 May 2024 08:28:37 -0700 (PDT)
Received: from localhost ([136.50.225.32])
        by smtp.gmail.com with ESMTPSA id dp18-20020a056820291200b005af4ecbcc5csm681707oob.29.2024.05.03.08.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 08:28:36 -0700 (PDT)
Date: Fri, 3 May 2024 10:27:20 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 3/5] ci: separate whitespace check script
Message-ID: <awbex2f6p4sqdneevwrsba4gayidhvxrdyqjqffcn7ub5imcmm@t3wfqe5xmytv>
Mail-Followup-To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <20240430003323.6210-1-jltobler@gmail.com>
 <20240502193840.105355-1-jltobler@gmail.com>
 <20240502193840.105355-4-jltobler@gmail.com>
 <ZjSKqaJxd55328Fn@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjSKqaJxd55328Fn@tanuki>

On 24/05/03 08:56AM, Patrick Steinhardt wrote:
> On Thu, May 02, 2024 at 02:38:37PM -0500, Justin Tobler wrote:
> > The `check-whitespace` CI job is only available as a GitHub action. To
> > help enable this job with other CI providers, first separate the logic
> > performing the whitespace check into its own script. In subsequent
> > commits, this script is further generalized allowing its reuse.
> > 
> > Helped-by: Patrick Steinhardt <ps@pks.im>
> > Signed-off-by: Justin Tobler <jltobler@gmail.com>
> > ---
> [snip]
> > diff --git a/ci/check-whitespace.sh b/ci/check-whitespace.sh
> > new file mode 100755
> > index 0000000000..f57d1ff5f0
> > --- /dev/null
> > +++ b/ci/check-whitespace.sh
> > @@ -0,0 +1,74 @@
> > +#!/bin/bash
> 
> This needs to be either "/bin/sh" or "/usr/bin/env bash".

Since the script is using some shell specific features, I'll update this
to "/usr/bin/env bash" in the next version.

> 
> > +baseCommit=$1
> > +outputFile=$2
> 
> I think the script would be more flexible if we just didn't have an
> output file in the first place and handle redirection of the output at
> the caller's side. That for example also allows you to easily append to
> a potential output file.
> 
> Edit: I see you change this in the next patch, so this is okay.
> 
> > +url=$3
> 
> We should check that we got 3 arguments in the first place.
> 
> Edit: I see that you add those checks in the next commit, but it does
> leave the reader wondering at this point. Maybe we should have a strict
> check here and then loosen it in the next commit where you make it
> optional.

For this patch specifically, I was trying to really only factor out the
whitespace check into its own script and keep changes outside of that to
a minimum. The next patch focuses on all the actual script changes and I
was hoping it might be easier to review that way. :)

-Justin

