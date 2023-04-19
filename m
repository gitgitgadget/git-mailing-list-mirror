Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49268C77B73
	for <git@archiver.kernel.org>; Wed, 19 Apr 2023 19:37:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbjDSThm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Apr 2023 15:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjDSThl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2023 15:37:41 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC3A10F
        for <git@vger.kernel.org>; Wed, 19 Apr 2023 12:37:39 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-51f597c975fso147419a12.0
        for <git@vger.kernel.org>; Wed, 19 Apr 2023 12:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681933059; x=1684525059;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m5IqTu7ycFozp84ThMzz9OmxPodwmz+MIuGXJ0nA5+I=;
        b=OSwKp0h7HtDU/MfaYGDEwEznZoqhNbQ/Q/6tFNn/aitJrtEGLCK42n3RH51Ph9gri7
         Ls7nTCFITrPCWcCvnt+vTD/lER1ej5Z1XtU2SCsYU30S9m3cwDomyTueRV2u/59+2Krz
         RUd2WainpyrestIl5BUz514TkDjctYsXk4J1OuOOeMj8KyjMYRgNDoOdAvK6LoxxNt15
         xmwHf+zKfVvv09wSCpVLVhLzfVRgLotOBXrPsfzqtxnF7LgjrxpOlDIin8TWKEXBXBnm
         N/rZCYiA6ODlTNUAlFRCDnqVND7dgLNBdv1m0v0n2NcaGV6hta547dZAVr61v8RIhsp1
         xO+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681933059; x=1684525059;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=m5IqTu7ycFozp84ThMzz9OmxPodwmz+MIuGXJ0nA5+I=;
        b=jk1klIfFHU9pGR6HjFa27NcSh5HzzhxQvPdYSUm7Vx5SzPTV6nWQ79WQ48RltfMZDj
         whOj5LtQ4qf4javRtbUBxshOQP7uPU7ZDRtGgdto3+NNLgINLoEkcmZ6Ee8srEFf53Zj
         oNrVwsTwADqhL9wWMyFi9v7oNcAaRp+Cn0RdPzOBfXefl5P7RoEbCTx3EUZ8Gl9Sq9yD
         626hVsbgu0+He3VZ/QnjcydY2qd25ei4C9ePyLykPDxZOGuyXrYb1ZrurC4f04bJbcdq
         HLG0lXc7Gg4M4UpVusTVzzqgTeikYPlgViUkq7AoREBFKNpigyBXryyKjs0kxEEApMVA
         /GQw==
X-Gm-Message-State: AAQBX9cg1sdwtvbqzl6BHnsHTwwoM4M3U2lrUHAz5bmLSMPVMGiBoRzi
        RwogANcwEDIRD/aAJKQEjV8=
X-Google-Smtp-Source: AKy350ZhpHBNQw/DqexiOejF7z8O55YZhNI4D221scgio/tmCQspVINbAW85IV1L3mwkx8P2pu3jhA==
X-Received: by 2002:a17:90a:f48a:b0:22b:b832:d32 with SMTP id bx10-20020a17090af48a00b0022bb8320d32mr3747976pjb.9.1681933059096;
        Wed, 19 Apr 2023 12:37:39 -0700 (PDT)
Received: from localhost (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id iy14-20020a170903130e00b001a63ba28052sm11777147plb.69.2023.04.19.12.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 12:37:38 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] doc: git-checkout: trivial callout cleanup
References: <20230418070048.2209469-1-felipe.contreras@gmail.com>
        <20230418070048.2209469-2-felipe.contreras@gmail.com>
Date:   Wed, 19 Apr 2023 12:37:38 -0700
In-Reply-To: <20230418070048.2209469-2-felipe.contreras@gmail.com> (Felipe
        Contreras's message of "Tue, 18 Apr 2023 01:00:47 -0600")
Message-ID: <xmqq8ren8xz1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> The callouts are directly tied to the listing above, remove spaces to
> make it clear they are one and the same.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  Documentation/git-checkout.txt | 4 ----
>  1 file changed, 4 deletions(-)

I tried to format git-checkout.1 and git-checkout.html from HEAD and
HEAD^ after applying this step, with asciidoc and asciidoctor, and
did not see any difference that came from this patch.  Am I correct
to understand that this patch is done purely for the benefit of
human readers, and not for formatting machinery?

It may be subjective for those who read the source if it is easier
to read with or without inter-paragraph spaces, but in any case, the
resulting source material now look the same way between two hunks,
and consistency is good.

Queued.  Thanks.

> diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
> index 6bb32ab460..8ddeec63dd 100644
> --- a/Documentation/git-checkout.txt
> +++ b/Documentation/git-checkout.txt
> @@ -483,14 +483,11 @@ $ git checkout -b foo  # or "git switch -c foo"  <1>
>  $ git branch foo                                 <2>
>  $ git tag foo                                    <3>
>  ------------
> -
>  <1> creates a new branch `foo`, which refers to commit `f`, and then
>      updates `HEAD` to refer to branch `foo`. In other words, we'll no longer
>      be in detached `HEAD` state after this command.
> -
>  <2> similarly creates a new branch `foo`, which refers to commit `f`,
>      but leaves `HEAD` detached.
> -
>  <3> creates a new tag `foo`, which refers to commit `f`,
>      leaving `HEAD` detached.
>  
> @@ -529,7 +526,6 @@ $ git checkout master~2 Makefile  <2>
>  $ rm -f hello.c
>  $ git checkout hello.c            <3>
>  ------------
> -+
>  <1> switch branch
>  <2> take a file out of another commit
>  <3> restore `hello.c` from the index
