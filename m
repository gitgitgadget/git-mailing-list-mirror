Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAED14F117
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 16:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729009542; cv=none; b=H3A6WUl/16Ix+VJ67n70g/iv6F0C2AZepulZUYLrgHmDSaJhVV+iSAjqtXjCBsYTipwKTONzvDL57z554pvgNS+4x4cf1q7p3FZdjdXo/g7/XlyATtYYb3LLJTo4ECidN20DlMHV2AIOkQcauNrBKA68mLSe7L8QGGU50zJ2gy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729009542; c=relaxed/simple;
	bh=l0sox3m+IGSGbsGZiAxh3zYqtVQat9jgdlZ0t5ossyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PGO6xWPRwmNvOmFLPw7u0y28AfyMshyD8sj6ExG1Db/7MZnwvZZ8y22cQQO4U63d4QPyECc/BFVum1XdgTvn3sIy1laEq7GW8Aam+hA28qA7ioH01SGrW0MQ10ut8Tz2tU4koB4rLq5kq4Uo9RInhlqmYJO1RO18IQJ2GIzHywk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=fNKt8VI+; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="fNKt8VI+"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e28fe3b02ffso4896718276.3
        for <git@vger.kernel.org>; Tue, 15 Oct 2024 09:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729009540; x=1729614340; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l1QkVW5Q5vp20MChvoE/sNkvk4ke2RgnuJM5MOtiVXI=;
        b=fNKt8VI+gD4fXm+KsCyrAiJuDcsEhZTZdIvoa7qM0dx7nkVjaPnlo7pxe82w9AqXSG
         kHP47Dd+10VC5H9tXEMop9a6ZFpuWiqiV47tkSSz092hAQOQMH6K6WzAr8pqqZts0Jrg
         zfwpgrSjEL/j7IUrOYKdKNKEJnSGTsqms+Jf4rSKEr7kRqx0C4J9QsoxgFk60v4889CY
         L682GmvVdvj6Ab6pqidngd8OJlEwitb7oAen0jOm6fEgxweR8FN2chAXZX89K79xpQSy
         5LhVkNCSGu05SRW8szkXc/WxDw/SjU//EInLoNefoSTRF3iRg6NU0Vj1Ll9CAljIU5pa
         FO+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729009540; x=1729614340;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l1QkVW5Q5vp20MChvoE/sNkvk4ke2RgnuJM5MOtiVXI=;
        b=VoC0xmN4gA6/+uVohuMpBEvPTqFnB4IewBpBLmxG1lO9SrSS+zU2jVi/4Zw0gyUMU1
         Caz1j1zhqwrbFCza9FEgNk0/OktCCuyuRSoX8FnRZ5UhODXtMQYvQkeEMqwN1rEGvHqb
         mIuvZdVKuw2wrRwJP78Gwtz/gI8kOexkdz7sHiIu2gKbbPhbVd3HFa2sGtXMu7QoyrRE
         XvDR/7TsaITir06qL860dN4j9zX9g4bD/o5EWWtCD5V96EI4ZHvWpSUajCVxkj9iNKSu
         T5TS9SbVx1FVQbnuWhRmXQy24C2Vt/aUyuf7fhzZQE0XuUxxbO9dqnTuas2AjDCkqFqI
         Onqg==
X-Gm-Message-State: AOJu0YxdVW5PPT43JeNDMppRCzJVdDU1HUtnp2pIXEJgLmbXIvh46fJZ
	8i3dnf75vSUXsupLGiobTlJw+UdMy4iTSe3TyKgz6Bd8FvGgiBIwCmWD3giOleMrvo+D30uJdFt
	H
X-Google-Smtp-Source: AGHT+IErPIjJHHj0x6fZlcgt+4SXQTRnJSaXS86bU7S8ZEvHyJLmpt+vz2xs2pjvjT+19Ycn+W0NIw==
X-Received: by 2002:a05:690c:3508:b0:6e2:5d2:3421 with SMTP id 00721157ae682-6e3479b8a14mr132041507b3.10.1729009539608;
        Tue, 15 Oct 2024 09:25:39 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e3c5d1faacsm3348977b3.111.2024.10.15.09.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 09:25:39 -0700 (PDT)
Date: Tue, 15 Oct 2024 12:25:38 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Prince Roshan <princekrroshan01@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Feature Proposal: Adding Command for Configuration Diff Between
 Commits
Message-ID: <Zw6XgpPZBDrq5QuO@nand.local>
References: <CAP3G6frW_B2pBN0S4H5fsJZgoGtPxC1+_dAzNRhQ9z8ERWZSVg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP3G6frW_B2pBN0S4H5fsJZgoGtPxC1+_dAzNRhQ9z8ERWZSVg@mail.gmail.com>

On Tue, Oct 15, 2024 at 04:29:44PM +0530, Prince Roshan wrote:
> Hi Git Community,
>
> I wanted to propose a new feature for Git that I believe would be
> beneficial for repository maintainers and developers alike. What do
> you think of adding a command like git config diff commit1 commit2 to
> show the configuration differences between two commits?
>
> This command could display differences in repository configurations
> (such as .git/config or submodule configuration) across two specific
> commits. I see this being particularly useful in scenarios like:

Submodule configuration is already diff-able since the state of
submodules is stored in .gitmodules (as you note in your reply to this
email further down in this thread).

But just computing the diff between two commits and focusing on the
.gitmodules file alone doesn't necessarily have all of the information
you're looking for, either. For example, Git's own .gitmodules file has
the following contents:

    $ cat .gitmodules
    [submodule "sha1collisiondetection"]
      path = sha1collisiondetection
      url = https://github.com/cr-marcstevens/sha1collisiondetection.git
      branch = master

Here we're using submodule.<url>.branch to specify the branch that we
want to check out. So it's impossible to reconstruct the exact SHA-1 we
checked out, since it depends on the state of the remote repository as
well as our own .gitmodules file.

On the configuration front, there isn't really a perfect answer either,
because Git configuration is not tracked within the repository. You
could consider a workflow where you store the configuration within the
repository and then automatically "install" that configuration when
updating the working copy.

But that is not without risk, since Git executes arbitrary code based on
certain configuration options (e.g., more esoteric options like
core.sshCommand and core.alternateRefsCommand, as well as more common
ones like core.editor). So you would have to be careful about when you
install arbitrary configuration, who it is coming from, whether you
trust that person, etc.

Thanks,
Taylor
