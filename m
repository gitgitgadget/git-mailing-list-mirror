Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4381C83F3E
	for <git@archiver.kernel.org>; Tue,  5 Sep 2023 19:25:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236319AbjIETZd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Sep 2023 15:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237513AbjIETZ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2023 15:25:29 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0003E46
        for <git@vger.kernel.org>; Tue,  5 Sep 2023 12:25:00 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-52a1ce52ef4so4112100a12.2
        for <git@vger.kernel.org>; Tue, 05 Sep 2023 12:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693941897; x=1694546697; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vNiyZTcBktaN35hdEi1ccJ99DBVek94ghG2MjZ0SpvM=;
        b=UFzr0ZlI42vfXrdtXX6qThR+EWiY8sEkezzGAx8kaN6zr8zo6LXkQQTUxPxH6hkKKT
         2sBcHZndhcP0Km1ynvVEAeyWdejrUBudeleTzzdBq0WNIAQ6zt1IoNTRp2XKC9oUWS8n
         2GM9NyfraOy4IK1PbnmxWJ2+IodLz9NCgUIud0HNLYlkt6vhphAwZ80iT0sw1LQcbKvo
         tnAOA7Y5SMX+l/5lifU8o9RZgoJ7+CFk7Av1lpMBYUKq6ada+1jhuCQ6bwJK0i71B7Tv
         9C8+rAaqvHeo/oj2kGJjV+CeE35UdeOf2RY8Rze9/ra6f6eLnfPcX3aIHMssh4QuIv3D
         Wx5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693941897; x=1694546697;
        h=mime-version:user-agent:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vNiyZTcBktaN35hdEi1ccJ99DBVek94ghG2MjZ0SpvM=;
        b=UZ0RP5mea5cBR+/cZvQJnV9ek6K8rSJqz2RCuJLKVBUVGPJ2m7DfBqj9a9oi/gF/hH
         XZlt1I/qgG0r/IL7zBKXfp7q/TQzUBmD0oxQiI3tvs1JW7b1u+0st6+125wWyZYiYGH0
         fJObNWT51mhNf45VtfmeJr5PDyLonoEyNmVbyxO79yNWCsGEHUpsrjlFe1qUbg5H2BMW
         R+Nwi8Oa8w8Q/Wm89NukU8LxMF+SaUGsB+h8R6551uOdVXTM08/VjoH+EadLr6G89NB8
         RwMa3sGnmVRI/FdFN3VuXfXW9/SxFfD0CC9ufka8xiaNco/DSx5BeOUyIqYOrnbQjhju
         J+jw==
X-Gm-Message-State: AOJu0YyRUQwnFzXd8g8/HIqe3g9nUv8gzDS/+9R+0kmeH3TurjeEMp/8
        gzjjtm3jeLkfDKaxWAcr1Hzb5pJ0nu8=
X-Google-Smtp-Source: AGHT+IF9GpGH3Y32vG9XWj7Z55VGXWH0FA9eSzsH0lX3llC6ha0vALKWDhF4xYP4daSHnGnczG7jdA==
X-Received: by 2002:a19:4f54:0:b0:500:9734:545a with SMTP id a20-20020a194f54000000b005009734545amr394548lfk.5.1693936348482;
        Tue, 05 Sep 2023 10:52:28 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id c19-20020ac25313000000b004fe7011072fsm2450969lfh.58.2023.09.05.10.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 10:52:27 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, John Cai <johncai86@gmail.com>
Subject: [PATCH 1/1] doc/diff-options: fix link to generating patch section
Date:   Tue, 05 Sep 2023 20:52:27 +0300
Message-ID: <87zg20qzhg.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

First, there is no need for conditional referencing, as all the files
that include "diff-options.txt" eventually include
"diff-generate-patch.txt" as well.

Next, when formatted as man-page, the section title is rendered
"GENERATING PATCH TEXT WITH -P" whereas reference still reads
"Generating patch text with -p", that is both inconsistent and makes
searching harder than it needs to be.

Fix the issues by just referring to the section, without custom
reference text, and then unconditionally.

Fixes: ebdc46c242 (docs: link generating patch sections)
Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 Documentation/diff-options.txt | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 9f33f887711d..c07488b123c6 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -22,13 +22,7 @@ ifndef::git-format-patch[]
 -p::
 -u::
 --patch::
-	Generate patch (see section titled
-ifdef::git-log[]
-<<generate_patch_text_with_p, "Generating patch text with -p">>).
-endif::git-log[]
-ifndef::git-log[]
-"Generating patch text with -p").
-endif::git-log[]
+	Generate patch (see <<generate_patch_text_with_p>>).
 ifdef::git-diff[]
 	This is the default.
 endif::git-diff[]
-- 
2.25.1

