Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F2ADC433F5
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 03:55:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235915AbiA0DzS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 22:55:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235900AbiA0DzP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 22:55:15 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6835AC06161C
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 19:55:15 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id h14so1425542plf.1
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 19:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=oqWu7eZpBX5ox1Xps0Lrbk2UWh9wLepI7Ngg3xLcNJw=;
        b=DvmThlBtUh8oYkWt1zjOn6I+r8lhQ+FVz70NqFDh+7yjMES2xe/+OeVfvgTzvDLTGE
         F/E0EVN0w9f962AMwAbYEm4uOtOs2P8j/K/gEH/s1zvB4OMQpKN2vm6WZKO95kFIAuUH
         2tc4cKL7r6N6KcPpRsd0jM9IR+uNZkHEchgrmN9HEwxzxRruwSTQK8en8dQCnOcplQ+N
         FxaEPs5IZrm9+wIkAt/P0QOpSGSirvZ8GdFSeyjbdT5Jwqwg42FnABdtlf32NEbce4MM
         x+CBitBHO9kk5879BKojQPWsxrX44wtW2+vu1jJdRGyAdiClAcLWrjR9ktQn1A9H7DTs
         gSUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oqWu7eZpBX5ox1Xps0Lrbk2UWh9wLepI7Ngg3xLcNJw=;
        b=mPx3czdPhJPnFJYf1DCi40QTLG0nkQ0nv45IJnjGInouOxCl8m//OzsbJMziG2t64T
         9s/2otqSIKxOPQJuKGorviMBDpR94XzcdeNl2kwNYAWF7il5leFQ/bj8eP8qXCvHs1/R
         Kzhs2rzmVLSRSTr8+bis9O93NLpaIAZwYs9drLqlX6f3A6ieVNUg43mpRlGsd6yOnvPb
         XiPU//p81PsO1x6fVnllRxCcn6wXOi+E11if/v1HiwFVissC2I3AUNtDuO0mgge173xg
         zQCWI+MioToVnF8yfFgrPkUtBAR7+qRqrBv9wOmKHNoIwf+Vyf6v9XO2jmJUyHmCSESP
         Wy6g==
X-Gm-Message-State: AOAM530ovpFOomJntOS6S0Mj4/pLqibCeYd278wzvLl15GYtiWLlzUTY
        71eu18wj8su+gWrpdqP/l+E=
X-Google-Smtp-Source: ABdhPJyAEajoP05XrFgoMeKXCQbXpAb9QGoTIpXoM4ncV/5RzlaQagBzyOkYJSi0RJgc2O373A7tlQ==
X-Received: by 2002:a17:90a:b90b:: with SMTP id p11mr2180459pjr.189.1643255714817;
        Wed, 26 Jan 2022 19:55:14 -0800 (PST)
Received: from [192.168.43.80] (subs02-180-214-232-13.three.co.id. [180.214.232.13])
        by smtp.gmail.com with ESMTPSA id a14sm3809887pfv.212.2022.01.26.19.55.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jan 2022 19:55:14 -0800 (PST)
Message-ID: <9d2e58ab-2d8f-0797-84ed-0c1e8941edaa@gmail.com>
Date:   Thu, 27 Jan 2022 10:55:08 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Git in GSoC 2022?
Content-Language: en-US
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Git Community <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
References: <439ebfba-d493-2cff-434a-b1073e755688@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <439ebfba-d493-2cff-434a-b1073e755688@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27/01/22 01.29, Kaartic Sivaraam wrote:
>    - Project ideas: There are two mentioned in SoC-2021-Ideas[3]
>      but both were picked by GSoC students the previous year. So,
>      we would need new ones this year.

I have several project ideas:

   - Document the "binary diff" format. Right now we have documentation
     for all diff formats used in Git, except for binary diff. Hint:
     read `diff.c`
   - Rewrite `git-request-pull.sh` in C. Currently the shell script
     implementation hard-codes message template and only outputs to
     stdout (though can be redirected to a file using shell means).
     In the C version, message template can be configured (with the
     default is same as current version) and introduces new
     `-o/--output` option to specify output file.
  
-- 
An old man doll... just what I always wanted! - Clara
