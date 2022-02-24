Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C774DC433EF
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 16:32:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbiBXQca (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 11:32:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiBXQc2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 11:32:28 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D835C4C408
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 08:31:49 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id w7so3369038ioj.5
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 08:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=6cdjocw7EblhwxF7z9satAf/hRPt3j0sxjkeQN1zX5w=;
        b=UfQMeiX00ewEzMtjGVCpovox9pQHdA4Wb0aAmn4oqqtFfTmLNihJlEkCcs8Dc8E4/o
         pRqtSFnY6dBuyL9JHN574w+Q+DLaSBnPalP+a1a6JhoRPxYTCNRbk91R1giwrQNfGWJ6
         78ZpCsd0HX/SAwcVm8pp1+fnSuxtH97PnKyY7kT9fYbel59h9CyHiQJEHuzxNRo6o+Ab
         GTGjem6DFQSuTluSvnAXJJ+OvmcXzfKOeQ49yvyenEENzNbOiralK19Jua2kVgRH+e/q
         0YkLOZdrQJX7Zmgbp/uSJW6NcrwvxDYRck7vjBv4fZX4JT2Ugmbb53qFDmuJcxkJCmAu
         IxxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6cdjocw7EblhwxF7z9satAf/hRPt3j0sxjkeQN1zX5w=;
        b=30sT4Dyo/L/AI0O/OY+gtm6Xsz0JNJqaEZYcFI7DXapZu7xs6vixevptXL1KprMNRm
         VmlmAjWJ7MVZnSKMYM90Fak3V4w/67/sQLoeLymWopou4Bq0hVeNU1fBJGFHbyyfB1LK
         Yj/c8AH2ppMl9nF4btjZST1yRxnJJ4Rm2wkmskeEkWMbB2oJBGBb/V5KEAKIwcYqJwMf
         mZHaMKsxQ9yd4L+Q4ZGcwQ24ek9hWod3jAsmHXOKGOrHJfzwlVA7DyKkakPKgwguva02
         hsKgY0tTPwnKu2wmJXuqCmdUsa45c58dddfI5sRWdE+UhtGSTSYp6oCgx13HHG0qDoMP
         rMRw==
X-Gm-Message-State: AOAM531wMSkLcEgR91w6lMjXANZrUJRdoYVVBK4RtKUEO6iKDP8/2nMf
        oBarjOiu7hisq8wC0lVEJXyVbQuLcJfM
X-Google-Smtp-Source: ABdhPJxMFL4PKAA3430ygONACiKPGxmtTL+Tfikb4GdwGHH+RxqH6mhVEFbYJZixsbNzkmqAxT+3HA==
X-Received: by 2002:ac8:7fcd:0:b0:2dd:2294:fa5d with SMTP id b13-20020ac87fcd000000b002dd2294fa5dmr3090049qtk.350.1645719712226;
        Thu, 24 Feb 2022 08:21:52 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id g202-20020a379dd3000000b0064932a7b992sm9294qke.98.2022.02.24.08.21.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 08:21:51 -0800 (PST)
Message-ID: <e3c0a046-8041-421d-6640-91d1a560f79b@github.com>
Date:   Thu, 24 Feb 2022 11:21:50 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 00/23] Builtin FSMonitor Part 3
Content-Language: en-US
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/15/2022 10:59 AM, Jeff Hostetler via GitGitGadget wrote:
> Here is part 3 of my builtin FSMonitor series.
> 
> Part 3 builds upon part 2 (jh/builtin-fsmonitor-part2) which is currently in
> "seen", so this series should be considered a preview until part 2 moves to
> "next". (And part 2 should not graduate to "master" without this part.)
> 
> Part 2 established the client code (used by commands like git status) and an
> MVP implementation of the FSMonitor daemon. This was sufficient to test the
> concepts and basic functionality.
> 
> Part 3 finishes the daemon and adds additional tests. This includes:
> 
>  * On Windows, handle short- and long-name aliasing.
>  * On Mac, handle Unicode aliasing.
>  * Mark bare, virtual, and remote working directories incompatible with
>    FSMonitor.
>  * On Mac, ignore xattr change FSEvents.
>  * On Windows, cd out of the working directory root.
>  * Create a thread to monitor the health and shutdown the daemon if
>    necessary.
>  * Speed up handling of directory notification events.
>  * Test directory move and rename events.
>  * Add performance test.

I had been more involved in early versions of parts 1 and 2, but was
not paying attention much as these updates for part 3 were coming into
git-for-windows/git and microsoft/git. (I do recall some of the support
issues that motivated them.)

Since these have been battle-tested in the wild for a while, I do not
doubt that they are solving the user needs they intend to solve.

Instead, I focused on looking at the patches for anything that might
be abnormal. The layout of the code is clear enough that I can easily
see how information from the platform-specific code is being handled,
so I do not worry about corner cases being an issue from the Git side
of the code. As for the platform-specific stuff, maybe there are cases
that are missed that require deep expertise in those platform calls. I
cannot speak to that until we get a user report of something even
stranger happening than the special cases targeted here.

With that said, I mostly found superficial things to improve the
series. Some typos, some rename possibilities, things like that.
 
> Here is performance data from t/perf/p7527-builtin-fsmonitor.sh on a
> synthetic repo containing 1M files on a Macbook Pro. It shows the effects of
> the untracked cache (uc) and FSMonitor (fsm) on git status.
> 
> $ ./p7527-builtin-fsmonitor.sh 
> # passed all 67 test(s)
> 1..67
> Test                                                                 this tree         
> ---------------------------------------------------------------------------------------
> 7527.4: [uc false][fsm false] status after checkout                  29.99(3.14+80.12) 
> 7527.6: [uc false][fsm false] status after big change                73.32(5.11+97.24) 
> 7527.8: [uc false][fsm false] status after add all                   47.80(5.12+90.47) 
> 7527.10: [uc false][fsm false] status after add dot                  49.22(5.16+92.05) 
> 7527.12: [uc false][fsm false] status after commit                   51.53(3.35+100.74)
> 7527.14: [uc false][fsm false] status after reset hard               33.74(3.03+85.31) 
> 7527.16: [uc false][fsm false] status after create untracked files   41.71(3.24+89.75) 
> 7527.18: [uc false][fsm false] status after clean                    34.33(3.07+89.36) 
> 
> 7527.20: [uc false][fsm true] status after checkout                  29.23(1.94+10.84) 
> 7527.22: [uc false][fsm true] status after big change                64.23(4.66+24.86) 
> 7527.24: [uc false][fsm true] status after add all                   45.45(4.37+18.70) 
> 7527.26: [uc false][fsm true] status after add dot                   44.42(4.02+17.10) 
> 7527.28: [uc false][fsm true] status after commit                    30.52(1.95+10.91) 
> 7527.30: [uc false][fsm true] status after reset hard                28.70(2.70+13.89) 
> 7527.32: [uc false][fsm true] status after create untracked files    28.63(2.59+10.71) 
> 7527.34: [uc false][fsm true] status after clean                     28.97(2.59+10.78) 
> 
> 7527.36: [uc true][fsm false] status after checkout                  35.06(3.17+86.11) 
> 7527.38: [uc true][fsm false] status after big change                74.65(5.14+101.50)
> 7527.40: [uc true][fsm false] status after add all                   49.96(5.22+90.96) 
> 7527.42: [uc true][fsm false] status after add dot                   49.77(5.24+91.72) 
> 7527.44: [uc true][fsm false] status after commit                    36.95(3.27+92.25) 
> 7527.46: [uc true][fsm false] status after reset hard                33.89(3.18+85.68) 
> 7527.48: [uc true][fsm false] status after create untracked files    41.44(3.40+92.99) 
> 7527.50: [uc true][fsm false] status after clean                     34.60(3.26+90.19) 
> 
> 7527.52: [uc true][fsm true] status after checkout                    0.58(0.45+0.10)   
> 7527.54: [uc true][fsm true] status after big change                 65.16(4.91+25.64) 
> 7527.56: [uc true][fsm true] status after add all                    45.43(4.45+18.92) 
> 7527.58: [uc true][fsm true] status after add dot                    15.56(2.57+6.32)  
> 7527.60: [uc true][fsm true] status after commit                      0.98(0.46+0.11)   
> 7527.62: [uc true][fsm true] status after reset hard                 30.30(2.96+14.49) 
> 7527.64: [uc true][fsm true] status after create untracked files      2.15(1.73+0.40)   
> 7527.66: [uc true][fsm true] status after clean                       1.68(1.56+0.32)   

The other stylistic thing is this performance test. It would be nice if
these tests were grouped by the operation (like "status after checkout")
so it is easier to compare the same operation across the matrix definitions.

This would require reordering the test definition as well as allowing the
different cases to simultaneously live in different repositories. The
p2000-sparse-operations.sh has this kind of organization, but you'll need
more involved test cases than "run this command".

Thanks,
-Stolee
