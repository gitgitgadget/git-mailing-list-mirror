Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9027AC4332F
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 08:43:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbiJMInE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 04:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiJMImz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 04:42:55 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB04E11C265
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 01:42:53 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id bp11so1691638wrb.9
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 01:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DA638DpmCNs4fVsqrnUKB6t0csSxWofyQYcTp0QOw0s=;
        b=mm+ctdKOrji+s+aDnUBg7kyG6wk+yePOnyUP1g95mgq1I4TyKGftkPihkOHSM0Q5ht
         fFeGlibZGa6BJwzEPuSICDbaLxxfxjhSq0g0JA/ppL7g8uTiSxVGVMRlg4OJsEpHL98z
         PogkoRbjF3HWwwSb6OPjRY1ZR0ISxdosGi4WDEiIS7CbF/g6ARNW2Ski3XaidH330O7f
         vpDHCvFC9wj9QcSw4k79yiyLgW3lLRa1vQ/3CP8bpkkOJJRJVq6elXVIrIYCwUiLH8Hj
         /bj5CMaJD3+8+AeLuyp1bpx5FdT68hNlV6nWIXYOKfqdeXvacz4IUepy5IgHN5/jkfy8
         6MYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DA638DpmCNs4fVsqrnUKB6t0csSxWofyQYcTp0QOw0s=;
        b=5gfpat4jiB20pfH+5gXYrenUdbPl/GAX4uplqrJw7HTJYgPCq1rylfpidNXLLd93ul
         +QaI/FciFP3yieRjPn8qvalKhTA6EMr63Lq0caI7jIfe4nmNhF1SDpF3Lbq2Q21RG75p
         FmJ0ekLNtpEmOrIpJ2BLj3jH2ADdaxT3U30nPwE1Pmmr8vXKsGet9tRBlyj8UtiwMRpt
         fYIK/ecWTTwyS3+vCur79Ll1auSfygzUOE5zvH6QWTXbYUKcs0XtfObxgsHL0G5NVO6J
         YnRY9OwuDdiJJCHLKPeWf/h+yKkMzh4ce9vlIlgFDIN3uxqCRTj7kDbssy619m/SZxX+
         gPEw==
X-Gm-Message-State: ACrzQf3719sTPjkt7s1puhR9Qq4yM5p+SVah01JbRmwK58OkucZjumBH
        zAX3KCydL8Ifi4oFjqB5Olugl5i1GR0=
X-Google-Smtp-Source: AMsMyM4sQJxldR5ly6sDRctFroNmCcNK3zaEKjY5LByTszxKSOiC1GiC6efWQmsos+TvhsYV62tLSQ==
X-Received: by 2002:a5d:59af:0:b0:22e:32be:60f1 with SMTP id p15-20020a5d59af000000b0022e32be60f1mr19877224wrr.81.1665650572056;
        Thu, 13 Oct 2022 01:42:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a14-20020a5d456e000000b0022ccae2fa62sm1554477wrc.22.2022.10.13.01.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 01:42:51 -0700 (PDT)
Message-Id: <1fd58520253420fbe870a8528540dbc9e2178e3f.1665650564.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1323.v3.git.1665650564.gitgitgadget@gmail.com>
References: <pull.1323.v2.git.1662561470.gitgitgadget@gmail.com>
        <pull.1323.v3.git.1665650564.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 13 Oct 2022 08:42:39 +0000
Subject: [PATCH v3 3/8] rebase: be stricter when reading state files
 containing oids
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

The state files for 'onto' and 'orig_head' should contain a full hex
oid, change the reading functions from get_oid() to get_oid_hex() to
reflect this.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/rebase.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 56e4214b441..76f83a42f49 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -431,7 +431,7 @@ static int read_basic_state(struct rebase_options *opts)
 	opts->head_name = starts_with(head_name.buf, "refs/") ?
 		xstrdup(head_name.buf) : NULL;
 	strbuf_release(&head_name);
-	if (get_oid(buf.buf, &oid))
+	if (get_oid_hex(buf.buf, &oid))
 		return error(_("could not get 'onto': '%s'"), buf.buf);
 	opts->onto = lookup_commit_or_die(&oid, buf.buf);
 
@@ -448,7 +448,7 @@ static int read_basic_state(struct rebase_options *opts)
 	} else if (!read_oneliner(&buf, state_dir_path("head", opts),
 				  READ_ONELINER_WARN_MISSING))
 		return -1;
-	if (get_oid(buf.buf, &opts->orig_head))
+	if (get_oid_hex(buf.buf, &opts->orig_head))
 		return error(_("invalid orig-head: '%s'"), buf.buf);
 
 	if (file_exists(state_dir_path("quiet", opts)))
-- 
gitgitgadget

