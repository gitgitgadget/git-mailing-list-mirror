Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FC781F462
	for <e@80x24.org>; Tue, 21 May 2019 01:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbfEUBBT (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 May 2019 21:01:19 -0400
Received: from mail-yw1-f74.google.com ([209.85.161.74]:45918 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726928AbfEUBBT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 May 2019 21:01:19 -0400
Received: by mail-yw1-f74.google.com with SMTP id d10so2214352ywh.12
        for <git@vger.kernel.org>; Mon, 20 May 2019 18:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=oQPIcmq1F6dcP08ZC3dVUJjcofS9pzIPkbkDKjVEduY=;
        b=vpT0tlrpE6/SB2YUBHrPkRCzm2M/tyvkjpF2cgp4geIdcluNN/zO0ojqAAvFIyxoBI
         MufjaPzEGvD3ojTvskIVr7UoGuW0LD4XloJRuvb18gWz5+RnYSFAHRegJoAHOZb5HHaF
         bzV96QyjPsq43s7HH7VYwibra3PNodG4Be8Jvb02qv00UWvx2MNB3pUoXA0knX/2GrnH
         g3evYwJLxMyTSnxp76uGpL/tQEUBLk9wwfhDVLKRGhqbctOVcW78XZf9s0fXX2z/pG/U
         i0w7OkKRJpSxSC5On+XfiTGJB5b+6kXP5bb2LqVzX5qmc719TAd3YGg1wcDVmNHdTKKq
         7zpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=oQPIcmq1F6dcP08ZC3dVUJjcofS9pzIPkbkDKjVEduY=;
        b=tzKDn9GLujfwuNTHjyN5a6OnuLn1g79LRFLQwy/JkFGC6ypTqiWozJQJXGUv9YJflv
         KEMUEzsasKUuwfW0iOcZHBmFvsqImE7UlGHC/ZEkg5z9radbBy+jlfRml/PmFLHJnbJC
         ABOsLNa/tkzFrZBbJ0PUZSNuqk0z9FUhGHHVHUDrcxXDO7vD5q0IdD7KdtiReq++FzkS
         8H/ypZ64IgG6naK/zANj5wYrfxAFCJESszdnfxcPC6m95xQOdJ8x/6RV7HAoWRDVe2FD
         3SHRMqm7slKgLEhVrJYzR++aSC3Ccr2jxWOtDrXi0WNTbG2XzifQQCAYVlowmE0JTTpR
         cTYQ==
X-Gm-Message-State: APjAAAW+LKFp23VQfUSKAhy3Tq5TSQDTRLUeG+Ak+XJkNGuOHpZnOUvs
        /8pkYD3oW3VUv1vzVguEVWc65Ycsh27iA9Ry3UjNr+tA0WTMmInA88DD7bRFXV31gY4sAktoH+7
        Kh2DtkS5M2xsQagX16ZRgPqLXVlU8TuEwu9vpOfjVzg0GapeJ/3NyDz84Hr0e6xaUomZwGaCl6g
        ==
X-Google-Smtp-Source: APXvYqwHFLNHZeOWnYDw92/jvmytJP8tIUxrJ9Jij3PS643GuD0sXIrlnclS2bYl6XeBrseD4/DvQCRLKQa5OBHWQn0=
X-Received: by 2002:a81:3008:: with SMTP id w8mr39475006yww.134.1558400478179;
 Mon, 20 May 2019 18:01:18 -0700 (PDT)
Date:   Mon, 20 May 2019 18:00:37 -0700
In-Reply-To: <20190517204826.45308-1-emilyshaffer@google.com>
Message-Id: <20190521010036.70378-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH v2] doc: hint about GIT_DEBUGGER
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We check for a handy environment variable GIT_DEBUGGER when running via
bin-wrappers/, but this feature is undocumented. Add a hint to how to
use it into the CodingGuidelines (which is where other useful
environment settings like DEVELOPER are documented).

It looks like you can use GIT_DEBUGGER to pick gdb by default, or you
can hand it your own debugger if you like to use something else (or if
you want custom flags for gdb). Hopefully document that intent within
CodingGuidelines.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 Documentation/CodingGuidelines | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 32210a4386..e99af36df9 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -412,6 +412,12 @@ For C programs:
    must be declared with "extern" in header files. However, function
    declarations should not use "extern", as that is already the default.
 
+ - You can launch gdb around your program using the shorthand GIT_DEBUGGER.
+   Run `GIT_DEBUGGER=1 ./bin-wrappers/git foo` to simply use gdb as is, or
+   run `GIT_DEBUGGER=my-debugger-binary my-args ./bin-wrappers/git foo` to
+   use your own debugger and arguments. Example: `GIT_DEBUGGER="ddd --gdb"
+   ./bin-wrappers/git log` (See `wrap-for-bin.sh`.)
+
 For Perl programs:
 
  - Most of the C guidelines above apply.
-- 
2.21.0.1020.gf2820cf01a-goog

