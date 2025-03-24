Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E6C26AFC
	for <git@vger.kernel.org>; Mon, 24 Mar 2025 15:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742829936; cv=none; b=nvwwi0pvFzwk32BJMc9runTVQqpH3ovpeNEryLk6heiC2HuU9ZCzZSEWBZJcNtyZtkSX0+bys/SYZlUo8Ehmgrf5KOHQOF8q1n4yCvc3LmEjGCSCokyhw8Vyfk/fSPyWhnYsC+ZD0X2y97qzTo/ML8Dsw5ADsTvGKve6xMninRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742829936; c=relaxed/simple;
	bh=l7yeYGzbCL6myd4WzMnRMyNRjMEiNogYCv3aIoicbiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iX6sPGqqv/HcEg/AX7r8Yuc5WAJgpFyWhzDYRpDG1359rWRBuw3A1zllq3yCXAXOABzvmEfoF9GpHLJD9ZScR5b4zmzdfGrpKLY34PjZyWrwbYcYzDVRvjo7fA69DO1B/e4DlW7ATfZ9sczE5sUdVof/Ix0jleVP539zfcpzXQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j2ZxTblQ; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2ZxTblQ"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3f68460865aso2642295b6e.0
        for <git@vger.kernel.org>; Mon, 24 Mar 2025 08:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742829933; x=1743434733; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rw15d2TWWdzVJoyeFvpK+ueWOY5S1s9SqanggXZzmHY=;
        b=j2ZxTblQipRcXx4qDQaSKiY5y6b6RO4YyFOiARSydd5oeNY069KrKX5u26UY0Uttbq
         cn6TLhyxgpO7csIp29pZDZcr3lJtLIdx/RFbGmyBvQZoDu9G1CA4XZ2roOgTol+frGDT
         vORp0UztVUwrBIVXnMWCR+SdqIxbp3U096wAwHJPR1DrdCvujpoARzwz4bJIUaDcbY9+
         5ppiNhu/LWWeDGaS95M1c9SsnuREc5lTgoQwROasYkFSk6qQV0Ca7xphfe3dNWD5+sss
         K+d/Xb4aS4hloI8VR4bXQDy3FxurWgT0K4almQ6BzTftLPO5ETwjS2XL05iPa639OpFq
         yUPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742829933; x=1743434733;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rw15d2TWWdzVJoyeFvpK+ueWOY5S1s9SqanggXZzmHY=;
        b=kfids++/vhhXre6cIbu2xv+ZoJkV9dRTEyzzF5Or2dDcxBIogCu0HK0k/VlyXg2BEN
         5uTXAAp88tcBR7ZvwVoiJgK9uCmzTmndb++w0Ps6tkGk+5uuYtCunKVO5TyV/XFYLfzp
         Vzi3jaNgOnB+9pSKPz47yVTKq1ff5+fnnowychWDkpXHsS61/1HR+jK5cpkSBdGp7Cqu
         dbY8C28Uf7a6xwzN+tJ/IJTMwh6TydnR2dW/0MdPif73mD2DkUzHq2kao1lVav+V5uWD
         h5tsJptYh7SW2PsZ04j+cDWYUinpAfiG9XyFwrR9Efbm1dulL/zohZaALRTotGpig3lz
         RGFw==
X-Gm-Message-State: AOJu0YxcfD33F2eQz/PQPwGY3eWLuB3fcB4wGtTmLkcYNhbCGVrbKe0Z
	Dcuc4ZvE0PBkIPDQ25FhmCKEubToA4auGopLntxjMl4pfTDDqEKk
X-Gm-Gg: ASbGncty5OFgbH3X6CiP36AvH5d4Yd5fmngLQI0YS+TbS9GtuDZeYiisdVKCZbYPpO9
	g6qu94p6iCqDmJH534v5hlArbp4ylLt2bMXmqgph0vNn/NlcBtjCnpFU1YLezIP8qiKnKIg+V/Y
	fBP0aC8fdexlz7lNKcUR+u/9McR2ZmcS48Avwdjw5HxQFuCcwJkqhBwp5cI9JLSrTd5wB3KzIBA
	tJkhBFXujgcH+YfOHcOP7UjNmKSeAIjHpHV+h+0mYsXaxd54N5goGnvkTbWXh+SuSlwwu0CXvNY
	tYwxI5+2jMl+eiSUs3ibMg011NHGfOZSYeHVFg==
X-Google-Smtp-Source: AGHT+IEuXTJBvDvmkuYlvDVIjxcE5CfmLvypLOgcQ9RzKOpFchQLPxdHsm+CTkFSBP39pCN9qU4bNA==
X-Received: by 2002:a05:6808:14c8:b0:3fa:d6c:cdb5 with SMTP id 5614622812f47-3febf797d75mr9094916b6e.34.1742829933018;
        Mon, 24 Mar 2025 08:25:33 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-3febf79dd92sm1579029b6e.46.2025.03.24.08.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 08:25:32 -0700 (PDT)
Date: Mon, 24 Mar 2025 10:21:54 -0500
From: Justin Tobler <jltobler@gmail.com>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, ps@pks.im, alan@norbauer.com
Subject: Re: [PATCH v2 1/3] remote: allow `guess_remote_head()` to suppress
 advice
Message-ID: <3rcpapodk473swxbdgubhuqijvgwe6rz5iqsfykglsmjbanuu7@mh6tvrhyyrx5>
References: <20250320014646.2899791-1-jltobler@gmail.com>
 <20250321231639.180762-1-jltobler@gmail.com>
 <20250321231639.180762-2-jltobler@gmail.com>
 <106cecbf-6a7c-46bd-8115-2b5fb06cc9af@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <106cecbf-6a7c-46bd-8115-2b5fb06cc9af@gmail.com>

On 25/03/24 09:31AM, Phillip Wood wrote:
> Hi Justin
> 
> On 21/03/2025 23:16, Justin Tobler wrote:
> > The `repo_default_branch_name()` invoked through `guess_remote_head()`
> > is configured to always display the default branch advice message.
> > 
> > Adapt `guess_remote_head()` to accept flags and convert the `all`
> > parameter to a flag.
> 
> This makes sense if we want to convert the boolean argument to a flags
> argument. However the only callers that do not set `all` when calling this
> function are in git clone where we don't want to emit the warning. It is
> probably not worth a re-roll but I wonder if we really need to do this
> conversion or if we should just hard code guess_remote_head() to be quiet
> when it calls repo_default_branch_name()

Good point. We could just rely on the fact that all current
`guess_remote_head()` callers that do not set `all` also do not want the
advice to be printed.

I have a slight preference to keep this as-is and favor the explicit
configuration, but ultimately I don't feel strongly either way. I am
open to change in a followup version though. :)

Thanks,
-Justin
