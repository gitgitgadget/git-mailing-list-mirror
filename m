Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD39ECAAD8
	for <git@archiver.kernel.org>; Tue, 13 Sep 2022 23:11:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiIMXLF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Sep 2022 19:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiIMXLE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2022 19:11:04 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0C470E43
        for <git@vger.kernel.org>; Tue, 13 Sep 2022 16:11:02 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id c4so10937577iof.3
        for <git@vger.kernel.org>; Tue, 13 Sep 2022 16:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=MRu5ro1RRIYbq0McBKI8b6JtnuNNQMSAwr/z5r6oCAc=;
        b=LItv3P02YSSzyqOU0a3FB0kgyzXsLTL24es8izXKNQEQAlfhvp5Wxpzsq1LgmIoKfy
         dAJYkpEzkJfyEG0M2MwYR6FiuKCj7nn7MO9InU7Y0XrsEMK116z0eljFn3OWGag9UmBw
         0D8z7d88hfOdGfEN+XtcTHo/iHFqtedo1savJuVzYCgNuhsMFz8sGjTzmHNR1f1YhpSI
         yrWNgWOPyKzdbvip8bCX5xkqsQDEzIstVHQ5xKFwU73XBgkZ3Imv8urFTOIe6sEq7OeZ
         paiNlRiJBwWbGZykHki89siH65tiTnDHkkGOITMfBKg+2x5bxMTsrt9yXg37s93d2ZoH
         oaMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=MRu5ro1RRIYbq0McBKI8b6JtnuNNQMSAwr/z5r6oCAc=;
        b=7RDlkdYoVaVglprnk/ORnH1bWt15ri7Ya5cGrLgNeYKtlE5T63Q4C+YYIRvqG/q/TH
         VXNc8w6P+CJzP2S396mfB8vJCnK1lPMKuMK9QwlO4a5oKGq0Gufr4xUCe6C1ffanZGBL
         mUxa9oMIp3BPmx6Lk+SN0iOkaIHy/USQlcbJr3nrQR9HDzV2N55T5OddJ0G8j6nGaMPy
         YvjH8LjpEPe2gW+DV/95ow1mZjB38751BV5mKundEsSY8uXNzzF2sqCG2it17dZvuAjL
         ohXmGm+78Y2PVs4mBiGrvsri6QfK/1hsLgREvDR/Qyj12sGTPBNBDfYvx+UuIOo7EsBK
         /DKw==
X-Gm-Message-State: ACgBeo183W/KC6fSytfgFe8Ri3ahysppuB25VBpMvNgjLI3tN0FG2096
        mAm0/U3fGGXE5mlJtX0iLbYO
X-Google-Smtp-Source: AA6agR67sxKq1XK6/0bkEYuU3IUAia6XY9nw47NinJo3iU61YHwUyAnyMuiHzI86wWSW/SewhVl7yQ==
X-Received: by 2002:a02:cc53:0:b0:35a:1885:92d2 with SMTP id i19-20020a02cc53000000b0035a188592d2mr8883029jaq.242.1663110662014;
        Tue, 13 Sep 2022 16:11:02 -0700 (PDT)
Received: from [10.71.3.213] ([12.148.187.67])
        by smtp.gmail.com with ESMTPSA id q16-20020a056e02079000b002eb75fb01dbsm5718867ils.28.2022.09.13.16.11.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Sep 2022 16:11:01 -0700 (PDT)
Message-ID: <5685773e-db83-6b92-ff42-0d51e6e6a22e@github.com>
Date:   Tue, 13 Sep 2022 18:11:00 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH] Documentation: add ReviewingGuidelines
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com,
        Johannes.Schindelin@gmx.de, steadmon@google.com,
        chooglen@google.com
References: <pull.1348.git.1662747205235.gitgitgadget@gmail.com>
 <xmqqr10f88jm.fsf@gitster.g>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <xmqqr10f88jm.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Victoria Dye <vdye@github.com>
>>
>> Add a reviewing guidelines document including advice and common terminology
>> used in Git mailing list reviews. The document is included in the
>> 'TECH_DOCS' list in order to include it in Git's published documentation.
>>
>> Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>> Helped-by: Derrick Stolee <derrickstolee@github.com>
>> Signed-off-by: Victoria Dye <vdye@github.com>
>> ---
> 
> I've commented on the text but haven't seen anybody else reviewing.
> No interest?  Everybody silently happy?

My guess is that there aren't as many eyes on this as there might typically
be because of Git Merge. In any case, I plan to re-roll based on your
feedback [1] (ideally) by the end of the week if other reviews aren't sent
in the meantime. 

I'm hoping there's a bit more interest after Git Merge. With reviewing being
such an integral part of contribution to Git, I'm really interested in
hearing people's thoughts on what should/shouldn't be in this document.

[1] https://lore.kernel.org/git/xmqqwnacibbm.fsf@gitster.g/
