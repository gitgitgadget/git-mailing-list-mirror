Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62D1F1F404
	for <e@80x24.org>; Sun,  4 Mar 2018 04:34:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751819AbeCDEe4 (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 23:34:56 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:34987 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751756AbeCDEez (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 23:34:55 -0500
Received: by mail-qt0-f195.google.com with SMTP id z14so16723061qti.2
        for <git@vger.kernel.org>; Sat, 03 Mar 2018 20:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=QnNGENYkxjuclJdy9fOXNOiYxNEWvhNgT0LRQdd7DrA=;
        b=iQf3Fzk6TvmfrzMal7IfYnDXF9LUsV58zjwNJ+uI/+mXhuGLvGhEP6MrMjMwGmAm7r
         ddqdWD8IzHazldF8Z7JJr3q2mcWY5Lw8ejkGJqBk+n+3wpJ1k3R0+Zw/who67LH+gDuG
         cgwnVWakV6Q2ge2q/IWncBYITcjhmt1dUBQFV2ZUg2Iczbkg1v+7FRwxb/i2U3HmmX0C
         7CPfhkVGqum6uauMu6Gz1Qx/4zOusVP/EiXOtDjHlQsZ3S6RMblQeQ+3sfSBArz1VNgh
         tdVLYqjT7bLrOYfuC1qCLLiMFBlEz+7+04VaqoibC/vzTbc9km5zr7H78gvePTnESegq
         2/WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=QnNGENYkxjuclJdy9fOXNOiYxNEWvhNgT0LRQdd7DrA=;
        b=k6U3r8HtqvPW8mNLfZmQFc+0DHT0gGLKvKfxeqCt62sEfW2VnVhkXBlVliELPNoZ/p
         4x+0LFnxmfy+UnZvWa/Lacs3410GupTprhqHGPSphH1ZYltysZVxtW0K5cQYCW4bywtS
         0CGGT7SIh5cwlKrdXljYLqAP4EX7Jw8XmwOK79bMVIYheKnShBuvw8tL9Xxgl3obbQC0
         WtOUYHzxUkpysq9gZr7whcQYr0q/3G1Uqta+olEykA5nWQzVwvcj4EaF9BpbgeRY1qDN
         d2fPRG1gtYrAbO18HOI1XAsopXyHM2Urm7t//depY4Wj58cfgXvtdkSrlB1tkV615AcX
         N+0w==
X-Gm-Message-State: AElRT7HgTDLrz83OaW8VweaIAueWX52ygMF9TaOTvdPuF3Dx+W7rOUTJ
        zhtqetFNJzefEanYG0PJGaJ5xYVWUOANroHYIKY=
X-Google-Smtp-Source: AG47ELvi3n696L6xhjlwq7kJPDBxTLh9xaFk4jGtG6QzoLzP4nBPb+eHaQW+5R7bON7LttjGGS48YrUEB61xCVbJDpI=
X-Received: by 10.200.6.5 with SMTP id d5mr16723453qth.205.1520138094931; Sat,
 03 Mar 2018 20:34:54 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.142.14 with HTTP; Sat, 3 Mar 2018 20:34:54 -0800 (PST)
In-Reply-To: <CAE09B1Ky1_PKWq17Nm_Uc9sZn7khycR0aK2Z3AHnyjYoPMy8Qg@mail.gmail.com>
References: <20180303034803.21589-1-dorabpatel@gmail.com> <CAPig+cR=adC_Ok=FJw2APaLahXX_v1ix4ufEJyBhED5ruXaQxA@mail.gmail.com>
 <CAE09B1+XXJvrOucHwehUGk=Taio7sirfOh5gq7KGs4iZSpK=vQ@mail.gmail.com>
 <CAPig+cTyZAFx486Y9LrQuaK0qMnQEGD3U55sk9Vvyb_TgDz5tQ@mail.gmail.com> <CAE09B1Ky1_PKWq17Nm_Uc9sZn7khycR0aK2Z3AHnyjYoPMy8Qg@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 3 Mar 2018 23:34:54 -0500
X-Google-Sender-Auth: -_XmEhKam11GvyZc2QaBDs4d4R4
Message-ID: <CAPig+cRgBXj+XfT=iq1osxtEA+2dQpnjOTBkwJa94COHM-t9BQ@mail.gmail.com>
Subject: Re: [PATCH] git.el: handle default excludesfile properly
To:     Dorab Patel <dorabpatel@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Alexandre Julliard <julliard@winehq.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 3, 2018 at 9:57 PM, Dorab Patel <dorabpatel@gmail.com> wrote:
> Thanks for reviewing and locating the commits.
>
> OK, I'll re-roll and add the relevant commits. It may take some time.
>
> Should I just send the revised patch as a separate thread (with the
> relevant commits and history)?

That would work. You can use "git format-patch -v2 ..." to mark the
patch as "[PATCH v2]", and "git send-email
--in-reply-to=20180303034803.21589-1-dorabpatel@gmail.com ..." to tie
it back to this thread when you send it.

As a an aid to reviewers, it's a good idea to add commentary
explaining what changed since v1 and provide a link back to v1, like
this[1]. Place the commentary below the "---" line following your
sign-off.

(One more minor comment: etiquette on this list is to avoid top-posting [2].)

Thanks.

[1]: https://public-inbox.org/git/20180303034803.21589-1-dorabpatel@gmail.com/
[2]: https://lkml.org/lkml/2005/1/11/111
