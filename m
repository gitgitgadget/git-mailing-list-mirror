Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 440951F454
	for <e@80x24.org>; Mon, 22 Oct 2018 08:40:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbeJVQ6B (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Oct 2018 12:58:01 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35737 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728164AbeJVQ6B (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Oct 2018 12:58:01 -0400
Received: by mail-qk1-f193.google.com with SMTP id v68-v6so24797216qka.2
        for <git@vger.kernel.org>; Mon, 22 Oct 2018 01:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=5apwgTA2O5FtsnlIal8XuDlqHpKHfgKp1bAxUckiboU=;
        b=dFBu11GHjJLXp/X5cE5fuEXH25qp+cd4O4+5LBtf4LIppOhkcNxFnN0DvuL6xjXTGo
         WWoY5ljZXE7bxbl/uXWl76TZtuAz8O2BuNRJ9YwIcDrQ6jNq1fSNNZinX1VQ8Kc2snx9
         6vGj/T6hAkD5/tq6AqRiEp8nt+QUypQsFg/EG/KWU0nRiWO/ud0+MakX4/tyc+bZbJY6
         qgo6RK5N996YwE6NB2MljGl2AvZAhAd0+NPyDcxJzk2Cnf0O0Sns/6OBoPd1VgRe2BLR
         7+EUo8PybcOOztx8Pb46sKjyPJ9jGMV1woA4QpiPZzf2aLVyciBgkUP+2+y8p2nV+HrP
         6i1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=5apwgTA2O5FtsnlIal8XuDlqHpKHfgKp1bAxUckiboU=;
        b=cbiWYDcBVvPlcMJZ+APBnNC/cigaA8OV2GcuoPorGc2LO1lnzudgnLBcAWJ/b9ZxiZ
         9xRTjB+2x7t7PRtwbTSRZSoOK5XsaXUjPrZTSRMPkvms4oTyOW18Eczkea14nVHq+h4n
         OtvwBs/Dq32RGvvemLhChdlEhUEmRNSKgYwQd1sUAKlI2yTU32YVvvxpBbo1peFb9vto
         PD7SGyzomweVqHhtUqox+az7vpKpLu640IkTcrCGY30X2Hx+jBqsbCdCsWEQ32EBcB2G
         6ypeduD7/aCoED992Hr+e3zNpbVthF41eGaolvv5cvMPYZ+bTOGErTPICYt+1M8LPXwR
         80OQ==
X-Gm-Message-State: ABuFfoh25yl2+3jLz2feCTIGZkm5CSB/1yIfx0knrTZFpJ654PmcPNr7
        2sLllwlwzkf5qtx1Ch0o8sQ1l3GU92fDRAE5FDdHuYu4
X-Google-Smtp-Source: ACcGV62Q8+Mjlsi/AQ5JyKpeeOTFVcid1j+SdCi6BkHmf2xnDkpiyoufec8z+7vGCs/IaQEIwKU+NwD6NqPbMTv8F2o=
X-Received: by 2002:a37:72c1:: with SMTP id n184-v6mr42527508qkc.133.1540197627171;
 Mon, 22 Oct 2018 01:40:27 -0700 (PDT)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 22 Oct 2018 10:40:15 +0200
Message-ID: <CAP8UFD3RKcHbgQ7PzFyJhNRAEc+ktM1HLB-KJB2qL-FiVtir7A@mail.gmail.com>
Subject: Draft of Git Rev News edition 44
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Gabriel Alcaras <gabriel.alcaras@telecom-paristech.fr>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Luca Milanesio <luca.milanesio@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-44.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/311

You can also reply to this email.

In general all kinds of contribution, for example proofreading,
suggestions for articles or links, help on the issues in GitHub, and
so on, are very much appreciated.

I tried to cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Gabriel and me plan to publish this edition on
Wednesday October 24th.

Thanks,
Christian.
