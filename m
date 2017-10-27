Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 622751FAED
	for <e@80x24.org>; Fri, 27 Oct 2017 17:07:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752548AbdJ0RHx (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Oct 2017 13:07:53 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:54068 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752466AbdJ0RHv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Oct 2017 13:07:51 -0400
Received: by mail-io0-f193.google.com with SMTP id 189so14115201iow.10
        for <git@vger.kernel.org>; Fri, 27 Oct 2017 10:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QMmv9zTKC+wi0gSNkKxwERBa+ShLu0hv3m9eIqqPPrI=;
        b=H3SGGe3JOV7cWn6KTr6JuE5T6FHfrSPve/9m62jTTtFpfKMKiQd27pbksgJg/YokT5
         vYsj9UBA69vEGrbL78erLFUv1Lgwr0zku/j94DpMNSbDuR+H9hckVlAGKy8QxbqMyaNH
         wL38erMQ6I7LxV6avvxYObQbK4Jm0nvcyuKM+TtKWawJ/XYQneryOqNkVAAvpNJd/8qL
         +eAsVtODHx9fc7Uyhnl93IHQy6Y3AmtvPW/tjIvhv0ubKYuPlpFgqUd4fKjnpBbDuocl
         GXIfHbk1lxk8n47HHRpNbpqc0vDUrsfzu0cZFOLl78eIsx/45PIwT1Lz8Jbnjz065wJN
         8Tzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QMmv9zTKC+wi0gSNkKxwERBa+ShLu0hv3m9eIqqPPrI=;
        b=mAzJ+vfNygss3lHQHX8SVhaWGIWyhEY+nuTBdDI3ElgPLmSIpaCtGNH6JKHn8eq+RS
         m0NwDo3YFDVPjYSdDK+9szi2Qt/7eAP0+6y2gbpJSOIMdTEItHU1Ab29XKzcrOjE+iaC
         /vn+ejfRA7nMrl0Vy9bBBox0Wjzd/dJmBGGJSZz87Sumg6GEqhmo3FBSyZlDNbITtmrv
         0aVqltZU2RjFhdndnYL050qYPOjpEOxR52Pvsaj2qtimU6Z/yk+wPjsY4JxHfIKN8owj
         Wv40kGbNfZdUweBR19y6DUDOKzlR1zjKUAxymRjf5WwqBh3HimGt4aYbJ1Shs5cdprTs
         oBZw==
X-Gm-Message-State: AMCzsaUBAA/DBs8dOnntkk/oxy2Y0/f3rbcUa1y0WnTWFWIYlqomvEYB
        nI/nvlpFReEmXR563NYZJgDIxg==
X-Google-Smtp-Source: ABhQp+T/A+XHWMdZpolwzHW8vbRPak99oWt5v/5rRdsbiAx02nESLke3iFpmObl3LDlAnGQBVJepAQ==
X-Received: by 10.107.170.166 with SMTP id g38mr1450514ioj.207.1509124070311;
        Fri, 27 Oct 2017 10:07:50 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:1da7:34ee:3ff4:f700])
        by smtp.gmail.com with ESMTPSA id b133sm3683347ioe.73.2017.10.27.10.07.49
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 27 Oct 2017 10:07:49 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de,
        jrnieder@gmail.com, larsxschneider@gmail.com, peff@peff.net,
        sbeller@google.com, tboegi@web.de
Subject: [PATCH 0/2] Re* Consequences of CRLF in index?
Date:   Fri, 27 Oct 2017 10:07:43 -0700
Message-Id: <20171027170745.2125-1-sbeller@google.com>
X-Mailer: git-send-email 2.15.0.rc2.443.gfcc3b81c0a
In-Reply-To: <xmqqinf1ce3i.fsf_-_@gitster.mtv.corp.google.com>
References: <xmqqinf1ce3i.fsf_-_@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Let's do this bit-shuffling as a preliminary clean-up.

These 2 patches can go on top of that as well.

Thanks,
Stefan

Stefan Beller (2):
  xdiff/xdiff.h: remove unused flags
  xdiff/xdiffi.c: remove unneeded function declarations

 xdiff/xdiff.h  |  8 --------
 xdiff/xdiffi.c | 17 -----------------
 2 files changed, 25 deletions(-)

-- 
2.15.0.rc2.443.gfcc3b81c0a

