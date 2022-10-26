Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0856C38A2D
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 20:35:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234310AbiJZUff (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 16:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234415AbiJZUfc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 16:35:32 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194EB43AEE
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 13:35:32 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id p3so14391982pld.10
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 13:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JzkH7Z+TyH24H7kGa6VAkW7wMbDrOpInKt0hM3TDOaA=;
        b=G1ifv/KoLtmf9paP9T5Uau2hVX69fL5/YqerslbRy8MAI85fi1sNCP2MCQbsp6wFWC
         Fct8uRVD9FJlanS+FZxeCFPFO+MTcX29vwzo4ZqdX+498j1Zp12VlLU/zFevjKz6/ERw
         YSY8dooxLuYdJw3EicCCsshdbzYoetDE015NvBKFcrIXSKxGPaTewZGZecgc6Icw8a30
         lK+3Jfa5c6dDsdEar2t8v/Dhxmo384lgsbLxNj69mQzQvem1JSX6yUENOgbdxi/FW1Mo
         MBVjKmcCEP7oHLjqkUacGdYtN6ThsCH979kWMCB8Fz+vRZ6WDMEAPXfjlFld1UAonZk6
         /BJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JzkH7Z+TyH24H7kGa6VAkW7wMbDrOpInKt0hM3TDOaA=;
        b=CvGFVLqE2DP/MwWuZg5VCq9s0M+f4nKp5YXvjM79lI18x9VTXjlpqCy9QS2+lx+wNa
         OuaIhQZLuG6gIeNzezL0EPh2kjw3IejfOnGgKf+g6qlOIgTsQ1jYirfn2LWS4n7ejvGM
         L4ZW5Xdp2hQp66P4H/IvXAySzi5hEIuejiZ86wdpEs+BSq4ei/1sF0Gh7e+uevQ4W1rd
         F7CbIzfAkBS4Plq7vVACIxKkLwkGfP8UcNYuTGWcQgxtbI69pGzsEB+Dmh21Kp1I58jH
         YGoaJp43gstqZPbLG1XZxg0IKW/Yuesx1MkO6xN760Ahyz3OHEA5RzqRL9wAVRaLeI9i
         eb7Q==
X-Gm-Message-State: ACrzQf2aCpNewIdipAxXZC/1ENTtuztCa9BperNt4u3LOCL6XciXhXRx
        HsPzDxMeSHtfZoB/DOVRS35E+n/azaA=
X-Google-Smtp-Source: AMsMyM7udD5rD/X4XYx0IDEvuHpf6IrjnQ9t8sTp/tfuVwoXSs6oa5My0zRj3e6+bLSAtCqqsYKRsw==
X-Received: by 2002:a17:90b:4d90:b0:213:687d:c0f0 with SMTP id oj16-20020a17090b4d9000b00213687dc0f0mr1317490pjb.212.1666816531470;
        Wed, 26 Oct 2022 13:35:31 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id a11-20020aa7970b000000b0056c7b49a011sm809873pfg.76.2022.10.26.13.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 13:35:30 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Documentation/howto/maintain-git.txt: fix
 Meta/redo-jch.sh invocation
References: <4ba057094ae6b1bd5c18583f23f7f99232034c72.1666815325.git.me@ttaylorr.com>
Date:   Wed, 26 Oct 2022 13:35:30 -0700
In-Reply-To: <4ba057094ae6b1bd5c18583f23f7f99232034c72.1666815325.git.me@ttaylorr.com>
        (Taylor Blau's message of "Wed, 26 Oct 2022 16:15:48 -0400")
Message-ID: <xmqq1qqugw6l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> The Meta/redo-jch.sh script is generated a few lines earlier by running:
>
>     $ Meta/Reintegrate master..seen >Meta/redo-jch.sh
>
> But the resulting script is not necessarily executable. Later mentions
> of this script invoke it with sh (instead of directly), but this one is
> an odd one out.
>
> Update the documentation to invoke the Meta/redo-jch.sh script with sh
> in case the maintainer has not made the script executable.
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
> Noticed while reading and following along with
> Documentation/howto/maintain-git.txt.

OK.  In the real life, the script gets once "chmod +x" and kept
updated by running "Meta/redo-jch.sh -u" which would update the
script in place, preserving the executable bit.  But explicitly
running it with the shell is less magical and less error-prone.


>  Documentation/howto/maintain-git.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/howto/maintain-git.txt b/Documentation/howto/maintain-git.txt
> index a67130debb..215e2edb0f 100644
> --- a/Documentation/howto/maintain-git.txt
> +++ b/Documentation/howto/maintain-git.txt
> @@ -256,7 +256,7 @@ by doing the following:
>     merged to 'next', add it at the end of the list.  Then:
>
>       $ git checkout -B jch master
> -     $ Meta/redo-jch.sh -c1
> +     $ sh Meta/redo-jch.sh -c1
>
>     to rebuild the 'jch' branch from scratch.  "-c1" tells the script
>     to stop merging at the first line that begins with '###'
> --
> 2.38.0.16.g393fd4c6db
