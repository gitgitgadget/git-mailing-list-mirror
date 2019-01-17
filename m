Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E01391F453
	for <e@80x24.org>; Thu, 17 Jan 2019 20:14:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729539AbfAQUOt (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 15:14:49 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:32803 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729333AbfAQUOt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 15:14:49 -0500
Received: by mail-ed1-f65.google.com with SMTP id p6so9433205eds.0
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 12:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=I3ZJYq71XSzMHlOMDHazBvd45CvBqaQU25Hj5rhadVk=;
        b=qNbXsEanEzpRhFk2CG/Twa8nNnld02wmufW41v0yW/KTODii+x8FQpph/9STr21QA/
         d57O8nb0HkEPGv9TMajdrJ7TZ+ut0mxnxVYUgXbiNM/mZdxi6bIfcQjhV2AVjU6lqi0r
         CM9ullstT6qG1kAWN/gaMYrvYl87FD2A223dNrtgLfSvV9wYjolfburz8rdtlLVd+n2a
         jJ91ZpetkTKlcuCHgt2Bpk/O9xHN9Q+Z8cao7D3Vhn1M1ejqs5vHkP+vhSqTKmQiDV1C
         hKV7u533TjGWVjSZ7E2Ah2KE2+m3EeWrZHNCzr8ovNKGH/hYkuGow4Toi0+pgUy9Suj0
         KkmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=I3ZJYq71XSzMHlOMDHazBvd45CvBqaQU25Hj5rhadVk=;
        b=Z77FHObXxoLSnrd/v2H1K4ODDM6hwOBC5aEVfyYYy1qCQVGB8bvHFSF4i8WS3gqr4J
         8+rTTHZTH8ZY15UlkoqzRTQ52cxJYg0JbhS9nBeeVplEXWxMUh5GJkJp/uslmtNoLwIP
         hFDr7VShWLMaB2CkC8rsErdIsVHSOlFL+8bWO8I7zK+rkzobKrmsBAoIwz2SIVnFXuhP
         QkUfRjTmIuuolqxNz9wZJpPwvM6xn0rtr16hyBRqzaXwQBOPvwblG/ACBcU8MfXO0OCC
         0uD0OAyK3gXbNAykNb5/bnAhVcnu214262zKt5nqFc8fJrRxULdKSMOZdd/D0mO3SvIq
         SkYA==
X-Gm-Message-State: AJcUukeitvXJ7TFiOg/uO5AUjcFsx0oEOHSTKTua91J85JBPBvokAXcK
        EztwvOl0cqDBMpvus2x2Jhs3WKEm
X-Google-Smtp-Source: ALg8bN7mP0bw4f1L6tELJVzXYmk5z8QJ+NyNTHztFyWRIJ1H8YQp7m4uof4MNmIp6JwlMtcddYKvrg==
X-Received: by 2002:a50:f098:: with SMTP id v24mr13022143edl.78.1547756087842;
        Thu, 17 Jan 2019 12:14:47 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a27sm7076218eda.65.2019.01.17.12.14.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 12:14:47 -0800 (PST)
Date:   Thu, 17 Jan 2019 12:14:47 -0800 (PST)
X-Google-Original-Date: Thu, 17 Jan 2019 20:14:44 GMT
Message-Id: <785b71df39c777f3ff182098a6961fceb629bfcf.1547756085.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.94.git.gitgitgadget@gmail.com>
References: <pull.94.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/2] mingw (t5580): document bug when cloning from backslashed
 UNC paths
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Due to a quirk in Git's method to spawn git-upload-pack, there is a
problem when passing paths with backslashes in them: Git will force the
command-line through the shell, which has different quoting semantics in
Git for Windows (being an MSYS2 program) than regular Win32 executables
such as git.exe itself.

The symptom is that the first of the two backslashes in UNC paths of the
form \\myserver\folder\repository.git is *stripped off*.

Document this bug by introducing a test case.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5580-clone-push-unc.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/t/t5580-clone-push-unc.sh b/t/t5580-clone-push-unc.sh
index ba548df4a9..c3703765f4 100755
--- a/t/t5580-clone-push-unc.sh
+++ b/t/t5580-clone-push-unc.sh
@@ -40,6 +40,11 @@ test_expect_success clone '
 	git clone "file://$UNCPATH" clone
 '
 
+test_expect_failure 'clone with backslashed path' '
+	BACKSLASHED="$(echo "$UNCPATH" | tr / \\\\)" &&
+	git clone "$BACKSLASHED" backslashed
+'
+
 test_expect_success push '
 	(
 		cd clone &&
-- 
gitgitgadget

