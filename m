Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE16C433F5
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 19:26:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbiCYT2H (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 15:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiCYT1r (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 15:27:47 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2093A1E7A43
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:01:12 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id j83so9143925oih.6
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=nWTceHPsH4uJAa62aaFOLBKnie/QHCXB5f2giQ5IVYI=;
        b=QgNgcGoA2oJF9IZ/vAig7S45v/yePe3D91Vcb3+79z9N+8x967Cetj/qMlkGY5UN2b
         kXwcdyFz0zMtwdCMg0C3JdV1FrUVah9NpiG+Ykv31TpS9XPMRP4g3oSOERO5H06VOBCp
         Zemr8PUWACGHy9C1mxncYwaK9lo7J3nUn8MPYH9lI+j/EzZsubcEgACbno1XLVmoqLLL
         eTZRc7eNVf4V1UnkeKA5nf9oeh/8/tnZ9IIE4kvXb+7M9uMrMrBnAkFpvUsUO/er3uTY
         OHTKaBW8gah8w2S+RGRwN30xwWpqS5BnLjO0JYcNnGOKESQItoRdJ/Ib4ao3PpW6NfME
         MDdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nWTceHPsH4uJAa62aaFOLBKnie/QHCXB5f2giQ5IVYI=;
        b=tiyQzh80F7VN+kBlMlM9uxTZC8YziQmHI3L7dX8usg//GdLXpARTkk7CSYjRE/O5ZF
         OLNJauh6jkNlAphCUMmJyva0t4jeDRxk3MjKCI/etPaeGqkq+Z/OwdtiZy3GX/PfmBPM
         UhxXskOf4ngDm7YSFGvIkmt3kUOZSG7k7wr6p+FjOX6iQWszYasLz1swpCDE8OIWasGf
         nAcXQy3Jba0S2Au1CYLAKOh1V7nI0CzzN7xCuiW0iGM95VMMR7IfFXLROgwy3LKjy/az
         Cr+kGLg7LTkzUXMS49xewu+gHhyeupxP9dL8FL2jWAUpaWeRjckE3U44sD5May/FqsUt
         3Sxw==
X-Gm-Message-State: AOAM5329xlABBHnfz6KiCECSQ1vD8xVDHs1KYp2chQg37/Jeqb9wD1wp
        f8hCPulR12FjbmZeatS0vZZL
X-Google-Smtp-Source: ABdhPJwBp+sHa962NBmZdwSnxYdz04Uq5+CMnEh3Xd8G0gZ11YOeSLn/BJxucZp9We3MSocVfLgEWQ==
X-Received: by 2002:a05:6808:4d2:b0:2ee:f75b:41d9 with SMTP id a18-20020a05680804d200b002eef75b41d9mr5987592oie.20.1648234871422;
        Fri, 25 Mar 2022 12:01:11 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id j4-20020a9d7384000000b005b23499b66dsm3028921otk.23.2022.03.25.12.01.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 12:01:11 -0700 (PDT)
Message-ID: <c1f255d7-6637-b6ac-0a64-1f64404a6f6c@github.com>
Date:   Fri, 25 Mar 2022 15:01:10 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: contrib/vscode/: debugging with vscode and gdb
Content-Language: en-US
To:     Matthieu Moy <Matthieu.Moy@univ-lyon1.fr>,
        Jonathan Bressat <git.jonathan.bressat@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Cc:     Cogoni Guillaume <cogoni.guillaume@gmail.com>
References: <CANteD_wDSRmwLQiYV1x133WEtVaRK__c584E3CbXN1tPOquitg@mail.gmail.com>
 <2a7eecb4a0b247ef8f855f1c4fb5d510@SAMBXP02.univ-lyon1.fr>
 <7a522ccc-0a45-47fa-509c-a7a8b159041d@univ-lyon1.fr>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <7a522ccc-0a45-47fa-509c-a7a8b159041d@univ-lyon1.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/25/2022 2:27 PM, Matthieu Moy wrote:
> On 3/25/22 14:19, Derrick Stolee wrote:
> 
>> Jonathan and Guillame reported that flipping this setting to "false"
>> allows the VS Code debugger to work with Git. I verified that the
>> debugger did not work by default but now does with this change.
> 
> FYI, I got the same problem, and I can reproduce the issue on a hello world program, so "externalConsole": true, is broken at least for me regardless of the Git codebase.
> 
> I couldn't understand what exactly the option was supposed to do. If I understand correctly, it should launch another window to show the git program output, but I don't know which window actually (xterm? x-terminal-emulator? a terminal program that isn't installed on my system?).
> 
>>   contrib/vscode/init.sh  |  2 +-
>>   t/test-lib-functions.sh | 34 ----------------------------------
> 
> I guess the test-lib-functions.sh part is a leftover from another work?

Whoops! Yes I was in the wrong worktree.

>> -            "externalConsole": true,
>> +            "externalConsole": false,
> I'd actually remove the line completely, to mean "let VSCode decide what to do", i.e. either VSCode's default, or the user's configuration ("launch" section in settings.json, see e.g. https://code.visualstudio.com/docs/getstarted/settings ). If some user has a non-broken externalConsole: true VSCode and likes this behavior, then the best place to configure it is in a user-wide config file IHMO.

I confirmed that deleting the line works just fine.

Here's a better patch without the bogus extra changes.

--- >8 ---

From 8d8ac565a9c6631a509f301e7719692bd781f8d2 Mon Sep 17 00:00:00 2001
From: Derrick Stolee <derrickstolee@github.com>
Date: Fri, 25 Mar 2022 09:07:11 -0400
Subject: [PATCH] contrib/vscode: fix interaction with UI debugger

The contrib/vscode/init.sh script helps Git developers using Visual
Studio Code to hook up the proper settings to work on Git using the UI
features of that editor environment. This should include the debugger
integration, but that is currently broken.

One thing this script does is create a .vscode/launch.json file, which
provides the information for how VS Code should launch the built
executable. This defaults to the Git executable at the root of the
repository (with no arguments). Among the initial settings, the
"externalConsole" setting is set to "true". This has been the case since
the script was created in 54c06c6013 (contrib: add a script to
initialize VS Code configuration, 2018-07-30).

Jonathan and Guillame reported that flipping this setting to "false"
allows the VS Code debugger to work with Git. Matthieu pointed out that
this is the default, so we can leave it out of the file completely and
let a user modify that themselves if they want. I validated that both
the "false" setting and removing the line both work.

The VS Code reference [1] mentions that this setting is only used when
debugging, so should not affect the "Run Without Debugging" feature.
Other than making the UI debugger work, this will also change the Git
output to appear in the "Debug Console" tab instead of a new window.

[1] https://code.visualstudio.com/docs/cpp/launch-json-reference

In cases such as using the Remote SSH capability, this setting is
necessary to have any success executing Git via the "Run" menu, since
the external console is not visible at all from the VS Code window.

Reported-by: Jonathan Bressat <git.jonathan.bressat@gmail.com>
Reported-by: Cogoni Guillaume <cogoni.guillaume@gmail.com>
Helped-by: Matthieu Moy <Matthieu.Moy@univ-lyon1.fr>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 contrib/vscode/init.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/contrib/vscode/init.sh b/contrib/vscode/init.sh
index 27de94994b5..f139fd86444 100755
--- a/contrib/vscode/init.sh
+++ b/contrib/vscode/init.sh
@@ -271,7 +271,6 @@ cat >.vscode/launch.json.new <<EOF ||
             "stopAtEntry": false,
             "cwd": "\${workspaceFolder}",
             "environment": [],
-            "externalConsole": true,
             "MIMode": "gdb",
             "miDebuggerPath": "$GDBPATH",
             "setupCommands": [
-- 
2.35.1.138.gfc5de29e9e6


