Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13E6E1F453
	for <e@80x24.org>; Fri, 26 Oct 2018 06:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbeJZOrJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Oct 2018 10:47:09 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:37563 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbeJZOrI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Oct 2018 10:47:08 -0400
Received: by mail-io1-f67.google.com with SMTP id k17-v6so22224ioc.4
        for <git@vger.kernel.org>; Thu, 25 Oct 2018 23:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rbzjfi72SOlcqcYe+gXXD6YoDqn6ghOmoLZ60dRN0zI=;
        b=WgWccJgmbXhuo3cAoPxtdT419TY0lVkGxqfSjdlv/gFF8naqV6jPbccO/vxeZJKDV1
         teIbquJ5T3Ybd+3jWghUN2Q46+o8DLB8ndQglSism9jwSJxutyQuvtaNbpLr+j6MpLW5
         cLC9mbbkj82/ScoU6rrXIpRmcdlLaVAAf5xMXS1AdIKWfJovyCA8n7uDRnsyE30i6lso
         zjIsYRFgh12b3+Hp4YpHwRUYEgbj5kMRRWQrrxGcWMDKk4lMDZbVTig8o+SMBukBsXro
         Bfcpn+2wQez1gRIqU6pR2viUykDN5dfwA4neDQrPcYwbi5lRCUpNcvTbQHQBwQGPBNz4
         o01g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rbzjfi72SOlcqcYe+gXXD6YoDqn6ghOmoLZ60dRN0zI=;
        b=S+mUIwKQxkmfegAKVO+SbR4ZCByV+sK7wBj7Nnmj5mhHMAhsOpngZIJt0neKNLrv/g
         wZcBAgCcFrVG07/PX4XDWR13es/F2XdfYjzKHhBQEHjiv+awpwhHjkyalr6dzoLdOxDQ
         Jdk+fZal0FkkVCezefnM+uNxHASDOOlptyDKwEmKtTtOdiUzQaODSjdIDdCuyVpTdrf0
         mXQv1YG3DBcPQ1/i0TcAAJnZrtZ5m+rBarDR+eZWB8XKK3SIzabwMgs0o8ZZrvpyaXQm
         wV2vC8pSz7c4e5jFtZqqgq7NiahL7l0booDJe82WPUoVDXO9lg36RgaBFnOgNZpdRlcj
         g8Yg==
X-Gm-Message-State: AGRZ1gKQDtdXqWQWuoqzCwSyvPqHSuzyxtv8Uh8zUU+Se30BOZ9u+gPV
        3b5gJHFLDfTs8ihvfHXEIDy7a4S6
X-Google-Smtp-Source: AJdET5dnjg3HII0Btf2cLPapa7KnGhk8TyRNOrM7hAycss2JZ4fc3O8Z8WrpWHd5LBSFdClOjuAIhA==
X-Received: by 2002:a5e:9505:: with SMTP id r5-v6mr1251956ioj.224.1540534288682;
        Thu, 25 Oct 2018 23:11:28 -0700 (PDT)
Received: from archbookpro.localdomain (ktnron0919w-lp140-01-76-68-143-166.dsl.bell.ca. [76.68.143.166])
        by smtp.gmail.com with ESMTPSA id h130-v6sm3862084ioa.52.2018.10.25.23.11.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 23:11:28 -0700 (PDT)
Date:   Fri, 26 Oct 2018 02:11:26 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     git@vger.kernel.org
Cc:     liu.denton@gmail.com, anmolmago@gmail.com, briankyho@gmail.com,
        david.lu97@outlook.com, shirui.wang@hotmail.com, davvid@gmail.com,
        gitster@pobox.com
Subject: [RESEND PATCH v3 2/3] completion: support `git mergetool --[no-]gui`
Message-ID: <20181026061126.GA7302@archbookpro.localdomain>
References: <cover.1540398076.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1540398076.git.liu.denton@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Denton Liu <liu.denton@gmail.com>
Signed-off-by: Anmol Mago <anmolmago@gmail.com>
Signed-off-by: Brian Ho <briankyho@gmail.com>
Signed-off-by: David Lu <david.lu97@outlook.com>
Signed-off-by: Ryan Wang <shirui.wang@hotmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index db7fd87b6..a45b4a050 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1833,7 +1833,7 @@ _git_mergetool ()
 		return
 		;;
 	--*)
-		__gitcomp "--tool= --prompt --no-prompt"
+		__gitcomp "--tool= --prompt --no-prompt --gui --no-gui"
 		return
 		;;
 	esac
-- 
2.19.1

