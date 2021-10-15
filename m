Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63632C433F5
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 12:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AA3F61056
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 12:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238805AbhJOM1u (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 08:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238802AbhJOM1u (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 08:27:50 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E261CC061570
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 05:25:43 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id j190so1705441pgd.0
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 05:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BiLYSHMVseUCwnRdKa3pSu/oLhaSHmSQAS9SwNdDIog=;
        b=IFJw5fn745nipaTQRsCkvRgPgfV+t4nWtyyIKrvuKDbWaapu38nvRHqT/xt1EsEoKH
         Q0S03c3mHZLQZ8VynzUA23jWXepGsvrAv2eB2JoaMSuaQPnOnlNINyMP9XnrVf318+ZK
         Mt04i+0O4YzEsy8pNvqMtNOCi2OvJUyuZpG4O37nxgPu3BUNgKVGpY2EImx3zM9bX03/
         fN6GsV0aNe+rfcKRJKhu4JFa8VIMD33Af/f27E+mf03hHiqJ7zgDAscGGVsySU1w+0bK
         ogP1H88LV4vlQ/8YNCaSwzof1lCAoEsiqHWHDRNDO+FJUBaIRjGuv182mXsFydir1yKO
         Hn6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BiLYSHMVseUCwnRdKa3pSu/oLhaSHmSQAS9SwNdDIog=;
        b=p95pVTuqCJhs4qSxtX6GozKSilmtWeys15IfnwFnXKdNa5TlioIDdeZZG6GkLLwzUx
         QEhA3BZGlr+lypf0WSihZRkZadsjnvbRO7KghDIsalcw9xnD8iNW0O2FML6V2EAX6yMC
         rV1z2N0C+ubLM75/6PBEwqHZmnIlmkyINXHXUdZ6lGwjl6m8tAUzuwfWeazKXpGSxxJO
         u8mw86dIm8TMqyG8/VJql+vPYmir0eBihr0LFazMKlYAPhAgY9/KazGgbrQRtf+r5IHF
         qxSJES6JG8/5I3F8wqA2V5GvUaGOKJyXj3p0khcPqs0KY6bZXLLkMRn0BwnumUnQMHeq
         4/Kg==
X-Gm-Message-State: AOAM532tdCzS1TJcuug+JbMyGqf4VySSlYI5cpA/GFjnN/dKsm4qddka
        51nDrS534PY/+Davy/B1LVtdZoLU54jsgMxp
X-Google-Smtp-Source: ABdhPJwIA4kV5j9wzi7rT7uqe6D1egFpLkWnU03+BbTjsb4Q406Z2FOkbHE3cVl3NU+8kKl5apO1Bw==
X-Received: by 2002:a63:fb18:: with SMTP id o24mr8937943pgh.8.1634300743262;
        Fri, 15 Oct 2021 05:25:43 -0700 (PDT)
Received: from ubuntu.mate (subs03-180-214-233-73.three.co.id. [180.214.233.73])
        by smtp.gmail.com with ESMTPSA id q18sm5575390pfj.46.2021.10.15.05.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 05:25:42 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Carlo Arenas <carenas@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH v2] Documentation: specify base point when generating MyFirstContribution patchset
Date:   Fri, 15 Oct 2021 19:25:16 +0700
Message-Id: <20211015122515.47535-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Specifying base point (commit hash) can help reviewers and testers
interested on the patchset. Mention how to record it with `--base`
option to `format-patch`.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Changes since v1 [1]:
     - Rewording (suggested by Junio).
     - Show command to determine base commit hash and pass it to `--base`
       option.

 [1]:
https://lore.kernel.org/git/f25fae40-0313-287b-5482-1c64cbe8cb64@gmail.com/T/#t

 Documentation/MyFirstContribution.txt | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
index b20bc8e914..5aaf31cb66 100644
--- a/Documentation/MyFirstContribution.txt
+++ b/Documentation/MyFirstContribution.txt
@@ -937,6 +937,23 @@ but want reviewers to look at what they have so far. You can add this flag with
 Check and make sure that your patches and cover letter template exist in the
 directory you specified - you're nearly ready to send out your review!
 
+It would help those who review and test your patches to specify on what
+commit the patches should be applied to. To do so, use the `--base` option
+when running `format-patch`. The option expects hash of the commit the
+patchset is based on. Since we base `psuh` on top of `master`, the base
+commit hash can be determined by: 
+
+----
+$ git show -s --format="%H" master
+----
+
+The output of command above can be passed to `--base` option. Replace `<base>`
+with your own hash:
+
+----
+$ git format-patch --cover-letter --base=<base> -o psuh/ master..psuh
+----
+
 [[cover-letter]]
 === Preparing Email
 

base-commit: 2bd2f258f4195ac54293a3f45b86457c0bd5fc11
-- 
An old man doll... just what I always wanted! - Clara

