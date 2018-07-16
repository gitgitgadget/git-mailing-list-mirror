Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E15BA1F597
	for <e@80x24.org>; Mon, 16 Jul 2018 01:28:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbeGPBxc (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Jul 2018 21:53:32 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:59050 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727661AbeGPBxc (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 15 Jul 2018 21:53:32 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:78f3:848c:e199:5398])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 7FBF660779;
        Mon, 16 Jul 2018 01:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1531704515;
        bh=Ap+QAgdEkJmXFt0TtB6P1WeQ+zavQ2lVgwmsqY/u/Cc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=zEGD65Uo25yojqBPPOz4ghp1bBiYOuUi/Ey+kaAtBr9OonRS/nN5pF7bMAsMob9zL
         6rqtslgwQLgqGJMWVYn/9tMSyaw0FQ/vrnlhBxpmLmqoEvtQY121h/3QuPeheQxXTk
         NeDy3CFlTuPWJV+P8bl/0wTBnOgrCKMKhB2wjPMXSg6xqPAnssGV9b41LOntVVksKK
         SvVooLt8MlQQQOq3kfZfLPy/iLB0dNILKWDWHvN17kYyiFcrBQFx+DSr+a7UkArWN6
         k8bozuSLCnjUhA6XMktHdXpKJCx2lYcyaYfpXSBNBr5td1zoJiMnEBZIUofotQXSa9
         zE1bp059LiDFK1XurrbYVqmYPPXOxUjRmOcJr+qrs+QuCeHcSJ71EV/SmdzEoFbZdS
         qS5TXOZNU/+zfomuFF+meC4G7c6ge4iE6E5sfZw9ZaPkjzZO8Ux51GbX2dzQStN8dt
         mz5JotpBw+CqisfBsTdxuUnFaOxSi/4k500GSqNKiohHWItX37H
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v2 14/16] log-tree: switch GIT_SHA1_HEXSZ to the_hash_algo->hexsz
Date:   Mon, 16 Jul 2018 01:28:06 +0000
Message-Id: <20180716012808.961328-15-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1
In-Reply-To: <20180716012808.961328-1-sandals@crustytoothpaste.net>
References: <20180716012808.961328-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 log-tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/log-tree.c b/log-tree.c
index d3a43e29cd..9655de8ad7 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -545,7 +545,7 @@ void show_log(struct rev_info *opt)
 	struct strbuf msgbuf = STRBUF_INIT;
 	struct log_info *log = opt->loginfo;
 	struct commit *commit = log->commit, *parent = log->parent;
-	int abbrev_commit = opt->abbrev_commit ? opt->abbrev : GIT_SHA1_HEXSZ;
+	int abbrev_commit = opt->abbrev_commit ? opt->abbrev : the_hash_algo->hexsz;
 	const char *extra_headers = opt->extra_headers;
 	struct pretty_print_context ctx = {0};
 
