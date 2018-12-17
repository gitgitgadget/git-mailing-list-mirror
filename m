Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6ED431F405
	for <e@80x24.org>; Mon, 17 Dec 2018 17:18:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbeLQRSA (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Dec 2018 12:18:00 -0500
Received: from mail-vs1-f42.google.com ([209.85.217.42]:39779 "EHLO
        mail-vs1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbeLQRSA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Dec 2018 12:18:00 -0500
Received: by mail-vs1-f42.google.com with SMTP id h78so8179924vsi.6
        for <git@vger.kernel.org>; Mon, 17 Dec 2018 09:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4DUZU6FCsyUWOMi4frYEurS7znpqSh8pehOcpQ1yVcs=;
        b=G+0K/95xkuzQscTPi+mSXfniXA0iT5KDblRFmeeMLU7ZGrl5Z2ZucEGgNheemmT7OF
         jedX4fKxPl0XjMKmgg4X5ENkcY8HP/TAB09RYNEOaoOtufFwdlaA+/HufDcSTNoNpRqX
         M6PnYPR2E5/6j794Qauu84VMw/EiL/hAlTeRxhNNJta3ykRan8Cnpwzz/+WQYTgfoLbG
         GLHTEd0X0qErPo1jiYdjepgEo+4L9kpxIYevKf0Ln+ARyKvARGeJYab855srD4lHRmMi
         17TZEf+ZN0fiDItIk0jgUeOghTUNVqR6y7o+SA6LhlKdgEp82vOqsDVIEP10JwwdgH45
         uCpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4DUZU6FCsyUWOMi4frYEurS7znpqSh8pehOcpQ1yVcs=;
        b=AsciVPrvfU5K6TFMcQn8REMtU10z5QuEeRtXdGZm7dHkuz5gbAHh4vwjl/ZtqsLAMW
         0imU19zOGL16eC1mTiZvClVLLp+V4IrEX+xc3Ncrc6lyoye3Mz/v8evaw8WRnhEQtuiD
         vNY4fTAcCIVJm7nZlYztCoYiM7MIiDkyiV8ueW6q0AT3qyqZFzaXXhTgabeeCNQ3X0w0
         UxT4ej94XvgNl1i3xNihnF6DsGA7lbhyHNRSB/z5Ge8LHkTiTa2f+EvKpkoSsuocKQ2b
         yNrfyJFfsUxeiF/AAyHZs4LnFzoaSycKGRTu13G9nXaOJujEiDdWuB/GeP8WXOF+A/p5
         mbIQ==
X-Gm-Message-State: AA+aEWY4DcVDsNfT4oUj5Icmqg6Ey/9OeQKw9a2zp03pTCgFEO9/Yp6s
        /x3To8TjuAu9RjPPdDMNwyAFGH7xNYwfBkVIjp0=
X-Google-Smtp-Source: AFSGD/XY4foBOkPTXojzzWgo4IoG0b+6ktlRFlZiTAbl52H6JGraCot1jZQmHo+k8dwZzNbdlunNzfWvmWsS2aJ7/zo=
X-Received: by 2002:a67:f696:: with SMTP id n22mr6746547vso.175.1545067078552;
 Mon, 17 Dec 2018 09:17:58 -0800 (PST)
MIME-Version: 1.0
References: <CAG2YSPzmN5u1uAPVbjsqC3LzVVinFR21-_6wfrkBHdPWhOfMfQ@mail.gmail.com>
 <CACsJy8ANoiWfmLkmO9ACab5H+m2c2y5uhKBJzGNwwxcs9zV0wA@mail.gmail.com>
In-Reply-To: <CACsJy8ANoiWfmLkmO9ACab5H+m2c2y5uhKBJzGNwwxcs9zV0wA@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 17 Dec 2018 09:17:46 -0800
Message-ID: <CABPp-BE9+qqVfccwzofD0qFecTGo2EjighNSu0vh-rF_8F5PoA@mail.gmail.com>
Subject: Re: Can git tell me which uncommitted files clash with the incoming changes?
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Mark Kharitonov <mark.kharitonov@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 17, 2018 at 8:26 AM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Mon, Dec 17, 2018 at 2:11 PM Mark Kharitonov
> <mark.kharitonov@gmail.com> wrote:
> >
> > Hi,
> > I have asked this question on SO
> > (https://stackoverflow.com/questions/53679167/can-git-tell-me-which-unc=
ommitted-files-clash-with-the-incoming-changes)
> > and usually there are tons of responses on Git questions, but not on
> > this one.
> >
> > Allow me to quote it now.
> >
> > Please, observe:
> >
> >     C:\Dayforce\test [master =E2=86=932 +0 ~2 -0 !]> git pull
> >     error: Your local changes to the following files would be
> > overwritten by merge:
> >             2.txt
> >     Please commit your changes or stash them before you merge.
> >     Aborting
> >     Updating 2dc8bd0..ea343f8
> >     C:\Dayforce\test [master =E2=86=932 +0 ~2 -0 !]>
> >
> > Does git have a command that can tell me which uncommitted files cause
> > the this error? I can see them displayed by git pull, but I really do
> > not want to parse git pull output.
>
> Assume that you have done "git fetch origin" (or whatever master's
> upstream is). Do
>
> git diff --name-only HEAD origin/master
>
> You get the list of files that will need to be updated. Do
>
> git diff --name-only

Are you assuming that `git diff --cached --name-only` is empty?  If it
isn't, that alone will trigger a failure (unless using an esoteric
merge strategy or an older version of git), so this assumption is
fairly reasonable to make.  But it may be worth being explicit about
for external readers.

> to get the list of files that have local changes. If this list shares
> some paths with the first list, these paths will very likely cause
> "git pull" to abort.
>
> For a better check, I think you need to do "git read-tree -m" by
> yourself (to a temporary index file with --index-output) then you can
> examine that file and determine what file has changed compared to HEAD
> (and if the same file has local changes, git-pull will be aborted).
> You may need to read more in read-tree man page.
>
> Ideally though, git-read-tree should be able to tell what paths are
> updated in "--dry-run -u" mode. But I don't think it's supported yet.

merge-recursive currently uses unpack_trees to do this "files would be
overwritten by merge" checking, so the suggestion of read-tree (which
also uses unpack_trees) makes sense.  BUT ... the error checking in
unpack_trees has both false positives and false negatives due to not
understanding renames, and it is somewhat of a nightmarish mess.  See
[1] for details.  Further, I think it warns in cases that shouldn't be
needed (both sides of history modified the same file, with the
modifications on HEAD's side being a superset of the changes on the
other side, in such a way that 3-way content merge happens to match
what is in HEAD already).  So, while the suggestions made so far give
some useful approximations, it's an approximation that will get worse
over time.  I don't have a better approximation to provide at this
time, though.


Elijah

[1] https://public-inbox.org/git/20171124195901.2581-1-newren@gmail.com/
, starting at "Note that unpack_trees() doesn't understand renames"
and running until "4-way merges simply cause the complexity to
increase with every new capability."
