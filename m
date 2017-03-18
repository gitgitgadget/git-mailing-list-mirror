Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D4DE2095B
	for <e@80x24.org>; Sat, 18 Mar 2017 18:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751778AbdCRSmV (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 14:42:21 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36048 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751671AbdCRSmS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2017 14:42:18 -0400
Received: by mail-wr0-f195.google.com with SMTP id l37so13190926wrc.3
        for <git@vger.kernel.org>; Sat, 18 Mar 2017 11:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=yNDamqA4aKMMXHB+MdwOQ5WeYbBOXgZxtAW8RS6mIyg=;
        b=Ojqllia5nq4tXkil16HV6gD+d/gPrK0G9HR3nrutSaKPneupf9UaUHjvCpuS4PJXtw
         Otak84wgQL5yh0RS62CgXI8fSxusx3BU+ehIPfw2shmD9Ru01cRChLjthtHbN1SdSTey
         HfbDHez6Dn/MG9bOdOj1jG1qlrF3+vFQmil8LGvThPLDMIkf93IqC/Qj9axLtrTAGK3A
         JaIjr9w0OpiAnhPLoEIowYkFBq2uyGmYrIlzq7MuFzA6WugAkIBCxWXg15eSL/+eNc9s
         Hb/+i6CnUYJ3tOcJtzdolF0bbUto7tN1+dEx5VLp6MET5+0zbuJ3XHzZABAD27hUwMpX
         IuMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=yNDamqA4aKMMXHB+MdwOQ5WeYbBOXgZxtAW8RS6mIyg=;
        b=knUTcNh1lnX/EOexPoOf8hX2EmzVttQI34l5hGhUF089zP/w+/OqHju7fZAnQQJCfJ
         Q7ULwI9/HdO5hMvx3jOBVldWgFfL8Ir4GgtZzIAO8FJvS2B9lIY67DL6lt0qskpNkbPO
         ZYIZtsVkZLnL/HRq9rq+fHPMB8xaryUEwSTYcFzijaixuWLexzr306M6/x6/FKGgB07I
         IqklpNkdvZNiRWdy3mbVp+mVMr+cF2tQN+VUSEFmD02x8zfu+7NHbvKlHAnBtsEYRQtG
         8OmOOUOX+Qjetvw/5bas+1AQfJZNbslI/3/dh5EuG1WRDr+JWvAUNLEhdKgcMqwPgnsM
         gMRQ==
X-Gm-Message-State: AFeK/H0ajBD3YR/0QXY9MUvTaZKuPPM7wO5iSOuqD4vGBvnM3BM8yUzPFhr0U07UCTPGxA==
X-Received: by 10.223.183.46 with SMTP id l46mr18488027wre.89.1489862536051;
        Sat, 18 Mar 2017 11:42:16 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id e16sm8026263wra.62.2017.03.18.11.42.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 18 Mar 2017 11:42:15 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/2] doc/SubmittingPatches: show how to get a CLI commit summary
Date:   Sat, 18 Mar 2017 18:42:03 +0000
Message-Id: <20170318184203.16890-3-avarab@gmail.com>
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

Amend the section which describes how to get a commit summary to show
how do to that with "git show", currently the documentation only shows
how to do that with gitk.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/SubmittingPatches | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 9ef624ce38..78c8e36a4b 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -134,8 +134,17 @@ with the subject enclosed in a pair of double-quotes, like this:
     noticed that ...
 
 The "Copy commit summary" command of gitk can be used to obtain this
-format.
+format, or this invocation of "git show":
 
+    git show -s --date=format:%Y-%m-%d --pretty='commit %h ("%s", %ad)' <commit>
+
+To turn that into a handy alias:
+
+    git config --global alias.git-commit-summary "show -s --date=format:%Y-%m-%d --pretty='commit %h (\"%s\", %ad)'"
+
+And then to get the commit summary:
+
+    git git-commit-summary <commit>
 
 (3) Generate your patch using Git tools out of your commits.
 
-- 
2.11.0

