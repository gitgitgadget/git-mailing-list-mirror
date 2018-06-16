Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC0231F403
	for <e@80x24.org>; Sat, 16 Jun 2018 05:42:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756508AbeFPFmG (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Jun 2018 01:42:06 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35738 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754027AbeFPFmD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jun 2018 01:42:03 -0400
Received: by mail-lf0-f66.google.com with SMTP id i15-v6so17532037lfc.2
        for <git@vger.kernel.org>; Fri, 15 Jun 2018 22:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C/+s72XH6I81c5lN4IK/WXsFBBcW147tCCugPqF/BAE=;
        b=G1LVdrBtPyvNX9Kp+1niX5ufQv8VqfwTs7te45aFGaBCPNPpwFv6WYA5xHnCq9w8a3
         r1/akIVZSLxhPOKhRn0dpR+7K86osxbyn2TrUjU1gsts41LK43Nu5tI8GVYokjCHYD7F
         TQWNbhmqz8HF4Wx3uX1nXu/Cy03Wr/x4+jTS996xKvmwELxrZmLo2XVHi8Qb9w/BtlsL
         O9PmQvNbXNN7Ff0TmRERGj7V1YaN6EVlOUPC/Zy5xHDgGuEXqCRT+yPFKBzKmI1K86n5
         gH+RDp0oGxrLDwLIJyb8I+yyIEj4oKfC8LAsuD2AuuyvGIbPxcBEwC9fuwK7Y9TvLvq/
         UCew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C/+s72XH6I81c5lN4IK/WXsFBBcW147tCCugPqF/BAE=;
        b=O5dAOGYkeSyc6+ZP07mzgT/lJqj7HwC57EK86rIB9VxONBufsa4l6lfaQDrU8RnoDn
         BarV7Irkdhinsm3u2gakwxSWAAcLMSmWK2s7ydx4Pjn4oc/uEmjWtkYL+BPccUMDj+qO
         0XMTOxavdMRw1uIFyO3EXieXNDj9+g9/E9+mS2WjvVNlVudpzF01vY2p0RARrjcLrp/C
         E5Rl0/KNsEa1HL6FEtt7+c0XmRd3RggrFzqIcIbmpR7y+Jbk4g0E/tvQUjmK2WOcQ8p0
         7TVMClg0OT0yd0fi3WaFk4kioUa7zL6iN9+LYqH3TnPdwzTksJiKHSeO6ZkAPSyXRJRY
         ZYmQ==
X-Gm-Message-State: APt69E17RQm4/yl6nzVTjUq/q1JdgeOBbJ8teK74L3g8geUJlk+pf1SE
        fNSfe407K4juisn1GQoaubeDGA==
X-Google-Smtp-Source: ADUXVKJPfiiB0uyedlQW4j9ChaYmULJcxj+5SCNpWwLOvvJntx7ezXXvDX/4i9UQF4w56B41WUAsLw==
X-Received: by 2002:a19:97cb:: with SMTP id z194-v6mr2871928lfd.17.1529127722065;
        Fri, 15 Jun 2018 22:42:02 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g5-v6sm1745194lje.21.2018.06.15.22.42.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jun 2018 22:42:01 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 01/15] contrib: add cocci script to replace index compat macros
Date:   Sat, 16 Jun 2018 07:41:43 +0200
Message-Id: <20180616054157.32433-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.333.g22e6ee6cdf
In-Reply-To: <20180616054157.32433-1-pclouds@gmail.com>
References: <20180616054157.32433-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Index compat macros are going to be removed to expose the_index and
then reorganized to use the right index instead of simply the_index
because sometimes we want to use a different index.

This cocci script can help with the first step. It can be used later
on on even builtin/ when we start to reorganize code in there, but for
now this is the script that performs all the conversion outside
builtin/

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 contrib/coccinelle/index-compat.cocci | 184 ++++++++++++++++++++++++++
 1 file changed, 184 insertions(+)
 create mode 100644 contrib/coccinelle/index-compat.cocci

diff --git a/contrib/coccinelle/index-compat.cocci b/contrib/coccinelle/index-compat.cocci
new file mode 100644
index 0000000000..ca46711eb6
--- /dev/null
+++ b/contrib/coccinelle/index-compat.cocci
@@ -0,0 +1,184 @@
+@@
+@@
+-active_cache
++the_index.cache
+
+@@
+@@
+-active_nr
++the_index.cache_nr
+
+@@
+@@
+-active_alloc
++the_index.cache_alloc
+
+@@
+@@
+-active_cache_changed
++the_index.cache_changed
+
+@@
+@@
+-active_cache_tree
++the_index.cache_tree
+
+@@
+@@
+- read_cache()
++ read_index(&the_index)
+
+@@
+expression path;
+@@
+- read_cache_from(path)
++ read_index_from(&the_index, path, get_git_dir())
+
+@@
+expression pathspec;
+@@
+- read_cache_preload(pathspec)
++ read_index_preload(&the_index, pathspec)
+
+@@
+@@
+- is_cache_unborn()
++ is_index_unborn(&the_index)
+
+@@
+@@
+- read_cache_unmerged()
++ read_index_unmerged(&the_index)
+
+@@
+@@
+- discard_cache()
++ discard_index(&the_index)
+
+@@
+@@
+- unmerged_cache()
++ unmerged_index(&the_index)
+
+@@
+expression name;
+expression namelen;
+@@
+- cache_name_pos(name, namelen)
++ index_name_pos(&the_index, name, namelen)
+
+@@
+expression ce;
+expression option;
+@@
+- add_cache_entry(ce, option)
++ add_index_entry(&the_index, ce, option)
+
+@@
+expression pos;
+expression new_name;
+@@
+- rename_cache_entry_at(pos, new_name)
++ rename_index_entry_at(&the_index, pos, new_name)
+
+@@
+expression pos;
+@@
+- remove_cache_entry_at(pos)
++ remove_index_entry_at(&the_index, pos)
+
+@@
+expression path;
+@@
+- remove_file_from_cache(path)
++ remove_file_from_index(&the_index, path)
+
+@@
+expression path;
+expression st;
+expression flags;
+@@
+- add_to_cache(path, st, flags)
++ add_to_index(&the_index, path, st, flags)
+
+@@
+expression path;
+expression flags;
+@@
+- add_file_to_cache(path, flags)
++ add_file_to_index(&the_index, path, flags)
+
+@@
+expression ce;
+expression flip;
+@@
+-chmod_cache_entry(ce, flip)
++chmod_index_entry(&the_index, ce, flip)
+
+@@
+expression flags;
+@@
+-refresh_cache(flags)
++refresh_index(&the_index, flags, NULL, NULL, NULL)
+
+@@
+expression ce;
+expression st;
+expression options;
+@@
+-ce_match_stat(ce, st, options)
++ie_match_stat(&the_index, ce, st, options)
+
+@@
+expression ce;
+expression st;
+expression options;
+@@
+-ce_modified(ce, st, options)
++ie_modified(&the_index, ce, st, options)
+
+@@
+expression name;
+expression namelen;
+@@
+-cache_dir_exists(name, namelen)
++index_dir_exists(&the_index, name, namelen)
+
+@@
+expression name;
+expression namelen;
+expression igncase;
+@@
+-cache_file_exists(name, namelen, igncase)
++index_file_exists(&the_index, name, namelen, igncase)
+
+@@
+expression name;
+expression namelen;
+@@
+-cache_name_is_other(name, namelen)
++index_name_is_other(&the_index, name, namelen)
+
+@@
+@@
+-resolve_undo_clear()
++resolve_undo_clear_index(&the_index)
+
+@@
+expression at;
+@@
+-unmerge_cache_entry_at(at)
++unmerge_index_entry_at(&the_index, at)
+
+@@
+expression pathspec;
+@@
+-unmerge_cache(pathspec)
++unmerge_index(&the_index, pathspec)
+
+@@
+expression path;
+expression sz;
+@@
+-read_blob_data_from_cache(path, sz)
++read_blob_data_from_index(&the_index, path, sz)
-- 
2.18.0.rc0.333.g22e6ee6cdf

