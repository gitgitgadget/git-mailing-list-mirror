Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA5CC433EF
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 16:24:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241527AbiBOQYk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 11:24:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235027AbiBOQYj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 11:24:39 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE2428985
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 08:24:29 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id q7so32918504wrc.13
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 08:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CU39LJhHFTadn/ATAK+XXC1ikHdirmlwf7S71Vr9szQ=;
        b=EhaoI8xMfQA4YHhNfq98fhfhMELU6uIC7dnm0T8gvIYLTYLplTHMSDCWQRsdCrU2wZ
         HwE8KfI4Z9iu6sRBdr5UTN4BdZOVO4yoMdam6nnAjfFm5Rvgjqzls31lommv6jhqm9ze
         ht4SBbrbpXFgNxA2p1bmXdXLypDSQuXfpnr9RosSwDNaCwsbnS6u6DuPgpLayPGTNnEX
         7plaEICgWgvJf9WERhDfBs3qNXgVpdr++vGKqdiF4Tb9c8UCQ7RMrbdNTVqDIONbPZ6b
         RRmDNN/XCvQMuZV1bKGckknJr3ihTemUC1LhpJpO1AQXO/+Ze5J+lDCxRVHbpneGAJq2
         dU2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CU39LJhHFTadn/ATAK+XXC1ikHdirmlwf7S71Vr9szQ=;
        b=h+J7nACk7ozXMMQaWANpI9op3yDSKi1Dsoz3p+wjsY5nGFKSJGUpAbYA7eKbWXF5cM
         Hem0mVaR1E8IPS+a+41Gfm/G/yMKDwRuJ4YEj7grKWKAeIFEkgrye2Vd2Po0frmfCvQe
         4gH8Z21Y9hYk0XACz2sx8N8e/pspb8OeIIfY9t5Tw5c5meowaAfg8R8fbrmWhf5BMiTM
         5jQG+MoMKHT4+z7jAsqn7eIuQJiT0/Rj3jFE7ma21EgybIbJI5zl4qjumiGiaIqEq9MW
         shAsDJkiY92HSkvNVAN5G2lNoSO4uaMxnT6Y5AGbD4uNakO1/hvdqHfBJ6NL3fggfXAW
         Qtww==
X-Gm-Message-State: AOAM533DV+gAS0bV7iRMNEPrX0qDC5zk7vZK6QvADaD+oeNRYh+u+bH6
        RGnmsdiwwfo8jf1Ime6F4bc=
X-Google-Smtp-Source: ABdhPJzmnc8iIW3weyOduOPytNPmApdihBXvSRd95diM6Rz95eMmqrD3oJORb7gM/ur+9HkFKK66Og==
X-Received: by 2002:a5d:64e3:: with SMTP id g3mr3804904wri.662.1644942267827;
        Tue, 15 Feb 2022 08:24:27 -0800 (PST)
Received: from [192.168.1.240] ([31.185.185.186])
        by smtp.gmail.com with ESMTPSA id b16sm24349658wrj.26.2022.02.15.08.24.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 08:24:27 -0800 (PST)
Message-ID: <005d5f82-ae13-992a-3df9-2738f348e01e@gmail.com>
Date:   Tue, 15 Feb 2022 16:24:26 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: js/use-builtin-add-i (was Re: What's cooking in git.git (Feb 2022,
 #03; Sat, 12))
Content-Language: en-GB-large
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>
References: <xmqq5ypj6rw6.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqq5ypj6rw6.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> * js/use-builtin-add-i (2021-12-01) 2 commits
>   - add -i: default to the built-in implementation
>   - t2016: require the PERL prereq only when necessary
> 
>   "git add -i" was rewritten in C some time ago and has been in
>   testing; the reimplementation is now exposed to general public by
>   default.
> 
>   On hold.
> 
>   What's the status of the "known breakage"?
>   Are we ready to switch if we wanted to?
>   There are known breakages on macOS.
>   cf. <nycvar.QRO.7.76.6.2112021832060.63@tvgsbejvaqbjf.bet>
>   source: <pull.1087.git.1638281655.gitgitgadget@gmail.com>

[disclaimer: I don't have access to a mac so this is based on web searches]

As I understand it the breakage is that we don't handle escape sequences 
properly on macos and a key that emits an escape sequence may be 
interpreted as a different key and confuse the user. However there is no 
way to remap the keys used by "add -p" and we don't use any keys that 
emit escape sequences.

On my linux laptop the builtin "add -p" recognizes "F2" as "Q" so there 
is another bug with the escape sequence handling that is not macos 
specific (the perl version reads the escape sequence correctly).

The macos problem is caused by poll() not working with stdin as it is a 
device (see bugs in [1]). It is possible to use select() instead and 
this is what libuv does[2]. Looking at the result of "git grep 'poll('" 
we never poll more than three file descriptors so we could add a 
git_poll() function in compat/ which uses select() and add

#ifdef __APPLE__
#define poll(fds, nfds, timeout) git_poll(fds, nfds, timeout)
#endif

to git-compat-util.h

I haven't looked at what's causing the problem with "F2" being 
recognized as "Q" yet. That and the macos problem feel like fairly minor 
regressions as they only affect keys that we do not use.

Best Wishes

Phillip

[1] 
https://developer.apple.com/library/archive/documentation/System/Conceptual/ManPages_iPhoneOS/man2/poll.2.html

[2] 
https://github.com/libuv/libuv/commit/731adacad2426d349d4c51ca608184f7e01c93c6
