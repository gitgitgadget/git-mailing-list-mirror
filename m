Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NORMAL_HTTP_TO_IP,
	NUMERIC_HTTP_ADDR,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75E371F4BE
	for <e@80x24.org>; Mon,  7 Oct 2019 13:48:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbfJGNsh (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Oct 2019 09:48:37 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55121 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727324AbfJGNsg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Oct 2019 09:48:36 -0400
Received: by mail-wm1-f68.google.com with SMTP id p7so12770678wmp.4
        for <git@vger.kernel.org>; Mon, 07 Oct 2019 06:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Fs004S2Bs4Rhc7gnVGeWqVeXG1nvfLw5guvYFPsmjh0=;
        b=JVhRr5BlHytXDUGxJyIowLyWyJuK4ZW350vgjWXOGTZ4xexe6fb7MnVlZU0Acu41Rq
         7/T2U6eCVPi6FEznKrKbvhdoutkkgb4A09MROxWQbLj0A5VpzGF9aqL3vfMKhT6qYI5r
         fFyWiHW3v8bW+LXoE/5OnDx8/qAeCOKDPROYqjefoqPKjCmG0FD5YiLl/esdyzSRenQT
         80WEPED/Wu+KM0TYJJmcbmCKctY8gO/fHmDGjooWDE2FzgxWDr80+17pA2C1g6HMO27c
         cgfdxhsJFQQ7SEAt+zStjXN2i40fZ0SUnoLa/SUmE7/SWsnCDSf8khuwnTGiY0UT3X3I
         Ta5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Fs004S2Bs4Rhc7gnVGeWqVeXG1nvfLw5guvYFPsmjh0=;
        b=IDlqP0qthXq7TbaKA/pRf5KbWAv7HkA1bUjKU4IMicmbfbv8BvEEWT/LJVCbHCNqaK
         z6ff+j+bmHS59l3v5X+R+Kz6XyagYZd7C40/jua9Pr8RU99j2XW0S/Vq2XlaX1lcEe8g
         W2PECY05gOeIkbTN9m7RvVb9RoHjK8RwFDFkygk0n3o8nyqfQj/S9qkALPLhTyxF2VGm
         p194xxM6byTBbnG7W6iYGN+/BtdlBz3BNyVRHB5G+tjFCtseWTo0Ptvy1CiFt+pnCwn/
         7DfeLGzE/CdGEhT4RdjAKTCH0bI2KXSl38Y8RhmI6bAxzPDJE/p6/Axo+pRZD7QxoiZp
         wEHw==
X-Gm-Message-State: APjAAAXuEtMSdtL+kK6KU8cQzG8tAGSAIKI0sHpRUvOErdizt/ZzNrR9
        3SimIKkcus6yDDMtkUsvJac=
X-Google-Smtp-Source: APXvYqxMM8ML2GWw9HOYHMngYFXBh8ryxaXFcuqvsaVEl5WRaNTpYhA+w8FbyAMYXe2JMPFGkp7B0A==
X-Received: by 2002:a1c:7d92:: with SMTP id y140mr20542041wmc.141.1570456114391;
        Mon, 07 Oct 2019 06:48:34 -0700 (PDT)
Received: from localhost ([95.149.189.152])
        by smtp.gmail.com with ESMTPSA id u68sm36140950wmu.12.2019.10.07.06.48.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Oct 2019 06:48:31 -0700 (PDT)
Date:   Mon, 7 Oct 2019 14:48:31 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        entwicklung@pengutronix.de
Subject: Re: Regression in v2.23
Message-ID: <20191007134831.GA74671@cat>
References: <20191007110645.7eljju2h6g7ts7lf@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191007110645.7eljju2h6g7ts7lf@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/07, Uwe Kleine-König wrote:
> Hello,
> 
> With git 2.23.0 I have:
> 
> 	uwe@taurus:~/tmp/rangediff-segfault$ git init
> 	Initialized empty Git repository in /home/uwe/tmp/rangediff-segfault/.git/
> 	uwe@taurus:~/tmp/rangediff-segfault$ echo root > root
> 	uwe@taurus:~/tmp/rangediff-segfault$ git add root
> 	uwe@taurus:~/tmp/rangediff-segfault$ git commit -m root
> 	[master (root-commit) b0feddb2dee8] root
> 	 1 file changed, 1 insertion(+)
> 	 create mode 100644 root
> 	uwe@taurus:~/tmp/rangediff-segfault$ echo content > file
> 	uwe@taurus:~/tmp/rangediff-segfault$ chmod +x file
> 	uwe@taurus:~/tmp/rangediff-segfault$ git add file
> 	uwe@taurus:~/tmp/rangediff-segfault$ git commit -m file
> 	[master 45b547c57acd] file
> 	 1 file changed, 1 insertion(+)
> 	 create mode 100755 file
> 	uwe@taurus:~/tmp/rangediff-segfault$ chmod -x file
> 	uwe@taurus:~/tmp/rangediff-segfault$ git add file
> 	uwe@taurus:~/tmp/rangediff-segfault$ git commit -m 'chmod -x'
> 	[master eaa5d3b98caa] chmod -x
> 	 1 file changed, 0 insertions(+), 0 deletions(-)
> 	 mode change 100755 => 100644 file
> 	uwe@taurus:~/tmp/rangediff-segfault$ git range-diff @~2..@~ @~2..
> 	Segmentation fault (core dumped)
> 
> Bisecting points to b66885a30cb84fc61986bc4eea805a31fdbea79a, current master
> (b744c3af07a15aaeb1b82fab689995fd5528f120) segfaults in the same way.
> 
> This is somehow similar to
> https://public-inbox.org/git/20190923101929.GA18205@kitsune.suse.cz/ but
> the patch by Johannes Schindelin sent in
> https://public-inbox.org/git/pull.373.git.gitgitgadget@gmail.com/
> doesn't help me.

Thanks for the report, and testing if those patches help.

> For me the segfault also happens in
> 
> 	strbuf_addstr(&buf, patch.new_name);
> 
> with patch.new_name being NULL.
> 
> The matching backtrace and patch object looks as follows:
> 
> 	(gdb) bt
> 	#0  __strlen_avx2 () at ../sysdeps/x86_64/multiarch/strlen-avx2.S:65
> 	#1  0x0000555cc448949c in strbuf_addstr (s=<optimized out>, sb=0x7ffcd1d9ef00)
> 	    at strbuf.h:292
> 	#2  read_patches (range=range@entry=0x555cc5dc2b70 "@~2..", 
> 	    list=list@entry=0x7ffcd1d9f280) at range-diff.c:126
> 	#3  0x0000555cc44898a8 in show_range_diff (range1=0x555cc5dc2b50 "@~2..@~", 
> 	    range2=0x555cc5dc2b70 "@~2..", creation_factor=60, dual_color=1, 
> 	    diffopt=diffopt@entry=0x7ffcd1d9f680) at range-diff.c:507
> 	#4  0x0000555cc4397aa6 in cmd_range_diff (argc=<optimized out>, 
> 	    argv=<optimized out>, prefix=<optimized out>) at builtin/range-diff.c:80
> 	#5  0x0000555cc4328494 in run_builtin (argv=<optimized out>, 
> 	    argc=<optimized out>, p=<optimized out>) at git.c:445
> 	#6  handle_builtin (argc=<optimized out>, argv=<optimized out>) at git.c:674
> 	#7  0x0000555cc4329554 in run_argv (argv=0x7ffcd1d9f9e0, argcp=0x7ffcd1d9f9ec)
> 	    at git.c:741
> 	#8  cmd_main (argc=<optimized out>, argv=<optimized out>) at git.c:872
> 	#9  0x0000555cc432803a in main (argc=4, argv=0x7ffcd1d9fc78)
> 	    at common-main.c:52
> 	(gdb) up 2
> 	#2  read_patches (range=range@entry=0x555cc5dc2b70 "@~2..", 
> 	    list=list@entry=0x7ffcd1d9f280) at range-diff.c:126
> 	126	range-diff.c: No such file or directory.
> 	(gdb) print patch
> 	$1 = {new_name = 0x0, old_name = 0x0, def_name = 0x555cc5dc98c0 "file", 
> 	  old_mode = 33261, new_mode = 33188, is_new = 0, is_delete = 0, rejected = 0, 
> 	  ws_rule = 0, lines_added = 0, lines_deleted = 0, score = 0, 
> 	  extension_linenr = 0, is_toplevel_relative = 0, inaccurate_eof = 0, 
> 	  is_binary = 0, is_copy = 0, is_rename = 0, recount = 0, 
> 	  conflicted_threeway = 0, direct_to_threeway = 0, crlf_in_old = 0, 
> 	  fragments = 0x0, result = 0x0, resultsize = 0, 
> 	  old_oid_prefix = '\000' <repeats 64 times>, 
> 	  new_oid_prefix = '\000' <repeats 64 times>, next = 0x0, threeway_stage = {{
> 	      hash = '\000' <repeats 31 times>}, {hash = '\000' <repeats 31 times>}, {
> 	      hash = '\000' <repeats 31 times>}}}
> 
> I guess you are able to work out the details with this information. If you need
> more input, please Cc: me on replies.

Indeed, I was able to figure out what's going wrong from the
backtrace.  Here's a patch.  It's not ready for inclusion, as I still
need to write some tests, and make sure I'm not breaking something
else.

I can hopefully do some more testing and write automated tests later
today or tomorrow.  In the meantime it would be awesome if you could
confirm if this patch fixes the problem you were seeing.

I have pushed this to GitHub as well if you prefer that to applying
the patch yourself: https://github.com/tgummerer/git tg/range-diff-mode-only-change

--- >8 ---
Subject: [PATCH] range-diff: don't segfault with mode-only changes

If we don't have a new file, deleted file or renamed file in a diff,
we currently add 'patch.new_name' to the range-diff header.  This
works well for files that are changed.  However if we have a pure mode
change, 'patch.new_name' is NULL, and thus range-diff segfaults.

We can however rely on 'patch.def_name' in that case, which is
extracted from the 'diff --git' line and should be equal to
'patch.new_name'.  Use that instead to avoid the segfault.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 range-diff.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/range-diff.c b/range-diff.c
index ba1e9a4265..d8d906b3c6 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -116,20 +116,20 @@ static int read_patches(const char *range, struct string_list *list)
 			if (len < 0)
 				die(_("could not parse git header '%.*s'"), (int)len, line);
 			strbuf_addstr(&buf, " ## ");
-			if (patch.is_new > 0)
+			free(current_filename);
+			if (patch.is_new > 0) {
 				strbuf_addf(&buf, "%s (new)", patch.new_name);
-			else if (patch.is_delete > 0)
+				current_filename = xstrdup(patch.new_name);
+			} else if (patch.is_delete > 0) {
 				strbuf_addf(&buf, "%s (deleted)", patch.old_name);
-			else if (patch.is_rename)
-				strbuf_addf(&buf, "%s => %s", patch.old_name, patch.new_name);
-			else
-				strbuf_addstr(&buf, patch.new_name);
-
-			free(current_filename);
-			if (patch.is_delete > 0)
 				current_filename = xstrdup(patch.old_name);
-			else
+			} else if (patch.is_rename) {
+				strbuf_addf(&buf, "%s => %s", patch.old_name, patch.new_name);
 				current_filename = xstrdup(patch.new_name);
+			} else {
+				strbuf_addstr(&buf, patch.def_name);
+				current_filename = xstrdup(patch.def_name);
+			}
 
 			if (patch.new_mode && patch.old_mode &&
 			    patch.old_mode != patch.new_mode)
-- 
2.23.0.501.gb744c3af07

