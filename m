Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D4BC433F5
	for <git@archiver.kernel.org>; Sat,  2 Apr 2022 16:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358458AbiDBQvH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Apr 2022 12:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345516AbiDBQvG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Apr 2022 12:51:06 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138783F33D
        for <git@vger.kernel.org>; Sat,  2 Apr 2022 09:49:13 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id q19so1422613wrc.6
        for <git@vger.kernel.org>; Sat, 02 Apr 2022 09:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=JFMai5JLn+MuagD885vZz7AqdkYkBnF1MPFWIOYOqu8=;
        b=D8XqyI0m5XYsk37KJjoR9kFqXlNm4rXSVVxwiouvWCLBPsfv0tNGRDK5sMD1YMYFda
         OILwuFMcXjK1qVpsO3ITWDGIu1rRW+G7rj6ec1/drtA2WM3x485qPuelz59XYJRkHGrs
         Bib2eFUWszlSbdqGm4Bt3S1HYtFCoTd7UrM2azYe6gAxTqSejOtIVVpxc4yr+IDLFa6J
         RPQAiOgTeLD92y/qlAzb+O+5ihkiSdPV8TIWFU19f9AVLULMkaiwlCEHR6BN+enw6AWB
         NJy9UnmnV9BjB5Twf6jMhokvl+i2EZmsX4QSh823bhQvTNJV9U3Mwdjmnt3memdlvlBI
         GIig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=JFMai5JLn+MuagD885vZz7AqdkYkBnF1MPFWIOYOqu8=;
        b=IgrVqzKbi27qyswAioVAwiJNpDyu1Kv4/JzIieCEC887r97tZP/IkGaOnw42INchFw
         nmt3LAp5jLzCPeFI5lpcCYqjIjUxFrGULK0mhRL+hGzP9WQpJEZruRyNKSJuygSS+Nbl
         zE4x+BQ+mw7vQ6eEeP+e5iSCLfmx4sVhoZxkLbb3tDYCRvSN35yeIwyKd6mg4ZDGZwA2
         Q58Ed4zsUUdl7oOuJlXke4W0ipvPXJRzL+WdnGO+33QZsX5dJDPH3qOLMsJ/06NvRUcZ
         Q8qsEVUTIqy5gwyxDPoQvo2KUvVifwqQI4ld2uTNd8zV62be68/R822wDdcHNHQU/7PS
         DlPA==
X-Gm-Message-State: AOAM533pYsXroLhUImeyN6652cE/Dly0HagfhENmNN4sW4+x+Rvtm24V
        FgTdLo5TtjY0XcYoFqafxiMJIR2kYCV55j/dYQ0qGyY6+Yw=
X-Google-Smtp-Source: ABdhPJyU1U9OmnGSSgrP1fgEj44M3L/fedQ7tG39YQSpBFI6bT961WVFaF9igjMu4OZITtt9ixYnpvx8kzWHLGorPt4=
X-Received: by 2002:a05:6000:1ace:b0:203:d465:1a83 with SMTP id
 i14-20020a0560001ace00b00203d4651a83mr11518693wry.26.1648918151411; Sat, 02
 Apr 2022 09:49:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAB1LBmvX4kv3yqSZ+X4Ozkb9esUem3U1JY48kWVi_Eef78Sk=Q@mail.gmail.com>
In-Reply-To: <CAB1LBmvX4kv3yqSZ+X4Ozkb9esUem3U1JY48kWVi_Eef78Sk=Q@mail.gmail.com>
From:   Laurent Lyaudet <laurent.lyaudet@gmail.com>
Date:   Sat, 2 Apr 2022 18:49:00 +0200
Message-ID: <CAB1LBms3F1EGswxF9mO=JrmWmj4XFncv4ZrkAy-dvOHdVrkwLQ@mail.gmail.com>
Subject: Re: Git has two ways to count modified lines
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le mer. 16 mars 2022 =C3=A0 19:08, Laurent Lyaudet
<laurent.lyaudet@gmail.com> a =C3=A9crit :
>
> Hello,
>
> I check the number of lines modified by my commits by hand,
> and today I had a surprising count :
>
> 1) I commit and get the following count
> laurent@laurent-GL73-8SD:~/ReposGit/flow$ git commit
> [master c068911] Task CU-21ph8h7 add buttons in PresenceList: "Tout
> d=C3=A9plier", "Tout replier", for this the useState for showDetail
> (boolean) in Presence is replaced by a useState for showDetails (Set
> of ids) in PresenceList; correction missing tr between thead and ths
> in PresenceList.
>  2 files changed, 88 insertions(+), 48 deletions(-)
>  rewrite src/apps/logs/components/PresenceList.js (61%)
>
> 2) I check the diff by hand, it doesn't match.
> I check on github, it agrees with my manual count.
>
> 3) I try to get the same answer again in command-line.
> laurent@laurent-GL73-8SD:~/ReposGit/flow$ git log -1 --shortstat
> commit c068911547bddbf7bfc4ddc7a68ee8482421ed5c (HEAD -> master,
> origin/master, origin/HEAD)
> Author: Laurent Lyaudet <laurent.lyaudet@gmail.com>
> Date:   Wed Mar 16 18:40:25 2022 +0100    Task CU-21ph8h7 add buttons
> in PresenceList: "Tout d=C3=A9plier", "Tout replier",
>     for this the useState for showDetail (boolean) in Presence is replace=
d
>     by a useState for showDetails (Set of ids) in PresenceList;
>     correction missing tr between thead and ths in PresenceList. 2
> files changed, 71 insertions(+), 31 deletions(-)
>
> How comes git has two ways to count modified lines ?
> How can I make git output again the same numbers than just after commit ?
> How can I check how it computed these numbers in the first place ?
>
> Thanks, best regards,
>     Laurent Lyaudet

Hello,

I thought my email was sent to the right mailbox, at least it is what
says this website :
https://git-scm.com/community
> General questions or comments for the Git community can be sent to the ma=
iling list by using the email address git@vger.kernel.org.
Moreover this website is cited in the README here :
https://github.com/git/git/blob/master/README.md
> Many Git online resources are accessible from https://git-scm.com/ includ=
ing full documentation and Git related tools.
Is there any problem with my questions explaining I got no answer, please ?

I have found a partial explanation for the count differences :
>  2 files changed, 88 insertions(+), 48 deletions(-)
>  rewrite src/apps/logs/components/PresenceList.js (61%)
When committing, a file considered as "rewrite" is counted like m
lines deleted and n lines added if it had m lines before and n lines
after.
Even if the diff is much smaller.
Hence I answered my question :
> How can I check how it computed these numbers in the first place ?
But the two other questions remains :
> How comes git has two ways to count modified lines ?
i.e. What is (was) the purpose of this rewrite counting (when coded) ?
> How can I make git output again the same numbers than just after commit ?

Thanks, best regards,
    Laurent Lyaudet
