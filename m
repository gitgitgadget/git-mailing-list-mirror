Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1B31FFC7B
	for <git@vger.kernel.org>; Wed, 21 May 2025 15:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747842885; cv=none; b=DbUL+XzYYZyaXj1yyDWHJwRWCQONuuyH+B9ogJaWFTUGPAxnYxtFqpwe5pCIPiMk6RrxdDA8RZnLAT7qAns3bDVi8DnlfJsk4qYfo+1u4bHoCZ+TOIUw/alDECAhUpBOQda4k7XLQCiBNCuzPtZofx1uAUH8BtBISZJjCxOVkdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747842885; c=relaxed/simple;
	bh=PK4VxvqwqiPlp8DXfP6AW3R4kHcZjfGGVOKPHa1iAX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P9a16VG9NwAUmF9etCArBVNBIs5upejuF3I7JmJWMLTrZjlU0GU4RYOLpQobtIJOzGnwMF7lqR+xyT5p02k6AQAVFIGeEpFBw0TnTfX5VLkgwzJSDfLYC0gHedvVgXZ2jGwaFjM5fTsVymQNCwiWyIM8icpFH9cZodbQUB+JrqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OA9RzTvQ; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OA9RzTvQ"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-601ad30bc0cso5433797eaf.0
        for <git@vger.kernel.org>; Wed, 21 May 2025 08:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747842883; x=1748447683; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fxNvj5DzbTDXdpBCpEGnzVT7D8fUtUj827P012SjnSA=;
        b=OA9RzTvQcRUhVlJvCfK9IYZi7ysJQ1c9WzZdy7VcuYl3+UoOMYk8YGPJSBioobI3tK
         xTfBtFYnxGu74JQ+BApOfkFDxogiSFEnVnWMFKbeMZk6xq3dTmh00QDR5MFsCw5TAiDH
         Ix7d6MjxNkswOm9qEybOvfO82NQFlVFUgHhY7DKOHzFOhZwf1JlY2bVZVb8udRKwszUj
         eTfE+TvJsbUaSTXDOx7QURxu6WouT1gLJsj5mNFXftZ4qo9M3b/ISCajuG7TGV7X/iCt
         YrErc//OgjSsxaXXhc9hNxylzqczS3tv+tVYC9oIdLxtnGMWlx3r2qpd0ASgGZB/lPPj
         JGBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747842883; x=1748447683;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fxNvj5DzbTDXdpBCpEGnzVT7D8fUtUj827P012SjnSA=;
        b=atq2pYN8wx6puKD8tVZ4jHh2q0d+u32fDFkz4/m3Tqt7OEYOVuyEUKyEh7OK1XK+JX
         V39AFCmCN5ylLDOvPp5sbBv1F3N4JHinnh/u4J/h1in85B78M83zHpGlAAM+EF6YtErl
         7ZIk28RdSUY7hR7XtObquKxzdgSOMPYBGS9EwdBv5Q3rmcD51XgGMpWnjFkYOniLVvWH
         tQ9UiHBKd815WJm0GBZXI+XuTQdWbFJ1yitPJNCecGYjEC3vtFoEyri8pZUj0FiRpNvQ
         Xp5rbiHNAzcQ6VFm3dZijFD3pKJlrqesN5JfJnzE4Ym1EkTdS932xZB1NHBLtUh4nuhO
         Kwow==
X-Forwarded-Encrypted: i=1; AJvYcCVRlSRJl0VQwkFB6uP9zVsABR3aYe0fuqcioz6RHiIm4l4khQc2h5yuNiTKCc4TFuD+ywI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzRAVRGr+FjSaBi8CeiCHPFb7DVVW2HzbzO5Iy4e1uJq5az/UA
	IfHcMdFiPHrydgFVx1Ddy3DIMjW8hi7+MymZKsJv257bRciw5599kQgG
X-Gm-Gg: ASbGncvaL8ERXD4EFOcYgDSR6R0Dn3+RHRc4gGNXXjG7z/Gueeu99CVHhl7cKpPW7O2
	fveJk+hNJoZhBl0rOlNVp8vBqGPx5Nl7TP6GrnJwJ8ey9tlBlvqpD63fZUdxPReq6rjY7JYfN7G
	vYcIP6RXIQwDdXFdgvNaiVnhgkN6G1g8+5GUmdnhc7RZtEnZDUiWFC9jkWjjbv2nP9C8wRfwBUM
	SnMbvGrrzwzyy/Fo8CAujqcF9uMcVcoPhCYoXD7uTrIEvMHQVAcjeB5aRSO0OIiMiiM2C3OyBQw
	35PLFrEtlqrZCS7qzwsoHGg+XdOoDx+5WcbbzkVdVrFh
X-Google-Smtp-Source: AGHT+IGu0IQ1nzFsWsOb9NrHFvDoOr+IAjF3kO6zEHZFBUTXO5sOpCeU8A1sAPrm6wavrkRmZefZTA==
X-Received: by 2002:a05:6871:a105:b0:2d4:dc79:b92 with SMTP id 586e51a60fabf-2e3c28013camr12658470fac.6.1747842882690;
        Wed, 21 May 2025 08:54:42 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-2e3c0a9ed10sm2748574fac.32.2025.05.21.08.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 08:54:41 -0700 (PDT)
Date: Wed, 21 May 2025 10:50:03 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Phillip Wood <phillip.wood123@gmail.com>, 
	"D. Ben Knoble" <ben.knoble+github@gmail.com>, git@vger.kernel.org, 
	Johannes Schindelin <johannes.schindelin@gmx.de>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] drop git_exec_path() from non-Git commands' PATH
Message-ID: <zhkp5ieg7d3itnwzo6f435snmtb6kseunwgrj2omu4gqemistg@6af5cxhswamk>
References: <20250520193506.95199-1-ben.knoble+github@gmail.com>
 <20250520193506.95199-5-ben.knoble+github@gmail.com>
 <aC2OaeLYJQAOE_S1@pks.im>
 <01301fa6-eea7-427d-a61f-5cb8dac99afd@gmail.com>
 <aC3SZtwQSt0mSVuo@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aC3SZtwQSt0mSVuo@pks.im>

On 25/05/21 03:17PM, Patrick Steinhardt wrote:
> On Wed, May 21, 2025 at 02:07:25PM +0100, Phillip Wood wrote:
> > On 21/05/2025 09:27, Patrick Steinhardt wrote:
> > > I agree with what Junio mentioned in a parallel thread, especially
> > > around Git hooks. The expectation there is that those may execute other
> > > Git commands, and that should typically be using the same execution
> > > environment as the original Git command that has been invoking the hook.
> > > So refining this patch so that the mechanism is opt-in probably makes
> > > sense.
> > > 
> > >      A slight tangent: I wonder whether it is even required nowadays to
> > >      adapt PATH at all anymore. As far as I understand this was a
> > >      requirement back when people still executed dashed binaries
> > >      directly. But nowadays scripts don't really do that anymore, but
> > >      instead use the git binary. And that one doesn't need PATH to be
> > >      adapted at all, as it knows to listen to GIT_EXEC_PATH and its
> > >      built-in path anyway.
> > 
> > But don't we still need to change PATH so that hooks, shell aliases, git
> > rebase --exec, git bisect run, etc. still run the same git executable that
> > started them? For example "/usr/bin/git -c alias.g=!git g --version" should
> > report the version of /usr/bin/git, not ~/.local/bin/git which comes first
> > in my PATH if git doesn't change it.
> 
> There's two parts to this: PATH and GIT_EXEC_PATH. We do have to adjust
> PATH indeed to contain the location of the 'git' executable. But we also
> add GIT_EXEC_PATH to it, which I'm less sure whether it's actually
> needed.

In instances where GIT_EXEC_PATH is set on the parent process to
override the default, wouldn't we also want this configuration to
propagate to child Git processes?

-Justin
