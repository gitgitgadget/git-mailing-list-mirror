Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D23CC05027
	for <git@archiver.kernel.org>; Wed,  1 Feb 2023 16:56:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbjBAQ4z (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Feb 2023 11:56:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbjBAQ4x (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2023 11:56:53 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB8379F37
        for <git@vger.kernel.org>; Wed,  1 Feb 2023 08:56:43 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id n2so13047579pfo.3
        for <git@vger.kernel.org>; Wed, 01 Feb 2023 08:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0ZS0LA4eLIHqmwZoqyEdCWhBdwB6gqOY5cROfK0+Y40=;
        b=UlQqOgi9TS3seKj9bjf1k6Xq9R0vK3aXFoTFJQ9TPuIp1p2qaTcs4YSTLuwpXWM5Ro
         aqYg661ymHgy/f6zSPqq+0Fm5WEMaOruGnQNaImKv9tN7sYPlNHqJAfNFWOKc4SzvIVX
         9GypQHUgtQeRF2gAhLBXhfiZskSttn+VkqX6f26MUY435LzSxwAqh5rnAJzjx9uOmvlA
         98w039wgNZ6KR+1ZWOSS8ajFiw7w6YygCZs5KE0lBc4L0Au48ryCxanQ73EyMFeqzzat
         efxjhb7E20VpogwAg7dlLAq5kTByjIAsp4b6yt4coPBiG0CSVCoFS0t89oaqPgGlyJrJ
         bOZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0ZS0LA4eLIHqmwZoqyEdCWhBdwB6gqOY5cROfK0+Y40=;
        b=vdeMFCzqTg3goSCwgs1am2lohC2RqZrQtLm8zUkvZEu5MrgRTEe/hT8/7Gvui32+ED
         tV/5HjjWWQ35igYtpkpq7XdMTMirGFKKTuzhof9cgjVH8OxYWExVofADx+BlQw3oi7HC
         f5iroC1KGuk9ax7gjqHZ619Ip89Y+Jkj40VbieyMR8emWzIpkMi4spEWYxEFTsQYaDv1
         3nWEFRLuOLX6WzpLkijdj4UZKeCV5OjlAgHC82tYd36qJ8dMlA2HHbGTPORgtQ1Gm7K0
         2ceLNUiGHDwkIN3MlJ/1SSyTMpZ2xDFX6I1wiQY6HrOhebXAXB4uKZsRfjJspdNaS07z
         rOMg==
X-Gm-Message-State: AO0yUKX8qH24iGTbzHzsmPJgg1sdHO1An6l0NORO6cGlN3Ss3iV2m2wL
        ClRYjQ34NNu8ZHowxQ1ht0BzWGgmtCE=
X-Google-Smtp-Source: AK7set9j1cFVJbRRIuW+5bLSLL0dq1B26uoIWxsvmhOle/uw0PaUYR9YytqhfciC6EOgYIEmWX7lIA==
X-Received: by 2002:aa7:80c6:0:b0:58d:a7f4:9630 with SMTP id a6-20020aa780c6000000b0058da7f49630mr2584174pfn.16.1675270603076;
        Wed, 01 Feb 2023 08:56:43 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id bw6-20020a056a00408600b005810a54fdefsm11712150pfb.114.2023.02.01.08.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 08:56:42 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] docs: document zero bits in index "mode"
References: <20230201024041.29401-1-chooglen@google.com>
Date:   Wed, 01 Feb 2023 08:56:42 -0800
In-Reply-To: <20230201024041.29401-1-chooglen@google.com> (Glen Choo's message
        of "Wed, 1 Feb 2023 10:40:41 +0800")
Message-ID: <xmqqmt5xwchh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> Documentation/gitformat-index.txt describes the "mode" as 32 bits, but
> only documents 16 bits. Document the missing 16 bits and specify that
> 'unused' bits must be zero.

I actually think the bottom 16-bit should just be described as
allowing only a limited set of possible values and list them all,
but this is good as an incremental improvement [*]

Thanks.


>    32-bit mode, split into (high to low bits)
>  
> +    16-bit unused, must be zero
> +
>      4-bit object type
>        valid values in binary are 1000 (regular file), 1010 (symbolic link)
>        and 1110 (gitlink)
>  
> -    3-bit unused
> +    3-bit unused, must be zero
>  
>      9-bit unix permission. Only 0755 and 0644 are valid for regular files.
>      Symbolic links and gitlinks have value 0 in this field.


[Footnote]

If I am not mistaken, there are only four possible values allowed.
So, instead of "split into...", we could just say

        32-bit "mode", which can be one of

          Regular non-executable file     100644
          Regular executable file         100755
          Symbolic link                   120000
          Git link                        160000

        No other values are allowed.

but we can move one step at a time ;-)

