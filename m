Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CC33207DF
	for <e@80x24.org>; Fri, 16 Sep 2016 17:43:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761690AbcIPRnv (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Sep 2016 13:43:51 -0400
Received: from mail-vk0-f47.google.com ([209.85.213.47]:35472 "EHLO
        mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757816AbcIPRnt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2016 13:43:49 -0400
Received: by mail-vk0-f47.google.com with SMTP id b133so36072693vka.2
        for <git@vger.kernel.org>; Fri, 16 Sep 2016 10:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RbH2UZcdhZKoyvkO7CN/l+EZWNRXgnxQLAbfO5duB+c=;
        b=JNr+M1/1tIiV8PHXGCaTGmrZwbsEM2Ky3QTwdoWZDWwk96i2ungOfxTBTv6qYYpjWP
         5OqwPx/rr8hFZZwmsf/gIZ3okynuQDM8KWgJXaiq7HFrL+sk80ZPAjlIjUyoLs7qtcSQ
         Mbi/I3TlkjMa/02tllLN/PqKn+lM1TrMpQCNX4cHUTXllRXz+32Vem1XBnpWAxxb8Sja
         CRXlnANChZD9C3r05JRkw4ckVD4PpNHZA1m/8r92POYmkPnPIND0RPu1ZDvQqrVJYrZh
         vVi0E2hg9i4kbwxCDOi6YzFCE5DR1Avosh65Yvnqjq1y+8bcLGwfsdxLCcsnFkEy8by2
         vnSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RbH2UZcdhZKoyvkO7CN/l+EZWNRXgnxQLAbfO5duB+c=;
        b=VOxL29+vWDiab/4++EiESZOqpUFOz3ZYdJMpqSAIcMx2ZU+BL0iRlmAL1IRPUpHAXm
         MRz+eZQOaRBkqD0yodstRQ7rSfN7a5mPv7PoUgNF2c/pW1uJKASExaTfGrMxPAB+uFEm
         PnPT3NOAhBpAVzkM6gTtJLcpxvim7W3CHNC3Kq8NLi+mKKqVcT/1zjrIVGEPmbvys6fR
         X5+U6THYL5PQr2bq+D/0XPys6Ntr/DQYjS8jVk3NKEq67n9FGy9lmNH9sEo/Zf4SsJBe
         XfenhYbPMEvaxZscL0ofbqiMure15kwuSyyEyVjrvK2COfV7F+N/RHr5byx9aig4EnMo
         uQjA==
X-Gm-Message-State: AE9vXwNdDOsCMXbwQP2BgUuUQ730kKd9Kl3G7DcIla3NZ10hbD5BL9hB26NiMT6ggzB6/FcCbsHT5Bd/DjIU9w==
X-Received: by 10.31.194.213 with SMTP id s204mr4095313vkf.146.1474047827042;
 Fri, 16 Sep 2016 10:43:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.35.16 with HTTP; Fri, 16 Sep 2016 10:43:26 -0700 (PDT)
In-Reply-To: <9A490197-3220-4AF9-95DA-89B726A91F92@gmail.com>
References: <cover.9c54bbdd9f054215b5432c4ba3081110e2e91724.1473973732.git-series.orirawlings@gmail.com>
 <728dfb8e2bf4aa9f6297eada7b8e8a107fd382e6.1473973732.git-series.orirawlings@gmail.com>
 <9A490197-3220-4AF9-95DA-89B726A91F92@gmail.com>
From:   Ori Rawlings <orirawlings@gmail.com>
Date:   Fri, 16 Sep 2016 12:43:26 -0500
Message-ID: <CAPv0x+OB=6ju90unOnChXLK-tbYt0utV5JsguE-Dw9zbd28siA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] git-p4: Add --checkpoint-period option to sync/clone
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git@vger.kernel.org, Vitor Antunes <vitor.hda@gmail.com>,
        Luke Diamand <luke@diamand.org>, Pete Wyckoff <pw@padd.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 16, 2016 at 11:19 AM, Lars Schneider
<larsxschneider@gmail.com> wrote:
>
>
> This looks interesting! I ran into the same issue and added a parameter to the p4 commands to retry (patch not yet proposed to the mailing list):
> https://github.com/autodesk-forks/git/commit/fcfc96a7814935ee6cefb9d69e44def30a90eabb

I was unaware of the retry flag to the p4 command, that seems like a
useful trick too. I think both approaches might pair nicely together
(p4 optimistically retrying, but still falling back to the latest git
checkpoint if we exhaust our N retry attempts).

> Would it make sense to print the "git-p4 resume command" in case an error happens and checkpoints are written?

I was thinking something like this would be a good idea and would
certainly aide in usability. Resuming a sync is fairly
straight-forward (just re-execute the same command). Resuming a clone
is a bit more problematic, today if a depot path argument is provided
to the sync or clone command (and it is always required for clone), no
attempt is made to examine the existing git branches and limit to only
Perforce changes missing from git.

There is a lingering TODO in the script where we check the presence of
the depot path argument, with a suggestion that we should always make
an attempt to continue building upon existing history when it is
available. I think there might be a few edge cases around this
behavior that I'd need to think through. But, if I'm able to address
the TODO, then printing the command to resume the import should be
pretty straight-forward. I'll continue working on that next week.
