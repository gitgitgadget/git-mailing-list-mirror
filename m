Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B17C43217
	for <git@archiver.kernel.org>; Sat,  9 Oct 2021 11:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07D1460F94
	for <git@archiver.kernel.org>; Sat,  9 Oct 2021 11:04:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232817AbhJILGZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Oct 2021 07:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232571AbhJILGX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Oct 2021 07:06:23 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2D4C061570
        for <git@vger.kernel.org>; Sat,  9 Oct 2021 04:04:26 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id n11so7420478plf.4
        for <git@vger.kernel.org>; Sat, 09 Oct 2021 04:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=IjRgtD+yYXLVJXN4J1vUccQpmIsS6/osGeS05BpD9FE=;
        b=AgsKR46vFN4qR547med92pCyY8vLpDIJmQ69W70l4sWIjd420jx8qAB/8r65AU2w/k
         nc9dKBIU776HljxFlCH02N0gAobpfYTAwFp50sE5HCwTf3U4YJoHFyhnUd7N6SRRdW9X
         vvo9b5Fp1B7oVqvb5SRFovnrCRyELy+tIUorSVOtNrTLodkYhcXXvwj0cyMB/68FQ284
         I+Of2e8LGJbcgTHaGRXBDaPV29+bM5hF60+Mrp0wNCtfdYJPrXz+jyJlCMLmklQfyNjb
         taKGq/TruhnEU8nDF2hvPkqpBvv/y0cT/LbkwOolqDVk9zuRxWcKoKnYjBPZZumN7YT6
         8rWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IjRgtD+yYXLVJXN4J1vUccQpmIsS6/osGeS05BpD9FE=;
        b=sFBLiqmmWU63D2fLhtFXIIPKSs7qWcuLL+nHS6Cm8mlZMhnmdtFgMLtbzDhNHtsLMX
         Vvwlfjl4KmO6zBEtL4yEeRB5pqR0zrHCa5zJEPSM5AnDl2+XPIILCjXd9TB265FWrs7v
         aZlA2R5kiyArLjaw77QY+1IgpOKmQwrLPCRmOmbv/H3ZxYdryrcA4yqOmcjMAv7KyC9N
         jQr4T7ol1Atn/ed7Iq5eOWL8RBDPoPp3YQOiwwiAm7VkYecdKue8PGPv+IPYVXYaj9E7
         mOlUJbF8TSK3fBoO2z3tY5pd2ZyASvW8zZh6x0V4QWieOtvn40oUBOPiK8MweRxSFsD1
         8JMQ==
X-Gm-Message-State: AOAM532DRdZFCnjsYJsDuxmpaGan6qdKrqFRL2XY5llwkZ9jRF8kGOkJ
        NhQ2+hsr0F9HSb4U7vXz2lE=
X-Google-Smtp-Source: ABdhPJwB3dTPQ8xIfipZVni3M9P+B49GIkTgPAywumMql6SCZWJJJ8WZfJfrAhg5oBHdiOV+qwg/nQ==
X-Received: by 2002:a17:90a:86:: with SMTP id a6mr17821555pja.190.1633777465727;
        Sat, 09 Oct 2021 04:04:25 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-65.three.co.id. [180.214.232.65])
        by smtp.gmail.com with ESMTPSA id r7sm1974375pff.112.2021.10.09.04.04.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Oct 2021 04:04:25 -0700 (PDT)
Message-ID: <189cd45c-c550-8021-a1d1-b271bd4ecf57@gmail.com>
Date:   Sat, 9 Oct 2021 18:04:22 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RFC PATCH] Documentation: better document format-patch options
 in send-email
Content-Language: en-US
To:     Carlo Arenas <carenas@gmail.com>
Cc:     git@vger.kernel.org, tbperrotta@gmail.com, gitster@pobox.com,
        avarab@gmail.com
References: <20211007033652.80793-4-tbperrotta@gmail.com>
 <20211009083133.4446-1-carenas@gmail.com>
 <1d6ec04f-6f89-5da6-75a9-3099e2437df5@gmail.com>
 <CAPUEsphrNMPO_KaAmae02-DsxB9m1tBEK_Gnv29_mLQn0j2MkA@mail.gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <CAPUEsphrNMPO_KaAmae02-DsxB9m1tBEK_Gnv29_mLQn0j2MkA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/10/21 16.32, Carlo Arenas wrote:
> The synopsis shows "send-email options" are also allowed (as
> optional), the mention of "relevant options" here was to indicate
> additional options from git-format-patch which make sense (ex: common
> diff options, --root, or the options from the range section of
> references).
> 
> The truth is that you can actually do files, directories and revisions
> now, but that is a bug.
> 
> Carlo
> 

git send-email behaves similar to ln(1), depending on what options and 
arguments that are passed. See my attempted patch [1] for the wording.

[1]: 
https://lore.kernel.org/git/20210924121352.42138-1-bagasdotme@gmail.com/

For SYNOPSIS for file/directory and revision range, I suggest:

'git send-email' [<options>] <file|directory>...
'git send-email' [<send-email options>] [<format-patch options>] 
<revision range>

where <revision range> must be any forms that are accepted by 
git-format-patch(1).

-- 
An old man doll... just what I always wanted! - Clara
