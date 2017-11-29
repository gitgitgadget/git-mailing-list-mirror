Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3237920C13
	for <e@80x24.org>; Wed, 29 Nov 2017 18:51:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752337AbdK2SvX (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Nov 2017 13:51:23 -0500
Received: from mail-vk0-f52.google.com ([209.85.213.52]:45830 "EHLO
        mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751791AbdK2SvW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Nov 2017 13:51:22 -0500
Received: by mail-vk0-f52.google.com with SMTP id s141so1851601vkb.12
        for <git@vger.kernel.org>; Wed, 29 Nov 2017 10:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=JkSUj8jUiELmKRNAJ3tNA/eOxGdSdsb3sOommfcUan8=;
        b=V0VQjSUIDoQMrLoe6WDvrjwC6t5lZ4MZ5ugOEJDW0aJX3CyjU1iPOG0vmbxFqJiOi6
         eML8CdF6jKdVTOwTW1Rnoi3UQiqStw/ILytV2DSh3N4+tiIQL6s9SAU7GNcmKIH0d9UT
         goApbBJoE744OBYQToSYcoBo9Cys4OKnx28QYNTs34q5ifsREUnX1+9GodeU+5VljlRo
         dC1DIjpJtemx7t04jEVu/BhCPhD8cxjp91WdRiitdXztmGx2nhm0f6QXBi57cGhr86GK
         j7ETSucdEEQUMIQQ+xGtSb4q0VOdHkcCbBErHa7F0DA0m1OaLsQRCHFSswS37fY2XWdP
         i6wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=JkSUj8jUiELmKRNAJ3tNA/eOxGdSdsb3sOommfcUan8=;
        b=k61PlOyk+DE0Mr7uAbhPwiZpCXje49mpTobfM9AXLDqNLowYC+CyTPmMM7d78hCluF
         CKEpCBygqX+ZKfRgIrWq9kNp4wxVyXgdSL5et6sVrc4gGDrx+hpp2qpB/2bh+ykci6nu
         9IBqXhuP7AZ8FQ78EDQiVVZmCtnRwCBeHUrajcREgkyHd6zoKP2YZku0eCjQLOaPo8u6
         TK4d/xQUZ0x9IcSnbnnJy1pZHbnZRDbqk3tLgm8cQgAjl8ye7qhsQEm40aI0iZxpOy0S
         Vqf/1AYjzIe3l+7ybVwE6AGZxNr93aP9sQbEZwdEk+GHU51xiAxlKUmhvUqHGov1HT3o
         K1ug==
X-Gm-Message-State: AJaThX6g77LUMN1LXMqhsFzBfL5lnGotsmfPNNqLl5NCwTSLCBOnDMN2
        j0xtXNF5raVI2/QpVKG1aNqY2NDksddyqT/OyNc=
X-Google-Smtp-Source: AGs4zMbMgy56Z8vKpG+Nw8Zrizo1dewslHsAzgHV5KXfRF1UE8Ym+MeBcf/mPh0pLbSJymmaVqsbRgvAQ8HgJUHKXdQ=
X-Received: by 10.31.82.133 with SMTP id g127mr3047542vkb.29.1511981480978;
 Wed, 29 Nov 2017 10:51:20 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.70.138 with HTTP; Wed, 29 Nov 2017 10:51:20 -0800 (PST)
In-Reply-To: <20171129183200.178183-1-jonathantanmy@google.com>
References: <20171129183200.178183-1-jonathantanmy@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 29 Nov 2017 10:51:20 -0800
Message-ID: <CABPp-BHEyXcjFzGvLHToz+2FRMM3g-mUTxn2uf8exQV61qff9w@mail.gmail.com>
Subject: Re: [PATCH on en/rename-progress] diffcore-rename: make diff-tree -l0
 mean -l<large>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 29, 2017 at 10:32 AM, Jonathan Tan <jonathantanmy@google.com> wrote:
> In the documentation of diff-tree, it is stated that the -l option
> "prevents rename/copy detection from running if the number of
> rename/copy targets exceeds the specified number". The documentation
> does not mention any special handling for the number 0, but the
> implementation before commit b520abf ("sequencer: warn when internal
> merge may be suboptimal due to renameLimit", 2017-11-14) treated 0 as a
> special value indicating that the rename limit is to be a very large
> number instead.
>
> The commit b520abf changed that behavior, treating 0 as 0. Revert this
> behavior to what it was previously. This allows existing scripts and
> tools that use "-l0" to continue working. The alternative (to allow
> "-l0") is probably much less useful, since users can just refrain from
> specifying -M and/or -C to have the same effect.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
> Note that this patch is built on en/rename-progress.
>
> We noticed this through an automated test for an internal tool - the
> tool uses git diff-tree with -l0, and no longer produces the same
> results as before.

Thanks for testing that version and sending along the fix.

I suspect the commit referenced twice in the commit message should
have been 9f7e4bfa3b ("diff: remove silent clamp of renameLimit",
2017-11-13) rather than b520abf ("sequencer: warn when internal merge
may be suboptimal due to renameLimit", 2017-11-14).

Other than that minor issue, patch and test looks good to me.
