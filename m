Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B880420A25
	for <e@80x24.org>; Sat, 16 Sep 2017 08:07:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751253AbdIPIHt (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Sep 2017 04:07:49 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:37567 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751170AbdIPIHp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Sep 2017 04:07:45 -0400
Received: by mail-wr0-f194.google.com with SMTP id u48so2369699wrf.4
        for <git@vger.kernel.org>; Sat, 16 Sep 2017 01:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Bv0S1hAoxdtYVu5hsHeZfIOJ3VoqogBEBXglCCqOktM=;
        b=EvtDvb9uOQjQ7EKUPZN5QRjcMXYhiRJLPIBYReHdC0TX2rtDjdRvlgTt5zox5RYRVA
         sZyPIf1glnaGexcIYk5Kht7unk/UCYI3VIM0pyBqqR8TONf4DwGmRduQCFu949NTyXru
         nrculBdl1YRb3zWAHWzAg/VFtGR3hjuU4gGfL/NxYQnw+W7TSkPV2DTqi6Zqw9l6fwXA
         OXIsGoneqWOcwZelZ6++YR5TyuiO72ebu1uql4HY9o8+0MNiKk4iiDqZlefTZqSwiahW
         QZrZkx7UfEtjfgjtg45jUABnOomcetjo7iuMsjg5A9eLcGPxpJgiVi/oFSTRgUSyIxhR
         KZKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Bv0S1hAoxdtYVu5hsHeZfIOJ3VoqogBEBXglCCqOktM=;
        b=g0oFwS4dB7TUNO+b16Oow8Hst5fLSQNMJzDN+aVlrXWD3lGn/1I5WsGmkaH8c7DWDl
         1/e5IydpoUZAU44BBgQeq6DPnIEirjSChj6mFARH/9t3ndgUHx18eJparpb7U3/5B2UV
         hg8dCdmSEzahwh5jCCjKUPWWhBwuJ1tcL9TCgh1xn4wbMfu5guhp3tVl5/wa8s8Tkpvs
         8swmfiJLyECFLTQqbd8FiCsRE5FQ6hYDIg27PwARtImD6Q1xnORREUJ5MBualCBBgBwM
         bCn3b18HT8LksSLmmZjhv3Gd9oUk3lZMjOruptVk5bqyzLDHtCIeK3UkRDPOBwdNYryD
         Wmcw==
X-Gm-Message-State: AHPjjUg6+d6Rko9WrGeuuxwR/RpwC9jaagoW3wbSl9YGrfmpPcNMHpNp
        V+w7QS4UkiHVXnj0
X-Google-Smtp-Source: ADKCNb7Ex2cMR7JZVGIUgnj9R9CaL2RewmZ8rlqVFQhcDPAdoj/If/OSaqBQbSxRhFoqr60XulMsEQ==
X-Received: by 10.223.177.18 with SMTP id l18mr22676841wra.167.1505549263657;
        Sat, 16 Sep 2017 01:07:43 -0700 (PDT)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id l126sm2814641wmd.1.2017.09.16.01.07.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 16 Sep 2017 01:07:42 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v6 01/40] builtin/clone: get rid of 'value' strbuf
Date:   Sat, 16 Sep 2017 10:06:52 +0200
Message-Id: <20170916080731.13925-2-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.14.1.576.g3f707d88cd
In-Reply-To: <20170916080731.13925-1-chriscool@tuxfamily.org>
References: <20170916080731.13925-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This makes the code simpler by removing a few lines, and getting
rid of one variable.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/clone.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 8d11b570a1..dcd5b878f1 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -875,7 +875,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	const struct ref *our_head_points_at;
 	struct ref *mapped_refs;
 	const struct ref *ref;
-	struct strbuf key = STRBUF_INIT, value = STRBUF_INIT;
+	struct strbuf key = STRBUF_INIT;
 	struct strbuf branch_top = STRBUF_INIT, reflog_msg = STRBUF_INIT;
 	struct transport *transport = NULL;
 	const char *src_ref_prefix = "refs/heads/";
@@ -1040,7 +1040,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		strbuf_addf(&branch_top, "refs/remotes/%s/", option_origin);
 	}
 
-	strbuf_addf(&value, "+%s*:%s*", src_ref_prefix, branch_top.buf);
 	strbuf_addf(&key, "remote.%s.url", option_origin);
 	git_config_set(key.buf, repo);
 	strbuf_reset(&key);
@@ -1054,10 +1053,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	if (option_required_reference.nr || option_optional_reference.nr)
 		setup_reference();
 
-	fetch_pattern = value.buf;
+	fetch_pattern = xstrfmt("+%s*:%s*", src_ref_prefix, branch_top.buf);
 	refspec = parse_fetch_refspec(1, &fetch_pattern);
-
-	strbuf_reset(&value);
+	free((char *)fetch_pattern);
 
 	remote = remote_get(option_origin);
 	transport = transport_get(remote, remote->url[0]);
@@ -1196,7 +1194,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	strbuf_release(&reflog_msg);
 	strbuf_release(&branch_top);
 	strbuf_release(&key);
-	strbuf_release(&value);
 	junk_mode = JUNK_LEAVE_ALL;
 
 	free(refspec);
-- 
2.14.1.576.g3f707d88cd

