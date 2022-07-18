Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70A51C433EF
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 12:18:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234838AbiGRMSU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 08:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234093AbiGRMST (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 08:18:19 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD4C248C1
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 05:18:16 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id v28so6955509qkg.13
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 05:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=2I2y8ivk4hPgsepxefi4pc6uo83WjGhD8Zx1/6PyB0Q=;
        b=A7noS0cNFm74uG6HwQTMXVwtKihuchFRkYqtClrH7X5zXPgR4AJ4OQNn34FMFycp+0
         3aeMkYlOE/SBOtWINkfhoJHprjxBDB2DyRnoh8+7juQtBRMju2UisAbEQSrcCmuiPmjo
         NmTHySUPs2EOzginT4GHfrmKpkJlU7QHApSJBk2lzY92BhoHnIVc8ygHVKnwH6bzThSo
         WKY2+hBG20gJHVkz8rhGQJu9Eeq/Rd+HNk9Hf6B8xHBB9UwGuUOpNl4Xb+iYeLC5Zvj1
         n7FkSJvKbIhjUv++jXHnwU3tJlChVLC/Efs+hfP570ndbMwk9VRtzvnRzindMmhHW/YZ
         ahdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2I2y8ivk4hPgsepxefi4pc6uo83WjGhD8Zx1/6PyB0Q=;
        b=M4kwLuVu+5K1tsq+sZkWO92wCHAgkaqzMiAbwHF9KBnrL4aHm54TEX+VPB+6K0gwkp
         eq5k8qrGbKyW4aCse1ouDki2y6VX4Cj6W8QfYAY6RSnqwFWoHK51Pk9QQLNPsX9BLlFa
         MctGXTieh93h0hG3GpZi4yNrKLCBPuGln8zaWPRjH4RNByjfObJSWwnPPXPofyc1myr7
         7JgNAzv8sM0abtgx857eNlhqOnwkvCoo3tvSrmRjwi6Pm48q/selg7dguRQ9/Q+dorUe
         jDvW8HobP4BUa00tKhlPL5SoRGc5RydXqqC+VGjGVZazjGuuBVeVuKMU4pJOFlQDT58g
         yRog==
X-Gm-Message-State: AJIora/ABRUyGaYrzUJGz29Sp04AQfw2hvEPo9h3rkkZDNEFJHcHVW86
        fqIKqS6Okn9PDyVdbtug6F9q3lXaI5C5
X-Google-Smtp-Source: AGRyM1tq3O1MLIYI8p6thWbZYTHL95+dWm32C+Sr5zEvcbIKTBmW8JpVq3QY0Z1YzM/riOET8lWRGw==
X-Received: by 2002:a05:620a:269a:b0:6b5:b76c:11c9 with SMTP id c26-20020a05620a269a00b006b5b76c11c9mr16768127qkp.100.1658146695698;
        Mon, 18 Jul 2022 05:18:15 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:841f:e099:cbef:4067? ([2600:1700:e72:80a0:841f:e099:cbef:4067])
        by smtp.gmail.com with ESMTPSA id e17-20020ac84911000000b0031eaabd2117sm8708109qtq.12.2022.07.18.05.18.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 05:18:15 -0700 (PDT)
Message-ID: <9c909270-cbd5-0356-0418-4b2d3e105c93@github.com>
Date:   Mon, 18 Jul 2022 08:18:14 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: Can I use CRoaring library in Git?
Content-Language: en-US
To:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>,
        =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
References: <CAPOJW5x4McofC5fxBvsRAzum28wmeDJCMTMRmY_0oy=32JjKqQ@mail.gmail.com>
 <CAPOJW5wVYcmTA6kpf=kGEofziq1RLCg2haCMrye=EXaPLzb7Tw@mail.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <CAPOJW5wVYcmTA6kpf=kGEofziq1RLCg2haCMrye=EXaPLzb7Tw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/18/22 7:48 AM, Abhradeep Chakraborty wrote:
> I just got to know that CRoaring doesn't support Big Endian systems (till now) -
> 
> https://groups.google.com/g/roaring-bitmaps/c/CzLmIRnYlps
> 
> What do you think about this?

Git cares enough about compatibility that that might be a
deal-breaker for taking the code as-is. If we _did_ take it
as-is, then we would need to not make it available on such
machines using compiler macros.

Thanks,
-Stolee
