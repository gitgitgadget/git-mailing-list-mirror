Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0EB61F600
	for <e@80x24.org>; Sun, 23 Jul 2017 18:17:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751625AbdGWSRo (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Jul 2017 14:17:44 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:36704 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751607AbdGWSRn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Jul 2017 14:17:43 -0400
Received: by mail-pg0-f53.google.com with SMTP id 125so47878252pgi.3
        for <git@vger.kernel.org>; Sun, 23 Jul 2017 11:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0Xcvu94fqb8jVnas8iYAKe8suZIdO9ZPzkOaoYumqHA=;
        b=WgLLkrZhnkV0kQVMi/BV822ahLR9/y9kMklMlTQYQvjbs30d5XiwBn4EqmucvACA/D
         5aaoviWJOsRUvawmjZbBAMYTyluvOXvjn36iLzdwmpFYJ73rrQxhaF4IZCCutsQkuZjh
         mfWIRUFwubPv8N67JCaln2o8m14TdybV7ZAJ/A4H1ic9FIxZL2giCjELOxWXJOIwTFmy
         wMII6Kq1DqHiEyWfYslxl7uSL8Wvu84mpt6knqDPlCcLNVJRGpE9r99PBpaOgT3S7uhE
         /CrJDInm1jfYj+AuBXXFgb1GfYGIRLMlye2OLO3FI32hhIlmNbI25LQ3uqhGIxzDbEV7
         zgjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0Xcvu94fqb8jVnas8iYAKe8suZIdO9ZPzkOaoYumqHA=;
        b=dMQmZFzvAnYbnzKgzmcsr/I7/eowPzdUvEcwsm05CAQ1xaUgZFANfpCBLqPgonojHG
         iKlppMf7x3qTlfn1bPgojoodvSHVKpipgcOtwIgpAFZZY/v5ZJwz1UipCaLZVNvSPdxs
         CWVzH4F1u6SKoLAtaHA8ux6ldHrC57t53lRNU1HyUcq0fCzKDmCmwn9DskH421RLTjFv
         LkNIXK/vodwBKKQNCkjgupCMfBnrBorcxdXkC2MBghlKp/+tUTpTkrUGxJG96uNaw98n
         6uUDZjvzJgG+ywHVcPsZ7PRmHT2bHpLySBQqJBc3BycmSPmGcNaEL4Gk2BvN92gArwFx
         cRZw==
X-Gm-Message-State: AIVw113d9LUVkaGrq7GYxzqaHTQBi2FGSTjpYFC9TZZCluwGAyHtk2k5
        uPWpy13IPyy3XjvbZPCCGOthAeqGpg==
X-Received: by 10.98.138.197 with SMTP id o66mr8935943pfk.207.1500833862815;
 Sun, 23 Jul 2017 11:17:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.130.67 with HTTP; Sun, 23 Jul 2017 11:17:42 -0700 (PDT)
In-Reply-To: <xmqq379qkalj.fsf@gitster.mtv.corp.google.com>
References: <cover.1499723297.git.martin.agren@gmail.com> <cover.1500321657.git.martin.agren@gmail.com>
 <xmqq379qkalj.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sun, 23 Jul 2017 20:17:42 +0200
Message-ID: <CAN0heSokk9RAYx7pB_qC5dbZ3N1ZJQgKkrmhrPXmyHjFsnJu7Q@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] tag: only respect `pager.tag` in list-mode
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 21 July 2017 at 00:27, Junio C Hamano <gitster@pobox.com> wrote:
> I tend to agree with you that 1-3/10 may be better off being a
> single patch (or 3/10 dropped, as Brandon is working on losing it
> nearby).  I would have expected 7-8/10 to be a single patch, as by
> the time a reader reaches 07/10, because of the groundwork laid by
> 04-06/10, it is obvious that the general direction is to allow the
> caller, i.e. cmd_tag(), to make a call to setup_auto_pager() only in
> some but not all circumstances, and 07/10 being faithful to the
> original behaviour (only to be updated in 08/10) is somewhat counter
> intuitive.  It is not wrong per-se; it was just unexpected.

Thanks for your comments. I will be away for a few days, but once I
get back, I'll try to produce a v3 based on this and any further
feedback.

Martin
