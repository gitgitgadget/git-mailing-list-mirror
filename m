Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4A6B202C1
	for <e@80x24.org>; Thu, 16 Mar 2017 05:20:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751192AbdCPFU3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Mar 2017 01:20:29 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:36828 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750987AbdCPFUL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2017 01:20:11 -0400
Received: by mail-qt0-f194.google.com with SMTP id n37so4468705qtb.3
        for <git@vger.kernel.org>; Wed, 15 Mar 2017 22:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WJrgLVH4xNqbRKHqhmWOFuGAYr2+FKXMDIOxH5H0OjM=;
        b=VsDg0BOv/PlJBvCKBeJFleOkarzcb0chS7djHR9UuTWHHkh64IQI7pLuaPqMHvu7dN
         vpj9uLzxVaf6MXsWZ7CM3chkri7V62fDbqBkh1JMCe9L/p6XbMv42dXSm9Gucn5Kld3E
         IGz6Dxhcutwj9rnZEt6D9FkYbbfyzFUjgTXT4QZiFcGzV/h2sv2dCJ1qvAVDQRo+x82a
         wH7OxgZeo8NyuzplhXF6IoXGPvI3v3C3X0/Ch22G5IRkPP4kHsb3F7rIeTVOEirGve49
         lhX6WNaTzfjwbstG/SQMcEBxEDUckusTTdoKPMYbcONJDseHHUopdI5AiY2QjR39a5z9
         Hwrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WJrgLVH4xNqbRKHqhmWOFuGAYr2+FKXMDIOxH5H0OjM=;
        b=hCrKrI3qWsoUjYXvaQXFYfXOXbrkfXIJI7WzjhEOEYuDprPWvDDb7PICo6PFdkhkZ7
         FCornSDExdupl0kagYPzbwKAwzDKw803IwUXGkhKHkEFiWKqjBhylJzMK6l9AZgibKhp
         Aa/x8xRrrrm4V6/QXYBZhfzcTmRXjvyvJPm76oeFd3vPCr7MXtxFKD/SohDOB5xO9QrV
         6C4y9rBNYlga8uoOXrlFhDma/2KAeAEM7Y3UoM1hM9uEnkPPbk6pVqSmj2HZSm6Cln1x
         a1LN98pN5PNpavbgbJcA9HGYCSmj0hRZ5+OYO5mnAvhRENMzmA95KaWAthvCpMaAjkJ1
         AedA==
X-Gm-Message-State: AFeK/H1dt+XSGY1iCCZodM6IR6FgL9OrIhOAVPvdfOtFwEItBd30SZHFleiQVuwMFbuI6w==
X-Received: by 10.200.46.91 with SMTP id s27mr7084815qta.278.1489641518263;
        Wed, 15 Mar 2017 22:18:38 -0700 (PDT)
Received: from mango1.eduroam.cornell.edu (nat-128-84-124-0-52.cit.cornell.edu. [128.84.124.52])
        by smtp.googlemail.com with ESMTPSA id y52sm2913833qty.60.2017.03.15.22.18.37
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 15 Mar 2017 22:18:37 -0700 (PDT)
From:   Devin Lehmacher <lehmacdj@gmail.com>
To:     lehmacdj@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: [GSoC][PATCH v4 4/4] credential-cache: add tests for XDG functionality
Date:   Thu, 16 Mar 2017 01:18:27 -0400
Message-Id: <20170316051827.97198-5-lehmacdj@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170316051827.97198-1-lehmacdj@gmail.com>
References: <20170314003246.71586-4-lehmacdj@gmail.com>
 <20170316051827.97198-1-lehmacdj@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Devin Lehmacher <lehmacdj@gmail.com>
---
 t/t0301-credential-cache.sh | 64 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/t/t0301-credential-cache.sh b/t/t0301-credential-cache.sh
index 82c841121..664c6dda1 100755
--- a/t/t0301-credential-cache.sh
+++ b/t/t0301-credential-cache.sh
@@ -12,6 +12,7 @@ test -z "$NO_UNIX_SOCKETS" || {
 # don't leave a stale daemon running
 trap 'code=$?; git credential-cache exit; (exit $code); die' EXIT
 
+# test that the daemon works with no special setup
 helper_test cache
 helper_test_timeout cache --timeout=1
 
@@ -20,4 +21,67 @@ helper_test_timeout cache --timeout=1
 # our socket, leaving us with no way to access the daemon.
 git credential-cache exit
 
+# we need to use rm -rf here since sometimes the daemon hasn't finished
+# cleaning up after itself and rmdir fails
+test_expect_success 'credential-cache --socket option overrides default location' '
+	test_when_finished "rm -rf \"$HOME\"/dir/" &&
+	check approve "cache --socket \"$HOME/dir/socket\"" <<-\EOF &&
+	protocol=https
+	host=example.com
+	username=store-user
+	password=store-pass
+	EOF
+	test -S "$HOME/dir/socket" &&
+	git credential-cache exit
+'
+
+XDG_CACHE_HOME="$HOME/xdg"
+export XDG_CACHE_HOME
+# test behavior when XDG_CACHE_HOME is set
+helper_test cache
+
+test_expect_success "use custom XDG_CACHE_HOME if set and default sockets are not created" '
+	test -S "$XDG_CACHE_HOME/git/credential/socket" &&
+	test_path_is_missing "$HOME/.git-credential-cache/socket" &&
+	test_path_is_missing "$HOME/.cache/git/credential/socket" &&
+	git credential-cache exit
+'
+unset XDG_CACHE_HOME
+
+test_expect_success "use custom XDG_CACHE_HOME even if xdg socket exists" '
+	check approve cache <<-\EOF &&
+	protocol=https
+	host=example.com
+	username=store-user
+	password=store-pass
+	EOF
+	test -S "$HOME/.cache/git/credential/socket" &&
+	XDG_CACHE_HOME="$HOME/xdg" &&
+	export XDG_CACHE_HOME &&
+	check approve cache <<-\EOF &&
+	protocol=https
+	host=example.com
+	username=store-user
+	password=store-pass
+	EOF
+	test -S "$HOME/xdg/git/credential/socket" &&
+	git credential-cache exit &&
+	unset XDG_CACHE_HOME
+'
+
+# we need to use rm -rf here since sometimes the daemon hasn't finished
+# cleaning up after itself and rmdir fails
+test_expect_success 'use user socket if user directory exists' '
+	test_when_finished "rm -rf \"$HOME/.git-credential-cache/\"" &&
+	mkdir -p -m 700 "$HOME/.git-credential-cache/" &&
+	check approve cache <<-\EOF &&
+	protocol=https
+	host=example.com
+	username=store-user
+	password=store-pass
+	EOF
+	test -S "$HOME/.git-credential-cache/socket" &&
+	git credential-cache exit
+'
+
 test_done
-- 
2.11.0

