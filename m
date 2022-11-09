Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A519AC433FE
	for <git@archiver.kernel.org>; Wed,  9 Nov 2022 16:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbiKIQLk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 11:11:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbiKIQLZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 11:11:25 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A152EA7
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 08:11:17 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id g12so26445617wrs.10
        for <git@vger.kernel.org>; Wed, 09 Nov 2022 08:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YXQYnykpQto+cudQtjNWOW2eQxQqG5RHXPWtyT1LGZ8=;
        b=m7MwoUP1EHzop/wcGH7tkTB6bLIp1TEh3pJvi2KTUtfbPhnBqFhNUQnbrRJHnc5wkN
         z1hy35wCRP6WIkVuEUTo2uUk8fxCsXlC/Y7UogmwBttOX/GuopC1tMSZ3EmYMdr3RYgG
         URfpqNlWabXQ6EGMubW0PmlXBsVR578FUzOD8mHnuohlXDj4LhvkAMJxzBi+VD5sVBCj
         wsNImM06qQ6y6in/fCz1ayYIasO9TdNNd4LQzvfE1lhC04UMsmCZCM+M12kNOJIs3HcL
         aG7j6Efj0HO6PR6z9bpxVKv7ZNUbvxCfVECqJCFBg5/YsdxSnPn6qCZm12U4kE5f0NJT
         Nn+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YXQYnykpQto+cudQtjNWOW2eQxQqG5RHXPWtyT1LGZ8=;
        b=qcue27rOu5cP1cZ2uKXjuf5i4TdM4U+35L3oUgf+e6CBcIUUarjyfk3iKxcFK+J9+U
         yN0hRPlzDpxoMpHrNMQZxBruSKwvK22+zKf6Q6CS9lso9OlzRFQCPdi3+1npTrjMLZBJ
         RSt6kai6Fz7m4OwIBwfa+LVkUVauSIhZ9Pi9XzppnBic5dPyheJyGtEu7nn1Km6GkkGL
         y3LopFUI6uU0jjH7dgaoxJAGOqyUyMGCbXX5U6Yt+J4yaOwTa1Q6FAUe/rDK54oo1vFG
         p055tuXCSFk54FqtVY8PxUSsOIsAhoCZmMzGoL1Ab2tfCxIXP8/M90e2CFG26BzT3wqt
         4g2Q==
X-Gm-Message-State: ACrzQf1Tt5VKdIp87FCQOZYwPyOEsD+HPJgrbXeqyVJOdTNiLUBOUOqS
        CuqKs6vCrxyGXDyPdiDQiORAZ/wNyn4=
X-Google-Smtp-Source: AMsMyM7ZWs/SQZWm/ya0bUXX+WmEkiBaI/MxNRSyMMfrPL8l0iy9gPjHIXCRNLqDgBS2MDQXt6emaA==
X-Received: by 2002:a5d:5d89:0:b0:226:e5ca:4bc2 with SMTP id ci9-20020a5d5d89000000b00226e5ca4bc2mr39032656wrb.310.1668010275645;
        Wed, 09 Nov 2022 08:11:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id be6-20020a05600c1e8600b003cf78aafdd7sm2151968wmb.39.2022.11.09.08.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 08:11:14 -0800 (PST)
Message-Id: <pull.1412.v2.git.1668010273573.gitgitgadget@gmail.com>
In-Reply-To: <pull.1412.git.1667989181611.gitgitgadget@gmail.com>
References: <pull.1412.git.1667989181611.gitgitgadget@gmail.com>
From:   "M Hickford via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 09 Nov 2022 16:11:13 +0000
Subject: [PATCH v2] Documentation: increase example cache timeout to 1 hour
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, M Hickford <mirth.hickford@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: M Hickford <mirth.hickford@gmail.com>

Previously, the example *decreased* the cache timeout compared to the
default, making it less user friendly.

Instead, nudge users to make cache more usable. Many users choose
store over cache.
https://lore.kernel.org/git/CAGJzqskRYN49SeS8kSEN5-vbB_Jt1QvAV9QhS6zNuKh0u8wxPQ@mail.gmail.com/

The default timeout remains 15 minutes. A stronger nudge would
be to increase that.

Signed-off-by: M Hickford <mirth.hickford@gmail.com>
---
    Documentation: Increase example cache timeout to 1 hour
    
    Previously, the example decreased the cache timeout compared to the
    default, nudging users to make cache less usable.
    
    Instead, nudge users to make cache more usable. Currently many users
    choose store over cache for usability. See
    https://lore.kernel.org/git/Y2p4rhiOphuOM0VQ@coredump.intra.peff.net/
    
    The default timeout remains 15 minutes. A stronger nudge would be to
    increase that.
    
    Signed-off-by: M Hickford mirth.hickford@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1412%2Fhickford%2Fnudge-cache-longer-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1412/hickford/nudge-cache-longer-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1412

Range-diff vs v1:

 1:  6c35d68cf98 ! 1:  e3e043779dd Documentation: increase example cache timeout to 1 hour
     @@ Commit message
          Documentation: increase example cache timeout to 1 hour
      
          Previously, the example *decreased* the cache timeout compared to the
     -    default, nudging users to make cache less usable.
     +    default, making it less user friendly.
      
     -    Instead, nudge users to make cache more usable. Currently many users
     -    choose store over cache for usability. See
     -    https://lore.kernel.org/git/Y2p4rhiOphuOM0VQ@coredump.intra.peff.net/
     +    Instead, nudge users to make cache more usable. Many users choose
     +    store over cache.
     +    https://lore.kernel.org/git/CAGJzqskRYN49SeS8kSEN5-vbB_Jt1QvAV9QhS6zNuKh0u8wxPQ@mail.gmail.com/
      
          The default timeout remains 15 minutes. A stronger nudge would
          be to increase that.


 Documentation/git-credential-cache.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-credential-cache.txt b/Documentation/git-credential-cache.txt
index 0216c18ef80..432e159d952 100644
--- a/Documentation/git-credential-cache.txt
+++ b/Documentation/git-credential-cache.txt
@@ -69,10 +69,10 @@ $ git push http://example.com/repo.git
 ------------------------------------
 
 You can provide options via the credential.helper configuration
-variable (this example drops the cache time to 5 minutes):
+variable (this example increases the cache time to 1 hour):
 
 -------------------------------------------------------
-$ git config credential.helper 'cache --timeout=300'
+$ git config credential.helper 'cache --timeout=3600'
 -------------------------------------------------------
 
 GIT

base-commit: 319605f8f00e402f3ea758a02c63534ff800a711
-- 
gitgitgadget
