Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0194FECAAA1
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 09:35:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbiH3JfX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 05:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231880AbiH3JeO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 05:34:14 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945E6DFB6E
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:33:08 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id t11-20020a05683014cb00b0063734a2a786so7650783otq.11
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=nGOuhaWOxo9xvzPGIKz68/nwuj1uDPNLb+Uj048LwjY=;
        b=av4MxFMJmfiQ1yJoIUxzn7cDJiGxtBd5kQD4K0T/e/hPR94iv/wzKm11+mue8uUefs
         G4+unDd5aZqwjQbTT0ucXJ+t2zETvNx0GmRBY/zgJc4EOy0cQ937gKnmHBZJpmJmEA58
         VDz9garliVv4Jod5VwCx5lzlt5nvJPKMxdCqeGyqq1Zpvpym2vW8Cd9CxmOqsJCBaB6N
         h56JdUu8+myo52G+1ri02xRKNyx+1AwqmS/Tvz9Ef5bfgd6kw8P6ztl+WfxHlBigdc/l
         PQ3ZAaZmu/D6hJCIJVypT8IyFhpFx7eE9dHowJYjwqu1qGkuAb/g55C4bu+YhALG7DB4
         /shw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=nGOuhaWOxo9xvzPGIKz68/nwuj1uDPNLb+Uj048LwjY=;
        b=sN7BLTymYX8JWbJAsKliQCyB7qCv688ngIvhZKCZxFfp9tHWvZQuFxc7tMVsjNrWss
         ihstMhIVKSferVhwV19tQuR0+DgAXcSD0QM4CAZphEz67WeDkgtUyp9ZBHEjd3jmrhq4
         ELxlrUl79+tQxGUxCsxPMiiChRIVorV18Q2Pj8G59KSWyyK4v7/V4iu6VmCcfdFSxiVi
         rIk60WBp2iJ/zXLRLGpPdDIWGlL8mmai/sbSQU+2JMlFSSPFWxkKIkiBvTTLVxUXMKga
         cguEwa4FZBr+pYp6/PtvxmYASIkyCGdUDTdbEG92VfkNh9xy7dK9YXJALYvJ9K9jR6W5
         q0Vw==
X-Gm-Message-State: ACgBeo1Vfx33DEKyt4hffJHjYo/xE6pFpgao3C4AEKKDy6TdzfjUUbDo
        IMyyq7MaeyqoG6q03l/qWYnJUwVq+30=
X-Google-Smtp-Source: AA6agR4ws/PJKYn7YOvylZqWpCnQkzzSAm2zmadrl3RiukCE228BTzX4mmDSkpWbe71/7f66fqtZEQ==
X-Received: by 2002:a05:6830:3153:b0:63b:3f5:59cd with SMTP id c19-20020a056830315300b0063b03f559cdmr5973901ots.129.1661851982915;
        Tue, 30 Aug 2022 02:33:02 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:eec:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id e6-20020a05683013c600b00638ac7ddb77sm6876703otq.10.2022.08.30.02.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 02:33:02 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     git-fc@googlegroups.com,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 48/51] completion: bash: trivial cleanup
Date:   Tue, 30 Aug 2022 04:31:35 -0500
Message-Id: <20220830093138.1581538-49-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.37.2.351.g9bf691b78c.dirty
In-Reply-To: <20220830093138.1581538-1-felipe.contreras@gmail.com>
References: <20220830093138.1581538-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The most typical case first (COMP_WORDBREAKS contains our wanted words).

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 92831977d7..395a356106 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -360,9 +360,7 @@ _get_comp_words_by_ref ()
 	# Which word separators to exclude?
 	exclude="${COMP_WORDBREAKS//[^=:]}"
 	cword=$COMP_CWORD
-	if [ -z "$exclude" ]; then
-		words=("${COMP_WORDS[@]}")
-	else
+	if [ -n "$exclude" ]; then
 		# List of word completion separators has shrunk;
 		# re-assemble words to complete.
 		for ((i=0, j=0; i < ${#COMP_WORDS[@]}; i++, j++)); do
@@ -397,6 +395,8 @@ _get_comp_words_by_ref ()
 				cword=$j
 			fi
 		done
+	else
+		words=("${COMP_WORDS[@]}")
 	fi
 
 	cur=${words[cword]}
-- 
2.37.2.351.g9bf691b78c.dirty

