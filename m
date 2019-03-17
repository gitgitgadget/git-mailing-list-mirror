Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C331B20248
	for <e@80x24.org>; Sun, 17 Mar 2019 18:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbfCQShD (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Mar 2019 14:37:03 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:32850 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbfCQShD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Mar 2019 14:37:03 -0400
Received: by mail-lj1-f193.google.com with SMTP id z7so12073247lji.0
        for <git@vger.kernel.org>; Sun, 17 Mar 2019 11:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=44u+RIEyIMcUDg105N+zULv77JrXUZRISakECMhX3bs=;
        b=OGpH1WNzPjTcm5E5ncl9BNXSuY5LMkOpedhm3Nb7onrYGMlJ7JmgdqNO2pi2xaJXuc
         GwzgdovaWq3+jNl0E9XYVRuAeMGzdjZvljEBZs01UiHsIFCDb2sHWXj6CGvRPvm2FUit
         HAOgms9oTcZWNQLyW41AZna7x0udrKN8NdYtmL8op/aQ4RILir87xwY8o4Oun69OEvLx
         QZYLtMzN/miSGgg/BKu8Pj3KefY0t0HEAgMmELjLmhW2kaH5yaLB4ogbESYgx8zQKmC9
         W5vi6AnWcRdgHqvKbR5oOq5hUPfbDeDAe1SAVLwdOJM7EJ169CjKBDNp0vXHupAexg23
         nf1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=44u+RIEyIMcUDg105N+zULv77JrXUZRISakECMhX3bs=;
        b=M8TKNbjUXCC6cP5Wa2aOmVZ6ZLxeE1M+qRZ0TpNsLiOjLMiXDcPF6aeAmYSitHsVZY
         w2MMqoapwNub6Mta9ax2l2pKbsK5nr/5GWN2U7NNyKVRrppjfqDTwjvQ4+wSn+wxvyvR
         IdRJrRY6dkeq2xNQFutupffslpOzXCYkANZHvwLx9q+39XwPITrXw6XVHZsdaCUlQHl2
         7N9g4d61zry/Gj3t9AxBqtmg6QVq9yHKjaXL1bNRYQ0vWWTZ7mzZyqlMuyxspcYSnPk0
         310pJXYTUa94Lz9LKbSfnsdWRZYW/XwT3hMMjZkq5PPmyOrj89t20epkaz+PwO/d7bA7
         Xuig==
X-Gm-Message-State: APjAAAX+8tbJgx48A0aaWDnrO03MthYFacEuSYDR6PLh9RjtxpUS2gtC
        /U5CysPAruB9lmyDHzasTaJfoNjo
X-Google-Smtp-Source: APXvYqzb72O+eSkbq0n5CHnwtb7UF0cuPBHJUmEgWQbtRd/2Vd66/nxyMJLA+y2TdHhQ3cwBQWr7Ow==
X-Received: by 2002:a2e:b001:: with SMTP id y1mr8144726ljk.130.1552847820559;
        Sun, 17 Mar 2019 11:37:00 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id e2sm1589484lfc.75.2019.03.17.11.36.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 11:36:59 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>
Subject: [PATCH 3/4] doc-diff: support diffing from/to AsciiDoc(tor)
Date:   Sun, 17 Mar 2019 19:36:02 +0100
Message-Id: <e6c9f88e575e13a564d47a19050b65154dede7c6.1552838239.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1552838239.git.martin.agren@gmail.com>
References: <cover.1552838239.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Provide `--from-asciidoctor` and `--to-asciidoctor` to select that the
"from" resp. "to" commit should be built with Asciidoctor, and provide
an `--asciidoctor` shortcut for giving both. Similarly, provide
--{from-,to-,}asciidoc for explicitly selecting AsciiDoc.

Implement this using the USE_ASCIIDOCTOR flag. Let's not enforce a
default here, but instead just let the Makefile fall back on whatever is
in config.mak, so that `./doc-diff foo bar` without any of of these new
options behaves exactly like it did before this commit.

Encode the choice into the directory names of our "installed" and
"rendered" files, so that we can run `./doc-diff --from-asciidoc
--to-asciidoctor HEAD HEAD` without our two runs stomping on each other.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/doc-diff | 53 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 45 insertions(+), 8 deletions(-)

diff --git a/Documentation/doc-diff b/Documentation/doc-diff
index 3e975d3c5d..36fc2307a7 100755
--- a/Documentation/doc-diff
+++ b/Documentation/doc-diff
@@ -12,9 +12,15 @@ OPTIONS_SPEC="\
 doc-diff [options] <from> <to> [-- <diff-options>]
 doc-diff (-c|--clean)
 --
-j=n	parallel argument to pass to make
-f	force rebuild; do not rely on cached results
-c,clean	cleanup temporary working files
+j=n			parallel argument to pass to make
+f			force rebuild; do not rely on cached results
+c,clean			cleanup temporary working files
+from-asciidoc		use asciidoc with the 'from'-commit
+from-asciidoctor	use asciidoctor with the 'from'-commit
+asciidoc		use asciidoc with both commits
+to-asciidoc		use asciidoc with the 'to'-commit
+to-asciidoctor		use asciidoctor with the 'to'-commit
+asciidoctor		use asciidoctor with both commits
 "
 SUBDIRECTORY_OK=1
 . "$(git --exec-path)/git-sh-setup"
@@ -22,6 +28,8 @@ SUBDIRECTORY_OK=1
 parallel=
 force=
 clean=
+from_program=
+to_program=
 while test $# -gt 0
 do
 	case "$1" in
@@ -31,6 +39,20 @@ do
 		clean=t ;;
 	-f)
 		force=t ;;
+	--from-asciidoctor)
+		from_program=-asciidoctor ;;
+	--to-asciidoctor)
+		to_program=-asciidoctor ;;
+	--asciidoctor)
+		from_program=-asciidoctor
+		to_program=-asciidoctor ;;
+	--from-asciidoc)
+		from_program=-asciidoc ;;
+	--to-asciidoc)
+		to_program=-asciidoc ;;
+	--asciidoc)
+		from_program=-asciidoc
+		to_program=-asciidoc ;;
 	--)
 		shift; break ;;
 	*)
@@ -79,8 +101,21 @@ then
 	ln -s "$dots/config.mak" "$tmp/worktree/config.mak"
 fi
 
-from_dir=$from_oid &&
-to_dir=$to_oid &&
+construct_makemanflags () {
+	if test "$1" = "-asciidoc"
+	then
+		echo USE_ASCIIDOCTOR=
+	elif test "$1" = "-asciidoctor"
+	then
+		echo USE_ASCIIDOCTOR=YesPlease
+	fi
+}
+
+from_makemanflags=$(construct_makemanflags "$from_program") &&
+to_makemanflags=$(construct_makemanflags "$to_program") &&
+
+from_dir=$from_oid$from_program &&
+to_dir=$to_oid$to_program &&
 
 # generate_render_makefile <srcdir> <dstdir>
 generate_render_makefile () {
@@ -97,7 +132,7 @@ generate_render_makefile () {
 	done
 }
 
-# render_tree <committish_oid> <directory_name>
+# render_tree <committish_oid> <directory_name> <makemanflags>
 render_tree () {
 	# Skip install-man entirely if we already have an installed directory.
 	# We can't rely on make here, since "install-man" unconditionally
@@ -107,10 +142,12 @@ render_tree () {
 	# through.
 	oid=$1 &&
 	dname=$2 &&
+	makemanflags=$3 &&
 	if ! test -d "$tmp/installed/$dname"
 	then
 		git -C "$tmp/worktree" checkout --detach "$oid" &&
 		make -j$parallel -C "$tmp/worktree" \
+			$makemanflags \
 			GIT_VERSION=omitted \
 			SOURCE_DATE_EPOCH=0 \
 			DESTDIR="$tmp/installed/$dname+" \
@@ -130,6 +167,6 @@ render_tree () {
 	fi
 }
 
-render_tree $from_oid $from_dir &&
-render_tree $to_oid $to_dir &&
+render_tree $from_oid $from_dir $from_makemanflags &&
+render_tree $to_oid $to_dir $to_makemanflags &&
 git -C $tmp/rendered diff --no-index "$@" $from_dir $to_dir
-- 
2.21.0

