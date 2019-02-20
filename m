Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,RCVD_IN_RP_RNBL,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C5521F453
	for <e@80x24.org>; Wed, 20 Feb 2019 00:32:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbfBTAcb (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Feb 2019 19:32:31 -0500
Received: from mail-qt1-f202.google.com ([209.85.160.202]:36549 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbfBTAcb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Feb 2019 19:32:31 -0500
Received: by mail-qt1-f202.google.com with SMTP id p5so21762540qtp.3
        for <git@vger.kernel.org>; Tue, 19 Feb 2019 16:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8DDtVBi42UkVtf5w55eIv1TkowA6XOJs1WfSo/YGn2E=;
        b=G2jOUpUJouMt6Pa4nkgXPC2Zr8OMIWZsqgCcQ8kyk+aQJYxKL6n4iUyvMIHGEtBVSF
         bre3Y3/DGDKKHVoblf4AHjX+QMEAJUQtAc8ncstCaQGyjRLNjRM3SWXQu+l+h7eUskiP
         7Ldka3zySLxz4kOYJNiQYtvEF3VQ85+/7f06ukB42PYtzRX+FALtgc4AYjgeY3JfXFJI
         Qlxde/2ZikSJD27o6f5kDueTFgiF7ynWPMjdemzbpfLhCqK6s5k4v0R9vojdUhITp1mx
         h6XyTHcrLzYtB5bOxkapWbmtrQPkE4+HiUn2U/WURMhiXLkDLsS+sCHJE6UHJgmFAZ34
         fYGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8DDtVBi42UkVtf5w55eIv1TkowA6XOJs1WfSo/YGn2E=;
        b=DkE68aSRoV5B8G8axoiMKJyr2qSx9DtuXSmzth9fYjcbVFl+J1goD+EfhAZEjuF0Yw
         Cziaq7TcovkjX3V20KFyDRotj9RfWUUmPhvUpoOhuEAlfxoCVgl5MtxUX9LwAN5K/rob
         FkcJRIKBt1NDTV2P1pcLLFACTNw3YArsr5IBykregZQNWIGLKD+e2SXHYcLRtagJUvxV
         brKTzk1tPjb21QGqr3phJx0GdmnL684H2Tn2x+nsnr6KUT1GSH3E9cxS8K+8QTaHTIK+
         NeZIhSXjkbqic4zVfPu5XmpAXC30mDgCNJb6tWNVzAlp9Tq8IlOYGN21k5c4kxC7SstY
         RDpA==
X-Gm-Message-State: AHQUAuZjBGCTJv1HGPeE2vCmorJDBJE4yWIRW1ErUNbO62ctvqGRCrUE
        5nJjlS2WbSdLbRz2M+peU2M4XS26cPYtfNeViI1HdnwB+glhljirCHi5VdyizB0MZhtHdGoPshz
        H7U7aY1rykDlH+fe8OX+QpJnuXuTweXfrzbo0zZe0J1BjFxGJZoi16fEMPiGiWU4=
X-Google-Smtp-Source: AHgI3IaBYeN97CTnKE2rpsBHFsvalfxz2tRrfLIK5qyFvGFXxItL/AGXDQ39/KhRiGeIFP5qy0BAYXhKDs+O8w==
X-Received: by 2002:a37:2f82:: with SMTP id v124mr18538014qkh.33.1550622749817;
 Tue, 19 Feb 2019 16:32:29 -0800 (PST)
Date:   Tue, 19 Feb 2019 16:32:26 -0800
In-Reply-To: <4ffb11ff776166944673ba3bdb96a9d20eb14df7.1549929088.git.steadmon@google.com>
Message-Id: <f8de6411ffccf98f51dfa2eaf16073515933e4ec.1550622671.git.steadmon@google.com>
Mime-Version: 1.0
References: <4ffb11ff776166944673ba3bdb96a9d20eb14df7.1549929088.git.steadmon@google.com>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
Subject: [PATCH v3] protocol-capabilities.txt: document symref
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 7171d8c15f ("upload-pack: send symbolic ref information as
capability"), we added a symref capability to the pack protocol, but it
was never documented. Adapt the patch notes from that commit and add
them to the capabilities documentation.

While we're at it, add a disclaimer to the top of
protocol-capabilities.txt noting that the doc only applies to v0/v1 of
the wire protocol.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 .../technical/protocol-capabilities.txt        | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/technical/protocol-capabilities.txt b/Documentation/technical/protocol-capabilities.txt
index 332d209b58..2b267c0da6 100644
--- a/Documentation/technical/protocol-capabilities.txt
+++ b/Documentation/technical/protocol-capabilities.txt
@@ -1,6 +1,10 @@
 Git Protocol Capabilities
 =========================
 
+NOTE: this document describes capabilities for versions 0 and 1 of the pack
+protocol. For version 2, please refer to the link:protocol-v2.html[protocol-v2]
+doc.
+
 Servers SHOULD support all capabilities defined in this document.
 
 On the very first line of the initial server response of either
@@ -172,6 +176,20 @@ agent strings are purely informative for statistics and debugging
 purposes, and MUST NOT be used to programmatically assume the presence
 or absence of particular features.
 
+symref
+------
+
+This parameterized capability is used to inform the receiver which symbolic ref
+points to which ref; for example, "symref=HEAD:refs/heads/master" tells the
+receiver that HEAD points to master. This capability can be repeated to
+represent multiple symrefs.
+
+Servers SHOULD include this capability for the HEAD symref if it is one of the
+refs being sent.
+
+Clients MAY use the parameters from this capability to select the proper initial
+branch when cloning a repository.
+
 shallow
 -------
 
-- 
2.21.0.rc0.258.g878e2cd30e-goog

