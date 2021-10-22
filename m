Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E989CC433EF
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 22:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD3E26135A
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 22:41:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233793AbhJVWnZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 18:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231730AbhJVWnZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 18:43:25 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D34F5C061766
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 15:41:06 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id x192so417626lff.12
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 15:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WprnlkcXszcykiydt/c7YA5R67cNuHkaLSEySTOTiOc=;
        b=otToA6jMKpq4U/a9fEFGOHw4s38KkV165yweUla0xkXgyEq9hweFaJqcFnT163W3BQ
         K3weNSIvA9qWXITEV6DTWnkR5plU1OzoGYqqPP0q395AAs00uNrs8lnlMtPzN3X8FRg5
         +wlUJxFaT44QhPqmVaYqO/YWdb1Zbo6eSHxIqzLwel6b7sADV9cO0EyrryRKrKWLlVe1
         RNOsMhbLJ1UCBrMiQDKzje+wIvs7qHjnQFbma0WbnKP1X5A0RcRGMErwb5F4Mf1bcy6l
         bWAzQqiTtBtLD1FACvm6BXqk2Zzld2bceUHXpD27uqqRi6ppBpPzbUZuMLqHxyAI7FyI
         81Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WprnlkcXszcykiydt/c7YA5R67cNuHkaLSEySTOTiOc=;
        b=nUnThynjzhyamcsdfMwF2FyHEcguWsqrhSzGV3a4SNEHQY47x4RFjTX/U455WRJU68
         aA89tFZ8Q2t5IU9+wsA490FlMJXC6q6rkFNp1VpeIaANhq6MNRayws32H4pzxZ2KOTp9
         9z5/6qMhQGo02tynApafAJu+kFWKcCr/9iL49gk5sxRB3hUt+XCh/1ILB0XEZNSpQHIL
         fTKJKtOoolhHf6XPXMAa8rMftA99bxp2ViZfQ1gS3PqQDC0M+wL805NoHLg47WY2bxLP
         JD5h5KP+UKGHYhOSe7TahZbW/Jo9XVoPdCb4IINhdjTVPc0rSonXSfP2j6fALgCBy8um
         KwuA==
X-Gm-Message-State: AOAM533kQZuWiS9EDSHhWUtq82Fk1/koV9puquJGO3j3uQTJaTGgM6dF
        hA06LTafaCSsau5gZGdUbzkDah1xDdA+yPio3M2KtZitqqc=
X-Google-Smtp-Source: ABdhPJwFUgr+uTwgCDuEN2EV4zIrf0zAoL1XTns9bY5ZrHMtgIR06vbZZ7CeLPWyHD0Q20IdEJyUsGP+TqTsLA8YYlk=
X-Received: by 2002:a05:6512:142:: with SMTP id m2mr716557lfo.125.1634942464992;
 Fri, 22 Oct 2021 15:41:04 -0700 (PDT)
MIME-Version: 1.0
References: <fcf288fc-72b7-964c-e462-496066528c7b@opentransactions.org> <YXLro/8c1Feg6TcN@kitchen>
In-Reply-To: <YXLro/8c1Feg6TcN@kitchen>
From:   Matheus Tavares <matheus.bernardino@usp.br>
Date:   Fri, 22 Oct 2021 19:40:53 -0300
Message-ID: <CAHd-oW50puNCrYTQhR4qffgtP6-wJerWLhmhCV+nYcLVNu+CBg@mail.gmail.com>
Subject: Re: gitignore as symbolic link
To:     Rene Kita <mail@rkta.de>
Cc:     Justus Ranvier <justus@opentransactions.org>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 22, 2021 at 1:57 PM Rene Kita <mail@rkta.de> wrote:
>
> On Thu, Oct 21, 2021 at 05:07:44PM -0800, Justus Ranvier wrote:
> > I have several repositories where the top level .gitignore file is a
> > symbolic link to the actual file which is contained in a submodule which all
> > the repositories share.
> >
> > This worked fine up to and including version 2.31.1 but as of 2.32.0 running
> > any command which would cause .gitignore to be read results in a "too many
> > levels of symbolic links error" and git behaves as if .gitignore is not
> > present.
> >
> This was fixed in commit a185dd58ecc17f2ea16985d59c9bb7b09bec7775 [1].

Hmm, the behavior Justus described is actually related to another
change. Since v2.32.0, git no longer follows ".gitattributes",
".gitignore" and ".mailmap" if they are symbolic links. It does that
by open()-ing these files with the O_NOFOLLOW flag, which returns
ELOOP ("too many levels of symbolic links error") when the basename is
a symlink. So the behavior you experienced is actually not a bug, but
an intended change.

For a full explanation please see a2ef579e261 ("attr: do not respect
symlinks for in-tree .gitattributes", 2021-02-16) [2] and feb9b7792f
("exclude: do not respect symlinks for in-tree .gitignore",
2021-02-16) [3].

But the short version is: git accesses these files either from the
working tree or the object store (think, e.g. a bare repo). Git never
follows symlinks in the second case, so following them on the working
tree was an inconsistent behavior which was fixed. (This also has a
security implication, in the sense that it could be dangerous to
follow symlinks that lead to paths outside the repository.)

Note that "core.excludesFile" and "$GIT_DIR/info/exclude" are still
allowed to be symlinks.

[2]: https://github.com/git/git/commit/2ef579e261
[3]: https://github.com/git/git/commit/feb9b7792f

> [1] https://lore.kernel.org/git/xmqqlf83h2a7.fsf@gitster.g/
