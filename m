Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04ADB1F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 21:50:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbeJKFOV (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 01:14:21 -0400
Received: from mail-io1-f74.google.com ([209.85.166.74]:48347 "EHLO
        mail-io1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbeJKFOV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 01:14:21 -0400
Received: by mail-io1-f74.google.com with SMTP id v12-v6so5939271iob.15
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 14:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Iaw44RTBOK0AvMmAeksONK9xCLHcVKCwlD5k4BRnW9k=;
        b=DO3vpJomrLSBRSao049486nz1m4+cwBrCBaW6ec8UH0+qswzfYfkUWMYpqvht1M95R
         emfkxyxEGpbnpz9wpdLi6Yn7jyi4nOcI/DebZMRo73EQWudDS1B3xq62Ca2OaTty8LMh
         AkkDeZcgt020qjYJnF5TmqpLgOpISakSXpWaS3TGgQjY9I86Lls9/QuSKrAf67JdqGt9
         9pEJO2fytDmDeqp+hdQiGvMoZt6BLSH9v8mMu/Nu9fybsImaX/1ERXOpM0T/cy0fVh3W
         pCo37C0ehWvGQJQ1OTu0uh2pXYqJewWV8lln05cV747Pe3IM+TAF+qJ9xVOQAv7pHdT4
         8ZPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Iaw44RTBOK0AvMmAeksONK9xCLHcVKCwlD5k4BRnW9k=;
        b=hkY38Sfl300zswniNugBWbKGIge03+nVDbj0YHrIGR8aUrpcuQD+H+4sJE18YiOlPr
         Bwj0ofUvCSVzQCcjDvXqbP3gXDbxB9UwvrCkzWMNomRd+wtPmUzlEnSDpeKReCxYpspE
         jA482ilAsEbdYP8oMS72T7pT15jF55inxDcCC+JaIUSXLevadBDiwYnJGkvO7PRNifJs
         Wxs4g2s+GqY98ioKiAoQThM8eEumUktxjYtgFOhz/UZUVIvlX9p57uGkbeMnMmP/gkac
         +41C6EPOczP08hnWlDT7TfbFZgfc/hM/UKhDdSCSILIsKGDOOosu98MhA8tGZC8zQNHw
         fQ5Q==
X-Gm-Message-State: ABuFfogJRzF/Rxn5t5rxX+Nd8C6HavaD15f1qDuF0ah+da3iKJKo66Nr
        qFjTVBO0BbuGadibqVXDwmHf4xn5pmLqQn577zhG34WD5eq6b+R6ri+7zdKwdkDO+/MXuCLjwNC
        KoLLrkop/+LOP+lhCkGp0NUFbAmaH7Ttn2o3L+gdmF4H02aRs5iiYrRk5FUKy
X-Google-Smtp-Source: ACcGV61zHHNRmYrtGRCtXnHugdNnx1R0DBfxMTwoV6snSNCEKDWb5zYVbnM+YJJE9JmL910PezdIZxckf3zQ
X-Received: by 2002:a24:6cc2:: with SMTP id w185-v6mr13462438itb.5.1539208216022;
 Wed, 10 Oct 2018 14:50:16 -0700 (PDT)
Date:   Wed, 10 Oct 2018 14:50:01 -0700
In-Reply-To: <20181010215008.233529-1-sbeller@google.com>
Message-Id: <20181010215008.233529-3-sbeller@google.com>
Mime-Version: 1.0
References: <20181010215008.233529-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0
Subject: [PATCH v5 2/9] submodule.c: fix indentation
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The submodule subsystem is really bad at staying within 80 characters.
Fix it while we are here.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/submodule.c b/submodule.c
index b53cb6e9c4..0de9e2800a 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1244,7 +1244,8 @@ static int get_next_submodule(struct child_process *cp,
 		if (!submodule) {
 			const char *name = default_name_or_path(ce->name);
 			if (name) {
-				default_submodule.path = default_submodule.name = name;
+				default_submodule.path = name;
+				default_submodule.name = name;
 				submodule = &default_submodule;
 			}
 		}
@@ -1254,8 +1255,10 @@ static int get_next_submodule(struct child_process *cp,
 		default:
 		case RECURSE_SUBMODULES_DEFAULT:
 		case RECURSE_SUBMODULES_ON_DEMAND:
-			if (!submodule || !unsorted_string_list_lookup(&changed_submodule_names,
-							 submodule->name))
+			if (!submodule ||
+			    !unsorted_string_list_lookup(
+					&changed_submodule_names,
+					submodule->name))
 				continue;
 			default_argv = "on-demand";
 			break;
-- 
2.19.0

