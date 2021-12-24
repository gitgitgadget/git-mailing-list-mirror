Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F144C433EF
	for <git@archiver.kernel.org>; Fri, 24 Dec 2021 05:14:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237445AbhLXFOL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Dec 2021 00:14:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbhLXFOL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Dec 2021 00:14:11 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6132C061401
        for <git@vger.kernel.org>; Thu, 23 Dec 2021 21:14:10 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id k64so6911128pfd.11
        for <git@vger.kernel.org>; Thu, 23 Dec 2021 21:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=KkPgbeJoqn2Mh9Mlnvdai0mKm5wtzWB8QSUL81FM/pw=;
        b=Xo+Zlj91YybLk+eU5SXg9fdWfesuXn9917UAtBH6EbCIUcmru4ZIBNcwqCGhuSfuc8
         bdZP/RrisFHiBAIFmKcmqkCscqQ8QtS062YVN7HyRa0Us1MiysE73ms4EakU/9psUcxt
         1/f7kgWH04lspwiMb4DRrJ2e84jURbD5OourMt8Fx2BxnkBFRj5OOwj8GCbYxd4bZFYh
         laS5HUm6ftdu2MDCzy6W8BFmhKQ9X2HM8DPUDhf8+f4RB6ISihZp47eCrdzgZ3EEKf+N
         mwTlrOK53I1Iz5McCP3OI22u4HlGqqQtL7nIL+tKKzeouFFgD5A4JX7Tw+en6gI2QdVQ
         859w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KkPgbeJoqn2Mh9Mlnvdai0mKm5wtzWB8QSUL81FM/pw=;
        b=N71Skt7SpmHBZfWKKPF4oYuwmntGSjCv98c/sLmpZhUrcpAZX/t5h0JOySktU9KJfB
         e5qilZqHFcOSJNd2rACcz6FJqEt617/4vcDyX6W8CzpDRLEmXCBGpjmY1ppxbV6v0h7w
         q4WKdurQCtWEn3XDha5uS0Ie8ElSFrjLOgs56WPQOV23Zo2vBF/I0xRHVVSudhWNn1WB
         ZZyTXRzbURlCSW4GQG1Wn70cifHoWT8Ce++zmF5rGyU3FA2bGQXVSPwsIng/G8iNVIrr
         /+KIf3BI1fDhU0JdUvC8IXxXuKcsoDxNLvz1CtR0qgKvVRxiMWgJaGL6gPXSldtdk0xn
         kqfg==
X-Gm-Message-State: AOAM531jq2Sl3jQvyQXc+5/dghViI8jlRX+MLFDOd3fiNaOF17tGM54U
        PqN5paaG6xf7K99s3zDGsYj7xLF9qRQ=
X-Google-Smtp-Source: ABdhPJzHxyF1c5rf5ONEnhYm5ciQ6dOvyQhJholPC+B8WV1VheOor7iKKZrvOyRgOzxjVPoyn/9CTg==
X-Received: by 2002:a63:ec4f:: with SMTP id r15mr4784553pgj.190.1640322850428;
        Thu, 23 Dec 2021 21:14:10 -0800 (PST)
Received: from [192.168.43.80] (subs28-116-206-12-33.three.co.id. [116.206.12.33])
        by smtp.gmail.com with ESMTPSA id j6sm7051243pff.33.2021.12.23.21.14.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Dec 2021 21:14:10 -0800 (PST)
Message-ID: <42bde83d-65fb-d326-ec3d-4ef4121c35dc@gmail.com>
Date:   Fri, 24 Dec 2021 12:14:05 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 1/4] t5540: require REFFILES
Content-Language: en-US
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
References: <pull.1168.git.git.1640170784.gitgitgadget@gmail.com>
 <e0d7dbf8b552381a9b7854f2bb9eff41508aac04.1640170784.git.gitgitgadget@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <e0d7dbf8b552381a9b7854f2bb9eff41508aac04.1640170784.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/12/21 17.59, Han-Wen Nienhuys via GitGitGadget wrote:
> +if test_have_prereq !REFFILES
> +then
> +	skip_all='skipping test; dumb HTTP protocol not supported with reftable.'
> +	test_done
> +fi
> +

Did you mean reftable doesn't support dumb HTTP protocol or vice versa?

-- 
An old man doll... just what I always wanted! - Clara
