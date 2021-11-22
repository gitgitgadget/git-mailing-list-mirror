Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA90C433EF
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 21:43:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233703AbhKVVrE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 16:47:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbhKVVrC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 16:47:02 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38CDFC061574
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 13:43:55 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 133so16886047wme.0
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 13:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=JHe/oVud/qxIqh6EiHr+HrGQtAFfvbsp7UWFLPBXU/w=;
        b=NKtqBtV/JjGOt1tYbsaeDjPW9si1qJlFG/Xv1zTKSXzM65lrGr99Hj2xpbnizf1ZJ6
         eu0hB8VK0MVKsqG5w1EWGtE6WvNegcrxpXCvASXsvhYjQvCb5i5z810jtCjMkmB4wIRw
         RAIHNNXwfIYfzhHzRd9SWjRaBtqWvEdjW+qIsXRyJUltOTD1qH/kd+d3PXetVPsCZ+QT
         ZqCmtqBvye6mWBk8qQ1BuYu1gdONR+FkombEWRH4cJtYfOnATO3MMCzhI1wcPdSfMUhX
         QuAQ/x0U62oq67BpDEYBoIlQcNjYCRjarYsxLPbfUJ5IGqsnv9VygDCVkg1HGXpzlicv
         mH7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=JHe/oVud/qxIqh6EiHr+HrGQtAFfvbsp7UWFLPBXU/w=;
        b=4w5ZdAmjC6V5Cf1MUBpf2uBTFknQY3T6rBPVbcnu73SYdwUykHKYUk1pMeg9tBE/us
         xtXi3hQn+gY6gxwj9hOw3+s62MITdzcRUILVmafzMEl0qmoZDLGhfhU9BLjWz5XIzrN8
         +Eu1xp/fiUBt4n5EW1sJfyBQscZGOOXTQ6+oW0Qkrl94ED2ArVS85ePmezYFSYr88xwY
         V2vkAKs+SdST+WS3AlI6hHMwbhgObKwBsm7e1zrrOC0+wQ1S0V+PQI3e6FXG8YuaRIAC
         3TvryqQOXfMhc13pfBu+jErv/IpoH/Lfd2UU7n5YhfvJgWfWhKpayock2RTS9ta+Q9W1
         Bffg==
X-Gm-Message-State: AOAM533fR+AaU0I41RfYV1WgcRNOqeTR3ZNP5Et2KQy0EyXAl1eT5vKv
        eqSa+1LaohMaVvtFujh6REE=
X-Google-Smtp-Source: ABdhPJz8Xn8i1aKQ9gUAs/utvZJdLPv/Yjjme88rl97DpwyYagMGuK8Z0TK0UAfGAhxDoVk99j4oyA==
X-Received: by 2002:a1c:f414:: with SMTP id z20mr392196wma.17.1637617433851;
        Mon, 22 Nov 2021 13:43:53 -0800 (PST)
Received: from [192.168.1.240] ([31.185.185.186])
        by smtp.gmail.com with ESMTPSA id s13sm23404155wmc.47.2021.11.22.13.43.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Nov 2021 13:43:53 -0800 (PST)
Message-ID: <04ab7301-ea34-476c-eae4-4044fef74b91@gmail.com>
Date:   Mon, 22 Nov 2021 21:43:51 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Update to Git 2.34.0 breaks application
Content-Language: en-GB-large
To:     Alexander Veit <alexander.veit@gmx.net>, git@vger.kernel.org
Cc:     thomas.wolf@paranor.ch,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>
References: <ee302c98-da27-da43-e684-c7ec8b225360@gmx.net>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <ee302c98-da27-da43-e684-c7ec8b225360@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alex

Thanks for the report

On 22/11/2021 08:42, Alexander Veit wrote:
> After an update from Git 2.25.1 to 2.34.0 the Java application that uses 
> the Eclipse JGit library freezes.
> 
> Strace suggests that the JVM receives a SIGTTOU from the child process 
> "git config --system --edit" created with java.lang.ProcessBuilder.
> 
> Upstream[1] has identified 3d411afa[2] as the possible commit that 
> introduced the problem.
> 
> The problem does not occur on all Linux systems.

I think the problem is possibly that git is calling tcsetattr() from a 
background process group[1]. A possible fix would be to call tcgetpgrp() 
after opening /dev/tty to see if git is in the foreground process group.

Best Wishes

Phillip

[1] https://www.man7.org/linux/man-pages/man3/tcsetattr.3p.html

> -Alex
> 
> Environment:
> OS: Linux Mint 20
> Kernel: 5.4.0-90-generic
> Git 2.34.0 from http://ppa.launchpad.net/git-core/ppa/ubuntu
> Java: OpenJDK 64-Bit Server VM AdoptOpenJDK (build 11.0.10+9, mixed mode)
> 
> 
> Ref.:
> [1] https://bugs.eclipse.org/bugs/show_bug.cgi?id=577358
> [2] 
> https://github.com/git/git/commit/3d411afabc9a96f41d47c07d6af6edda3d29ec92#diff-01b59b6a71e42b9c1251ffbf76a1119b965be087a78538e80e01f9239c8e5880 
> 
