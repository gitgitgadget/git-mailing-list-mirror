Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8354E20248
	for <e@80x24.org>; Fri, 12 Apr 2019 16:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbfDLQak (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Apr 2019 12:30:40 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36732 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbfDLQaj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Apr 2019 12:30:39 -0400
Received: by mail-wm1-f66.google.com with SMTP id h18so11746741wml.1
        for <git@vger.kernel.org>; Fri, 12 Apr 2019 09:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fHgFyIwjU2MQKh8mXLPzuFDOW26Tbuu/pQK5KhJqXOM=;
        b=Hj/IbXrNk3yDzTVe43OFN6CDKymUSp5xOlOfu0zf5nhwGCFS2MTphSTSF3lr3NzmvH
         EPShSeoR+CbCBatM7eP1VZJoNOKO4SnncynrWZaQsgTSgt4Dm8GcMKJ6BLiQg0n4AZjv
         P4WuIm03fz20kdENsVnTWPQqVP7uGNBRkKKlqhF4Bb/SiHztEq70q5JC3ic7oqAMynyN
         TkXGu1tOvz7BBStSGLCd2GQCTD2cFFyddp5eRIWrFNS5FYeTweV7EIV1IbljN8WfxLd8
         2jftOUXVaNL5r5CnLlPT+s93AaSDAu0bMRq2GnHdbCZ1cgoOpftHGaM5B4aNlMsSas3L
         qMPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fHgFyIwjU2MQKh8mXLPzuFDOW26Tbuu/pQK5KhJqXOM=;
        b=n/Tnnn2YxXxNPIIfs1pKZL7TOdrPbd+7L9IBirQDVm6fMHtpJbF7jCGAaGjqAe9lz7
         3foNICJcLpYWxSOGxeI4uAJmfEmfSYqkcDYQHHzg8M1DZLN4ZXp4SZtiFS8aBNtMrpBA
         iTu6ySv2naqcU8zaAs2kBjB4iwcoIBu/aGyBgCeSXDUPW26gJHO+fqRgSqwngr3jxH/L
         ejVEXiQxtIf+DxNiTCJXCm3g5Dp0CmRJuOvvRgibMwj6vcQYFn8ZxpZz600QLCbpx1As
         sIABa7+Z9g5fsF0tBKFzgqjv9i63QiWHvHXiRd8q4kSTerYqvmHe27eAc3oH8buuNiGo
         EuDw==
X-Gm-Message-State: APjAAAU1yO5faL2SKSOIYWZtltOUUKhflshQrJ0vBpAlEt1qf7HApJ9j
        0WzFEgMhiHb/63vvQtXIZJJYbag0
X-Google-Smtp-Source: APXvYqzhtinV+6x2KU6Py8FpYQl5ol3Jc/eEky/3pY1AQA3yjgOqG4+n7qol9qhzjpJo/rUAP8SYHA==
X-Received: by 2002:a7b:c4d2:: with SMTP id g18mr11667576wmk.108.1555086637765;
        Fri, 12 Apr 2019 09:30:37 -0700 (PDT)
Received: from [192.168.2.240] (host-92-22-21-176.as13285.net. [92.22.21.176])
        by smtp.gmail.com with ESMTPSA id k9sm56637914wru.55.2019.04.12.09.30.36
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 09:30:36 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [BUG] rebase --interactive silently overwrites ignored files
To:     wh <microrffr@gmail.com>, git@vger.kernel.org
References: <CAL_tzDGRQ4BzJ4c6QypXfBXQNQYocbKbJSBOHhBBB2TwQQPCGA@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <2643a200-5356-f3bc-1715-3f34b5f19a5b@gmail.com>
Date:   Fri, 12 Apr 2019 17:30:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAL_tzDGRQ4BzJ4c6QypXfBXQNQYocbKbJSBOHhBBB2TwQQPCGA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi

On 12/04/2019 00:56, wh wrote:
> I'm using git 2.20.1 from Debian. Git is usually careful not to
> overwrite untracked files, including ignored files.

Git normally overwrites ignored files, so I think in your example rebase 
-i is working as expected, I'm surprised that the am based rebase does 
not overwrite the ignored file. There has been some discussion about 
introducing 'precious' files that are ignored but protected in the same 
way as untracked files [1].

Best Wishes

Phillip

[1] https://public-inbox.org/git/20190409102649.22115-1-pclouds@gmail.com/

  But interactive
> rebase doesn't detect this (non-interactive rebase works fine).
> 
> Reproduction:
> -----
> 
> #!/bin/sh
> mkdir upstream
> cd upstream
> git init
> echo 1 >feature-1
> git add feature-1
> git commit -m "feature 1"
> 
> cd ..
> git clone upstream local
> cd local
> # write some tools for our own convenience
> echo ours >tools
> echo /tools >>.git/info/exclude
> # start working on a feature
> git checkout -b f2
> echo wip >feature-2
> git add feature-2
> git commit -m "wip"
> 
> cd ../upstream
> # official tools are available
> echo theirs >tools
> git add tools
> git commit -m "tools"
> 
> cd ../local
> git fetch ../upstream master
> 
> # this would be okay
> #git rebase FETCH_HEAD
> 
> # problem: overwrites tools silently
> GIT_EDITOR=true git rebase -i FETCH_HEAD
> 
> cat tools
> 
> -----
> 
> Expected: `git rebase -i` fails because it would have to overwrite the
> untracked "tools" file. Contents of tools file remains `ours`.
> 
> Actual: Contents of tools file becomes `theirs`.
> 
