Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA5812018A
	for <e@80x24.org>; Fri,  1 Jul 2016 16:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752065AbcGAQDu (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 12:03:50 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:36371 "EHLO
	mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751533AbcGAQDt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 12:03:49 -0400
Received: by mail-lf0-f66.google.com with SMTP id a2so11741184lfe.3
        for <git@vger.kernel.org>; Fri, 01 Jul 2016 09:03:48 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ROAIXIxGJygCl97Ohnl4F9zSHO0GPRjO5/fZm3BEm+g=;
        b=0WDfNGub640lpdVW060zLGKaFVf+PD6jMwao504XUrUJ4dA4S66XX1oX58tFNjuNA6
         OtQKKeP28/QXruCoPhoThZvFXlCdmFp3aq17HgpptGmQ4WHvK7kOQzCVg+c6QZFkCYYL
         W4Zl/fBwp4yImFvCWFTHB1JysUp2lAkZDE5O9gzVTFDsrEbgc3X/Sx8JfZBIr6sX5XzL
         ATq738rCw8rME+oecxs0OhPz0QknU0NGrv0EaN/iQkhZ6zirCwjqEgdghAFJmxGlPEw8
         cUoQFkCn01ZbHXSH9AkJHtWLGBBIV8JtlNDopQ6x/OWIye72KH9W+up3sppdZeIipg1P
         J2uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ROAIXIxGJygCl97Ohnl4F9zSHO0GPRjO5/fZm3BEm+g=;
        b=NpGzUggKXADNwmZeRy1+ub6oVP4m9Mo2GR1bSD4Hk+yZJLjYA6rAagBCzuk+6UYnzd
         c8Z/1RMRa0kdmTgRngy9eDgcAyW8+lTBSTuBhnlijFx/U72Nn5vaGYVJupe72rKubMhc
         AEj6EyvDYcviHrNm8AM0ANL5o7hPOO/E77u8YBCYSG35ANmyamRLsldgmWSEUyE5c65R
         bOj0XO/gRIIVmFR5oB6QeJjKn52U5S9N1lp1PxbPHpMKqrHuQO1sLKCwg0i5Zf0PaRr5
         FTxmrvoAkcM8x6Eedj3rOdigosq0ZvCILHZ6aAS/T95A4K2MFM45uIuwbNQOHmetM5JF
         UNcQ==
X-Gm-Message-State: ALyK8tIROlzTCLWsljbNxFMmQtiLG2fO76tE3iFmOEQFB2u6JUHQeFtyLdfIddwhyzDgwg==
X-Received: by 10.25.27.203 with SMTP id b194mr5699557lfb.172.1467389027623;
        Fri, 01 Jul 2016 09:03:47 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id k18sm884102lfg.47.2016.07.01.09.03.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 01 Jul 2016 09:03:46 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, marcnarc@xiplink.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v5 1/5] git-fetch.txt: document fetch output
Date:	Fri,  1 Jul 2016 18:03:27 +0200
Message-Id: <20160701160331.29252-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.531.gd073806
In-Reply-To: <20160701160331.29252-1-pclouds@gmail.com>
References: <20160626055810.26960-1-pclouds@gmail.com>
 <20160701160331.29252-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This documents the ref update status of fetch. The structure of this
output is defined in [1]. The ouput content is refined a bit in [2]
[3] [4].

This patch is a copy from git-push.txt, modified a bit because the
flag '-' means different things in push (delete) and fetch (tag
update).

PS. For code archaeologists, the discussion mentioned in [1] is
probably [5].

[1] 165f390 (git-fetch: more terse fetch output - 2007-11-03)
[2] 6315472 (fetch: report local storage errors ... - 2008-06-26)
[3] f360d84 (builtin-fetch: add --prune option - 2009-11-10)
[4] 0997ada (fetch: describe new refs based on where... - 2012-04-16)
[5] http://thread.gmane.org/gmane.comp.version-control.git/61657

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/git-fetch.txt | 46 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
index efe56e0..cbf441f 100644
--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.txt
@@ -99,6 +99,52 @@ The latter use of the `remote.<repository>.fetch` values can be
 overridden by giving the `--refmap=<refspec>` parameter(s) on the
 command line.
 
+OUTPUT
+------
+
+The output of "git fetch" depends on the transport method used; this
+section describes the output when fetching over the Git protocol
+(either locally or via ssh) and Smart HTTP protocol.
+
+The status of the fetch is output in tabular form, with each line
+representing the status of a single ref. Each line is of the form:
+
+-------------------------------
+ <flag> <summary> <from> -> <to> [<reason>]
+-------------------------------
+
+The status of up-to-date refs is shown only if the --verbose option is
+used.
+
+flag::
+	A single character indicating the status of the ref:
+(space);; for a successfully fetched fast-forward;
+`+`;; for a successful forced update;
+`x`;; for a successfully pruned ref;
+`-`;; for a successful tag update;
+`*`;; for a successfully fetched new ref;
+`!`;; for a ref that was rejected or failed to update; and
+`=`;; for a ref that was up to date and did not need fetching.
+
+summary::
+	For a successfully fetched ref, the summary shows the old and new
+	values of the ref in a form suitable for using as an argument to
+	`git log` (this is `<old>..<new>` in most cases, and
+	`<old>...<new>` for forced non-fast-forward updates).
+
+from::
+	The name of the remote ref being fetched from, minus its
+	`refs/<type>/` prefix. In the case of deletion, the name of
+	the remote ref is "(none)".
+
+to::
+	The name of the local ref being updated, minus its
+	`refs/<type>/` prefix.
+
+reason::
+	A human-readable explanation. In the case of successfully fetched
+	refs, no explanation is needed. For a failed ref, the reason for
+	failure is described.
 
 EXAMPLES
 --------
-- 
2.8.2.531.gd073806

