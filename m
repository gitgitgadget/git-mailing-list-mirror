Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A014B1F731
	for <e@80x24.org>; Tue,  6 Aug 2019 17:40:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387836AbfHFRkR (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Aug 2019 13:40:17 -0400
Received: from mail-pg1-f180.google.com ([209.85.215.180]:41276 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387420AbfHFRkQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Aug 2019 13:40:16 -0400
Received: by mail-pg1-f180.google.com with SMTP id x15so31615321pgg.8
        for <git@vger.kernel.org>; Tue, 06 Aug 2019 10:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MY/oEopIU4pIdBimDe6OsIAJRlgqgWvkvkbhgG6h+yA=;
        b=cJAocER3SnoUP2MktVJMsV6bEf26W8jfrzWFhOGJA+m1txQ615R2NWQa0JF/tkqWkh
         sd2BL56UauqaSj/FOPAVr5ADoJCKJUcJj3hHYqv46usXG3u/gZo+rPKGwMA/rbC2jK81
         UoW7oEuDJp4RwoqJkbKy0Iy/OAa2/WzJw9rl7qVcbzmHH0Sdxx2YwwspoYvSUmpM5jWx
         bL/8lf2rokAUkIGQXGX0PfdM9ZTm8KafpsuL1Mk347a+OMqQRnDo6IQb6TX3vXdWWnWk
         yU0zfsAnu5m49eTW4VnRfdhpqWxZygkUCISOdy6Q81rr4RTRyOQhI/sJdaZNRpGcFJN2
         egvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MY/oEopIU4pIdBimDe6OsIAJRlgqgWvkvkbhgG6h+yA=;
        b=VpTfxrCerD5mi9xmHL+/dM8w88vsR3IoXZZr/W6pzp4u/zXf8yXPA75caqW6oS0FJB
         Lq80K3nzNzdySMktptJpRyqzs4Kl+5tLv+tX1v/OWnpg4MOSS5UAeMhuxFK0UYL/PTIR
         Ke/U+TsHm7JDq2gtFzLh9nJWBOLgWGXH0Wh4nH2xLsfmNIzO7nwV9N1hvuqiTO1DU9zt
         eTXK1NsWuDyj//XHGGZ3dZYp+ufu7Nm8MW0Lbi94vEjc8HnOa8vLDR0MENMVkPm5CjEx
         gVxNDX3IZbCmdyIdsDcquGFe2EHt81C8g5tBWq6k3GhlLV76sINFY48bUyrtaT5Wgy10
         LZFQ==
X-Gm-Message-State: APjAAAVm7zwvTAwB6RLSbBwFm6q1Orx9N71jumnRrEkaSyDO3mJQpO8a
        CwrcGQ8jcq7PwSBVPEwmXmQ2ZWRhLjo=
X-Google-Smtp-Source: APXvYqwgqT4ZKnIbUfPN/q5H5Fg2G5x2J1qqezPD4mvSiXx0b1FSWglKFNITpTu9Tw3KqqU8pJjZ9w==
X-Received: by 2002:a63:2b8e:: with SMTP id r136mr4046992pgr.216.1565113214889;
        Tue, 06 Aug 2019 10:40:14 -0700 (PDT)
Received: from ar135.iitr.local ([103.37.200.217])
        by smtp.gmail.com with ESMTPSA id z20sm139757104pfk.72.2019.08.06.10.40.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 10:40:14 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     Junio <gitster@pobox.com>, GIT Mailing List <git@vger.kernel.org>
Cc:     Thomas <t.gummerer@gmail.com>, Elijah <newren@gmail.com>,
        Phillip <phillip.wood123@gmail.com>,
        Dscho <Johannes.Schindelin@gmx.de>,
        Martin <martin.agren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Subject: [GSoC][PATCHl 6/6] rebase: add --author-date-is-committer-date
Date:   Tue,  6 Aug 2019 23:06:38 +0530
Message-Id: <20190806173638.17510-7-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190806173638.17510-1-rohit.ashiwal265@gmail.com>
References: <20190806173638.17510-1-rohit.ashiwal265@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The previous commit introduced --ignore-date flag to interactive
rebase, but the name is actually very vague in context of rebase -i
since there are two dates we can work with. Add an alias to convey
the precise purpose.

Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
---
 Documentation/git-rebase.txt | 1 +
 builtin/rebase.c             | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index a5cdf8518b..bb60426911 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -388,6 +388,7 @@ See also INCOMPATIBLE OPTIONS below.
 	as the committer date. This implies --force-rebase.
 
 --ignore-date::
+--author-date-is-committer-date::
 	Lie about the author date by re-setting it to the value
 	same as committer (current) date. This implies --force-rebase.
 +
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 7f464fc9ba..a9a42f9ee4 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1433,6 +1433,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "committer-date-is-author-date",
 			 &options.committer_date_is_author_date,
 			 N_("make committer date match author date")),
+		OPT_BOOL(0, "author-date-is-committer-date", &options.ignore_date,
+			 "ignore author date and use current date"),
 		OPT_BOOL(0, "ignore-date", &options.ignore_date,
 			 "ignore author date and use current date"),
 		OPT_PASSTHRU_ARGV('C', NULL, &options.git_am_opts, N_("n"),
-- 
2.21.0

