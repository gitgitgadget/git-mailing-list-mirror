Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61DFF201C8
	for <e@80x24.org>; Sun, 12 Nov 2017 15:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751324AbdKLPAm (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Nov 2017 10:00:42 -0500
Received: from a7-19.smtp-out.eu-west-1.amazonses.com ([54.240.7.19]:57984
        "EHLO a7-19.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751249AbdKLPAm (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 12 Nov 2017 10:00:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1510498840;
        h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=ClvcSQixFD3CWnM/LKkKY0DezMZzKBRForsHGJ4zvnk=;
        b=QugQJwIx/jZXGC8hWnBgXnQYUKkuIJzHuV/PqRC2NailFNxLTT6eazA37oGqWg54
        l24Uh3FLnST8RgaYJEeRFwMQeKOMBSuoGpmnj/PpMhQw+dilMPw9hB5uh3Ch/FGjNuV
        UoqeKeKNcxLh5crEM8lUSamjEi17FwZ4dUE0utgk=
From:   Soukaina NAIT HMID <nhsoukaina@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102015fb0bf2f74-cb456171-fe65-4d83-8784-b553c7c9e584-000000@eu-west-1.amazonses.com>
Subject: [add-default-config 1/5] add --color option to git config
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Sun, 12 Nov 2017 15:00:40 +0000
X-SES-Outgoing: 2017.11.12-54.240.7.19
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Soukaina NAIT HMID <snaithmid@bloomberg.net>

Signed-off-by: Soukaina NAIT HMID <snaithmid@bloomberg.net>
---
 Documentation/git-config.txt | 4 ++++
 builtin/config.c             | 1 +
 2 files changed, 5 insertions(+)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 4edd09fc6b074..5d5cd58fdae37 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -179,6 +179,10 @@ See also <<FILES>>.
 	specified user.  This option has no effect when setting the
 	value (but you can use `git config section.variable ~/`
 	from the command line to let your shell do the expansion).
+--color::
+	Find the color configured for `name` (e.g. `color.diff.new`) and
+	output it as the ANSI color escape sequence to the standard
+	output. 
 
 -z::
 --null::
diff --git a/builtin/config.c b/builtin/config.c
index d13daeeb55927..124a682d50fa8 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -80,6 +80,7 @@ static struct option builtin_config_options[] = {
 	OPT_BIT(0, "int", &types, N_("value is decimal number"), TYPE_INT),
 	OPT_BIT(0, "bool-or-int", &types, N_("value is --bool or --int"), TYPE_BOOL_OR_INT),
 	OPT_BIT(0, "path", &types, N_("value is a path (file or directory name)"), TYPE_PATH),
+	OPT_BIT(0, "color", &actions, N_("find the color configured"), ACTION_GET_COLOR),
 	OPT_GROUP(N_("Other")),
 	OPT_BOOL('z', "null", &end_null, N_("terminate values with NUL byte")),
 	OPT_BOOL(0, "name-only", &omit_values, N_("show variable names only")),

--
https://github.com/git/git/pull/431
