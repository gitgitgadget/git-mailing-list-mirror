Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FC2B1F404
	for <e@80x24.org>; Mon,  9 Apr 2018 19:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753464AbeDIT0U (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 15:26:20 -0400
Received: from mail-ot0-f179.google.com ([74.125.82.179]:35740 "EHLO
        mail-ot0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753070AbeDIT0T (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 15:26:19 -0400
Received: by mail-ot0-f179.google.com with SMTP id f47-v6so9959969oth.2
        for <git@vger.kernel.org>; Mon, 09 Apr 2018 12:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=f/9aot2kajFIT8uqM9f0Rshq5HLk+NTMRARggdHXLGo=;
        b=cB4k1/ytniWPc+U0uKgmUQTKmxVZ2jfZsiL4sKcKzuoVp0c23K7l69y4CilvEbnkSw
         o6K0xdkp6VdCJM1tUMMDOZbSRdUUl5NXv8KNUo8KRUMq3nN3RY6pcxl5f/zQPN0KEBZd
         4OLySEUwEgpgyROtqrW5nEjMwKu2sozDOphlWthoNQdxXoR51QUrT3GO006rj64TXDP3
         n49FifSHuApvSw54B7W1m9l+rXuYwOVy2NEPH0/ckYTqU2PFSavkCmv4JpgTdN38akoM
         iaTBR2uryVXoPweYKzZkiHpDljo+qsT69wjSb+OL0ZGC+eLoH82KW/FZGOoNNwmRDtMP
         1fsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=f/9aot2kajFIT8uqM9f0Rshq5HLk+NTMRARggdHXLGo=;
        b=gJ7ab3KoK6GcRJqSUQ90Cx67YHXu/EWfCI6GE/J/XiBXiRz85/WTgV+nWS7YpBflfx
         oRTi/FrK+OCCknoPh2ywGBTGzJNHwy0XoGNN55QuNy5xD/l4L+WJ0s/ifq/Yiff+CO+b
         KP49Qu86OJiEAj2ltUSmADIlid9/Sjt3ZTnt56nacBrqfoOEdiNPG2yh58gpf8RpybVU
         1GftOux4VF6nrpWSgx50QCwKyqEkMYsKXOMK+zmnh9EiPtzgY3CAu1oRgTS7sdwsM49/
         U9q52qw/JwXk1MWTO0QATmSnf0wiGuv00KlgLEStOhgzScxgZDQasiMiCU1Lju2/Q0i9
         TInw==
X-Gm-Message-State: ALQs6tA9cd2uYFtI9rCDJF45utEupGjJHUuHgWs7ZeR1cQBGixw2ccYI
        t2MtAbUASZqxIHuJSnzwgPAhPiTiLvieaekrQenStQ==
X-Google-Smtp-Source: AIpwx49TTu9CtXsVYv0CmCYd+UOQU6Zhk844zcwxJmvUGSS2EUn1yGpex2J3/KMH3dS79jhfIEzdxfOaZ4OHXtHwCCc=
X-Received: by 2002:a9d:2c8:: with SMTP id 66-v6mr23699443otl.336.1523301978151;
 Mon, 09 Apr 2018 12:26:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.69.145 with HTTP; Mon, 9 Apr 2018 12:26:17 -0700 (PDT)
From:   Hari Lubovac <hlubovac@gmail.com>
Date:   Mon, 9 Apr 2018 12:26:17 -0700
Message-ID: <CAFLu24=o0nQveRpMJV-6dhvft0H9PgdBahisBi4EEg=G0BwhpQ@mail.gmail.com>
Subject: Windows > git.exe > the result of "git branch" does not always
 highlight the current branch
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It appears to be just a reporting issue. Probably not a big deal, but
I thought I should report this, if it hasn't been noticed: when a
branch is switched to by being named with non-original
character-casing, then it's not clear which branch is current.

Example:

C:\repo>git branch
* bar
  foo

C:\repo>git checkout Bar
Switched to branch 'Bar'

C:\repo>git branch
  bar
  foo
