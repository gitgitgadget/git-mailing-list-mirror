Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CD021F403
	for <e@80x24.org>; Tue,  5 Jun 2018 15:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752094AbeFEPcO (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 11:32:14 -0400
Received: from mail-ot0-f172.google.com ([74.125.82.172]:35284 "EHLO
        mail-ot0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751701AbeFEPcM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 11:32:12 -0400
Received: by mail-ot0-f172.google.com with SMTP id q17-v6so3323869otg.2
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 08:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=LIMLcElw4cKrkA4vzxxhmhDfubdTZIiHb/vgzzkacn4=;
        b=m6NmWa7/3zAJeMpdWMcyLNy1mLQ08N7xk4xUfAqfJqm3aT06vafATM8Z/dVD5mJUpa
         44TZWQ3LvKT090+xnUPtWqxFfOWRGA7sOUzIn6vVZFNzxWLmQ7ltqsy93ghdKplpAqnt
         aUr7d8kMPRQiTLpTYX4A5Wgm3hd53968vvLkkn0/vVesJuH/CMonu14stvjTIb22CYah
         SQd4AlcYJZhoIjGaP1mym0Zwi2x1UV4ok/FguOMfGFnWD8Z3IKuQQ0iSk2RIdfxUaV+r
         00RwM5cC+vsimG3cCm4oqmVwM1YuoC3ouuzSHjwO9NqkIj322LqPX/R+39ke/DNH0adX
         dUfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=LIMLcElw4cKrkA4vzxxhmhDfubdTZIiHb/vgzzkacn4=;
        b=TKrwTy1yIjnL+QIv9S3DtyjfgHEVd8yAOlz75Y9kt9pKwFqyxKo1JMrv9WHzy78Xsp
         +2RZhN5OXFyNdnOr9wJAmSHoZEPApzBad8k9tpb9V9vAg0fEPbltaTuPDtKk3q8Zm3Vp
         EYTmmc5LstJX3VmCygrEbWJ+2GAq1IiCy1UNltO47aUA1BLvaQ2jqDs3YZTzlaNtrtAd
         teeougqftRkggD1bPiCrz1unac80RB8QCdMS46YYyCwjAS7hxIyDfrAc+Ko6OcCSRkoP
         beaF5Otce6S9QWqbDzDm64OjRfVbEDpV/4tsx1ri4F7vsLOU8pH0HfO11fQJRg5si70V
         ClPA==
X-Gm-Message-State: ALKqPwfSfyy9DfITl5apDnmqCyXE1mSHhVcX+zuUqlefxuq1CwztVY2M
        FwKYeDE4FhNWq1iFmXe7+NCn6Li94ODsdAyfy5eO1Q==
X-Google-Smtp-Source: ADUXVKLLFyQGA7vxZCiqc7A7FeLhdg3wijwVETvYTrBRRCZpG+t9qc2Axf4QyNIKbXYHTYXAN1vFX9jk7LQd+R8x+/Q=
X-Received: by 2002:a9d:c61:: with SMTP id 88-v6mr18576539otr.173.1528212732012;
 Tue, 05 Jun 2018 08:32:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:2082:0:0:0:0:0 with HTTP; Tue, 5 Jun 2018 08:31:41 -0700 (PDT)
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 5 Jun 2018 17:31:41 +0200
Message-ID: <CACsJy8CNrQ-CKoJ+1NCR1rsO+v0ZNZ9CVAFsJpmcRWZY6HUtKw@mail.gmail.com>
Subject: BUG: submodule code prints '(null)'
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I do not know how to reproduce this (and didn't bother to look deeply
into it after I found it was not a trivial fix) but one of my "git
fetch" showed

warning: Submodule in commit be2db96a6c506464525f588da59cade0cedddb5e
at path: '(null)' collides with a submodule named the same. Skipping
it.

I think it's reported that some libc implementation will not be able
to gracefully handle NULL strings like glibc and may crash instead of
printing '(null)' here. I'll leave it to submodule people to fix this
:)
-- 
Duy
