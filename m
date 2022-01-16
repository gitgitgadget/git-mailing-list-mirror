Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 399E5C433EF
	for <git@archiver.kernel.org>; Sun, 16 Jan 2022 16:11:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbiAPQLf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Jan 2022 11:11:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbiAPQLf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jan 2022 11:11:35 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1EEDC061574
        for <git@vger.kernel.org>; Sun, 16 Jan 2022 08:11:34 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id ay4-20020a05600c1e0400b0034a81a94607so16147355wmb.1
        for <git@vger.kernel.org>; Sun, 16 Jan 2022 08:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=UVj1+Q7FEvEkKU363zNItZxkaHAwcr/UdO8g+qKGT08=;
        b=KChGWRFJrbyP5OzPYLcIA+gI2cy51oggFEdYFq2aOOUisaTB7DoIeZZ5ERWSZ6FWR4
         VsX7zSV+CAGbXoJZmbgevga/Ekf3L/9j3cbgYEWYOWAcv8Shvb/SNiMwoUn+igOdtiKI
         CQ7lJfF7c72MoElQZu6ENP4kK7ygB0h2k8zQKf8JlOusLX8w9P/BxgdC/rK61VJns86K
         BsP0+csbLTcH9LxjE16WvGb5v7Trn6ZRFgtadCRRXL9XWyuQRaGeJbCFDASxAIb6zEc4
         RnamU0XE4xNnyJo6vQvl+CZ8aTy+QuyAVi4OV3rjw4fohaFEiBWy/ORIBxnehe8HprgZ
         m98Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=UVj1+Q7FEvEkKU363zNItZxkaHAwcr/UdO8g+qKGT08=;
        b=n/UubBvVJsBwZ6xGTdmWUulXYMFaVVnYVjt9QSLdnSyBVVXtsidq0vK9kngBQETvpZ
         Z7hWwygtPzCjMMk4j7lUfLGrPuhhzPgcPkqYnrZETHVxtdLY0p0HY6hugafz6ORvPcB+
         EqExaJPlbJJ/1ynnWpZK9OQ8pmN4H1MMEVGjOeNr+bDcRJOYfjqyaLYVdnvoT5V8dBsQ
         iwmAZny6PbFIY1InFJktOSIhA+v4m2//epDe2Fh3NKMetz00r2hoyAOCsgBovcWBQ1eS
         PZvmBCZfQlRRvS1Y81qAVwE7c54wTweoPqdKIQv36E3VspG54uy94fyCyflRXZp8KIyz
         dDjw==
X-Gm-Message-State: AOAM532syiOGb/Ef8NGdPpS/hHcOcXHjV3CZ1cH7w5zmgqznAAmfmNIW
        h6b18dgDsdkrcbI6ryVnvi0pv08+st4=
X-Google-Smtp-Source: ABdhPJzjbgS/APPdKaQq3zocq8TcSHxrtVHCYlAACsKCH1ykXk1t0pJ/dsGkMpJQKbOsMRvss1daDw==
X-Received: by 2002:a1c:1bc2:: with SMTP id b185mr5984315wmb.99.1642349492917;
        Sun, 16 Jan 2022 08:11:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f9sm12820177wry.115.2022.01.16.08.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jan 2022 08:11:32 -0800 (PST)
Message-Id: <pull.1115.v2.git.1642349490723.gitgitgadget@gmail.com>
In-Reply-To: <pull.1115.git.1642182615339.gitgitgadget@gmail.com>
References: <pull.1115.git.1642182615339.gitgitgadget@gmail.com>
From:   "Philip Oakley via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 16 Jan 2022 16:11:30 +0000
Subject: [PATCH v2] README.md: add CodingGuidelines and a link for Translators
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philip Oakley <philipoakley@iee.email>,
        Philip Oakley <philipoakley@iee.email>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philip Oakley <philipoakley@iee.email>

The README.md does not use the GitHub Markdown URL links [1] of
[txt](url), rather the reference method [2] of trailing empty square
brackets. The references themselves are listed at the foot of the
document. Those footers are not shown by GitHub/GitLab rendering.

Also space out the list joining instructions and clarify that
subscription is via the majordomo address.

[1] https://docs.github.com/en/github/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax#links
[2] https://gist.github.com/ChrisTollefson/a3af6d902a74a0afd1c2d79aadc9bb3f#reference-links

Signed-off-by: Philip Oakley <philipoakley@iee.email>
---
    README.md: add CodingGuidelines and a link for Translators
    
    Also space out the list joining instructions and clarify the
    subscription via the majordomo address.
    
    
    Signed-off-by: Philip Oakley philipoakley@iee.email
    ===================================================
    
    cc: Philip Oakley philipoakley@iee.email cc: Junio C Hamano
    gitster@pobox.com cc: Jiang Xin worldhello.net@gmail.com
    
    changes since v1:
    
     * Used reference style links, rather than lnk [url] style.
    
     * added Jianf as L10 coordinator.
    
     * note: Patch is a response to a user question on the "Git for Human
       Beings" git-users list
       https://groups.google.com/d/msgid/git-users/aa68b9c8-4cf4-4193-8af3-79d7e3feafbbn%40googlegroups.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1115%2FPhilipOakley%2FReadme-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1115/PhilipOakley/Readme-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1115

Range-diff vs v1:

 1:  ac6d0abbdde ! 1:  48cc30b7cc8 README.md: add CodingGuidelines and a link for Translators
     @@ Metadata
       ## Commit message ##
          README.md: add CodingGuidelines and a link for Translators
      
     -    Also space out the list joining instructions and clarify the subscription
     -    via the majordomo address.
     +    The README.md does not use the GitHub Markdown URL links [1] of
     +    [txt](url), rather the reference method [2] of trailing empty square
     +    brackets. The references themselves are listed at the foot of the
     +    document. Those footers are not shown by GitHub/GitLab rendering.
     +
     +    Also space out the list joining instructions and clarify that
     +    subscription is via the majordomo address.
     +
     +    [1] https://docs.github.com/en/github/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax#links
     +    [2] https://gist.github.com/ChrisTollefson/a3af6d902a74a0afd1c2d79aadc9bb3f#reference-links
      
          Signed-off-by: Philip Oakley <philipoakley@iee.email>
      
     @@ README.md: installed).
       requests, comments and patches to git@vger.kernel.org (read
      -[Documentation/SubmittingPatches][] for instructions on patch submission).
      +[Documentation/SubmittingPatches][] for instructions on patch submission
     -+and [Documentation/CodingGuidelines]() ).
     ++and [Documentation/CodingGuidelines][]).
      +
      +Those wishing to help with error message translation (localization L10)
     -+should see [po/README.md]()
     -+(a `po` file is a portable object file for the translations).
     ++should see [po/README.md][] (a `po` file is a Portable Object file that
     ++holds the translations).
      +
       To subscribe to the list, send an email with just "subscribe git" in
      -the body to majordomo@vger.kernel.org. The mailing list archives are
      -available at <https://lore.kernel.org/git/>,
     -+the body to majordomo@vger.kernel.org (not the list). The mailing list
     -+archives are available at <https://lore.kernel.org/git/>,
     ++the body to majordomo@vger.kernel.org (not the Git list). The mailing
     ++list archives are available at <https://lore.kernel.org/git/>,
       <http://marc.info/?l=git> and other archival sites.
       
       Issues which are security relevant should be disclosed privately to
     +@@ README.md: and the name as (depending on your mood):
     + [Documentation/giteveryday.txt]: Documentation/giteveryday.txt
     + [Documentation/gitcvs-migration.txt]: Documentation/gitcvs-migration.txt
     + [Documentation/SubmittingPatches]: Documentation/SubmittingPatches
     ++[Documentation/CodingGuidelines]: Documentation/CodingGuidelines
     ++[po/README.md]: po/README.md
     + \ No newline at end of file


 README.md | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/README.md b/README.md
index f6f43e78deb..d2b061e3998 100644
--- a/README.md
+++ b/README.md
@@ -32,10 +32,16 @@ installed).
 The user discussion and development of Git take place on the Git
 mailing list -- everyone is welcome to post bug reports, feature
 requests, comments and patches to git@vger.kernel.org (read
-[Documentation/SubmittingPatches][] for instructions on patch submission).
+[Documentation/SubmittingPatches][] for instructions on patch submission
+and [Documentation/CodingGuidelines][]).
+
+Those wishing to help with error message translation (localization L10)
+should see [po/README.md][] (a `po` file is a Portable Object file that
+holds the translations).
+
 To subscribe to the list, send an email with just "subscribe git" in
-the body to majordomo@vger.kernel.org. The mailing list archives are
-available at <https://lore.kernel.org/git/>,
+the body to majordomo@vger.kernel.org (not the Git list). The mailing
+list archives are available at <https://lore.kernel.org/git/>,
 <http://marc.info/?l=git> and other archival sites.
 
 Issues which are security relevant should be disclosed privately to
@@ -64,3 +70,5 @@ and the name as (depending on your mood):
 [Documentation/giteveryday.txt]: Documentation/giteveryday.txt
 [Documentation/gitcvs-migration.txt]: Documentation/gitcvs-migration.txt
 [Documentation/SubmittingPatches]: Documentation/SubmittingPatches
+[Documentation/CodingGuidelines]: Documentation/CodingGuidelines
+[po/README.md]: po/README.md
\ No newline at end of file

base-commit: 1ffcbaa1a5f10c9f706314d77f88de20a4a498c2
-- 
gitgitgadget
