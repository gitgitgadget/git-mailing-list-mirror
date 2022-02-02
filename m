Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B75C433EF
	for <git@archiver.kernel.org>; Wed,  2 Feb 2022 16:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345746AbiBBQF1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Feb 2022 11:05:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345786AbiBBQFW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Feb 2022 11:05:22 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E26C06174A
        for <git@vger.kernel.org>; Wed,  2 Feb 2022 08:05:13 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id c192so15633432wma.4
        for <git@vger.kernel.org>; Wed, 02 Feb 2022 08:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=oN7OhmOWC0CngAuJ8/UPEc35WO8UjB6SUxTdHbldhBk=;
        b=WQWFreHVYGhUKtGr6bLubrmg4oBRLRN5vkNPlK027IZ8rsyFDb0ur/yAm6XB+PcCNt
         fUpq3zOSY/hotKxHfnlZm+gPUBgq4vBi9Wm3/2AiyO55+Ax15nkDvP0+exTwdECwED+x
         ciYvj87vUYZQ0hBk+9tJ3CQ4HdLEJFCzIP4z6p4kFHkcM9kvF3xzuhdLvjoK4ThRvEld
         icm27kXNks0HSm7c0hyhbBVirX6fUSs03MLKcGU31Rb/Cxxaac3sgesuasBdGacQqwPe
         OxlNSbUcITWSAEhzEHUB6nIDUG4x0oH6LlPTHSFHOgsIkcSCaDtP81Dr7qnVwGe1jrVG
         iWew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oN7OhmOWC0CngAuJ8/UPEc35WO8UjB6SUxTdHbldhBk=;
        b=CHC7Mvx7DqnE3TrVw50pz8Q2Uac0iBJiHWELYnEwaXYdXALjHpccpx7ZYmuGTg3rw1
         kjOYZ1fHWpo5zRcntvSjrhVKqhcfCMXg+lXT4q0vQV+0PSc6y9MbZ+HuC9ser9yUWZ9d
         vb/M7Z/IRytMo+EuPfv/EiTdS1K9qCrqInnF0RT7zjhS3U+bWPlrZOK2NP+92zZofVvy
         QrYV9BG4hoyQr1asM3CStbTUAoPizk57Rzp9SEwyJO1opot5RnaWIli/Py8TnZ7zy89w
         w0AmQrsEMIVD/ElkHCUqNTlyAfznTHWYj0vpY95/1j+8tJph3u2AyxPpI3x//x1Ti9ar
         MGRw==
X-Gm-Message-State: AOAM533ogp1COA25Gi7EuhFDaeLQ2NtVZ48YCxDvmkm2JcIlGyeFWQrY
        gotXLZCqFDWfU4D/1y2pREc=
X-Google-Smtp-Source: ABdhPJxhJFQx59KHpxrK7Zrkj613opF2j9I8eB976ldK3CcumKdPPUOKXB1d9XE7HymzPXaQ/NeZOw==
X-Received: by 2002:a05:600c:687:: with SMTP id a7mr6878864wmn.104.1643817911887;
        Wed, 02 Feb 2022 08:05:11 -0800 (PST)
Received: from [192.168.3.156] ([92.173.128.58])
        by smtp.googlemail.com with ESMTPSA id r2sm20870419wrz.76.2022.02.02.08.05.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Feb 2022 08:05:11 -0800 (PST)
Message-ID: <29731fdd-ca0c-a3f6-84c7-7429ccef5673@gmail.com>
Date:   Wed, 2 Feb 2022 17:05:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 1/4] i18n: factorize more 'incompatible options'
 messages
Content-Language: fr
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jean-No=c3=abl_Avila_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?Jean-No=c3=abl_Avila?= <jn.avila@free.fr>
References: <pull.1123.v3.git.1643580113.gitgitgadget@gmail.com>
 <pull.1123.v4.git.1643666870.gitgitgadget@gmail.com>
 <2eac2ef502b86d0c15513c8d0e69928ce2140b1f.1643666870.git.gitgitgadget@gmail.com>
 <xmqqv8xzh6iw.fsf@gitster.g>
From:   =?UTF-8?Q?Jean-No=c3=abl_Avila?= <avila.jn@gmail.com>
In-Reply-To: <xmqqv8xzh6iw.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le 31/01/2022 à 23:41, Junio C Hamano a écrit :
> "Jean-Noël Avila via GitGitGadget"  <gitgitgadget@gmail.com> writes:
>
>> +inline void die_for_incompatible_opt3(int opt1, const char *opt1_name,
>> +				      int opt2, const char *opt2_name,
>> +				      int opt3, const char *opt3_name)
>> +{
>> +	die_for_incompatible_opt4(opt1, opt1_name,
>> +				  opt2, opt2_name,
>> +				  opt3, opt3_name,
>> +				  0, "");
>> +}
> I haven't seen a non-static inline function defined in a common
> header files.  Does this actually work?  In my build, ld choked on
> this one.


This is quite subtle: "inline" is just a hint to the compiler but the

compiler can choose not to inline, so there must be an external symbol

to link to (which is not the case with this code).


My tests and the CI builds went smoothly, so I guess all these compilers

luckily chose to inline, but not yours.


With "static", we ensure that either it is inlined or there is a static

function (in which case, this bit of code will be duplicated across

compilation units).



