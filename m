Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C58AE2018E
	for <e@80x24.org>; Mon,  8 Aug 2016 21:05:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752839AbcHHVFK (ORCPT <rfc822;e@80x24.org>);
	Mon, 8 Aug 2016 17:05:10 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35059 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752786AbcHHVEs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2016 17:04:48 -0400
Received: by mail-wm0-f67.google.com with SMTP id i5so17868469wmg.2
        for <git@vger.kernel.org>; Mon, 08 Aug 2016 14:04:47 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WYGucJ9nPzonxWH3ckRxpOPMc/OoBjb6Ffnby1I420k=;
        b=jt+hOc3SPzyZJCKXV4nucD2QOXvArACpE5oOls3pgkOR54xTN5EWS+IprlOquJ3fgX
         mXIHdLfIkVbtwvwqJznk/EUebZ6QkvYS9eKkfANJZQXLxa7NnOiDHVSsdJB1we4dsuhR
         ovDUuK1QSidueaJxewoWk3YDDRo8pioC3hr3zYC8PrQgVTpILOzfvZsnXYq5KpOhRBg3
         VFkPlBVJBwd+T3F+Y1z5GuFlfjFGrayp+3VMAC1ry1ZWyjGBnSeT6ipGvc9fQiJKp5hp
         SzfEA7HGV+GOQNu0kNshPLMZ/Z48jd2HrOF63PGuasP/rSTnpuV4qMf+6fmhokXsc0Cr
         60Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WYGucJ9nPzonxWH3ckRxpOPMc/OoBjb6Ffnby1I420k=;
        b=azX1iSIbU/54ViB9vkgPq0kCPu5z5JI33QeL3JMQkBduDoMXRuUGAwMUdDhGmSU6Mg
         MRcKbd/KPAj1vxP9kG4WoBenakYH4RNeQxOk/wyin3qsfse7mmEX6Pn95ukiMDXIG2DM
         H84EmI/HXraoQegRuXUiiJJFPuBtiTGYJTPrmx3HR6/eOsyHI/rZBjFGhTYs17VD11b7
         MzX+wwmKF75CqpgyFIWOej/CVfzUq4yDmNjH91c8U792854Mbky8d0PkFJ2JhktgTe+N
         Ixip+E/hqNcfAGQ5gHviU4dxWjM/irgJP7aQP3vVYc0DVMwVdMcZhUgdFwJCCbfNOs0N
         Gomw==
X-Gm-Message-State: AEkoouu20d2BaBMld7rGXDWnjd7zokMIfqYNQIN+DfAIVPwKi5KYWkKPTfcNlNPCTTn/+Q==
X-Received: by 10.194.65.170 with SMTP id y10mr24239279wjs.26.1470690286621;
        Mon, 08 Aug 2016 14:04:46 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id o2sm8539048wjo.3.2016.08.08.14.04.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 08 Aug 2016 14:04:45 -0700 (PDT)
From:	Christian Couder <christian.couder@gmail.com>
X-Google-Original-From:	Christian Couder <chriscool@tuxfamily.org>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v10 33/40] environment: add set_index_file()
Date:	Mon,  8 Aug 2016 23:03:30 +0200
Message-Id: <20160808210337.5038-34-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.2.614.g5428e0c
In-Reply-To: <20160808210337.5038-1-chriscool@tuxfamily.org>
References: <20160808210337.5038-1-chriscool@tuxfamily.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Introduce set_index_file() to be able to temporarily change the
index file.

Yeah, this is a short cut and this new function should not be used
by other code.

It adds a small technical debt, because unfortunately a very big
technical debt already exists as the apply code and a lot of other
"libified" code already call functions like read_cache(),
discard_cache() and cache_name_pos() instead of functions like
read_index_from(), discard_index() and index_name_pos() that are
available when the NO_THE_INDEX_COMPATIBILITY_MACROS env variable
is defined.

Avoiding this small new technical debt is unfortunately not as simple
as just changing these functions in "apply.c", as these functions can
be called by other "libified" code that can indirectly be called by
apply code.

For example cache_name_pos() is used in "dir.c" and "diff.c", and then
"dir.h" and "diff.h" are included in many other "libified" *.c files
(including "apply.c"). So it is very difficult to make sure that apply
code doesn't indirectly call any of the problematic functions.

And even if it was possible to make sure that now "apply.c" doesn't
indirectly call any of these functions, how could we make sure that
later a refactoring in other "libified" code will not change a
function that is indirectly called by "apply.c" to make it call another
function that indirectly calls a problematic function?

So it's a different project altogether to remove calls to problematic
functions (like read_cache(), discard_cache(), cache_name_pos() and so
on) in all the libified code, starting maybe with "dir.c" and "diff.c".

Now if someone really needs to use this new function, it should be
used like this:

    /* Save current index file */
    old_index_file = get_index_file();
    set_index_file((char *)tmp_index_file);

    /* Do stuff that will use tmp_index_file as the index file */
    ...

    /* When finished reset the index file */
    set_index_file(old_index_file);

It is intended to be used by builtins commands, in fact only `git am`,
to temporarily change the index file used by libified code.

This is useful when libified code uses the global index, but a builtin
command wants another index file to be used instead.

Helped-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 cache.h       | 13 +++++++++++++
 environment.c | 16 ++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/cache.h b/cache.h
index b5f76a4..c9ad7f9 100644
--- a/cache.h
+++ b/cache.h
@@ -471,6 +471,19 @@ extern const char *strip_namespace(const char *namespaced_ref);
 extern const char *get_git_work_tree(void);
 
 /*
+ * Hack to temporarily change the index.
+ * Yeah, the libification of 'apply' took a short-circuit by adding
+ * this technical debt.
+ * Please use functions available when
+ * NO_THE_INDEX_COMPATIBILITY_MACROS is defined, instead of this
+ * function.
+ * If you really need to use this function, please save the current
+ * index file using get_index_file() before changing the index
+ * file. And when finished, reset it to the saved value.
+ */
+extern void set_index_file(char *index_file);
+
+/*
  * Return true if the given path is a git directory; note that this _just_
  * looks at the directory itself. If you want to know whether "foo/.git"
  * is a repository, you must feed that path, not just "foo".
diff --git a/environment.c b/environment.c
index ca72464..55b2b6b 100644
--- a/environment.c
+++ b/environment.c
@@ -292,6 +292,22 @@ int odb_pack_keep(char *name, size_t namesz, const unsigned char *sha1)
 	return open(name, O_RDWR|O_CREAT|O_EXCL, 0600);
 }
 
+/*
+ * Hack to temporarily change the index.
+ * Yeah, the libification of 'apply' took a short-circuit by adding
+ * this technical debt.
+ * Please use functions available when
+ * NO_THE_INDEX_COMPATIBILITY_MACROS is defined, instead of this
+ * function.
+ * If you really need to use this function, please save the current
+ * index file using get_index_file() before changing the index
+ * file. And when finished, reset it to the saved value.
+ */
+void set_index_file(char *index_file)
+{
+	git_index_file = index_file;
+}
+
 char *get_index_file(void)
 {
 	if (!git_index_file)
-- 
2.9.2.614.g4980f51

