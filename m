Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51893C433EF
	for <git@archiver.kernel.org>; Sat,  2 Oct 2021 02:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CDE861AF8
	for <git@archiver.kernel.org>; Sat,  2 Oct 2021 02:35:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbhJBChD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 22:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbhJBChC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 22:37:02 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0450C061775
        for <git@vger.kernel.org>; Fri,  1 Oct 2021 19:35:17 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id rj12-20020a17090b3e8c00b0019f88e44d85so1621699pjb.4
        for <git@vger.kernel.org>; Fri, 01 Oct 2021 19:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JWDyWGCM59XhmH4x0NKnjiMTSZD9d+gD8C+sGiLRdsg=;
        b=KhDfiXkdAtkVBKgDRefq6WdKbyfFy4qwGM44k4u2muRw9SQggF9+uRssvyneuedvJX
         2TOd7GOvrrNgjl9eSUjiqKtXeEIwbdV6XeMi1UWsi3YVwZcIImzp0IllIAcpepIyPI0A
         T/tzlpZWRjFlrMVBujJIZCZD6h3Kpm1KZvvUH3WqroHE0UvWTK8i37qWu3NEGNamd9Xu
         UX/2sumub2TxTQHbOgoNLYam2zxwX/tJg/NKON5SL6wQtgMpCaZAjum5yVXVtONNEhdc
         fE4CNEv0ReaRPq8aLr5S8e05uHREC5BqlWusWCb1sbuhjpydolG2nowPiA8lEcsOxFPM
         bYIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JWDyWGCM59XhmH4x0NKnjiMTSZD9d+gD8C+sGiLRdsg=;
        b=7kWjU6gq+BFq7u6yfibQJ2aE8I9byi3G+4m2HrakFAte+spxN+GUgT+8G5xmQqWYK0
         Ldts7aQHoYyYT+oCC7ZYZDFQfqjouVLylKnMNVXxKS97QbamUPZ9qaAkFjmHu04fa+uq
         Tuz84MANrS+/c4Da0Xc3MVpQfmUDa9WuGwMywfdF8GWhrgBzDs1i54+T+LAmqOfqUBP4
         TmesFZmHDEd1gVclHCDoBihpPb2Ar7wXcDI0qsoCU5K8mFf+NWuRcwbTMN/t9XH685iJ
         BQkFc3Gt2nq+l5CnwoJ1MOKLmkReRVRY+mxMrgo82HEDRujI6ZP/DKW+g3MQ168zhHOP
         uznw==
X-Gm-Message-State: AOAM533asy6AjlsP89jkJi6AU2JBTn4HUngpNyd1TSX86t5R91sgvcbU
        uC3mSi6lERixpXn8FNIy7mA=
X-Google-Smtp-Source: ABdhPJwB9Jlz+SLxN6GZewHZ54KD8GrB4H0UJkKHf98vlpv9TV6nidKOh793TQGNXMeu25atN5sXZQ==
X-Received: by 2002:a17:90a:5b0d:: with SMTP id o13mr23824140pji.117.1633142116988;
        Fri, 01 Oct 2021 19:35:16 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-94.three.co.id. [180.214.232.94])
        by smtp.gmail.com with ESMTPSA id p17sm7752718pfo.9.2021.10.01.19.35.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Oct 2021 19:35:16 -0700 (PDT)
Subject: Re: [PATCH v3 2/2] blame: document --color-* options
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        "Dr . Matthias St . Pierre" <m.st.pierre@ncp-e.com>
References: <20211001113725.13354-1-bagasdotme@gmail.com>
 <20211001113725.13354-3-bagasdotme@gmail.com>
 <CAPig+cSWutBRQK+Qy=nkaDZRvy4trVNPuo+cF-quC2rBwNe2fw@mail.gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <e70942cd-8362-b8d0-f168-01f6c190fb0b@gmail.com>
Date:   Sat, 2 Oct 2021 09:35:12 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cSWutBRQK+Qy=nkaDZRvy4trVNPuo+cF-quC2rBwNe2fw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/10/21 02.10, Eric Sunshine wrote:
>> +       config option. Only the line annotation (see "The Default Format" section)
>> +       is colored.
> 
> You can drop the last sentence entirely if you start the blurb like this:
> 
>      Color line annotations differently, if...
> 
>> +--color-by-age::
>> +       Color lines depending on the age of the line. The `color.blame.highlightRecent`
>> +       config option controls what color is used for which range of age. Only the
>> +       line annotation (see "The Default Format" section) is colored.
> 
> Ditto about dropping the last sentence.
> 
>      Color line annotations depending upon the age of the line.
> 

I observed that both --color-lines and --color-by-age only apply to 
default blame format, so the wording can be `Color line annotations ... 
if neither --porcelain nor --incremental option is specified ...`

-- 
An old man doll... just what I always wanted! - Clara
