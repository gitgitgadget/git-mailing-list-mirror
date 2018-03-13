Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AB241F404
	for <e@80x24.org>; Tue, 13 Mar 2018 20:40:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753134AbeCMUkD (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Mar 2018 16:40:03 -0400
Received: from mail-wr0-f178.google.com ([209.85.128.178]:42977 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753122AbeCMUj6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Mar 2018 16:39:58 -0400
Received: by mail-wr0-f178.google.com with SMTP id s18so2238839wrg.9
        for <git@vger.kernel.org>; Tue, 13 Mar 2018 13:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=g0t1z1fV/g/GeZYYkj/zeNQBK2/n18mW/uWcGlTs6PE=;
        b=u7zZWcZ41m4t1X1tcxLLVRARDGDspqJ66q68RReXxKjnsBp3zvWEryDHmWfY+roTyy
         Ik4lzXdKRrbN2c3w2jT9xdE0TeWXru5oh/jmoYgRzNxmkty3uVH3HSvXwBIaZn9COnuc
         kH8olmo0P21a/VwOG4KJpyExjV1GmUR+jVy3+wOCQ9tzUL8txk+Un44t+C4Xz6V3fVpf
         VRe1N39hE3eMKOwq2f0P7/S9qc/exKmpSl8GcufbCe/aQxjyWSzKapYIZaUDJnoIvRFo
         bmrMa7nvJ0S/Rc8Tm2KZI7WhdL7/qVknxvTqj+C20Q3AoSPrFgUOZM4uhxDHMy2UuboD
         6HMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=g0t1z1fV/g/GeZYYkj/zeNQBK2/n18mW/uWcGlTs6PE=;
        b=pXWrws6BUkn4BWbGAysFpwLsExE3cTiCUg81742BlieqdLX/Et5Dls4CE2FZJvvZCH
         Z+F70p72PGxFbNZRs2Z3WXI55t1RkWXU8MGoHDXwFXE2QB7fh1FkSGsaVaBA1cOZW6sD
         UXp88M1fBOfQjR/+Jt/Jn/tEp3qwv26tXDzDRhclD5xKuU+QbuP1/9A7UbG3/ztJAQAH
         u1HpDQROb9zDQ4h6isw4FiYp1moTEDJw0YF9TgWZGPmppI8+dS/3Fl3w7HG7c+Ja+D+4
         U0vP+LMGM8mc95UuT8PJZ3vuYYawuA8py2MT8bApdtZeBOqw+y7T0jHxrq3axRp1/kuG
         qjWw==
X-Gm-Message-State: AElRT7Gxi2lPFVr+FpM9X2xcCqJbhFbBNAB7Vs1j0fbMN1WuSnzRuXdv
        Ho+iy31IDRI9fgCxz9JKWyxWc+GF
X-Google-Smtp-Source: AG47ELsPCD2C9VytrwAmMWoPhkJ/PYoLEbi00LjXvLcuwgfMVIc1+6AeiRliDToIiwu3nNShBQty8g==
X-Received: by 10.223.146.102 with SMTP id 93mr1678537wrj.255.1520973596239;
        Tue, 13 Mar 2018 13:39:56 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id m9sm1424203wrf.13.2018.03.13.13.39.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Mar 2018 13:39:55 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Daniel Jacques <dnj@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Steffen Prohaska <prohaska@zib.de>,
        John Keeping <john@keeping.me.uk>, Stan Hu <stanhu@gmail.com>,
        Richard Clamp <richardc@unixbeard.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/3] Makefile: optionally symlink libexec/git-core binaries to bin/git
Date:   Tue, 13 Mar 2018 20:39:35 +0000
Message-Id: <20180313203935.5084-4-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180313203935.5084-1-avarab@gmail.com>
References: <20180313203935.5084-1-avarab@gmail.com>
In-Reply-To: <xmqqfu533jrk.fsf@gitster-ct.c.googlers.com>
References: <xmqqfu533jrk.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a INSTALL_SYMLINKS option which if enabled, changes the default
hardlink installation method to one where the relevant binaries in
libexec/git-core are symlinked back to ../../bin, instead of being
hardlinked.

This new option also overrides the behavior of the existing
NO_*_HARDLINKS variables which in some cases would produce symlinks
within to libexec/, e.g. "git-add" symlinked to "git" which would be
copy of the "git" found in bin/, now "git-add" in libexec/ is always
going to be symlinked to the "git" found in the bin/ directory.

This option is being added because:

 1) I think it makes what we're doing a lot more obvious. E.g. I'd
    never noticed that the libexec binaries were really just hardlinks
    since e.g. ls(1) won't show that in any obvious way. You need to
    start stat(1)-ing things and look at the inodes to see what's
    going on.

 2) Some tools have very crappy support for hardlinks, e.g. the Git
    shipped with GitLab is much bigger than it should be because
    they're using a chef module that doesn't know about hardlinks, see
    https://github.com/chef/omnibus/issues/827

    I've also ran into other related issues that I think are explained
    by this, e.g. compiling git with debugging and rpm refusing to
    install a ~200MB git package with 2GB left on the FS, I think that
    was because it doesn't consider hardlinks, just the sum of the
    byte size of everything in the package.

As for the implementation, the "../../bin" noted above will vary given
some given some values of "../.." and "bin" depending on the depth of
the gitexecdir relative to the destdir, and the "bindir" target,
e.g. setting "bindir=/tmp/git/binaries gitexecdir=foo/bar/baz" will do
the right thing and produce this result:

    $ file /tmp/git/foo/bar/baz/git-add
    /tmp/git/foo/bar/baz/git-add: symbolic link to ../../../binaries/git

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 46 +++++++++++++++++++++++++++++++---------------
 1 file changed, 31 insertions(+), 15 deletions(-)

diff --git a/Makefile b/Makefile
index ee0b6c8940..ac7616422d 100644
--- a/Makefile
+++ b/Makefile
@@ -329,6 +329,13 @@ all::
 # when hardlinking a file to another name and unlinking the original file right
 # away (some NTFS drivers seem to zero the contents in that scenario).
 #
+# Define INSTALL_SYMLINKS if you prefer to have everything that can be
+# symlinked between bin/ and libexec/ to use relative symlinks between
+# the two. This option overrides NO_CROSS_DIRECTORY_HARDLINKS and
+# NO_INSTALL_HARDLINKS which will also use symlinking by indirection
+# within the same directory in some cases, INSTALL_SYMLINKS will
+# always symlink to the final target directly.
+#
 # Define NO_CROSS_DIRECTORY_HARDLINKS if you plan to distribute the installed
 # programs as a tar, where bin/ and libexec/ might be on different file systems.
 #
@@ -2594,35 +2601,44 @@ endif
 
 	bindir=$$(cd '$(DESTDIR_SQ)$(bindir_SQ)' && pwd) && \
 	execdir=$$(cd '$(DESTDIR_SQ)$(gitexec_instdir_SQ)' && pwd) && \
+	destdir_from_execdir_SQ=$$(echo '$(gitexecdir_relative_SQ)' | sed -e 's|[^/][^/]*|..|g') && \
 	{ test "$$bindir/" = "$$execdir/" || \
 	  for p in git$X $(filter $(install_bindir_programs),$(ALL_PROGRAMS)); do \
 		$(RM) "$$execdir/$$p" && \
-		test -z "$(NO_INSTALL_HARDLINKS)$(NO_CROSS_DIRECTORY_HARDLINKS)" && \
-		ln "$$bindir/$$p" "$$execdir/$$p" 2>/dev/null || \
-		cp "$$bindir/$$p" "$$execdir/$$p" || exit; \
+		test -n "$(INSTALL_SYMLINKS)" && \
+		ln -s "$$destdir_from_execdir_SQ/$(bindir_relative_SQ)/$$p" "$$execdir/$$p" || \
+		{ test -z "$(NO_INSTALL_HARDLINKS)$(NO_CROSS_DIRECTORY_HARDLINKS)" && \
+		  ln "$$bindir/$$p" "$$execdir/$$p" 2>/dev/null || \
+		  cp "$$bindir/$$p" "$$execdir/$$p" || exit; } \
 	  done; \
 	} && \
 	for p in $(filter $(install_bindir_programs),$(BUILT_INS)); do \
 		$(RM) "$$bindir/$$p" && \
-		test -z "$(NO_INSTALL_HARDLINKS)" && \
-		ln "$$bindir/git$X" "$$bindir/$$p" 2>/dev/null || \
-		ln -s "git$X" "$$bindir/$$p" 2>/dev/null || \
-		cp "$$bindir/git$X" "$$bindir/$$p" || exit; \
+		test -n "$(INSTALL_SYMLINKS)" && \
+		ln -s "git$X" "$$bindir/$$p" || \
+		{ test -z "$(NO_INSTALL_HARDLINKS)" && \
+		  ln "$$bindir/git$X" "$$bindir/$$p" 2>/dev/null || \
+		  ln -s "git$X" "$$bindir/$$p" 2>/dev/null || \
+		  cp "$$bindir/git$X" "$$bindir/$$p" || exit; } \
 	done && \
 	for p in $(BUILT_INS); do \
 		$(RM) "$$execdir/$$p" && \
-		test -z "$(NO_INSTALL_HARDLINKS)" && \
-		ln "$$execdir/git$X" "$$execdir/$$p" 2>/dev/null || \
-		ln -s "git$X" "$$execdir/$$p" 2>/dev/null || \
-		cp "$$execdir/git$X" "$$execdir/$$p" || exit; \
+		test -n "$(INSTALL_SYMLINKS)" && \
+		ln -s "$$destdir_from_execdir_SQ/$(bindir_relative_SQ)/git$X" "$$execdir/$$p" || \
+		{ test -z "$(NO_INSTALL_HARDLINKS)" && \
+		  ln "$$execdir/git$X" "$$execdir/$$p" 2>/dev/null || \
+		  ln -s "git$X" "$$execdir/$$p" 2>/dev/null || \
+		  cp "$$execdir/git$X" "$$execdir/$$p" || exit; } \
 	done && \
 	remote_curl_aliases="$(REMOTE_CURL_ALIASES)" && \
 	for p in $$remote_curl_aliases; do \
 		$(RM) "$$execdir/$$p" && \
-		test -z "$(NO_INSTALL_HARDLINKS)" && \
-		ln "$$execdir/git-remote-http$X" "$$execdir/$$p" 2>/dev/null || \
-		ln -s "git-remote-http$X" "$$execdir/$$p" 2>/dev/null || \
-		cp "$$execdir/git-remote-http$X" "$$execdir/$$p" || exit; \
+		test -n "$(INSTALL_SYMLINKS)" && \
+		ln -s "git-remote-http$X" "$$execdir/$$p" || \
+		{ test -z "$(NO_INSTALL_HARDLINKS)" && \
+		  ln "$$execdir/git-remote-http$X" "$$execdir/$$p" 2>/dev/null || \
+		  ln -s "git-remote-http$X" "$$execdir/$$p" 2>/dev/null || \
+		  cp "$$execdir/git-remote-http$X" "$$execdir/$$p" || exit; } \
 	done && \
 	./check_bindir "z$$bindir" "z$$execdir" "$$bindir/git-add$X"
 
-- 
2.15.1.424.g9478a66081

