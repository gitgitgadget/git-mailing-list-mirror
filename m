Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF534207EC
	for <e@80x24.org>; Fri, 30 Sep 2016 17:01:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933778AbcI3RBX (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Sep 2016 13:01:23 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:36081 "EHLO
        mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932646AbcI3RBW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2016 13:01:22 -0400
Received: by mail-pa0-f43.google.com with SMTP id qn7so40230164pac.3
        for <git@vger.kernel.org>; Fri, 30 Sep 2016 10:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LrrDwtviFP1YSPMjmf7KCdiQGa5SjcpiXrW5pSQ6jXY=;
        b=fsmkVwYLaxBW5jlYe5bFWW5qqMXmkoA15Ex5acnimXbbPb9CwhrSin/lbrZubLHL15
         37Up0KfO/NtgDKzag1uZ6j4iicmyT9f6b0yD88Jcn/E2EoiPbNxmp+k7zNukGHDW9DX1
         THo2Z+YRMhTVkL71gzE4jTFbjw6wS5Um3LdqIcEamKmV6dMVEJc1lyruBUCDlW3fTIzY
         Vnq5Ch6UQxU0zhUAZAnXSb95P/OUTxJb4reekJGQusDrzuWp61U771Vq4GYRs6+UuoWX
         F+uSR+OeagqdYzA6zAyMYlSbBVQsj9HGwzTxtqkGToFPQxvtCeMx7i5x9+YLTYQ9Ee99
         jLKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LrrDwtviFP1YSPMjmf7KCdiQGa5SjcpiXrW5pSQ6jXY=;
        b=Eydlugx0ro3krfx/Cqzo74P5fjMwjOmqRRuDVgRZ7Izd1+3EG0XQPTC+JEbBDCNNdP
         jx9AdecqfJOZGZxFkR00UjdTbk4i7AsFD1yP0OyU3etxA8ur3IFrMDKFRZR0dCXAnW6U
         FX8IVGGnTmJEw0DaErIVFu2V2UXQQtxlK+PJK3Yg8HRV3CZdsNW0YK5tN5X9AOYOd2KM
         bcTXNqiU2JEKqpddLlSEvXuPYCcuDjl9JRx1ZiWS13Bs6dDa5xOk5M3A2SZKWna2lxOz
         goaOU34RutjDSmElZ4rnX90mb6rC8DNAYH9gb3F+32blMUFgtmjhJAXGOB3CYD8QKENr
         7oQQ==
X-Gm-Message-State: AA6/9RlWy0CfePvx8nnMy0ycKwDECEyZ6PafhQo4hFQGkb7qkykH4JxdmHnrUUjR3b1yI9if
X-Received: by 10.66.246.13 with SMTP id xs13mr13408367pac.57.1475254881098;
        Fri, 30 Sep 2016 10:01:21 -0700 (PDT)
Received: from google.com ([2620:0:1000:5e00:8826:94df:73a:c97f])
        by smtp.gmail.com with ESMTPSA id m82sm29204093pfk.64.2016.09.30.10.01.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Sep 2016 10:01:20 -0700 (PDT)
Date:   Fri, 30 Sep 2016 10:01:18 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net
Subject: Re: [PATCH v6 3/4] ls-files: pass through safe options for
 --recurse-submodules
Message-ID: <20160930170118.GA13951@google.com>
References: <1475099443-145608-1-git-send-email-bmwill@google.com>
 <1475185723-36871-1-git-send-email-bmwill@google.com>
 <1475185723-36871-4-git-send-email-bmwill@google.com>
 <xmqqy42ab5ww.fsf@gitster.mtv.corp.google.com>
 <20160930163347.GA11126@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160930163347.GA11126@google.com>
User-Agent: Mutt/1.7.0 (2016-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pass through some known-safe options when recursing into submodules.
(--cached, -v, -t, -z, --debug, --eol)

If other unsafe options are given the caller will be errored out.

Signed-off-by: Brandon Williams <bmwill@google.com>
---

Something more like this correct? I ditched the extra parameters and
reworded the commit msg to reflect this.

 builtin/ls-files.c                     | 30 +++++++++++++++++++++++++++---
 t/t3007-ls-files-recurse-submodules.sh | 16 ++++++++++++----
 2 files changed, 39 insertions(+), 7 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 63befed..b6144a5 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -30,6 +30,7 @@ static int line_terminator = '\n';
 static int debug_mode;
 static int show_eol;
 static int recurse_submodules;
+static struct argv_array submodules_options = ARGV_ARRAY_INIT;
 
 static const char *prefix;
 static const char *super_prefix;
@@ -168,6 +169,25 @@ static void show_killed_files(struct dir_struct *dir)
 	}
 }
 
+/*
+ * Compile an argv_array with all of the options supported by --recurse_submodules
+ */
+static void compile_submodule_options(const struct dir_struct *dir, int show_tag)
+{
+	if (line_terminator == '\0')
+		argv_array_push(&submodules_options, "-z");
+	if (show_tag)
+		argv_array_push(&submodules_options, "-t");
+	if (show_valid_bit)
+		argv_array_push(&submodules_options, "-v");
+	if (show_cached)
+		argv_array_push(&submodules_options, "--cached");
+	if (show_eol)
+		argv_array_push(&submodules_options, "--eol");
+	if (debug_mode)
+		argv_array_push(&submodules_options, "--debug");
+}
+
 /**
  * Recursively call ls-files on a submodule
  */
@@ -182,6 +202,9 @@ static void show_gitlink(const struct cache_entry *ce)
 	argv_array_push(&cp.args, "ls-files");
 	argv_array_push(&cp.args, "--recurse-submodules");
 
+	/* add supported options */
+	argv_array_pushv(&cp.args, submodules_options.argv);
+
 	cp.git_cmd = 1;
 	cp.dir = ce->name;
 	status = run_command(&cp);
@@ -567,11 +590,12 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 	if (require_work_tree && !is_inside_work_tree())
 		setup_work_tree();
 
+	if (recurse_submodules)
+		compile_submodule_options(&dir, show_tag);
+
 	if (recurse_submodules &&
 	    (show_stage || show_deleted || show_others || show_unmerged ||
-	     show_killed || show_modified || show_resolve_undo ||
-	     show_valid_bit || show_tag || show_eol || with_tree ||
-	     (line_terminator == '\0')))
+	     show_killed || show_modified || show_resolve_undo || with_tree))
 		die("ls-files --recurse-submodules unsupported mode");
 
 	if (recurse_submodules && error_unmatch)
diff --git a/t/t3007-ls-files-recurse-submodules.sh b/t/t3007-ls-files-recurse-submodules.sh
index b5a53c3..33a2ea7 100755
--- a/t/t3007-ls-files-recurse-submodules.sh
+++ b/t/t3007-ls-files-recurse-submodules.sh
@@ -34,6 +34,18 @@ test_expect_success 'ls-files correctly outputs files in submodule' '
 	test_cmp expect actual
 '
 
+test_expect_success 'ls-files correctly outputs files in submodule with -z' '
+	lf_to_nul >expect <<-\EOF &&
+	.gitmodules
+	a
+	b/b
+	submodule/c
+	EOF
+
+	git ls-files --recurse-submodules -z >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'ls-files does not output files not added to a repo' '
 	cat >expect <<-\EOF &&
 	.gitmodules
@@ -86,15 +98,11 @@ test_incompatible_with_recurse_submodules () {
 	"
 }
 
-test_incompatible_with_recurse_submodules -z
-test_incompatible_with_recurse_submodules -v
-test_incompatible_with_recurse_submodules -t
 test_incompatible_with_recurse_submodules --deleted
 test_incompatible_with_recurse_submodules --modified
 test_incompatible_with_recurse_submodules --others
 test_incompatible_with_recurse_submodules --stage
 test_incompatible_with_recurse_submodules --killed
 test_incompatible_with_recurse_submodules --unmerged
-test_incompatible_with_recurse_submodules --eol
 
 test_done
-- 
2.10.0

