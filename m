Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E3181F97F
	for <e@80x24.org>; Tue,  9 Oct 2018 22:51:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbeJJGKY (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 02:10:24 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:38984 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725750AbeJJGKY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 02:10:24 -0400
Received: by mail-ot1-f48.google.com with SMTP id l58so3433418otd.6
        for <git@vger.kernel.org>; Tue, 09 Oct 2018 15:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=h3+W24+ZEct7Odt1QejG3QBhz/YBn2c5KjvdnsOntDs=;
        b=P9tRsco2+juCG6cTkiLscuQo/znZYgl30g/TU9PG/S0fAy0p6QxwFiKjJD1M/BgnOT
         mlKeN7fLaIffR6i6lZwrOoCiRjVZoxNM5hWD1D/arY9JYpYiWVKPUGsGm+azVUZP3J60
         Ml6736nVqPQpQRILEa92+wp7yyWdDuvJ6nZjkK5sNbEVF2BHi6Ze8CCccnyaolCcMTfx
         LPpSeVu3OVh/vN6lvuatnOCANnY9jkYYW1XwTgU6lpufBuYwcjSc9fY69S+IiuYKEz06
         NbTLn4JaFTM44xdPtWexzG3UXiFKKw1RhTzHd3DHd+AjWYsFYJFqJfTE/06vg5EkuasF
         Xj3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=h3+W24+ZEct7Odt1QejG3QBhz/YBn2c5KjvdnsOntDs=;
        b=luS975F2ahQyTOvVAYhDmClilFFSnGQxEU3nrrgJIhuk20EzBfyQeSk+MJHOrjK2QB
         A9kogJPYO5IX+BgYjJyJKppJ3ZBh2UY73IqRopMWGdzeM0Wjxrn/GPPvUUIe99Swx9wA
         sWEZxGFTd7/Zz2gXck/djYbxeEMQ2yvF8TOUbe5x1m3nffduT3Ef2TOlBUqZdcoHjV/W
         CN9rKrcy5I5CGFMm38Ug+Bl3nyiGlGxpcb73VrqhGDGnGVuIvPz2TkkKn1wHD65GBBCv
         omyRsQCU9jDeF1XfgTEogtdd8WGudM5/F54YctxghHz4fNkUPBs94Exn9GR+wLiKWv6j
         a5nw==
X-Gm-Message-State: ABuFfohTWA7hL4Zepg/LuoIOqKtHzJpGpdnVE0MRArQ+M/vp/WaKv4yJ
        OCHBCRGt07f44MZWNwy38YMfpqin8nm+RkEtD+XgFokd
X-Google-Smtp-Source: ACcGV62Sq7R5yXbZa5/XeeHbvLw0X6MndvVkzENPsntwenczLWkZ+fbd9KR/FD75IiMdHbGbE3oQrLdO27cmsEnOJ4g=
X-Received: by 2002:a9d:30c2:: with SMTP id r2mr17427649otg.143.1539125472443;
 Tue, 09 Oct 2018 15:51:12 -0700 (PDT)
MIME-Version: 1.0
References: <CACPiFCJZ83sqE7Gaj2pa12APkBF5tau-C6t4_GrXBWDwcMnJHg@mail.gmail.com>
In-Reply-To: <CACPiFCJZ83sqE7Gaj2pa12APkBF5tau-C6t4_GrXBWDwcMnJHg@mail.gmail.com>
From:   Martin Langhoff <martin.langhoff@gmail.com>
Date:   Tue, 9 Oct 2018 18:51:01 -0400
Message-ID: <CACPiFCKQq--xrMf1nF=1MmC+eESE_aKms3yogoRwCY=YxcOWXA@mail.gmail.com>
Subject: git svn clone/fetch hits issues with gc --auto
To:     Git Mailing List <git@vger.kernel.org>,
        Eric Wong <normalperson@yhbt.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi folks,

Long time no see! Importing a 3GB (~25K revs, tons of files) SVN repo
I hit the gc error:

warning: There are too many unreachable loose objects; run 'git prune'
to remove them.
gc --auto: command returned error: 255

I don't seem to be the only one --
https://stackoverflow.com/questions/35738680/avoiding-warning-there-are-too-many-unreachable-loose-objects-during-git-svn

Looking at code history, it dropped the ability to pass options to git
repack when it was converted it to using git gc.

Experimentally I find that tweaking it to run git gc --auto
--prune=5.minutes.ago works well, while --prune=now breaks it.
Attempts to commit fail with missing objects.

- Why does --prune=now break it? Perhaps "gc" runs in the background,
and races with the commit being prepared?

- Would it be safe, sane to apply --prune=some.value on _clone_?

- During _fetch_, --prune=some.value seems risky. In a checkout being
actively used for development or merging it'd risk pruning objects
users expect to be there for recovery. Would there be a safe, sane
way?

- Is there a safer, saner value than 5 minutes?

cheers,


m
-- 
 martin.langhoff@gmail.com
 - ask interesting questions  ~  http://linkedin.com/in/martinlanghoff
 - don't be distracted        ~  http://github.com/martin-langhoff
   by shiny stuff


-- 
 martin.langhoff@gmail.com
 - ask interesting questions  ~  http://linkedin.com/in/martinlanghoff
 - don't be distracted        ~  http://github.com/martin-langhoff
   by shiny stuff
