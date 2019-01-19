Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF1F61F453
	for <e@80x24.org>; Sat, 19 Jan 2019 18:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728945AbfASSFW (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 Jan 2019 13:05:22 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35612 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728668AbfASSFW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Jan 2019 13:05:22 -0500
Received: by mail-lf1-f67.google.com with SMTP id e26so12760289lfc.2
        for <git@vger.kernel.org>; Sat, 19 Jan 2019 10:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4mDihb0tvNP8ezY20uqsl31ddpYaCrqOH04y+iuhc6I=;
        b=XUUNK7TKFf/FC/1qFv23bLL6rnTTuJoryJ5ohAhVFL+6mS5ceFPCL+T5AVLbgd5GK5
         UaqnY29Dmw5JFXdeqtvNXNdT3pdWk2eMM6bTyHjTCxsiN50Wrg/CeK6O4nOGuJIcpvDg
         VeeV3JYB3dwLuWXNmue+CeJ82XvPFZxabYJly99GKopfk99JkM3KjRRMPywLhmTqMdvk
         cTJH2NNmqEMuQDyjR/2XCb972vPnyDHUpK1MYbK2MO/h/e8KmMtNxIABn8RydVqIV78h
         TaHnC+Oitpub4i/hC8qqxca/8ZeIRwJTYA9BmMSBRrHLnOJN/9wF0H3gWu3l0S4un+zL
         HkYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4mDihb0tvNP8ezY20uqsl31ddpYaCrqOH04y+iuhc6I=;
        b=DjbnpuwR36s1aZKtktF5h5YWxxXuzFP2uF2GD6bRgX0sd8jS1vE2iwpy2tTRbnJgKb
         zTiqUmloGofSHe7FK6lUJs3WhyCodMOY4CgBipNsaE8qLIZyPacwfblL63QctGJT0ej6
         SXq6WpJFTc4NZXSZlRLSM8oN4LbCF8K655uL/djYtVnd4vk/fwPlGyg8LtLQgD2TxDoN
         dbc7mGrGl12SbYJgdjRxNgWK0LTaklNoNaZqa5n56oLjXQTR+/6ceKF/ZLKSsTftQjht
         0W85uaUQIi9GAe4mrANwkQxC5o2xvmLsVFDyXA56g+1miucyVedHjxtMM2wn9st7OfZi
         Sy3g==
X-Gm-Message-State: AJcUuke6bYdZS8G0THIHqo4okMe9V4O3WMyOm/TchOU6Sb9/fakCSeGC
        JZB8jeeIqtHTzbHuyN60vQKf7WxQgajv0AxqrvM=
X-Google-Smtp-Source: ALg8bN6Fm1o56qlJnkwwwd9C4AtSElD6Mf50eDZawc3GCaQHzFpmeam9FpHG+pV2X+4wUqG/XmRxD6yvOA6t+MsoqF8=
X-Received: by 2002:a19:4ace:: with SMTP id x197mr14675497lfa.39.1547921120504;
 Sat, 19 Jan 2019 10:05:20 -0800 (PST)
MIME-Version: 1.0
References: <20190119033530.4241-1-brandon1024.br@gmail.com> <20190119154552.12189-1-martin.agren@gmail.com>
In-Reply-To: <20190119154552.12189-1-martin.agren@gmail.com>
From:   Brandon Richardson <brandon1024.br@gmail.com>
Date:   Sat, 19 Jan 2019 14:05:09 -0400
Message-ID: <CAETBDP5Ve=85Jtkb55=htPO1eiZQmqG7deUX_BF6ih259gY-XQ@mail.gmail.com>
Subject: Re: [PATCH v3] commit-tree: add missing --gpg-sign flag
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Martin,

> I looked into this test in a bit more detail, and it seems to be quite
> hard to get right. Part of the reason is that `git commit-tree` requires
> a bit more careful use than `git commit`, but part of it is that the
> tests that we already have for `git commit-tree [-S]` right before the
> ones you're adding are a bit too loose, IMHO. So they're not ideal for
> copy-pasting... I've come up with the patch below, which you might want
> to use as a basis for your work.
>
> That is, you could `git am --scissors` this patch on a fresh branch and
> `git commit --amend --signoff --no-edit` it (see
> Documentation/SubmittingPatches, "forwarding somebody else's patch"),
> then base your work on it, e.g., by cherry-picking your v3 commit.
>
> I think you would want to add 2x3 lines of tests (3 for `--gpg-sign`, 3
> for `--gpg-sign=...`). That would give you eleventh-signed and
> twelfth-signed and you wouldn't need any invocation of `git commit` (so
> no thirteenth-signed).

Just finished adding in the changes you suggested, and everything looks
good on my end. I based my changes on the patch you provided.

> Or, a bit simpler:
>
>   oid=$(echo 10 | git commit-tree -S HEAD^{tree}) &&
>   git tag tenth-signed "$oid"

Just noticed your latest email. Do you prefer it this way? If so, I can amend
what I have before I submit v4.

When I submit v4, should I submit the patch you created as well, given
that my changes are based off of it?

Brandon
