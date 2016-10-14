Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7A9F1F4F8
	for <e@80x24.org>; Fri, 14 Oct 2016 17:38:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752591AbcJNRiJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Oct 2016 13:38:09 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35926 "EHLO
        mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751453AbcJNRiI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2016 13:38:08 -0400
Received: by mail-pa0-f54.google.com with SMTP id ry6so48750599pac.3
        for <git@vger.kernel.org>; Fri, 14 Oct 2016 10:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sQqNryc4yXtjRZHXxl8UCcfLFBsjP3BTB717IvEP91Y=;
        b=nmz8n2pgPOey6XCajbWhuqtyEvsyM9s4wtT3+/hJtHodGKxXBNvzSCWq6yAiBohvFI
         So6BWkiUBOKyB1G6JU/6R3n+AjTqfFD01gSEIduM8AlikvyNIKXFiAAoWiQCCS08FJnF
         qCNVHahKRLsE3/LMFbQ9SOqESgG27HqMUmyAlkXr/cZyPxm2BV06mVAsAF8aGek4+Fx2
         30SsUcXraXwQkmd0KN3FcdI0K8ja0aSWVfLG2lUtidsnkDOP3zG0kNUe4BU6MQgYE+/c
         3XX29ZP8XdZ3mvZ6nD88zFLCB5Yf1VRA5796Vd6xDFsK4sgk4gIEgFLjYtGJHwoMiBR+
         xwhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sQqNryc4yXtjRZHXxl8UCcfLFBsjP3BTB717IvEP91Y=;
        b=foTqv1hi+kJPucxN2IYrkeykASlVDWKsd4JV0beeXQcQMu55fBvb5bwafcOThOSxBr
         SLuN4fCebH1WvBnStNy3yR14J0iUmFabShLrFg0P0J0Gv61MQ4dotWfRR7R9Ra0AEZMi
         gPaY8GgJd0oICsbEz5U7lvxQqr6/uV3vXDG8tNX4pooFEwIaEKiiqd1rDxCQrOqO9rLL
         5m4Br/heG3XrI2ZywzoZvM8VXptXveLFiTceHIYMfX5xDIhhBmEu47YgwY/nbB+H92yh
         4+pX0UQewDpl4mcpQXTP93jfg6p8MEcYRUcwA4XWh7/KtfGgBTfMBN51N1saoW5A2KeO
         +ZnA==
X-Gm-Message-State: AA6/9RmDjDQiDJhBsBn/FrNLOQWqJDDdON1l/TbEi3gx4mNgc+R4TbveFQWPMumlJPumZjCA
X-Received: by 10.66.9.199 with SMTP id c7mr16667803pab.19.1476466687069;
        Fri, 14 Oct 2016 10:38:07 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([100.96.238.21])
        by smtp.gmail.com with ESMTPSA id b88sm28955706pfe.72.2016.10.14.10.38.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 14 Oct 2016 10:38:05 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        jnareb@gmail.com
Subject: [PATCH v3 0/6] allow non-trailers and multiple-line trailers
Date:   Fri, 14 Oct 2016 10:37:57 -0700
Message-Id: <cover.1476466609.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <cover.1476232683.git.jonathantanmy@google.com>
References: <cover.1476232683.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ah, I knew I forgot something. These are exactly the same as v2, except
that these are signed off.

Jonathan Tan (6):
  trailer: improve const correctness
  trailer: use list.h for doubly-linked list
  trailer: streamline trailer item create and add
  trailer: make args have their own struct
  trailer: allow non-trailers in trailer block
  trailer: support values folded to multiple lines

 Documentation/git-interpret-trailers.txt |  10 +-
 t/t7513-interpret-trailers.sh            | 174 ++++++++++
 trailer.c                                | 538 +++++++++++++++----------------
 3 files changed, 444 insertions(+), 278 deletions(-)

-- 
2.8.0.rc3.226.g39d4020

