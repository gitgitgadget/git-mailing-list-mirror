Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A693F20970
	for <e@80x24.org>; Mon, 10 Apr 2017 08:08:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751864AbdDJIIu (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Apr 2017 04:08:50 -0400
Received: from mail-lf0-f49.google.com ([209.85.215.49]:34208 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751442AbdDJIIt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2017 04:08:49 -0400
Received: by mail-lf0-f49.google.com with SMTP id z15so66385644lfd.1
        for <git@vger.kernel.org>; Mon, 10 Apr 2017 01:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=iH8t6QM9bjTR3Qr6Vmn97Fm/e1KPkyXzC1u0FWpUz+M=;
        b=s04yMRqjFPVlZTd20NkNSlJfLrE41JbuVjN/QV7ojMTPNfQfvAy/jdOPA6f1f7Pqh/
         G3lqdpw2y4KrgtuKchlvpwGlJ/JoT+sobcVZ+WhWVoGlAJlGnhcJn+qRcgG2vIzBj6iB
         SmQ9bzI5zq+Scg8dhtjz/jTtGboPy4beadiastTg6Yum/T0tsJ2nWubOm5HIoKcLdSnb
         5bZrFe08TTIV50P/v/5b95NVaMA9YRYeLa50pTUTr68dTd7ZBfbPO/NjlqzdwAsVjFXi
         1eGZh8tQ0uBL3OfRmYFQrQ0A7fHI2H3vn9Y8VJBbv9xINELclZRGVL3QdJgbIWNZFbGR
         AXzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=iH8t6QM9bjTR3Qr6Vmn97Fm/e1KPkyXzC1u0FWpUz+M=;
        b=VRqRSIS9Vr+arqh4ZbA+cl8A9KCq7oi5dCaWJyQCdSxq2jenHyjlr5oZlvuc3Vzmtk
         coczHLYr8z6vCraLJBX/XxF9hd0DH5gVgj1B8M0Zi+l+mWbccKrFVe4zkE6QMpojPNWG
         fapb/yTQCm1/shCHgQin/ot6oHWREFP3LFoae5CKj7wOrAKzPpSoYzKWcW3CUJMm+Epy
         tO0pV1cLhRy1QVGft5ETJfOeVOnJQDIIxv5VdzG3ChknqGqb+/FhvNDlfdpBQR+AiSHv
         ugo8Ewm4nEDnVH3UgT0PcUDqayjpzvy6dx89yfp7jUCNj2AKChLrRL6jVTdcOnBZyaaI
         UaBA==
X-Gm-Message-State: AFeK/H1ko51v2QfznP3QQxETxBXI4d/bSYbqorNeRRfnolABQPN2GRZcJ9HFxp5spt6Ntu4os5WsVweHrZ4uZA==
X-Received: by 10.46.81.25 with SMTP id f25mr13411901ljb.119.1491811727979;
 Mon, 10 Apr 2017 01:08:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.145.30 with HTTP; Mon, 10 Apr 2017 01:08:27 -0700 (PDT)
In-Reply-To: <1n47so5.9e6qvf1bbqww4M%haller@ableton.com>
References: <CA+P7+xqS1Fh0aDV=QYbVMdRa=M4e-mBtjvknR=U_RShDoccNjQ@mail.gmail.com>
 <1n47so5.9e6qvf1bbqww4M%haller@ableton.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 10 Apr 2017 01:08:27 -0700
Message-ID: <CA+P7+xq6MJa-J5cj2Om20d+g7KBretShpxH=13HWV7vFR9be8g@mail.gmail.com>
Subject: Re: Tools that do an automatic fetch defeat "git push --force-with-lease"
To:     Stefan Haller <haller@ableton.com>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=3F_Bjarmason?= <avarab@gmail.com>,
        Matt McCutchen <matt@mattmccutchen.net>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 9, 2017 at 4:00 AM, Stefan Haller <haller@ableton.com> wrote:
> Jacob Keller <jacob.keller@gmail.com> wrote:
>
>> Agreed. You "take" a lease whenever you push to the remote or when you
>> pull from the remote and when you pull into the branch. It should
>> store something that tracks both the branch and remote branch together
>> so that you can generalize it to multiple remotes.
>
> I don't see why it has to support multiple remotes (but then I don't
> have much experience with workflows involving multiple remotes, so I may
> well be missing something). A local branch can only have one remote
> tracking branch on one remote, and in my view --force-with-lease without
> arguments works with that remote tracking branch only. Is this view too
> simple?
>

I think that's fine. Thinking in terms of only one remote at a time is easier.

>> It doesn't necessarily track perfectly with a branch that contains
>> extra work such as when doing pull --rebase, but maybe you have an
>> idea about that?
>
> Maybe I wasn't clear enough about that in my proposal, but I propose to
> always store the commit hash of the remote tracking branch as a new
> lease after push and pull, not the local branch. This way it works
> nicely with pull --rebase and a branch that has extra local commits.
>
>

Oh right. The main thing it doesn't give is that this doesn't enforce
that your local branch *has* to have at one point prior to the push
matched the remote branch that you're overwriting, which would be even
more evidence that your changes are what you expect and aren't
deleting anything unexpectedly. However, I think that's not strictly
necessary to require that since it would also break pull-rebase
workflow anyways.

So something like:

For a branch, also store its last known "lease" sha1 value, which
updates once every time that we push that branch to the remote
tracking branch or any time that we pull into the branch using the
remote tracking branch.

This value is what we would default to, and we only need to store the
latest one, since that's the last known good value. If the value is
wrong then we will error and avoid deleting work, and if it's correct,
then we know that the remote branch is correct for this specific push
and is safe.

I think this is straight forward and reasonable approach to solve the
problem, and makes using force-with-lease much nicer.

Thanks,
Jake

> --
> Stefan Haller
> Ableton
> http://www.ableton.com/
