Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943283B297
	for <git@vger.kernel.org>; Wed, 15 May 2024 05:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715749638; cv=none; b=rNHh+XnQhtFabH0N8+67uqfxyyuZgpIb55WDEZZhV0mv9pZe8XUmYhkT10JbJAMNkEvbTBMFPlbK9nKq/Q2oQWWiIAKqMh0/0Mb4adJl7E17CKOq0NF/bx1dIN75ws999CEk7M6bkaJA3nkiyRUXCWzZETXWKpLHIRumGeTD1VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715749638; c=relaxed/simple;
	bh=tRHv5I6vSvCinqHtPzbzbEwx2yriXjy9x3dcgzzljOw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iK9xwffQyiM/wOusS/X/TedHgFmiaRPSrHnBTx/Qa41ApOWm56ZQTGszcq1eHfci5MaYqOcVwRn/K8Fd7XitJRvVZ086JEOQm9rsDgJ9jo+++VOF5YdQxggUlPXTvkLa2vEN+uEw1pVCl+SzsUBnTZzZ7F0BcCq3mURgFg+jG3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ao87JtrF; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ao87JtrF"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-36c96441a41so27740835ab.3
        for <git@vger.kernel.org>; Tue, 14 May 2024 22:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715749636; x=1716354436; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k2dS67ymURuWDK86q4uv72MlJ9ztW9bwDViVJbmLMU0=;
        b=ao87JtrFCqs3xpOoubnP1kVAIQXsrRvQpwLdZgaXptRHadkTAeUxWfHRoHxngAY+dQ
         jrwdvKI123eaYQTEd+S09Cpc8ntCMgDw/XOuSjGLaFUxQ2jYBd3pWAxoaNfGQpfug3v5
         S756GsyF0uKgmb+/HWGnn+DS2bMPZftO/5os9lJ99xPVkeuLNf1bjQuCWOrp8h/ej4fr
         +AgIUF3dTg7FCauuxlna/gVEZzIGPI9pvNeX6HX19wqH059TqOgiELldzckQkiGQk+gg
         WOCmfM2HJebSiAn2pBZCd/tc1jZSG8rKPaNX79dnCWSR0wPvdFayQj/woE86rz03PofI
         AR0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715749636; x=1716354436;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k2dS67ymURuWDK86q4uv72MlJ9ztW9bwDViVJbmLMU0=;
        b=JiDx0xrpTPbZTbCYrvkaBxnmjPQon2v7QjbrjMfmz6WWFEC+aLU9FCdmrwJnv9L5Dh
         XbjzvNv+oEo1Eszc2VuZNo8dGJZ/kmDFusDagXA0vqYC7movH+gmGDa18owT0b8YK0GJ
         4ON2i1jbOtyq/eoIVfiY9tzACw2lx52AemCNHZ67mNXzsgnEyBHJNqumB9owUhHAL+Pd
         hoqK9RRUFNo4icWeNDAaVk+ZL3U0hTCOOUvvyWj8DIGEz4BMs6uLc03lvHdpIJPPDvto
         SNMidakDoXYn5sx+7z9yUGwyXWHvmOM95W3nEbJbMb8w9EGxOzJTv0zEqs58hPfiqr6G
         AltA==
X-Gm-Message-State: AOJu0Yz5Jkehk7bvKZ44WlFi3ad/4qzUU0nlYL0sv0MKx4I3YveSXzLU
	7vfm81pGXlZERBu/wdQLpKwGMQmWb5NyC5SY1xDXEWrhj0pxlC2zfdOq98gn9Z5iPv2A6YMEACU
	Kr/ApZVtqSvdj6J/hxBmB3I4PtJZv4KAw
X-Google-Smtp-Source: AGHT+IHrV0k5gvCoO3wbGv08FrFUaREsGc8T/k2vKZ3WYzlZ3rLd0ONLFNS/2OLgdurpBmz9q0TVL/THZ1jFulQ80V8=
X-Received: by 2002:a05:6e02:1565:b0:36c:4dab:7716 with SMTP id
 e9e14a558f8ab-36cc144b143mr238463595ab.11.1715749635632; Tue, 14 May 2024
 22:07:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJsoDaEJn1Y0CgtxpkGqVRsTiDnMxjNFrtbTuUVOvT87N23JNg@mail.gmail.com>
 <13fa579b-8987-4430-967c-42b9de8acb6d@gmail.com> <CAJsoDaFhTcm0fEw3+Ba4PvTjPYxscALeLN2kBgs4YYz8Bg-R7g@mail.gmail.com>
 <CAJsoDaHu1xgfwXHqOGgctQoi5Qb5D1aESeMvaVHaQV0zjyzRRg@mail.gmail.com> <89b83e3d-dd38-4b3b-8f87-6ac739e4e12f@gmail.com>
In-Reply-To: <89b83e3d-dd38-4b3b-8f87-6ac739e4e12f@gmail.com>
From: Ondra Medek <xmedeko@gmail.com>
Date: Wed, 15 May 2024 07:07:03 +0200
Message-ID: <CAJsoDaGFh-51y4HJnmDo1t44qLR9zU2q10qoBceYCDbLEv4hZg@mail.gmail.com>
Subject: Re: Checkout to different directory at certain commit without
 changing index
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Phillip,
thanks for your insightful advice.
Ondra

On Tue, 14 May 2024 at 12:07, <phillip.wood123@gmail.com> wrote:
>
> Hi Ondra
>
> On 14/05/2024 07:29, Ondra Medek wrote:
> > Hi Phillip,
> >
> > your trick with different index file works with git checkout, too, e.g.
> >
> > GIT_INDEX_FILE="$destdir"/.git git --work-tree="$destdir" checkout -f
> > -q "$commit" -- ./
> > rm -f "$destdir"/.git
>
> I'd not thought of that, presumably "git restore" would work as well.
> Using "./" means it will only work from the repository root, you can use
> the pathmagic ":/" instead to checkout everything when it is run from a
> subdirectory  but you need to make sure GIT_INDEX_FILE is an absolute path.
>
> Best Wishes
>
> Phillip
>
> > Sincerely
> > Ondra
> >
> > On Mon, 13 May 2024 at 19:23, Ondra Medek <xmedeko@gmail.com> wrote:
> >>
> >> Hi Phillip,
> >>
> >> besides dependency on tar, I do not want to use git-archive because
> >> it's influenced by export-ignore and export-subst attributes, too (as
> >> I have mentioned).
> >>
> >> Thanks for git read-tree, seems it's exactly what I need. Just git
> >> read-tree has complained that -u switch needs -m or --reset switches.
> >> And I have simplified it to
> >>
> >> git --work-tree="$destdir" read-tree --index-output="$destdir".git -u
> >> --reset "$commit"
> >> rm -f "$destdir"/.git
> >>
> >> May I post this solution to the SO thread I have mentioned?
> >>
> >> Thanks very much
> >>
> >> Ondra
> >>
> >> On Mon, 13 May 2024 at 17:28, Phillip Wood <phillip.wood123@gmail.com> wrote:
> >>>
> >>> Hi Ondra
> >>>
> >>> On 13/05/2024 08:26, Ondra Medek wrote:
> >>>> Hello,
> >>>> I need a simple script for unskilled users to do a fast checkout (LFS
> >>>> friendly) of the current local Git clone at a certain commit to a
> >>>> different directory I.e. something like "copy at a point in history".
> >>>
> >>> I think using
> >>>
> >>>       git archive "$commit" --format=tar |
> >>>          { cd "$output_directory" && tar -xf -; }
> >>>
> >>> is probably the simplest solution. If you don't want to rely on tar then
> >>> something like
> >>>
> >>>       GIT_DIR="$(git rev-parse --path-format=absolute --git-dir)" &&
> >>>       GIT_COMMON_DIR="$(git rev-parse --path-format=absolute
> >>> --git-common-dir)" || exit
> >>>       GIT_INDEX_FILE="$GIT_DIR/tmp-index-$$"
> >>>       export GIT_DIR GIT_COMMON_DIR GIT_INDEX_FILE
> >>>       unset GIT_WORK_TREE
> >>>       mkdir "$output_directory" && cd "$output_directory" &&
> >>>       git read-tree -u "$commit"
> >>>       status=$?
> >>>       rm "$GIT_INDEX_FILE"
> >>>       exit $status
> >>>
> >>> Which uses a temporary index file should work (note I haven't tested
> >>> it). You may want to add "--recurse-submodules" and/or
> >>> "--no-sparse-checkout" to the "git read-tree" commandline.
> >>>
> >>> Best Wishes
> >>>
> >>> Phillip
> >>>
> >>>> IMO all possible solutions are summarized in this thread
> >>>> https://stackoverflow.com/questions/160608/do-a-git-export-like-svn-export
> >>>> I describe some of them with my remarks:
> >>>>
> >>>> - git checkout-index : works with HEAD only.
> >>>> - git archive: influenced by export-ignore and export-subst
> >>>> attributes, so may not produce exact copy of sources. (And needs tar).
> >>>> - git worktree add -d : needs cleanup: git prune or git remove.
> >>>> - git clone: Unfortunately, -b param cannot work with commit hash and
> >>>> does not respect local worktree settings (e.g. autocrlf). So, a
> >>>> solution may be a bit complicated: git clone -s -n . dest/path ; cp
> >>>> .git/config dest/path/.git ; cd dest/path ; git co -q <commit-ish> ;
> >>>> rm -rf .git
> >>>> - git checkout: Unfortunately, modifies Git index, so some action to
> >>>> revert index is necessary after: git --work-tree=/path/to/checkout/
> >>>> checkout -f -q <tree-ish> -- ./
> >>>>
> >>>> For me, the best solution is with git clone, because it does not
> >>>> modify Git index nor any source working tree settings, so no cleanup
> >>>> is necessary. But it's a bit complicated, though. It seems to me that
> >>>> "git checkout" could do this better and simpler if it would have some
> >>>> param to not modify the Git index. Is it possible to enhance git
> >>>> checkout? Or is there any other simple solution not mentioned in the
> >>>> SO thread?
> >>>>
> >>>> Thank you
> >>>> Ondra Medek
> >>>>
