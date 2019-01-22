Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F4FE2141E
	for <e@80x24.org>; Tue, 22 Jan 2019 14:42:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728959AbfAVOmd (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 09:42:33 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38217 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728713AbfAVOmc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 09:42:32 -0500
Received: by mail-wr1-f67.google.com with SMTP id v13so27651125wrw.5
        for <git@vger.kernel.org>; Tue, 22 Jan 2019 06:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MN03LHVm0+8KK7+jJq6RQo8x9DaQXPHU+lJ9nH9vCGo=;
        b=AZN8dmgUrgOBQLTYDXK8iPQXwCVnYxzy/23VEsSM8sghdeUZpw4aTxzfJPCfJPC1Hi
         NKTco4ydoHMy9O+tcBcSiIv39ADLblUF0Yqbbx4l4VeJK9UHyZoucCKwX1ifzTSBUcZ/
         DASIYL4RHg8SlgocUjJ/AQVoGP5QvFs+Fr6TFYfIYO9GyAoDS42GJsdWtz2HDLocY/mr
         khGyV5QZJL0vagqfyIsCZk7fJWRAEavDC8AK9JlXTlmRn9adLvkahUcz3o0E68NfxNsb
         CKXYxZCpDlpcRJkZecGTV+DifzZq5F+0ZY0qRJgxOATcXIwDFr2mv7B/YAQDnd6adjlJ
         LPmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MN03LHVm0+8KK7+jJq6RQo8x9DaQXPHU+lJ9nH9vCGo=;
        b=M1HEDcSk9ZfMM8dyjiHrp7lIkiIJMGpQ656uxv3l1pMpJEt8uHH4vnXuDtMM14Yobv
         B9FyHNhkSXEGvw3hOsILRN4iYF3DourPACMqX1nOkWJTlM+7FmC11HVIMD54lDg8467w
         qwyfmsk1TdhgyYqmnjxG7pzcb9GiNgDkDyC8kmdxQtJXnb55GFI9SFJrEY+sTY5EEgtG
         rv9cg5gYQ+oDl1toClkcPB4bA8UYSx9GWY7RKDf5lK2mmTO3yy/kMznLoKB7qsj/qmaN
         8cFVbq3DEk8BK2n8vu9DkBxvJ+JnN47WyLH1fAYnErJpyQ9OZ2QAoPHWZIM/H4L2fY27
         t/Kw==
X-Gm-Message-State: AJcUukc42J1IDLVOdDHrbk4d40I6GZFqB29yJfULM2I707DcBIVOjVcX
        aoIPXKxo7Uyy736YK8540fbFiBvo
X-Google-Smtp-Source: ALg8bN5fFg8nyICMU91QcyvlZGNbAvvzy5PwLoLj246mKY0zDkQ4pJX451y0TKyvYjwdzsKujwyiOA==
X-Received: by 2002:adf:c612:: with SMTP id n18mr32129661wrg.174.1548168150490;
        Tue, 22 Jan 2019 06:42:30 -0800 (PST)
Received: from ubuntu-N750HU.booking.pcln.com (access-114.38.rev.fr.colt.net. [213.41.38.114])
        by smtp.gmail.com with ESMTPSA id k26sm31266168wmi.28.2019.01.22.06.42.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 06:42:29 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH v2 01/13] fetch: fix extensions.partialclone name in error message
Date:   Tue, 22 Jan 2019 15:42:00 +0100
Message-Id: <20190122144212.15119-2-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.20.1.322.gd6b9ae60d4
In-Reply-To: <20190122144212.15119-1-chriscool@tuxfamily.org>
References: <20190122144212.15119-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is "extensions.partialclone" and "core.partialCloneFilter", but
not "core.partialclone". Only "extensions.partialclone" is meant to
contain a remote name.

While at it, let's wrap the relevant code lines to keep them at a
reasonable length.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/fetch.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index e0140327aa..c0ade48f5d 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1478,7 +1478,8 @@ static inline void fetch_one_setup_partial(struct remote *remote)
 	 */
 	if (strcmp(remote->name, repository_format_partial_clone)) {
 		if (filter_options.choice)
-			die(_("--filter can only be used with the remote configured in core.partialClone"));
+			die(_("--filter can only be used with the remote "
+			      "configured in extensions.partialclone"));
 		return;
 	}
 
@@ -1646,7 +1647,8 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 		result = fetch_one(remote, argc, argv, prune_tags_ok);
 	} else {
 		if (filter_options.choice)
-			die(_("--filter can only be used with the remote configured in core.partialClone"));
+			die(_("--filter can only be used with the remote "
+			      "configured in extensions.partialclone"));
 		/* TODO should this also die if we have a previous partial-clone? */
 		result = fetch_multiple(&list);
 	}
-- 
2.20.1.322.gd6b9ae60d4

