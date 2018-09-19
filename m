Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 418AB1F453
	for <e@80x24.org>; Wed, 19 Sep 2018 23:40:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbeITFVO (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Sep 2018 01:21:14 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:44734 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbeITFVN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Sep 2018 01:21:13 -0400
Received: by mail-yb1-f193.google.com with SMTP id s8-v6so3157285ybo.11
        for <git@vger.kernel.org>; Wed, 19 Sep 2018 16:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S4njkGN1+Tyfve/GDNpTB6xn5B1j4RkG/G1CDAghtp8=;
        b=p9QLHKSpM/aiKy/hBErHg3S5I4fifZCBPUU/8flWVq5Aki+ND3G+o2l9sn3aHkGS/3
         OXsnmdCHhzZQ6DueqmG6CLwmutqApcd/XkaMM+azU64UV8GJfh6j3+4iiTmV56YRAq83
         EYa4uMGWQ7BsSQBf9G1asBcGIlfoAmnc6VdL/jIJs7jJadE4q/reQrGYNO949l0UhiDo
         aol/A+4PcK76zftb1vD6btEd0vvzNFYU+XZXMVp3RX7qdoEWOSoljjVinJdreEw2zN/2
         72KEokqTV1mJjxlaYEDLRu5AR5Uf8hNL4werA5s1ycLH8pwfoqxB82fMSiYoE6DDXtCw
         aDBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S4njkGN1+Tyfve/GDNpTB6xn5B1j4RkG/G1CDAghtp8=;
        b=gG4ZHBbItgFbOt5BSOfGHzYQ7ijK8XOuauQ2KVHRFFMezJUFphFO30MumQXPXRJO7q
         XyKkv4ubpfsArDvLHsav/q9KuJVsw2V9M4xKqVIRRmR+EnEf6KxYGOh3z6nnZ/u0ey/E
         lxR1uXv4qcVxLd/f/s9eMyEAQGwa0pldHOpySE3+4mBCwwWgLuI3UxoqZ5F35stHOYTK
         mrVUAZNsnb9J0CVlpprOSd8n/mNMprKSuY8FcZuTxTCyLTPcNw73vX4T0G0tP9N1UXX/
         DGuyFkn7rBP3r/wdKKUQFZEZ+H46b2tGaLQxKiUWtK/ycwg40KgJkEdxZfyq0ryuSlY+
         Vd6w==
X-Gm-Message-State: APzg51BB45EgBgoal/08HSikIxNdax+yVCivVzzix6G1FNVbmDI9yoOe
        EsgX8r6AwZmh3gbbG6cdvlo7fbqYTf5+ao1PcRwyXQ==
X-Google-Smtp-Source: ANB0VdZD1kY8nXV7VwX1ah2egjRxqS3jvjoGNNBnu0RpG3YmKUC4LJ2ezrsoBkHE4FsuiKKLAeTMQSmb8LRzaa87KoE=
X-Received: by 2002:a25:8892:: with SMTP id d18-v6mr3339096ybl.521.1537400454715;
 Wed, 19 Sep 2018 16:40:54 -0700 (PDT)
MIME-Version: 1.0
References: <20180919161434.3272-1-newren@gmail.com> <20180919161434.3272-5-newren@gmail.com>
In-Reply-To: <20180919161434.3272-5-newren@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 19 Sep 2018 16:40:43 -0700
Message-ID: <CAGZ79kayKOmFhNxZyZ7-eumnLdK5-GtOb4OXFwdDP3qe4uQY7Q@mail.gmail.com>
Subject: Re: [PATCH 4/4] merge-recursive: rename merge_file_1() and merge_content()
To:     Elijah Newren <newren@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 19, 2018 at 9:15 AM Elijah Newren <newren@gmail.com> wrote:
>
> Summary:
>   merge_file_1()  -> merge_mode_and_contents()
>   merge_content() -> handle_content_merge()
>
> merge_file_1() is a very unhelpful name.  Rename it to
> merge_mode_and_contents() to reflect what it does.
>
> merge_content() calls merge_mode_and_contents() to do the main part of
> its work, but most of this function was about higher level stuff, e.g.
> printing out conflict messages, updating skip_worktree bits, checking
> for ability to avoid updating the working tree or for D/F conflicts
> being in the way, etc.  Since there are several handle_*() functions for
> similar levels of checking and handling in merge-recursive.c (e.g.
> handle_change_delete(), handle_rename_rename_2to1()), let's rename this
> function to handle_content_merge().
>
> Signed-off-by: Elijah Newren <newren@gmail.com>

I looked through the whole series and 1,2,4 are obvious improvements IMHO,
and 3 in itself is not worth it if it weren't for 4 (as now we don't
have neither
_1 and _one functions in this file).

The whole series looks good to me.

Thanks,
Stefan
