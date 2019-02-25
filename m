Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7A4120248
	for <e@80x24.org>; Mon, 25 Feb 2019 21:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730345AbfBYVye (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Feb 2019 16:54:34 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:37372 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729575AbfBYVyd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Feb 2019 16:54:33 -0500
Received: by mail-pl1-f202.google.com with SMTP id n1so4843745plk.4
        for <git@vger.kernel.org>; Mon, 25 Feb 2019 13:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lZ+SU1g58+pIyK5R8rJgq7ty7fJwd6Ljlw/mFnvSHtE=;
        b=LL5rVzkOi0VqgWL1f1wp3lDQoCwurDXkeDS71JBgJ1/EIvst5DAFwDMBNmCKQ5jC5A
         XfBSM4fJMSCiL8HVbNIlaRr3nYD0nAMpIlSDiVJcnWEQwYEd7L8OpTdkZ7DGz7lrcsUx
         LEyripyqzYapmsnXVp9dpllpA6Q9k3LjgfkicpKLUifGeJmUSi3BeF0CCMFeAhDL3IsB
         iT46jqmz7cGUWRFhFIDBeJnf0ndzaZBydM79TMi/eFI8UTHbT7bR44AvPNqSGKqdCyIb
         Y4FE7aiHGxk8eo8DLYoK47rV4DxPK22dgpqVjSqCustS29X9WgM3HTJv5dGmEmqDyfhX
         u6gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lZ+SU1g58+pIyK5R8rJgq7ty7fJwd6Ljlw/mFnvSHtE=;
        b=Ucxe5lOvh3XrR6en9Loj7kNFH3r6yXgOSEDrsdMwbuEbUkmb0jbyeAmWn22Zk56PTJ
         0gzjSWVnEQcG1fx8BZj82eA/bi6pSf4cAnzmhaUiY/hn+ueMO1pzPdQ0Y5B3efbU6dim
         etzYesXx5THwN1dkW/aZaPFZnUnkSwgS3pxHRl9N4ic+DBjaouEvHpfFRhwmIiQuEtG2
         winPv6KfNs8AKIp/a5VTuosMLIHhzQFvv2TvAvgdcw3CeZ4mFkoLcnGNfPnlX93MgcAO
         WbfY7YJtzNY3i33LYspz2HgTM7Mxnq226BTafdM09r3Iw+H75dsV1jlQII84K2+zfLBF
         l/Ug==
X-Gm-Message-State: AHQUAuY01DJQ2aP1gTjyLDh3H0kP1Y8ObOBIxb7qGm1Xd/ksDzP4Qgnq
        p2cLsw2UQ/gTxzJ5tTLvhKCOtddNS8+QRuulaDr+2ZVqj9w+IXnnUXPnows8vFUP9FgQ4+VbbBu
        aOiAgAm9iTPKJgVZi3DcTETtM378RCFvuaQs0uKLqIQQokHWrUeI4KVs24wHKq9rvGmmN+I4BCK
        J/
X-Google-Smtp-Source: AHgI3Ibvlh73g92ZJ1AD3FN1J/lPlNnnrPTvx8+RS0vcI1y/ReYlhMFbAdljrypKNHdvINfzdRDTH3RwNSsQvnDDqk9a
X-Received: by 2002:a63:5d1c:: with SMTP id r28mr7831840pgb.93.1551131672811;
 Mon, 25 Feb 2019 13:54:32 -0800 (PST)
Date:   Mon, 25 Feb 2019 13:54:11 -0800
In-Reply-To: <cover.1551131153.git.jonathantanmy@google.com>
Message-Id: <6c29e64bc3b081b0974de3e0d5fb7b926b272eaa.1551131153.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1551131153.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [PATCH 6/8] t5700: only run with protocol version 1
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t5700-protocol-v1.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/t/t5700-protocol-v1.sh b/t/t5700-protocol-v1.sh
index ba86a44eb1..d5ed196bfd 100755
--- a/t/t5700-protocol-v1.sh
+++ b/t/t5700-protocol-v1.sh
@@ -4,6 +4,9 @@ test_description='test git wire-protocol transition'
 
 TEST_NO_CREATE_REPO=1
 
+# This is a protocol-specific test.
+GIT_TEST_PROTOCOL_VERSION=
+
 . ./test-lib.sh
 
 # Test protocol v1 with 'git://' transport
-- 
2.19.0.271.gfe8321ec05.dirty

