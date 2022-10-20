Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90445C433FE
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 20:32:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbiJTUcl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 16:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiJTUcj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 16:32:39 -0400
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0351FB79B
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 13:32:38 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id ot12so2418896ejb.1
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 13:32:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dm/lvvYNQqwKr/aJnhvaFsqbas26dm4zRsStpydk3wI=;
        b=psUwRTI3gabXSLBa6lexql2+HxThyiAWVTHQbPizb3PG+hD5jGmuw0FjIrZy0e2vgR
         ppP7psoHmOWQklZGW6Xd+4UCBqY2BisX4hZdVNEbRSnMnOBGzEDaQrl4t0FJ8vXo89+5
         +Y9YGtPg+RMKcsbVKvzXlaNz5RjxD6UJbkOJCS73chEAoPPODbRnCNanx+U+hkQSB4nc
         jiAHQjbnUWDuWz3IzSD9vc3mki4vWMactrMKN8stIyV+/5vpS8phq8fRvodBANQhcUo1
         8rnIVTfogyo318tlJpahbWxx5rw293yL8usi2UHxmAD/qq9tkrB3MGYFY+OY63PXr64g
         IIiw==
X-Gm-Message-State: ACrzQf0sMqdpYtcjmuP6h1Z5SeWold/6SVH4zQKHH1zOluucyLuoo+Id
        kn3/Fa7Ebewqdk4Qdg7QkQm97R8uuGK2s/3B0hPMDCf1
X-Google-Smtp-Source: AMsMyM5ynsDAGXZBr0gOqdcJJMSeBrFt4k2+4sQED76khFaIzy2adTmakMcJ680fQAO/nuX6KhwGnVdx4OISbVTZY0I=
X-Received: by 2002:a17:906:6791:b0:78d:4051:fcf0 with SMTP id
 q17-20020a170906679100b0078d4051fcf0mr12352145ejp.591.1666297956825; Thu, 20
 Oct 2022 13:32:36 -0700 (PDT)
MIME-Version: 1.0
References: <5E2E10BE-6EEB-4C78-A489-5899400DA937@gmail.com>
 <CA+JQ7M-NA9UYafMurb9MAo5bp6djdzRP7ChAbdmzU+nmrkXTNw@mail.gmail.com> <DB5611E0-6B1C-4711-BB9F-72F6E8F39506@gmail.com>
In-Reply-To: <DB5611E0-6B1C-4711-BB9F-72F6E8F39506@gmail.com>
From:   Erik Cervin Edin <erik@cervined.in>
Date:   Thu, 20 Oct 2022 22:31:58 +0200
Message-ID: <CA+JQ7M92x03FPWM6qWjG=FYPxCYs8xcC_HRWLnkwj4iqA9KK=w@mail.gmail.com>
Subject: Re: Cloning remotely under git for Windows not working
To:     "W. Ekkehard Blanz" <ekkehard.blanz@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 20, 2022, 8:16 PM W. Ekkehard Blanz
<ekkehard.blanz@gmail.com> wrote:
> Here is the output from running it with GIT_TRACE=1 (which I had to do under Cygwin, since this won't work in a DOS shell, but I am still using native git from Windows - did not install it in Cygwin to keep things consistent):
>
>     $ GIT_TRACE=1 git clone 10.0.7.181:D:\\gitDepot\\test.git
>     19:04:23.917439 exec-cmd.c:237          trace: resolved executable dir: D:/Applications/Git/mingw64/bin
>     19:04:23.917439 git.c:460               trace: built-in: git clone '10.0.7.181:D:\gitDepot\test.git'
>     Cloning into 'test'...
>     19:04:23.948681 run-command.c:655       trace: run_command: unset GIT_DIR; GIT_PROTOCOL=version=2 ssh -o SendEnv=GIT_PROTOCOL 10.0.7.181 'git-upload-pack '\''D:\gitDepot\test.git'\'''
>     username@10.0.7.181's password:
>     fatal: ''D:\gitDepot\test.git'' does not appear to be a git repository
>     fatal: Could not read from remote repository.
>
>     Please make sure you have the correct access rights
>     and the repository exists.
>
> What I got from this is to use double backslashes to get the path right (I had tried this before though), but unfortunately, the result is still the same.

Maybe try forward slash, it's valid in both unix and windows and
sometimes plays nicer

> I will try the power shell workaround once I am back from my doctor's appointment.  Is that on the local or the remote machine or both?

on the remote
