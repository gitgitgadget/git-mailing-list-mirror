Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FB151F4B5
	for <e@80x24.org>; Tue, 19 Nov 2019 01:07:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbfKSBHC (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Nov 2019 20:07:02 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:41439 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbfKSBHB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Nov 2019 20:07:01 -0500
Received: by mail-pj1-f68.google.com with SMTP id gc1so2027980pjb.8
        for <git@vger.kernel.org>; Mon, 18 Nov 2019 17:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=e4tpXidDTSJN0v5SgHDSA5yZYXlsvO5ZviNyhRRUwHY=;
        b=vTLljaCbSaS6bM282W6PXZY7WGvtb9YQaLxhHm+7sl3/OBB+ac/z2daH7X2RpgCTzF
         4ZheFUwrRNLCg6ljy56E8OZwXsRJ2AmBrUlBboN7MJI+Le36/0jyiU9oftFyGXVRTyWb
         5z7hOy2WltBmLYvyYK0TmvaYcSoqQQ9WwIafNpIuYWXNOoFCOX5RhZyN6OE+DygaX/kS
         5j5dXer3pk7SrSQ0Siy5XtFa1K2f0StBQIJxoKZueUb0oMPmNgY9gY8PFKbZEisaXSZU
         Dz7sNTuA+WTB6BM7RUC8h+RI2yimUfxvRNE10+TNFyvid00QdvbApMHpXINOI6+2SVVS
         OqQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e4tpXidDTSJN0v5SgHDSA5yZYXlsvO5ZviNyhRRUwHY=;
        b=WXwcfKTbVbjZnEsdv4lXQZuW6QLd6s5wx9v6JKDs746WdaB7VwiWOjU+BaZ4WPP5+l
         pybGXrlimm1iIUs0ehgDFn3OK2+rZYAvKiYLb+dYsHw5EjxzASOf3DdquL1E4R3RFxmi
         uuBny3DqRVdiCOjM0WLFK1up7PJ/HKJcUH1xJAEcYAeS4zGTKLucuDbrtCeP3hNwMrSy
         j3/4JD+dH7Ru1xmPSm54Q8/pgv6a305xGzQe5fSvVFoH9m2WBoWnwXOyr7hPZXNIinGT
         EA9NI8Nl3QBLrOndnKoq8aRWduo8xfef1jZRg0qsxXDPowlAvWm1+38Ml1kWVic03v1w
         Aihg==
X-Gm-Message-State: APjAAAXrn4cq41qvQp4AWOEfu0FbmKxg35I/krOXsVwu3LnaH9hwE727
        CLGWkIkEp6ZFcNb+AHV6YXcvZk7U
X-Google-Smtp-Source: APXvYqwpoWQYE/cdNFoxaOMi2FQivMLYKs/WUcDQ7nJhHpJlZPWzDkhTmBE+Q7akLQxYtCaehNTocA==
X-Received: by 2002:a17:902:9043:: with SMTP id w3mr11499194plz.30.1574125619428;
        Mon, 18 Nov 2019 17:06:59 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id 8sm15073911pfc.42.2019.11.18.17.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 17:06:58 -0800 (PST)
Date:   Mon, 18 Nov 2019 17:06:57 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 2/3] t3206: demonstrate failure with notes
Message-ID: <00d6b47db0a68d0bc91b252675a2165985426f5e.1574125554.git.liu.denton@gmail.com>
References: <cover.1574125554.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574125554.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a commit being range-diff'd has a note attached to it, the note
will be compared as well. However, this shouldn't happen since the
purpose of range-diff is to compare the difference between two
commit-ranges and, since the note attached to a commit is mutable, they
shouldn't be included as part of the comparison.

Demonstrate this failure in t3206.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t3206-range-diff.sh | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index 87c6c029db..29b9a6f854 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -505,4 +505,19 @@ test_expect_success 'range-diff overrides diff.noprefix internally' '
 	git -c diff.noprefix=true range-diff HEAD^...
 '
 
+test_expect_failure 'range-diff does not compare notes' '
+	git notes add -m "topic note" topic &&
+	git notes add -m "unmodified note" unmodified &&
+	test_when_finished git notes remove topic unmodified &&
+	git range-diff --no-color master..topic master..unmodified \
+		>actual &&
+	cat >expected <<-EOF &&
+	1:  $(test_oid t1) = 1:  $(test_oid u1) s/5/A/
+	2:  $(test_oid t2) = 2:  $(test_oid u2) s/4/A/
+	3:  $(test_oid t3) = 3:  $(test_oid u3) s/11/B/
+	4:  $(test_oid t4) = 4:  $(test_oid u4) s/12/B/
+	EOF
+	test_cmp expected actual
+'
+
 test_done
-- 
2.24.0.420.g9ac4901264

