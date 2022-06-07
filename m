Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B05DC43334
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 01:20:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345378AbiFHBUX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jun 2022 21:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443864AbiFHBAz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jun 2022 21:00:55 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8551EEBAA
        for <git@vger.kernel.org>; Tue,  7 Jun 2022 13:42:56 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id q15so17658673wrc.11
        for <git@vger.kernel.org>; Tue, 07 Jun 2022 13:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ornPLfJhC7fIaVmbe59l55vjgSVTJqD+sQ62T0bkfsU=;
        b=bFNc794x958AVgpWzyCMdkxRO5doFj2Mgb6r+9P7JL4TNqnBzNLU9tcdwxl2GLW6u8
         4eTQ0Gvb6YwBONwPym8ySwTX7ADeGuZYfk58TLPStRq9QlDCgmg9TfNo+6JMf9IAhO+b
         dBoZS1ueDBT6+gNa0eGIle6m5b/Cwz/I7jn0XAGaXTXoVqEkZqW6+bJvJ+e5Tpa3BHlJ
         F1/Zz3bnHOWvPHGlb/XYCsIHGugm/3qmJmOaWV/j44c93aVeH3//2tUtf8xd0mZ2GKVo
         K/LI9kLPjdpOatUK6CJ3KqUd0Y3I50ooci3qjgaqXl8bMIghNsFrdrhv0L3iTGyJbCjk
         dvgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ornPLfJhC7fIaVmbe59l55vjgSVTJqD+sQ62T0bkfsU=;
        b=j/tS2GAmGoYZbmBkHUvJdmH2jJvmm44tuWuwOvCmaZVv5Yu9McJfGj37w99SnLhu/K
         0yI4EtVSRN0ZqcD/oJMbIer51mbpKlQZ04mqTP0j7PQm1Jsicj1WZgJAhu1P5lb45Nwf
         UJ/A9YvRomhfQ5TupdFHgGkGLJcm7PTi/FA0SFSja8f/18zxXI6PYnf9l/hqQ/Bk+Ayh
         N/gjU9aWXA05KDH6xVqvzPdvGWDTKE3JqEg47++hCpV0sYwPDsmo3u/OGekmW7aDCxrC
         E/QUT8w+IRQJARMHh7pUjekLKzWELsZzWG2PxD3ogYsDVNLXitbClZr1USjnKMuB40YC
         qZFg==
X-Gm-Message-State: AOAM530iZZYkLzQWDm39DH05pdErfb7QtUT22fgZfaPaqH/zB9RQAz3s
        cxlcDzT9dBAmDdnhsjZrfV/wsxef6OY9ITjg
X-Google-Smtp-Source: ABdhPJyhnAFv7OShKXSI+50HPuvVVcvZOGl/8fLGIRzY510Lj41Rv/AyDlnuEPZ4+UW9VJqpbjqm0Q==
X-Received: by 2002:adf:f646:0:b0:210:32ea:e679 with SMTP id x6-20020adff646000000b0021032eae679mr28514975wrp.395.1654634574876;
        Tue, 07 Jun 2022 13:42:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k7-20020a7bc407000000b00397402ae674sm3254567wmi.11.2022.06.07.13.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 13:42:54 -0700 (PDT)
Message-Id: <9f261c7df2c0a433c6acc46ffefd8d2633fdc3d4.1654634569.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1247.v2.git.1654634569.gitgitgadget@gmail.com>
References: <pull.1247.git.1654263472.gitgitgadget@gmail.com>
        <pull.1247.v2.git.1654634569.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Jun 2022 20:42:45 +0000
Subject: [PATCH v2 3/7] sequencer: define array with enum values
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The todo_command_info array defines which strings match with which
todo_command enum values. The array is defined in the same order as the
enum values, but if one changed without the other, then we would have
unexpected results.

Make it easier to see changes to the enum and this array by using the
enum values as the indices of the array.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 sequencer.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 8c3ed3532ac..8e26c9a6261 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1685,20 +1685,20 @@ static struct {
 	char c;
 	const char *str;
 } todo_command_info[] = {
-	{ 'p', "pick" },
-	{ 0,   "revert" },
-	{ 'e', "edit" },
-	{ 'r', "reword" },
-	{ 'f', "fixup" },
-	{ 's', "squash" },
-	{ 'x', "exec" },
-	{ 'b', "break" },
-	{ 'l', "label" },
-	{ 't', "reset" },
-	{ 'm', "merge" },
-	{ 0,   "noop" },
-	{ 'd', "drop" },
-	{ 0,   NULL }
+	[TODO_PICK] = { 'p', "pick" },
+	[TODO_REVERT] = { 0,   "revert" },
+	[TODO_EDIT] = { 'e', "edit" },
+	[TODO_REWORD] = { 'r', "reword" },
+	[TODO_FIXUP] = { 'f', "fixup" },
+	[TODO_SQUASH] = { 's', "squash" },
+	[TODO_EXEC] = { 'x', "exec" },
+	[TODO_BREAK] = { 'b', "break" },
+	[TODO_LABEL] = { 'l', "label" },
+	[TODO_RESET] = { 't', "reset" },
+	[TODO_MERGE] = { 'm', "merge" },
+	[TODO_NOOP] = { 0,   "noop" },
+	[TODO_DROP] = { 'd', "drop" },
+	[TODO_COMMENT] = { 0,   NULL },
 };
 
 static const char *command_to_string(const enum todo_command command)
-- 
gitgitgadget

