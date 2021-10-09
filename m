Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B87EEC433EF
	for <git@archiver.kernel.org>; Sat,  9 Oct 2021 08:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B59760F3A
	for <git@archiver.kernel.org>; Sat,  9 Oct 2021 08:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233010AbhJII7e (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Oct 2021 04:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbhJII7d (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Oct 2021 04:59:33 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45DDC061570
        for <git@vger.kernel.org>; Sat,  9 Oct 2021 01:57:36 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id v20so605626plo.7
        for <git@vger.kernel.org>; Sat, 09 Oct 2021 01:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=3M70ZLBPyUQSTBfztufPQK0acan5WrjJmEZ9GlD685o=;
        b=TgCxOF3B+TV46FtMajmcysIZR8AbIHVC1KlG5yp7JIz1wr/q11h8SvXUWWAqWrnyA1
         dgK1Yc+xhDon+e0O9lraBD1Y3SXAtCG6S9p/ucl0yb+cxwG4VeR47SjVSufOkgV9T1z6
         o9gKu9PiSxPzuw3TRJi9FNViMy6z9JYuJZC/WfLBOTvaI1IVtcfZ9zV12pvyqo8YhsuC
         H2JBz4DB1W0u6MT0R1YQ23+k6ecDeWWKirdbxGrPir+5zTcFitYBCOiUXVCapwVWjskb
         92uBZ5ydbvR+DjZ73VgzTiXTf5SL5SYmoeY9ztTX1TSLV91gJIdA1owoCvpF5BPnUsE7
         SNiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3M70ZLBPyUQSTBfztufPQK0acan5WrjJmEZ9GlD685o=;
        b=bNhI4He0s306wPFdkIq/TIW66GFa3jT78VcAu0XaF+kr+HRiaNErl22S81oRbS6kIo
         nVHANhDeMRA4dlcfFJU3Z+TAn20dwvaukoB0d4gp5akFwZyalkaOXeZcON2AY8rD+6x6
         oRkD8x+FZRoLJascanTXOnGo2wofYBbUSQfrKsof63QzgA8RpXNuhYF0S6ctoyppTMox
         iKFCM8ECVoUTnA5qw9u/knMWiI1+y25/H5UBMlKC99ZfY3FU7JfUUA2c6piVhhs9CNHR
         n6cS03sqRQOXxeIwCFeE1vTNYDs0U559niFfh2NbJ2LBdh9QcVoj9A4WQSL6rbwY2cke
         gryQ==
X-Gm-Message-State: AOAM532EeUyqDV4ppBU4WzZvEkR/2DMGBc8nCblkNZkjOblUQCRVJazi
        ijjZdDFVVfCeEMBSMFTmp1jRm8B85MTrgQ==
X-Google-Smtp-Source: ABdhPJz+nyeDW11hBGZoVzWuktrH641XOAod+uIZdN3MTvMQyeGSA2pePW3nEBw+uvd761frb2HxCg==
X-Received: by 2002:a17:90a:b117:: with SMTP id z23mr1354408pjq.74.1633769856343;
        Sat, 09 Oct 2021 01:57:36 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-90.three.co.id. [180.214.232.90])
        by smtp.gmail.com with ESMTPSA id z9sm1427383pji.42.2021.10.09.01.57.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Oct 2021 01:57:36 -0700 (PDT)
Message-ID: <1d6ec04f-6f89-5da6-75a9-3099e2437df5@gmail.com>
Date:   Sat, 9 Oct 2021 15:57:32 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RFC PATCH] Documentation: better document format-patch options
 in send-email
Content-Language: en-US
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        git@vger.kernel.org
Cc:     tbperrotta@gmail.com, gitster@pobox.com, avarab@gmail.com
References: <20211007033652.80793-4-tbperrotta@gmail.com>
 <20211009083133.4446-1-carenas@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20211009083133.4446-1-carenas@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/10/21 15.31, Carlo Marcelo Arenas Belón wrote:
> -2. Generic <revision range> expression (see "SPECIFYING
> -   REVISIONS" section in linkgit:gitrevisions[7]) means the
> -   commits in the specified range.
> -
> -The first rule takes precedence in the case of a single <commit>.  To
> -apply the second rule, i.e., format everything since the beginning of
> -history up until <commit>, use the `--root` option: `git format-patch
> ---root <commit>`.  If you want to format only <commit> itself, you
> -can do this with `git format-patch -1 <commit>`.
> +2. A Generic <revision range> expression that describes with
> +   options and revisions a range of commits.
> +
> +If you give a single <commit> and nothing else, it is taken as the
> +<since> of the first form.  If you want to format everything since the
> +beginning of history up until <commit>, use the `--root` option:
> +`git format-patch --root <commit>`.  If you want to format only the
> +<commit> itself, use instead `git format-patch -1 <commit>`.
> +
> +If you want to affect a set of commits, provide a range (see
> +"SPECIFYING RANGES" section in linkgit:gitrevisions[7]).
>   

Supposed that we have following commit graph:

a --- b --- c --- d --- e --- f (main)
             \
              --- g --- h --- i (mywork, HEAD)

According to your edit, `git format-patch <c>` and `git format-patch 
--root <i>` are equivalent, right?

I think for the third case, s/affect/format/.

> @@ -18,8 +19,8 @@ DESCRIPTION
>   Takes the patches given on the command line and emails them out.
>   Patches can be specified as files, directories (which will send all
>   files in the directory), or directly as a revision list.  In the
> -last case, any format accepted by linkgit:git-format-patch[1] can
> -be passed to git send-email.
> +last case, a revision in a format accepted by linkgit:git-format-patch[1]
> +as well as relevant options must be provided to git send-email.
>   
>   The header of the email is configurable via command-line options.  If not
>   specified on the command line, the user will be prompted with a ReadLine
> 

Did you mean that in the second form of git send-email, only 
format-patch options are accepted?

-- 
An old man doll... just what I always wanted! - Clara
