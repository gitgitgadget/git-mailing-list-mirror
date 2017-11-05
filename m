Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFE3720450
	for <e@80x24.org>; Sun,  5 Nov 2017 11:58:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751409AbdKEL6j (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Nov 2017 06:58:39 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:55557 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751184AbdKEL6i (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Nov 2017 06:58:38 -0500
Received: by mail-wr0-f193.google.com with SMTP id l8so6082119wre.12
        for <git@vger.kernel.org>; Sun, 05 Nov 2017 03:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Cu8Alcr1ppba5cFOC7fdLzfPT6FVoKj6pMc9qgnYe94=;
        b=g+kIzQYVuTVDgwNutuXYhc7Dzblp5aVTivV09ddZJhsOFpNnJhD0LjUsyRFMpjMZc7
         toDdv6XYfdcJ0Zi2iBTR0vJbPwiEquEbpbD0C+2c8ov0CHsni2W3xPriadEdzrM2XZVo
         lKmHIkZkXjdIdIAEH2tS39LQtMeG+lVnR9xk0tnzcvPYlHtiUZJecfYuqVW3SoluNCMv
         A6RMuH3+HhdL4xR3y89GADZWPbSanjOnG9T/46qAJzBhVP2rMrY5p7raIfNmM6tIeLox
         IsUDIJJ7ZBjNFCo0OfQ7VALWsw9lnraaR1GqxrBal/laVB2Ex092Yj8CYUZ9ecM10/tF
         TJfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Cu8Alcr1ppba5cFOC7fdLzfPT6FVoKj6pMc9qgnYe94=;
        b=eWj77GUPRipPjyhp/YRpG9fskCbnumnZ872h40Vb07ycclNfH1mgj1ekc5p6sbNh4Z
         04Feu/Nc1QRPYiz/9fqYamRUFur9saN7NruOmvcD0s9AYy2dW8QFWIFiOaTbgdikD0rq
         qy+AGNyskG9QdVahVM6DFgCWN0JPQELnfegmTQGtmHcB2uXiTCpeUJUV35MmEb48GK9b
         yYyL39J58K8bLLnMEDV2SYN1YOJBaz2kPzyovaXFtdxgRFHD3q+fv3sQ7q3cAh3Ybc/S
         0bW7tO1aOMezZrz8dJkG9DcqSwZpn0cNY2i/aCdyX/dTw3pizG9WCbk69z1bbgjTaBaB
         qApg==
X-Gm-Message-State: AMCzsaUJ9eCMN2k8N2vVLA5PCfe9XmTesO+sJH3zFK7RF20RDXKikfNh
        HJkrYn0sV95CnLe221Sqw/U=
X-Google-Smtp-Source: ABhQp+Tx4WZm1nv+vLbx8ZqXCBywi3QNzHtrYJhxADj6bseFnB438FJzl3G7JuAmqsnKatOlB6WZPQ==
X-Received: by 10.223.160.86 with SMTP id l22mr9871001wrl.187.1509883117030;
        Sun, 05 Nov 2017 03:58:37 -0800 (PST)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id u18sm14391450wrg.94.2017.11.05.03.58.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 05 Nov 2017 03:58:36 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, hkleynhans@bloomberg.net,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 1/4] t7006: document that `pager.foo` can be partially preserved
Date:   Sun,  5 Nov 2017 12:58:19 +0100
Message-Id: <a785966f0ffa966661e4022c077f81c46db3bb98.1509879269.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.15.0.415.gac1375d7e
In-Reply-To: <cover.1509879269.git.martin.agren@gmail.com>
References: <20171104092850.5fthdgvnihd3y4fm@sigill.intra.peff.net> <cover.1509879269.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Assuming a blank slate, consider the following configuration:

[pager]
	foo = some-command
	foo = false

Now `git -c pager.foo=true foo` will page using `some-command`. This
might have been intended, or is perhaps just a side-effect of the
implementation. In any case, it could be useful and someone might rely
on it, either knowingly (as above) or not (if these lines are spread out
across the configuration).

However, `git --paginate foo` will *not* use `some-command`. That
matches the documentation (Documentation/git.txt).

Upcoming commits will expand on how paging for `git foo` can be
configured. Those commits mustn't change how `pager.foo` behaves, so add
tests for these two cases.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 t/t7006-pager.sh | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index f0f1abd1c..e890b2f64 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -117,6 +117,24 @@ test_expect_success TTY 'git config uses a pager if configured to' '
 	test -e paginated.out
 '
 
+test_expect_success TTY 'configuration remembers pager across boolean changes' '
+	echo paging >expected &&
+	test_unconfig pager.config &&
+	test_terminal git -c pager.config="echo paging" \
+			  -c pager.config=false \
+			  -c pager.config \
+			  config --list >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success TTY '--paginate does not respect inactivated pager' '
+	rm -f paginated.out &&
+	test_terminal git -c pager.config=bad \
+			  -c pager.config=false \
+			  --paginate config --list &&
+	test -e paginated.out
+'
+
 test_expect_success TTY 'configuration can enable pager (from subdir)' '
 	rm -f paginated.out &&
 	mkdir -p subdir &&
-- 
2.15.0.415.gac1375d7e

