Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ADD9C433F5
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 07:02:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345605AbhLCHFe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 02:05:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378774AbhLCHF1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 02:05:27 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A544C061759
        for <git@vger.kernel.org>; Thu,  2 Dec 2021 23:02:02 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id d9so3679558wrw.4
        for <git@vger.kernel.org>; Thu, 02 Dec 2021 23:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=Cc1qSmhkRH9mEiAkeWW//bHs4MCli1Fze6wkuo2IMdo=;
        b=lptudOfEMMWUWgFI0WPp38z7AK404xDWwssH5b1xitdustZb+NjDSJ0rr1g8T7d+MZ
         LsVOvDWtBU0kTgRDK5kxI0FC2L2JTQ/xP4qPesCM69jB+oenAksghlPTjceseHed1vrJ
         uifxHe1vd1KXNeakymrP4+YH4ekXlqjj5oXGiE/+0DXoBF6lF3P8Gj6oalnRjEPBrjf2
         c0e7hBB9emyShoyHFmK2M8+Bmj8Oa+fNA/9r7tUSmlMFuL6haN/AIf6FNKgZCXpW9f7P
         A1YsNQlsrWk+3PUSWJVaaFegczxr6MkrCCqtxDhl0WB84mbi8IonsN6O5H2Po88bkCQ0
         ANSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=Cc1qSmhkRH9mEiAkeWW//bHs4MCli1Fze6wkuo2IMdo=;
        b=Y2j6Ptc1kewDyAAQnwyaEjx+vyAsRcIEFwkiCAhQuGwk+jtV+jAu7cpyK+A+uSKB1k
         SRfn9kYNbuKDa4Udptzy6MNvAFSb20DZ1Z0jyaFAp8cps/szQvUNiRFLH+tkcilkfdcy
         xqr87OYDzSUOVThf75x6aHXK7/g+YruqLGAhumK3nvf8MtlqE/uxXxjv4zm+edQWXNhQ
         +jGoauimv7/q3vAC7+eNcKQ10n4CbFN2uYGwJEI3hx6v+NAkrDIczuJUJfiin0J0a6MH
         VW7KAWMM5wCyoS3UTXRiXZ4KgU9ni5nVN4rFGmmY4LVJ+C+6KDk8A0mKYMl1m8n12Y88
         iJ+g==
X-Gm-Message-State: AOAM532xHQjVPeO7RTpnOHy62Sl8EbQ8s0LJLBZFd3aBWrA9yyqIZy13
        MDBpok6x6m3Sr/KiiS4fy6i4gCFj/lQ=
X-Google-Smtp-Source: ABdhPJytvSolvSXM5JwfU4e2wRwuEWkrQNshuKXKR+GjnMVXZG1qzLPg6EBliIukL58/w8KR9XqhnQ==
X-Received: by 2002:a05:6000:547:: with SMTP id b7mr19772044wrf.543.1638514920175;
        Thu, 02 Dec 2021 23:02:00 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h13sm1856984wrx.82.2021.12.02.23.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 23:01:59 -0800 (PST)
Message-Id: <7d97cbe7e9a9c55048f4db646626598774e6d92e.1638514910.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1088.git.1638514909.gitgitgadget@gmail.com>
References: <pull.1088.git.1638514909.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Fri, 03 Dec 2021 07:01:49 +0000
Subject: [PATCH 10/10] i18n: ref-filter: factorize "%(foo) atom used without
 %(bar) atom"
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 ref-filter.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 554c2ba1b17..b515efeaa25 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -841,7 +841,7 @@ static void if_then_else_handler(struct ref_formatting_stack **stack)
 	struct if_then_else *if_then_else = (struct if_then_else *)cur->at_end_data;
 
 	if (!if_then_else->then_atom_seen)
-		die(_("format: %%(if) atom used without a %%(then) atom"));
+		die(_("format: %%(%s) atom used without a %%(%s) atom"), "if", "then");
 
 	if (if_then_else->else_atom_seen) {
 		/*
@@ -907,7 +907,7 @@ static int then_atom_handler(struct atom_value *atomv, struct ref_formatting_sta
 	if (cur->at_end == if_then_else_handler)
 		if_then_else = (struct if_then_else *)cur->at_end_data;
 	if (!if_then_else)
-		return strbuf_addf_ret(err, -1, _("format: %%(then) atom used without an %%(if) atom"));
+		return strbuf_addf_ret(err, -1, _("format: %%(%s) atom used without a %%(%s) atom"), "then", "if");
 	if (if_then_else->then_atom_seen)
 		return strbuf_addf_ret(err, -1, _("format: %%(then) atom used more than once"));
 	if (if_then_else->else_atom_seen)
@@ -943,9 +943,9 @@ static int else_atom_handler(struct atom_value *atomv, struct ref_formatting_sta
 	if (prev->at_end == if_then_else_handler)
 		if_then_else = (struct if_then_else *)prev->at_end_data;
 	if (!if_then_else)
-		return strbuf_addf_ret(err, -1, _("format: %%(else) atom used without an %%(if) atom"));
+		return strbuf_addf_ret(err, -1, _("format: %%(%s) atom used without a %%(%s) atom"), "else", "if");
 	if (!if_then_else->then_atom_seen)
-		return strbuf_addf_ret(err, -1, _("format: %%(else) atom used without a %%(then) atom"));
+		return strbuf_addf_ret(err, -1, _("format: %%(%s) atom used without a %%(%s) atom"), "else", "then");
 	if (if_then_else->else_atom_seen)
 		return strbuf_addf_ret(err, -1, _("format: %%(else) atom used more than once"));
 	if_then_else->else_atom_seen = 1;
-- 
gitgitgadget
