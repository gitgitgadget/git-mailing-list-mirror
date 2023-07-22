Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49083C001B0
	for <git@archiver.kernel.org>; Sat, 22 Jul 2023 21:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjGVVoj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Jul 2023 17:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjGVVoi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Jul 2023 17:44:38 -0400
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B71CE10D8
        for <git@vger.kernel.org>; Sat, 22 Jul 2023 14:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1690062274; x=1690667074; i=tboegi@web.de;
 bh=2U3Yl7iRU1SpJ5uuJjr3fmv/GHl/wIx5mtRK9qNk4hM=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
 b=qZX0y3ff+cRJ5f+NBQ0BrXcCGk0yv5O4ATmm7QelK3yryO51NGPz1y3anHckhc77s1zX4de
 laKBo2r0Jof6GwlqaMdChLa9uFssI791jtqPRwOC+xO8P0HFfQVdXWIUffUgWzoTZ2R1WZYPs
 zkh50/vODqmQhIjvD346D2g+Ilh3Ul9a61IwZYOI+x0IeDIQZDDX7GVvz/D0w95t6BxjQU4JF
 a1Ww99rJfmHC2JTlcUtw/Yb34JsEdwt+Ov0oRGRbJo+Hv0t/r/LX55OtOprNRmzFx9u8x1G1H
 Q9Qu2HBJfB1UtxxE6e+EEJzuCQMG7T3MHUKWXTcr84PhTBtgXUkw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MlbLM-1pg3RA0YGw-00iwpb; Sat, 22
 Jul 2023 23:44:34 +0200
Date:   Sat, 22 Jul 2023 23:44:33 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Till Friebe <friebetill@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Lost files after git stash && git stash pop
Message-ID: <20230722214433.3xfoebf7my5wsihf@tb-raspi4>
References: <5260C6A0-C53C-4F6D-B899-6AD8601F8458@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5260C6A0-C53C-4F6D-B899-6AD8601F8458@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:NWaTftdjybKcjV8QHeZWqBgCVSul4roQXZYpt1HKaE3OJNL4hd8
 XGqMOLycJZ109pZCYk/Jj8Tpmz+AhWN0cssWyHltVpc8ZDdTA0cvy5q1qBD3lDXgyUHRU0S
 E756O7Xnt8X5TNFfnjZs504kw7wvDF/qWwnb4oiACJD50JyrYsm/lTPJnkXQkCLxyxbOnCG
 WZusLCtJ2t9psMHv3g8yg==
UI-OutboundReport: notjunk:1;M01:P0:dqNTcmkobLg=;XBR9+2tlW2gkBjm+Ktl+47zCuNJ
 YANTygFp1C2XoaEJfikW0bkdq3mCR5P0i/szhwRe5B17FbqcwY5E7kQs0RyMPznYBKWG8xnto
 mgZ/dIRbPUfr+nVYY2y/FdbnqQfxH9H7FXyMYV2ShLjfO77u9heRR+Z70BRSrikMMvqf1b/AX
 zP1/cVKTA1VHznYiZredWbwkIJzIWOl8DuQIJND0JezavI/Ry6i+Ep2r2j2KSXivJGGRq1iXO
 4lQYqnmFqySfgMt0lRU96tWrYu3NwZ3qVh1ftzo+8ZQ02HNER5peRXUJVvV7DPA4cPwRqytbZ
 NVF8Dd1PhdnFx4FDfRkiq6oLtRFjps2hwlKqTL89qIvpagKNE9Dz/QmB8PWMc0ZwvUDNIzsyb
 skRXCS9u6cMCztN5HngpOPQUsWn4sXShqnc09CNo8zH7CqsPRUXooD7nIDTlBxGRYxkynzbcI
 M0z7OArduH+IjqweKUxncYeTVEC/7AR9/sQ9dueQ40b7r4lZrtQTN1rDzYb9rjl6N/bHsm6rN
 NqMC2n7h5L4BhKwISrwX+EwCbJKFMmmRyPh5Qgm6+AdHMc1KnUre0WIB5R4wwAAOkWtx8dArw
 s/9+9LWXjB55iYW7Tq7XPGT/tDZfi0vnaFY5xjpS7xmynBUNPeu2e2xV2bEegjzn+0NJrAwZu
 tMW7GPGbZjBPZrV4FRr1RMD11uc44xMwDlh0ZMEjeD+x/dr8jof55y6EUye3BQm7fdU/GIgF+
 uzI8Jcwyap/fntxx/OFfXEPy4Fe0Zt5rKXj3KO/+TTH9hxyZy+LSZMtJdHsagdr3Va0wcHKBE
 p41IF/W6kkZTfCR2GrdhpHIlt+jcYYdkmC7vk6IcOjWgxKYO7shMKEcbexYBXR/uaHsdvx5D2
 /jU29tiwFCpkED3fcL7fcqjIOV3LD29IxPtQVFswlk8LwpejejiMk1mu35NG2k5/YYUd0A3Hi
 TyQvaNy6wnAup+OYwFziBAgWPPw=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 21, 2023 at 07:31:53PM +0200, Till Friebe wrote:
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
>
> What did you do before the bug happened? (Steps to reproduce your issue)
> ```
> git init
> mkdir README
> touch README/README
> git add .
> git commit -m "Init project"
> echo "Test" > README/README
> mv README/README README2
> rmdir README
> mv README2 README
> git stash
> git stash pop
> ```
>
> What did you expect to happen? (Expected behavior)
> I expected that after the `git stash pop` the README file would be back.
>
> What happened instead? (Actual behavior)
> This README with "Test" file was deleted and I lost 5 hours of work.

That is always sad to hear, when work is lost.

However, I personally wonder if this is a bug or not.
First, Git is told to track a file called README/README
Then the file is removed, without telling Git.
And a new, unkown file appers on disk (which collides with the name
of the directory)

Using this sequence could have told Git, what is going on:
git mv README/README README2
rmdir README
git mv README2 README

(a temporary branch may be checked out, with the option
 to merge-squash the final result)


An other alternative could be to tell `git stash` to care
about untracked file(s):

git stash -u
git stash pop

Which will refuse to apply the stash.

A third alternative could be to keep the file inside an
editor, to have the content still available.

However, it would/could be nice, if files are not simply deleted,
but saved into a "lost+found" folder, or a wastebasket kind of thing.

But which files ?
Those that are untracked ?
They may be important (local config files, passwords, help scripts, ...)
or not (.o files from a C compiler).

In some older discussions they had been named "precious" files.
But, as far as I remember, there was no easy solution.
In that sense I don't have a better answer.
Others may have.

Thanks for reporting, it make me read [1] and come to the conclusion
that it is sometimes safer to checkout out a temporary branch, commit
everything and clean up later, rather than relying too much on
`git stash`


<https://stackoverflow.com/questions/835501/how-do-you-stash-an-untracked-=
file>
>
> What's different between what you expected and what actually happened?
> The file doesn't exist anymore and I can't recover it.
>
> Anything else you want to add:
> This is just a reproducible example.
>
