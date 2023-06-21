Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A718EB64D7
	for <git@archiver.kernel.org>; Wed, 21 Jun 2023 07:30:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbjFUHar (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jun 2023 03:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbjFUHak (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2023 03:30:40 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA10172C
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 00:30:28 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f9c532fa45so1237415e9.2
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 00:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687332626; x=1689924626;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ww97vxDb5eyBOCbsy0ZIpc+K8AXKXdnYa1caNBwqeYU=;
        b=e5kN1Z0fnVL3J70VVlj25fy7x+WieHdSTITalAPf9F0YT5ses5xwtMEwGaOvrRS/Ml
         qbkystgMrJJz/oRSuzbxr9/sCjLtvaQCyOi+M8sCiTw4G7RK5jzrpwhUzg7daRLJ/hY3
         D4cA2UxmhqMwSxo+ywpCJwVBqLfJ78PHeRjLLOXpMF5+FsXYOr8MobjDYUn78iaIHwF7
         7eP4T1gCMtMbIuIiiGB1x2mR9+meJuMJ2JISQaAA0cJ5x/gEWL000S0VwIlbgyi3DN8S
         aqTYxgyzzzaiz9mgTqE6tsohFtgEEkSg4Y1tJ99HyHzrLuozIiteoAfpQAddJV/nUicZ
         Oi0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687332626; x=1689924626;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ww97vxDb5eyBOCbsy0ZIpc+K8AXKXdnYa1caNBwqeYU=;
        b=S4eCo5F2riPq2xw+qFYNApkC9FYM0doLLwdJKd5cwaILsfaWRg3IH0S1WCIFCuIUbI
         XEiTE+dxoBUJKBDwRWFiYuycAPAtQ5c3vdZNvYFsw0USuegcObYDBnNhZ1YcBDv14AHT
         Dp8pQ8PM93Szl6JeV3z0gkVIBPLaYN+FE9akTzxAKhp8AsDZQXoHzcaJ4MZS3Jl9RV9N
         WZqviINm2rlJp7y17QKhW/ZUdJlOZrIF+IeVUpx5Dr3HgmCWOCclTgxpQZn6CBEjlz9P
         OdFPaCCXkORyOyz6RZuoWchzozbw5296/1FUteVPdK4Ybnz1sVLgsDm0qFImMJlH6Wu4
         kYtw==
X-Gm-Message-State: AC+VfDx1umPOEChmtbNcXKIqq1TTlLSEauqOIr6Xt2xV203i2R7y1qJ6
        aL8txJHXWZmiHXgJzkdR9pmrOmMZq8o=
X-Google-Smtp-Source: ACHHUZ68GRB8H0vdB6a/cm0UYWCqISCyRENsRPsmnlpCUbnCufwzwzVgYrymF52oAyCWY0s+6Dkdcg==
X-Received: by 2002:a1c:f70a:0:b0:3f7:34dc:ed0d with SMTP id v10-20020a1cf70a000000b003f734dced0dmr10385794wmh.25.1687332625933;
        Wed, 21 Jun 2023 00:30:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q6-20020adff506000000b00307c8d6b4a0sm3689868wro.26.2023.06.21.00.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 00:30:25 -0700 (PDT)
Message-Id: <pull.1538.v2.git.1687332624780.gitgitgadget@gmail.com>
In-Reply-To: <pull.1538.git.1685303127237.gitgitgadget@gmail.com>
References: <pull.1538.git.1685303127237.gitgitgadget@gmail.com>
From:   "M Hickford via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 21 Jun 2023 07:30:24 +0000
Subject: [PATCH v2] doc: gitcredentials: link to helper list
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, msuchanek@suse.de, sandals@crustytoothpaste.net,
        lessleydennington@gmail.com, me@ttaylorr.com,
        mjcheetham@github.com, M Hickford <mirth.hickford@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: M Hickford <mirth.hickford@gmail.com>

Link to community list of credential helpers. This is useful information
for users.

Describe how OAuth credential helpers work. OAuth is a user-friendly
alternative to personal access tokens and SSH keys. Reduced setup cost
makes it easier for users to contribute to projects across multiple
forges.

Signed-off-by: M Hickford <mirth.hickford@gmail.com>
---
    gitcredentials: link to list of helpers
    
    Add link to list of helpers

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1538%2Fhickford%2Fhelpers-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1538/hickford/helpers-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1538

Range-diff vs v1:

 1:  49e2a6fc9f2 ! 1:  26818290468 doc: gitcredentials: introduce OAuth helpers
     @@ Metadata
      Author: M Hickford <mirth.hickford@gmail.com>
      
       ## Commit message ##
     -    doc: gitcredentials: introduce OAuth helpers
     +    doc: gitcredentials: link to helper list
      
     -    OAuth credential helpers are widely useful but work differently to other
     -    credential helpers, so worth introducing in the docs.
     +    Link to community list of credential helpers. This is useful information
     +    for users.
      
     -    Link to relevant projects.
     +    Describe how OAuth credential helpers work. OAuth is a user-friendly
     +    alternative to personal access tokens and SSH keys. Reduced setup cost
     +    makes it easier for users to contribute to projects across multiple
     +    forges.
      
          Signed-off-by: M Hickford <mirth.hickford@gmail.com>
      
       ## Documentation/gitcredentials.txt ##
     -@@ Documentation/gitcredentials.txt: $ git config --global credential.helper foo
     +@@ Documentation/gitcredentials.txt: $ git help credential-foo
     + $ git config --global credential.helper foo
       -------------------------------------------
       
     - 
     -+=== OAuth credential helpers
     -+
     -+An alternative to entering passwords or personal access tokens is to use an
     -+OAuth credential helper. Many popular Git hosts support OAuth. The first time
     -+you authenticate, the helper opens a browser window to the host.
     -+Subsequent authentication is non interactive.
     -+
     -+Two cross-platform open-source OAuth credential helpers are:
     ++=== Available helpers
      +
     -+* https://github.com/git-ecosystem/git-credential-manager[Git Credential Manager]
     -+* https://github.com/hickford/git-credential-oauth[git-credential-oauth]
     ++The community maintains a comprehensive
     ++https://git-scm.com/doc/credential-helpers[list of Git credential helpers]
     ++available.
      +
     ++=== OAuth
      +
     ++An alternative to inputting passwords or personal access tokens is to use an
     ++OAuth credential helper. Initial authentication opens a browser window to the
     ++host. Subsequent authentication happens in the background. Many popular Git
     ++hosts support OAuth.
     + 
       CREDENTIAL CONTEXTS
       -------------------
     - 


 Documentation/gitcredentials.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/gitcredentials.txt b/Documentation/gitcredentials.txt
index 100f045bb1a..a266870a042 100644
--- a/Documentation/gitcredentials.txt
+++ b/Documentation/gitcredentials.txt
@@ -104,6 +104,18 @@ $ git help credential-foo
 $ git config --global credential.helper foo
 -------------------------------------------
 
+=== Available helpers
+
+The community maintains a comprehensive
+https://git-scm.com/doc/credential-helpers[list of Git credential helpers]
+available.
+
+=== OAuth
+
+An alternative to inputting passwords or personal access tokens is to use an
+OAuth credential helper. Initial authentication opens a browser window to the
+host. Subsequent authentication happens in the background. Many popular Git
+hosts support OAuth.
 
 CREDENTIAL CONTEXTS
 -------------------

base-commit: 79bdd48716a4c455bdc8ffd91d57a18d5cd55baa
-- 
gitgitgadget
