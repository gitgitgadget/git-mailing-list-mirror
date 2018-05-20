Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11DAA1F51C
	for <e@80x24.org>; Sun, 20 May 2018 21:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751688AbeETVMQ (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 May 2018 17:12:16 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:38232 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751408AbeETVMO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 May 2018 17:12:14 -0400
Received: by mail-wr0-f194.google.com with SMTP id 94-v6so14080610wrf.5
        for <git@vger.kernel.org>; Sun, 20 May 2018 14:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Yvei23vPH4GvUhAk+nVmIJkPJpg3uTgIVnCV9QVFjpw=;
        b=kkd6e3kzKrOQdUFA6WPMJZYkCvOAuYPno2NiQ3bncwG66eO29gss/ONeZdJr9yQnVO
         UOXNOk1LQu5t1uiB3B7M0UykvTl4nRDxOtAaUKiRZOgoFJBR5/Uuv5Y00ZcyV6yorKj3
         wReJT50ojf/E7OclZhXCeVJFrjydhWwM7UAemR72hHoS+LYSSe96jPaAO64yaKuip+qk
         bssON2IfNf1/ufWGDXO0q1+MDEacdtzZiPdsn1Kfxr/gGHT+s3M0d1fp59m4py/bxDLN
         9i0Y6zpBGChNp3WzWl/d0tIGYffY8RJicMfXTIQySBso5jE6ADl8RPlgc//SGGXBp07H
         cS/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Yvei23vPH4GvUhAk+nVmIJkPJpg3uTgIVnCV9QVFjpw=;
        b=oCTGexDzfMwqWC3orJ5f+aWiqzyQ5dKpVx3l5TCvDwQkT3JsmTi8fHjqzAT3XuHRK6
         po4/FbuOsz7QbJwNnezlsXY/7TEigqBHAHfZ1YAizmp7YYPlN2V4Cu2RFGtPREYd8wnO
         8uv+6SV8OOP5e+i/z3zwhjYe/cJ5unU4GyxCYV9uWEXVGDZfrpIa0ObcDt2mj/0+m8+v
         KyQQSPaMxPzRCIditupGTAg7AqCHTtiqfqC2zyLjbtvsXykMLHUke/CfIlAmadcOfsZM
         c5Ze3FYyM5bJZXnP7ee+5LOTmGr9djfNmtLmLRFpzUHV6SVu7qmiovchslIERx5N1qu9
         r6Ag==
X-Gm-Message-State: ALKqPweViJB1SGYVEBg7zSU5sAhoBqYCTTqWNwEmjylOgOfIfuYBmmFN
        ZffEF+iRV05LQOXagEnKKgsyEzay
X-Google-Smtp-Source: AB8JxZp2jBoenQJrsn2/Ljd106mA+CzS9pgzWHo1lxXPaATk2W3GpN0KUckLJrtt6q1zVfXZQEmh7w==
X-Received: by 2002:adf:84e2:: with SMTP id 89-v6mr2182197wrg.167.1526850732425;
        Sun, 20 May 2018 14:12:12 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id w5-v6sm11705830wmd.26.2018.05.20.14.12.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 20 May 2018 14:12:11 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [RFC/PATCH 3/7] rerere: add some documentation
Date:   Sun, 20 May 2018 22:12:06 +0100
Message-Id: <20180520211210.1248-4-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.17.0.588.g4d217cdf8e.dirty
In-Reply-To: <20180520211210.1248-1-t.gummerer@gmail.com>
References: <20180520211210.1248-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add some documentation for the logic behind the conflict normalization
in rerere.  Also describe a bug that happens because we just linearly
scan for conflict markers.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---

This documents my understanding of the rerere conflict normalization
and conflict ID computation logic.  Writing this down helped me
understand the logic, and I thought it may be useful to have this as
documentation in Documentation/technical as well.  Junio: as you wrote
the original NEEDSWORK comment, did you have something more in mind
here that should be documented?

 Documentation/technical/rerere.txt | 43 ++++++++++++++++++++++++++++++
 rerere.c                           |  4 ---
 2 files changed, 43 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/technical/rerere.txt

diff --git a/Documentation/technical/rerere.txt b/Documentation/technical/rerere.txt
new file mode 100644
index 0000000000..94cc6a7ef0
--- /dev/null
+++ b/Documentation/technical/rerere.txt
@@ -0,0 +1,43 @@
+Rerere
+======
+
+This document describes the rerere logic.
+
+Conflict normalization
+----------------------
+
+To try and re-do a conflict resolution, even when different merge
+strategies are used, 'rerere' computes a conflict ID for each
+conflict in the file.
+
+This is done by discarding the common ancestor version in the
+diff3-style, and re-ordering the two sides of the conflict, in
+alphabetic order.
+
+Using this technique a conflict that looks as follows when for example
+'master' was merged into a topic branch:
+
+    <<<<<<< HEAD
+    foo
+    =======
+    bar
+    >>>>>>> master
+
+and the opposite way when the topic branch is merged into 'master':
+
+    <<<<<<< HEAD
+    bar
+    =======
+    foo
+    >>>>>>> topic
+
+can be recognized as the same conflict, and can automatically be
+re-resolved by 'rerere', as the SHA-1 sum of the two conflicts would
+be calculated from 'bar<NUL>foo<NUL>' in both cases.
+
+If there are multiple conflicts in one file, they are all appended to
+one another, both in the 'preimage' file as well as in the conflict
+ID.
+
+This is currently implemented by simply scanning through the file and
+looking for conflict markers.
diff --git a/rerere.c b/rerere.c
index af5e6179a9..a02a38e072 100644
--- a/rerere.c
+++ b/rerere.c
@@ -394,10 +394,6 @@ static int is_cmarker(char *buf, int marker_char, int marker_size)
  * and NUL concatenated together.
  *
  * Return the number of conflict hunks found.
- *
- * NEEDSWORK: the logic and theory of operation behind this conflict
- * normalization may deserve to be documented somewhere, perhaps in
- * Documentation/technical/rerere.txt.
  */
 static int handle_path(unsigned char *sha1, struct rerere_io *io, int marker_size)
 {
-- 
2.17.0.588.g4d217cdf8e.dirty

