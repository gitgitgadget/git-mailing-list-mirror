Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98C6B1F453
	for <e@80x24.org>; Fri,  3 May 2019 07:17:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfECHR5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 May 2019 03:17:57 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44707 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfECHR5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 May 2019 03:17:57 -0400
Received: by mail-wr1-f66.google.com with SMTP id c5so6413365wrs.11
        for <git@vger.kernel.org>; Fri, 03 May 2019 00:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qPInfntCdPfwtn3FFTlUuoSUfewkgaJ6ZE+WkTAdV7Q=;
        b=sD1BWxkux2aDJr4q2cruc/aVHbUtm8S/UcTP0uCXWdB6Zrz8HSBKHO5oFMlcSh1cyC
         kg/neWi+IG4SZmiBOewKkpe9PAG2zjhOn1O88/+raO1zQgrw232W6amXnb+gWBcv249c
         t8kDHWgVk87K662RENDIcPUQGvFYJ7Bv2MyxlnXLks0jHQXgzYi8QN2/VjVYxHwBBbIC
         t8dP5illAy/sHsgwU41WCN6K651YsyK/cS5ILQX0uJdDEQb3H7u/yXLHZOjco9G9orKA
         Nq09V7a+g7qVxFWKWCk9+j8i8h1o6ylk0DVzgKIHBPP5JMMpEjegZbvG1Dtaf93Yhvy0
         lt3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qPInfntCdPfwtn3FFTlUuoSUfewkgaJ6ZE+WkTAdV7Q=;
        b=QKht3qeeLlG01jKKE4vGuus90N0Px5VnpoUiHbgPXObtBsKxFj0W54sTzThwsT1U6P
         aP9ieYTVXHyEx6ZUKkZmtOOX+/eiZKhu9R8ROzhPmReHuPH7qT5+Ws3FkLgdXcXWiEg/
         7NV1RkTSzNdX/1g0Sp+oGrAQoV2zrIXeVGMnyrMNS07l5JHjmMYbFJJaqkec3wDJg0zp
         B3Z+bvPoNS89GHg2z5K9PX87Mso/f4JnXUuT63bC0FZxQL0HfZAsR2c+yJnp9qFi0s/O
         kV2A1118TlpMnXxNUDy8Cqw8t31+ekoZa2ti5CCkevo5FFPtigjBguSD7ctymikabw4i
         07Iw==
X-Gm-Message-State: APjAAAX8tqNHH2PrSucMdwVsriReZqPTJQ7Yloea8fnYrcoaTBBh6pE3
        jPdekVCF2YLccTdp/Cmh1mQ=
X-Google-Smtp-Source: APXvYqyJYbQEfv+w+wa4dDMg5zQ5k70T+hgz+4hB8i+56mZ8wzLLSBSPsF/L2BLaBCTBMscyAI5MEQ==
X-Received: by 2002:adf:e3c8:: with SMTP id k8mr5609238wrm.329.1556867875070;
        Fri, 03 May 2019 00:17:55 -0700 (PDT)
Received: from ?IPv6:2001:a62:437:4001:fd44:6515:8790:2e05? ([2001:a62:437:4001:fd44:6515:8790:2e05])
        by smtp.googlemail.com with ESMTPSA id g12sm1188109wmh.17.2019.05.03.00.17.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2019 00:17:54 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] revisions.txt: mark optional rev arguments with []
To:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
References: <18c8ed70602271a28c93df922eb3da8fb7563e2e.1555913472.git.liu.denton@gmail.com>
 <cover.1556367012.git.liu.denton@gmail.com>
 <90c787c219d25f38c1d53ae837160994a7bc6355.1556367012.git.liu.denton@gmail.com>
From:   Andreas Heiduk <asheiduk@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <1684a040-ebc0-2567-225e-d26aa13951a2@gmail.com>
Date:   Fri, 3 May 2019 09:17:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <90c787c219d25f38c1d53ae837160994a7bc6355.1556367012.git.liu.denton@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 27.04.19 um 14:16 schrieb Denton Liu:
> In revisions.txt, an optional rev argument was not distinguised.
> Instead, a user had to continue and read the description in order to
> learn that the argument was optional.
> 
> Since the [] notation for an optional argument is common-knowledge in
> the Git documentation, mark optional arguments with [] so that it's more
> obvious for the reader.
> 
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>  Documentation/revisions.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
> index e5f11691b1..68cce2ca06 100644
> --- a/Documentation/revisions.txt
> +++ b/Documentation/revisions.txt

I think I found another one here:

@@ -65,7 +65,7 @@ some output processing may assume ref names in UTF-8.
 '@'::
   '@' alone is a shortcut for `HEAD`.
 
-'<refname>@{<date>}', e.g. 'master@\{yesterday\}', 'HEAD@{5 minutes ago}'::
+'[<refname>]@{<date>}', e.g. 'master@\{yesterday\}', 'HEAD@{5 minutes ago}'::
   A ref followed by the suffix '@' with a date specification
   enclosed in a brace
   pair (e.g. '\{yesterday\}', '{1 month 2 weeks 3 days 1 hour 1

The doesn't give a hint that <refname> is optional but actually it is.

> @@ -95,7 +95,7 @@ some output processing may assume ref names in UTF-8.
>    The construct '@{-<n>}' means the <n>th branch/commit checked out
>    before the current one.
>  
> -'<branchname>@\{upstream\}', e.g. 'master@\{upstream\}', '@\{u\}'::
> +'[<branchname>]@\{upstream\}', e.g. 'master@\{upstream\}', '@\{u\}'::
>    The suffix '@\{upstream\}' to a branchname (short form '<branchname>@\{u\}')
>    refers to the branch that the branch specified by branchname is set to build on
>    top of (configured with `branch.<name>.remote` and
> @@ -103,7 +103,7 @@ some output processing may assume ref names in UTF-8.
>    current one. These suffixes are also accepted when spelled in uppercase, and
>    they mean the same thing no matter the case.
>  
> -'<branchname>@\{push\}', e.g. 'master@\{push\}', '@\{push\}'::
> +'[<branchname>]@\{push\}', e.g. 'master@\{push\}', '@\{push\}'::
>    The suffix '@\{push}' reports the branch "where we would push to" if
>    `git push` were run while `branchname` was checked out (or the current
>    `HEAD` if no branchname is specified). Since our push destination is
> @@ -131,7 +131,7 @@ from one location and push to another. In a non-triangular workflow,
>  This suffix is also accepted when spelled in uppercase, and means the same
>  thing no matter the case.
>  
> -'<rev>{caret}', e.g. 'HEAD{caret}, v1.5.1{caret}0'::
> +'<rev>{caret}[<n>]', e.g. 'HEAD{caret}, v1.5.1{caret}0'::
>    A suffix '{caret}' to a revision parameter means the first parent of
>    that commit object.  '{caret}<n>' means the <n>th parent (i.e.
>    '<rev>{caret}'

