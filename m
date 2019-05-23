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
	by dcvr.yhbt.net (Postfix) with ESMTP id 864E81F462
	for <e@80x24.org>; Thu, 23 May 2019 00:55:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729583AbfEWAzz (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 May 2019 20:55:55 -0400
Received: from mail-ot1-f74.google.com ([209.85.210.74]:34298 "EHLO
        mail-ot1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727305AbfEWAzz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 May 2019 20:55:55 -0400
Received: by mail-ot1-f74.google.com with SMTP id e3so2133996otk.1
        for <git@vger.kernel.org>; Wed, 22 May 2019 17:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=703vQFEKkklltiJkz1AzaqfpNsK7GDRxtBx7QgkEWOI=;
        b=iPBH/C8zVR3+RCQR09u6sevntzvloAfNtiNZls2kdINjJGI8HsWfrj2A46zt6jLyFM
         1u5n0FBEIzG7Rco8AvG/U9UuXA3Ty3uTDoPlWsLaKwzV3se5oMFaqU+vXgOWP7two62t
         Xuw8/4fihm2PX8sATEbTgTnu49EMi6qbo2YBAnvrhx5h+HrlvxXbnoLTzAbEtVrdwg93
         sLxVp+haR3ZGKvsy3mU5KPwnS/ffkahRhsNhFbrAKCOp2RBe+XfbYiJCLn3HoY5ed0eU
         3yQY68pJq4fdH03Q8WcZV5779h3H534TMOxOs6NfweA+8iGJXxmuC0Vi5qHc5II/PaXb
         Ow5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=703vQFEKkklltiJkz1AzaqfpNsK7GDRxtBx7QgkEWOI=;
        b=PT3FnKOTwbrwFbVSNZ5lAy3L57fDHwd3UB/XkH66yo2+SMSNzQGZqVxY/hZ5sQqUVY
         fYaEh2uiUMI3vdny0JZv7HZg9pBu/UiFbDQQpS95CGOvzXff153QP8i0vdz8iRArOg9G
         QnEHyrGz2sEzKZ9+GKF7/MESOrwuDYw/HBW4b/9+eD0pcDK9AgY6CR0vxZ5/psKMxRe4
         8Mf7kf76I01YXtCJ6xeehGfi0IsxC9a8ovj401c4HUZCs57oVRbiM635X2JNVCyj09UM
         Idpw2IlNF7hCPnrNuIpgXTRpbteoTSp7dZq3I9EX2KxRplEv7gVOB6RpwIXwCRzosmdB
         lVgw==
X-Gm-Message-State: APjAAAUErmY9I3mT496Hdave3StcVRW/+M92XL96uDg8mNGwxkp63Z4w
        f/gMpH3XYdm4KVHU5gsIsVc3ngU7b1KxTkL9a9klXWi4bPK0JHJkod7f1X6EnH3e3GQMBQvvpoy
        uSQfwQ8Rm29QUCZhbUDOvS8BZd4hESJdSDtU9pvSvCYTBlqatnZNzU2+04Jlbf6/OSasTZyXC5A
        ==
X-Google-Smtp-Source: APXvYqyxo4ggF+gzLK1YjwSRa1Y6nb/aTSXb29sX/tiMTlVIeuMM2X71aKUpMQXVtdN4IonR/pcz6JY4lfg6/+9vRuQ=
X-Received: by 2002:a9d:6954:: with SMTP id p20mr10666924oto.337.1558572954375;
 Wed, 22 May 2019 17:55:54 -0700 (PDT)
Date:   Wed, 22 May 2019 17:55:33 -0700
In-Reply-To: <20190521010036.70378-1-emilyshaffer@google.com>
Message-Id: <20190523005533.260611-1-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20190521010036.70378-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH v3] doc: hint about GIT_DEBUGGER in CodingGuidelines
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We check for a handy environment variable GIT_DEBUGGER when running via
bin-wrappers/, but this feature is undocumented. Add a hint to how to
use it into the CodingGuidelines (which is where other useful
environment settings like DEVELOPER are documented).

You can use GIT_DEBUGGER to pick gdb by default, or you can hand it your
own debugger if you like to use something else (or if you want custom
flags for gdb). This commit documents that intent within
CodingGuidelines.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---

Since v2, only the commit message has changed. Removed some weak
language to make the commit message read more easily.

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

