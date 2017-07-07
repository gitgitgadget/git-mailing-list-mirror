Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 232D1202AE
	for <e@80x24.org>; Fri,  7 Jul 2017 06:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751013AbdGGGUQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jul 2017 02:20:16 -0400
Received: from mail-qt0-f180.google.com ([209.85.216.180]:36745 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750974AbdGGGUQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2017 02:20:16 -0400
Received: by mail-qt0-f180.google.com with SMTP id i2so19790183qta.3
        for <git@vger.kernel.org>; Thu, 06 Jul 2017 23:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mazzo-li.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4Hwa9IkPbrMAhVIXxCV+qLAGk07TEHUC27cafBKPxkw=;
        b=VxwAALiXS9Vfm47o5ZEezs/E6CstYTzSjTfYi/ZKQpPdybRAMrErNul2eZZrRnqzHn
         JO1o6zt+Kh+D0mW3cFg95zcGqeEA+yoJv6pv95sm/zXpDA/vbR/p2M9li6bOcEkoIAOA
         dCPR7jmIBWlU0X+8yVskyszOHe/ExLJ3h4YnjEEkGznESnQsDJj6hCfuQxMWv8iSffZq
         UwE+IfD06lO9lgK1zJ1yzwCd1gFsaDY1b1ITvvVDOf2hnXXDzaCA0c/xNLyylYSQxJK2
         ffxiNuComVSphx3d6MuRzs2CXslLoGE26JCj4VW+yg2Gitr0LDqytdJHx+2QCMouZM2D
         sC5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4Hwa9IkPbrMAhVIXxCV+qLAGk07TEHUC27cafBKPxkw=;
        b=d1EwdUoa8q9eocE+YeGSbvyxxZaGyOyd6+ATdFnbWDksPPrBxleQo7l9vhx7G4Ly2U
         NLdbUNo59gnkU9ck7W/ExzFBAKQT4DHPodypOBGLPYBPf2IDlgbF8hTkTlqbYvZM5KyT
         jmlLZAgXrc6UqCX18YF10PYMq7ovSYCMeAz+e4WBe6Z/X6Kmzr/W+woHmddKfkKIVARV
         Xk/+hlds5SjFTTe6/G240KtiLtIVSNzakn6rO0FKRBslqV09HgDkmc2Rpe/FNmEF5FIP
         Clc9zV2mk7WSpyYDk8vSGnVQUzdjRJEHNjArcOoAPLkNxru5I7ESaJLw9nYszb7K00iE
         Qx1Q==
X-Gm-Message-State: AKS2vOzikyyuAClqdvaGdi4jK7AJNCN6fWIJsBANSIRXS2Qg6ZYjeB13
        vOEQVucKF8mgnnsfjR3LAzaOcVPvjrSTbDg=
X-Received: by 10.200.9.55 with SMTP id t52mr66542056qth.107.1499408415094;
 Thu, 06 Jul 2017 23:20:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.140.67 with HTTP; Thu, 6 Jul 2017 23:19:34 -0700 (PDT)
In-Reply-To: <xmqqy3s1e5uw.fsf@gitster.mtv.corp.google.com>
References: <1499116727-757-1-git-send-email-f@mazzo.li> <xmqqvan8jdje.fsf@gitster.mtv.corp.google.com>
 <CAPB=P5xsssm=RiAkEuAtpxe52+-sNAPVP2qnQGctLjNZFYznkg@mail.gmail.com>
 <CAPc5daXn=PJ47JkZQNnReNNSUhQK3eJm0Namd-A+e9TM4Dnr2A@mail.gmail.com>
 <CAPB=P5z7MA+TuVaFLUQQdOoJXUb74YxEPS6k4O+NorneVpLitg@mail.gmail.com>
 <xmqqa84ikj61.fsf@gitster.mtv.corp.google.com> <EA42AB04-D538-4B4A-BC19-CAE9A80EEA76@mazzo.li>
 <xmqqy3s1e5uw.fsf@gitster.mtv.corp.google.com>
From:   Francesco Mazzoli <f@mazzo.li>
Date:   Fri, 7 Jul 2017 08:19:34 +0200
Message-ID: <CAPB=P5xNDdexiyT_mVvcVmmuzS5RUqnhyC3VofPcs5-k5H8BBQ@mail.gmail.com>
Subject: Re: [PATCH] push: add config option to --force-with-lease by default.
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6 July 2017 at 21:13, Junio C Hamano <gitster@pobox.com> wrote:
> By that logic, a hypothetical update to `--force` that makes 1/3 of
> the attempted forced push randomly would make it safer than the
> current `--force`, wouldn't it?

It would. However, this additional safety is not really meaningful to any
workflow, while the one added by `--force-with-lease` is.

> When third-party tools fetch and update remote-tracking branches
> behind the users' back, the safety based on the stability of
> remote-tracking branches are defeated.  And the biggest problem
> is that the way `--force-with-lease` misbehaves---it is not like
> it randomly and mistakenly stops the push that could go through;
> it lets through what shouldn't.
>
> See the other patch I sent just now---with something like that patch
> that lets those like you, who know their remote-tracking branches
> are reliable, use the lazy form, while disabling it by default for
> others (until they examine their situation and perhaps disable the
> problematic auto-fetching) in place, I do not think it is a bad idea
> to advertise --force-with-lease a safer option than --force (because
> those for whom it is not safer will not be able to use it).

Fair enough, I'm OK with enabling it with some config. I'd still like a
way to enable it by default if I want though.

Thanks,
Francesco
