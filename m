Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8DC21F597
	for <e@80x24.org>; Tue, 31 Jul 2018 00:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732154AbeGaCJX (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 22:09:23 -0400
Received: from mail-oi0-f73.google.com ([209.85.218.73]:36809 "EHLO
        mail-oi0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732009AbeGaCJX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 22:09:23 -0400
Received: by mail-oi0-f73.google.com with SMTP id c18-v6so12422851oiy.3
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 17:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=On4Cvv9zuloEfkrYxgOOycJC7eXbp2y340qdCAx9/c8=;
        b=NrSWVL3b3GoqHL7xd4vkW3xpLHiADBr3AMq2IEdeaRBnlqobYETIp/Drutmf+5g/OT
         QCdeMvNggwfg0OLMLd45FoYyyj4MeR6sbf+ubeOpOto+VIXbVz0t26OAvX0j2iYqbBgY
         f41oe4vqJ2YHT8pRLNA6zj0yGHMZLVLw0N+OUsJAPfKTIYlJhTDSmhvxtE//ZBb6971E
         hpmKWq0zHifVKMzOV+i8vHveYfvvHb0rupJi3+GYOdWs0hqrNdJbvsS3D0alqfQUKdAy
         9KaB1Z6hHCGEVwIXgxXaTG3Yhsgnemr3TW8KM1+cd0IEMoUoXRD5dAMTJ4KA+iqsdQ/L
         xnAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=On4Cvv9zuloEfkrYxgOOycJC7eXbp2y340qdCAx9/c8=;
        b=SJxUV7AtcXGm2WISmz61HHLqttwRKJO9HKKMxem637achaoTvHeMZqpPEfVoSZ95Ma
         AwL4aCe3jmf2ukDVuXBf0im9SzU53TKMNWVZOimls9Jh65XOxYeE1Omf15HxJtT0/SSY
         bBAdOyPNK20xDG2AP5QIsieadZHEvrR2VvW+76U401mBcamZMSWJZoOP/0EZDbExeBRP
         tBLRuUTn11e4dFyiaqDKU0ndryEPmCuD09nbKQxWDysC8zMBtGMXVrPs3LouAiyL+xFu
         JPaptOQ/+N3nIXy5rPiGop7KNGP3G7rL/0/eDi67W38ALTDE0c+77QoIJec+BVJsoYsZ
         q+Ng==
X-Gm-Message-State: AOUpUlHP5pclOWW9WuoTKf5XfEZmzH3tMuA9LccmagvDn2n2x93jIKDx
        CRQZtgUtc8ZGEKUGkqnXhTzICP6ge3me
X-Google-Smtp-Source: AAOMgpcKsdqhcs+RvOeOwah4vBpjN+KGAkEiAchn7CKAeNylj1/L5lIXGfiXFDIgyl4uDtRSGUMC0EO9ijXd
MIME-Version: 1.0
X-Received: by 2002:aca:5550:: with SMTP id j77-v6mr12338813oib.75.1532997111653;
 Mon, 30 Jul 2018 17:31:51 -0700 (PDT)
Date:   Mon, 30 Jul 2018 17:31:35 -0700
In-Reply-To: <20180731003141.105192-1-sbeller@google.com>
Message-Id: <20180731003141.105192-3-sbeller@google.com>
References: <20180728030448.192177-1-sbeller@google.com> <20180731003141.105192-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.132.g195c49a2227
Subject: [PATCH 2/8] t3206: add color test for range-diff --dual-color
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        sunshine@sunshineco.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The 'expect'ed outcome has been taken by running the 'range-diff | decode'.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/t3206-range-diff.sh | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index 2237c7f4af9..019724e61a0 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -142,4 +142,43 @@ test_expect_success 'changed message' '
 	test_cmp expected actual
 '
 
+test_expect_success 'dual-coloring' '
+	cat >expect <<-\EOF &&
+	<YELLOW>1:  a4b3333 = 1:  f686024 s/5/A/<RESET>
+	<RED>2:  f51d370 <RESET><YELLOW>!<RESET><GREEN> 2:  4ab067d<RESET><YELLOW> s/4/A/<RESET>
+	    <REVERSE><CYAN>@@ -2,6 +2,8 @@<RESET>
+	     <RESET>
+	         s/4/A/<RESET>
+	     <RESET>
+	    <REVERSE><GREEN>+<RESET> <BOLD>   Also a silly comment here!<RESET>
+	    <REVERSE><GREEN>+<RESET>
+	     diff --git a/file b/file<RESET>
+	    <RED> --- a/file<RESET>
+	    <GREEN> +++ b/file<RESET>
+	<RED>3:  0559556 <RESET><YELLOW>!<RESET><GREEN> 3:  b9cb956<RESET><YELLOW> s/11/B/<RESET>
+	    <REVERSE><CYAN>@@ -10,7 +10,7 @@<RESET>
+	      9<RESET>
+	      10<RESET>
+	    <RED> -11<RESET>
+	    <REVERSE><RED>-<RESET><FAINT;GREEN>+BB<RESET>
+	    <REVERSE><GREEN>+<RESET><BOLD;GREEN>+B<RESET>
+	      12<RESET>
+	      13<RESET>
+	      14<RESET>
+	<RED>4:  d966c5c <RESET><YELLOW>!<RESET><GREEN> 4:  8add5f1<RESET><YELLOW> s/12/B/<RESET>
+	    <REVERSE><CYAN>@@ -8,7 +8,7 @@<RESET>
+	    <CYAN> @@<RESET>
+	      9<RESET>
+	      10<RESET>
+	    <REVERSE><RED>-<RESET><FAINT> BB<RESET>
+	    <REVERSE><GREEN>+<RESET> <BOLD>B<RESET>
+	    <RED> -12<RESET>
+	    <GREEN> +B<RESET>
+	      13<RESET>
+	EOF
+	git range-diff changed...changed-message --color --dual-color >actual.raw &&
+	test_decode_color >actual <actual.raw &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.18.0.132.g195c49a2227

