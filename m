Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F1051F404
	for <e@80x24.org>; Sun,  8 Apr 2018 21:10:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752919AbeDHVKi (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Apr 2018 17:10:38 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:56318 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752680AbeDHVKh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Apr 2018 17:10:37 -0400
Received: by mail-wm0-f43.google.com with SMTP id b127so14171616wmf.5
        for <git@vger.kernel.org>; Sun, 08 Apr 2018 14:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=nIN1ls9PrNdzBPmo+aukV+42ZKj0nk2tBg8Y384Fswo=;
        b=cClI9MLQRlSGRxrvHzF4jaSTGpksnMcswO4WqSRQBiuBLc0Ubbf2Lt9WG5P9Vh78z2
         EvekCDF8+1MHtU4zsar7czGBpwWor3dbaDy7jif32ab5S0oVRXMQ1rbk1i/nFqve0dH3
         kg6r7MfsE7Kks3+7AHivSrdcR4Jobe93waQ6gCZt6AnBdqq05MWqyzT2lzeqd9yke5h5
         1APNuBJF1+EB3aM85xjgdnC1dzCoHWLfckwS06ZP1IJk08zlj720N9GNZtqcBw7tYeNC
         093/jOIoeafwKztFLuoaa5cdEm74lPzEHx+shvfyDu2hXwlU1ADU5iQqSH9fw/9mZlyh
         hB8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=nIN1ls9PrNdzBPmo+aukV+42ZKj0nk2tBg8Y384Fswo=;
        b=QRzF6YHVNOVGWZfZn/PFd0FVEhy30Jn62ZLTwEiQUzf9mbJ8aLjcC01Dfhd6rctHWi
         MkLLQYR1KGmwGs1J32gxRsEYvvkvNNfN8y67lVqEepcMlirxTC6aOimURxvvPd4OExko
         PB5zxFyI1oX0DONehNu7SskgVTN9SsIL4SFU8H+ahTIXGzDO1sUjbPRN5qrRnkvBR5ws
         i2U3jDI0beDm406D1I2zR7uiaS3QSRbyF1TLfZeEaNG9mjN8cEHixhC7bQZimHznH45M
         txIARaUjJMoE6huDteDoM43rwwv1L54+dwZj3NDgkUbNA5YQs4nN93fNyPUWXgqfxJUd
         jA0w==
X-Gm-Message-State: ALQs6tA2GtH1BahuhqROHciFMt1I3KoEGJCxDaMnXxLfx9spgcfG7DdI
        TsKpoc53gYf1633od68NQRv0iRrJt7ZVJzt+/X4EiyxT
X-Google-Smtp-Source: AIpwx48qUb8kuBc/ieQt87FFG4FztWXbSTwa/hJDfhpOzUeC9+reXtfIDwRM7adq7lLCgwPGFfsbzYCQG7Cy43DmhTM=
X-Received: by 10.28.150.210 with SMTP id y201mr20294519wmd.112.1523221836675;
 Sun, 08 Apr 2018 14:10:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.152.238 with HTTP; Sun, 8 Apr 2018 14:10:16 -0700 (PDT)
From:   Ilya Kantor <iliakan@gmail.com>
Date:   Mon, 9 Apr 2018 00:10:16 +0300
Message-ID: <CAFU8umhSAufzbPBDMVt4ekcWjPa4Yymh+NeW=BYa8ARuRuZcbw@mail.gmail.com>
Subject: After a rebase, ORIG_HEAD points to the previous tip of the branch?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Immediately after a finished rebase, is it true that ORIG_HEAD points
to the previous tip of the branch?

So that `git reset --hard ORIG_HEAD` will cancel the rebase?

P.S. I'm asking because most of time that is so, but there is at least
one case when ORIG_HEAD breaks that assumption. Not sure if it's a bug
or not.

---
Best Regards,
Ilya Kantor
