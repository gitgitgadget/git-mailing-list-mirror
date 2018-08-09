Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E039F1F405
	for <e@80x24.org>; Thu,  9 Aug 2018 21:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbeHIX1J (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 19:27:09 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36654 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727166AbeHIX1I (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Aug 2018 19:27:08 -0400
Received: by mail-wm0-f67.google.com with SMTP id w24-v6so1657703wmc.1
        for <git@vger.kernel.org>; Thu, 09 Aug 2018 14:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=HEJneJbtGkY8yEIinFSkAQzqJRLK7PHCRgx4hvizTQM=;
        b=IPNCwDGW14e4tquBIdUPWG1+TbMX6bsLf+z4AYeQSwmifUHU2fC1apqluay1/k2IcF
         tjSA3A1qitmFsriA3yRQYsgt9RB6q6nSfWEuERowl5C4ZmaOFS73mPst6A/dNb8xabFr
         aes/BMPDkvXnXHKmY1xuf4FW9fwmCiMm7kE3/uB4OLqh6+HzsQPk39pb6tUTvf0EMIrs
         sQ7X186ypdk9KJtq2O3+hZ6IqNe7e559tZiGoOzdwjcQSbANHFd3j0IuqIJ9lMt5tM47
         67hBJSMu3sov3VKvtE2kehUBJVMKmet99Ctgpq7S2boKsP4hEVRMGF4Hs6NRw69vZ+jv
         /oUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=HEJneJbtGkY8yEIinFSkAQzqJRLK7PHCRgx4hvizTQM=;
        b=lb/dp5ORHQwWwOAx8mbu3nMFSBy8OoYdvpc28zYrU//tEOhOuiez4VuC3rEhr1zLOl
         P6Vkbq0blGQH5TYaCqpUW2t8CyPnX7u/sh6w3l7Bc8KShmlMZH/KkHavXrGCrtTXkh9p
         Tk/vNyccOEvPXXUQugcDEDlMFv2hzlK4Lxs2MnTEqytnVnkFDjdeHbWdWXgWIS6B9McR
         Vct83PBu9usRFZsKOi+sDdue2niLN1d2QOGBK//iBRVbCcaCfHONHdPi7LPavo+O4i8q
         wvrkLceFRFhOnsORXcaA+oI+WZFSx7uoVcldRHPYnMekBtMb4wPgQFPl1oFV5rP4jWwd
         9hyg==
X-Gm-Message-State: AOUpUlFBfnXMzhAfw3EKsDNl2iLpogWPqZWTpn8w6c/dbOKd8DhWofCL
        Dgrcm4Rcr+YIRyUspaltI5W3cxsC
X-Google-Smtp-Source: AA+uWPw+iVw1rq527dn/Tf2NjcpViDEIgozSNOnISh7tZtml53wRY8lIcXRuy+pSMTlad9ZOKf/3hQ==
X-Received: by 2002:a1c:1c54:: with SMTP id c81-v6mr2466136wmc.147.1533848432492;
        Thu, 09 Aug 2018 14:00:32 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id m207-v6sm12596511wma.31.2018.08.09.14.00.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 14:00:31 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [GSoC][PATCH v7 05/26] stash: convert apply to builtin
References: <cover.1533753605.git.ungureanupaulsebastian@gmail.com>
        <7ba9a8515d445d10af36a8a79071af51b90f5aef.1533753605.git.ungureanupaulsebastian@gmail.com>
        <xmqqa7pwfw84.fsf@gitster-ct.c.googlers.com>
        <1ba17df0-e6da-3358-622b-c19092c20eb0@gmail.com>
Date:   Thu, 09 Aug 2018 14:00:31 -0700
In-Reply-To: <1ba17df0-e6da-3358-622b-c19092c20eb0@gmail.com> (Paul-Sebastian
        Ungureanu's message of "Thu, 9 Aug 2018 23:01:09 +0300")
Message-ID: <xmqqftznb6hc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com> writes:

>> Good to see that the right way to forward a patch from another
>> person is used, but is this a GSoC project?
>
> Yes, it is. I forgot to add the [GSoC] tag in the last series of patches.

The reason I asked was because IIRC GSoC was not supposed to be team
effort but "summer job" by individual students.
