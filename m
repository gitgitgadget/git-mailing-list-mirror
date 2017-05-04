Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2654207D6
	for <e@80x24.org>; Thu,  4 May 2017 22:01:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752174AbdEDWBI (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 18:01:08 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35088 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751459AbdEDWBH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2017 18:01:07 -0400
Received: by mail-wr0-f194.google.com with SMTP id g12so2692213wrg.2
        for <git@vger.kernel.org>; Thu, 04 May 2017 15:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JrVKONKNBtRAZf62lemopNTSasQyinEZSb64FXlO2ac=;
        b=RQnvXk/gtPUqNv7pMVAxU5aPeejPc4KvCfPSmr094mYbWvbxhZg7+Elm4K9w8zcijy
         vILONP9uvKQ46NjsG0p1epy9JTXgfshWAKkmAfjFZp38eC0dBbAGrKOxayToctJYZRM1
         BguJellvuTt+1mUWUvy8gBtFjnjqSlEXR1c3a8EdLxfzNnxJG7UjjcEXzOpbc8U24PAw
         EFaB6SgXcRXf5r2ZXqpxVh79M93WP0wm0wd9t5QQ7ETIodRQZ0e4/j0eevJBsSqEpGrJ
         oAxfx28ckxl20fr/5FYX7p5UCyVmuhSiYojRelPTKOy9TTPUXm9xOt9+1ilH7HQnZL4y
         C9ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JrVKONKNBtRAZf62lemopNTSasQyinEZSb64FXlO2ac=;
        b=tSoML+hJL7cJBzwRmjJG1AWwkSIv1s/XwfVdgcXmfqoSB6B3kAQPr17PqzS9RPuWkP
         NU6chpsXgBUdEWvTu3VDUDm0MIke/PC6obS8Wq0KCtakWRp2GYP3fnHN2Cd1QWTfb7gm
         H+35/Ep7sc0Q2nXf1Bat8/9XC5ua+B8O/qDlpK9O4yqU1aabM4evsuHoF0KjyNQjY2FM
         IVUC5knk0qN6F/vcmcY6/JGRbdWa47x9xGHL858+CQjjDIUfp12DC89HkMJLlrJJAkjv
         0F3TSFtszgSIG+Ll6CGmEgwNavsldip6lL9cq46QK8TXpkAspbGHWIniCPhaxeM2Spuh
         6GYA==
X-Gm-Message-State: AN3rC/7h+v6vrzEW2KYQv+bkQR1ht10yZ/s6AznLm2S23gnFgy3NBPRY
        m8JBlOj+6XzIgQ==
X-Received: by 10.223.151.203 with SMTP id t11mr22458511wrb.18.1493935266105;
        Thu, 04 May 2017 15:01:06 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id w136sm2424680wmd.0.2017.05.04.15.01.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 May 2017 15:01:05 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
        Stefano Lattarini <stefano.lattarini@gmail.com>,
        =?UTF-8?q?Ond=C5=99ej=20B=C3=ADlka?= <neleai@seznam.cz>,
        "Arnold D . Robbins" <arnold@skeeve.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/7] compat/regex: add a README with a maintenance guide
Date:   Thu,  4 May 2017 22:00:37 +0000
Message-Id: <20170504220043.25702-2-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170504220043.25702-1-avarab@gmail.com>
References: <20170504220043.25702-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a README file to compat/regex describing how the copy of the gawk
engine should be maintained.

Since gawk's regex engine was originally imported in git.git in commit
d18f76dccf ("compat/regex: use the regex engine from gawk for compat",
2010-08-17) the Git project has forked the upstream code.

Most of the changes that have been made in that time have been made
redundant by similar changes made upstream. Out of all the
modifications made to it since then, which can be found via:

    $ git log --oneline d18f76dccf..v2.13.0-rc2 -- compat/regex/

These are the only real code changes that aren't made fully redundant
by upstream patches:

    ce518bbd6c ("Fix compat/regex ANSIfication on MinGW", 2010-08-26)
    5b62e6374a ("compat/regex/regexec.c: Fix some sparse warnings", 2013-04-27)
    d099b7173d ("Fix some sparse warnings", 2013-07-18)

These look to me like they might be a non-issue due to subsequent
changes, or perhaps aren't needed anymore due to compiler updates.

In addition a few style & typo changes have been made in that time:

    ce9171cd63 ("compat/regex: fix spelling and grammar in comments", 2013-04-12)
    749f763dbb ("typofix: in-code comments", 2013-07-22)
    c01499ef69 ("C: have space around && and || operators", 2013-10-16)

Some of these could still be applied, but I don't see any point in
doing so. These are typo & style nits, if anyone really cares that
much they should send updates to gawk.git instead of making the
re-merging of code into git.git harder over such trivial issues.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 compat/regex/README | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 compat/regex/README

diff --git a/compat/regex/README b/compat/regex/README
new file mode 100644
index 0000000000..345d322d8c
--- /dev/null
+++ b/compat/regex/README
@@ -0,0 +1,21 @@
+This is the Git project's copy of the GNU awk (Gawk) regex
+engine. It's used when Git is build with e.g. NO_REGEX=NeedsStartEnd,
+or when the C library's regular expression functions are otherwise
+deficient.
+
+This is not a fork, but a source code copy. Upstream is the Gawk
+project, and the sources should be periodically updated from their
+copy, which can be done with:
+
+    for f in $(find . -name '*.[ch]' -printf "%f\n"); do wget http://git.savannah.gnu.org/cgit/gawk.git/plain/support/$f -O $f; done
+
+For ease of maintenance, and to intentionally make it inconvenient to
+diverge from upstream (since it makes it harder to re-merge) any local
+changes should be stored in the patches/ directory, which after doing
+the above can be applied as:
+
+    for p in patches/*; do patch -p3 < $p; done
+
+For any changes that aren't specific to the git.git copy please submit
+a patch to the Gawk project and/or to the GNU C library (the Gawk
+regex engine is a periodically & forked copy from glibc.git).
-- 
2.11.0

