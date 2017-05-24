Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C25C91FF30
	for <e@80x24.org>; Wed, 24 May 2017 14:22:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031092AbdEXOWi (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 May 2017 10:22:38 -0400
Received: from mail-ua0-f172.google.com ([209.85.217.172]:33553 "EHLO
        mail-ua0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967891AbdEXOWe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2017 10:22:34 -0400
Received: by mail-ua0-f172.google.com with SMTP id e28so97969882uah.0
        for <git@vger.kernel.org>; Wed, 24 May 2017 07:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=uTg3e42Bo0yqyRzlrQhEb1hFReMRCCJsaHgdBqbfM1Y=;
        b=a1CTdc9zzeRsmpy4Vo96e0TinzQ8QOtgXGKrLUQI/4PTdXj1Kpi0m161gewCUofRTy
         L5YoNDM2C/BYjtdWMES68OHCwGdgYBAeWvtlpl6Gf3Z+/5mrqHmu6+9djSuFOtGwvNOS
         /U5ShQeLDitys+Vnx2ZcTrCqYXQKwcZGjYzr6LXvL8jD6qwJy2N19dI81wKakYZjnQUE
         uZAsAlrd7k9sQ8aTKloi/4U0gNd6to+7RBQtlaBePYz/mHbPd+LFwNnctjMSAZj6W6qz
         ZowecOmVLHD2XlrTzAvSHxBdIasMP1ljKU64hMm6h6FN3oIf4oyGoG1br6X1A2/xFUDp
         wJNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=uTg3e42Bo0yqyRzlrQhEb1hFReMRCCJsaHgdBqbfM1Y=;
        b=Z15DmVBlgZi3XVKVLjRnDD1enDGT4ur2XgeOJpr6MjK8VOeuD3qggE9oubA1Scv6fT
         YMlMqHxYFISTkEu57/jph5rcs6WTYcQQ9P0V19E1VyVMuH4KMsmol+4dVMxFKXVRsZjV
         DLCBWz9kj4BKXQLvH9cvRTePO4mPFc/xMUoZn97ORj6ohSI5wtaL7+R72mAEAdRZrAod
         DCnz5IkQ5XdbfHE9fqGifZGM7ueou3kFywim3wZ/jhAgd74TRMQP+NTXgmf9oiyePcNP
         Hm2663F8X8HcexP6EirwUcdmqCbM2VurDCaKkUKmjF4gvu+ZIustKGFKULFwbXRZr5HX
         2Hbg==
X-Gm-Message-State: AODbwcBiyklHekBsKKPQVrpMdV0ZaPYRoLE76I/LMRcIRnZqcX3kTNFE
        JFxiJB2e0Wx6ViboeQ3eCe5SY8/mbWfo
X-Received: by 10.176.3.209 with SMTP id 75mr19063000uau.122.1495635753214;
 Wed, 24 May 2017 07:22:33 -0700 (PDT)
MIME-Version: 1.0
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.159.55.163 with HTTP; Wed, 24 May 2017 07:22:32 -0700 (PDT)
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Wed, 24 May 2017 09:22:32 -0500
X-Google-Sender-Auth: 4L75pFv98GmBTuRUanrdIvZ2iVQ
Message-ID: <CAHd499B+cyN=3XDqr7KgHSpyHLwi6bS=P_4beoS5fSkFhapAtw@mail.gmail.com>
Subject: Hide decorations in git log
To:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Is it possible to hide decorated refs in `git log` even if they are
reachable from the refs I'm actually interested in seeing the logs of?

For example, if I do `git log --graph --decorate --oneline --branches
'feature/*'`, I'd like to *only* see refnames that match the glob
pattern. However, you'll see tags and other branches that do not match
the glob if they are reachable from the result set.

This is purely a visual thing, and shouldn't impact the search results
I'd think.

This is especially useful in cases where I do --simplify-by-decoration
to get a better understanding of the topology of just a couple of
select branches. Without some sort of "decoration exclusion", I am
getting ton of results including tags, etc which obfuscates the
information I'm really interested in.

Thanks in advance.
