Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E61B81F403
	for <e@80x24.org>; Tue, 19 Jun 2018 14:48:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757149AbeFSOsf (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Jun 2018 10:48:35 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:39894 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756726AbeFSOsf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 10:48:35 -0400
Received: by mail-oi0-f68.google.com with SMTP id t22-v6so18393062oih.6
        for <git@vger.kernel.org>; Tue, 19 Jun 2018 07:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+bBr7EOb1EbFULGxzckAA5oZNiYB97/AMsQOf5+sXsA=;
        b=pDpf9v6HxC4r/jo7gguMU8JFC2O1r/M9rZw0fcTWynouAhpE48ODKYXS2cp8sFujQE
         373FZAwD3CGGJLGIlHrUuh5MNqyqNJ5B/RDgZtJRL/HNGh9obSaYxygjGivq7BNAoq6g
         g/Xf7V6kbe9Vo04bjyAKh4BhFZjIBKbQiz3RpgYKDjljw04Y53RS1iGa4SgXNGeBPsjQ
         HycMIlOOhmUWEOj81/yVo3JS8Rw+rOmVEPWvHH/WubQHOnkKw/FmcxSKvvhOBqGC7+/9
         RS2/XMxXh6cS5s7igRdiETNZ3aU/I9E6XJVkYOcLF6A4rXqAShNg+D2N6kXJhs+RL95c
         K/Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+bBr7EOb1EbFULGxzckAA5oZNiYB97/AMsQOf5+sXsA=;
        b=VIXerKcBNAfpJdBwbeldpMJ3VxoZ2IRGUvMCgkbix6zBlXjZmZDWTYuuYzKxwO4wuK
         vXLF8iujnAbkEnq96D6kELO8Os5qKEB0sHDeuuLiiPx6AivEeMvBPDsRwjnH7tlW1knA
         D8Srw9TQLAkbtnYTlolCon0u18ysQQGOvXmva0SjFEoAGtxpFD9KzGy7JqvfkfxVvX6P
         3YTVwGB0slbhyPly+uX5VmgWvhnLd32EPrpgLsa/MSfBQaCLAUqLkm2t0qV/U6w/Mz75
         DzbakW1mCpQOeh+gcA57KOU9lVnrdWXvb3lBZOrekr8YiuoUT8RqEP8ceuiRV+0Qv5bU
         8j3Q==
X-Gm-Message-State: APt69E3IH+RLAkcSP7JJBEWASwvRV05qJ+CtE1d/ubn1DCeMmpBrpqes
        hCRvhwoTg0HZjOzpNLK2KXk02s9AYk1azcGbwEQ=
X-Google-Smtp-Source: ADUXVKIcY7NlliWCgT2m5KzBGdRNMVDtDegMNoIqmoJi/iYJMh6P6KHUVHlW5AH4M5yBlzQjBv+ZtNFtcIe6gXlsYYA=
X-Received: by 2002:aca:5144:: with SMTP id f65-v6mr10034785oib.32.1529419714420;
 Tue, 19 Jun 2018 07:48:34 -0700 (PDT)
MIME-Version: 1.0
References: <20180616054157.32433-1-pclouds@gmail.com> <2c01d5ef-7b92-bf1f-75d0-147910feec08@gmail.com>
In-Reply-To: <2c01d5ef-7b92-bf1f-75d0-147910feec08@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 19 Jun 2018 16:48:07 +0200
Message-ID: <CACsJy8BLGJHZMqoGbx20B+b8qb8cry0DNRmzrjNyEgxqo13NBg@mail.gmail.com>
Subject: Re: [PATCH 00/15] Kill the_index part 1, expose it
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 19, 2018 at 1:48 PM Derrick Stolee <stolee@gmail.com> wrote:
> Personally,
> I find it difficult to base a patch off of multiple in-progress branches
> and would rather work off of a "known good" point like the tip of master.

You should always base your patches on 'master' (or even 'maint' if
it's bug fixes that have a chance of entering 'maint'). We all we face
conflicts at some point (mostly when we rebase after something gets
merged to master; or things are merged on 'pu'). But git-rerere should
keep conflict resolution easy (most of the time). I also expect Junio
to kick and scream when patch series conflict badly on 'pu' and he
will decide which one goes first and kick others out temporarily.
-- 
Duy
