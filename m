Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 730D920D0A
	for <e@80x24.org>; Thu,  1 Jun 2017 18:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751122AbdFAS7p (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 14:59:45 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:36109 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751105AbdFAS7o (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 14:59:44 -0400
Received: by mail-io0-f171.google.com with SMTP id o12so42321331iod.3
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 11:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NhbqQ2mRZlcfX+m1UuTwHaVrrdcqo3uqWR9qepKAT5Y=;
        b=SYWWkYCkf1krAajQJs0nZItfNXrf48hv5fYDBVWySyWlRgyYmJWiM6jK4D5d2TWHaq
         zuGqsvoRWZu09aM/g4yWjrM3z6XLFKKPNTx4APrP993t1LQeq5hsCou+jDNn9s91E7it
         oz60y8uD8W6KsynS2wNULMEyaN0vaBRJyTAsdvl2TYcwZXLrHpHe7GQmdiFouGjXa7nH
         U5+NazaKN93rRZ8MY4Ed3sOX/8JTJfiD6xykp5H9ukscF0y8cWxLVQ0+XwEyuHz1ae/Z
         d0Ubjg1a1Wnno+W+vEPDzPptheMH8W6Kux6qGGGvHpkqe82Q505SORbaCmFv/54LDrmU
         d19A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NhbqQ2mRZlcfX+m1UuTwHaVrrdcqo3uqWR9qepKAT5Y=;
        b=aLLGqwOfEwDJ7DqjcJtRvGkLvUHGbc78Be7uGjcvBW26YhkDQUKUL9QLha25FLNSU2
         X7JLSZskmIIgO8aKjMeJn4NIrp89gOIZallrSnNDKrvuGFDdKFV7mpikqer11dytEQxk
         kF/RuO4eJDFDdvCZ1whmW8VRzTf7LwtvTil371yLxQAgPghOe4W6v2eZi2zHgl9+lRP7
         oIjm9kuUNmJ4YUW9jcjInAzb+t9T13fc030TYWwBvl1Lvd/kw1Qo/oeAhBuAlmWbHl95
         j4q0i4078bKJ1V0Hjky/Wyp0ZSfu8Z7G/2rawVe0uRDbv82EoK3JGiRIIbEc3LT1/d7M
         fFjA==
X-Gm-Message-State: AODbwcBfWqTEj6+/u+sgBoOEZ+sdIhVdB/mNPQNkYmMVaNN0uwc0qKep
        M/Xt2qHBbG6gstDNVHWCPxnYeSatBQ==
X-Received: by 10.107.178.215 with SMTP id b206mr498137iof.50.1496343583704;
 Thu, 01 Jun 2017 11:59:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Thu, 1 Jun 2017 11:59:22 -0700 (PDT)
In-Reply-To: <0102015c64f0dd99-a702d419-2bbb-48a3-b541-296011972e7d-000000@eu-west-1.amazonses.com>
References: <0102015c64f0dceb-02338e52-74d5-4d6c-9a9d-f41e98ff88bc-000000@eu-west-1.amazonses.com>
 <0102015c64f0dd99-a702d419-2bbb-48a3-b541-296011972e7d-000000@eu-west-1.amazonses.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Thu, 1 Jun 2017 20:59:22 +0200
Message-ID: <CACBZZX66dbdxuMx4EWdxYdRiMpBbXSbBCsmEO9uiEZYyyOmnDw@mail.gmail.com>
Subject: Re: [PATCH/RFC v3 3/3] branch: add copy branch feature implementation
To:     Sahil Dua <sahildua2305@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 1, 2017 at 8:35 PM, Sahil Dua <sahildua2305@gmail.com> wrote:
> Adds copy branch option available using -c or -C (forcefully).

Commenting on the series in general. I have a fixup branch for you
with commits to squash:
https://github.com/avar/git/tree/avar/sahildua-rename-branch-2 issues:

 - There's a mixed variable declaration  with code, should be predeclared.
 - Stuff like printf(_("% branch), "copied") gives bad translations,
needs to be expanded
 - Fixed up comment style

In addition when I try to run the tests I get:

    fatal: cannot lock ref 'refs/heads/a': 'refs/heads/a/b/c' exists;
cannot create 'refs/heads/a'
    not ok 45 - git branch -c a a/a should fail

And there's 18 other failures in that test script, although some could
be from that first failure, doesn't this fail for you? I can't see why
it wouldn't everywhere, i.e. you're trying to create a "a" ref when
"a/b/c" exists.
