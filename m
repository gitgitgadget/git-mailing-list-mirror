Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN:  
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3F131F405
	for <e@80x24.org>; Mon, 17 Dec 2018 22:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732221AbeLQWuo (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Dec 2018 17:50:44 -0500
Received: from mail-it1-f179.google.com ([209.85.166.179]:37169 "EHLO
        mail-it1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727342AbeLQWuo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Dec 2018 17:50:44 -0500
Received: by mail-it1-f179.google.com with SMTP id b5so1553933iti.2
        for <git@vger.kernel.org>; Mon, 17 Dec 2018 14:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MfLlRzVGdSKRBXC4z5Gn7JVKGwb6G4GrMIkiR+XSLfA=;
        b=CR8UvUQZ4N4mTalyVXVI4+bECFjlJBgksCoNlNmidt0uQ6cR1CGMN0HBSFIKFryGYh
         h8V0+w+D7QXt+nWsdQjI5xjIgezKNX/X/LrvwyRr3goAvN4wkKv27wamJgUFr4b2E17+
         n2BerteNnPdQvMsZjeXWW6Y3iM+a+EjBy+wgIWo6S94YXuH7haDakGj23ri8VW2lq5QZ
         JT61vtBDZAuYccJABGXJKlv0ItY7sjLkpfY0ke+LEazLXqBol680HtuRZ8kOYctfzRe/
         9v2CmKwgbAEOHCz0605+MGr4dnJ9qIq91XZMqPKPjTsN4tcHGt6lYggXLB6Hj3AHQCFS
         NEDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MfLlRzVGdSKRBXC4z5Gn7JVKGwb6G4GrMIkiR+XSLfA=;
        b=THTCRSBDkO4Uw9qWyj55b3gNKIqg1mg/vlZzoDRtuj0d67CwvKuU33RXBtJYg8Yn6r
         uIvIgbjmJcX1SQkBjGxzYJDXMaMJ5JwHB/3kUb+KRV/yzO8nVWsUHzDqn5HXtvkCSzoT
         hJNblsacaYiQjsGcRbHgoug2ZFZkxq3YBqQzi1pKXGEKLddyD1xU/cIQKQclyXxhFr0i
         wYuTLRW4w6f9O+TsdU2BUclQ6eJPhyuJgozMfa4VwUMNONOot24U04E10bJV3YX46tuO
         jc595lN4vH355f05UMU+qo1Knde/U8muwS2EeQaPPyhq3G7W/VFoXh0sHn/IUUJAkmyX
         kNzg==
X-Gm-Message-State: AA+aEWao2AoKETod5IDnHZV1XnksSRzE/PObJfi/uQe1LQJg5W8kpOjp
        gYJPirGXqmjeP2raSkIRSK1ctmxdaqr9V0OvAU0=
X-Google-Smtp-Source: AFSGD/VGqg/RYpxKy6t1oBOUqyKPcr5XSrcppD6GHLYDzDBXrjyAH8ZaPfAjDZOiMDMJuqqChzykd124P3YJquQBLqk=
X-Received: by 2002:a24:6b90:: with SMTP id v138mr858234itc.86.1545087042961;
 Mon, 17 Dec 2018 14:50:42 -0800 (PST)
MIME-Version: 1.0
References: <CAG2YSPzmN5u1uAPVbjsqC3LzVVinFR21-_6wfrkBHdPWhOfMfQ@mail.gmail.com>
 <CACsJy8ANoiWfmLkmO9ACab5H+m2c2y5uhKBJzGNwwxcs9zV0wA@mail.gmail.com>
 <CABPp-BE9+qqVfccwzofD0qFecTGo2EjighNSu0vh-rF_8F5PoA@mail.gmail.com> <CACsJy8BFoK4hoXrSUi+P3xB1LumevvFe6XWAM2fLUq-UGNUs8A@mail.gmail.com>
In-Reply-To: <CACsJy8BFoK4hoXrSUi+P3xB1LumevvFe6XWAM2fLUq-UGNUs8A@mail.gmail.com>
From:   Mark Kharitonov <mark.kharitonov@gmail.com>
Date:   Mon, 17 Dec 2018 17:50:31 -0500
Message-ID: <CAG2YSPy85YtAv6m5WR4ZrsZ4TRzgcyrC4DNZnOONtFD6MsH=YQ@mail.gmail.com>
Subject: Re: Can git tell me which uncommitted files clash with the incoming changes?
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Guys, having git merge --dry-run would be great, but I am OK with git
merge for real as long as its output is parseable.

However, somewhere in between git 2.18 and git 2.20 the output of
merge changed and now I do not know how to parse it.
it used to be something like that:

bla bla bla
<tab>file name 1
<tab>file name 2
...
bla bla bla

But now, the files are output in one line and given that some files
may have spaces in the name I do not see how this can be parsed. If we
could have easily parseable output of merge, it would be enough for
me.


Le lun. 17 d=C3=A9c. 2018 =C3=A0 14:37, Duy Nguyen <pclouds@gmail.com> a =
=C3=A9crit :
>
> On Mon, Dec 17, 2018 at 6:17 PM Elijah Newren <newren@gmail.com> wrote:
> >
> > On Mon, Dec 17, 2018 at 8:26 AM Duy Nguyen <pclouds@gmail.com> wrote:
> > >
> > > On Mon, Dec 17, 2018 at 2:11 PM Mark Kharitonov
> > > <mark.kharitonov@gmail.com> wrote:
> > > >
> > > > Hi,
> > > > I have asked this question on SO
> > > > (https://stackoverflow.com/questions/53679167/can-git-tell-me-which=
-uncommitted-files-clash-with-the-incoming-changes)
> > > > and usually there are tons of responses on Git questions, but not o=
n
> > > > this one.
> > > >
> > > > Allow me to quote it now.
> > > >
> > > > Please, observe:
> > > >
> > > >     C:\Dayforce\test [master =E2=86=932 +0 ~2 -0 !]> git pull
> > > >     error: Your local changes to the following files would be
> > > > overwritten by merge:
> > > >             2.txt
> > > >     Please commit your changes or stash them before you merge.
> > > >     Aborting
> > > >     Updating 2dc8bd0..ea343f8
> > > >     C:\Dayforce\test [master =E2=86=932 +0 ~2 -0 !]>
> > > >
> > > > Does git have a command that can tell me which uncommitted files ca=
use
> > > > the this error? I can see them displayed by git pull, but I really =
do
> > > > not want to parse git pull output.
> > >
> > > Assume that you have done "git fetch origin" (or whatever master's
> > > upstream is). Do
> > >
> > > git diff --name-only HEAD origin/master
> > >
> > > You get the list of files that will need to be updated. Do
> > >
> > > git diff --name-only
> >
> > Are you assuming that `git diff --cached --name-only` is empty?  If it
> > isn't, that alone will trigger a failure (unless using an esoteric
> > merge strategy or an older version of git), so this assumption is
> > fairly reasonable to make.  But it may be worth being explicit about
> > for external readers.
>
> Actually I think Jeff's suggestion may be better since he compares
> worktree with HEAD and should catch everything.
>
> > > to get the list of files that have local changes. If this list shares
> > > some paths with the first list, these paths will very likely cause
> > > "git pull" to abort.
> > >
> > > For a better check, I think you need to do "git read-tree -m" by
> > > yourself (to a temporary index file with --index-output) then you can
> > > examine that file and determine what file has changed compared to HEA=
D
> > > (and if the same file has local changes, git-pull will be aborted).
> > > You may need to read more in read-tree man page.
> > >
> > > Ideally though, git-read-tree should be able to tell what paths are
> > > updated in "--dry-run -u" mode. But I don't think it's supported yet.
> >
> > merge-recursive currently uses unpack_trees to do this "files would be
> > overwritten by merge" checking, so the suggestion of read-tree (which
> > also uses unpack_trees) makes sense.  BUT ... the error checking in
> > unpack_trees has both false positives and false negatives due to not
> > understanding renames, and it is somewhat of a nightmarish mess.  See
> > [1] for details.  Further, I think it warns in cases that shouldn't be
> > needed (both sides of history modified the same file, with the
> > modifications on HEAD's side being a superset of the changes on the
> > other side, in such a way that 3-way content merge happens to match
> > what is in HEAD already).  So, while the suggestions made so far give
> > some useful approximations, it's an approximation that will get worse
> > over time.
>
> Ah.. dang. I guess we need "git merge --dry-run" then :)
>
> > I don't have a better approximation to provide at this
> > time, though.
> >
> >
> > Elijah
> >
> > [1] https://public-inbox.org/git/20171124195901.2581-1-newren@gmail.com=
/
> > , starting at "Note that unpack_trees() doesn't understand renames"
> > and running until "4-way merges simply cause the complexity to
> > increase with every new capability."
>
>
>
> --
> Duy



--=20
Be well and prosper.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
"There are two kinds of people.Those whose guns are loaded and those who di=
g."
   ("The good, the bad and the ugly")
So let us drink for our guns always be loaded.
