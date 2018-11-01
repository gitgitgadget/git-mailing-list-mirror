Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55F2D1F453
	for <e@80x24.org>; Thu,  1 Nov 2018 12:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbeKAVDc (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Nov 2018 17:03:32 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36122 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728199AbeKAVDc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Nov 2018 17:03:32 -0400
Received: by mail-wm1-f67.google.com with SMTP id a8-v6so1121477wmf.1
        for <git@vger.kernel.org>; Thu, 01 Nov 2018 05:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gla8R/83fguG2iyJlz3txGL01tOW8s7yMXIdDFa7f+E=;
        b=jhHVhzyHqVP0Hl83hTFU20bd5kEKGqLy7Etz+2gZOk1zXUOXqcMKUSDpzahB000+yP
         9LBQQKyU/IQRD2s7Xl7OSkqTNnpSWr+IOTRVrI9/quWbUlJ3RogLgD4oioq1NtdrOZGK
         q75mg+w57YhXz+v+a+5LHizHCJgY2JzEGjkoUW0C+o9w1xpgUKM6Ir+HGBUeexbmipoJ
         D+jammTrA8hB2REBfrBKsBzI0u6Aj6WoNHEJKAMwqdKmbxiXLvHXluBnUEcDYu0gz5/X
         ikQSWxBj/2DzallELZTaCptq6wxGvzmAb6lnSBMNVnWtqKMXpFMJ9kaA0pNW+oFWfbRG
         GBtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gla8R/83fguG2iyJlz3txGL01tOW8s7yMXIdDFa7f+E=;
        b=m/6tDBBXp0HDKLRCCrlCYAVNuzU92pfEdlTER8sz42n8s7MUNuzcafK/R8UaIeHKiD
         ltX4YA2Fu1KyEtOV9d9fMjRRuZwpDtpDcAObqSIWRgOxLS08EQTXSLLXwsELnt2yko25
         8LOhr42ubTiUs0SeiwDaeX3ZXxOtu/DlmgET8GysTndGfTb2G2IEDlu4wvieCuH8iIrG
         NbmhOF7feLEiN/83QY8PVT63sWw+EIU9/T+PML+BRLmqolSd7rzLWY3UpCo0B3ukjCAN
         qEOjNgCfOxO20KFrRQhCldTrnnaaszANqZSwSlLrElZuZS2i/XvA3wLO1n9jsjpIQpHS
         k5ug==
X-Gm-Message-State: AGRZ1gLP5mklWfApCozxo+WNeL5JDdcVpfdepmiTwvgGEdSR6fOu8Ll2
        fNLLY0NivV+9yL9XOG8Bg3x+HrVM
X-Google-Smtp-Source: AJdET5e3zIGgSycp7L0+o+KjT/rPrE5YdOWIWrMli60m8nX7yXAyvD7I14jL6cC9zLqurMGCUfp2Tg==
X-Received: by 2002:a1c:650b:: with SMTP id z11-v6mr5417850wmb.28.1541073651227;
        Thu, 01 Nov 2018 05:00:51 -0700 (PDT)
Received: from localhost.localdomain ([31.223.156.57])
        by smtp.gmail.com with ESMTPSA id z12-v6sm14368239wrn.43.2018.11.01.05.00.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 05:00:50 -0700 (PDT)
From:   Slavica Djukic <slavicadj.ip2018@gmail.com>
X-Google-Original-From: Slavica Djukic <slawica92@hotmail.com>
To:     slavicadj.ip2018@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        slawica92@hotmail.com
Subject: [PATCH 2/3] [Outreachy] ident: introduce set_fallback_ident() function
Date:   Thu,  1 Nov 2018 13:00:29 +0100
Message-Id: <20181101120029.13992-1-slawica92@hotmail.com>
X-Mailer: git-send-email 2.19.1.windows.1
In-Reply-To: <20181101115546.13516-1-slawica92@hotmail.com>
References: <20181101115546.13516-1-slawica92@hotmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Usually, when creating a commit, ident is needed to record the author
and commiter.
But, when there is commit not intended to published, e.g. when stashing
changes,  valid ident is not necessary.
To allow creating commits in such scenario, let's introduce helper
function "set_fallback_ident(), which will pre-load the ident.

In following commit, set_fallback_ident() function will be called in stash.

Signed-off-by: Slavica Djukic <slawica92@hotmail.com>
---
 cache.h |  1 +
 ident.c | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/cache.h b/cache.h
index 681307f716..6b5b559a05 100644
--- a/cache.h
+++ b/cache.h
@@ -1470,6 +1470,7 @@ extern const char *git_sequence_editor(void);
 extern const char *git_pager(int stdout_is_tty);
 extern int is_terminal_dumb(void);
 extern int git_ident_config(const char *, const char *, void *);
+void set_fallback_ident(const char *name, const char *email);
 extern void reset_ident_date(void);
 
 struct ident_split {
diff --git a/ident.c b/ident.c
index 33bcf40644..410bd495e9 100644
--- a/ident.c
+++ b/ident.c
@@ -505,6 +505,23 @@ int git_ident_config(const char *var, const char *value, void *data)
 	return 0;
 }
 
+void set_fallback_ident(const char *name, const char *email)
+{
+	if (!git_default_name.len) {
+		strbuf_addstr(&git_default_name, name);
+		committer_ident_explicitly_given |= IDENT_NAME_GIVEN;
+		author_ident_explicitly_given |= IDENT_NAME_GIVEN;
+		ident_config_given |= IDENT_NAME_GIVEN;
+	}
+
+	if (!git_default_email.len) {
+		strbuf_addstr(&git_default_email, email);
+		committer_ident_explicitly_given |= IDENT_MAIL_GIVEN;
+		author_ident_explicitly_given |= IDENT_MAIL_GIVEN;
+		ident_config_given |= IDENT_MAIL_GIVEN;
+	}
+}
+
 static int buf_cmp(const char *a_begin, const char *a_end,
 		   const char *b_begin, const char *b_end)
 {
-- 
2.19.1.windows.1

