Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73ABFC433EF
	for <git@archiver.kernel.org>; Mon, 25 Jul 2022 20:36:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237233AbiGYUgC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 16:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236746AbiGYUgB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 16:36:01 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC241C935
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 13:36:00 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id r70so9743248iod.10
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 13:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=VaAXBHbFat3vHxflVc9hcRs6fW+TdKPhFkFZKkUTMhk=;
        b=jbZoD5x1Eub84scKEHPkbiEOZ8jzgtE1Z84ym5nM9xZzrIAG6nDM2EVczLeXaWN1lF
         /6aWTyYgXvSlckhCdNNJDOrMNXelOG3eZmJYEifPvYJnmeQXtyHGfyBeghr2NIDnrlQR
         FHM13wiTzDa9M1qKbqOuNdcLvM7vRVJzeZ+/VI11xcLsKPiBEwkiLo5IDkMgTyk2YnCc
         GNvoq2vjXzu9rSYRkF14u1GoRGmVLxt7AGLlJ7hr7UzUMT0Say2PEBrGSyhT1KKfujXo
         qisXV/KmZ6GyJQ1RZ+bLA8QKOmAFyKW9hO+F6U32JZsUrHL6tsTk4ixoLTtoE5YxgW8Y
         az7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VaAXBHbFat3vHxflVc9hcRs6fW+TdKPhFkFZKkUTMhk=;
        b=cys3Jh/kSk9JXPXlVgqMyFZZXwYjBJ9mcjT7vsDUNfBR3+i0730z6ljFP1CwgJBEQr
         Pqc6dvNuMhxSQvEaSrJ7y+Wavo+e+IFpZAmqGoedKrG26zRC3igZ8b6DfSzssJ7tOvwN
         +dFHV8a8+HLJINlgxzg+/68iJTs8CzMHSidLzt4mQ/B60UBuY83BLmhJrT3jBqRDst35
         5VGRh0ewUukqoDOlrT4gGVB+8YxSEanLFcjOVlD/Izv9vkIQ77NcMGhADdciITrPkpta
         7EE+PLHjoYZxUFAnoXiqfX4hYFzPTmAwmbyvsgWl8PSFQ9MrQ9CVty0FAgAbTurGopoG
         jLtw==
X-Gm-Message-State: AJIora+zWKx/ltHk82N4TWK53S2y7bchTxwt68EIpAesEQ5/YR6JuDiV
        C4o6y+tK+E7uaxQ+NzBaM4i7
X-Google-Smtp-Source: AGRyM1todSze5XS+dzWA70YnqapQ7vtlS1ntfgcv7W/l4F6dII1vNhszRYRXbpIIaCp2Z0DyGdK7fA==
X-Received: by 2002:a05:6638:2714:b0:33f:6fe4:b76c with SMTP id m20-20020a056638271400b0033f6fe4b76cmr5527415jav.211.1658781360316;
        Mon, 25 Jul 2022 13:36:00 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:bd67:ba73:30ac:5f37? ([2600:1700:e72:80a0:bd67:ba73:30ac:5f37])
        by smtp.gmail.com with ESMTPSA id o17-20020a056e02115100b002dd0ba40abdsm5054430ill.18.2022.07.25.13.35.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jul 2022 13:35:59 -0700 (PDT)
Message-ID: <3c182e33-ee8e-0a1f-8915-8f97da2499e6@github.com>
Date:   Mon, 25 Jul 2022 16:35:59 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 00/10] typed sort of linked lists
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
References: <4d7cd286-398e-215c-f2bd-aa7e8207be4f@web.de>
 <xmqqk08bv0ax.fsf@gitster.g> <xmqqy1wh3tzy.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqy1wh3tzy.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/25/2022 2:52 PM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> René Scharfe <l.s.r@web.de> writes:
>> A nicely presented coherent story that results in an overall code
>> reduction.  Thanks for a pleasant read.
>>
>> Will queue.
> 
> No comments or objections from anybody?  I am planning to merge the
> topic to 'next' and to 'master' soonish.

Sorry. I had started reading it and also found it to be a
pleasant read, but did not get around to finishing it and
saying so publicly. Consider that done now.

Thanks, René!
-Stolee
