Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 079331F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 21:11:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbeKNHLS (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 02:11:18 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42076 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725748AbeKNHLR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 02:11:17 -0500
Received: by mail-ed1-f66.google.com with SMTP id j6so6780745edp.9
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 13:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KDf9d+gWZj6JNUxbuIJR7lsucnBm3DffuUwCCnNl/U0=;
        b=iesT1F7H/nvaTl3UroSNZs6fh7TeKFxwrmhCIxpwGaBkL1zvLTdIyx5AFslwKKh2Pe
         NMir1Sva7LvLfQ3Eby/A/x9chPHmQ+Qb4xcgYus+s8VgpfJvyZ34oWmwrm8JRajQ0pL6
         zUXyCcVAltDccqFn1B1yx4tGaCMZNoZFQwAUy/tjrNQa9XRzM/QOuv07g2r0j4nB7Scv
         e4kR5Xx9jWTi0gUG3PFdqWswkx2plugebUWDIvx7ma9vplJC4y+U6criakfdGzc0GKM2
         tctO0YeLBPxUZWpexFoJ+KLWRRNSPS9nsbNTStjBCrYNzUhezOR+jIvmp3i83gckh2N5
         4pFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KDf9d+gWZj6JNUxbuIJR7lsucnBm3DffuUwCCnNl/U0=;
        b=R59FsP9ATkCKP09WEyiYmkyq1CYnVpCiOL75iKJZFHTKjkFfw/+f13OEnDZy3C9TjB
         32ZIi7qtdoJSiOU5tUyyL0lMPb2DWONP8zkjDHCbsYjQ0Zj11dVr3YkejuoMRWWLxJ5M
         o1KtrPUi8pRSORqMRLIeW6x59CEkdeTJUakcZIatDnHRZHAgbW7ZRq6MICFWcy8/VjWx
         VUCDC6PgmcsrmLk9ZoP9tFNz1pOuK6wR5GZnXeZhKUgL7NDXARDFbAinttHs5ti9J7f2
         TovmA4KRSVQ17IKHkoMHg48F9ILVbeqvODF/gYzT4DekLkz/1qmLIAL0vAcJ3Jjv0cIY
         /KKA==
X-Gm-Message-State: AGRZ1gI0kM6D/GPh/wWVZeHHZl69xkgCIO9wxOl9IJ9QktUjWEwgbhG2
        Bpi5c45rd74g3rZn8o/oTPTQ4aMWxdDbdNsAA4VggQ==
X-Google-Smtp-Source: AJdET5fkaCDodgbT1EA3A8h+IC5RbcUqRj2MHMrjBbAO0oNWBJhSz1p21L7dT/kHk1+Yt+M7cqo2QelIWUBGW4HLpW0=
X-Received: by 2002:a17:906:f04:: with SMTP id z4-v6mr13759541eji.106.1542143478191;
 Tue, 13 Nov 2018 13:11:18 -0800 (PST)
MIME-Version: 1.0
References: <pull.79.git.gitgitgadget@gmail.com> <6276372ad3dc6fa4b9b352abb2b0192a6d010528.1542121775.git.gitgitgadget@gmail.com>
 <CAGZ79kYR_mQmtOuW7SEZ92K_o0f_C2enJJ1Yt=V3tyvi-A53+A@mail.gmail.com> <CAK8L4uiMHrsdwJz9+rD1tSCywL2kHosx-hKZdS=UtZDHLy464A@mail.gmail.com>
In-Reply-To: <CAK8L4uiMHrsdwJz9+rD1tSCywL2kHosx-hKZdS=UtZDHLy464A@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 13 Nov 2018 13:11:06 -0800
Message-ID: <CAGZ79ka8tpP7Ph_H8rguomPXoO2J6rDoOKAJTa1b6RSowRwZHQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] bundle: refuse to create empty bundle
To:     gael.lhez@gmail.com
Cc:     gitgitgadget@gmail.com, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 13, 2018 at 12:33 PM Ga=C3=ABl Lhez <gael.lhez@gmail.com> wrote=
:
>
> Hello,
>
> I don't know why I receive these message (and especially now given the ti=
me at which I pushed this) but I suppose someone (Johannes Schindelin ?) pr=
obably pushed back my original commit from git for windows github to GIT gi=
t repository.

Yes that is pretty much what is happening. Johannes (GfW maintainer)
tries to push a lot of patches upstream to git and cc's people who
originally authored the patch.
Thanks for taking a look, again, even after this long time!

>
> If you think "bundle: cleanup lock files on error" is better, then no pro=
blem with me. I'm not a native english speaker and I simply expressed the r=
eason for my problem but - after reading back my commit - neither this mail=
' subject and my original commit subject (see https://github.com/git-for-wi=
ndows/git/pull/797/commits/0ef742a1a92ae53188189238adbd16086fabf80a) expres=
s the core problem.

I am not a native speaker either, which makes it extra hard to
understand some commits. ;-) So I propose a wording which would have
helped me.

> As I'm not accustomed to pushing on GIT 'git repository' , please let me =
know if I have something else to do ?

I don't know how Johannes handles pushing changes upstream, maybe he
will take on the work of resending a reworded patch.
Let's hear his thoughts on it. I would guess you're more than welcome
to take your patches from GitForWindows into Git itself.

Cheers,
Stefan
