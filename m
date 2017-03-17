Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10D5320951
	for <e@80x24.org>; Fri, 17 Mar 2017 12:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751096AbdCQMhC (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 08:37:02 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:34593 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751017AbdCQMg5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 08:36:57 -0400
Received: by mail-qt0-f196.google.com with SMTP id x35so9248111qtc.1
        for <git@vger.kernel.org>; Fri, 17 Mar 2017 05:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tN58uwB9TXV0CzPhg9UZsLPeo19EehmD6lRjLmIAXcI=;
        b=ayq7VUqCSzFAZoB59nN6hIEbjoqeqG8FzsvfF+FJehOYuoCJ/S2ZyVXZefS0Guc/FL
         5Mm4v8ZDF1h3gHR8MuUuebbAQDjIB03T3PC/+21zJ9eSUdqUv7vaXaV6l7rwcnRkbFMu
         8Gb6+jAtn4u1HNT+uUwigMo3FzYGlbtE1xckUWFU3eKSiBn+4R+gJlC9uFYcSEcwX6Z3
         qp/jdQCacnVcQKbDbExvuJ4ykfCaN/HD8O53Och4hR7mLaJhuH1Wp3JydVRE0llc7MV1
         +tI2xEGn5GdVodwE60fIzsL8fkMZetO9wf4L7a0u0GYwUBabZuWN9v2cw2FmXUilwRla
         7l3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tN58uwB9TXV0CzPhg9UZsLPeo19EehmD6lRjLmIAXcI=;
        b=uECFzHKCeT/OmCD+oJqznv4MxlD2QxwHbOxCFy1hEA4U/Y/xeu00XfL1rKrwDFj/2d
         TP7XzN8GFA/1+pfzEL+u+3Q88TNYq2oEjUIL6mwc9r3tsHysMJWgmo3z8wyG86VBXbOh
         VZpt3s22tY526qLIbLzY/wyVd+kA3BqavWiClSoczTLZwUxQoHf1h3mRQHPQ0ivm2sDt
         rKTvNQKeL40kwgOx6h6D21sf86H7G4pTmsB3ss3YfbZ4ByQGBASSMdFBaVsloxHtyszu
         0+QAbxNzFknPpGHfzmkks3d0jAHTAGowyvUK0hO1is/Wt3czK3g4UTPRPVPBA0WGdl/m
         IEiw==
X-Gm-Message-State: AFeK/H1H9MG4decCKNNqzuUGcKgdI6N5axCwn6AlZejtwpzDTLjbcTVYE9DxAqJ7B1NsCQ==
X-Received: by 10.237.41.7 with SMTP id s7mr12743209qtd.64.1489754197971;
        Fri, 17 Mar 2017 05:36:37 -0700 (PDT)
Received: from mango1.eduroam.cornell.edu (nat-128-84-124-0-116.cit.cornell.edu. [128.84.124.116])
        by smtp.googlemail.com with ESMTPSA id h33sm5811607qtc.42.2017.03.17.05.36.37
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 17 Mar 2017 05:36:37 -0700 (PDT)
From:   Devin Lehmacher <lehmacdj@gmail.com>
To:     lehmacdj@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net
Subject: [GSoC][PATCH v6 3/3] credential-cache: add tests for XDG functionality
Date:   Fri, 17 Mar 2017 08:36:34 -0400
Message-Id: <20170317123634.10863-3-lehmacdj@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170317123634.10863-1-lehmacdj@gmail.com>
References: <20170317025315.84548-3-lehmacdj@gmail.com>
 <20170317123634.10863-1-lehmacdj@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Devin Lehmacher <lehmacdj@gmail.com>
---
 t/t0301-credential-cache.sh | 93 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/t/t0301-credential-cache.sh b/t/t0301-credential-cache.sh
index 82c841121..fd92533ac 100755
--- a/t/t0301-credential-cache.sh
+++ b/t/t0301-credential-cache.sh
@@ -12,7 +12,100 @@ test -z "$NO_UNIX_SOCKETS" || {
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
+test_expect_success SYMLINKS 'use user socket if user directory is a symlink to a directory' '
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

