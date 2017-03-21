Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BD602095D
	for <e@80x24.org>; Tue, 21 Mar 2017 14:28:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932253AbdCUO2U (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 10:28:20 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36153 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755348AbdCUO2T (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 10:28:19 -0400
Received: by mail-wm0-f65.google.com with SMTP id x124so3229605wmf.3
        for <git@vger.kernel.org>; Tue, 21 Mar 2017 07:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=aQaKInknjnz7EIxRRK6Cwej2q5psvVvFnPu4AoPVThA=;
        b=rwTdJtPTKWo/s6RNQkgYQ8+JSJsb0c9/zd0amwZObjA9obCpkRvVi/u1hf1E2ktuzv
         OYkdq5mZuSkjQoTZ8DPktn8VU5gbGkxQQu4CmY2N94Wnq2ZV0o20jFlHOcOBbNE7zmsn
         4ht2X3/r8ytl3bzALb61YXzkTqE8ce2/UzoGOe+MefVd/SAVnYCN2Kzu+4ZAdwC7l2Dz
         UiX8xAHTUdtcvbcjmzJPnLyrnhK0nOgHCxIZMACWg7X1ueL20H4MWAgXiHMLfAGc5Tw4
         NBjGWE2QQR/JRxuV/6TqL1PqnKp2nxzkwBYAbyTc9D0oeRa8h1sJt/kIg4hj4OCeVGV6
         TyQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=aQaKInknjnz7EIxRRK6Cwej2q5psvVvFnPu4AoPVThA=;
        b=eiT3g9CJQcFAES3JJx1pjgtnl50U1cyeueknS4NjL18HREocoSfmGp/t2ZPziWw9wE
         lfuqIfrFPm31Uencjd/pEGlHVGfCM109mzqbaWUn8FfQyn+osimb8PCd76qFvfmAeMS+
         p0biY6px9S2x7r5DgsqQ4osM+kxGVHyCfIgSiFsaFlkvvZ3w2dKQiccYqmwGCw6cxx9d
         o9JDsY6ddLDaXAR5EV5csHoIgjThGzuzy+JsCax8lOBFE/LjEprweYNg98Mv5/nij2rA
         GS/zEwDINVurSG+pMIZ8bWGfOFgLqHqnfDzn66NDXlwy8U2aLUvUG6FlQG6i4NbAbW70
         cFvg==
X-Gm-Message-State: AFeK/H0+m/jbVfCe7v55A/alY87EQTUVtLPtO9vRtO/jL3zzhbFufYXua3KCh5Ey1h7QYw==
X-Received: by 10.28.214.146 with SMTP id n140mr2998269wmg.58.1490106128213;
        Tue, 21 Mar 2017 07:22:08 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id s17sm25317092wrc.25.2017.03.21.07.22.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 21 Mar 2017 07:22:07 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/2] doc/SubmittingPatches: clarify the casing convention for "area: change..."
Date:   Tue, 21 Mar 2017 14:21:53 +0000
Message-Id: <20170321142154.16993-2-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170321142154.16993-1-avarab@gmail.com>
References: <20170321142154.16993-1-avarab@gmail.com>
In-Reply-To: <xmqq37ea2ykh.fsf@gitster.mtv.corp.google.com>
References: <xmqq37ea2ykh.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Amend the section which describes how the first line of the subject
should look like to say that the ":" in "area: " shouldn't be treated
like a full stop for the purposes of letter casing.

Change the two subject examples to make this new paragraph clearer,
i.e. "unstar" is not a common word, and "git-cherry-pick.txt" is a
much longer string than "githooks.txt". Pick two recent commits from
git.git that fit better for the description.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/SubmittingPatches | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 3faf7eb884..9ef624ce38 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -98,12 +98,17 @@ should skip the full stop.  It is also conventional in most cases to
 prefix the first line with "area: " where the area is a filename or
 identifier for the general area of the code being modified, e.g.
 
-  . archive: ustar header checksum is computed unsigned
-  . git-cherry-pick.txt: clarify the use of revision range notation
+  . doc: clarify distinction between sign-off and pgp-signing
+  . githooks.txt: improve the intro section
 
 If in doubt which identifier to use, run "git log --no-merges" on the
 files you are modifying to see the current conventions.
 
+It's customary to start the remainder of the first line after "area: "
+with a lower-case letter. E.g. "doc: clarify...", not "doc:
+Clarify...", or "githooks.txt: improve...", not "githooks.txt:
+Improve...".
+
 The body should provide a meaningful commit message, which:
 
   . explains the problem the change tries to solve, iow, what is wrong
-- 
2.11.0

