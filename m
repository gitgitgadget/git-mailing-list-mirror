Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A72B8C433FE
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 12:55:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236847AbiC2M5P (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Mar 2022 08:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236839AbiC2M5C (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Mar 2022 08:57:02 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DCE2A27A
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 05:54:05 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id 10so15094448qtz.11
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 05:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y9ego1PepFOUPT3KmFXNQHJDxgO3A1CcYqe0ZfPViwY=;
        b=GH0rGRiyTnk7KOpoBsDo8QXA1OfmFWhI/vSUl47EFu2+/Z7NqGXKXNVjNqoPNvdlfW
         AUCbMyeMNtVLjpRNnPqSjWjFAYWiwT7Jhhgz0bzHPkVQEGicFcQQvbgtUQEeszEKz2hc
         2MvefV7ondzavJ5ypZrOn5VZ/C9SW+DWcnd6jnYVM+b9Cj+A6Quv0Hmz3qp/odag98cl
         vHEsbz1yi0e44Yy9UHed3+nW4hiZdOtgEoeebirXT7AD9ZkRn6GGeoQb/al6TbflH9uf
         Bi9Ud6xqc0LU88Ia7lrsK09/8jbjBkdFqtDGb5TiqSLtFxy8ZI4NJ9xZn33yX3kELEVh
         cPww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y9ego1PepFOUPT3KmFXNQHJDxgO3A1CcYqe0ZfPViwY=;
        b=aTuu2+4To/3k1BYmM1sh4cnwJVA2Qw7WH87TOcwo2oDKOlxFwNe5QSRp/PLmKLDJcp
         SNDV+WgLtGf05OEMjdSdD21KffGQnAUXfXZdXm6qtMSrwh/CvjXGLxYnkAMWKIUNlveG
         VC8kbZhet2VGK4/6xg8Yi2abMNM/gyBQyRRlbtp5MNb+qtQ/+IjAhOxnTg6NC+5Umf/e
         UXKzywUzhturts/zUXD7gGu5hES7n9XqmBD9FlLoViMbd/OpVeemHagXUzhboZwQjWu2
         IGCFDnPYH//jIwLZCJsueo9Lin5c/NS2GhxaJZ8CrtWQWxnpJsW5qBT1mDbAEU4/C/HV
         huPQ==
X-Gm-Message-State: AOAM533Ih2nqBJLO6Ujuvak27c65hwoxwKMt7b797lRP7qUr38fetxXH
        bApp68KDZg7piMSrheprSqTF50vCbj5YSw==
X-Google-Smtp-Source: ABdhPJzhvSm6qTC2H3M9kpG0jZaAIkwFstPe26gsCDl5hEI7oJ6Hu/swW0qIlUM3KJKGthbANFztVg==
X-Received: by 2002:a05:622a:148:b0:2e1:cb56:f3ee with SMTP id v8-20020a05622a014800b002e1cb56f3eemr27376038qtw.636.1648558442694;
        Tue, 29 Mar 2022 05:54:02 -0700 (PDT)
Received: from localhost.localdomain (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id l8-20020a05622a174800b002e1e3f7d4easm15739714qtk.86.2022.03.29.05.54.01
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 29 Mar 2022 05:54:01 -0700 (PDT)
From:   Philippe Blain <levraiphilippeblain@gmail.com>
To:     git@vger.kernel.org
Cc:     Fernando Ramos <greenfoo@u92.eu>, gitster@pobox.com,
        davvid@gmail.com, sunshine@sunshineco.com, seth@eseth.com,
        rogi@skylittlesystem.org
Subject: [PATCH] fixup! vimdiff: add tool documentation
Date:   Tue, 29 Mar 2022 08:54:00 -0400
Message-Id: <20220329125400.63337-1-levraiphilippeblain@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <xmqqy20ty3k6.fsf@gitster.g>
References: <xmqqy20ty3k6.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---

Hi Junio, Fernando,

I think the canonical Asciidoc way would be to use a listing block
(start and end the block with '----', and not indenting the lines
at all, as is done in a few places in the docs), but in this case
the parser gets confused about the several dashes in the content of
the block. So we can use a "literal block" instead [1].

[1] https://docs.asciidoctor.org/asciidoc/latest/verbatim/literal-blocks/

 Documentation/mergetools/vimdiff.txt | 174 ++++++++++++++-------------
 1 file changed, 90 insertions(+), 84 deletions(-)

diff --git a/Documentation/mergetools/vimdiff.txt b/Documentation/mergetools/vimdiff.txt
index f63fc48c29..1cc9c133f9 100644
--- a/Documentation/mergetools/vimdiff.txt
+++ b/Documentation/mergetools/vimdiff.txt
@@ -3,17 +3,17 @@ Description
 
 When specifying `--tool=vimdiff` in `git mergetool` Git will open Vim with a 4
 windows layout distributed in the following way:
-
-    ------------------------------------------
-    |             |           |              |
-    |   LOCAL     |   BASE    |   REMOTE     |
-    |             |           |              |
-    ------------------------------------------
-    |                                        |
-    |                MERGED                  |
-    |                                        |
-    ------------------------------------------
-
+....
+------------------------------------------
+|             |           |              |
+|   LOCAL     |   BASE    |   REMOTE     |
+|             |           |              |
+------------------------------------------
+|                                        |
+|                MERGED                  |
+|                                        |
+------------------------------------------
+....
 `LOCAL`, `BASE` and `REMOTE` are read-only buffers showing the contents of the
 conflicting file in specific commits ("commit you are merging into", "common
 ancestor commit" and "commit you are merging from" respectively)
@@ -56,14 +56,15 @@ needed in this case. The next layout definition is equivalent:
 +
 --
 If, for some reason, we are not interested in the `BASE` buffer.
-
-           ------------------------------------------
-           |             |           |              |
-           |             |           |              |
-           |   LOCAL     |   MERGED  |   REMOTE     |
-           |             |           |              |
-           |             |           |              |
-           ------------------------------------------
+....
+------------------------------------------
+|             |           |              |
+|             |           |              |
+|   LOCAL     |   MERGED  |   REMOTE     |
+|             |           |              |
+|             |           |              |
+------------------------------------------
+....
 --
 * `layout = "MERGED"`
 +
@@ -71,14 +72,15 @@ If, for some reason, we are not interested in the `BASE` buffer.
 Only the `MERGED` buffer will be shown. Note, however, that all the other
 ones are still loaded in vim, and you can access them with the "buffers"
 command.
-
-           ------------------------------------------
-           |                                        |
-           |                                        |
-           |                 MERGED                 |
-           |                                        |
-           |                                        |
-           ------------------------------------------
+....
+------------------------------------------
+|                                        |
+|                                        |
+|                 MERGED                 |
+|                                        |
+|                                        |
+------------------------------------------
+....
 --
 * `layout = "@LOCAL,REMOTE"`
 +
@@ -86,16 +88,17 @@ command.
 When `MERGED` is not present in the layout, you must "mark" one of the
 buffers with an asterisk. That will become the buffer you need to edit and
 save after resolving the conflicts.
-
-           ------------------------------------------
-           |                   |                    |
-           |                   |                    |
-           |                   |                    |
-           |     LOCAL         |    REMOTE          |
-           |                   |                    |
-           |                   |                    |
-           |                   |                    |
-           ------------------------------------------
+....
+------------------------------------------
+|                   |                    |
+|                   |                    |
+|                   |                    |
+|     LOCAL         |    REMOTE          |
+|                   |                    |
+|                   |                    |
+|                   |                    |
+------------------------------------------
+....
 --
 * `layout = "LOCAL,BASE,REMOTE / MERGED + BASE,LOCAL + BASE,REMOTE"`
 +
@@ -103,59 +106,62 @@ save after resolving the conflicts.
 Three tabs will open: the first one is a copy of the default layout, while
 the other two only show the differences between (`BASE` and `LOCAL`) and
 (`BASE` and `REMOTE`) respectively.
-
-           ------------------------------------------
-           | <TAB #1> |  TAB #2  |  TAB #3  |       |
-           ------------------------------------------
-           |             |           |              |
-           |   LOCAL     |   BASE    |   REMOTE     |
-           |             |           |              |
-           ------------------------------------------
-           |                                        |
-           |                MERGED                  |
-           |                                        |
-           ------------------------------------------
-
-           ------------------------------------------
-           |  TAB #1  | <TAB #2> |  TAB #3  |       |
-           ------------------------------------------
-           |                   |                    |
-           |                   |                    |
-           |                   |                    |
-           |     BASE          |    LOCAL           |
-           |                   |                    |
-           |                   |                    |
-           |                   |                    |
-           ------------------------------------------
-
-           ------------------------------------------
-           |  TAB #1  |  TAB #2  | <TAB #3> |       |
-           ------------------------------------------
-           |                   |                    |
-           |                   |                    |
-           |                   |                    |
-           |     BASE          |    REMOTE          |
-           |                   |                    |
-           |                   |                    |
-           |                   |                    |
-           ------------------------------------------
+....
+------------------------------------------
+| <TAB #1> |  TAB #2  |  TAB #3  |       |
+------------------------------------------
+|             |           |              |
+|   LOCAL     |   BASE    |   REMOTE     |
+|             |           |              |
+------------------------------------------
+|                                        |
+|                MERGED                  |
+|                                        |
+------------------------------------------
+....
+....
+------------------------------------------
+|  TAB #1  | <TAB #2> |  TAB #3  |       |
+------------------------------------------
+|                   |                    |
+|                   |                    |
+|                   |                    |
+|     BASE          |    LOCAL           |
+|                   |                    |
+|                   |                    |
+|                   |                    |
+------------------------------------------
+....
+....
+------------------------------------------
+|  TAB #1  |  TAB #2  | <TAB #3> |       |
+------------------------------------------
+|                   |                    |
+|                   |                    |
+|                   |                    |
+|     BASE          |    REMOTE          |
+|                   |                    |
+|                   |                    |
+|                   |                    |
+------------------------------------------
+....
 --
 * `layout = "LOCAL,BASE,REMOTE / MERGED + BASE,LOCAL + BASE,REMOTE + (LOCAL/BASE/REMOTE),MERGED"`
 +
 --
 Same as the previous example, but adds a fourth tab with the same
 information as the first tab, with a different layout.
-
-           ---------------------------------------------
-           |  TAB #1  |  TAB #2  |  TAB #3  | <TAB #4> |
-           ---------------------------------------------
-           |       LOCAL         |                     |
-           |---------------------|                     |
-           |       BASE          |        MERGED       |
-           |---------------------|                     |
-           |       REMOTE        |                     |
-           ---------------------------------------------
-
+....
+---------------------------------------------
+|  TAB #1  |  TAB #2  |  TAB #3  | <TAB #4> |
+---------------------------------------------
+|       LOCAL         |                     |
+|---------------------|                     |
+|       BASE          |        MERGED       |
+|---------------------|                     |
+|       REMOTE        |                     |
+---------------------------------------------
+....
 Note how in the third tab definition we need to use parenthesis to make `,`
 have precedence over `/`.
 --
-- 
2.29.2

