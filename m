From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/2] pathspec: remove deprecated get_pathspec
Date: Thu,  6 Aug 2015 11:27:12 -0700
Message-ID: <1438885632-26470-3-git-send-email-sbeller@google.com>
References: <CAPig+cT_YB=HY9dBo5eRNu4qvCqCXRwwXgpxCA8YjxagP+sHfA@mail.gmail.com>
 <1438885632-26470-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>, pclouds@gmail.com,
	sunshine@sunshineco.com
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Aug 06 20:27:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNPtG-0001ti-4c
	for gcvg-git-2@plane.gmane.org; Thu, 06 Aug 2015 20:27:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755611AbbHFS1e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2015 14:27:34 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:36313 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753846AbbHFS1U (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2015 14:27:20 -0400
Received: by pacrr5 with SMTP id rr5so33141013pac.3
        for <git@vger.kernel.org>; Thu, 06 Aug 2015 11:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FvO/xRWavfClmox8/UlkaAGV+K2MkT0/ql2++w0NHe8=;
        b=XvNU91v/VzuRadBxFzKHfF6IGzl52m67FKyrAz+RiRvcG96mbLguA4nJ4kc1VdO2Mo
         vEa55yje94ilR6fv7G4fTtFAlxZTONbzJkOyH4mby5Z8whovcpGG3zRXpPj7N+rjVuuU
         ans+OTO10nUmVv+1aWIXF7wMEesQNyo4LOCokOUWzrJ+F1x9aTPE6ylRcbWbCTe2tQqu
         g9EEbSQ00PswnGzA1Eq3Yqe83aV5JsB8gB7m3z/swoUWtsbk4iIqOeCFo4IsLm8B2O+k
         5GeFDx7BkQgfTbg+0M6JuEEh88AGTgi4q8LMc2tpNmwt9bdf3O9IOiogTJjw/tK4PW9G
         LwUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FvO/xRWavfClmox8/UlkaAGV+K2MkT0/ql2++w0NHe8=;
        b=Kaf18eVmSfbzJoVsnYhig+YLRICraQ1Zuf5IMApy2SHDaZ7LetFkbDZjWWzmv8neyZ
         332JiP3oewSpc9LwuvCGZfq+jAT3PtybQ6PCpWQ9Tl/p7O3QrGHSUZfdkrCxr8d/imEL
         jqJEtitcKSRGr861hzdgNUES4+5H6n0U5O0B4LEMpfyW9clre0lQEnv701RcnghWJ4A1
         M4EqSGHS1EsQoNMoV1XO89hPgGxBiTqmGxP8YP2FzoMZ3Aw6AGiiUhsFPu67K/RJX2jP
         y4eN+Jb8HTPwfCMUZW4c9w/8OXTWuCV0r/UJCYcRFHO/20wxhFIRhlosaVYiKl3BtB66
         MZlA==
X-Gm-Message-State: ALoCoQmQW/Ztq8b5sUbfq6UGYuWxwLnT/dbw1xp/3xAhqLCsNXsfipyznm+yGWUGf7Z9cpX6UUIb
X-Received: by 10.68.241.166 with SMTP id wj6mr6034132pbc.114.1438885640116;
        Thu, 06 Aug 2015 11:27:20 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:8060:d893:ee2c:36a5])
        by smtp.gmail.com with ESMTPSA id tx5sm7365479pab.30.2015.08.06.11.27.19
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 06 Aug 2015 11:27:19 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.239.g9728e1d.dirty
In-Reply-To: <1438885632-26470-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275433>

The function `get_pathspec` is no longer used, so remove it.

The NEEDSWORK comment in pathspec.c is outdated as that happened in
(fadf96aba, 2013-09-09, Merge branch 'nd/magic-pathspec')

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/technical/api-setup.txt |  2 --
 cache.h                               |  1 -
 pathspec.c                            | 36 -----------------------------------
 pathspec.h                            |  2 +-
 4 files changed, 1 insertion(+), 40 deletions(-)

diff --git a/Documentation/technical/api-setup.txt b/Documentation/technical/api-setup.txt
index 540e455..eb1fa98 100644
--- a/Documentation/technical/api-setup.txt
+++ b/Documentation/technical/api-setup.txt
@@ -27,8 +27,6 @@ parse_pathspec(). This function takes several arguments:
 
 - prefix and args come from cmd_* functions
 
-get_pathspec() is obsolete and should never be used in new code.
-
 parse_pathspec() helps catch unsupported features and reject them
 politely. At a lower level, different pathspec-related functions may
 not support the same set of features. Such pathspec-sensitive
diff --git a/cache.h b/cache.h
index 4f55466..d4e22e2 100644
--- a/cache.h
+++ b/cache.h
@@ -452,7 +452,6 @@ extern void set_git_work_tree(const char *tree);
 
 #define ALTERNATE_DB_ENVIRONMENT "GIT_ALTERNATE_OBJECT_DIRECTORIES"
 
-extern const char **get_pathspec(const char *prefix, const char **pathspec);
 extern void setup_work_tree(void);
 extern const char *setup_git_directory_gently(int *);
 extern const char *setup_git_directory(void);
diff --git a/pathspec.c b/pathspec.c
index 9304ee3..abaec0a 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -94,12 +94,6 @@ static void prefix_short_magic(struct strbuf *sb, int prefixlen,
  *
  * For now, we only parse the syntax and throw out anything other than
  * "top" magic.
- *
- * NEEDSWORK: This needs to be rewritten when we start migrating
- * get_pathspec() users to use the "struct pathspec" interface.  For
- * example, a pathspec element may be marked as case-insensitive, but
- * the prefix part must always match literally, and a single stupid
- * string cannot express such a case.
  */
 static unsigned prefix_pathspec(struct pathspec_item *item,
 				unsigned *p_short_magic,
@@ -450,36 +444,6 @@ void parse_pathspec(struct pathspec *pathspec,
 	}
 }
 
-/*
- * N.B. get_pathspec() is deprecated in favor of the "struct pathspec"
- * based interface - see pathspec.c:parse_pathspec().
- *
- * Arguments:
- *  - prefix - a path relative to the root of the working tree
- *  - pathspec - a list of paths underneath the prefix path
- *
- * Iterates over pathspec, prepending each path with prefix,
- * and return the resulting list.
- *
- * If pathspec is empty, return a singleton list containing prefix.
- *
- * If pathspec and prefix are both empty, return an empty list.
- *
- * This is typically used by built-in commands such as add.c, in order
- * to normalize argv arguments provided to the built-in into a list of
- * paths to process, all relative to the root of the working tree.
- */
-const char **get_pathspec(const char *prefix, const char **pathspec)
-{
-	struct pathspec ps;
-	parse_pathspec(&ps,
-		       PATHSPEC_ALL_MAGIC &
-		       ~(PATHSPEC_FROMTOP | PATHSPEC_LITERAL),
-		       PATHSPEC_PREFER_CWD,
-		       prefix, pathspec);
-	return ps._raw;
-}
-
 void copy_pathspec(struct pathspec *dst, const struct pathspec *src)
 {
 	*dst = *src;
diff --git a/pathspec.h b/pathspec.h
index 0c11262..b345df6 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -19,7 +19,7 @@
 #define PATHSPEC_ONESTAR 1	/* the pathspec pattern satisfies GFNM_ONESTAR */
 
 struct pathspec {
-	const char **_raw; /* get_pathspec() result, not freed by free_pathspec() */
+	const char **_raw; /* not freed by free_pathspec() */
 	int nr;
 	unsigned int has_wildcard:1;
 	unsigned int recursive:1;
-- 
2.5.0.239.g9728e1d.dirty
