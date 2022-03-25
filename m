Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EBE5C433F5
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 13:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352767AbiCYNVU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 09:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244397AbiCYNVT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 09:21:19 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70976BF02F
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 06:19:45 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-de48295467so8105939fac.2
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 06:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=vS/LpvGadpTwN1MRWY+A+PivZVlef2lUKgfhJi9x6A0=;
        b=Xwzpka6FD7xOCUQfIUwZv1wVO4BdW8V4UYhkrJYilzZo7q1vDiZRqAu4gqnen0T3kL
         Qy9JKlG46JJz6asxEd7A77k2yi8F58wWC5r/b5htJisSSKQ3nSJrLUe9WTxW5TmS9t1A
         bv3yVAS+lhSfHeTVqWh6Vn1/sBsS9WcXOiKp9dyJBY3qF5UsD8L/228Ds7kZQ5bkSVXV
         wY6945AoRwZikt7idhOSsL/+9xA6S9oJEKXzktCwHe+Gewikc4Cd8BGxJpf6NZpLp9Ho
         IbNSGYzqLqJbp2xwsJgaooxr9Q9wxr6SmvuDnN7N9zisB3OZBlrX272Yyv7vToeA8Fkz
         L4Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vS/LpvGadpTwN1MRWY+A+PivZVlef2lUKgfhJi9x6A0=;
        b=6jbqjem/R0T6zjgbRNAxceL7Own/GqrPBDS5FOjw82rCWHgK0IlwmpEAVuz2z0f+jb
         ZsAlRi+4Y2WrqDXDNqMzxTqqKXuT6mFtkzwmM00IR4qYru8ER7XW/3ZSjwPW8ZPlRZV4
         +rhZsVIfoZtufD8Ec6wk4sqwa/yUSEqLaMvGJHjG1J0n/bcf8fOlcekb55WJzFPwHc7u
         V4RBHILR2Bv4GFLtNxciIlJKP3IcpxC4jOX5ufvrahDBPVUXBvBqsKHpxsMGnZ7YMChb
         4nrVWeu/n12AeM6CFgQqG5M8LdBCo5y2PL4ZLsnY3dUXwlWlTuBzufumNais+Q3hua6b
         FgJA==
X-Gm-Message-State: AOAM531dynjisMgdRppfb+hfJr+8Em4pzSH9H3VL2B+Gpu7Xl6MjGyPC
        42XashBG6NpUnpEL/yL3HW3j
X-Google-Smtp-Source: ABdhPJzWjlSCd+Vugco82X46BjnQdmuF1nj67KBKCIBTkJYXyy7q9m2t8G6s6uvoIYVuaH/6wouHmw==
X-Received: by 2002:a05:6870:1614:b0:dd:cd0e:d84d with SMTP id b20-20020a056870161400b000ddcd0ed84dmr4765419oae.2.1648214384498;
        Fri, 25 Mar 2022 06:19:44 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id g25-20020a544f99000000b002da70c710b8sm2754284oiy.54.2022.03.25.06.19.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 06:19:44 -0700 (PDT)
Message-ID: <f6afa542-cd97-2af9-a07f-6c2a3721a200@github.com>
Date:   Fri, 25 Mar 2022 09:19:42 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: contrib/vscode/: debugging with vscode and gdb
Content-Language: en-US
To:     Jonathan Bressat <git.jonathan.bressat@gmail.com>,
        git@vger.kernel.org
Cc:     Cogoni Guillaume <cogoni.guillaume@gmail.com>,
        matthieu.moy@univ-lyon1.fr
References: <CANteD_wDSRmwLQiYV1x133WEtVaRK__c584E3CbXN1tPOquitg@mail.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <CANteD_wDSRmwLQiYV1x133WEtVaRK__c584E3CbXN1tPOquitg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/24/2022 4:16 AM, Jonathan Bressat wrote:
> Hello
> In contrib/vscode/ the script init.sh create launch.json with the
> option "external console" to true but actually this option make gdb
> didn't work so we passed to false and then it works.
> Is there any reasons why it is set to true, do we not use this properly ?
> Then would it be nice to correct it in contrib/vscode and to talk
> about it in that doc : https://git-scm.com/docs/MyFirstContribution ?

Hi Jonathan and Guillaume,

I use VS Code to work on Git (using Remote SSH from a Windows machine
to a Linux machine) but I've always used command-line gdb for debugging.

However, your request here got me interested. I confirmed that running
the debugger from the VS Code UI did not show any output or show that
a breakpoint was hit. Performing the update you recommend made the
debuggin UI populate with all the necessary info (stack trace, variables,
showing the breakpoint line in the editor).

Here is a patch that makes the change as you suggest. I tried to research
the setting appropriately, so please let me know if there is anything you
think is incorrect here.

Thanks,
-Stolee

--- >8 ---

From b053b797cf8585d2b0212cd2576fe05c2d1a5432 Mon Sep 17 00:00:00 2001
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
allows the VS Code debugger to work with Git. I verified that the
debugger did not work by default but now does with this change.

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
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 contrib/vscode/init.sh  |  2 +-
 t/test-lib-functions.sh | 34 ----------------------------------
 2 files changed, 1 insertion(+), 35 deletions(-)

diff --git a/contrib/vscode/init.sh b/contrib/vscode/init.sh
index 27de94994b5..0b7ebc12668 100755
--- a/contrib/vscode/init.sh
+++ b/contrib/vscode/init.sh
@@ -271,7 +271,7 @@ cat >.vscode/launch.json.new <<EOF ||
             "stopAtEntry": false,
             "cwd": "\${workspaceFolder}",
             "environment": [],
-            "externalConsole": true,
+            "externalConsole": false,
             "MIMode": "gdb",
             "miDebuggerPath": "$GDBPATH",
             "setupCommands": [
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 8f0e5da8727..2501fc5706f 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1788,40 +1788,6 @@ test_subcommand () {
 	fi
 }
 
-# Check that the given command was invoked as part of the
-# trace2-format trace on stdin, but without an exact set of
-# arguments.
-#
-#	test_subcommand [!] <command> <args>... < <trace>
-#
-# For example, to look for an invocation of "git pack-objects"
-# with the "--honor-pack-keep" argument, use
-#
-#	GIT_TRACE2_EVENT=event.log git repack ... &&
-#	test_subcommand git pack-objects --honor-pack-keep <event.log
-#
-# If the first parameter passed is !, this instead checks that
-# the given command was not called.
-#
-test_subcommand_inexact () {
-	local negate=
-	if test "$1" = "!"
-	then
-		negate=t
-		shift
-	fi
-
-	local expr=$(printf '"%s",' "$@")
-	expr="${expr%,}.*"
-
-	if test -n "$negate"
-	then
-		! grep "\"event\":\"child_start\".*\[$expr\]"
-	else
-		grep "\"event\":\"child_start\".*\[$expr\]"
-	fi
-}
-
 # Check that the given command was invoked as part of the
 # trace2-format trace on stdin.
 #
-- 
2.35.1.138.gfc5de29e9e6

