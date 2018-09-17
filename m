Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD1AA1F42B
	for <e@80x24.org>; Mon, 17 Sep 2018 22:25:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbeIRDyd (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 23:54:33 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:47375 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728438AbeIRDyd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 23:54:33 -0400
Received: by mail-pl1-f201.google.com with SMTP id d40-v6so8324199pla.14
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 15:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=WgK5LSuJhzNilwH/VUSjurYLUVWcGSsPrI2+29Jmvz4=;
        b=U9Y3rVBTwvkkjEBm+1ibF2vjFBtq/3lQpVQq6j2HlynmcbDd9/tRJ+iGqe8Xgvns5n
         DTvRQsxdorZLP8bY350c4K2v/f1G13TWebBcJKlmTUJw7C8s3dCx+CSI3NsQaYo0jxHd
         YK9if3B+6ZP3N4Atq1ykjS5JSChevVIFStWDSNj6+fKTSDGglNvIEWXDR+pqFpQBFuqj
         eKAsC5vzjzU+0Sd6MrTuCQ8S2wXwDGm0Qlz1yfJfCVu1arNBf/7raY0ONIIZIqrqLaV4
         PAEwST33s9wGEDvpmUeUMut2Bf+sW+deIZ5Q8KvbSRUFsMFpj/uxHSFjCX7dMJa0TksR
         y0ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=WgK5LSuJhzNilwH/VUSjurYLUVWcGSsPrI2+29Jmvz4=;
        b=fnepvQlprqFgqVsNP7IdyZVPB11BsaBBEB1mwtltDm2ITIDRlTxYeb/uOZVkzGFmKh
         lnCvgqVuQnO//bn6QW7QPQyBa9VK5KJhEOUjxScjJdPW0lw5vUM3VdKmY1GCl4KZZRn/
         Q+7Rg3x+hJHs5tDAodH9r3HNf/Vi5oHvrnjlVa1J1v383YErfwcJzgXWrzDePOtPfLrG
         P6l5oUlTA3R/kOK09gH68oA5TR5Tq+MWWb492bMKjUyVeWgtYR4L20y/UmnDkV76kUNN
         uy7TrMCsJC1N1kAWylG0kuizWqE+5xBa4WnkgplcJeFqQ6nJoKSuU365DWVcm/RK4oAl
         MpkA==
X-Gm-Message-State: APzg51AbUsysMpPmjhBTQL4RzNxmhgpPPNMXMhMzbmM43VPqW1eyZbqf
        J+RwDmgksoB9i3FFcETCAV2rATKKAoF0sb3YAViUxrnR2ho6ywKEmQD78meDD/mPVCYApThamtz
        opST2PVQS11LhieshpSxKXyyck6Kug6c+511PEKV8vVhVrpqLyAP6h+jUfv8=
X-Google-Smtp-Source: ANB0VdZFSBZ05saEKc1Ow90vGb3dh5IYgqG6QB3iV0gjJ5bHPs+UIsouDDD0S+W7ujTI/dIdg4Smz+jh+yKj
X-Received: by 2002:a63:2a56:: with SMTP id q83-v6mr1081312pgq.12.1537223115016;
 Mon, 17 Sep 2018 15:25:15 -0700 (PDT)
Date:   Mon, 17 Sep 2018 15:24:23 -0700
In-Reply-To: <cover.1537223021.git.matvore@google.com>
Message-Id: <e01b719de662f0b150f78b5a6ab6ccfce9c675fa.1537223021.git.matvore@google.com>
Mime-Version: 1.0
References: <cover.1536969438.git.matvore@google.com> <cover.1537223021.git.matvore@google.com>
X-Mailer: git-send-email 2.19.0.444.g18242da7ef-goog
Subject: [PATCH v2 6/6] t9109-git-svn-props.sh: split up several pipes
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org
Cc:     Matthew DeVore <matvore@google.com>, peff@peff.net,
        jonathantanmy@google.com, gitster@pobox.com, jrn@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A test uses several separate pipe sequences in a row which are awkward
to split up. Wrap the split-up pipe in a function so the awkwardness is
not repeated.

Signed-off-by: Matthew DeVore <matvore@google.com>
---
 t/t9101-git-svn-props.sh | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/t/t9101-git-svn-props.sh b/t/t9101-git-svn-props.sh
index 8cba331fc..952bd4814 100755
--- a/t/t9101-git-svn-props.sh
+++ b/t/t9101-git-svn-props.sh
@@ -190,16 +190,21 @@ EOF
 # This test can be improved: since all the svn:ignore contain the same
 # pattern, it can pass even though the propget did not execute on the
 # right directory.
+# Note we avoid using pipes in order to ensure that git exits with 0.
 test_expect_success 'test propget' "
-	git svn propget svn:ignore . | cmp - prop.expect &&
+	test_propget () {
+		git svn propget $1 $2 >observed
+		cmp - $3
+	} &&
+	test_propget svn:ignore . prop.expect &&
 	cd deeply &&
-	git svn propget svn:ignore . | cmp - ../prop.expect &&
-	git svn propget svn:entry:committed-rev nested/directory/.keep \
-	  | cmp - ../prop2.expect &&
-	git svn propget svn:ignore .. | cmp - ../prop.expect &&
-	git svn propget svn:ignore nested/ | cmp - ../prop.expect &&
-	git svn propget svn:ignore ./nested | cmp - ../prop.expect &&
-	git svn propget svn:ignore .././deeply/nested | cmp - ../prop.expect
+	test_propget svn:ignore . ../prop.expect &&
+	test_propget svn:entry:committed-rev nested/directory/.keep \
+		../prop2.expect &&
+	test_propget svn:ignore .. ../prop.expect &&
+	test_propget svn:ignore nested/ ../prop.expect &&
+	test_propget svn:ignore ./nested ../prop.expect &&
+	test_propget svn:ignore .././deeply/nested ../prop.expect
 	"
 
 cat >prop.expect <<\EOF
-- 
2.19.0.444.g18242da7ef-goog

