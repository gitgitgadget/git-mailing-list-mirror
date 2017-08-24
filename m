Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 086A520285
	for <e@80x24.org>; Thu, 24 Aug 2017 22:54:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754048AbdHXWyI (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Aug 2017 18:54:08 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:35176 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753411AbdHXWyG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2017 18:54:06 -0400
Received: by mail-pg0-f41.google.com with SMTP id 63so4751498pgc.2
        for <git@vger.kernel.org>; Thu, 24 Aug 2017 15:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BzzsVb2IZ5D7lNzzLJC+ZOsqwHHzDkO6451qhOJ2sRA=;
        b=jaK3isC2HERWQ/eA1XqvYEcRrDgUCfdgW3+g9yIgAqzWAGcfVVhHcT+4MH9d7Y5OT4
         me7EIGDVjnJGHVdsvmQt48AZqVOLE9nYaWwF5qzRyUzf/reryYAu5G1ehBGnKgggpLTj
         xPv++V8+g50lRUEBgk8/f2D0R0Jwnyja5wIwC3BNIHQdj+kJ03BGBryaSIFzjkJpHzh0
         ylCiv6MXS9VRSslzOKOoLk0NCefOgw8umPb3VICLyGE5z2+AsCmO8llbKvegY26W+fgW
         3i7EkHdvVD8WrcqxMAgb9A5dWGOnXhoE1ESo9ysfW2yxwxiTOsp/9tbWRKAbBdN0P7EC
         kKWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BzzsVb2IZ5D7lNzzLJC+ZOsqwHHzDkO6451qhOJ2sRA=;
        b=jMU+B2dEXpBezGsi3ZMznUU2XuT5nRZCmg55WEDmxfYsJVzsotSVJiCdzpsit8RrQu
         KGCw9b/nO1R9PzpqY1od6XIj3c37TsEGFqsjgvo3prLx3EfmG0KzjeAA9hISWvmPUhok
         XRDhks/VkcXohU+0qbHixsIKnl8obRidJBWvZLhlw6JENar8Xqf0IFqyIJQ7KsrKAZaP
         BI3+AUDCKq5fwhooromuXf/78eLUhzTy/J+T66H0y+MfvMVcQsMv1V9+pRKI/z2LXyoH
         WIGE7ejRg52oGKDKvAGxKwsb3kYO1oOQt3cGdeqSjE4Egn6LR7fUwJY2kciKc3LkVEhR
         1f4w==
X-Gm-Message-State: AHYfb5i1fST7ZxtUmYxTPYFzgT/Id+vrSSvsdWbWLiAKzRaebbH0KplZ
        6jPBVjRL1Lz8rj7O1Jt6VQ==
X-Google-Smtp-Source: ADKCNb7IUC1ga8erhL9vKSp46Gq/2t+OmOiTuopXKQ1nxk1h8ezzufhDFl6kIeguUMyRKX113vm8gA==
X-Received: by 10.98.90.131 with SMTP id o125mr7859900pfb.222.1503615244937;
        Thu, 24 Aug 2017 15:54:04 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id x8sm9402667pfi.174.2017.08.24.15.54.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 24 Aug 2017 15:54:03 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@gmail.com, sbeller@google.com,
        gitster@pobox.com, jonathantanmy@google.com,
        Brandon Williams <bmwill@google.com>
Subject: [RFC 7/7] upload-pack: ack version 2
Date:   Thu, 24 Aug 2017 15:53:28 -0700
Message-Id: <20170824225328.8174-8-bmwill@google.com>
X-Mailer: git-send-email 2.14.1.342.g6490525c54-goog
In-Reply-To: <20170824225328.8174-1-bmwill@google.com>
References: <20170824225328.8174-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 upload-pack.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/upload-pack.c b/upload-pack.c
index 7efff2fbf..0f853152f 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1032,9 +1032,15 @@ static int upload_pack_config(const char *var, const char *value, void *unused)
 	return parse_hide_refs_config(var, value, "uploadpack");
 }
 
+void upload_pack_v2(void)
+{
+	packet_write_fmt(1, "%s\n", "version 2");
+}
+
 int cmd_main(int argc, const char **argv)
 {
 	const char *dir;
+	const char *version;
 	int strict = 0;
 	struct option options[] = {
 		OPT_BOOL(0, "stateless-rpc", &stateless_rpc,
@@ -1067,6 +1073,11 @@ int cmd_main(int argc, const char **argv)
 		die("'%s' does not appear to be a git repository", dir);
 
 	git_config(upload_pack_config, NULL);
+
+	version = getenv("GIT_PROTOCOL");
+	if (!strcmp(version, "2"))
+		upload_pack_v2();
+
 	upload_pack();
 	return 0;
 }
-- 
2.14.1.342.g6490525c54-goog

