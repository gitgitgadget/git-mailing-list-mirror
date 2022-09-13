Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 930C1ECAAD8
	for <git@archiver.kernel.org>; Tue, 13 Sep 2022 19:26:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiIMT0H (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Sep 2022 15:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiIMT0C (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2022 15:26:02 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52FE7962B
        for <git@vger.kernel.org>; Tue, 13 Sep 2022 12:26:01 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id r66-20020a1c4445000000b003b494ffc00bso1581951wma.0
        for <git@vger.kernel.org>; Tue, 13 Sep 2022 12:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=+Gm0KiPEcdtvw2UZkAcrYNiFoXQRkfYRnk7dWz7jZJA=;
        b=YB910xYMB1acQe9deX3qPHIfWqM0o+JPfY0qU+u84szHEmI9l4tlhuaaYtNsdgD0f/
         ChIJdz+0FkYmsgfz7dmZBO82bn5hhB1tM9wfC4FLuLiLZdpddxmS093XkIbzx7arJfc2
         DQIpWsaPTPL+sU0GNikJK9F3CM43ydp07lEuQ+rueD5hlixMsOP8SC0D1QppngHDXRaT
         NNBIuAdG9x9nUF2sop+UqP3/XjKG811mTHZ5z0Rn3ydyFXFUvoZbGtvJ54t5n9lvgp64
         iSy9kQm1wu3lMt0vfwaFtGa3QOruFkYeawi5rcYJlU6+2bI8/Ls+Os+nhVunQ0h7R1hZ
         GB7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=+Gm0KiPEcdtvw2UZkAcrYNiFoXQRkfYRnk7dWz7jZJA=;
        b=TvqhuqerC/3mAxa4N71hwdAj2l4GQ+h6Hv+BOLfZ0re5uIFCkT4n6w1cGO00L//Oo7
         LtjFNWT8YQDHVu6Sq8vqnT57kRdfwTresclS+KszD4SP27u1e8t7BUsms3ljbW/ry/ps
         S3/YcuKlV0/foVowsnSNOD5g13+723Up/ZBYwRTb6FWWw6OZ1cdLvuEUBwiut6UP+952
         fljR9jBcVEyqWwKa5T12N+6mvQRvMGFGsg3DoqSCTt4tXieIa9isKKE1MMlUmsv1DuzP
         rUwOmznBKLmhlchpa4AzL2MEO8tDNQDlpL3PF2LhjVu0mstz9aIrfMqLbrOiZkOx3gls
         10yw==
X-Gm-Message-State: ACgBeo0EXgW2XM0nPDS7l3OA2D0XsfhjTpJemR4XVDlttf8Y1tWDy4WN
        IYGCmqLWeP0NEYRgE6x30BAGkVc2ix8=
X-Google-Smtp-Source: AA6agR7oFomqg1OJD0aVKBjKS8bNDyBHm9OFeOfX/y23+wVj08E2lOdqNw5BxjRaVu3OQHuf72UBCA==
X-Received: by 2002:a7b:c5d3:0:b0:3a8:3d5f:4562 with SMTP id n19-20020a7bc5d3000000b003a83d5f4562mr633152wmk.78.1663097159965;
        Tue, 13 Sep 2022 12:25:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d10-20020a056000114a00b002253604bbefsm11775322wrx.75.2022.09.13.12.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 12:25:59 -0700 (PDT)
Message-Id: <ae5c1bfc092e98b810757e752efd7cfde48a3809.1663097156.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.git.1663097156.gitgitgadget@gmail.com>
References: <pull.1352.git.1663097156.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 13 Sep 2022 19:25:50 +0000
Subject: [PATCH 2/8] netrc: ignore unknown lines (do not die)
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Matthew John Cheetham <mjcheetham@github.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matthew John Cheetham <mjcheetham@outlook.com>

Contrary to the documentation on credential helpers, as well as the help
text for git-credential-netrc itself, this helper will `die` when
presented with an unknown property/attribute/token.

Correct the behaviour here by skipping and ignoring any tokens that are
unknown. This means all helpers in the tree are consistent and ignore
any unknown credential properties/attributes.

Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
---
 contrib/credential/netrc/git-credential-netrc.perl | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/contrib/credential/netrc/git-credential-netrc.perl b/contrib/credential/netrc/git-credential-netrc.perl
index bc57cc65884..9fb998ae090 100755
--- a/contrib/credential/netrc/git-credential-netrc.perl
+++ b/contrib/credential/netrc/git-credential-netrc.perl
@@ -356,7 +356,10 @@ sub read_credential_data_from_stdin {
 		next unless m/^([^=]+)=(.+)/;
 
 		my ($token, $value) = ($1, $2);
-		die "Unknown search token $token" unless exists $q{$token};
+
+		# skip any unknown tokens
+		next unless exists $q{$token};
+
 		$q{$token} = $value;
 		log_debug("We were given search token $token and value $value");
 	}
-- 
gitgitgadget

