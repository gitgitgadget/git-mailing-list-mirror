Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 358CCC433F5
	for <git@archiver.kernel.org>; Tue,  3 May 2022 04:58:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbiECFBr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 May 2022 01:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbiECFBp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 May 2022 01:01:45 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72D73BA71
        for <git@vger.kernel.org>; Mon,  2 May 2022 21:58:14 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id cx11-20020a17090afd8b00b001d9fe5965b3so1241677pjb.3
        for <git@vger.kernel.org>; Mon, 02 May 2022 21:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:from
         :subject:content-transfer-encoding;
        bh=WifkHTvGkBhOihOjBSfC/6UWaPjyjIm2i3ufFu4NYLQ=;
        b=bkNQwMuZ5qnFueQ4cJfgyLp4e8aAEKS42RgY/cPAHfkD7rZl/kFDbPzOF6Nf4GMTVG
         BrJ6hp3YJ1r2FWVxGMVS2cALoKvxe4W5vcsBfd15Qqy/ziAmkaOEK94zRFqc4YVZ8gd6
         UMRmQW/6qnahAGtUf6bQY8w76mbFfWUwd6T8U4VlozJOxd0JX/BuCWYWASsPNS15QyfL
         swgAN+YCXXTtzViFZpQforUe4fbPbgUX539/VTU1wVjMLb1nwoM0Gq1jL0uH4PDKklQm
         E11OnBbSUkI6wZnim3zerDvoZtLVb6Q2xvmIih0XuaMQVZDVh50gm4kboMZcuoBv1Gnl
         Fzvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:from:subject:content-transfer-encoding;
        bh=WifkHTvGkBhOihOjBSfC/6UWaPjyjIm2i3ufFu4NYLQ=;
        b=yhtHh2OJMj+g0Klpb09euf2LqIwN3WFoMwBYjUxjlnoj1bopwmrHWcU49nR+DsQ22B
         UZ2bJWCsEtfVhzf0+0O4L328MXxkM1wPXAiZjnPPWYLIV7OkDeARNgbN0sux/QsIAC2+
         uM/8w/LwMN2h8YyEU/Uaz1bg0e5R/vp+c9THzCLdS6W1Kek4nvZ3vX/QlSyF7eKBnD2G
         /wXOGcgusJcqzL+p6SxKbfcR9hnb2rVALtKM70UFFMGLlnghn9vOYhiLvh9sTLKCOVuH
         trgtsCIHJTogM742WV8eIUZf6iBh5dI25oGCaw+nOo47Ax519DM6EeibL47bRL53n+zi
         0azA==
X-Gm-Message-State: AOAM5338rlBEL0uLXd6XA6wUunrXW3Y3RjmPDAERYEPrV3jVfZXtSzf+
        SPheEaJY2u5KocZHlJzkK9ZDeQlMePA=
X-Google-Smtp-Source: ABdhPJxazULf4BWcCyNRZQi/RNc2iepSkZtUxbsyEb2tg3gfuwj8Z2f56d75Xp1YK7xxtqTQwJ9mrw==
X-Received: by 2002:a17:90b:2311:b0:1d9:2e43:c7ae with SMTP id mt17-20020a17090b231100b001d92e43c7aemr2832788pjb.47.1651553894084;
        Mon, 02 May 2022 21:58:14 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-4.three.co.id. [180.214.233.4])
        by smtp.gmail.com with ESMTPSA id o3-20020a63f143000000b003c14af5062asm11609654pgk.66.2022.05.02.21.58.12
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 May 2022 21:58:13 -0700 (PDT)
Message-ID: <9b3a9023-cd73-2e9d-64f1-7cc7e53d9b54@gmail.com>
Date:   Tue, 3 May 2022 11:58:10 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
To:     git@vger.kernel.org
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Incorrect branch information after fetching (local branch != remote
 branch)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I have a copy of linux.git (Linux kernel) repository, with following
branch mapping:

  * master -> torvalds/master (Linus' mainline tree)
  * linux-5.*.y -> stable/linux-5.*.y (Stable tree)
  * net-next -> net-next/master (net-next tree)

When I fetch the mainline tree (torvalds/master), I get the expected
branch fetching info:

From https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux
   672c0c5173427e..9050ba3a61a4b5  master     -> torvalds/master

When I fetch net-next, I get possibly incorrect branch name instead:

From https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next
   6e28f56c0d1d97..0530a683fc858a  master     -> net-next/master

I expected that net-next (local branch name) is displayed instead of
master in this case.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara
