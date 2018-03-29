Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3F1A1F404
	for <e@80x24.org>; Thu, 29 Mar 2018 17:58:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751913AbeC2R6p (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Mar 2018 13:58:45 -0400
Received: from mail-yb0-f172.google.com ([209.85.213.172]:38594 "EHLO
        mail-yb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750866AbeC2R6o (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Mar 2018 13:58:44 -0400
Received: by mail-yb0-f172.google.com with SMTP id o197-v6so2272896ybg.5
        for <git@vger.kernel.org>; Thu, 29 Mar 2018 10:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jh1Kz7ozcI4mQ3Z6vmUtrj2bL4HwZMBYjnIkg56cjSY=;
        b=pKQbQPzAujSKW1G3UUVd9MRvTO2nOa492aUjSZl3hWXgMqIXFb/1wdRPIzPP8pdqCx
         RmdN/OGx2Rnq2tSTehcqOhlzJ31nLWFVGXiOFxzxStcjarmu29WefiVkYOqwEPnodjAj
         4QpFTMWOeN4KGqtG8nokegBnBt/yuT+iusLDuOpMK0NFLVybwfZT0M4lFoF6kCLwMYlJ
         P2eK7yIMmb6DZ4InB/hp7JU4Ubb04lGLJItMvH0VUXE+lLHtKaBKQsg5ZECLcU6SsA/O
         y+m83736ep8IPipdhqHbdrQQlzCQM5slCGrUrW7fYQJ71IoabtSEWtQa7V3N71zQp+Mv
         yjyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jh1Kz7ozcI4mQ3Z6vmUtrj2bL4HwZMBYjnIkg56cjSY=;
        b=QW5ePDT37murT+TaXAlB++izQBUmLcNIcn5COA2S6+sQy2F4+QpJgCJxKak7qQDTe7
         uijUOjonyzjtJYyhn8Xpav8oViNJEnT3jS6dXHE3lf0/a7Vi6RPftYRJV/nOuah6K9yR
         fxxydhWGKPY4JZAlgjb1usOC5yZv9jT5GcTJtLE2QaKfW0JeVKHZKjjWQVlE7YiWWaSC
         glWT+nW4dpMJ0ryUBcVU+wnew3Jb+4W03IPHFLtxy1C2YJ7zyqjspVuJrxLaPCb2bo2b
         uCPm4PRXnJw0FMwDyACBw2uJLXYxyzd5YUsl5vsII1yL4PbIXwEZO7A9YCz8bPVQMhXo
         MSbg==
X-Gm-Message-State: AElRT7EME4g8a/qYp8XLY+M4wu7xDA5P2bUdOT+zgiV2FPzz9Pu8t8m0
        BcVeOZXHLAn+CCxZWWBFkr5zBWbLlkcJ97hc5r655A==
X-Google-Smtp-Source: AIpwx49GM2+oHRu6tzsa2RYF8kQvYVWzVZqEbxTtcDcqaq+VM6d4MWdSTEFGt4RMZvWPu16RFL983QMxMjSAUJlWXCo=
X-Received: by 2002:a25:9841:: with SMTP id k1-v6mr5568630ybo.352.1522346323695;
 Thu, 29 Mar 2018 10:58:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf81:0:0:0:0:0 with HTTP; Thu, 29 Mar 2018 10:58:43
 -0700 (PDT)
In-Reply-To: <cover.1522336130.git.johannes.schindelin@gmx.de>
References: <cover.1522336130.git.johannes.schindelin@gmx.de>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 29 Mar 2018 10:58:43 -0700
Message-ID: <CAGZ79ka41uD7A_64kz5oyrhCBci+oXmDGEVc6mHWyQd7d9avAQ@mail.gmail.com>
Subject: Re: [PATCH 0/9] Assorted fixes for `git config` (including the "empty
 sections" bug)
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>, Phil Haack <haacked@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 29, 2018 at 8:18 AM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:

> So what is the argument against this extra care to detect comments? Well, if
> you have something like this:
>
>         [section]
>                 ; Here we comment about the variable called snarf
>                 snarf = froop
>
> and we run `git config --unset section.snarf`, we end up with this config:
>
>         [section]
>                 ; Here we comment about the variable called snarf
>
> which obviously does not make sense. However, that is already established
> behavior for quite a few years, and I do not even try to think of a way how
> this could be solved.

By commenting out the key/value pair instead of deleting it.
It's called --unset, not --delete ;)

Now onto reviewing the patches.

Stefan
