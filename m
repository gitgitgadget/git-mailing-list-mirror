Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A5DC433F5
	for <git@archiver.kernel.org>; Sat, 25 Sep 2021 12:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67D5C61279
	for <git@archiver.kernel.org>; Sat, 25 Sep 2021 12:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244576AbhIYMVl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Sep 2021 08:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233528AbhIYMVi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Sep 2021 08:21:38 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534E3C061570
        for <git@vger.kernel.org>; Sat, 25 Sep 2021 05:20:04 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id x8so5550142plv.8
        for <git@vger.kernel.org>; Sat, 25 Sep 2021 05:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lAgI15oAWfglmb0W5gZBt4p90S2epnVKy+kX2qVVaws=;
        b=A49wRUNSEWJP11jS+fYniFo6z4YGT1NrazgyFVS/b8SYjuCRYoJ8+/AkGfZdtfC/N2
         M0eZlf/ZZDOeCE7NxydX8aV7kWaxI7144+plYdXX1W5n9JpA2cAFkDQAVLmHSnR0F1De
         OM+oswVruI94E7faP9CiCCVkX1aG6hfXb/pnGP6UJXGuLJyE5f3YXHS+kEDmeZidcSkG
         SxCkEP1nyQmYOyFCWeVlxVYE2xliuJMWb488I6I0PYGYPk1eNwsyz9DMg6PJskleK0pU
         m11ytMp0oLY8DBa/qMhIe/hxM8ftPsuIUIsRsEHjxmQbd746d+yojy5heYS30WTuWus8
         QtlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lAgI15oAWfglmb0W5gZBt4p90S2epnVKy+kX2qVVaws=;
        b=E82fZx8tqgFzUz8fapJNiogTCtoQFV/EdeZqJrCWxo8O5mE7zjmJMP3263tmhweIHE
         A2MbeICKLvDmt00ZwHATdDFbjxKX2fmwqtyPW3yWjtnP9s6GPyeyf2uyXANYcFEGdu7x
         Jvr/38ZBtA5sCrtpDqlhrFSK05O0KKwhgqYlsLl2pGbuuDrzHCtYEpIO3iDIsVfKOdwa
         H9N4lwUr2JZkU6i+f9bpPQY9QgJr9fjaHJlZ6xvwkb9scXAK4E0197BwVIFVBjobMBPr
         f3q1XKYbJWbGpWfhJnFMduSTmZaUhf+PqOWrbhtiRUEV2OzxzbLNzBGBRPLdK4sOIBCN
         Ogpg==
X-Gm-Message-State: AOAM533jdJtT9eYQ//HXM3h/6eWBmFwOSK7ZK+xpnEcxspcBeDmKhisI
        rzJ/G6OoGEZg8W6RbSNEcoY=
X-Google-Smtp-Source: ABdhPJynfLUHylO/XY6Ud/4NkOi6brv1YiLoY26VtQU4ZItpU2tUwjSvYuJBTGKBh1Mz3RDr/Jy2Hg==
X-Received: by 2002:a17:90b:4c44:: with SMTP id np4mr7943705pjb.30.1632572403770;
        Sat, 25 Sep 2021 05:20:03 -0700 (PDT)
Received: from ubuntu.mate (subs09a-223-255-225-68.three.co.id. [223.255.225.68])
        by smtp.gmail.com with ESMTPSA id v7sm11531429pff.195.2021.09.25.05.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Sep 2021 05:20:03 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     "Dr. Matthias St. Pierre" <Matthias.St.Pierre@ncp-e.com>
Cc:     git@vger.kernel.org, Stefan Beller <stefanbeller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH] blame: document --color-* options
Date:   Sat, 25 Sep 2021 19:18:18 +0700
Message-Id: <20210925121817.1089897-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <d918fe0de6b04d8d848050d4aedbe060@ncp-e.com>
References: <d918fe0de6b04d8d848050d4aedbe060@ncp-e.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit cdc2d5f11f1a (builtin/blame: dim uninteresting metadata lines,
2018-04-23) and 25d5f52901f0 (builtin/blame: highlight recently changed
lines, 2018-04-23) introduce --color-lines and --color-by-age options to
git blame, respectively. While both options are mentioned in usage help,
they aren't documented in git-blame(1). Document them.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/blame-options.txt | 8 ++++++++
 Documentation/git-blame.txt     | 4 ++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
index 117f4cf806..b15999a3c8 100644
--- a/Documentation/blame-options.txt
+++ b/Documentation/blame-options.txt
@@ -136,5 +136,13 @@ take effect.
 	option.  An empty file name, `""`, will clear the list of revs from
 	previously processed files.
 
+--color-lines::
+	Color lines that contain repeated metadata. The color used is set with
+	`color.blame.repeatedLines` config option.
+
+--color-by-age::
+	Color metadata depending on age of the line. `color.blame.highlightRecent`
+	config option controls what color is used for each range of age.
+
 -h::
 	Show help message.
diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
index 3bf5d5d8b4..cfdbad030b 100644
--- a/Documentation/git-blame.txt
+++ b/Documentation/git-blame.txt
@@ -11,8 +11,8 @@ SYNOPSIS
 'git blame' [-c] [-b] [-l] [--root] [-t] [-f] [-n] [-s] [-e] [-p] [-w] [--incremental]
 	    [-L <range>] [-S <revs-file>] [-M] [-C] [-C] [-C] [--since=<date>]
 	    [--ignore-rev <rev>] [--ignore-revs-file <file>]
-	    [--progress] [--abbrev=<n>] [<rev> | --contents <file> | --reverse <rev>..<rev>]
-	    [--] <file>
+	    [--color-lines] [--color-by-age] [--progress] [--abbrev=<n>]
+	    [<rev> | --contents <file> | --reverse <rev>..<rev>] [--] <file>
 
 DESCRIPTION
 -----------

base-commit: 99c99ed8259bf070cd8ae7b51a94904b7cf5c161
-- 
2.25.1

