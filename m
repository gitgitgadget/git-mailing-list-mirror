Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 552C0201C8
	for <e@80x24.org>; Tue, 14 Nov 2017 09:38:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754351AbdKNJii (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Nov 2017 04:38:38 -0500
Received: from mail-vk0-f47.google.com ([209.85.213.47]:47984 "EHLO
        mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754186AbdKNJia (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Nov 2017 04:38:30 -0500
Received: by mail-vk0-f47.google.com with SMTP id 22so8146742vkq.4
        for <git@vger.kernel.org>; Tue, 14 Nov 2017 01:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=48BFXm9PyW/PVjls77Tds9wHNasvLWKsS1E3wBVVtk4=;
        b=rHxGohoFLKII9X7Kz+8+Cm+kl/LSHsV6bhzC/KcYiHU5loYyJv//zjconyokOmXWdG
         4ZGeRYzmBsKaFWLSOTEwUS4vjnGOyVtCaFatAUAEG6GjKTcTEojE2hDzvIUDZZk1ZEiT
         pBvSMNni9dJFcGWRkjiECeD9r/PCvJTfhfM56qgI26If4pO6TwC5st8FZ8VINioHcvmP
         EP5M4/nODc9emdI367EXHOFlpgryujFXXTZXQQsvyl18PhGARKok6jrsFA/+NFO+0qKW
         xD/NdUUsXZJdnPsZIwcexrsLjnIoI6qdDQUJn51aquf+2exQUclZO8t0WACm/sueF20s
         0nyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=48BFXm9PyW/PVjls77Tds9wHNasvLWKsS1E3wBVVtk4=;
        b=WuAIoi6zHyWK30WzuDL41k62Dxo2eRgMU/GuqIz6sy4ROi9r/vebZRHdko+GL/ekNF
         et5rhVKs4jZo22bfo3FOyRBGxcRHw9+g8/qUWiGv/15+YW6VRBJgbABPtnl7cO5YU34T
         csQAarmyBU80opOWvRNclxMLwv0mLJU0gheMNEfoJhlJNety3TnWU5SpXhIclW/a7aQ3
         tywtkz9mUcynhPvo6CP7Vf89Bq7NAqQreUepmO/q1mXKUM4CLZ8oJt+sIK9BnWvdFMAp
         v0fNvVriBUJu4CfBkHOBywfhyDVnGh+ZeGG6ufUamTqFKRs5ZogQli4k6iHEmKvXEbUe
         n+FA==
X-Gm-Message-State: AJaThX6gOnJJ7faX2e/piOI9efVlfDJqp1ERBAA/xeHNwoV87/vCllY/
        2SoksN1Nkkf/jD7kYNgvcsy7/W3rS9xa/vDsFDuMTwNX0I0=
X-Google-Smtp-Source: AGs4zMYlGlmlzTtynFdIX3RHuW6LrOoBlsGU+kCPSwM30jTIwngvSgZvjEs8zvAYLFCUxTNOJzGKtOlGaIlEAcCKRdk=
X-Received: by 10.31.234.68 with SMTP id i65mr134819vkh.126.1510652309661;
 Tue, 14 Nov 2017 01:38:29 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.17.80 with HTTP; Tue, 14 Nov 2017 01:38:28 -0800 (PST)
In-Reply-To: <alpine.LFD.2.21.1711140409020.13653@localhost.localdomain>
References: <alpine.LFD.2.21.1711140409020.13653@localhost.localdomain>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Tue, 14 Nov 2017 01:38:28 -0800
Message-ID: <CAGyf7-FSHW4DqMXt1043FjmOO8tRQHq=xFGwQgKTK06Gi+a-PA@mail.gmail.com>
Subject: Re: why can *some* git commands not be run from within .git directory?
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 14, 2017 at 1:18 AM, Robert P. J. Day <rpjday@crashcourse.ca> w=
rote:
>
>   just noticed something i was unaware of -- some git commands can't
> be run if i'm in the .git directory, while others can. for example,
> if i "cd .git", commands like this work just fine:
>
>   $ git show
>   $ git branch
>   $ git log
>
> but others seem unwilling to determine the "working tree":

Once Git finds a .git directory, or determines it's in one, it doesn't
look "higher"; instead, it runs like it's in a bare clone. That means
any command that requires a work tree or an index generally won't
work. Of course, you can still tell Git where the work tree is and
then the commands work fine from the .git directory:

incom@Jael MINGW64 /c/Temp/example/.git (GIT_DIR!)
$ GIT_WORK_TREE=3D.. git status
On branch master
Your branch is up-to-date with 'origin/master'.

nothing to commit, working tree clean

>
>   $ git status
>   fatal: This operation must be run in a work tree
>   $
>
> and:
>
>   $ git stash list
>   fatal: /usr/libexec/git-core/git-stash cannot be used without a working=
 tree.
>   $
>
> what's the distinction between commands that can work this way, and
> commands that can't?
>
> rday
>
> p.s. i will refrain from pointing out the inconsistency in using the
> phrases "work tree" and "working tree" to mean the same thing, when
> there is a distinct "worktree" entity.

No you won't, clearly.

>
> --
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Robert P. J. Day                                 Ottawa, Ontario, CANADA
>                         https://urldefense.proofpoint.com/v2/url?u=3Dhttp=
-3A__crashcourse.ca&d=3DDwIBAg&c=3DwBUwXtM9sKhff6UeHOQgvw&r=3DuBedA6EFFVX1H=
iLgmpdrBrv8bIDAScKjk1yk9LOASBM&m=3DyPGW_MCaDCBECSMjz40m8vsxUhljCB3dnrQ4TBi8=
PtE&s=3D-JNZXqYtyY7CIJGy65WWa88Kq7BaelyajFehPQZkvo4&e=3D
>
> Twitter:                                       https://urldefense.proofpo=
int.com/v2/url?u=3Dhttp-3A__twitter.com_rpjday&d=3DDwIBAg&c=3DwBUwXtM9sKhff=
6UeHOQgvw&r=3DuBedA6EFFVX1HiLgmpdrBrv8bIDAScKjk1yk9LOASBM&m=3DyPGW_MCaDCBEC=
SMjz40m8vsxUhljCB3dnrQ4TBi8PtE&s=3D-9gIAxcdRGPmIz1rpLLb7nl14azEwoE-fOJ-IxAY=
i18&e=3D
> LinkedIn:                               https://urldefense.proofpoint.com=
/v2/url?u=3Dhttp-3A__ca.linkedin.com_in_rpjday&d=3DDwIBAg&c=3DwBUwXtM9sKhff=
6UeHOQgvw&r=3DuBedA6EFFVX1HiLgmpdrBrv8bIDAScKjk1yk9LOASBM&m=3DyPGW_MCaDCBEC=
SMjz40m8vsxUhljCB3dnrQ4TBi8PtE&s=3DprnIhreU-Vhx0V6lRCBQEPbJk2P8bPlHcRFus1X_=
6wM&e=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
