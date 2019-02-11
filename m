Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBE9B1F453
	for <e@80x24.org>; Mon, 11 Feb 2019 23:52:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbfBKXw1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 18:52:27 -0500
Received: from mail-pl1-f201.google.com ([209.85.214.201]:34556 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727122AbfBKXw1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Feb 2019 18:52:27 -0500
Received: by mail-pl1-f201.google.com with SMTP id cg18so622710plb.1
        for <git@vger.kernel.org>; Mon, 11 Feb 2019 15:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to;
        bh=f4SNLT6B/jHcSqmS9MP762oJt3Mwx12BKfdeP0CvNpw=;
        b=TMOzUDx8GLV8vKswFYCH/qyclqtn0WhpQ/hs16MymOsKxc2TEYLUG6tu4bJE67ha8e
         dsdqiyjuKO9Diw8bmKCJXtmzmB29bVE1TXuLCQWH1Q1lxR17XRhi8qpSmkF0+sg4Vmtx
         boqpG2k5MF+ObDgWVyX3tSVsWzlffN9ctZuckBLDFChu3XtvQVVWTIRu/WCTxwh8OL84
         p2u+9Tadjpmxsv2nqBvTR2J8tEmQEetr49rfrJxs8736J32rsqNPeLUxC8QwHbsHcma9
         Yrrj5h2yr00zdSkZstlA/B9TjKBwMLj10gM2uX3b1Cm9IrZSBBpvn20DPwM/cQa7CxHn
         0kqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to;
        bh=f4SNLT6B/jHcSqmS9MP762oJt3Mwx12BKfdeP0CvNpw=;
        b=Z+2QqU0Dx7lQExrlDV9vSrlkTsOBjOIkzSttdWmLZoTdhhOsTIIRg3FRGeSWkdP67g
         n6N0Z/sMIQ79An1SBae2oPhurbfZy4pdSr4Cq441Z1t6V+FKY5F+Y9FwIV5vXEDitIK3
         IHFdf7CwQj87q2JtdmOEh7ZfY2Nhm1uSmNkWsUKX9XVV0T0QR1OgJ5B97+HIGJR2PjZf
         i8GNVwUbcJSHG/kJw4YWC+oGG6/gIj27z80jhi3MWca+1tJ1mk6GMXFiZhqU5p4wG0Ug
         RJbJSJ8fISuxWennsBQ/IStO2Z1etb+4VqRshHswct1KA/PV9GnXT7u4unnwv1bbDKeA
         QAJQ==
X-Gm-Message-State: AHQUAuaRSZ44iK3pBE2rmqNePKb9mSZoYLFGhi0wsG5qfngBjqY9flhU
        1kWVEnGcCKsvWOwO3ANTODh2Rhl2ZZbARsLdq6zJneM6SPDKdh+DiTlZ4RoLQDTIUkmNaNJuT25
        fUAqFv3O+sTEqXxb0q5vMSPlre25V+kFCIxxe0Od+nlIgovzf4j+Kt0ZG1DS5MvM=
X-Google-Smtp-Source: AHgI3Ia2Op/I19F7mFQ/G6goQuiV7iiZ6vqzcHvFUG2vXRvSmJxSeCkr+3LAYNv7kmxK9hVxpotpHevV1wugzA==
X-Received: by 2002:a17:902:5a09:: with SMTP id q9mr291601pli.50.1549929146825;
 Mon, 11 Feb 2019 15:52:26 -0800 (PST)
Date:   Mon, 11 Feb 2019 15:52:24 -0800
Message-Id: <4ffb11ff776166944673ba3bdb96a9d20eb14df7.1549929088.git.steadmon@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.20.1.791.gb4d0f1c61a-goog
Subject: [PATCH] protocol-capabilities.txt: document symref
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 7171d8c15f ("upload-pack: send symbolic ref information as
capability"), we added a symref capability to the pack protocol, but it
was never documented. Adapt the patch notes from that commit and add
them to the capabilities documentation.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 Documentation/technical/protocol-capabilities.txt | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/technical/protocol-capabilities.txt b/Documentation/technical/protocol-capabilities.txt
index 332d209b58..0ccdbadbe9 100644
--- a/Documentation/technical/protocol-capabilities.txt
+++ b/Documentation/technical/protocol-capabilities.txt
@@ -172,6 +172,20 @@ agent strings are purely informative for statistics and debugging
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
2.20.1.791.gb4d0f1c61a-goog

