Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DA581F462
	for <e@80x24.org>; Tue, 18 Jun 2019 17:09:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729994AbfFRRJS (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jun 2019 13:09:18 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40338 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729319AbfFRRJS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jun 2019 13:09:18 -0400
Received: by mail-pf1-f196.google.com with SMTP id p184so8017818pfp.7
        for <git@vger.kernel.org>; Tue, 18 Jun 2019 10:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E0tDpwlg+OKRkVbD+oy1LwC7tE5sbq/gpCxskU0uUP0=;
        b=j2aizDIFvDSKQS0X4EyteZ72VbEZcsE7kHvcFV+LNcRt1hU9HAF9uTntU0MukBLu8u
         XUjDZnBi7dWbQyeayohpAHOSLOgSaTpyESipAZR9FbppYuypnOWT8T/Q/xQpL9aLQJMa
         XOgx2RVCjlPplGYN6ImeXBncbVIXeIi4jH1rYvcN2lGTV4teKnBkEGX0XRdQbGadIQNo
         YqhwGt3O4HhA0tRicOckIkn7wx94ksa//8Zes114cFoK7rlCa4+zDAgWc5w8JsSQfB+s
         m/OAttgd4R81oORKsC28sL/EJScw/l9eMvOm/3I4lXkzpKTRWRw24hMez+delUa8oa0s
         XvMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E0tDpwlg+OKRkVbD+oy1LwC7tE5sbq/gpCxskU0uUP0=;
        b=aTbXcUp8/M6IrnjRCd3RpIxg9gdDDXi6pQG1nrx3PN4igDvl4AFBiHOOq94DzTR2Bo
         1pjA+QMJhBG2A4mfUrZUYWj6xHZOdPwVMvnIPecQoH5ciLGZTW9+Tq8407ZcBm7p3ZD/
         JgxFxfyfYDCxXeEzs19CVX1Tpz1Y2gaKTkLq2TWgr4WxL5gYn0MiAhnmLqrRCd64UuFb
         6TD2w2PzIva8F26WJ1D5BIlSjJ2hfLvcHIAVVs55+wnvqIqF6VNSItD/4pG8ctnauJpU
         w1kHlHBVGwIIwmVLFRaQVYXBK2f+BTcnISQDcx0dVhcV9IrxZw8RYQuer4OrwZV3Vr+v
         ELjw==
X-Gm-Message-State: APjAAAW44UpVBseKAAPo5qruQ274HkpvrPVhsX4KdHIW5jTTrkYA9VrD
        NWODWUp4JS5+XVAK1IGE+OY=
X-Google-Smtp-Source: APXvYqw185gYxQOEdKAwzkmBP3zq0L4QtEqYw7PX6G+sAXypb7mbCUWTzsD8abHLFgmIHHVdvglDeQ==
X-Received: by 2002:a17:90a:480a:: with SMTP id a10mr6282563pjh.57.1560877757509;
        Tue, 18 Jun 2019 10:09:17 -0700 (PDT)
Received: from ar135.iitr.ernet.in ([103.37.201.80])
        by smtp.gmail.com with ESMTPSA id d6sm14251093pgf.55.2019.06.18.10.09.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 10:09:16 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     rohit.ashiwal265@gmail.com
Cc:     git@vger.kernel.org, newren@gmail.com, t.gummerer@gmail.com,
        phillip.wood123@gmail.com, martin.agren@gmail.com,
        jrnieder@gmail.com, gitster@pobox.com
Subject: [GSoC][PATCH v5 2/5] sequencer: rename reset_for_rollback to reset_merge
Date:   Tue, 18 Jun 2019 22:36:47 +0530
Message-Id: <20190618170650.22721-3-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190618170650.22721-1-rohit.ashiwal265@gmail.com>
References: <20190608191958.4593-1-rohit.ashiwal265@gmail.com>
 <20190618170650.22721-1-rohit.ashiwal265@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We are on a path to teach cherry-pick/revert how to skip commits. To
achieve this, we could really make use of existing functions.
reset_for_rollback is one such function, but the name does not
intuitively suggest to use it to reset a merge, which it was born to
perform see 539047c ("revert: introduce --abort to cancel a failed
cherry-pick", 2011-11-23). Change the name to reset_merge to make
it more intuitive.

Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
---
 sequencer.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index c644368b54..12f2605ded 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2731,7 +2731,7 @@ static int rollback_is_safe(void)
 	return oideq(&actual_head, &expected_head);
 }
 
-static int reset_for_rollback(const struct object_id *oid)
+static int reset_merge(const struct object_id *oid)
 {
 	const char *argv[4];	/* reset --merge <arg> + NULL */
 
@@ -2753,7 +2753,7 @@ static int rollback_single_pick(struct repository *r)
 		return error(_("cannot resolve HEAD"));
 	if (is_null_oid(&head_oid))
 		return error(_("cannot abort from a branch yet to be born"));
-	return reset_for_rollback(&head_oid);
+	return reset_merge(&head_oid);
 }
 
 int sequencer_rollback(struct repository *r, struct replay_opts *opts)
@@ -2796,7 +2796,7 @@ int sequencer_rollback(struct repository *r, struct replay_opts *opts)
 		warning(_("You seem to have moved HEAD. "
 			  "Not rewinding, check your HEAD!"));
 	} else
-	if (reset_for_rollback(&oid))
+	if (reset_merge(&oid))
 		goto fail;
 	strbuf_release(&buf);
 	return sequencer_remove_state(opts);
-- 
2.21.0

