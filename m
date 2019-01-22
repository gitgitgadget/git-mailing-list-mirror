Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 863C81F453
	for <e@80x24.org>; Tue, 22 Jan 2019 21:22:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbfAVVWW (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 16:22:22 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36177 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbfAVVWT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 16:22:19 -0500
Received: by mail-ed1-f65.google.com with SMTP id f23so15256edb.3
        for <git@vger.kernel.org>; Tue, 22 Jan 2019 13:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=m3WRjV0vGcYO/s8Lbvc+ufD3Abycq3lG2DvCDGRaZMY=;
        b=G89zUqhKshIqLF/hpfqE+yY30nwoaj9QPpiT6uqfQ9iH2lWrhXJP3ECf6k2gwIDzIF
         gj3mJyyE9/ZQOpzBa2dOTFFRmXUq+hcU2VmPd1FO4xFRnvYTrTI1Ay5iT5lgxBUTR097
         7gd1++60jyUifj/MbZaQstl9eh99QpYYPHUgBL0nQQIoDFd+Zr2SNs8zNobnQ/yuqYTv
         Y+8GnTBfA7VYavwOG/4/tLog1NRmz2bS2SjBzkjujsmefhzgdnHeWSJtrBbg/sdMln3w
         PkA2Wx9ZyPhibzz22BvtQm3Ge8Qjps/RtyDF4zNxKhPA+aHlh/NAxxw39k2Oidl26MlO
         /T7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=m3WRjV0vGcYO/s8Lbvc+ufD3Abycq3lG2DvCDGRaZMY=;
        b=cY2Qbki/eJfYG28GLc8AOBzmKn3vd2H7LFYFx4g825s60XPc6yJLMkVu7LEPWTJJ7m
         M+uu4DjdM5em0pstztYtpBXs2tcMeE1nrsHpK/kTLELQ5OPE3VG7/tFrjvKDJ91DIj3X
         C7ERx/sJWhd7N9vxPaHZ133ZhSWSmgtUAVdg0WXycwq7R8gTZ18B6Mruo8TYKREcduKg
         jqpa514oudalUqgICHk4w9LG6phsFcwPNJoCqzrIVjKh5AKOSriT7nGfqz7z3Br+gwLz
         oQ6sIeSapHOKvk649hhc+czjfYx39jxge8NHWOsvZTlnXq33vfcoJ0fysVJp9ieSbTSp
         HV7g==
X-Gm-Message-State: AJcUukeEOTfPGaaeGkdvmfzllpvEr1wgMbdd2EzQq4ECa+EjZhVhwXQ9
        QOHK15QvdHsgANrE2ejOdMXv0yRM
X-Google-Smtp-Source: ALg8bN7W1U+cY/gYDkjz53Rzy5nkO0mBUAczr1CIvXmNST5sa3oJ5CK1cXxlJQ9gNocLSNRSTIH3Ng==
X-Received: by 2002:a17:906:4003:: with SMTP id v3-v6mr116800ejj.240.1548192137158;
        Tue, 22 Jan 2019 13:22:17 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z2sm10121917edd.4.2019.01.22.13.22.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 13:22:16 -0800 (PST)
Date:   Tue, 22 Jan 2019 13:22:16 -0800 (PST)
X-Google-Original-Date: Tue, 22 Jan 2019 21:22:02 GMT
Message-Id: <394164709724f6a90c03016aee4a65c671839459.1548192131.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.108.git.gitgitgadget@gmail.com>
References: <pull.108.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 05/14] trace2:data: add editor/pager child classification
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jeffhost@microsoft.com, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Add trace2 process classification for editor and pager
child processes.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 editor.c | 1 +
 pager.c  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/editor.c b/editor.c
index c985eee1f9..71547674ab 100644
--- a/editor.c
+++ b/editor.c
@@ -78,6 +78,7 @@ static int launch_specified_editor(const char *editor, const char *path,
 		p.argv = args;
 		p.env = env;
 		p.use_shell = 1;
+		p.trace2_child_class = "editor";
 		if (start_command(&p) < 0)
 			return error("unable to start editor '%s'", editor);
 
diff --git a/pager.c b/pager.c
index a768797fcf..4168460ae9 100644
--- a/pager.c
+++ b/pager.c
@@ -100,6 +100,7 @@ void prepare_pager_args(struct child_process *pager_process, const char *pager)
 	argv_array_push(&pager_process->args, pager);
 	pager_process->use_shell = 1;
 	setup_pager_env(&pager_process->env_array);
+	pager_process->trace2_child_class = "pager";
 }
 
 void setup_pager(void)
-- 
gitgitgadget

