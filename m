Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 308E1C6FA82
	for <git@archiver.kernel.org>; Thu, 22 Sep 2022 16:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbiIVQ75 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Sep 2022 12:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbiIVQ7q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2022 12:59:46 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD5213E8F
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 09:59:42 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id r7so16570345wrm.2
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 09:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=+Gm0KiPEcdtvw2UZkAcrYNiFoXQRkfYRnk7dWz7jZJA=;
        b=C3JAjsAFkQRIS4ZlyO31OB1RbAvojAA6GkVBTfEt8/f1PHu8ezTRrti14OdxQ+9U69
         zGpEkOvr7fvqb05/Zx/DeVzH3dqAvrLkcemXaEJO5fOrRnXTF9fbND+0hYe7qwo3fY7h
         jaET5UBy9CwRIi90Ojy8q5Xffzww1mN3zEgtvWVEV2r34Z3zTuQPB3HWRFMvcO0OXShJ
         VUbaJ4K3pxF/ceiXUGEiIhGCbpsGFPKzfbkVqtIWDavUzhIonUlsNGk8Cv1xlohDsaqk
         WdGqsJ3UryPFwj+znljoCA6IMqeu2IYoy6g3+spxH/BKC4+cJxoMNsOKmmPMs0le7UDX
         1Vaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=+Gm0KiPEcdtvw2UZkAcrYNiFoXQRkfYRnk7dWz7jZJA=;
        b=FMJOEMuxWxpfGJWe8O5YV+LZ0raKkxhIvwbLZnv4rO1CHpncA5st+elq+m2P8W7qF7
         SMPRx8lb8UxO47r9XC5UM3VpM0JIfDlKeNV4qQUxYSqYXPPs0vytde0DHhwB0v7xCg57
         +SBZ47PK3X5P1zhHkGZ0wE0DKyW6zpEkc0Av+nIwdOmyNieSabajFmlMpzxQdPoQgSpe
         kaYlLZOd6GJx8nXXzr85UijeFT3+bC/JWpBWF8yobkCSKcrETeuP7Z6k8kpucaWFRfHE
         vBO7EcWXP6JsowA5y8F4Kh9vkhw49Rqxi3aVSzEJG+MWGQ2CBBP/peDplgLNi6t1AbAp
         b9sw==
X-Gm-Message-State: ACrzQf3ZcnT4/bBbHRRUFPbtBRTri49lf3JifYRFJAYuklpP/bGRK/fm
        glEjE82YFDS2y3ZnevkAJITpYcF0g8o=
X-Google-Smtp-Source: AMsMyM7lXR4X/jxlDI340dN+TuZkxp8oWHSMVUx5ymsHF37cBcMGGGEhMSY7IZ9YpQdBb9B06Kd33w==
X-Received: by 2002:adf:fd09:0:b0:22a:f514:d7b7 with SMTP id e9-20020adffd09000000b0022af514d7b7mr2643027wrr.430.1663865980585;
        Thu, 22 Sep 2022 09:59:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q12-20020a7bce8c000000b003b5054c6cd2sm23039wmj.36.2022.09.22.09.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 09:59:39 -0700 (PDT)
Message-Id: <ae5c1bfc092e98b810757e752efd7cfde48a3809.1663865974.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1363.git.1663865974.gitgitgadget@gmail.com>
References: <pull.1363.git.1663865974.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 22 Sep 2022 16:59:33 +0000
Subject: [PATCH 2/3] netrc: ignore unknown lines (do not die)
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, mjcheetham@outlook.com,
        Matthew John Cheetham <mjcheetham@github.com>,
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

