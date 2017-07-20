Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 989401F600
	for <e@80x24.org>; Thu, 20 Jul 2017 14:19:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965635AbdGTOTq (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jul 2017 10:19:46 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37544 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755495AbdGTOTo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2017 10:19:44 -0400
Received: by mail-wm0-f65.google.com with SMTP id m4so3725088wmi.4
        for <git@vger.kernel.org>; Thu, 20 Jul 2017 07:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=qudG91cyud1+vlHO4bQWykRW2dMo8XWqzZ2U6GVC0MQ=;
        b=q4i1sts+3//zvE96BWLygGZrjsvzf/7srJ1fS8cJxI7L7UIzlQwbIpnptO/yfK8iOi
         820KHzhkuN5kfcemO27zNtD6ngN/UdhvNtGZK49EzorPcbX18Jw3VJNcG5OJ9Gy/VYgu
         rIjm7c87Zy6+RlyYn0CXlelkNDyURBBMcakpWW1wMWzrNAlsfxkTMaJm8jG8zuL78Qky
         9XFdH8OCvaS4sbcb231Y0DfvKppQaS1X8UNt4qWkHxH2ulBbNZLPW5gUzRNcw+rrM5F2
         oJGwTLF+jhpihdCOja2PKk08af/v9swdvvRjzSrCuSjL9mXGR2Tk0JMeoJW/Z9JLt6Bp
         EOsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=qudG91cyud1+vlHO4bQWykRW2dMo8XWqzZ2U6GVC0MQ=;
        b=aI9U5ZJESHaN9s+HhxsDDOkKZbF7YVJqnfWdi2lTXmb6xRCI+piYuIuF4rAotzaCLy
         mffkADMHV9oZS87/9Fld70nDSCDwi9eiNB5o4/JoAikTfaw+iqLBSK8hQqw/D6dSQQvA
         roRSqkZFEFSCkS06Anc8vAj+CjHmf0w8zV9c0bIjavqYckb3D4MqwpRvy0ne0yOSugCZ
         ywBomjWAUGG3O+6wqRl3+c1xPw1f5fjdkyt6mVIvwf51u8dxRstRy3sezsCPKmhYlRK1
         2MEdAqaJzZGYaH/I7TIXTB2n5Gxkc1nsRl+TU4hE6t62UAyCrZikcAcK6R1WYF3OAA6T
         GA4A==
X-Gm-Message-State: AIVw112O4qahwTPJ7xPllNWn83q0PG55CU9/lhFe4ZTH7/kHpLlBzUUp
        i9fstlyDv1g9wnYAPu4=
X-Received: by 10.80.135.208 with SMTP id 16mr3085946edz.121.1500560382750;
        Thu, 20 Jul 2017 07:19:42 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id l24sm1630566eda.11.2017.07.20.07.19.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jul 2017 07:19:42 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/6] RelNotes: mention "log: make --regexp-ignore-case work with --perl-regexp"
Date:   Thu, 20 Jul 2017 14:19:23 +0000
Message-Id: <20170720141927.18274-3-avarab@gmail.com>
X-Mailer: git-send-email 2.13.2.932.g7449e964c
In-Reply-To: <20170720141927.18274-1-avarab@gmail.com>
References: <20170720141927.18274-1-avarab@gmail.com>
In-Reply-To: <xmqq7ez6hk2y.fsf@gitster.mtv.corp.google.com>
References: <xmqq7ez6hk2y.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To inform users that they can use --regexp-ignore-case now, and that
existing scripts which relied on that + PCRE may be buggy. See
9e3cbc59d5 ("log: make --regexp-ignore-case work with --perl-regexp",
2017-05-20).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/RelNotes/2.14.0.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/RelNotes/2.14.0.txt b/Documentation/RelNotes/2.14.0.txt
index 9a4c2bb649..c125f8fd68 100644
--- a/Documentation/RelNotes/2.14.0.txt
+++ b/Documentation/RelNotes/2.14.0.txt
@@ -120,6 +120,9 @@ UI, Workflows & Features
  * "git log" learned -P as a synonym for --perl-regexp, "git grep"
    already had such a synonym.
 
+ * "git log" didn't understand --regexp-ignore-case when combined with
+   --perl-regexp. This has been fixed.
+
 Performance, Internal Implementation, Development Support etc.
 
  * The default packed-git limit value has been raised on larger
-- 
2.13.2.932.g7449e964c

