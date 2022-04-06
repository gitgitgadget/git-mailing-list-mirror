Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7356FC433F5
	for <git@archiver.kernel.org>; Wed,  6 Apr 2022 20:15:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbiDFUQ4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Apr 2022 16:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232896AbiDFUQQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Apr 2022 16:16:16 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C0712A85
        for <git@vger.kernel.org>; Wed,  6 Apr 2022 11:03:14 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-e1dcc0a327so3801869fac.1
        for <git@vger.kernel.org>; Wed, 06 Apr 2022 11:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=nNIVg/0Db5ove50aZXzOAXLkBffMEI6QBh72JUuohvw=;
        b=To3Xfo5T80NfvUG4fXD+OxUVUXYPGyRDWCipa++peOJCpxocWDcRPcxEKoYAnY0kvy
         8tUh899P2FEfHnAO01m1k8piYZ9QbXzIf32+46bNeaLyR25uptCG+m7VB9CceLa5G4cP
         nlm+fdlMIYfRzkIvTcb0+dzMDsQT/aC9mNtB7cp/jXlvzgyEwUchxWhy/NrX0EKUerDM
         h+wwhdHVDzc29CQVlQIwNJ7WpdJFjuimyklCXw6vneFo2oM77bocwxoCeh5BKirWBbNV
         HblsyP7cgeUYrueMv3KoreJTNYtxQ0FUqTcY5h+VaJeyKgPc4/dYd+TiV++nAYq0NZcR
         We6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nNIVg/0Db5ove50aZXzOAXLkBffMEI6QBh72JUuohvw=;
        b=HzqjXjDSefVe7TjxWbdpjkwi7WM+VewgJLvMsCwvzYQvu1deIpuAzSbPBumkv+XCFt
         RbQ+0E7ZioF0ismzcRPXjac567MBG9NIb1gM8qssfSzxNOWPVk0RxQQ7XwCZenugy5ms
         FDKt1TaSVS4NsWwV/IsV5UeGtvZGjkLt3ir/M2vUShqdaXxUqRWk3s7/0IypTF5progJ
         fj+f2mtByIGwYGDgLsTmukumbtI8RtQN4yA7bNwavTopVchwGbKmARJz4fKaAF94yVCq
         8Tvb7fW3roZQiqJfAveap4PgvxOtlIPGJwDK2yxD0jIwicQJdvnlndBIODlaa5vYGy6y
         RjXw==
X-Gm-Message-State: AOAM532wTb5Yo1ecwHmz+s+MQx+jSMMd/IkcF34XfAc5r/7MhtCXq2z9
        cORF5fiqzvgjcTz31zAJO7ZKcflTCS5m
X-Google-Smtp-Source: ABdhPJxrfcCvuUrT94ImuJgBq+X8zq+NQNZSGsPHO5nl4oJGg+GGbhFoOgrE4nK3ig+gjrK9/bQI9w==
X-Received: by 2002:a05:6870:2116:b0:e2:5693:a5f with SMTP id f22-20020a056870211600b000e256930a5fmr1302388oae.242.1649268193837;
        Wed, 06 Apr 2022 11:03:13 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id q11-20020a4a330b000000b003289cbe97c6sm6594709ooq.13.2022.04.06.11.03.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 11:03:13 -0700 (PDT)
Message-ID: <378c5790-f587-4e26-87be-8f856974e5ca@github.com>
Date:   Wed, 6 Apr 2022 14:03:12 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/1] contrib/vscode/: debugging with VS Code and gdb
Content-Language: en-US
To:     COGONI Guillaume <cogoni.guillaume@gmail.com>, avarab@gmail.com
Cc:     Matthieu.Moy@univ-lyon1.fr, git.jonathan.bressat@gmail.com,
        git@vger.kernel.org
References: <84f77a5b-5721-3583-8ed8-9d360928cf35@matthieu-moy.fr>
 <20220406151858.5047-1-cogoni.guillaume@gmail.com>
 <20220406151858.5047-2-cogoni.guillaume@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <20220406151858.5047-2-cogoni.guillaume@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/6/2022 11:18 AM, COGONI Guillaume wrote:
> The externalConsole=true setting is broken for many users (launching the
> debugger with such setting results in VS Code waiting forever without
> actually starting the debugger). Also, this setting is a matter of user
> preference, and is arguably better set in a "launch" section in the
> user-wide settings.json than hardcoded in our script. Remove the line to
> use VS Code's default, or the user's setting.
> 
> Add useful links in contrib/vscode/README.md to help the user to
> configure VS Code and how to use the debugging feature.
> 
> Add a mention to the README and the init.sh in Documentation/
> MyFirstContribution.txt and a part to convince a newcomer that VS Code
> can be helpful.

Sorry for not getting to this in v1.
 
> Signed-off-by: COGONI Guillaume <cogoni.guillaume@gmail.com>
> Co-authored-by: BRESSAT Jonathan <git.jonathan.bressat@gmail.com>
> Helped-by: Matthieu Moy <Matthieu.Moy@univ-lyon1.fr>
> Helped-by: Derrick Stolee <derrickstolee@github.com>

Here, you probably want to flip the order here (Helped-by, then
Co-authored-by, then Signed-off-by). You probably also want the
sign-off of your co-author, too.

The sign-off should be the last thing in the message, because
the previous lines are covered by that sign-off.

> +
> +[[Bonus-useful-tools]]
> +== Bonus - useful tools
> +
> +=== VS Code

Here, maybe use the full name, then the short version.

 === Visual Studio Code (VS Code)

> +A script that creates the configuration files is available in contrib/vscode/init.sh. Useful links
> +and explanation of how to use the script are available in contrib/vscode/README.md.

This passive voice could be made active such as:

  The contrib/vscode/init.sh script creates configuration files that
  enable several valuable VS Code features. See contrib/vscode/README.md
  for more information on using the script.

Make a new paragraph before talking about debuggers.

> +Using the integrate debugger can be particularly helpful to understand how Git works internally.
> +It can be used to isolate some parts of code, with this you may be able to ask more precises
> +question when you are stuck. (See getting-help sections).

I would focus less on "benefits of debugging" and focus instead on
"benefits of debugging using your GUI editor". Something like this
might be a good start:

  In particular, this script enables using the VS Code visual debugger,
  including setting breakpoints in the editor.

> \ No newline at end of file

Fix this missing newline.

> diff --git a/contrib/vscode/README.md b/contrib/vscode/README.md
> index 8202d62035..f383c95e1f 100644
> --- a/contrib/vscode/README.md
> +++ b/contrib/vscode/README.md
> @@ -6,7 +6,11 @@ code editor which runs on your desktop and is available for
>  [Windows](https://code.visualstudio.com/docs/setup/windows),
>  [macOS](https://code.visualstudio.com/docs/setup/mac) and
>  [Linux](https://code.visualstudio.com/docs/setup/linux). Among other languages,
> -it has [support for C/C++ via an extension](https://github.com/Microsoft/vscode-cpptools).
> +it has [support for C/C++ via an extension](https://github.com/Microsoft/vscode-cpptools) with
> +[debugging support](https://code.visualstudio.com/docs/editor/debugging)
> +
> +To get help about "how to personalize your settings" read:
> +[How to set up your settings](https://code.visualstudio.com/docs/getstarted/settings)

These changes are pretty standard, and I have no concerns here.

>              "stopAtEntry": false,
>              "cwd": "\${workspaceFolder}",
>              "environment": [],
> -            "externalConsole": true,

And this is the necessary fix.

Thanks for working on this!

Thanks,
-Stolee

