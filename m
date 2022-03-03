Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77898C433EF
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 23:59:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbiCDAA2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 19:00:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbiCDAA1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 19:00:27 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF8610BBC4
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 15:59:40 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id ge19-20020a17090b0e1300b001bcca16e2e7so9200576pjb.3
        for <git@vger.kernel.org>; Thu, 03 Mar 2022 15:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7OaJDxVhtR23U+zn0fPXR853pshNRFWn9CmZVdwi8uA=;
        b=I/4UtxngGB2RM/wdnDGS02K6th3MBE8E8ElZvqfqcBNbPWTNFJ3mwtC3KlaE4wvvKz
         cM0h/OnsA7XgdVNTr0lUVwmCaYz0TBP78sNOvBA9MRHW1MkCMWlp2hZ++nyeV2W4PSG8
         1pgUVDiPsRvSqg52GOv90S57B1BuzU/5ffA8YHc0jGsjR7ho715/syDCJhFgDcz3/iAo
         sP0lY0sohNjmifOE3s4zkEpL5WHB5zQs/DHgj9lJXE39fqHgy6yniJuja2vpHeOf/hLf
         3xL860mkW7Z5NsXJCEP904AwW88MW0mpDgsssUVnpOWqBKg/UVDOUvaNmwgHImAkuC/u
         j3jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7OaJDxVhtR23U+zn0fPXR853pshNRFWn9CmZVdwi8uA=;
        b=lZ5Z4Symyg9eBrqV2dToD8ORWYd838uUCS45wJ8uOpvBKPci4/uLx7TSwLaIU4bOJq
         FX1D9s5MkWYMI29EWNoxHwZqPgnexLJD6RSPp28KjKJ8cSy8U0EcM2n9d1T+tQMd1eDO
         lwaVFLwpvGhx/Z5xt/F+q6l4UoleBvQESpqDPfgF1Jdtwg4SxZ12e2WA1afTWKJIDNvF
         +Wl831pIQh5H1Klxj18FXgfFQy4VjkeLv4+SpagOCJ7fKZoZO/rjVt/eFvOnEWGu/bfq
         T2S9mUCEhuZEzbootChdpT8JIAENmRtF3eVITmGJ4bYDuOGMwI2N+bWxyTu9tAS+jiQT
         N4vA==
X-Gm-Message-State: AOAM533g6xOopUq94j+95wjC3U8fh88DOiz1VCECQepj20VK5UMaK8GP
        pQ5KXsGdvsubMyJZQhw6rBTboztGf4Jmvg==
X-Google-Smtp-Source: ABdhPJx/hyLmnqlU5a0wxKhDLkLjkpCuyZhb+zPkLetbmOqjc9gbZlu58nJPjYewLqHY28J4tWx1OA==
X-Received: by 2002:a17:902:d512:b0:151:b9e0:32c3 with SMTP id b18-20020a170902d51200b00151b9e032c3mr1522060plg.133.1646351979710;
        Thu, 03 Mar 2022 15:59:39 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:90ea:410e:eb0e:7f23])
        by smtp.gmail.com with ESMTPSA id f4-20020a056a00238400b004e10b67e658sm3575766pfc.3.2022.03.03.15.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 15:59:38 -0800 (PST)
Date:   Thu, 3 Mar 2022 15:59:33 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 1/3] SubmittingPatches: write problem statement in the
 log in the present tense
Message-ID: <YiFWZal+k6ixnYPU@google.com>
References: <20220126234205.2923388-1-gitster@pobox.com>
 <20220127190259.2470753-2-gitster@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127190259.2470753-2-gitster@pobox.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 27, 2022 at 11:02:57AM -0800, Junio C Hamano wrote:
> 
> We give a guidance for proposed log message to write problem
> statement first, followed by the reasoning behind, and recipe for,
> the solution.  Clarify that we describe the situation _before_ the
> proposed patch is applied in the present tense (not in the past
> tense e.g. "we used to do X, but thanks to this commit we now do Y")
> for consistency.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/SubmittingPatches | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
> index 92b80d94d4..7225a0fb52 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -142,6 +142,13 @@ The body should provide a meaningful commit message, which:
>  
>  . alternate solutions considered but discarded, if any.
>  
> +[[present-tense]]
> +The problem statement that describes the status quo is written in the
> +present tense.  Write "The code does X when it is given input Y",
> +instead of "The code used to do Y when given input X".  You do not
> +have to say "Currently"---the status quo in the problem statement is
> +about the code _without_ your change, by project convention.
> +

The writing sample helps a lot here. "Present tense" is a poor example,
but I think it's common for native language speakers to know less about
specific grammar words (like "imperative mood" below), even though they
can often instinctively tell what form you're describing when seeing a
sample.

As for the norm itself, I think it is a good one, and I've seen it
pointed out in code reviews frequently. Thanks.

Reviewed-by: Emily Shaffer <emilyshaffer@google.com>

>  [[imperative-mood]]
>  Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
>  instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
> -- 
> 2.35.0-177-g7d269f5170
> 
