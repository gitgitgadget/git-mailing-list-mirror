Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E8DC433EF
	for <git@archiver.kernel.org>; Tue, 15 Mar 2022 00:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343992AbiCOAxq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 20:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241685AbiCOAxm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 20:53:42 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C78042A33
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 17:52:31 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id e24so26572539wrc.10
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 17:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WC2jXxDpze2oFshu0RZQrgPh/wDpQiK3hw/Ys11qSIU=;
        b=BFcdlyuePNXUTOJy5Nk03bwnc8sQR8TlgpRw/IfPAmKBaazqp8LChva2vcpnTjnyFH
         HplN0QQ++r0s6WcMyybvvjiHEqw4+r8B4ZzW0Wm9G+RRD/ioHMa/i+swkK34W2CVR3rQ
         c0AyUjDBacBN87XmiwXz/HvOPGttXrpJJ7ARaFDpNJtpMl/CLSmkicwmhKMBjZjCqIdE
         XeEmKdOOnTF2gvcCtgXFDo40QMt7yiU3ytMkukYNRG03uMKGJMpCHvohcguCoXnYlwQ/
         D5TFEB2+QCqlBjV3sV+DBYPSGgurQ4+kajkF0ZbXiXWjhFGgD6jBoJeUVwl35p1m1YcV
         PzaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=WC2jXxDpze2oFshu0RZQrgPh/wDpQiK3hw/Ys11qSIU=;
        b=wkcY0gBetZIybmL7cv/wq/X37sc+4rTmGnGFXcGTANuN9tfCY4dx3Im8zXvavI4KwI
         vsk5Xqrs2wjuJK6J0cVO+H/26s71BR3AH4pordA/+JYI+qGeWVWh15WBz1Vbn11p9o8y
         F1EdY/nmCO00/rgutfqw7Nz4+z6lTamrJeDFHF8TH4CLFwi8hXNdyci6NqI65ul5AeI/
         UxrnbQL+05Dd5FrTq7bJjp1q2Lfy9LDrZzWg26DEQX3T5GditPIqFofBKtq8jteYEhMf
         oQod6Ac3b9aZTc6OeYEXCh2yFp/VDbFMopn0yXb+zgqeKr380t0D3+LUVrBohX/uDeCo
         6LRw==
X-Gm-Message-State: AOAM531CudGHaj9rlsHoNdYmPqoiogSm7ZrZyMW5+f9MFD7ooLqnxfy7
        F83ciE9PRQoFWEpXdVuohvgBmWiJHVU=
X-Google-Smtp-Source: ABdhPJxdJPhe10TSn7q3s1zmQMiGGbY7xGH6Lutq2rFgT38A7wiPNDdYiTM0CYTn6moPlGtSUDRi9g==
X-Received: by 2002:a05:6000:23c:b0:1f0:2413:c860 with SMTP id l28-20020a056000023c00b001f02413c860mr17972022wrz.693.1647305549913;
        Mon, 14 Mar 2022 17:52:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v8-20020a1cf708000000b0034d7b5f2da0sm826519wmh.33.2022.03.14.17.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 17:52:29 -0700 (PDT)
Message-Id: <16aa4d0b2e4fdf4d807723a9aeb64ca7efb43233.1647305547.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1227.v2.git.git.1647305547.gitgitgadget@gmail.com>
References: <pull.1227.git.git.1647032857097.gitgitgadget@gmail.com>
        <pull.1227.v2.git.git.1647305547.gitgitgadget@gmail.com>
From:   "David Cantrell via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Mar 2022 00:52:27 +0000
Subject: [PATCH v2 2/2] if a file has been staged we don't want to list it
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     David Cantrell <david@cantrell.org.uk>,
        David Cantrell <david@cantrell.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: David Cantrell <david@cantrell.org.uk>

The previous use of --committable would include files that
had been `git add`ed, but for which a simple `git restore filename`
doesn't work. --modifed only lists those whose modifications have
not been staged.

Signed-off-by: David Cantrell <david@cantrell.org.uk>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 7ccad8ff4b1..10773a9fecd 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2896,7 +2896,7 @@ _git_restore ()
 	esac
 
 	if __git rev-parse --verify --quiet HEAD >/dev/null; then
-		__git_complete_index_file "--committable"
+		__git_complete_index_file "--modified"
 	fi
 }
 
-- 
gitgitgadget
