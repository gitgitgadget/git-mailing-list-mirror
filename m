Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C47141F859
	for <e@80x24.org>; Fri, 19 Aug 2016 17:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755437AbcHSRIt (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Aug 2016 13:08:49 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:36390 "EHLO
        mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755420AbcHSRIs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2016 13:08:48 -0400
Received: by mail-pa0-f68.google.com with SMTP id ez1so3684552pab.3
        for <git@vger.kernel.org>; Fri, 19 Aug 2016 10:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xIeZBlf1m75q40sHgirqHpxne/uyH8N5J1qiPlzf0E4=;
        b=c3oHL+GxDBe7iyIse9o9I5h3PbKw+Gz5v5buqZ6qfg+jZJdhDqQQ/9BhUzKysessnc
         270j973SzKLnXVnXc/kDG+uejm/SgO3/JG9erLHRxWSzWLcjhupUc66zYkphebuv019C
         amwTn8fGZElCTTkSKwsnXFSILg0W6uVR83HTfvkd/XYBZrtLVdZ0fKVTV0oYlWnRyXZr
         KUSZpF9qIr0IqxygwoansPbngsfgf/5eY5fyyIHaLzgaqY7+sutxvVBSKQVkA8CgJz+A
         2dJ+DBZhvP5wZqpO5cMH3unXJ12SovgAXjkpKGJhwkhs+WYi2tcrS/qBQy1jDclCtt7q
         IMjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xIeZBlf1m75q40sHgirqHpxne/uyH8N5J1qiPlzf0E4=;
        b=kclkNR6xss2XdrqtbkjS3GZutG4ixk/rIoaeqYovnt7/NpLNlSIzw9zzzOMoLbKWHa
         OeKiOYEW3s95LeyJdrraJlI8kBuoGytJ/BJL9Y3JEerga25xnJ9as9uiZYVlfEZUkRzj
         1aGvtDv6MBzpnRX8ov6Qx7cm2RPdh67trNzUUgHynr4WlqEKbdMoh44HYoeWwF85aHxj
         X1Ok5ngUuFIdvu8Y4e/Xm01UmZGOJE+TRReUUycrYZF5Up6XkQf8qp5S4x1d/jhIMstG
         InD2WkZI/ybT5Kl6aN+aigcdhY1j/tAtTyKc1nJQ6svYHvOBLIR9xCI2q10ANeNNdQ3U
         ZJiA==
X-Gm-Message-State: AEkoouv2tLy0q0WJg1avo9Erkwg/1fconTxnxfijb5UbYxmFZpPb0LNIH93GowHeD0ANOw==
X-Received: by 10.66.5.72 with SMTP id q8mr15595787paq.38.1471626504122;
        Fri, 19 Aug 2016 10:08:24 -0700 (PDT)
Received: from tci.int.yp.com ([216.2.203.2])
        by smtp.gmail.com with ESMTPSA id m128sm7930676pfm.42.2016.08.19.10.08.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 19 Aug 2016 10:08:23 -0700 (PDT)
From:   Brian Henderson <henderson.bj@gmail.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, e@80x24.org, gitster@pobox.com,
        Brian Henderson <henderson.bj@gmail.com>
Subject: [PATCH v3 0/3] diff-highlight: add support for git log --graph output.
Date:   Fri, 19 Aug 2016 10:08:09 -0700
Message-Id: <20160819170812.1676-1-henderson.bj@gmail.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20160819145123.73hf7ffysy53l3kz@sigill.intra.peff.net>
References: <20160819145123.73hf7ffysy53l3kz@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I cleaned up the graph test, hopefully it's better.

Brian Henderson (3):
  diff-highlight: add some tests.
  diff-highlight: add failing test for handling --graph output.
  diff-highlight: add support for --graph output.

 contrib/diff-highlight/Makefile                  |   5 +
 contrib/diff-highlight/diff-highlight            |  19 ++-
 contrib/diff-highlight/t/Makefile                |  22 +++
 contrib/diff-highlight/t/t9400-diff-highlight.sh | 204 +++++++++++++++++++++++
 4 files changed, 244 insertions(+), 6 deletions(-)
 create mode 100644 contrib/diff-highlight/Makefile
 create mode 100644 contrib/diff-highlight/t/Makefile
 create mode 100755 contrib/diff-highlight/t/t9400-diff-highlight.sh

-- 
2.9.0

