Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B379FC433F5
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 12:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BB5D61184
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 12:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbhKCMtV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Nov 2021 08:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbhKCMtU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Nov 2021 08:49:20 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D747BC061714
        for <git@vger.kernel.org>; Wed,  3 Nov 2021 05:46:43 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id t30so3355760wra.10
        for <git@vger.kernel.org>; Wed, 03 Nov 2021 05:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=FAx+eoLfDqmLVg99l575I6JCdZZRhNabBBSgwFGEu7Y=;
        b=G0UDcD1EEEPU7XEftYDyMSA1+etL+1esmjFL4k6msaFoH80ifoosMHDPgR02OzraNk
         m6ZDm3QAZBPyY3WcqayIUadW073bb+h6Ukb7t7/AWeXSbZqM3Kj41YpWxrij15fcivn4
         9oZsxQmhRzD5msDCS6unvGbPwXq5zGAVET91zTCDAPaFYHaNdhV2ah3ATgml/wWPIXEz
         61Uq+ghyOkcPDemFskf3HoWpKuIXuRZdldWEPtxYP76o9J+RgcBvmqJUSIR8t5fD7mC/
         bs7mgxpeQQGnbqpl/j6Yi6L2qQx+w4sMs5s9F25aAYglW41qQA3b7XvKCk9x+Vam4Al9
         GnFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=FAx+eoLfDqmLVg99l575I6JCdZZRhNabBBSgwFGEu7Y=;
        b=ZEbDu9PqCp36ql778SckTYORt7kUskJyl0MkXfUGy31EPoNsx+Yo/4kXUJwgK31IWd
         oMQ26+TsEYnETfQHAa+Ygef+73r7NExAed9o7zn5yB/O6OGfTthKY6WTSx97e+2r1dUs
         KsJSNPGYVxj6Pz8+6h7eQbBy3VpTe8395/+msLfF3qMATCYS74KEuD07a6EKTEmQDJWS
         6xEMdzQ5txHI2h7dxPgI62H8tICIF8jYaYXkgjJ1c/EaUyf7x2LoS8UAlEun3Ay0gQ6X
         7D0a+vZ+SHJgTO9fDjft0y0MTH4fvv1ksLQGm36bMtwrHF6KXqjt5dipZphgYHusuw7R
         WuoQ==
X-Gm-Message-State: AOAM532RmKA3emql839D8T9DRJZxx+klrz0ZDWOOQFjg2dKLl9u1zA+u
        KBoYUKiqtXyMq/6xG3/iElY=
X-Google-Smtp-Source: ABdhPJzwJbxv0LnsV492tA+rPvYNN9yk2hVmkpVg5Zdu3nxoARpHMWR+w6os1iW9AyEUb41ZLeb5mA==
X-Received: by 2002:a05:6000:10cb:: with SMTP id b11mr43840539wrx.71.1635943602310;
        Wed, 03 Nov 2021 05:46:42 -0700 (PDT)
Received: from [192.168.3.156] ([92.173.128.58])
        by smtp.googlemail.com with ESMTPSA id s26sm116698wmc.0.2021.11.03.05.46.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Nov 2021 05:46:41 -0700 (PDT)
Subject: Re: [PATCH v2 4/9] doc: use only hyphens as word separators in
 placeholders
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jean-No=c3=abl_AVILA?= <jn.avila@free.fr>
Cc:     =?UTF-8?Q?Jean-No=c3=abl_Avila_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        Eli Schwartz <eschwartz@archlinux.org>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <pull.1066.git.1635261072531.gitgitgadget@gmail.com>
 <984b6d687a2e779c775de6ea80536afe6ecc0aaf.1635438124.git.gitgitgadget@gmail.com>
 <ee376004-a4dd-539d-28b3-3fc5baa6fe00@archlinux.org>
 <2803948.JoDkH9avOM@cayenne> <xmqqmtmocqz4.fsf@gitster.g>
From:   =?UTF-8?Q?Jean-No=c3=abl_Avila?= <avila.jn@gmail.com>
Message-ID: <0b404448-cd4b-8614-2c49-c4683b56879f@gmail.com>
Date:   Wed, 3 Nov 2021 13:46:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <xmqqmtmocqz4.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: fr
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Jean-Noël AVILA <jn.avila@free.fr> writes:
>
>> The choices here may be awkward; no problem to propose even more descriptive 
>> names.
>>
>>>   Similarly "the 'format:<format-string>' format" feels highly
>>>   redundant, I expect the reader knows that <string> contains a format
>>>   inside it as it's mentioned immediately before *and* after.
>>>
>> The fact that it is a string doesn't tell you much about what you can do with 
>> it. For me, this isn't a problem that the explanation is redundant.
> I agree that --format:<string> is quite poor, as type alone does not
> give readers any information on what it means and how it is supposed
> to look like.  Calling it <format-string> does make quite a lot of
> sense.
>
> It is a bit less obvious how much value we get out of <bool-value>,
> though.  In --opt=<arg> scheme of things, what comes after '=' are
> all <value>s, so <bool-value> does not clarify over <bool> like the
> way <format-string> clarifies over <string>.
>
Agreed. Should reroll the patch series?

