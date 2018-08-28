Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 240F81F404
	for <e@80x24.org>; Tue, 28 Aug 2018 15:35:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbeH1T13 (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 15:27:29 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:44931 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbeH1T13 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 15:27:29 -0400
Received: by mail-ua1-f67.google.com with SMTP id m11-v6so1256221uao.11
        for <git@vger.kernel.org>; Tue, 28 Aug 2018 08:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jIP0h6LwYCqDZyxnE7Oyk6zMJE+tp3zLi07VKud6KbQ=;
        b=vdDmDH22Y8lLPbERYIAFS/oEijkKqZE6pDVOd7FA9wBhs016+E6gV3xjUFi5U4S9y+
         IytuannqmQPHYdb+abBC8MKjeRkwL+xVBlDNlAqGSF2D+5cGOvni4C36oHtKL/CQS+hy
         78IH8oHyVJdfwABzEGNkxoDGPwZeZQ2JYp8f98tmz1cgo0kmT84xoYQa689sr0HsX6W3
         HC/vXacjA3fpq7T+LUprK6t78khT2lyafTslr6at611bU12Xnn1sPe35Xcv1QjPGsvzd
         ISECCrMPMXjx99XBmLyTUf9QL5hiXw3Bk7kH358leSPfk+ZoGcTNk10Hn8HPdsuFP7aA
         SAEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jIP0h6LwYCqDZyxnE7Oyk6zMJE+tp3zLi07VKud6KbQ=;
        b=p0bZ7Owro6p+tbM54D+eYjGqJNCTsI/4C7ctIxBA6ajhzBmGxX8UBXSzmIeKOSicPY
         AF6XUENg2bsXqfTmJTotw1Bl3h+tq1VW3ONBzgH4q1xHCDa75R5XpXt0kkiv9kL0fsP5
         JM/Cmic1YMoFDEErUlSWI0F6EZryze1qFTbZ9AChUzx3l67nlkT8hSjULWDgZM8utIA5
         Kti0f7TbDgaiUKs1pWkOe5EIyPYkdQBq4PuYm9IjYZS8BV6sB8wU4namapp957DHxlsL
         8AN0g5/ElMB4bG54TlAvD4KnCnDLdq/x5W63Zy0UrnPSkW8CN4pgdLXy9lXcFNgJD/g1
         atMg==
X-Gm-Message-State: APzg51C+nVnt4W5MlDuli02GrQHmKb/mymsSlFDne0DIUQayCt8ATQoL
        iM9q5Ke2YBoyZ8bqrPAAVvp21Pnf0a0UmI8GwQg=
X-Google-Smtp-Source: ANB0VdZQcO01v5hKsRVCWQ0W6YpxFXO2LlWHau6vnKgvtraf1y+TDExZnyqk98zrvpCqr+4/wabeMlpy7Ly9pie73jQ=
X-Received: by 2002:ab0:5507:: with SMTP id t7-v6mr1412533uaa.100.1535470516064;
 Tue, 28 Aug 2018 08:35:16 -0700 (PDT)
MIME-Version: 1.0
References: <679370A8-E477-450D-96E5-6B1869D27576@gmail.com>
 <87in3ueiks.fsf@evledraar.gmail.com> <nycvar.QRO.7.76.6.1808281532220.16620@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1808281532220.16620@tvgsbejvaqbjf.bet>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 28 Aug 2018 08:35:03 -0700
Message-ID: <CABPp-BENB=mqfFU4FGb2OS9VDV=9VdT71HhFLZwtyxD8MpdTMQ@mail.gmail.com>
Subject: Re: A rebase regression in Git 2.18.0
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
        corrmage@gmail.com, Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 28, 2018 at 6:33 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Tue, 28 Aug 2018, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> > On Tue, Aug 28 2018, Nikolay Kasyanov wrote:
> >
> > > I=E2=80=99ve found something that may be a regression in git rebase i=
mplementation in 2.18.0.
> > > First I spotted it on macOS but I can also confirm it happening on Li=
nux.
> > > Git 2.19.0.rc0.48.gb9dfa238d is affected too.
> > >
> > > In order to trigger it, a repo layout similar to the following is req=
uired:
> > >
> > > files/
> > >     file1
> > >     file2
> > >     file3
> > >     file4
> > >     file5
> > > project
> > >
> > > Let=E2=80=99s call this state baseline. Then, in a branch, let=E2=80=
=99s edit project file and move file3 to nested/files subdirectory, here=E2=
=80=99s the final layout:
> > >
> > > files/
> > >     file1
> > >     file2
> > >     file4
> > >     file5
> > > nested/
> > >     files/
> > >             file3
> > > project
> > >
> > > Let=E2=80=99s get back to master and also edit project file to cause =
a conflict. After that trying to rebase the branch upon master will cause t=
he following git status output:
> > >
> > > rebase in progress; onto baf8d2a
> > > You are currently rebasing branch 'branch' on 'baf8d2a'.
> > >   (fix conflicts and then run "git rebase --continue")
> > >   (use "git rebase --skip" to skip this patch)
> > >   (use "git rebase --abort" to check out the original branch)
> > >
> > > Changes to be committed:
> > >   (use "git reset HEAD <file>..." to unstage)
> > >
> > >     renamed:    files/file1 -> nested/files/file1
> > >     renamed:    files/file2 -> nested/files/file2
> > >     renamed:    files/file3 -> nested/files/file3
> > >     renamed:    files/file4 -> nested/files/file4
> > >     renamed:    files/file5 -> nested/files/file5
> > >
> > > Unmerged paths:
> > >   (use "git reset HEAD <file>..." to unstage)
> > >   (use "git add <file>..." to mark resolution)
> > >
> > >     both modified:   project
...
> > >
> > > Here=E2=80=99s a ready-to-use repository: https://github.com/nikolayk=
asyanov/git-rebase-bug.
> >
> > Thanks for the test case. This bisects down to 9c0743fe1e
> > ("merge-recursive: apply necessary modifications for directory renames"=
,
> > 2018-04-19) first released as part of 2.18.0.
> >
> > I have not dug to see if the behavior change is desired or not, that
> > commit changed the results of a bunch of test cases, maybe it was
> > intended. Elijah?
>
> I think this was already mentioned before, in a different mail thread:
> have you tried whether `git rebase -m` fixes that behavior?

I'm not aware of a previous mention, but yes, using a rebase type
other than the default am one (either -m or -i) will fix this.  (I did
previously bring up that am-based rebase would fail to detect
directory renames, due to not even calling in to the recursive merge
machinery in many cases[1].  But this is an example of am-based rebase
doing the opposite -- detecting a directory rename where there is
none, which had never occurred to me until seeing this report.)


I'm pretty sure this is a bad interaction between the
build_fake_ancestor() stuff and directory rename detection.  You see,
you *think* the following three commits are being merged:

Base: files/{file1,file2,file3,file4,file5}, project_v1
branch: files/{file1,file2,file4,file5}, nested/files/file3, project_v2
master: files/{file1,file2,file3,file4,file5}, project_v3

But the default rebase (via builtin/am) does NOT do that.  It instead
merges the following trees:

Base: files/file3, project_v1
branch: nested/files/file3, project_v2
master: files/{file1,file2,file3,file4,file5}, project_v3


To the recursive machinery, that looks an awful lot like "branch"
renamed files/ -> nested/files/, and that master just added a bunch of
paths (file[1245]) into the files/ directory.  From this view, what
merge-recursive did was correct, it's just that rebase/am fed it
information that doesn't quite match what should really be merged.

Possible fixes:
  - Change builtin/am.c:fall_back_threeway() to use actual commit
trees when available instead of building fake minimal ones.  (One of
the problems with am, is that the "base" commit may not exist in the
current repo, so there's an issue here with threading information from
rebase down to am.)
  - Add a flag to turn off directory rename detection, and set the
flag for every call from am.c in order to avoid problems like this.

The first option might be a bit nicer for the end-user, but would only
help when am is called from rebase; when running `git am` directly,
things would get pretty messy.  So we might need the second option
anyway.  Since we're in -rc for 2.19, we should probably just go for
the second option.  I'll try to put together some patches this
evening.


[1] https://public-inbox.org/git/20180607171344.23331-4-newren@gmail.com/
