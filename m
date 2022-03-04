Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4540EC433EF
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 00:07:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbiCDAIX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 19:08:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbiCDAIW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 19:08:22 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002F210AA
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 16:07:34 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id m11-20020a17090a7f8b00b001beef6143a8so6498914pjl.4
        for <git@vger.kernel.org>; Thu, 03 Mar 2022 16:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=B6CQ+CBs02Ocf20ka3eYKu6i0l7K1AlMOIGvDsMNIuI=;
        b=j35BBnztQhUWaj/62cWSOMCVTM924VPtIJuS48PEYZnaapZHJrjyGqZS1nt/n0vrjp
         zwlb3dbZYd5YtvVlK6aR1faopDpOFlIhSAmjqfTvEG1vf7nW+xlNBXGlI1U7xAa0/cgK
         aKNDoLGEo2encNg+D900L3IC53pRBI2LLVKlih8M7U7kMfozW9ArKIKK/yXhynYKlvOj
         ahE7veVSxOBeN6sIia53DRMHfcyylwnLJwzWdS6Zxp7xCQZh/u0CktEZZb/4HJa5yham
         u8xPwOt4Ae1zN5+IuB/bKqjT9mtW4ll8tZ/MlEl6OjiGuXktbAqLzd61OiLwNEHjbR47
         FFIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B6CQ+CBs02Ocf20ka3eYKu6i0l7K1AlMOIGvDsMNIuI=;
        b=WPbqe7Mk82I0Yr2xy/pXj4t5vD4FlYVpl5+EQ81pvV/vMXVz5IMkgfk5Xa9CDqYt34
         q4Vt/RaI6XTK55RDCEauVA58ZQZxNJEDt/QRVM+FEg0OrayOCFph0lETRdY2EQFJ3OKw
         ezv5Y0CqUhoH7B2rVM1n9ekTGsqDdLuROfs01F5dZzvdv++JQydWNAdhsNuKi35yUuV5
         FiCmFDSVY/WdalGd4LkI8Fbx1RiXRPmZsANqdNyxv3zfwWoTV2rXDV6CRmC8MGoD50Vj
         9hL3RJmJwfWPifMjpglnHFcdFkEwu9N3qOyML7J5jLPD62SEIxFkKCYYhEx0wp+rg7WX
         8kCw==
X-Gm-Message-State: AOAM532TowozwAOlM+JTousRznIX1l0DxSSBQqX7sqW8BE6YUUYZv1Qt
        qZPhNz87FW5QK2g/nFRaR9nmRg==
X-Google-Smtp-Source: ABdhPJxYaja5M79bNeUgWdnmRhVYcqdbLVUC9IjQM5t/A8GO6fGKyThRmjiWW/wFZmETvbHI433tfQ==
X-Received: by 2002:a17:90a:560a:b0:1bc:72e7:3c13 with SMTP id r10-20020a17090a560a00b001bc72e73c13mr7838471pjf.246.1646352454185;
        Thu, 03 Mar 2022 16:07:34 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:90ea:410e:eb0e:7f23])
        by smtp.gmail.com with ESMTPSA id 63-20020a630942000000b00372a99c1821sm2942063pgj.21.2022.03.03.16.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 16:07:33 -0800 (PST)
Date:   Thu, 3 Mar 2022 16:07:28 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 2/3] CodingGuidelines: hint why we value clearly
 written log messages
Message-ID: <YiFYQBWBVq/HQULM@google.com>
References: <20220126234205.2923388-1-gitster@pobox.com>
 <20220127190259.2470753-3-gitster@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127190259.2470753-3-gitster@pobox.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 27, 2022 at 11:02:58AM -0800, Junio C Hamano wrote:
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/CodingGuidelines | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
> index 0e27b5395d..c37c43186e 100644
> --- a/Documentation/CodingGuidelines
> +++ b/Documentation/CodingGuidelines
> @@ -26,6 +26,13 @@ code.  For Git in general, a few rough rules are:
>     go and fix it up."
>     Cf. http://lkml.iu.edu/hypermail/linux/kernel/1001.3/01069.html
>  
> + - Log messages to explain your changes are as important as the
> +   changes themselves.  Clearly written code and in-code comments
> +   explain how the code works and what is assumed from the surrounding
> +   context.  The log messages explain what the changes wanted to
> +   achieve and why the changes were necessary (more on this in the
> +   accompanying SubmittingPatches document).
> +

One thing not listed here, that I often hope to find from the commit
message (and don't), is "why we did it this way instead of <other way>".
I am not sure how to phrase it in this document, though. Maybe:

  The log messages explain what the changes wanted to achieve, any
  decisions that were made between alternative approaches, and why the
  changes were necessary (more on this in blah blah)

Or maybe "...whether any alternative approaches were considered..." fits
the form of the surrounding sentence better.

 - Emily

>  Make your code readable and sensible, and don't try to be clever.
>  
>  As for more concrete guidelines, just imitate the existing code
> -- 
> 2.35.0-177-g7d269f5170
> 
