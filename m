Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6735E1F405
	for <e@80x24.org>; Mon, 17 Dec 2018 19:37:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732887AbeLQThe (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Dec 2018 14:37:34 -0500
Received: from mail-it1-f181.google.com ([209.85.166.181]:50227 "EHLO
        mail-it1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388356AbeLQThe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Dec 2018 14:37:34 -0500
Received: by mail-it1-f181.google.com with SMTP id z7so666702iti.0
        for <git@vger.kernel.org>; Mon, 17 Dec 2018 11:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LdMigJEKpBOIQkoZm97ubPl7VC/BxaCVZmdIZmaRLwE=;
        b=FOmSbogkZuY7zKd+MozhOM5fEvdudTroo4wwp6HzfN+IG4mioZkjRu+jKUn7SSprN6
         G1MXWj4BGd6lVryv3t9q3Fht+i5MaCPAMJMR7v0Gz6tTKy2i3D/7TkpwZNagBlGDiRPU
         X2kK22jaqz3FoaPIp60YzeZgwV7UoZ6BLh1Y5uaR8bWiFYzuVTCRImsvfl96CUuAl4tL
         0dioWJigMpMAyBv1H++U6oWOXlhSZYBOEnv+jgbZKC3Zm2AxBG/+S+Sl3rNsVZGoo6+l
         iU8BtFQvG/69H1o5zpY7JFB+FXV7lux3ckodkXIIDsUNIWSUXW8nllSs65Rt+XDgcZHI
         tRKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LdMigJEKpBOIQkoZm97ubPl7VC/BxaCVZmdIZmaRLwE=;
        b=AEF3w1AxLemJfylM4dFKpRCuZAVU4AYLSqyfaySGr+NcCFWwBp0LDTEXf6shjBagxp
         a9Aa19UGh5Q9TR0cuwVGkv3sUqDdsmEOE/PeiEE67KPwfrzBhO5BHb0DsOs7N9/9U08K
         W2Q3Bfqf6lNBRs3NgY14o/Lw+DIdoilrMGXRjEPleVDL1VOYQwaUa0TwVsu2E/BxsNFY
         F8j1n9j8my1zSJYnQE4Mxn+jy7CasPYtrre1KpfPURhMpl8/PlC9K86rryL2xB9gF+Bc
         GaBY9/9fNrLMctc2M6dye4V80xnw5e5j5bQfOuwp34WFKte/i5CQhJVrcVNAd+Z2UpI4
         MdFw==
X-Gm-Message-State: AA+aEWYTz2NoUOSvX9MaAYg4AV/ACXTF+rqXgKQ37JKrh6F4593w4Mvs
        2az6B9RqiMRGFupBCIi168+bNk6O9ah6Yx5sCcM=
X-Google-Smtp-Source: AFSGD/Xg8rWl6YL3HpxLX+POkoKMiSm/6KNs0kURm0KXX0p+/GQrR0f/G3EUcwC1x3ghzh48CcA/Z2zUqzUQ1fjqnd0=
X-Received: by 2002:a05:660c:81a:: with SMTP id j26mr424113itk.70.1545075453127;
 Mon, 17 Dec 2018 11:37:33 -0800 (PST)
MIME-Version: 1.0
References: <CAG2YSPzmN5u1uAPVbjsqC3LzVVinFR21-_6wfrkBHdPWhOfMfQ@mail.gmail.com>
 <CACsJy8ANoiWfmLkmO9ACab5H+m2c2y5uhKBJzGNwwxcs9zV0wA@mail.gmail.com> <CABPp-BE9+qqVfccwzofD0qFecTGo2EjighNSu0vh-rF_8F5PoA@mail.gmail.com>
In-Reply-To: <CABPp-BE9+qqVfccwzofD0qFecTGo2EjighNSu0vh-rF_8F5PoA@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 17 Dec 2018 20:37:06 +0100
Message-ID: <CACsJy8BFoK4hoXrSUi+P3xB1LumevvFe6XWAM2fLUq-UGNUs8A@mail.gmail.com>
Subject: Re: Can git tell me which uncommitted files clash with the incoming changes?
To:     Elijah Newren <newren@gmail.com>
Cc:     Mark Kharitonov <mark.kharitonov@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 17, 2018 at 6:17 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Mon, Dec 17, 2018 at 8:26 AM Duy Nguyen <pclouds@gmail.com> wrote:
> >
> > On Mon, Dec 17, 2018 at 2:11 PM Mark Kharitonov
> > <mark.kharitonov@gmail.com> wrote:
> > >
> > > Hi,
> > > I have asked this question on SO
> > > (https://stackoverflow.com/questions/53679167/can-git-tell-me-which-u=
ncommitted-files-clash-with-the-incoming-changes)
> > > and usually there are tons of responses on Git questions, but not on
> > > this one.
> > >
> > > Allow me to quote it now.
> > >
> > > Please, observe:
> > >
> > >     C:\Dayforce\test [master =E2=86=932 +0 ~2 -0 !]> git pull
> > >     error: Your local changes to the following files would be
> > > overwritten by merge:
> > >             2.txt
> > >     Please commit your changes or stash them before you merge.
> > >     Aborting
> > >     Updating 2dc8bd0..ea343f8
> > >     C:\Dayforce\test [master =E2=86=932 +0 ~2 -0 !]>
> > >
> > > Does git have a command that can tell me which uncommitted files caus=
e
> > > the this error? I can see them displayed by git pull, but I really do
> > > not want to parse git pull output.
> >
> > Assume that you have done "git fetch origin" (or whatever master's
> > upstream is). Do
> >
> > git diff --name-only HEAD origin/master
> >
> > You get the list of files that will need to be updated. Do
> >
> > git diff --name-only
>
> Are you assuming that `git diff --cached --name-only` is empty?  If it
> isn't, that alone will trigger a failure (unless using an esoteric
> merge strategy or an older version of git), so this assumption is
> fairly reasonable to make.  But it may be worth being explicit about
> for external readers.

Actually I think Jeff's suggestion may be better since he compares
worktree with HEAD and should catch everything.

> > to get the list of files that have local changes. If this list shares
> > some paths with the first list, these paths will very likely cause
> > "git pull" to abort.
> >
> > For a better check, I think you need to do "git read-tree -m" by
> > yourself (to a temporary index file with --index-output) then you can
> > examine that file and determine what file has changed compared to HEAD
> > (and if the same file has local changes, git-pull will be aborted).
> > You may need to read more in read-tree man page.
> >
> > Ideally though, git-read-tree should be able to tell what paths are
> > updated in "--dry-run -u" mode. But I don't think it's supported yet.
>
> merge-recursive currently uses unpack_trees to do this "files would be
> overwritten by merge" checking, so the suggestion of read-tree (which
> also uses unpack_trees) makes sense.  BUT ... the error checking in
> unpack_trees has both false positives and false negatives due to not
> understanding renames, and it is somewhat of a nightmarish mess.  See
> [1] for details.  Further, I think it warns in cases that shouldn't be
> needed (both sides of history modified the same file, with the
> modifications on HEAD's side being a superset of the changes on the
> other side, in such a way that 3-way content merge happens to match
> what is in HEAD already).  So, while the suggestions made so far give
> some useful approximations, it's an approximation that will get worse
> over time.

Ah.. dang. I guess we need "git merge --dry-run" then :)

> I don't have a better approximation to provide at this
> time, though.
>
>
> Elijah
>
> [1] https://public-inbox.org/git/20171124195901.2581-1-newren@gmail.com/
> , starting at "Note that unpack_trees() doesn't understand renames"
> and running until "4-way merges simply cause the complexity to
> increase with every new capability."



--=20
Duy
