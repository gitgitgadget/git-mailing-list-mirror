Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B01361F463
	for <e@80x24.org>; Sat, 14 Sep 2019 12:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388356AbfINMtq (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Sep 2019 08:49:46 -0400
Received: from mail-wm1-f50.google.com ([209.85.128.50]:50193 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388351AbfINMtq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Sep 2019 08:49:46 -0400
Received: by mail-wm1-f50.google.com with SMTP id c10so5375475wmc.0
        for <git@vger.kernel.org>; Sat, 14 Sep 2019 05:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=Ve0P3hfwDx6REHSOCBFhrm4WuOtsCz4P4F3mpCMiBJY=;
        b=N71uSNKJBV5xpFMtBOORF7rdCZTVMxGiVTsLrVOoFHpN+67YFz8tYdHGUN21S32ftV
         BE/0gB8Z3zUPYBz7EMVSxZanbexFa6sYxS7S1sIZIPKg9Oat1d7bxMT4q0ABpWre819E
         dfyKX78nwyzzlrp+MnAWigZQqgs1db0j84BH1GfliLUMlqI0pJy32O/9nWivZZg4xYTg
         Ucm21xW+dNXPVcaeokh6MZ7vRDsgs+k7dcOIv5dq7kMYjpVpHaaRzBVjcXc/+k7JdGIt
         jDBNVyGyTwg4s8MfA4sb+XG2FxuOaf9BhsSaPD+V1pNPv7nGAZrHC2CeFxXltNYgqFnJ
         Np9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=Ve0P3hfwDx6REHSOCBFhrm4WuOtsCz4P4F3mpCMiBJY=;
        b=X9L5tzxSCc52AN6xDqX0+33fSc21s88iaIqoJUNacfz/GdugZudbRiG1ofZ2yfpuOF
         bkggdKN/iY/ik7gwQ7H8gxdUg3zaDTzn9pt9NJ6YvYCFDsczMprxK9cd9uC2qF5UdZCk
         ydzDsFBZ+Tkx1m5NFoHuq3rWw+l8l9SQb3J9Yz3kqEmrgjML/zhlxT9+xEMEIVx9RTqI
         I4yHjQElrJ7+rRSo9txFxZB11kS2K2F8ngjytGVbLSU4xh3qP1sTsObf9xYMqDY0eQSa
         T7TxnE0z9wlTYsddQJUgiz9prZKb4eTVJl4jPuXwgpPJo4sFnWzyWT2SLDRTayVs7mrQ
         dBJA==
X-Gm-Message-State: APjAAAXMWLptG48PCmA/cLrkpBQ8HdpVOMLOW4/lEBwFee7V/Yspt8t4
        9/3QwuM9kz1uEjquLhqfF1JMq2qUNqc=
X-Google-Smtp-Source: APXvYqwZ4sggkEu9wyIJsRI6zieFD3WdtyF8dJyOrkHPfk6b2JZT6jyOyg3XmxMlGzz0NBrU9dbvzA==
X-Received: by 2002:a1c:1b58:: with SMTP id b85mr7515477wmb.95.1568465384353;
        Sat, 14 Sep 2019 05:49:44 -0700 (PDT)
Received: from ?IPv6:2a01:e35:2f1a:f160:5d34:95e:5d6e:ddbb? ([2a01:e35:2f1a:f160:5d34:95e:5d6e:ddbb])
        by smtp.gmail.com with ESMTPSA id y72sm7695173wmc.26.2019.09.14.05.49.43
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Sep 2019 05:49:43 -0700 (PDT)
To:     git@vger.kernel.org
From:   Audric GUERIN <audric.guerin@gmail.com>
Subject: Git versioning policy - PatchMyPC compatibility on Windows
Message-ID: <c760038f-7c50-73df-5187-a186868c995b@gmail.com>
Date:   Sat, 14 Sep 2019 14:49:40 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I use PatchMyPC to keep all my applications up to date on Windows but 
there is one application that is never properly detected as up to 
date... and it is Git as you guessed.

According to Justin Chalfant, Director of Engineering of PatchMyPC, Git 
version "number" / identifier is not "standard".
https://patchmypc.com/forum/index.php?topic=3032.msg8211#msg8211

PatchMyPC seems not to like that:
Git version identifier = version number + platform specific identifier

command "git version" currently returns:
git version 2.23.0.windows.1

git executables (like git-cmd.exe for instance) displays this "File 
version" on Windows:
2.23.0.1

What are your thoughts? And can you answer to Justin Chalfant on 
PatchMyPC forum?

Regards,

Audric GUERIN

