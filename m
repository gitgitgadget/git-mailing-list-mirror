Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B025BC433EF
	for <git@archiver.kernel.org>; Tue, 12 Apr 2022 17:52:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245399AbiDLRyj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Apr 2022 13:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358560AbiDLRyi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Apr 2022 13:54:38 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D445DA2A
        for <git@vger.kernel.org>; Tue, 12 Apr 2022 10:52:18 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id g11so13259571qke.1
        for <git@vger.kernel.org>; Tue, 12 Apr 2022 10:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=WsuNQXYQPAMSWHv+gR6BFTHjWDMUOtvfKWEAD1TP7gI=;
        b=ZHF0bXEE3knM7Qf5CCVTmB82Oo0hTa9LzJH/8oXELOP2C1WSELYCpFhbuniHQZM176
         7yNO7vTIqkVTcyikG7krbqRIuQCV/1ahXM1b00EQBXOeTrgjWk+t0UOMT4OGGURiBV5H
         VKlHhYIxDwqKrMWkFtABmK6ltoNMM2+hBSiOaVAwuNL2D4xOfaylLf6uO70pvJZo2/4/
         hGy1W7YRD+MnTDHbRIahsLpGqk3z+LCk4VRs1J5VhXIQjGgRcD0uyUQ+vBojAY0SJpjA
         dBoNZKBuLh+Y3Qvd9oxMB7yidPlMD98IkD1n3z9gRWzrccsaLhoKvWxtB4lNuZDfD9JD
         w0Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WsuNQXYQPAMSWHv+gR6BFTHjWDMUOtvfKWEAD1TP7gI=;
        b=04IgAdNcSWO6h8bSGRowm9b6LqNsDzDpXwVt5+KqjPRJ6+l09p8EwGrgmG6+ZnkzgY
         F2vEMjECLEkYp6LeYvfrz7gnz7KhGGl3LMdEM0PwzcRHmsSarKddsLqVAwkSkCj2Fmq6
         SOSKSgefbrzyWWAvFPYQwej5ZW66Eps1r7mDJfdZBu2GfduYQOrzNFpjefoiExSxTzN+
         doH0onglfozNdKAy1z0PDXDXEanDGCqQfp/bh1CNI4ntXdWfdopajv+K3KL3eEFJwJD6
         i6OUb4gD8VGlwcpEkUhueCejf5MsuQ76ZP+hpRsUj8dRaas++RzbzuL7YjGpWyiGPZvw
         6+vA==
X-Gm-Message-State: AOAM531F8kosJU3ozi/x0/XHtTG/3F76XhwYFtEzlnPMspssCmF/Cj78
        4ew/bwx3Ku+dsopw+Q5t0KE=
X-Google-Smtp-Source: ABdhPJwWmSaJpuxzMjPfap0pd3XIqw5cRt1JX9xSOURRb6g2OzFBPsTB3+hKw0KKa+0h/MOF3fFXCw==
X-Received: by 2002:a05:620a:bcb:b0:67d:1b1c:a988 with SMTP id s11-20020a05620a0bcb00b0067d1b1ca988mr3973268qki.587.1649785938073;
        Tue, 12 Apr 2022 10:52:18 -0700 (PDT)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id i18-20020ac85c12000000b002eea9d556c9sm4927881qti.20.2022.04.12.10.52.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 10:52:17 -0700 (PDT)
Subject: Re: What's cooking in git.git (Apr 2022, #03; Tue, 12)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <xmqq8rsab5do.fsf@gitster.g>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <8698e468-5552-77a3-10c7-933affd98832@gmail.com>
Date:   Tue, 12 Apr 2022 13:52:16 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqq8rsab5do.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Le 2022-04-12 à 13:04, Junio C Hamano a écrit :
> 
> 
> Security releases for the 2.30-2.35 maintenance tracks have been
> tagged to address CVE-2022-24765, which allows a user to trick other
> users into running a command of their choice easily on multi-user
> machines with a shared "mob" directory.  The fix has been also
> merged to Git 2.36-rc2 and to all integration branches.
> 

This is quite a big behaviour change for some environments [1], so I would think maybe it
deserves to be fully spelled out in the release notes for 2.36.0,
instead of just referring readers to the release notes for the maintenance
release, where they can read a full description only in the release notes
for 2.30.3 ?

Thanks,
Philippe.

[1] the commit message for the change mentions "shared directories", 
but in some environments, it is quite common for each user to have
read access to other uers's home directories. I'm mostly thinking about
high performance computing clusters, which is the kind of systems I have 
experience with. This makes it really easy for local
"git experts" to 'cd' into a colleague's repo and help them when they 
are facing a Git problem. The fact that it won't be possible to do that
without manually invoking 'git config --add safe.directory $PWD' beforehand
is a little sad... What were the arguments for specifically disabling
'git -c safe.directory' for this fix ?
