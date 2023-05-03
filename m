Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BBD9C77B7F
	for <git@archiver.kernel.org>; Wed,  3 May 2023 06:09:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjECGJf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 02:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjECGJe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 02:09:34 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE9E2D4E
        for <git@vger.kernel.org>; Tue,  2 May 2023 23:09:33 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-63b7096e2e4so3744040b3a.2
        for <git@vger.kernel.org>; Tue, 02 May 2023 23:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683094173; x=1685686173;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=+be3yWWLMBuFpo4SvnbKI3h2BhIxIEYfZIU3no4/AA4=;
        b=qsvv5m71sCz/fPgRSwRyjfFn4OBZAio6gc/xH0igIsQ955C6GGQMZdkpNqx1tvvPhJ
         Y5grdn3BnDP9zC36ywUkb9VgzGU2q81PtrUzmlUxOYA9P6WG+DItF5fSxi6luu2H3aZj
         Rmcw9Zh5j3x0QjHybM7Px3AnoVKXdTAadESyr3tiUcs17ybOt1z/cpOLgRj8Ec/8ahw2
         +M2ydyCt91S1tmGxIwfbVvUI4Rx1V2hq6DFAM4NfM9byIA4d6KFIyDjz/EoWEZGLcf1h
         7HJPz7ySKNdmxRuRHOjaog+fuMQMFuqkIpsbXTZ1YPaWwXANQJQfS4fyvcq21rT/Fs73
         6vZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683094173; x=1685686173;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+be3yWWLMBuFpo4SvnbKI3h2BhIxIEYfZIU3no4/AA4=;
        b=iWXkNQZhtM8Awd/vtOiZtW0C6oRoyBcQ2W4m04yU6doCKw51T8dojSRJjZc345jbZ1
         3PmtgvxuDzQsxCEg/zqQUMzIb9q1yC+qi6dCFgfW0TZUyNdv0xdLoQ7rwav9ZAEG7SIl
         RElH5HegzKRrYIpwMhbxreGeLSlQRjGLkFBnmtKSoiShaxSLTtlQuXlF1z201CDjVtep
         CncgO3N/ecgo38a3uapAX19HDIMZZSY1G71tWBO4SYCDOMXc8k+BhY3UZMXNwnr/3og+
         94Oz7WyRcj/snV6psfCOJaI7sl5jCGzqcy9sH1fWvuVvspd03jsuGkoZFPJawKxfx/pU
         CeIw==
X-Gm-Message-State: AC+VfDx/+P2csA2M7oB+Ey3CzVJrxbLieu1MuaGJQNm6VDgUZQZQCIpb
        /GM28Bb+1zhGTiGPyG1DPzo=
X-Google-Smtp-Source: ACHHUZ7blVTFGDrg15QKl64aiIOMpbG7GNeCPuIxUBaeIj1T7RRUg5zwzLteuh1Wdme/i0LRGyTX5Q==
X-Received: by 2002:a05:6a00:15cf:b0:63b:62d1:d868 with SMTP id o15-20020a056a0015cf00b0063b62d1d868mr27954116pfu.8.1683094172653;
        Tue, 02 May 2023 23:09:32 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id f14-20020a056a00238e00b00640e64aa9b7sm15415567pfc.10.2023.05.02.23.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 23:09:32 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] doc: git-checkout: trivial callout cleanup
References: <20230418070048.2209469-1-felipe.contreras@gmail.com>
        <20230418070048.2209469-2-felipe.contreras@gmail.com>
        <xmqq8ren8xz1.fsf@gitster.g> <644684018a766_aba29424@chronos.notmuch>
        <xmqq8reg96cu.fsf@gitster.g>
        <20230425061029.GA4015844@coredump.intra.peff.net>
        <644af29c8526c_7f4f2945f@chronos.notmuch>
        <20230502101854.GA1180695@coredump.intra.peff.net>
Date:   Tue, 02 May 2023 23:09:31 -0700
Message-ID: <xmqqpm7ivtd0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> > Using just a blank line between the code block and the call-out list
>> > (instead of the "+") works for asciidoc (it is happy to keep the two
>> > together) but not asciidoctor (it ends the outer ordered list before
>> > starting the callout list).
>> ...
>  $ git checkout hello.c            <3>
>  ------------
> -+
> +
>  <1> switch branch
>  <2> take a file out of another commit
>  <3> restore `hello.c` from the index
>
> which asciidoc renders the same, but asciidoctor is not.

Yet another random annoying differences that explains why we wrote
it that way in the first place X-<.  If it has been removed to make
it not to matter, that was lucky of us ;-)

Thanks.



