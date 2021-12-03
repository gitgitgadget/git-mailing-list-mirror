Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D2DC433F5
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 07:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378789AbhLCHRK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 02:17:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378786AbhLCHRJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 02:17:09 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FE6C06174A
        for <git@vger.kernel.org>; Thu,  2 Dec 2021 23:13:46 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id i12so1546426wmq.4
        for <git@vger.kernel.org>; Thu, 02 Dec 2021 23:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=92i7f5ZK7nNy61yfapP5L+1b8yZdSLPHDRn+7/nsggc=;
        b=BDJuqecRMBHR1eD+G+Q2zng4xO+ozg8yzpFAOIfxebkR/hDoSpy8FNIHNw3LXo1COH
         6OUleTlTecXho7+fHWjttXOKwiWGBzUsOgq9nCyLwB3VSnKw8isBPeShuujmxdQN2GvT
         HzCnNNQyNuNU9NDEn8OOLHfFNRArb8BWZ4aFvM+TWXbIx58r4LgurRbO0VqWpVvV5zxM
         jKoSTHzD9YbKr07Vmbg/I0kjiITpyxWHLGDWapLxpVSofBhT0kteoNeBAusD6NAIPiJN
         AOQSb3Ab0xJ7Oa2k3ijRfKpeStaaDEq031Y9foNca/9auW62KCc5zQKaRe1h4gnYed8f
         d2ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=92i7f5ZK7nNy61yfapP5L+1b8yZdSLPHDRn+7/nsggc=;
        b=k8sHQzLPIB2agQN07Z6X5hp9B2RBGnoj2idbHTHfhLDBOA4FWBuo6803bPE0mjRN0R
         WGtPzaNY4A7cGmQBHUCoG1pfk4VfoVLEgZ4vR67m2FCZmbiMx0NhRS5Lnf3z7Vvk8cQ+
         kC8jTKMuYBJo3L5qe8AuMGlMpvv3BLqPoUv1l2LDrBRrvj1shqZ7dvWCfrtjLRjD256K
         yB204z6cFvUAXFKrjaj7oMqaL2SPFnA4ypltvS8NwRZaB3KANqRb5rTNTk9AyWy5PaoJ
         N+sOv+3hfM4CEXrwgyjEUtSNoUW3bVIb+pdvPXJPRr32kviY3qxTSLEzuszbUPwI8T9C
         XEEw==
X-Gm-Message-State: AOAM532aUEiAu58bTKQ7fqWrfk5t5R+dD8uvG7C0ngmbl5QgSXAGXVnc
        ZqqwMGW3XLDjxjyAQfIFIshKmbkzZt0=
X-Google-Smtp-Source: ABdhPJwN3fd1yjr/ssVHr7QGwKWab1GuhvaU/an4ENMLKsVFcnydpJchamvzC1XhYHj2n22sEVFEnA==
X-Received: by 2002:a05:600c:a45:: with SMTP id c5mr12786601wmq.79.1638515624263;
        Thu, 02 Dec 2021 23:13:44 -0800 (PST)
Received: from ?IPv6:2a01:e0a:d1:f360:572d:8330:19bb:81f3? ([2a01:e0a:d1:f360:572d:8330:19bb:81f3])
        by smtp.googlemail.com with ESMTPSA id x13sm1895206wrr.47.2021.12.02.23.13.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Dec 2021 23:13:43 -0800 (PST)
Subject: Re: Merge conflict when lines next to each other are changed
To:     Loic Fouray <loic@yeplaa.net>, git@vger.kernel.org
References: <A5C94370-A9D0-43B2-9B32-0935703BCC94@yeplaa.net>
From:   =?UTF-8?Q?Jean-No=c3=abl_Avila?= <avila.jn@gmail.com>
Message-ID: <78fd768d-6248-556c-4b74-7e35bb09a197@gmail.com>
Date:   Fri, 3 Dec 2021 08:13:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <A5C94370-A9D0-43B2-9B32-0935703BCC94@yeplaa.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: fr
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le 01/12/2021 à 10:30, Loic Fouray a écrit :
> Hi,
>
> In a file, I have this 2 lines one below the other:
>
> Repository: myvalue
> Tag: 8.2.10
>
> On my local branch i have updated repository myvalue.
> On the upstream repo, they updated often the tag value (not updated of my side).
>
> When i perform a merge from upstream to local branch, i have a conflit. 
> It seems that it’s related to neighboring lines. 
> Could you confirm that it ‘s a normal git operation?
>
> Also, i need to automate this merge. Is It possible with git tools to avoid this conflict or to resolv this conflict automatically?
>
> Thanks for tour help
> Loïc 
>
>
Hi,

This is a use-case for git attribute "merge" :

https://git-scm.com/docs/gitattributes#_performing_a_three_way_merge


BR


Jean-Noël

