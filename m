Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB6C61FAEB
	for <e@80x24.org>; Sat, 10 Jun 2017 13:41:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752134AbdFJNk7 (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Jun 2017 09:40:59 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:35183 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752110AbdFJNkv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jun 2017 09:40:51 -0400
Received: by mail-qt0-f195.google.com with SMTP id x58so19592607qtc.2
        for <git@vger.kernel.org>; Sat, 10 Jun 2017 06:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tzCKJOvThX50FUCp5Msvf5K6o9WrhF5k+uOlxattUig=;
        b=XzBX9X+HMSDjMrFJC9a4T4tETLFMNcq44f3cH39tDXuuAeH1rBB7WJiLGWQtZKe9rx
         j3eiw9TOu/T+CpKWuIkANpL9VissQTP/PTQKogKAmWFfDnJfJe56Pbq+IUI/A7Lu+61V
         7Q0kMWvJSgBU2VeryAI9L1CjN6XwYvwpqUlqvBk/qUvQD9095mn3RmmeGTWaQuenLFMX
         4l99mbYe9gyCVUdkBRJ/fre8RGGb3pUgo97eLkrrTTUpmeBUT5bxz4ihCwybssiy9Xnt
         apIbZdteK/GwHQWwJpQBpVgVZgGk+B2hR7r8Jb5KgkVqnFV7lSB4BZ25UwtRBqSI1SBv
         aQDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tzCKJOvThX50FUCp5Msvf5K6o9WrhF5k+uOlxattUig=;
        b=CKWK6RmTqKlXeHgNMgKPxeCS4GaE0ot1KpgcTeqwFu+Dylnnv/220cEI3xKwVvIE88
         WRXc3wGBwa8U/a8K605XOsfhPGZslPLqLoI43U+1BKZymBzE+VdWzVcBA/Pfyh/fN+pW
         fIqBJUcqwyIVpn235/LXMCIOW+nuYsZU9DLRBH9ctygefs6kzd1C+/WE71kJvpBk1S2t
         KkdJo08GzTQjooHYW/zTmz8RzakNKPGtZPI+Rt2nsCr6JHYJVMg3JvQwm28QS/mWVrqw
         sKr3Rcur0tuYfVUYSZLS0xKcZ5P0crBn14I+6p1/HzWbhoLbL9vXrViVkD8mcYS5IPK3
         OcRg==
X-Gm-Message-State: AODbwcB/t7u70vU1PJPX2qygVQHY+x9WZ0Xv5n9Bzu598jHFP2Wx7WGL
        OOw5oIQE53SJ0k3tt0k=
X-Received: by 10.200.55.148 with SMTP id d20mr39027581qtc.94.1497102050457;
        Sat, 10 Jun 2017 06:40:50 -0700 (PDT)
Received: from localhost.localdomain ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id f94sm2707503qtb.16.2017.06.10.06.40.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 10 Jun 2017 06:40:50 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
X-Google-Original-From: Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, benpeart@microsoft.com, pclouds@gmail.com,
        johannes.schindelin@gmx.de, David.Turner@twosigma.com,
        peff@peff.net, christian.couder@gmail.com, avarab@gmail.com
Subject: [PATCH v5 6/7] fsmonitor: add a sample query-fsmonitor hook script for Watchman
Date:   Sat, 10 Jun 2017 09:40:25 -0400
Message-Id: <20170610134026.104552-7-benpeart@microsoft.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170610134026.104552-1-benpeart@microsoft.com>
References: <20170610134026.104552-1-benpeart@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This hook script integrates the new fsmonitor capabilities of git with
the cross platform Watchman file watching service. To use the script:

Download and install Watchman from https://facebook.github.io/watchman/
and instruct Watchman to watch your working directory for changes
('watchman watch-project /usr/src/git').

Rename the sample integration hook from query-fsmonitor.sample to
query-fsmonitor.

Configure git to use the extension ('git config core.fsmonitor true')
and optionally turn on the untracked cache for optimal performance
('git config core.untrackedcache true').

Signed-off-by: Ben Peart <benpeart@microsoft.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 templates/hooks--query-fsmonitor.sample | 76 +++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)
 create mode 100755 templates/hooks--query-fsmonitor.sample

diff --git a/templates/hooks--query-fsmonitor.sample b/templates/hooks--query-fsmonitor.sample
new file mode 100755
index 0000000000..8d05b87a90
--- /dev/null
+++ b/templates/hooks--query-fsmonitor.sample
@@ -0,0 +1,76 @@
+#!/bin/sh
+#
+# An example hook script to integrate Watchman
+# (https://facebook.github.io/watchman/) with git to provide fast
+# git status.
+#
+# The hook is passed a version (currently 1) and a time in nanoseconds
+# formatted as a string and outputs to stdout all files that have been
+# modified since the given time. Paths must be relative to the root of
+# the working tree and separated by a single NUL.
+#
+# To enable this hook, rename this file to "query-fsmonitor"
+
+# check the hook interface version
+if [ "$1" -eq 1 ]
+then
+	# convert nanoseconds to seconds
+	time_t=$(($2/1000000000))
+else
+	echo -e "Unsupported query-fsmonitor hook version.\nFalling back to scanning...\n" >&2
+	exit 1;
+fi
+
+# Convert unix style paths to what Watchman expects
+case "$(uname -s)" in
+MINGW*|MSYS_NT*)
+  GIT_WORK_TREE="$(cygpath -aw "$PWD" | sed 's,\\,/,g')"
+  ;;
+*)
+  GIT_WORK_TREE="$PWD"
+  ;;
+esac
+
+# In the query expression below we're asking for names of files that
+# changed since $time_t but were not transient (ie created after
+# $time_t but no longer exist).
+#
+# To accomplish this, we're using the "since" generator to use the
+# recency index to select candidate nodes and "fields" to limit the
+# output to file names only. Then we're using the "expression" term to
+# further constrain the results.
+#
+# The category of transient files that we want to ignore will have a
+# creation clock (cclock) newer than $time_t value and will also not
+# currently exist.
+
+echo  "[\"query\", \"$GIT_WORK_TREE\", { \
+	\"since\": $time_t, \
+	\"fields\": [\"name\"], \
+	\"expression\": [\"not\", [\"allof\", [\"since\", $time_t, \"cclock\"], [\"not\", \"exists\"]]] \
+	}]" | \
+	watchman -j |
+	perl -0666 -e '
+		use strict;
+		use warnings;
+
+		my $stdin = <>;
+		die "Watchman: command returned no output.\nFalling back to scanning...\n" if $stdin eq "";
+		die "Watchman: command returned invalid output: $stdin\nFalling back to scanning...\n" unless $stdin =~ /^\{/;
+
+		my $json_pkg;
+		eval {
+			require JSON::XS;
+			$json_pkg = "JSON::XS";
+			1;
+		} or do {
+			require JSON::PP;
+			$json_pkg = "JSON::PP";
+		};
+
+		my $o = $json_pkg->new->utf8->decode($stdin);
+		die "Watchman: $o->{error}.\nFalling back to scanning...\n" if $o->{error};
+
+		local $, = "\0";
+		print @{$o->{files}};
+	'
-- 
2.13.0

