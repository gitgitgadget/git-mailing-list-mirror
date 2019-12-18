Return-Path: <SRS0=Z/Vr=2I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A9CC43603
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 19:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A60421D7D
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 19:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="g6hTmAeX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbfLRT1o (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Dec 2019 14:27:44 -0500
Received: from mout.web.de ([217.72.192.78]:59985 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726698AbfLRT1o (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Dec 2019 14:27:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1576697262;
        bh=UM7wpXbJQ3bCjRBb9+n/XqoDMxhW5dwT/w6mUxUUap4=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=g6hTmAeX6yjxm8pgIfpQfyNa+EGe1HwG5dprUyq2NhhLzXXEEC8oHLiPk4NGvoFbD
         IjTv99k92e00w6eVFTvCLvYEG7I/uTi+CCf+sxnL74C6z12KiafR8vFUn1zLchzUol
         luCql4E0UYdopx64/Bjv0MHF9BW690aiLxAxUN3M=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lmu2K-1i34N73bwK-00h4kZ; Wed, 18
 Dec 2019 20:27:41 +0100
Date:   Wed, 18 Dec 2019 20:27:41 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Scott Richmond <scott@brightrockgames.com>
Cc:     git@vger.kernel.org
Subject: Re: Ability to ignore EOL changes for certain projects
Message-ID: <20191218192741.ybi3xpvax7lrrubz@tb-raspi4>
References: <CAB1T5w2GyfERoaCyFZeKaui_xuXd0r6J+Zvq4pecstBJ9UyRzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB1T5w2GyfERoaCyFZeKaui_xuXd0r6J+Zvq4pecstBJ9UyRzw@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:2c1YLYblS3X64Y/SHNXLG+49wmoSe4gW6kGZSXSGmZ+Rk+DbrhA
 5AHRMYneqPNPeH3Ncezp6m+Z6p7ULAIxKbv0wI+uorI/8q/2KNCOWLu/9TQESyEgMFLxav1
 3lqCBCsTsRiME7pd5e9vCaUlQBCrAjjJ0cw3CYwtCEAaT1YADCcQnGCbkRI8VSn5Ny+5DMX
 kJp3Vx6K4YkL8M5nkUlAA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:L2QbpwKNhv0=:jbnyOk2q2nLmUymSKTnvqM
 zMCK+W1aZ38qygOXLzndjdwEDFN8EsNMwYfJpPVxo1IN4S2H+9rNaI/W3vl/u+27hV35QmGhJ
 zhbW1s/i+oBqe9LQKAD6GnIk1waZS/0CRAYjcaSi9quqbGxoh01scf1AIqQsGfVxMf6fBWScK
 JwqpWGf8nfZzFd+cjcHoPTmg1p+oi+RvKHjSHPAMjjmWeytLA15tLja+t5KrdXCyfry/X4QO4
 NydBupkuVXsa7sZeyIhzaYdnBiMrAWSw5PHRMZCkTwZ01T9FsNkP55MNQdb1FqBEDxq1CXuZc
 ZzNaCUuEobO1D99tNiKcS3DgHoGSLGbuPQatrD9eVEEBbfdB9XoPKiFAaf9W6OgwDUbNo8+Ck
 I3TkmWIBZ+GYX4gCtTninz4WLyYY8kySpuhPrnou3/7OWHrTxBi9CSGTwlW1aLjMPgTt2ICno
 kqr7lrPLU54k3dDBTEw5ZLJ8oNtyX5qnW+v1pwuDPiM59qfiGNd6jb8RttR9XH0iiJ0XHOZqM
 JmBsINCjcPG8zyZFWksYQFgKwUY1DqpG7AqXool+m6hSpG3OsoZWnzU036mO72iK06r7Av3VW
 scwrw47T4mX1UUiJlMiwuRfHJYVJBvSyQ7yS2vPowx2lnNwwG94bdJyJ71HsKrJb7fDDQaznU
 ej5RPRHwZbsKTU68+QOb2OkVP8E5sEB806/GRfiHvj1EkQCR1Uuz3/THaSG5BkOKIn6qMyUFf
 XADrxjcAvmvV24yOSoxDeKl/q3DYAX6iDg4JE2AKuNryvLXs9DQqXP04/P3zPBC7ALFhyWjmt
 5FrODmR57VwwUOJmVxzosJGKqWjE/GPBsQ/r7giMU4nmPjVt/bZUEXJrOp1ibsmE27GrcNava
 LhsZC9YhEXnajJ8sE1tbOxrc3KnENUF9/Zd/s8d91eAl8hM3Dk4eMaMFgmTSyEH1YwbJK1g9X
 29One+78EYkCopoU8zAFXJto02mPL4BnstaOHLcDpvtnkJ/Rh1QjVQsu9Cc4WDVfP9YzHTt+Y
 fIgF4L+fIqzruyVnDKTDi2AavhqYs8Opxi6b504RSYOVaW5O1GRY1uL7QYz4+AHyAcJWTFxUU
 7jPqITYT2o8P/BFj8MSFG5Jzh84YAUaRdSV9YNB/Dyp5qMC35j4Fihix8X7X/JrOOgEXR1h4g
 TJj3CP5oiSE7/jihD54dIh7ZXROmnOgmfL6pTU8HSKwZa7F7jthQke/+imcujmoek+1D+Tydw
 lXsl1wXxEwBQsgigOda9kUQTQCDWoJZoFn6+MHA==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 18, 2019 at 11:10:27AM +0000, Scott Richmond wrote:
> The Problem Domain
> In certain dev environments (Unity3D projects) there is (AFAIK) an
> unsolvable problem where some files are often modified with line
> endings that aren't the native system or not the committed line
> endings for that file. Secondarily, in this case line endings don't
> matter - Nothing in the dev environment "cares" which kind of line
> ending is used.
>
> The Problem
> Git always cares about EOL. Git has options to transparently modify
> EOLs when files are checked in or out. However it is not possible to
> tell Git to ignore EOLs in other commands:
> Git status shows the file modified.
> Merging/Pulling has to care because it can't merge with a modified
> working tree. Which means the user has to care - They have to either
> stash the EOL changes or wipe them out. Sometimes, if the user has a
> particular app running, it may automatically reload that file and
> recreate the modified EOL changes, causing an endless loop. This
> problem is often made unclear to the user how to solve, especially if
> they aren't domain experts.
>
> To be clear, in this particular dev environment, I can say with
> confidence that this particular issue is a major and common pain point
> for users. It is made worse as many users in this environment aren't
> programmers by trade and aren't domain experts in version control. I
> also believe this environment is becoming a non-trivial portion of the
> Git userbase and it would be worthwhile looking into resolving.
>
> Solution Request
> It would be fantastic if we could tell Git to stop caring about EOL
> changes on a per-repo basis, with the effective output being that git
> status shouldn't show changes for files with differing EOLs.
>
> I'm experienced with Git, though I am not expert enough to consider
> creating such a change myself - It is unclear to me just how
> complicated a change may be. However maybe I could look into it if it
> was made clear that this improvement is possible and has no serious
> side effects.

Hej Scott,
I think that you problem can be solved.
For each repository, you can tell Git to ignore the line endings,
CRLF vs LF.

If you start with a fresh repo,
you can do something like:

echo "* text=3Dauto" >.gitattributes
git add .gitattributes
git commit -m "Add .gitattributes"

For existing repos, we need to take another step:

echo "* text=3Dauto" >.gitattributes
git add .gitattributes
git add  --renormlize .
git commit -m "Add .gitattributes"

More information can be found e.g. here:
https://git-scm.com/docs/git-add

Once you done that, you can merge branches
into the master branch with help of the renormalize

git merge -X renormalze branch-name

See even here:
https://git-scm.com/docs/git-merge


This is just a (too) short introduction, I hope that it
helps and that you find the time to dig somewhat deeper into
the documentation.

Other developers have that problem as well, you are not alone.

If you have a public repo, I could help with one example.


>
> Regards,
>
> Scott Richmond.
>   Director, Producer, Programmer
>   Brightrock Games
>   T: 07480795661
