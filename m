Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E468120958
	for <e@80x24.org>; Sat, 25 Mar 2017 11:54:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751271AbdCYLyv (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Mar 2017 07:54:51 -0400
Received: from mail-oi0-f43.google.com ([209.85.218.43]:35380 "EHLO
        mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751210AbdCYLyu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2017 07:54:50 -0400
Received: by mail-oi0-f43.google.com with SMTP id f193so5876833oib.2
        for <git@vger.kernel.org>; Sat, 25 Mar 2017 04:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Eq0akkYLxo/uZgSFvZP0OTjUufvsboTH8dy5TjmaQns=;
        b=AKYkeSlK54uEyQNcAgV7fIu7ceFj8ysruf1EIwQME5DPTVcDi8waQteRCLe0QSbO4l
         W+N0zLKD2XX8NeNNFBW53cZ5rWKXsti87Vubtz4IQQ5pNNKnNeJTq1a/XFVoZWGoFl1p
         psLIOiYayBgZpnZtjKBhPqm3OXxvXRcV0Z9n4vbn3127s4sOYbCP90m7KsTrbmeEftu9
         DsTQe/cSnp8kt2cmbL/qb/fL0Yp11TWpSDyEBlSdzEPIdRoe5ITkx8wST3T7zKI/B/A4
         v3MvqYDORq/Hh4yDlEY3R5yZNdJAEGBsDggP+lxaX4PnLoBFdxZG/wKZPhXbKuU5g6PB
         tIYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Eq0akkYLxo/uZgSFvZP0OTjUufvsboTH8dy5TjmaQns=;
        b=JfiR141lkP15TpSZI0d/JidLBX9suvFnfadLVDjDOiD8Zu6gI9QlsgWOtLBQKRDyvj
         WGz6JPSMbzoGreKcknk7Vi/6v3PyXphJ0WiHm7HodZu+0k1jUp5HSH+OQr9tB4mf4U6h
         awoyNxCVBkOdcJdOejsMWwRyvat19uMSFAk0DGwZoS2XeHaChuA10kFUuB3QQ+GSZ4E7
         sDP406t+WOBo9+Y8a636dZPjJirULT+75GyCEsLiGEq7SyUiMQk5nh5CNGNrtiOmAIp9
         XjXpTR8D7oAg45SjxH66MNuup9z/9Xjv2Up6omIc4saK+YtyRmWmRX9pXf5ne8gYtmtz
         VPZg==
X-Gm-Message-State: AFeK/H1/fz9EtvxqXsjIT8N4t+7AOjz6lbY+RlNL/x6ZiJEsYzbva3Tfcz5i1zSe/NDYWez1G+e9JmXcb+kIZA==
X-Received: by 10.202.183.86 with SMTP id h83mr6001350oif.169.1490442889000;
 Sat, 25 Mar 2017 04:54:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.158.84 with HTTP; Sat, 25 Mar 2017 04:54:18 -0700 (PDT)
In-Reply-To: <20170322133735.ozjbncfm5tchygoc@sigill.intra.peff.net>
References: <20170222140450.30886-1-pclouds@gmail.com> <20170318020337.22767-1-pclouds@gmail.com>
 <20170318020337.22767-25-pclouds@gmail.com> <20170322133412.e2oqmqekreyuf4gr@sigill.intra.peff.net>
 <20170322133735.ozjbncfm5tchygoc@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 25 Mar 2017 18:54:18 +0700
Message-ID: <CACsJy8Bkzf8okX6oroHoXocBxfKvZQP469K_=fU==Ekv2DTxUQ@mail.gmail.com>
Subject: Re: [PATCH v6 24/27] t/helper: add test-ref-store to test ref-store functions
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        David Turner <novalis@novalis.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 22, 2017 at 8:37 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Mar 22, 2017 at 09:34:12AM -0400, Jeff King wrote:
>
>> On Sat, Mar 18, 2017 at 09:03:34AM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:
>>
>> > diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
>> > new file mode 100644
>>
>> When nd/files-backend-git-dir is merged to 'next', the new tests in
>> t1405/t1406 break. They need this on top (which should probably just be
>> squashed into this commit when you re-roll).
>>
>> -- >8 --
>> Subject: [PATCH] test-ref-store: setup git directory
>>
>> Without setting up the git directory, we rely on the ".git"
>> fallback in setup_git_env(). This will cause us to abort
>> once b1ef400ee (setup_git_env: avoid blind fall-back to
>> ".git", 2016-10-20) is merged.
>
> After posting this, it occurred to me that "pu" should be showing the
> same failure, but it doesn't. The reason is that e9e167145 (worktree.c:
> kill parse_ref() in favor of refs_resolve_ref_unsafe(), 2017-03-18) from
> nd/worktree-kill-parse-ref sneaks in the setup call.
>
> We should move it back to the addition of test-ref-store, though, since
> nd/files-backend-git-dir may graduate separately.

Right. I needed that setup_git_directory() for the third ref store.
But now that I think about it, I need it for the first two as well
because git_path() is always involved. Will fix (since it looks like
files-backend-git-dir is not merged to next yet).
--=20
Duy
