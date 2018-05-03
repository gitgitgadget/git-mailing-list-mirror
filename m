Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54564200B9
	for <e@80x24.org>; Thu,  3 May 2018 18:49:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751346AbeECStM (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 14:49:12 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:43892 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751101AbeECStI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 14:49:08 -0400
Received: by mail-wr0-f194.google.com with SMTP id v15-v6so18635999wrm.10
        for <git@vger.kernel.org>; Thu, 03 May 2018 11:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Tckeed6VAEadcQI43MPlEB9zQMA97Fr9UYCurr1ob5Y=;
        b=ImzTzhxO6aknEOXel/Sr+bsObmOo37cGwbzrViimR92ta7ePS+yL1nVlJoPmJZgdN4
         VzQ+Hcs3RH+h1Qx+c+/ABxbGukpe4tFOJiv4ykTOuG+L/1PwqWYODxbnR/pi9xb+yw4b
         6yGdjmToM+Wpviyg115bDcEdkDdip6/Z8viBp+uZNGjZMO2/e/jv9I35G7V9p243j5Co
         J+v1RFaE+EUNjbBRK/oD2uhDAgt0yZxdtJyEp1apdNFI5uUeF/T5MbmPOzwYXezGutuv
         CoLSxjhyGpp7qXg7vloh4guBTacLq3DOziuFRCX6JdL0o+QX7VA7Tzdycyt2ORBOiVmA
         o7zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Tckeed6VAEadcQI43MPlEB9zQMA97Fr9UYCurr1ob5Y=;
        b=XUy8MXysHiqrtJY8Y3932XrcZpU9q95o3hdmlIFEzbIzwSNbZhPSvnVbMiamnNXHwT
         sFrpcFV8JH78y1i9P9Ohds7Z3IyBF0BJsTG7pehfNiqQPnUM/go2KcYWVS24050ECr5A
         Y7eTa5EAsbFL8wvtUmrIW0wObJmHYt2bpP58y63VCJbWqKI5bqxQ8yiuUknrZ6pnldQ8
         DJAtxznByGMfLRs8TjC1NacOmsK8wN2EVFn6Z81kj4sy+pr+QcFPbnC1TtznPG+T4sYb
         bSC5Lh0bLaS1NMbSwePnE3vpcKGbDc2sckUabx5a8sfB836MEhSrLvmlw1IWYgOoftwL
         YYWg==
X-Gm-Message-State: ALQs6tAt/V5IAS9unLdU/5ynCMfGGebU7SR32M9npGu3DElcmDd+ttbZ
        BryTfkerRCnvAgektwOlU1dXIzu2
X-Google-Smtp-Source: AB8JxZqRA7EszfzNYVBVj4UuOG+wuW4c4FblmRWfOyhp0aqYt3o15/uuB9l75wquTFIJFYXHSYt1aA==
X-Received: by 2002:adf:d1cc:: with SMTP id m12-v6mr10253706wri.214.1525373346819;
        Thu, 03 May 2018 11:49:06 -0700 (PDT)
Received: from arrakeen.fritz.box ([2001:a62:81d:ab01:a521:6b31:5c87:9e4b])
        by smtp.gmail.com with ESMTPSA id f83-v6sm198322wmh.32.2018.05.03.11.49.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 May 2018 11:49:06 -0700 (PDT)
From:   Andreas Heiduk <asheiduk@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Andreas Heiduk <asheiduk@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v3 6/7] doc: add note about shell quoting to revision.txt
Date:   Thu,  3 May 2018 20:48:29 +0200
Message-Id: <20180503184830.11889-7-asheiduk@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180503184830.11889-1-asheiduk@gmail.com>
References: <20180427170440.30418-1-asheiduk@gmail.com>
 <20180503184830.11889-1-asheiduk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
Reviewed-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/revisions.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index dfcc49c72c..e760416d07 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -7,6 +7,10 @@ syntax.  Here are various ways to spell object names.  The
 ones listed near the end of this list name trees and
 blobs contained in a commit.
 
+NOTE: This document shows the "raw" syntax as seen by git. The shell
+and other UIs might require additional quoting to protect special
+characters and to avoid word splitting.
+
 '<sha1>', e.g. 'dae86e1950b1277e545cee180551750029cfe735', 'dae86e'::
   The full SHA-1 object name (40-byte hexadecimal string), or
   a leading substring that is unique within the repository.
@@ -186,6 +190,8 @@ existing tag object.
   is matched. ':/!-foo' performs a negative match, while ':/!!foo' matches a
   literal '!' character, followed by 'foo'. Any other sequence beginning with
   ':/!' is reserved for now.
+  Depending on the given text, the shell's word splitting rules might
+  require additional quoting.
 
 '<rev>:<path>', e.g. 'HEAD:README', ':README', 'master:./README'::
   A suffix ':' followed by a path names the blob or tree
-- 
2.16.2

