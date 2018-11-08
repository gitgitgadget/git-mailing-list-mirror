Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 694D91F453
	for <e@80x24.org>; Thu,  8 Nov 2018 20:53:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbeKIGaR (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Nov 2018 01:30:17 -0500
Received: from mail-vs1-f73.google.com ([209.85.217.73]:50386 "EHLO
        mail-vs1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbeKIGaR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Nov 2018 01:30:17 -0500
Received: by mail-vs1-f73.google.com with SMTP id f203so3289580vsd.17
        for <git@vger.kernel.org>; Thu, 08 Nov 2018 12:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=aihNd2+oWmFS7+Liyve/66K8kjetOjI+OCXcKC32k6I=;
        b=uCY+jvq++a4f8ChaaCs+CXLIbzj4cwlwtposYpKha7PjjiwaxwW9gjjLmB1bmN35pl
         Rb7BtO3DxrNWqCIAJiqV4tgIM+ystd5HmQ89rpyPI3Jg5n2u2bZbpezsARDOzv+6uqu8
         Gn4vYw3cmBFj8TjOiTUZ1fZsTGJcPAlquQI0DoW9AwjdLFqVpYSivLPWRzjT+e8U0xX4
         ScmiBsxiLf5dr5uXFHVK3fTa/ObflorEUbO1HsYJaZ6sIFoUFQX6rdq9thGknQnGykod
         qiN4H0QMYdB6QdmZU0Ewj1M4ch8a4xw5ht5ddJxEsLv990/BrFF4KmER94KTFuSZORpt
         KPcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=aihNd2+oWmFS7+Liyve/66K8kjetOjI+OCXcKC32k6I=;
        b=fHAG69pm+bTTl3eXbg8GDEl3DFoi4NRzrPUkdmxp6deidL8Geh4tBGQOIeLqsRZ+Rw
         vH3c7m6oVSnmcCVzVJXq/+3x5fJN53htcR7at9S0iEh2J72VmFCmZFqFEhO2ip3VSxa8
         C2zU9ogh/9V77qWbFuVtn22C6gLUg/1sMPdtJnueID7Q+YkBIst1tAAZa7JvyPcqfC25
         dHp/b3oeY1f32SIKyX3tk6ZVfjajsmOTBM737gvPsIszMeBaRc+Sj8IqpdFOmls0LUxN
         B4d4hDBtLgOuTLPfKMdGhLE1uA9oe/XkuRfcstqY3DBn3DMi0dg4grp5t1z+8z6jyqcR
         G7BQ==
X-Gm-Message-State: AGRZ1gJemzncgm+1UKFrtOD0JhG45wArEIwTVJ+p03SzE5KkzhbA343b
        v8H+mx+N24MZeT5OlhAKftfZEKIPpJjY
X-Google-Smtp-Source: AJdET5di63Wb6cnUWKCFCIrJIPjSgiDz3FYlSSHp/gGwP/ZWO8/51+hMFcmxiMAab4RxLYR9bxknwVZeHrDD
X-Received: by 2002:ab0:278e:: with SMTP id t14mr5194208uap.5.1541710383001;
 Thu, 08 Nov 2018 12:53:03 -0800 (PST)
Date:   Thu,  8 Nov 2018 12:52:55 -0800
In-Reply-To: <20181030220817.61691-2-sbeller@google.com>
Message-Id: <20181108205255.193402-1-sbeller@google.com>
Mime-Version: 1.0
References: <20181030220817.61691-2-sbeller@google.com>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
Subject: [PATCH] Makefile: add pending semantic patches
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com, szeder.dev@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: SZEDER G=C3=A1bor <szeder.dev@gmail.com>

Add a description and place on how to use coccinelle for large refactorings
that happen only once.

Based-on-work-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---

I consider including this patch in a resend instead.
It outlays the basics of such a new workflow, which we can refine later.

Thanks,
Stefan

 Makefile                  |  7 +++--
 contrib/coccinelle/README | 60 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index b08d5ea258..e5abfe4cef 100644
--- a/Makefile
+++ b/Makefile
@@ -2739,9 +2739,12 @@ endif
 	then \
 		echo '    ' SPATCH result: $@; \
 	fi
-coccicheck: $(addsuffix .patch,$(wildcard contrib/coccinelle/*.cocci))
+coccicheck: $(addsuffix .patch,$(filter-out %.pending.cocci,$(wildcard con=
trib/coccinelle/*.cocci)))
=20
-.PHONY: coccicheck
+# See contrib/coccinelle/README
+coccicheck-pending: $(addsuffix .patch,$(wildcard contrib/coccinelle/*.pen=
ding.cocci))
+
+.PHONY: coccicheck coccicheck-pending
=20
 ### Installation rules
=20
diff --git a/contrib/coccinelle/README b/contrib/coccinelle/README
index 9c2f8879c2..fa09d1abcc 100644
--- a/contrib/coccinelle/README
+++ b/contrib/coccinelle/README
@@ -1,2 +1,62 @@
 This directory provides examples of Coccinelle (http://coccinelle.lip6.fr/=
)
 semantic patches that might be useful to developers.
+
+There are two types of semantic patches:
+
+ * Using the semantic transformation to check for bad patterns in the code=
;
+   This is what the original target 'make coccicheck' is designed to do an=
d
+   it is expected that any resulting patch indicates a regression.
+   The patches resulting from 'make coccicheck' are small and infrequent,
+   so once they are found, they can be sent to the mailing list as per usu=
al.
+
+   Example for introducing new patterns:
+   67947c34ae (convert "hashcmp() !=3D 0" to "!hasheq()", 2018-08-28)
+   b84c783882 (fsck: s/++i > 1/i++/, 2018-10-24)
+
+   Example of fixes using this approach:
+   248f66ed8e (run-command: use strbuf_addstr() for adding a string to
+               a strbuf, 2018-03-25)
+   f919ffebed (Use MOVE_ARRAY, 2018-01-22)
+
+   These types of semantic patches are usually part of testing, c.f.
+   0860a7641b (travis-ci: fail if Coccinelle static analysis found somethi=
ng
+               to transform, 2018-07-23)
+
+ * Using semantic transformations in large scale refactorings throughout
+   the code base.
+
+   When applying the semantic patch into a real patch, sending it to the
+   mailing list in the usual way, such a patch would be expected to have a
+   lot of textual and semantic conflicts as such large scale refactorings
+   change function signatures that are used widely in the code base.
+   A textual conflict would arise if surrounding code near any call of suc=
h
+   function changes. A semantic conflict arises when other patch series in
+   flight introduce calls to such functions.
+
+   So to aid these large scale refactorings, semantic patches can be used,
+   using the process as follows:
+
+   1) Figure out what kind of large scale refactoring we need
+      -> This is usually done by another unrelated series.
+   2) Create the sematic patch needed for the large scale refactoring
+      and store it in contrib/coccinelle/*.pending.cocci
+      -> The suffix containing 'pending' is important to differentiate
+      this case from the other use case of checking for bad patterns.
+   3) Apply the semantic patch only partially, where needed for the patch =
series
+      that motivates the large scale refactoring and then build that serie=
s
+      on top of it.
+      By applying the semantic patch only partially where needed, the seri=
es
+      is less likely to conflict with other series in flight.
+      To make it possible to apply the semantic patch partially, there nee=
ds
+      to be mechanism for backwards compatibility to keep those places wor=
king
+      where the semantic patch is not applied. This can be done via a
+      wrapper function that has the exact name and signature as the functi=
on
+      to be changed.
+
+   4) Send the series as usual, including only the needed parts of the
+      large scale refactoring
+
+   Later steps (not necessarily by the original author) are to apply the
+   semantic patch in a way that do not produce lots of conflicts, for exam=
ple
+   by consulting `git diff --numstat origin/master..origin/pu` and the cha=
nges
+   of the semantic patch.
--=20
2.19.1.930.g4563a0d9d0-goog

