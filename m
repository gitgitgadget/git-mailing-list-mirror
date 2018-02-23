Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F98F1F576
	for <e@80x24.org>; Fri, 23 Feb 2018 10:18:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751605AbeBWKSH (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 05:18:07 -0500
Received: from mail-ot0-f174.google.com ([74.125.82.174]:35418 "EHLO
        mail-ot0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751413AbeBWKSE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 05:18:04 -0500
Received: by mail-ot0-f174.google.com with SMTP id p8so7050424otf.2
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 02:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dZ3HCUepqieM8HY2EWS+Aa/5muiEU/fPEyZuTQ+rDio=;
        b=F3p2IcjFLNScqqojkWovnSGjyoYgepq9gOo0Jge1RtkeVrNlo1UszG/FnJ4d/4ZH8i
         FMplMImc4KaIZN0tGZhxZizcI22lrRNtDorKzWC/1F8zKqF/ndGdPmujZ6Pd0XWwEqJJ
         Ib0p7EKJH6cHhN1lI+VZFoSVsngo8gbb5ncV2mmcez87MPvYTIXWlyvgPDjpGpj9WcSA
         MnCMatPaUsWAnHBT2Z5awwYXIcLWIQoxFRP8AatpT0uZ4/vDhG+3CdJVsC641wwxVOne
         OQ9pytzDkaWG8bwQomGzesslF+MDu5wIz0AuN2/GachKTGhw0KEX+M0gm8xiEsgWJATf
         L8MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dZ3HCUepqieM8HY2EWS+Aa/5muiEU/fPEyZuTQ+rDio=;
        b=r81rI6K7VCHfz9+J5/zVoAAQjqPPun/Jk1nw8qTOuB343WQbNWSxR1K68lapFsIQ7o
         GizP37Q+GiZLJJKDTJ4OOPG9NC3TtBlmOXtFkLY+Uuh/GtBsRJhmdKMwASv2ZciA3fJP
         b4/6gPqIDE1kVHJQowta0BTdjbgJ+v4Rr/poBlKLk3J3lvBUDUH9IP3hLf1wygHON7Sr
         adMRNhY3USnjokGiSjN9Rc90rBgMPXyg2PtEUD6IJhh7KP/btrC9Cra6G5MpKfurpbMP
         Lt4N3AduewFe85yeHCF8YqVwbMFqSBYxlJYjb4bzjIlABSxMWrB+Sqd9FFOunkxgPJjd
         QXUw==
X-Gm-Message-State: APf1xPBVyhFP0Q8PKIAAYwFT5Zgiod24ZXYKe+ouaOWAyhdTTOdHvaoS
        uK1zcNK5Mvg4LmSz2m50tYpWVnjMcw1YOMav/Yw=
X-Google-Smtp-Source: AG47ELv21R4eMYxwG9mYAlnVi4JbdI4zeJA0TwoyzAL0nk/kAG+G+zoQmD8axWa2t0SW2INFJxVEIDns3kNJcq5OfL0=
X-Received: by 10.157.54.161 with SMTP id h30mr702582otc.173.1519381084381;
 Fri, 23 Feb 2018 02:18:04 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.25.140 with HTTP; Fri, 23 Feb 2018 02:17:33 -0800 (PST)
In-Reply-To: <xmqqsh9sx4xk.fsf@gitster-ct.c.googlers.com>
References: <20180131110547.20577-1-pclouds@gmail.com> <20180209110221.27224-1-pclouds@gmail.com>
 <20180209110221.27224-7-pclouds@gmail.com> <CAM0VKjmFEyr4qHdc1qfW0M_RZ7cM9bCfsn-M4Rapzt6CPhZE1g@mail.gmail.com>
 <CACsJy8CWdJJigQSEjGuhoH1URGY8=YSAHiqhaGBZK7Zr8GZUGg@mail.gmail.com> <xmqqsh9sx4xk.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 23 Feb 2018 17:17:33 +0700
Message-ID: <CACsJy8DWwOezWpTVmpndhvhujzGV79uT2RqpZJxcp7oLr7G+-g@mail.gmail.com>
Subject: Re: [PATCH v3 06/42] completion: use __gitcomp_builtin in _git_am
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 23, 2018 at 1:19 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> Now that you mention it, the only command that completes
>> --rerere-autoupdate is git-merge. Since this is "auto" I don't think
>> people want to type manually.
>
> Sorry, but I do not quite get the connection between "since this is
> 'auto'" and the rest of the sentence.  Is it just it is so lengthy
> that people do not want to type and are likely to use completion?

Well, if it is to be done automatically, I should not need to tell it
manually (by typing the option on command line). Granted it's a weak
argument.

>> Maybe I should separate these changes
>> _and_ remove --rerere-autoupdate from _git_merge() too? At least that
>> it will be consistent that way.
>
> Hmmmm.  Why not complete this option?  Is it because the current
> completion script does not and we are trying to preserve the
> behaviour?  I do not have a strong opinion either way, but just
> trying to understand the reasoning behind the choice.

There's not a strong argument for not completing this option really.

It may belong to the unpopular category and adding it may make people
<TAB> more for other options. But I think it's way too early to decide
that. And even if that's true, I think we should let the user choose
to not complete certain options they don't like.

It's good that this is spotted. I think I'll just keep all
--rerere-autoupdate completable. Well, v4's coming (in a few days)...
-- 
Duy
