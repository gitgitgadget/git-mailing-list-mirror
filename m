Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1A261F404
	for <e@80x24.org>; Fri, 30 Mar 2018 14:17:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751282AbeC3OR3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 10:17:29 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:36765 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751237AbeC3OR2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 10:17:28 -0400
Received: by mail-wm0-f51.google.com with SMTP id x82so16978307wmg.1
        for <git@vger.kernel.org>; Fri, 30 Mar 2018 07:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=ElniiRf18Gsme9hBKIJyxummn1KKwNaMlD62R8KMPes=;
        b=LrNzzce9+FQKhov0MySNK2UfrNIeeU8DAhrjzgCBqrw+SnsB+w5EojHYepqagws9fr
         nZW6LwV9OibqMcAQV4jO2FYSsq20emisWH+cJc2E3P3dmOjhUYCyNiIP9/lLEao2VxuL
         Csz2eyqb9DCQl0TnreI9/zZtyJpb6ko3ZhGiH7tavUWciaTq4HAu5KlPV+BDCqb6Pdjf
         cCXdhAG+qrDLhyarAzlKfiJ7F6fZGlEcw1rHNV0snDgcB4/Lf6U8we59+RvEz0tm6P/G
         ciNmW3rwlppwP8o7ltUZrG50jOSN71IPrRLCEiBcxxC9FD0ta4CPcm/Gf9h8YdPd2N05
         lCmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=ElniiRf18Gsme9hBKIJyxummn1KKwNaMlD62R8KMPes=;
        b=ZiJ+3ulurgPRU+Fb7hB2b4YRwbJYVBSTZqQVRWO2j55QscLbhdcr3IVMEmd9B8bksK
         U83RArpLsxVnsaLu8lNkGmI0Ib0quww7wEu08pa0hE9p/a0hClh8H66ClxMnYMRDxdpd
         r3jeHhb6VAdn6aRqM4gpb2ICB5Va+OyRqN8u4i7XCmy8/D08/PhFXYbuZnmG9Od9PbBI
         RDCOfPsDPXNSrHAW6p+Tph0eJLq6qAxHBin8JnrV9cWo6/6EzVaAkaUGmqzX5UAZfJcX
         OjY3ZkjSBGY0EG1iYOQ9wYt5qga6Y0fDfvc9cQyjeEVL/mcpUmG1yFxlhjNgM3Z5Z0MW
         zPZQ==
X-Gm-Message-State: AElRT7FvKsLokNFM5NoIK0LJ1ppehR6RmIug6sQmTtbp2kacBP21+31y
        fuIJ+/IVzDl2hu4oAMTJHe4=
X-Google-Smtp-Source: AIpwx4/cqHxD0HUcA9Fdv+SLsyfbB/eq1/YpUNC2cFl5RJt9eROtvEcW9p0tdDl4fyIafhZkehRK1Q==
X-Received: by 10.80.169.89 with SMTP id m25mr3078073edc.244.1522419447106;
        Fri, 30 Mar 2018 07:17:27 -0700 (PDT)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id o61sm5173888edb.88.2018.03.30.07.17.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Mar 2018 07:17:26 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>, Phil Haack <haacked@gmail.com>,
        Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH 0/9] Assorted fixes for `git config` (including the "empty sections" bug)
References: <cover.1522336130.git.johannes.schindelin@gmx.de>
User-agent: Debian GNU/Linux 9.4 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <cover.1522336130.git.johannes.schindelin@gmx.de>
Date:   Fri, 30 Mar 2018 16:17:25 +0200
Message-ID: <87h8oxwsui.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 29 2018, Johannes Schindelin wrote:

> Nonetheless, I would be confortable with this patch going into v2.17.0, even at
> this late stage. The final verdict is Junio's, of course.

Thanks a lot for working on this. I'm keen to stress test this, but
won't have time in the next few days, and in any case think that the
parts that change functionality should wait until after 2.17 (but
e.g. the test renaming would be fine for a cherry-pick).
