Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEF4220955
	for <e@80x24.org>; Fri, 17 Mar 2017 02:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750970AbdCQCyT (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Mar 2017 22:54:19 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:36121 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751182AbdCQCyO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2017 22:54:14 -0400
Received: by mail-qt0-f193.google.com with SMTP id n37so8085837qtb.3
        for <git@vger.kernel.org>; Thu, 16 Mar 2017 19:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dqD8hk7i6RjzNiRXkGs6PtXrVcwP2eji65LEyzo8RRo=;
        b=eQ5GIWgWPl0byPWalxajJEIjzV3c+HblGs4PLxjtNd85s80g/gTAki/KNJ/lYV8gSW
         o2IIIeY0FyH0JV6dduKPk1RY3XaoMl0aUTu6wExjHDbKvcXHDsffmFnFjQ4Mcjpx1GGz
         pO8YiMLQ/DkzgY7ybHEBwH2xhl1aw1WzZGWcPE9IYgryKF3Mq253xhfpTDbXBq0IX1bV
         XbFNpGF/zVQWg0shzTUiWyDAEzC4Ek8o1DzrQZC084Bx0GHDwUVIVSM6cjxSdHcFsspN
         lQFGGFI9Aw/lVJwq14rEHOk4Igip3/ZdloIZVcQ/b9ciSWxEJ/PnMQnAEfDG9O23uw55
         P9HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dqD8hk7i6RjzNiRXkGs6PtXrVcwP2eji65LEyzo8RRo=;
        b=Vt1VeGKYtxthVOtcBixyKWdAz4iYPoXyHC3NEGClGQ4jgEc7GoaBZ/9RIUlgkZnKRF
         bTRS+dKYbb93CsShsL6HIl7oyfGZyfKdLRkRWw4YmL9frts4S3mesi0Nc1G/HaEFaDZy
         BJUDSrUQQoa1Fnrmn7Mgjc/aihva+YRNoyVPH3n/afS+5wVx8vNCGVW89VdvGNZUUDnE
         VdCY3k46dXJvcpTZMV8szhZkoY5QPSBv+BkV6OjLvA+7Z9X1k+8zQWLlfTXPpwodHiWo
         KuZDnlu1GeVr2XP6AS2s2OlAgPOor+9kZu8mG99A5Mh3QKV3QVnKHDe+xhESYbYsMAcZ
         YfDQ==
X-Gm-Message-State: AFeK/H1ez+wOtmQKrAA/F+k+sOuQKS0FYrSVjgbZ0/WHZ5u5HIZoHvIGutlzkNmkUDNx2A==
X-Received: by 10.200.53.99 with SMTP id z32mr12942172qtb.106.1489719198115;
        Thu, 16 Mar 2017 19:53:18 -0700 (PDT)
Received: from mango1.eduroam.cornell.edu (nat-128-84-124-0-116.cit.cornell.edu. [128.84.124.116])
        by smtp.googlemail.com with ESMTPSA id r30sm5009007qtc.66.2017.03.16.19.53.17
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 16 Mar 2017 19:53:17 -0700 (PDT)
From:   Devin Lehmacher <lehmacdj@gmail.com>
To:     lehmacdj@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net
Subject: [GSoC][PATCH v5 3/3] credential-cache: add tests for XDG functionality
Date:   Thu, 16 Mar 2017 22:53:15 -0400
Message-Id: <20170317025315.84548-3-lehmacdj@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170317025315.84548-1-lehmacdj@gmail.com>
References: <20170316051827.97198-5-lehmacdj@gmail.com>
 <20170317025315.84548-1-lehmacdj@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Devin Lehmacher <lehmacdj@gmail.com>
---
 t/t0301-credential-cache.sh | 94 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/t/t0301-credential-cache.sh b/t/t0301-credential-cache.sh
index 82c841121..82c4dfa07 100755
--- a/t/t0301-credential-cache.sh
+++ b/t/t0301-credential-cache.sh
@@ -12,7 +12,101 @@ test -z "$NO_UNIX_SOCKETS" || {
 # don't leave a stale daemon running
 trap 'code=$?; git credential-cache exit; (exit $code); die' EXIT
 
+# test that the daemon works with no special setup
 helper_test cache
+
+test_expect_success 'socket defaults to ~/.cache/git/credential/socket' '
+	test_when_finished "
+		git credential-cache exit &&
+		rmdir -p .cache/git/credential/
+	" &&
+	test_path_is_missing "$HOME/.git-credential-cache" &&
+	test -S "$HOME/.cache/git/credential/socket"
+'
+
+XDG_CACHE_HOME="$HOME/xdg"
+export XDG_CACHE_HOME
+# test behavior when XDG_CACHE_HOME is set
+helper_test cache
+
+test_expect_success "use custom XDG_CACHE_HOME if set and default sockets are not created" '
+	test_when_finished "git credential-cache exit" &&
+	test -S "$XDG_CACHE_HOME/git/credential/socket" &&
+	test_path_is_missing "$HOME/.git-credential-cache/socket" &&
+	test_path_is_missing "$HOME/.cache/git/credential/socket"
+'
+unset XDG_CACHE_HOME
+
+test_expect_success 'credential-cache --socket option overrides default location' '
+	test_when_finished "
+		git credential-cache exit --socket \"\$HOME/dir/socket\" &&
+		rmdir \"\$HOME/dir\"
+	" &&
+	check approve "cache --socket \"\$HOME/dir/socket\"" <<-\EOF &&
+	protocol=https
+	host=example.com
+	username=store-user
+	password=store-pass
+	EOF
+	test -S "$HOME/dir/socket"
+'
+
+test_expect_success "use custom XDG_CACHE_HOME even if xdg socket exists" '
+	test_when_finished "
+		git credential-cache exit &&
+		sane_unset XDG_CACHE_HOME
+	" &&
+	check approve cache <<-\EOF &&
+	protocol=https
+	host=example.com
+	username=store-user
+	password=store-pass
+	EOF
+	find . &&
+	test -S "$HOME/.cache/git/credential/socket" &&
+	XDG_CACHE_HOME="$HOME/xdg" &&
+	export XDG_CACHE_HOME &&
+	check approve cache <<-\EOF &&
+	protocol=https
+	host=example.com
+	username=store-user
+	password=store-pass
+	EOF
+	test -S "$XDG_CACHE_HOME/git/credential/socket"
+'
+
+test_expect_success 'use user socket if user directory exists' '
+	test_when_finished "
+		git credential-cache exit &&
+		rmdir \"\$HOME/.git-credential-cache/\"
+	" &&
+	mkdir -p -m 700 "$HOME/.git-credential-cache/" &&
+	check approve cache <<-\EOF &&
+	protocol=https
+	host=example.com
+	username=store-user
+	password=store-pass
+	EOF
+	test -S "$HOME/.git-credential-cache/socket"
+'
+
+test_expect_success 'use user socket if user directory is a symlink to a directory' '
+	test_when_finished "
+		git credential-cache exit &&
+		rmdir \"\$HOME/dir/\" &&
+		rm \"\$HOME/.git-credential-cache\"
+	" &&
+	mkdir -p -m 700 "$HOME/dir/" &&
+	ln -s "$HOME/dir" "$HOME/.git-credential-cache" &&
+	check approve cache <<-\EOF &&
+	protocol=https
+	host=example.com
+	username=store-user
+	password=store-pass
+	EOF
+	test -S "$HOME/.git-credential-cache/socket"
+'
+
 helper_test_timeout cache --timeout=1
 
 # we can't rely on our "trap" above working after test_done,
-- 
2.11.0

