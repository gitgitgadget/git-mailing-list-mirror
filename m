Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02069C433EF
	for <git@archiver.kernel.org>; Thu, 30 Dec 2021 13:20:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239511AbhL3NUD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Dec 2021 08:20:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233897AbhL3NUB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Dec 2021 08:20:01 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81CBC061574
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 05:20:00 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id j3-20020a056830014300b0058f4f1ef3c2so28343375otp.13
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 05:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0rZ8Sl+3cJ53EKtdQn52MrNAAaMgGepQVuKfPRt2aHQ=;
        b=VcYe70fB2SKhzmC1t4V+zEG3IZnPyJP1goOEtgCKVBB/AsqztapRBEJvRawBnEXzGc
         XT0xhZ8HsPNkoVCRVHBeQ5Q/2O1pTm7qpxJ4LGg7McU3C9hiTQ2RxNeeDc3mZZFdfem0
         D3ZsJiFaVjzW6MkyeHb2Rq0d7e8h1YFrehOUuYfaNzDvanqTR2rTwlGA0FjRMeITF+cW
         yCWhGoqOAh2y+w1XMrrb2OoHIncCil+LUEs+tfexZ/ZvtBNzPHOs2KaJG+IuozqLQoHq
         KbCOEw7ADd1+JtGUiQVe3H57NpHIXsQo/98AkcVZ3khr9RCsuklzK+N7I1BDmd2Q/2jY
         bJfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0rZ8Sl+3cJ53EKtdQn52MrNAAaMgGepQVuKfPRt2aHQ=;
        b=tcdfnPeVDBMV1NxDmrv2TGJj8Ibdn0UoSK7d9AP9kvwcUHMq92AvH5qimyLUUQVNkc
         BKTpftcwtnM71Z0msqJo2orOeTHHMDjaN+0gWDuXjBYHEfkh/k/DJfwUqFXwwb7m7mda
         e3BieUy/HxEKooxVzfKHrRpqYos1hw+YjucempufnAtmU9wiEACW6rp2ZcJrsZGwGdT6
         5sweiXslaFAGbYdp6+2gRpqCFsdHYSfJ1f2Et0YgZgElShYJT17UHA00nqs5DMe2bJVr
         LGftxOs4KIOo/pG5UEiBZETBcea4KZMhKdjNVc/L+vV2EBuqS7ak6wHNZpS+mRum4QIj
         MXmA==
X-Gm-Message-State: AOAM530rJaAT9QcsKsZhHJICJzP6VsfSWbgI8sguQOvPGkGeXnQJj13P
        9sd+cbg5Eyybylf1ljQJoTQ0fL/ETC0wgWtHxlIS13kYJoYvwg==
X-Google-Smtp-Source: ABdhPJxQLvffk2mWzihilE8wlHwsDvzy6LD37o6krMEFIBCDQ3Afot8WBCuMsiHsn+skuxuEw7MFSuzrZSvOZNg6968=
X-Received: by 2002:a05:6830:4b3:: with SMTP id l19mr20200529otd.153.1640870399629;
 Thu, 30 Dec 2021 05:19:59 -0800 (PST)
MIME-Version: 1.0
References: <61CC2DD2020000A10004691F@gwsmtp.uni-regensburg.de>
In-Reply-To: <61CC2DD2020000A10004691F@gwsmtp.uni-regensburg.de>
From:   Son Luong Ngoc <sluongng@gmail.com>
Date:   Thu, 30 Dec 2021 14:19:49 +0100
Message-ID: <CAL3xRKet7KXTx+6ALVZCxeFRkU3guwNc6GtAT1iofB=UKqj2fg@mail.gmail.com>
Subject: Re: Filtering commits after filtering the tree
To:     Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ulrich,

On Thu, Dec 30, 2021 at 12:28 PM Ulrich Windl
<Ulrich.Windl@rz.uni-regensburg.de> wrote:
>
> Hi guys!
>
>
> As  I know there are really smart ones around, please don't laugh how I helped myself with this problem:
> https://stackoverflow.com/q/70505903/6607497
> I'm sure you wouldn't have wasted hours with rebasing interactively...
>
>
> Feel free to comment either on the list or at SO (comment or improved answer).

You probably want to try git-filter-repo (1)
while using `--message-callback` as documented in (2)

>
>
> Regards,
> Urich
>
>

Hope it helps,
Son Luong.

(1) https://github.com/newren/git-filter-repo
(2) https://htmlpreview.github.io/?https://github.com/newren/git-filter-repo/blob/docs/html/git-filter-repo.html#CALLBACKS
