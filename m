Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8807C433F5
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 00:10:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235490AbiCDALP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 19:11:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbiCDALN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 19:11:13 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AAA63FBFD
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 16:10:26 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id a5so6134558pfv.9
        for <git@vger.kernel.org>; Thu, 03 Mar 2022 16:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=c6g3cU85o+Dt37MlcUyA3ppME3cNQHUjxWp3KYWh/Zw=;
        b=DLurrt9/Jdx8GN7Ewzo6Oc19liTUsZGNJKALMFSqlMtlzFukj8ZcpsbpwEHusQVxiO
         W+KH7Qm7YYhbV3N24Z84NGIsPcKjurxbtUePZXNbMlU9rLP6POC9BR8NnvDjnkOXYy6c
         mS0+zGaELWiPY44LK5quvWPq+bZh6fq5aA9RdZMBFCMD5yzlh2Fbu+8Z+87Al/g4JF82
         QINp+H+DaLOL8AqJIjY9kpJ7AY4czE4L8Ji+fT+eZHA+c8xoxFEjmJsX7UN6OQ3HAfFB
         /GPCFK8U4dO5xwiGdLB5hrQpKFFUSnDEdHyjczqin1wWVB50Rx1fSRQcJd9DPs9Yg4I+
         wa8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=c6g3cU85o+Dt37MlcUyA3ppME3cNQHUjxWp3KYWh/Zw=;
        b=RAgMa+dcX3qEjxlzuhiUmoj+fjpHTNSJxPD5rtHPAHEv9rM2lbza0FFALpRsl7FpGz
         Z+gomwn5CnY/jHFw6D7saznxLUiK+muJUiLc7yYfQxCWpx0GYJRy/nCMnnWkkx0CrhYD
         RqOci07HJHZ084VnNzhwMnWF4xfCVIXdiojxaVp0A+p1/ZZmniHnJgFnoD4VbMcmd5FC
         K3o7hrqeACFvABwyRin13MoEAeIyFa/0m7LVdoe8NZjnnJ6DeoVCNqGE/bb99pOsVEki
         HX2s8n5zRdb7Q7qITLfCAgH1cfSmQGphe8vWnjXozn7TV07z/XJMfBXznQYksDVlYa37
         8c+g==
X-Gm-Message-State: AOAM532VP4UhgaDiqNfd879wrCYTy1UvEkSEQPUTBxQ4NFVLCJIzNoZ4
        d9lHEh8gd0mu++3LxdBJyLjuIaANVTIjjQ==
X-Google-Smtp-Source: ABdhPJy4rYa545NpDm2fmUC9Ao8To49J2dF5ex7kzRpyYd/jOag7jzaX49Cm2NpA6gusBxE9/6F/ow==
X-Received: by 2002:a63:90c8:0:b0:37c:996e:3127 with SMTP id a191-20020a6390c8000000b0037c996e3127mr232337pge.33.1646352625231;
        Thu, 03 Mar 2022 16:10:25 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:90ea:410e:eb0e:7f23])
        by smtp.gmail.com with ESMTPSA id t12-20020a056a0021cc00b004e105f259e8sm3598738pfj.152.2022.03.03.16.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 16:10:24 -0800 (PST)
Date:   Thu, 3 Mar 2022 16:10:19 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 3/3] SubmittingPatches: explain why we care about log
 messages
Message-ID: <YiFY693P6E/eVS3k@google.com>
References: <20220126234205.2923388-1-gitster@pobox.com>
 <20220127190259.2470753-4-gitster@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127190259.2470753-4-gitster@pobox.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 27, 2022 at 11:02:59AM -0800, Junio C Hamano wrote:
> 
> Extend the "describe your changes well" section to cover whom we are
> trying to help by doing so in the first place.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/SubmittingPatches | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
> index 7225a0fb52..a6121d1d42 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -110,6 +110,35 @@ run `git diff --check` on your changes before you commit.
>  [[describe-changes]]
>  === Describe your changes well.
>  
> +The log message that explains your changes is just as important as the
> +changes themselves.  Your code may be clearly written with in-code
> +comment to sufficiently explain how it works with the surrounding
> +code, but those who need to fix or enhance your code in the future
> +will need to know _why_ your code does what it does, for a few
> +reasons:
> +
> +. Your code may be doing something differently from what you wanted it
> +  to do.  Writing down what you actually wanted to achieve will help
> +  them fix your code and make it do what it should have been doing
> +  (also, you often discover your own bugs yourself, while writing the
> +  log message to summarize the thought behind it).
> +
> +. Your code may be doing things that were only necessary for your
> +  immediate needs (e.g. "do X to directories" without implementing or
> +  even designing what is to be done on files).  Writing down why you
> +  excluded what the code does not do will help guide future developers.
> +  Writing down "we do X to directories, because directories have
> +  characteristic Y" would help them infer "oh, files also have the same
> +  characteristic Y, so perhaps doing X to them would also make sense?".
> +  Saying "we don't do the same X to files, because ..." will help them
> +  decide if the reasoning is sound (in which case they do not waste
> +  time extending your code to cover files), or reason differently (in
> +  which case, they can explain why they extend your code to cover
> +  files, too).
> +
> +The goal of your log message is to convey the _why_ behind your
> +change to help future developers.
> +

This is pretty compelling. Is it clear enough why we care about this in
the commit message, as opposed to in the patch description (cover letter
or post-"---" blurb)? Is it too obvious to explicitly mention that the
commit message is the first thing we try to make sense of during a 'git
blame' or 'git bisect'?

Either way, I think this is an improvement on the doc as it was before.

Reviewed-by: Emily Shaffer <emilyshaffer@google.com>

>  The first line of the commit message should be a short description (50
>  characters is the soft limit, see DISCUSSION in linkgit:git-commit[1]),
>  and should skip the full stop.  It is also conventional in most cases to
> -- 
> 2.35.0-177-g7d269f5170
> 
