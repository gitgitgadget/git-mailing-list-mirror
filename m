Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E5BF1F404
	for <e@80x24.org>; Fri,  9 Feb 2018 20:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752805AbeBIUcx (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 15:32:53 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38320 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752784AbeBIUcw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 15:32:52 -0500
Received: by mail-wm0-f66.google.com with SMTP id 141so18408696wme.3
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 12:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=xWX+qnq4vDLiMtUKHAJuyIW9bWmnPaqNhf+1BKCOUm0=;
        b=P0S6vxzqmrou0nHEM0z3EkNEGNkjQ/xuayx5vyS62vAM+J/jOyMeUUPnxoW5Jboszy
         pbHA46VG6XESbvPpLRqUA4sIS+20X3Fc5IShUdGD3vgLUDzvMn20EiSfbCY7zwv9VBvf
         C2BXTyuOVLeb8/jeGeTTrAgCtw7y8i6sbY60udOHBwbzpGthTAkq69FqBfvbsOeAgT9b
         aqr2HHkR5Q4P5L4jwNSi9Zh3QAhq89ceM/jiguP5AdwBVQPAXWAxH0H3QrbUEhkSq3C1
         KRFQsmfCOtagiM9XO9JOjrZGaXKS1GbC5VtOVvz1drMrEDAReBUcUtmU1mSYWMJkoWEr
         QLFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=xWX+qnq4vDLiMtUKHAJuyIW9bWmnPaqNhf+1BKCOUm0=;
        b=c03S8CnbepBvmt3XuibrWFDvFkamm6wXwXsEm0BUaeYCQVhP+qWca1W+tQKbSAnIiK
         MuCYe0mM0hQ3aRmneUqioWv+Jp+Ji0XLZAf74E2koI29YwZ1KN92t5GghEjmLqfefLeA
         0MU8VSwZi+jL2oCUyMWNLloSWE5+D53sJXVCW0N0+6iK56nFOGbkreuv/S7PAap984GE
         LPAw8yP9U25HAw5gMWYFc+v4lpQ9oW5BxUTWwikCie5iTM7HNDqy/uEfqIEqi5I4UTS6
         WL+xTGZvBjdRApzR4mDvjSzUg+dJU/B/QabcDhsTNNCBITc+lmkSEbyL7+9NvLs5ASQD
         0pZg==
X-Gm-Message-State: APf1xPDdfMm8uE9TsAk+2pqeM7IQFUUcd10cLF/fK9EtI3zACYvB4tIM
        6sMzjh5M778E6sHq0BZ6DBj9ag0L
X-Google-Smtp-Source: AH8x225lCGjIePkjRinQDy21ZD2tP1rSlmqyb2ffy924187fqJUTnyhJ+qvstpPrMtfPG+4FDGdwHg==
X-Received: by 10.28.53.130 with SMTP id c124mr2723341wma.110.1518208370711;
        Fri, 09 Feb 2018 12:32:50 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id y90sm5750233wrc.24.2018.02.09.12.32.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Feb 2018 12:32:49 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Giuffrida <michaelpg@chromium.org>,
        Michael Schubert <mschub@elegosoft.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Daniel Barkalow <barkalow@iabervon.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 09/17] fetch tests: double quote a variable for interpolation
Date:   Fri,  9 Feb 2018 20:32:08 +0000
Message-Id: <20180209203216.11560-10-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180209203216.11560-1-avarab@gmail.com>
References: <20180209203216.11560-1-avarab@gmail.com>
In-Reply-To: <20180121000304.32323-1-avarab@gmail.com>
References: <20180121000304.32323-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If the $cmdline variable contains arguments with spaces they won't be
interpolated correctly, since the body of the test is single quoted,
and because test-lib.sh does its own eval().

This will be used in a subsequent commit to pass arguments that need
to be quoted to git-fetch, i.e. a file:// path to fetch, which will
have a space in it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5510-fetch.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index dacdb8759c..88d38e0819 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -578,7 +578,7 @@ test_configured_prune () {
 			set_config_tristate fetch.prune $fetch_prune &&
 			set_config_tristate remote.origin.prune $remote_origin_prune &&
 
-			git fetch $cmdline &&
+			git fetch '"$cmdline"' &&
 			case "$expected_branch" in
 			pruned)
 				test_must_fail git rev-parse --verify refs/remotes/origin/newbranch
-- 
2.15.1.424.g9478a66081

