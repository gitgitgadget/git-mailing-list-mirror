Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,RCVD_IN_RP_RNBL shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA38F1F453
	for <e@80x24.org>; Wed, 20 Feb 2019 00:00:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbfBTAAu (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Feb 2019 19:00:50 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36759 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727476AbfBTAAu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Feb 2019 19:00:50 -0500
Received: by mail-wm1-f66.google.com with SMTP id j125so4594907wmj.1
        for <git@vger.kernel.org>; Tue, 19 Feb 2019 16:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s/xeHP36mBrVSLI30+VwPXw8gciNDnQZuvpE3YfksfE=;
        b=HL0384ZWnW8q0JEFvlgbwYyDCaVj6X5zZqgPqwRyxKXTuPKFHAoEZA7kMouKWOC5/p
         xRv2yo6QOgIPbgSlulyQcnZLhFNmSFyESVHQYzeXVl1qEfg30uKd5LPH5/mYvfiZdOpA
         k6nb8nVLLtZZKSmRjCXNKbzkgH1FP1/ebeRhBOCjWHRYd3y4G9b2kplldseJ0gLIyOfB
         +UskeofFUb+ahPaz8PLa3NYvSYxvMuhDj2IvicfxDAd0LAHBSBarhO6pUUj4ihqfDZVA
         nolOW2TM+Afwl0VYZtKXbuh1nvnjk62AF+Rq6fHpWlsOXIuaXIHroJJJMakgRnCRmUPr
         4MnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s/xeHP36mBrVSLI30+VwPXw8gciNDnQZuvpE3YfksfE=;
        b=tKjACmeG+ZD31metaa5lZS6PNEj4TnYXUV2+X+S4VjdbAugb5mlMJH7nI+7IsQQha/
         qXIaLk9h5RGxBVCWaC9jBtHGnTxCBIhzWc+WyCZx3b6WRXHJ1VAtu7yBr5Aa4roMZKRk
         ugE7si0ABJFYNPCy6JK1ESCWwh/ydK2R/opn91k7wulMXnuIdb+wLXzLV+xnC1O2JMq7
         DKIxJ92yJkerB2wIfrc6DLLeK/5rgIbklCF+PilyXEtJ0JNcAmfHz31a37j7bKGeLqWH
         RmxFmgAyKmOf0NTDbEWT/pS92d02HpKbIXg1kf+iQE58WKJZtw3QmjUjsYImUQ+A3Qt4
         LUsw==
X-Gm-Message-State: AHQUAuZvPJj7JUb9/dhspEZEQ7KauPtNNXQWSsyQ/l991B6SczaBN0gf
        KJca/pCvDtSdSQb+0AJcfEh5c8Y9
X-Google-Smtp-Source: AHgI3IZJjk6XY45v3vgh96/XcbIjYWMTNxIvgN2aiuWeYHjTdWtsQn1+atu/xpka6LZtn0SJkQWwyQ==
X-Received: by 2002:a1c:ac85:: with SMTP id v127mr4057357wme.62.1550620846546;
        Tue, 19 Feb 2019 16:00:46 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f13sm3307196wmh.41.2019.02.19.16.00.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 19 Feb 2019 16:00:45 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=E7=8E=8B=E5=81=A5=E5=BC=BA?= 
        <jianqiang.wang@securitygossip.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] receive-pack: fix use-after-free bug
Date:   Wed, 20 Feb 2019 01:00:33 +0100
Message-Id: <20190220000033.357-1-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The resolve_ref_unsafe() function can, and sometimes will in the case
of this codepath, return the char * passed to it to the caller. In
this case we construct a strbuf, free it, and then continue using the
dst_name after that free().

The code being fixed dates back to da3efdb17b ("receive-pack: detect
aliased updates which can occur with symrefs", 2010-04-19). When it
was originally added it didn't have this bug, it was introduced when
it was subsequently modified to use strbuf in 6b01ecfe22 ("ref
namespaces: Support remote repositories via upload-pack and
receive-pack", 2011-07-08).

This is theoretically a security issue, the C standard makes no
guarantees that a value you use after free() hasn't been poked at or
changed by something else on the system, but in practice modern OSs
will have mapped the relevant page to this process, so nothing else
would have used it. We do no further allocations between the free()
and use-after-free, so we ourselves didn't corrupt or change the
value.

Jeff investigated that and found: "It probably would be an issue if
the allocation were larger. glibc at least will use mmap()/munmap()
after some cutoff[1], in which case we'd get a segfault from hitting
the unmapped page. But for small allocations, it just bumps brk() and
the memory is still available for further allocations after
free(). [...] If you had a sufficiently large refname you might be
able to trigger the bug [...]. I tried to push such a ref. I had to
manually make a packed-refs file with the long name to avoid
filesystem limits (though probably you could have a long a/b/c/ name
on ext4).  But the result can't actually be pushed, because it all has
to fit into a 64k pkt-line as part of the push protocol.".

An a alternative and more succinct way of implementing this would have
been to do the strbuf_release() at the end of check_aliased_update()
and use "goto out" instead of the early "return" statements. Hopefully
this approach of using a helper instead makes it easier to follow.

1. Jeff: "Weirdly, the mmap() cutoff on my glibc system is 135168
   bytes. Which is...2^17 + 2^12? 33 pages? I'm sure there's a good
   reason for that, but I didn't dig into it."

Reported-by: 王健强 <jianqiang.wang@securitygossip.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

This fixes an issue reported by 王健强 to git-security@. As noted in
the commit message the consensus was that the use-after-free wasn't
exploitable in practice, and that the patch should therefore be
discussed on the main list.

The bug first appeared in v1.7.7, so it's not a 2.21 rc issue, as
might be inferred from the timing of this patch.

 builtin/receive-pack.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index d58b7750b6..0874f5c1b7 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1198,17 +1198,12 @@ static void run_update_post_hook(struct command *commands)
 	}
 }
 
-static void check_aliased_update(struct command *cmd, struct string_list *list)
+static void check_aliased_update_internal(struct command *cmd,
+					  struct string_list *list,
+					  const char *dst_name, int flag)
 {
-	struct strbuf buf = STRBUF_INIT;
-	const char *dst_name;
 	struct string_list_item *item;
 	struct command *dst_cmd;
-	int flag;
-
-	strbuf_addf(&buf, "%s%s", get_git_namespace(), cmd->ref_name);
-	dst_name = resolve_ref_unsafe(buf.buf, 0, NULL, &flag);
-	strbuf_release(&buf);
 
 	if (!(flag & REF_ISSYMREF))
 		return;
@@ -1247,6 +1242,18 @@ static void check_aliased_update(struct command *cmd, struct string_list *list)
 		"inconsistent aliased update";
 }
 
+static void check_aliased_update(struct command *cmd, struct string_list *list)
+{
+	struct strbuf buf = STRBUF_INIT;
+	const char *dst_name;
+	int flag;
+
+	strbuf_addf(&buf, "%s%s", get_git_namespace(), cmd->ref_name);
+	dst_name = resolve_ref_unsafe(buf.buf, 0, NULL, &flag);
+	check_aliased_update_internal(cmd, list, dst_name, flag);
+	strbuf_release(&buf);
+}
+
 static void check_aliased_updates(struct command *commands)
 {
 	struct command *cmd;
-- 
2.21.0.rc0.258.g878e2cd30e

