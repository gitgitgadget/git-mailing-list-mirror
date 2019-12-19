Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31BCBC43603
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 03:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAB2F21D7D
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 03:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="GuCA1LLE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfLSDMc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Dec 2019 22:12:32 -0500
Received: from mout.web.de ([212.227.17.12]:42945 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbfLSDMb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Dec 2019 22:12:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1576725148;
        bh=iXXEgjfubDWFKGTRzJ+yl4FvBQEHl1r3jHy4A2fxgvY=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=GuCA1LLEt0dp+Lcf0aljQSpXCsUKiRQqEl74LXjzHyAxxA8VG6KIK2DVBxBrU9LVc
         ToMVzbIuO63b9V5IaZoOM9MpU/j0gyKdx32Wpn17OhpX+DPrVmNzh0jGbcAgxmcsgb
         8eAMUposFKioh7s2YwyT4wOb7P1BXpqttZwsXgP0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LvSLn-1hhfF11Zgp-010bp2; Thu, 19
 Dec 2019 04:12:28 +0100
Date:   Thu, 19 Dec 2019 04:12:28 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Scott Richmond <scott@brightrockgames.com>
Cc:     git@vger.kernel.org
Subject: Re: Ability to ignore EOL changes for certain projects
Message-ID: <20191219031227.xqlv564h3iq5ofq7@tb-raspi4>
References: <CAB1T5w2GyfERoaCyFZeKaui_xuXd0r6J+Zvq4pecstBJ9UyRzw@mail.gmail.com>
 <20191218192741.ybi3xpvax7lrrubz@tb-raspi4>
 <CAB1T5w1Ct7_D7kiUypRuoK+zeiocyPJn0SindXfs6M5wUkVavw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAB1T5w1Ct7_D7kiUypRuoK+zeiocyPJn0SindXfs6M5wUkVavw@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:4SsIP4z0RUKws3EXaC2lLF2CVo8aKZFEUesM05VPoBNtHg1U1vV
 DqII3XezFusmyfRvN80nVq8H+wYqA4rfL1ySWXe+OCgNJRqYz+aQflKNtMvuRkFkWSt+rDB
 0BXyE7SOFNmnV7GTfQcpPUziaxKy9PWw2rc2zOH24tOH84w9T5/W4NUiKtHzB6glfrZRFuQ
 1cCexoKrtVs/loqBNoIfQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fWSH5+ZN1rI=:aYBiIetVluoQF/E8jrqWd3
 G3EuIBrR7A8WACdscFUrPD1mcBbATWRKlRDk94A643YOi4NxBdKN5+n+BZqrZih+3P6AcnFUd
 hvO5cdqhOXLQr8aou89D8lQdpCHi8ytVpczxOWOx1IF1LIhLIrS3dc2qopHr/6O9UA2FYwyWw
 Z7z/vS+7HJHB1Lsxm/z/Ja4w1C29o9zeM1xuNIi1tyKBhZy/XXuVZzh8bAR8v5wwL1Xw6Smyu
 5cXqtzonBsB34XHImrLZbppVYDnkTQnkOjqMRz2jFV//5vU7EaEcK9uCUbfCDo1NaXD5zIdXC
 I5A+FJrXZRMRiXiYmKjQZrC8YvqlJz0vXFwdCGuLOrUQc8ka4/0pLUDG904VWihJQwkTw5FSg
 sg0CHIdyXOOLIxWlOMtWx5/GWg/un8+V2rlbK1JNs5Un9efhUzPwuZ9lEhd8Za9yclpztw/i2
 BKqk9W9Ji1DtQjZBdAyO9XBMMt0vbQ/YZxCttE6p+L9kZSgDcjpaW9gq/UcOPcCLksTtrheuD
 P7/PAJePHDMLmkJYyzsxvs8EpJV72mXGhGvfwqWG3Ibyrxnqlzm3eVNvPdJyU7bqkqANVZ2fN
 RTsdM9ybuTR+4RgTOZHT3XglDnNK7ihpgXln2nQ1XF1A6m1XCELglN51kAuVSLZC7Cu7jdpnL
 WYQMlHpGBq+3NLA9loTh5oytmgWH83sHdYBVcOE9h91ApvPutZdQobLieuOcs+b74t29COO7L
 uf7j+1ySXtkm1Q5UN5KAwwM3VTditjb0U9POkKkugMMq9ZZNn/tk3auOUzhFmebl1LCxy3W3q
 Rf5d5uwN+x1bJ1fIxFxaiq9P7xo5R6A0yaZrUh6AZUKNOxX6JEzoSYE8Yv66wBhfjOkDbCq0l
 TDD1XfBJaILlmODo7y6L2qk/3GYqUYTZq4BhSwQLqj47pnfDhnVCMsPMizzYneKwnV9KoZ8mt
 AD5qc1jN2xzntrsEdAHtocjwZSZozq7T1M6ENpbZ6X96ONlIG0ZTg3A6kWPqtAyuipJstZLFC
 wJSOOjo61+WOlzCEFBZi+I96xPi1LDEDmm/9dmEyjGZBjHevo9bujnj26Hw+Bq7fwZc37i9rx
 CfeWL2X1uub1PMoKmr3/00qaN1l1qMbJGUxg7bpaZyufRVdoI1k3GlIO1Oy8kDtjZkXjBvcgv
 yieZGZl2YlIczGpaU8/D91plNdPgK/rtJbMCbUUJ5htW8I+1djKlIAY1lAbRUkbNqImGCY1fz
 5C7fX/FU48PjYn+dYFIGAG3uoNbSjgfxIoqlxKQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Scott, please avoid top-posting in this list, see my answers at the end.

> On Wed, Dec 18, 2019 at 7:27 PM Torsten B=F6gershausen <tboegi@web.de> w=
rote:
> >
> > On Wed, Dec 18, 2019 at 11:10:27AM +0000, Scott Richmond wrote:
> > > The Problem Domain
> > > In certain dev environments (Unity3D projects) there is (AFAIK) an
> > > unsolvable problem where some files are often modified with line
> > > endings that aren't the native system or not the committed line
> > > endings for that file. Secondarily, in this case line endings don't
> > > matter - Nothing in the dev environment "cares" which kind of line
> > > ending is used.
> > >
> > > The Problem
> > > Git always cares about EOL. Git has options to transparently modify
> > > EOLs when files are checked in or out. However it is not possible to
> > > tell Git to ignore EOLs in other commands:
> > > Git status shows the file modified.
> > > Merging/Pulling has to care because it can't merge with a modified
> > > working tree. Which means the user has to care - They have to either
> > > stash the EOL changes or wipe them out. Sometimes, if the user has a
> > > particular app running, it may automatically reload that file and
> > > recreate the modified EOL changes, causing an endless loop. This
> > > problem is often made unclear to the user how to solve, especially i=
f
> > > they aren't domain experts.
> > >
> > > To be clear, in this particular dev environment, I can say with
> > > confidence that this particular issue is a major and common pain poi=
nt
> > > for users. It is made worse as many users in this environment aren't
> > > programmers by trade and aren't domain experts in version control. I
> > > also believe this environment is becoming a non-trivial portion of t=
he
> > > Git userbase and it would be worthwhile looking into resolving.
> > >
> > > Solution Request
> > > It would be fantastic if we could tell Git to stop caring about EOL
> > > changes on a per-repo basis, with the effective output being that gi=
t
> > > status shouldn't show changes for files with differing EOLs.
> > >
> > > I'm experienced with Git, though I am not expert enough to consider
> > > creating such a change myself - It is unclear to me just how
> > > complicated a change may be. However maybe I could look into it if i=
t
> > > was made clear that this improvement is possible and has no serious
> > > side effects.
> >
> > Hej Scott,
> > I think that you problem can be solved.
> > For each repository, you can tell Git to ignore the line endings,
> > CRLF vs LF.
> >
> > If you start with a fresh repo,
> > you can do something like:
> >
> > echo "* text=3Dauto" >.gitattributes
> > git add .gitattributes
> > git commit -m "Add .gitattributes"
> >
> > For existing repos, we need to take another step:
> >
> > echo "* text=3Dauto" >.gitattributes
> > git add .gitattributes
> > git add  --renormlize .
> > git commit -m "Add .gitattributes"
> >
> > More information can be found e.g. here:
> > https://git-scm.com/docs/git-add
> >
> > Once you done that, you can merge branches
> > into the master branch with help of the renormalize
> >
> > git merge -X renormalze branch-name
> >
> > See even here:
> > https://git-scm.com/docs/git-merge
> >
> >
> > This is just a (too) short introduction, I hope that it
> > helps and that you find the time to dig somewhat deeper into
> > the documentation.
> >
> > Other developers have that problem as well, you are not alone.
> >
> > If you have a public repo, I could help with one example.
> >
> >
> > >
> > > Regards,
> > >
> > > Scott Richmond.
> > >   Director, Producer, Programmer
> > >   Brightrock Games
> > >   T: 07480795661
On Wed, Dec 18, 2019 at 09:33:32PM +0000, Scott Richmond wrote:
> Hey Torsten,
>
> Thanks for the reply!
>
> Correct me if am wrong, but those steps don't tell git to "ignore"
> line endings. That just causes git to check all text files in and out
> with a specific EOL type (Either automatically chosen, or not). If an
> app in the dev env changes a files' EOL to something else, git will
> notice the change locally.
>
> Regards,
>
> Scott Richmond.
>   Director, Producer, Programmer
>   Brightrock Games
>   T: 07480795661
>

Hej Scott,

I am not sure whether I understand your question correctly.
So I set up a little test, to illustrate things better.


user@linux:/tmp/EOLtest $ git init
Initialized empty Git repository in /tmp/EOLtest/.git/
user@linux:/tmp/EOLtest $ printf "Line1\r\nLine2\r\n" >file
user@linux:/tmp/EOLtest $ git add file
user@linux:/tmp/EOLtest $ git commit -m "add file with CRLF"
[master (root-commit) 0e4d1df] add file with CRLF
 1 file changed, 2 insertions(+)
  create mode 100644 file

user@linux:/tmp/EOLtest $ printf "Line1\nLine2\n" >file
user@linux:/tmp/EOLtest $ git status
On branch master
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
    (use "git checkout -- <file>..." to discard changes in working directo=
ry)

        modified:   file

no changes added to commit (use "git add" and/or "git commit -a")
user@linux:/tmp/EOLtest $ git diff
diff --git a/file b/file
index 4aa551d..ac2dd81 100644
=2D-- a/file
+++ b/file
@@ -1,2 +1,2 @@
-Line1
-Line2
+Line1
+Line2

user@linux:/tmp/EOLtest $ echo "* text=3Dauto" >.gitattributes
user@linux:/tmp/EOLtest $ git add --renormalize .
user@linux:/tmp/EOLtest $ git commit -m "Normalize the repo"
[master b41136d] Normalize the repo
 1 file changed, 2 insertions(+), 2 deletions(-)
 user@linux:/tmp/EOLtest $

user@linux:/tmp/EOLtest $ printf "Line1\r\nLine2\r\n" >file
user@linux:/tmp/EOLtest $ git status
On branch master
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
    (use "git checkout -- <file>..." to discard changes in working directo=
ry)

        modified:   file

user@linux:/tmp/EOLtest $ git diff
warning: CRLF will be replaced by LF in file.
The file will have its original line endings in your working directory

#############################
No, at this point, I am surprised myself.
"file" is reported as "modified", but it should not be modified, right?
Is that the problem, that you have ?


We can fix it, by running:

user@linux:/tmp/EOLtest $ git add file
user@linux:/tmp/EOLtest $ git status
On branch master
nothing to commit, working tree clean

But I still think, that this "modified" is unexpected,
and a (possible) bug in Git, thanks for reporting.

Which Git version do you use ?
Is this test script a description of you problem ?

