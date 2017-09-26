Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1904720281
	for <e@80x24.org>; Tue, 26 Sep 2017 22:39:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032615AbdIZWjz (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Sep 2017 18:39:55 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:47449 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031041AbdIZWjw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2017 18:39:52 -0400
Received: by mail-pg0-f42.google.com with SMTP id d8so6692221pgt.4
        for <git@vger.kernel.org>; Tue, 26 Sep 2017 15:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jTSH4hqQ/hqgzNZ8S6c7d4KWr3ZuQGMED7BkzHM3cBw=;
        b=irfsG0C39Iyrzl8cnxsF9lGJp91G7ViozqmYkAkeJ9pjJl0Md48/KYRU8ZUok0bCF2
         XTP4IpkaUpIHwWDoBzpCozJD3j+6/YD3B52UTmL9u55yGZ4bBC18crk54Z4auRuZ4PoT
         Qejwka8Jd49fxiOcZ1NnRwSJZKeEjS1kQ6+BS6S/+jZNAjBMe5NDTxnRFI3vkQxq4ux4
         OFrZVgef0qFenVkpeh3FU6LOiOuKwdrk1qrjAzqceOt8Pn6lE25x+ztc3vD7/XU1I0Tn
         P469GfLSKCxXFLtYESJegJ1gkwKu3BmNycd1z2oF7ohZ7aXIxGteC9IFC7wLHzeQiKGq
         6Fkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jTSH4hqQ/hqgzNZ8S6c7d4KWr3ZuQGMED7BkzHM3cBw=;
        b=Udnzu2NqMvn3khI+v2htL4vvYhyhQlJwoMrmQsEee2EZ5dSh7rOHSAI9ceG10WRLKI
         otgWexPqi2mBVcZtR2KXt/yFAB78AefS1jxbvGZHk9ZfM5oU+W4BL/4F6wodpJHBgg+u
         5E+g4T2ff1/3xTzfaMFuuKIYHTS2FZ2iBMxXqVyVoshrE3frKGnxrWySFTKCjjci3Xym
         WZUtov+Pt+b0NV+YZZT9Iq7RiNPicLVbRcODXZvbb5DVoMlsYfQEb5PPtfqOPxeVGnxz
         tNPuVsRgOXuaT/hdeqt5A5goah3a5qlY6+huuxTqQhZ4e5fP4zCUOvppoEhYnj+wHg83
         2enQ==
X-Gm-Message-State: AHPjjUjT1mzz9MhVLez+f54jZv5bkEPYL0zyC+yk5/qiW0KNb931qB0w
        jN+QUjK8hzTb1uvLpNHpAo8TDQ==
X-Google-Smtp-Source: AOwi7QCuuJ5SYET/Yj+O5rQNaX0pFRm9KKJAhjQL5W+HjBNDJxl/T2jE8fd5qNvrTYUcDb3Gqq8Ytg==
X-Received: by 10.84.235.195 with SMTP id m3mr5629404plt.259.1506465592112;
        Tue, 26 Sep 2017 15:39:52 -0700 (PDT)
Received: from twelve3.mtv.corp.google.com ([2620:0:100e:422:51cf:598a:e16a:8a0b])
        by smtp.gmail.com with ESMTPSA id y16sm15734390pfe.68.2017.09.26.15.39.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Sep 2017 15:39:51 -0700 (PDT)
Date:   Tue, 26 Sep 2017 15:39:50 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 07/13] object-filter: common declarations for object
 filtering
Message-Id: <20170926153950.a147c48ce62f73702eff7ebb@google.com>
In-Reply-To: <20170922203017.53986-8-git@jeffhostetler.com>
References: <20170922203017.53986-6-git@jeffhostetler.com>
        <20170922203017.53986-8-git@jeffhostetler.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 22 Sep 2017 20:30:11 +0000
Jeff Hostetler <git@jeffhostetler.com> wrote:

>  Makefile        |   1 +
>  object-filter.c | 269 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  object-filter.h | 173 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 443 insertions(+)
>  create mode 100644 object-filter.c
>  create mode 100644 object-filter.h

I think these and list-objects-filter-* are multiple levels of
indirection too many. Would a single file with a few implementations of
filter_object_fn be sufficient?
