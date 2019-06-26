Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 402C31F461
	for <e@80x24.org>; Wed, 26 Jun 2019 23:51:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbfFZXvD (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jun 2019 19:51:03 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:56651 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbfFZXvD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jun 2019 19:51:03 -0400
Received: by mail-pf1-f201.google.com with SMTP id x10so258431pfa.23
        for <git@vger.kernel.org>; Wed, 26 Jun 2019 16:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xZPo7IbblC2mxy8Nz3bkmiWr8q70ZXXBBoHRw1UpBd8=;
        b=aFOYsPa23lB/UcQ7WnHkzjEIxFe9Q61rdMy6usCLGrbrhgI2OHPARyM2JnITN4Isky
         KLzgL9/1bZEzVSM7+m1ozk9jjD1QVtfTIZ9sAOyT/0U7zgrf+qKWAlBt1VNmC5s4loMJ
         JVzfO0o495VJ3JuZw2M11KtX73ghFSyYLNmVZvY4RuvxWDp4rN4jwgJtQuTTgtlmVY99
         TWo+hIwcH26XZeof3XNgpXsSmgYK9WIFyGGakYJqdrf3d8Vx4wZOzJzr3L0zjUYAU4FZ
         5N3RSpQOv8c2WQ7yRulohHXDDOwqjcDykbnKaddIoJXHNEvCuRnuD1HaaiN5TI0631WW
         Bllw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xZPo7IbblC2mxy8Nz3bkmiWr8q70ZXXBBoHRw1UpBd8=;
        b=B4SEtnmJWZYU8RRSZNEP06DQ/Epa8sXBNemNMsyuvndk42lM+7/BT6iuMNAnwTKMmZ
         H6S9R0G6OMy/xXX1JKen39bRDIvbSN4rrpJ2oD8K/L6r7Sx14O6IGtpoBOPgZ74e8xRF
         JMjFEd+l/M/X61TDGE5XOJwLlyzXpegheCfDi++oLZM/8mi45Pr2Nks+hPivkHAfDXHl
         DUNCm2e0y3lJqJGLiQtW7pLRJCKViulrC/3iKKSFPVGTs1coiAxlPxvgrvxlzUdG69lj
         1dKoyQChnr4wt6aIcSUPIz59dPMyA2L+3HmRi8tiJNW6FFmR1l1kpcxiaNyJprpFp86o
         pbdQ==
X-Gm-Message-State: APjAAAV44PPL7JlHchYA1IxUdRY0ouy61LajzI6VS+IHO4INJADP4i4p
        uX4n7kbFjAFRjyreta9vr+RjzEshp0Ib+iLZ60mnFSTi40yop4UN1VkuLlBkFiG/4dd6HL2lQ+r
        s4h/Hi7X4VhjXxVNOxyIUS1AwmS0SN+yKXlIpKD74lb6xlKlkUJX2SBjwcdJYjLxpKeabiJnC8Q
        ==
X-Google-Smtp-Source: APXvYqxjUMmvM+41whtkpqSNDqPG3sagBS0goj3u581wqGGuKthmmbfp6/RpOhbJyOSGEsLVcLdD5bIt0WG74I08gfk=
X-Received: by 2002:a65:4945:: with SMTP id q5mr634929pgs.9.1561593062121;
 Wed, 26 Jun 2019 16:51:02 -0700 (PDT)
Date:   Wed, 26 Jun 2019 16:50:22 -0700
In-Reply-To: <20190626235032.177551-1-emilyshaffer@google.com>
Message-Id: <20190626235032.177551-4-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20190626235032.177551-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [RFC PATCH v2 03/13] walken: add placeholder to initialize defaults
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eventually, we will want a good place to initialize default variables
for use during our revision walk(s) in `git walken`. For now, there's
nothing to do here, but let's add the scaffolding so that it's easy to
tell where to put the setup later on.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 builtin/walken.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/builtin/walken.c b/builtin/walken.c
index 9eea51ff70..daae4f811a 100644
--- a/builtin/walken.c
+++ b/builtin/walken.c
@@ -16,6 +16,19 @@ const char * const walken_usage[] = {
 	NULL,
 };
 
+/*
+ * Within init_walken_defaults() we can call into other useful defaults to set
+ * in the global scope or on the_repository. It's okay to borrow from other
+ * functions which are doing something relatively similar to yours.
+ */
+static void init_walken_defaults(void)
+{
+	/*
+	 * We don't actually need the same components `git log` does; leave this
+	 * empty for now.
+	 */
+}
+
 int cmd_walken(int argc, const char **argv, const char *prefix)
 {
 	struct option options[] = {
@@ -28,6 +41,8 @@ int cmd_walken(int argc, const char **argv, const char *prefix)
 	 */
 	argc = parse_options(argc, argv, prefix, options, walken_usage, 0);
 
+	init_walken_defaults();
+
 	/*
 	 * This line is "human-readable" and we are writing a plumbing command,
 	 * so we localize it and use the trace library to print only when
-- 
2.22.0.410.gd8fdbe21b5-goog

