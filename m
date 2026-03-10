Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0BA40DFAD
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 13:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773149814; cv=pass; b=jH+dixSPutKgdkEcXGeRzkFLEGw8UiDYafGfDQDgCl1Byq7KtEaMY2gUp45hGsRCAPTgC8IVpTNqiduAVJRJVqrsvPqx1F4MJtATCRmjwY9rXf6sNJ/U07AEdH6R7emahMghCL11wADMgkvhzi0MH6MsxSRMJzduHkxgev1Hgzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773149814; c=relaxed/simple;
	bh=afPnE5BDprCShJT1dwjCe5giv3ckFeLS31pTlfbQHTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YRsFpcG+gAFGLgoX2xccwE2D9Dz2uq+PeX2VHGcJDo2NJDvnwmmbmfS60V8VDjciZyWlZb+fKCWjWl+gcuimO7ONMQqsgDouHaDArpFh/9C0V9gsS7MNbuLoOWWaHjn2BKUIuaIT4utJpXpsgo497t9YlwhglGr10lajyq3gWHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kE4s8Hfi; arc=pass smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kE4s8Hfi"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-5ffea5acd19so2501669137.1
        for <git@vger.kernel.org>; Tue, 10 Mar 2026 06:36:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773149812; cv=none;
        d=google.com; s=arc-20240605;
        b=CC9c7IyP6k4GfSf4XkQdKNAV5oXDe/m5IWDpxdmRUQU7Xv3D6aqAhIzbEBJK5kZ+LE
         FXCMRroh20ggpYIFoLKgkwbdu0fw/ic/pqshndh1nxmJBlwuAsZkfyDsXDiptpeqyL0q
         xX6hIfNVeFGIxbyQbjNWDcLukvLRYOp8OWzoUzhpCscdVVXjLN3m8haxAAlQEYKr2n2t
         QmX6WX7inzKChtdI9Z6kYG1Xhu22Kl8XRF39Y+cnRsbH/dqm6omLXE5sqs40oOTspVei
         P+dIccVz7Y+mDimhWWyqVZK+TuCYb19PyiB8M+IsOZ8gK+CnZ/rjjffBb8GORrRH9+pf
         coVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=nE3EhDDtI18KgLlHZKY3IA7GELinpJcm5bDKTBwiy0c=;
        fh=ZiG9X25KuuY6L50mqS3dg8QNMIFKV63zlBWmxroyUuE=;
        b=X8Bu8Yvaj7ZaNpuyfeaNRMiha+rjDzoP38x6w5qda0OvIBYIJl+/GUwmC20TVJkL9T
         fE4cxq0FnZbGDFXcXECV8Jjg5LnT96b3oKWFDKDG4CCn+cvfwPKNMbZDNCnR51D314KU
         HdtphZXBITU/yBugG6T9OZOFS9k0eB4smqdxDCy7PBZEbmBPFY0Iq3cYOvuE5ROsLJmu
         BAz2rEh6lXyHvQpgdtUau19yg+MzM1WclSTKHqJuUilhQcgi/CGOzxNrv2GuYWoiCDYt
         5iPl7T8sUSuqUc22MR8V7EhiLun/J/laraHt5CWVqC81++Zn1lTa/fci3qV56BHQ8eL/
         rJ3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773149812; x=1773754612; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nE3EhDDtI18KgLlHZKY3IA7GELinpJcm5bDKTBwiy0c=;
        b=kE4s8HfiiCB8WHIkOYGUhi0dPnqlRc6+IkN3wKs4T4vqNNDLo7XbHMixlCBmAUESzl
         hWk6Ny9+uoz0vDzGdr1xNs09kiqJGVOoG53qYXDyJIRM6HiS03szrSrueohAUKvrbrKs
         RFMkD/090SAbgQ4yh0iLuqrhkwSR2zpdBg6Hc+xDBlIW6XnQ+99csOv8vciwX+TS2HgI
         nNb1DIYik/628EiQri2PaN2G0qCXtPToIHB7gMPQdLGR7l1uyMJOCKlbxSs6KCf3FEHg
         KnV3u96sUq2IAE73jYJDwM+sEJmTKmBhtVQE/alfGvuEkymoXPubTmwBV7W4D9mKTy/Z
         wy3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773149812; x=1773754612;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nE3EhDDtI18KgLlHZKY3IA7GELinpJcm5bDKTBwiy0c=;
        b=qpSy25kxuXVusxjAhnMKqxipi8AjNT0NgEm1Y98W8Jh3FZfhGszAAYzaaQq9cKYfmL
         Pi3xfhexb7o6vCxAXCSz61rnbWfeoWKjLMy1Z9ZSPLBnKhI+2jM2UBJJjgtvpA3VVNAd
         GMptisaeXMSC/BoFbkYA5b4g86cR4/5wWDYAfdh5AoC5jh4Tj/vznIv4DGQlrmGmQpl8
         xDKb6RliYYHwD0eN+uVR01b7p6ZjG0PPmBCP08E5omPdaIl8BJwGII4qpS+khTNzRaeX
         WBI6ROIDvzh0z+iWcY1FtBmT0k02945HVvmOuQ2xE0lM6qmPjUIovvZXCUluwhAaHQY7
         sL4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXypV9ho8T7ASfaD9IQlgqA40Z+rlB+VBIe1VcUGior2ztjAP7btWPoKaqRUf+0NwYOiC8=@vger.kernel.org
X-Gm-Message-State: AOJu0YziHeXMa6iPMH8qc4A9ge9QHpYgO+wfCpZM1vbyom0dACqLvpEw
	L97eIv5jAX9d9lW+qT0mK6K6YchacbENN74lZ4ozmrBwi5+zmDTvbHdQ7e0rBXzdJUK6pmA+f7A
	q8PPVNwuRi5BGrh72iPHE5/2cibMg77truF126Tc=
X-Gm-Gg: ATEYQzy6silqt4ZW2uLwEllkM5QqXsnF2wohbR6XS7K5gdIndtmm9IkYDxFy6roGFnf
	hQQ3jzPoTzNSPI+0idfAKrR+bwLXOpWFDr/mcGw7BnnaDJGojkJ26caJ5zNB80rWcNj9MJPbndF
	4cJ+rYAP3If/mHwW0ag2YMgA06vYnDSX6LCD5f3GpDfW1Tqh9szouesO36CdPAXMJ8IXR+kFY5R
	/zRPOA3NCq/pBhb2rvKA+JrSVRezOhKXC7T6/Wfr90Whoq8GNCPgB5y+IMRlAxsQVaLawwHIi9v
	vOSFylvuq1pjqPuCjcMl1zZTJzaXUOCm5F1ciPgRIJC+v85r4dJpPE+TP+qvhq03s4whax5NfxT
	XLnXKRYjWL5ZfMOT49IY=
X-Received: by 2002:a05:6102:2acd:b0:5ff:befc:6769 with SMTP id
 ada2fe7eead31-5ffe610d2a8mr6388048137.19.1773149811665; Tue, 10 Mar 2026
 06:36:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2233.git.git.1773132678.gitgitgadget@gmail.com>
 <pull.2233.v2.git.git.1773140364525.gitgitgadget@gmail.com> <abAZw-Z1mKf4tAuH@pks.im>
In-Reply-To: <abAZw-Z1mKf4tAuH@pks.im>
From: Arsh Srivastava <arshsrivastava00@gmail.com>
Date: Tue, 10 Mar 2026 19:06:39 +0530
X-Gm-Features: AaiRm52Aw68j5nhrU-qdaXrK3xPk0DCO59MQDcgECBJDzCr2_2ZD6E9AeiDC6l0
Message-ID: <CAOAgETMe_yGyuaV4Eo9WDNYBa+eG-SEYDTCDoV45itNh_TE_GA@mail.gmail.com>
Subject: Re: [PATCH v2] advice: add stashBeforeCheckout advice for dirty
 branch switches
To: Patrick Steinhardt <ps@pks.im>
Cc: Arsh Srivastava via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Thank you so much for looking into my PR and i believe advice.h is
used in the add.c file. And advice really helps young developers
understand what's wrong in their files because navigating git and
trying to find solutions is very difficult, causing them to go to ai
models making them copy pasting machines.


On Tue, 10 Mar 2026 at 18:46, Patrick Steinhardt <ps@pks.im> wrote:
>
> On Tue, Mar 10, 2026 at 10:59:24AM +0000, Arsh Srivastava via GitGitGadget wrote:
> > diff --git a/advice.c b/advice.c
> > index 0018501b7b..e1264f525c 100644
> > --- a/advice.c
> > +++ b/advice.c
> > @@ -81,6 +81,7 @@ static struct {
> >       [ADVICE_SET_UPSTREAM_FAILURE]                   = { "setUpstreamFailure" },
> >       [ADVICE_SKIPPED_CHERRY_PICKS]                   = { "skippedCherryPicks" },
> >       [ADVICE_SPARSE_INDEX_EXPANDED]                  = { "sparseIndexExpanded" },
> > +     [ADVICE_STASH_BEFORE_CHECKOUT] = { "stashBeforeCheckout" },
> >       [ADVICE_STATUS_AHEAD_BEHIND_WARNING]            = { "statusAheadBehindWarning" },
> >       [ADVICE_STATUS_HINTS]                           = { "statusHints" },
> >       [ADVICE_STATUS_U_OPTION]                        = { "statusUoption" },
> > @@ -312,3 +313,29 @@ void advise_on_moving_dirty_path(struct string_list *pathspec_list)
> >                           "* Use \"git add --sparse <paths>\" to update the index\n"
> >                           "* Use \"git sparse-checkout reapply\" to apply the sparsity rules"));
> >  }
> > +
> > +void advise_on_checkout_dirty_files(struct string_list *file_list)
>
> Huh. So this patch wires up a new function and advice, but we don't ever
> seem to use it. Am I missing something?
>
> Patrick
