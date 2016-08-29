Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 981572018E
	for <e@80x24.org>; Mon, 29 Aug 2016 17:34:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751965AbcH2ReD (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 13:34:03 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:35411 "EHLO
        mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751083AbcH2ReC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 13:34:02 -0400
Received: by mail-pa0-f68.google.com with SMTP id cf3so9274809pad.2
        for <git@vger.kernel.org>; Mon, 29 Aug 2016 10:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CfZmOEatMmB3iR6RGIrs9tSZsNyAj3UmdVeHo42q0y4=;
        b=CS1z/nJ3euW4AeEhxlarSW7izz409dWCddejKXL2vvx4ctcTBX8GL4WZUl2uUECDeW
         kTELh8NDfOnCXxm9Yztl+GmvErqE9OPwwg05HPy2Xj+0a5qd9viwvdYvdrcACSXKay7J
         xLcSef1NrYDmzesdIPkayN/KarVlAL+adUhvM6NOPOD89WWbdDleajEYjCulccWDZbkT
         CpEXUGOolfqSbF2HVR+2W3fo3n7GIGvX+YD4PbSXHwqQ8BXmQLlc3T11piDwC3zzo0Fh
         zDk+qqAAp517c21zJi0qBwi67N4E/10Q+vxY8TRihmuyXrXvz6tzUZJctB2oQQ4jK/qf
         NvnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CfZmOEatMmB3iR6RGIrs9tSZsNyAj3UmdVeHo42q0y4=;
        b=NLKO3ga/cjwGhwhg7thKY0VW4R81Z60WNaZsvwgcDhIxKPTRnM3HChWnWZjlMxQm2M
         6HOQ1rYZ+gY2jd5ojqHDiZhcNk7ik8f5WszeQnvs5wGXR9iUoB8ATKhz/qBB4l1zPLGi
         sR6xD2N2StjKKt7s6apcpg32evPe2KJ4SSv+pthIFtspun67EwdR8qxkc4A06JH+WdcD
         xYEW7br0bQOKQTLeq9bW6maer5lwSdYRw3YKWyGbXX1ahvD9ap0VU8m5ZRqN9LxKrJPE
         HwFvVXLABJH7HAzc/0x6QZeBp6/sF21/zTZ02OHz+nWP5V4bGF/bqUQWmrEplOBOS+lN
         q7vA==
X-Gm-Message-State: AE9vXwNu1ZwLk1NvITlTyTLjeFW9RP4/ySwecR7qOCPHHL0qQV2Dbf+ibZ4m5a2fjmAXqA==
X-Received: by 10.66.49.67 with SMTP id s3mr35109326pan.100.1472492042077;
        Mon, 29 Aug 2016 10:34:02 -0700 (PDT)
Received: from tci.int.yp.com ([216.2.203.2])
        by smtp.gmail.com with ESMTPSA id h125sm50721234pfg.54.2016.08.29.10.33.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 29 Aug 2016 10:34:00 -0700 (PDT)
From:   Brian Henderson <henderson.bj@gmail.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, e@80x24.org, gitster@pobox.com,
        Brian Henderson <henderson.bj@gmail.com>
Subject: [PATCH v4 0/3] diff-highlight: add support for --graph option
Date:   Mon, 29 Aug 2016 10:33:44 -0700
Message-Id: <20160829173347.454-1-henderson.bj@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160823041252.53ldwacgdey2euxt@sigill.intra.peff.net>
References: <20160823041252.53ldwacgdey2euxt@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

How does this look?

Drawing the graph helped me a lot in figuring out what I was actually testing. thanks!

Brian Henderson (3):
  diff-highlight: add some tests.
  diff-highlight: add failing test for handling --graph output.
  diff-highlight: add support for --graph output.

 contrib/diff-highlight/Makefile                  |   5 +
 contrib/diff-highlight/diff-highlight            |  19 +-
 contrib/diff-highlight/t/Makefile                |  22 +++
 contrib/diff-highlight/t/t9400-diff-highlight.sh | 223 +++++++++++++++++++++++
 4 files changed, 263 insertions(+), 6 deletions(-)
 create mode 100644 contrib/diff-highlight/Makefile
 create mode 100644 contrib/diff-highlight/t/Makefile
 create mode 100755 contrib/diff-highlight/t/t9400-diff-highlight.sh

-- 
2.9.3

