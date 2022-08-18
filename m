Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C20AC32774
	for <git@archiver.kernel.org>; Thu, 18 Aug 2022 14:01:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245519AbiHROBO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 10:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245696AbiHROAm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 10:00:42 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF245F8F
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 07:00:37 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id e20so1355618wri.13
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 07:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=SZAxNE/NA5qi/90iFH3jiQDcg0Xj4r7/4el8YEH4BXA=;
        b=dzcdcHyfU3RQVVMLSBvCXi6kzfcVeSGTb5/PXLQlKzYFcPv9I6F3+XLYhcQRXiJPqy
         DgVmClR5xjek+Fdk70E8vbWolOu+2mCKrFHMQcvFDUCx+x5DRDy/jnkCmUBOV6MuI1gD
         AvQoW8VoWkW4JKEcJeBvwvfSJ5/CxPv7d4OC7SeUyrw8Z1jji9UinciE2BhP6xI6XDax
         fuGNTAfSJD3N171L/ZmckYUTPBo0hiM3K5YZQGkYAcEoL53ROtcagB+pqWHb1MUMc52R
         gV9JdJW6hD59LYqmMkp0JHQWOps5zR8LvrC8Wbfcrn3+NQ1jzB+AjZOz/+6W2zY4J9Tl
         K8JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=SZAxNE/NA5qi/90iFH3jiQDcg0Xj4r7/4el8YEH4BXA=;
        b=NmpbrB/PlObIgO1xaO3OllvRu4bAXNkO6Oj0R4XIjmKptIOOfZEuiwzeiCzXdLLifD
         oudNMBe9Hy5c94NguBNyYg3F8twVJ7dMxVvvCBAnNiEhhvgQJWgZpKPKYn/Si5qshcmK
         GC1QJ+9HcIA5qBN4p/jOAcw4CvG9Vs0QrwDsXTUM0jW1PW2Cdya5W7LtsmXEQoOt3iqz
         hNRimFOU2gnqmwMmmnoN7A9a1j37QrdycnVNqbEwXb+YLdQI86ydop0/d09obuZJVRPh
         iBka2jXUV4P2LGd1DBFu7GXpHVkAB5mrGYVaj+zyeK+2p3uApLMGTIgucM4CM5HLf+g3
         103A==
X-Gm-Message-State: ACgBeo3bSnTCgoRBlS6rzl7rXkz41CMqyPhxsaVnvu5kt90GRBYkQYjC
        Gp3QM51N74vcTUODX7Y7o/fs9V9I/t8=
X-Google-Smtp-Source: AA6agR658VTLYz4zAoMGxNcz1RkPfGaKcsVjt3R6wAQ5JpiMkB+bxFzd1AlJa3aneFvIid4LD0RTIg==
X-Received: by 2002:a5d:504b:0:b0:220:7ae9:d7df with SMTP id h11-20020a5d504b000000b002207ae9d7dfmr1690042wrt.465.1660831235704;
        Thu, 18 Aug 2022 07:00:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c19-20020a05600c4a1300b003a30fbde91dsm5098800wmp.20.2022.08.18.07.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 07:00:34 -0700 (PDT)
Message-Id: <106a0563cfc29b75dbdbd54ce55140762e133539.1660831231.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1307.git.git.1660831231.gitgitgadget@gmail.com>
References: <pull.1307.git.git.1660831231.gitgitgadget@gmail.com>
From:   "Sergio via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 18 Aug 2022 14:00:31 +0000
Subject: [PATCH 2/2] Add Eclipse project settings files to .gitignore
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Sergei Krivonos <sergeikrivonos@gmail.com>,
        Sergio <sergeikrivonos@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Sergio <sergeikrivonos@gmail.com>

Signed-off-by: Sergio <sergeikrivonos@gmail.com>
---
 .gitignore | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.gitignore b/.gitignore
index 42fd7253b44..13755c31caf 100644
--- a/.gitignore
+++ b/.gitignore
@@ -246,3 +246,5 @@ Release/
 /git.VC.db
 *.dSYM
 /contrib/buildsystems/out
+/.cproject
+/.project
-- 
gitgitgadget
