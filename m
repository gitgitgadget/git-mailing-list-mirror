Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8756120135
	for <e@80x24.org>; Wed,  8 Mar 2017 23:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751775AbdCHXQP (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 18:16:15 -0500
Received: from mail-pf0-f173.google.com ([209.85.192.173]:33364 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751286AbdCHXQO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 18:16:14 -0500
Received: by mail-pf0-f173.google.com with SMTP id w189so20596122pfb.0
        for <git@vger.kernel.org>; Wed, 08 Mar 2017 15:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QGbvp3335Wba+uZa69/ilaphvsACGMw7V0GWOsCx6ho=;
        b=SOi1JbFFdYkIxvps/jhilajKotNaP8R++PI/iT/Mz4JRxy7HF2IpWt31yOBBq7MuE0
         47SAWy0XInt8VS+X3Kz5AcRSEU0Ls0KJyKSqw+mznxUQlBQwAGbPMg13FafdY2XMlCGX
         wZ8fOzdgXdx5VNfRIAZdu4VC8bFY49/6IUCLC3buwp8pBU6GAGgWaHtDZqVLpd6bAW7B
         K1etU1WfYoVvh1QkDBQruwki1+lgjCQLRvJGIrVQ8f+4TM6Oz7rALRyi5UssRljlkepD
         lfnILN+s6pWHZjFH+vlAOEWKy6BlPKE+cpAFbq023YHKTqMO+udxmo05fXwDDaozdTY7
         DCWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QGbvp3335Wba+uZa69/ilaphvsACGMw7V0GWOsCx6ho=;
        b=DEfUM9D6bjCBzK4OEGdQ+6fTLwzT3xnkQnCrajSfiJeR+hkqDrI8cB4bmS/0QtJGSN
         71Swaw4oxntcq0PnRHLcKIXckU4e4zCsdlXNmU01k8a85yYll25mIYG4o+znayLR3x5Y
         N1Fu1bK6H4TVbOajbbdL5/6y4YCp2kQUkrPNMtrvfjdF5LAbSn6yBhLxwHZyG+PPKjW7
         C+oLZ8NLc4F1N64Jszaoapgd1kAl6tgYLqEg6RKPQJhRC/BM2CP48NPCi8CxW55JvQBp
         CIwNfxOAxVlTc0hXDDvuvLYUwBqM72NGrcAH77/Mi7DNX+253s7e2x44AipWZJgEq0Tv
         nm5A==
X-Gm-Message-State: AMke39nanmxq3PH5JRaKX9wes8ohWko4+ypJGvBUg6FyAXyJoH8eEHiWNh4ehs7reilg+5b/xElcFcHSWcQtJ/NR
X-Received: by 10.99.140.77 with SMTP id q13mr9902381pgn.179.1489014940891;
 Wed, 08 Mar 2017 15:15:40 -0800 (PST)
MIME-Version: 1.0
Received: by 10.100.187.5 with HTTP; Wed, 8 Mar 2017 15:15:40 -0800 (PST)
In-Reply-To: <20170308230512.30572-1-me@vtolstov.org>
References: <CAGZ79kbnpUtrKdjQdQ-r6rRuVvnawooLFk1bO8jOSgxNkx2Dbg@mail.gmail.com>
 <20170308230512.30572-1-me@vtolstov.org>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 8 Mar 2017 15:15:40 -0800
Message-ID: <CAGZ79ka7PNKq5JWLPujvVHJWf6eEUadaJXd5AmKEvKT_y1ghOA@mail.gmail.com>
Subject: Re: [PATCH] submodule--helper.c: remove duplicate code
To:     Valery Tolstov <me@vtolstov.org>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 8, 2017 at 3:05 PM, Valery Tolstov <me@vtolstov.org> wrote:
>> Then the next step (as outlined by Documentation/SubmittingPatches)
>> is to figure out how to best present this to the mailing list; I think the best
>> way is to send out a patch series consisting of both of these 2 patches,
>> the "connect_work_tree_and_git_dir: safely create leading directories,"
>> first and then your deduplication patch.
>
> Is there a handy way to forward your patch in new patch series?

No there is not. :(

Here is what I would do:
* Take the patch and "git am" it (you probably did that for testing already.)
* use "git rebase --interactive" to get the order right,
* use "git format-patch HEAD^^ --cover-letter" to create the series.
    (This will take care of e.g. rewriting the patch to be numbered correctly)
* use "git send-email 00* --to=list --cc=Junio ..." etc to send it out
as a new series.

Alternatively you can take the patch file you sent and that patch and
manually edit their numbering and send them out.
(PATCH 1/2 and PATCH 2/2)

> Also,
> should I start new thread for new patch series?

As you like.
As far as I understand, it is very easy for Junio to take a whole
(sub-)thread of patches and apply that and make a branch with
multiple commits out of it as he has tooling for that.

>
> Regards,
>   Valery Tolstov

Thanks,
Stefan
