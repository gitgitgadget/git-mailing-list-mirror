Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85593208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 06:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbeHFIJL (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 04:09:11 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:47047 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbeHFIJK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 04:09:10 -0400
Received: by mail-yb0-f194.google.com with SMTP id f10-v6so1310383ybk.13
        for <git@vger.kernel.org>; Sun, 05 Aug 2018 23:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+O1rH01I5ZWszgdNQGrEgH3EFL/ZLm9fugj3rthH014=;
        b=ECNozaZRatFKPf3igJ7EIgK3IsloO/UrZXkUmEPuxfRJArJbwNdydxoUKYO+lasoi0
         2LVJ9j/3fHT6uKT9Cd9ftSXk+CmvlSnudlRrT109ickciDifISktWsBee7SJ9N1m2B5p
         Hpr3jGrGjjW+HZZuCK9ZOeovKk/v4WaXVNeeY7vUjBjM4GnAyE2fB4OGbtmoB0a6A5/Y
         OecPk2X97O2LX1qtFfP4sbSocb3C4A6bJPIfa86dkUHwcKmdedOxbJTkFJ4AQuBy3AGP
         4yOJKk7vsJ5qMsznzwKt94aoAox9gtZwylYMjo7OXYq16t0qhuSROfuuuzS7L4YNz3s3
         ZRgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+O1rH01I5ZWszgdNQGrEgH3EFL/ZLm9fugj3rthH014=;
        b=LDJ65HqlZ3Uouvzlmqwa5oEeMSwL7iiznuCKuveGoAq9ete9XymtWw4APfvOl7wQ+o
         PKC6+gYzKhji6sDD6sJIekm1ptx6AFCfSRsI6UV4y7nVBdGGt27mTsbtiv8s9TLuf0dw
         fKvUfsvgjUrZ5B4RYmLN6TFsLNl2P/EF9gb3TOlF2aPZaT5R/YsD2LWGfnibxeKWvbqi
         NvLotRRRXYDma6KCPWLJHKIPoZ9HB0xkv4kUVCoe9wkxus0ezYzyX4CLLI+U8iXBkzaB
         as21H+uc14jg5jB1Zh+h11rMVy6Y85Eh/+RzPWA1xn9nZXJTBYHcBJBc6C4xXy2BwBF7
         e0RA==
X-Gm-Message-State: AOUpUlF3y6HrvNgUi7p8YUr4el8EQVMij/eOkxgbMfdjHJbFm04/Syzr
        SDXtJPUbe3Fyz66ggThnSxUWdxhTJ9nMMg6emIsfzpeb
X-Google-Smtp-Source: AAOMgpeWju1VWYNWxkS27j4Rjc+qgqM5wTRlPJ4IqvCCFkIURq8ShsP+OM2gAluvBVJ76y8e1mzMSdI11iie54pmV8Y=
X-Received: by 2002:a25:ea13:: with SMTP id p19-v6mr6805630ybd.167.1533535301943;
 Sun, 05 Aug 2018 23:01:41 -0700 (PDT)
MIME-Version: 1.0
References: <20180804015317.182683-1-sbeller@google.com> <xmqqd0uyt6hj.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqd0uyt6hj.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Sun, 5 Aug 2018 23:01:31 -0700
Message-ID: <CAGZ79kZnVEsvpicNu7LXkRcHuRqGvESfvG3DL5O_2kPVYrW-Gg@mail.gmail.com>
Subject: Re: [PATCH 0/7] improve range-diffs coloring and [RFC] move detection
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 4, 2018 at 9:57 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Stefan Beller <sbeller@google.com> writes:
>
> > This builds on top of sb/range-diff-colors, which builds on js/range-diff.
>
> As another round of js/range-diff is expected, according to
>
> <nycvar.QRO.7.76.6.1808011800570.71@tvgsbejvaqbjf.bet>

Oh right. I forgot to mention that in this cover letter, but Johannes
has had work issues last week and people threw lots of stuff at him,
so I concluded the resend might take a while. Hence I just put it out there
in case we're happy with the status quo of that series.

> I will refrain from queuing this right now.  Possible conflict
> resolution that won't be reusable when the base one is rerolled and
> this and another topic that depend on the current round of
> js/range-diff are rebased on top is not something I can spend my
> time on this week.

Thanks! I'll resend when appropriate.
Stefan
