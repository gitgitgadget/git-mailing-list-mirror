Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5D9199B0
	for <git@vger.kernel.org>; Mon, 13 May 2024 17:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715621011; cv=none; b=HZgnyhffl+QjB8FUTcVahX0lykjWhGsBYYulTzPsHZokhIrYBScUeLLefa2ocjJ9TlmIdEfl87yZMgi3AVeB+fYt3HJvXDxOL/ZjEIZR5LbeKs8U4GdT4+Y/L9wLEiCnKs8AqGGtoy4mNGQHyOzDg297zZgwMZwil2QoJ7m6/IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715621011; c=relaxed/simple;
	bh=pnb5oW9Ta14XmARRTZJyTYta1k60B/Bd7VkqsHjkPhs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hnqRG8aWdgiAPml1wYQWZ2tUSPkHTfEU2GCR8pIlSlU3qksPf+3ZBmh0BEJvms0SU4D317oFIjjmI6dD0KqBhSggQiDjD+ZUq40Wij/gJ3cXULR006zwVLsEdHulXa8klhQ4ZHURX+uAc4QfWYMQTUHRoEV0xe1u9rnf/8+rols=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oo65jYF5; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oo65jYF5"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-36c67760b1aso22498885ab.1
        for <git@vger.kernel.org>; Mon, 13 May 2024 10:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715621009; x=1716225809; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3s40G4YU7mzOZaQx4bz/KS8hYAaUS72w9uTQtAqw/+U=;
        b=Oo65jYF5sgxtdBp225ow/qdpAa2TJR92XBytE5+00QpEL/kvhgPFdgegCxSfO8K2b6
         RdQ10je6JFBrq2uVYQFG8fyCNgI0b/4pad660Ici7VkYWCeRF5poKgTWpKI4DHp6ZuJc
         jqLBeu313bATVNOOYBRUlBmvJAc85hfaEEtlkoGwMU5yl10+55LtSlxQ1M0e98PrTHT7
         TZfXYTZY5Jm8P654R+fTuqIVlT7VU1EZvLrh8fSLnTSSQTQXvog9To/7vJMcuc8bwGeN
         4qT1kBR04ATBsmgBI2do3DwXAaTHLX/WsKcLKSGFTtS8ArZvQ/rVkNMbZp8wJut/BiPd
         v4EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715621009; x=1716225809;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3s40G4YU7mzOZaQx4bz/KS8hYAaUS72w9uTQtAqw/+U=;
        b=KnQ6sIVuaar0keb6MexOi7Qtbd3a6ai9ZnZkQKzShArbZVBAUacTo0zfr2yzhurh1/
         ewoYfNuU9vsvjR8YlGIpOnFpCATr2H6kyMuhuROq8ySkZB1GhZUusv8LbpnJhygnhCVa
         D/JaHMVr8tm7A9HjzdvnZnebnd8Mn+BNHC521PbyWz40eKRdxXwgXg0AkM/tiOZXezUY
         Tl8Uizcr1jJeIFRrvoxHAG5L6TYeGfMmuMTgnc5IdasL8/QKrtgpFRqQDu+FBIA0ougu
         9nacSt/rgpOz5zmUp1T653hc0HwXP3c7xAq/dva1/3QLPAjHV6Ewf2jZgQVLVk/eicSq
         shbw==
X-Gm-Message-State: AOJu0Yyiv91WPxSpimH/L17TXZd1B/iwpfdp6vFVhurpJh+sMrTi/9Xs
	6fRn+sf56Zs5x8BPBfC0vDGpvsX73ztJnfhhDl+EnuhEF9wd+qh4JAWyER8IBatGHbKpmqxFjQH
	XpQAPdWZZAkTYilTindEiGsoTVumidg==
X-Google-Smtp-Source: AGHT+IF2Qt5fdh7ZHQQX8tHaxXWS6K1SkLC6oJm1AzLEnfyaJSB6jy692BMKIXXwUt8a4x4EO3QaIrC4XalOQ9EWy2o=
X-Received: by 2002:a05:6e02:1846:b0:36b:3b10:7419 with SMTP id
 e9e14a558f8ab-36cc16f8780mr121725185ab.32.1715621008783; Mon, 13 May 2024
 10:23:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJsoDaEJn1Y0CgtxpkGqVRsTiDnMxjNFrtbTuUVOvT87N23JNg@mail.gmail.com>
 <13fa579b-8987-4430-967c-42b9de8acb6d@gmail.com>
In-Reply-To: <13fa579b-8987-4430-967c-42b9de8acb6d@gmail.com>
From: Ondra Medek <xmedeko@gmail.com>
Date: Mon, 13 May 2024 19:23:17 +0200
Message-ID: <CAJsoDaFhTcm0fEw3+Ba4PvTjPYxscALeLN2kBgs4YYz8Bg-R7g@mail.gmail.com>
Subject: Re: Checkout to different directory at certain commit without
 changing index
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Phillip,

besides dependency on tar, I do not want to use git-archive because
it's influenced by export-ignore and export-subst attributes, too (as
I have mentioned).

Thanks for git read-tree, seems it's exactly what I need. Just git
read-tree has complained that -u switch needs -m or --reset switches.
And I have simplified it to

git --work-tree="$destdir" read-tree --index-output="$destdir".git -u
--reset "$commit"
rm -f "$destdir"/.git

May I post this solution to the SO thread I have mentioned?

Thanks very much

Ondra

On Mon, 13 May 2024 at 17:28, Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> Hi Ondra
>
> On 13/05/2024 08:26, Ondra Medek wrote:
> > Hello,
> > I need a simple script for unskilled users to do a fast checkout (LFS
> > friendly) of the current local Git clone at a certain commit to a
> > different directory I.e. something like "copy at a point in history".
>
> I think using
>
>      git archive "$commit" --format=tar |
>         { cd "$output_directory" && tar -xf -; }
>
> is probably the simplest solution. If you don't want to rely on tar then
> something like
>
>      GIT_DIR="$(git rev-parse --path-format=absolute --git-dir)" &&
>      GIT_COMMON_DIR="$(git rev-parse --path-format=absolute
> --git-common-dir)" || exit
>      GIT_INDEX_FILE="$GIT_DIR/tmp-index-$$"
>      export GIT_DIR GIT_COMMON_DIR GIT_INDEX_FILE
>      unset GIT_WORK_TREE
>      mkdir "$output_directory" && cd "$output_directory" &&
>      git read-tree -u "$commit"
>      status=$?
>      rm "$GIT_INDEX_FILE"
>      exit $status
>
> Which uses a temporary index file should work (note I haven't tested
> it). You may want to add "--recurse-submodules" and/or
> "--no-sparse-checkout" to the "git read-tree" commandline.
>
> Best Wishes
>
> Phillip
>
> > IMO all possible solutions are summarized in this thread
> > https://stackoverflow.com/questions/160608/do-a-git-export-like-svn-export
> > I describe some of them with my remarks:
> >
> > - git checkout-index : works with HEAD only.
> > - git archive: influenced by export-ignore and export-subst
> > attributes, so may not produce exact copy of sources. (And needs tar).
> > - git worktree add -d : needs cleanup: git prune or git remove.
> > - git clone: Unfortunately, -b param cannot work with commit hash and
> > does not respect local worktree settings (e.g. autocrlf). So, a
> > solution may be a bit complicated: git clone -s -n . dest/path ; cp
> > .git/config dest/path/.git ; cd dest/path ; git co -q <commit-ish> ;
> > rm -rf .git
> > - git checkout: Unfortunately, modifies Git index, so some action to
> > revert index is necessary after: git --work-tree=/path/to/checkout/
> > checkout -f -q <tree-ish> -- ./
> >
> > For me, the best solution is with git clone, because it does not
> > modify Git index nor any source working tree settings, so no cleanup
> > is necessary. But it's a bit complicated, though. It seems to me that
> > "git checkout" could do this better and simpler if it would have some
> > param to not modify the Git index. Is it possible to enhance git
> > checkout? Or is there any other simple solution not mentioned in the
> > SO thread?
> >
> > Thank you
> > Ondra Medek
> >
