Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87E4F2095B
	for <e@80x24.org>; Sat, 18 Mar 2017 18:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751695AbdCRSmT (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 14:42:19 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34286 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751661AbdCRSmQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2017 14:42:16 -0400
Received: by mail-wm0-f65.google.com with SMTP id u132so8112352wmg.1
        for <git@vger.kernel.org>; Sat, 18 Mar 2017 11:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=aQaKInknjnz7EIxRRK6Cwej2q5psvVvFnPu4AoPVThA=;
        b=d8CzNpKPQ5RqHcQeMO6xZOZsLmy3En24F4uP+T04LbXwKKbSkkqVThH+whjqf3qGdH
         MMozCTSTWo8oYIbD4auNdgFWDf4fPUg4pTR3C5ZhOYzIxdOjNlSO4NGscb8syxAxhHjo
         /kZ3B7y/iSExOKGqnL2ZdwvI7++mNYnR4zCIDZ7yQs1zByja85m+S7RjUaXGA2KkKuwt
         cvsjPAwlLP9sBWjcuVniJMy/+feEieEXATI0zgNDc3xfgzvl6qv6bG+2HNNPLt1Xe/Vk
         X1g3HMIswtqvEV7+vsOrG+o+nytSWRIRJunmu16QEGmPCcSgGvYJWfjGO5au1bYt2DRX
         P4/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=aQaKInknjnz7EIxRRK6Cwej2q5psvVvFnPu4AoPVThA=;
        b=m8UQq94RVxEZzjR2SSnWk5KuaVujbtTdguw0JcaBqzLxvfI1aq/wpgLhMjdHY/Goe2
         N5X1BD9/34l68OeX4fumpU5n5GcmxsX4k0HXZI1SeFXinZkSqvCk40mGc4fh2QMXm9u2
         RMpLy29KBJBPojJrKCRXciEzJcXM+nriFpcWQOTwALeqQnVrnDPPLq/vF7wCCMiiITyl
         Nl15BYntecQVAbT6Jch3Pid1gl3+MAq6VQjARLmQ23fv+gW9JCnAl1vBKeuZTH56tuEz
         zXra3hDk8YySP1ZAHEDCY3ejyHpqZFh12gx7DW9SjOgYSSbReCiD7itJdgLAB7zCllse
         e31Q==
X-Gm-Message-State: AFeK/H2rp8PcO6gaLEmAIjOaETPqKe9TCo8Ec2KYXxIvfCnMuZCxBjxjo3wE/BWr9BOLvw==
X-Received: by 10.28.9.213 with SMTP id 204mr3515989wmj.89.1489862534478;
        Sat, 18 Mar 2017 11:42:14 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id e16sm8026263wra.62.2017.03.18.11.42.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 18 Mar 2017 11:42:13 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/2] doc/SubmittingPatches: clarify the casing convention for "area: change..."
Date:   Sat, 18 Mar 2017 18:42:02 +0000
Message-Id: <20170318184203.16890-2-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170318184203.16890-1-avarab@gmail.com>
References: <20170318184203.16890-1-avarab@gmail.com>
In-Reply-To: <xmqqvar6310x.fsf@gitster.mtv.corp.google.com>
References: <xmqqvar6310x.fsf@gitster.mtv.corp.google.com>
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

