Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21A381F453
	for <e@80x24.org>; Fri, 21 Sep 2018 19:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391160AbeIVBto (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 21:49:44 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50947 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390726AbeIVBto (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 21:49:44 -0400
Received: by mail-wm1-f67.google.com with SMTP id s12-v6so4226151wmc.0
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 12:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=UB0tOhJR1Ys/esSmXJxLgMCU5bQ5KzWucZAd8zW0f+4=;
        b=qPeNW+S8LwC6KZsJaD6SK/ri2i4yvZIibnQBhgfsPKzEs+vv1nS9Jf9mzFbybCxnXm
         TG7N7wXu2vGFMFjQ3QYdj8ZxN7OS8HTGhw4xnm//t6jZbOBkxVz1WobMhZjxh/QWXAAN
         1+fOkJW2ovCGjWiU4axvvdA88rLQ3oZ+iXMUaLyYO0SgJWfjw83RcYE3xk1BJUwe353u
         S8V/bOZnRw8ORDINMYUiWNWsAKGJt7ozc1y8Urc8nKDvY6wmNJwdrmqLW+87hjnjuaQ3
         ZNgZtUMCNUgeExY1Ii09P/StAw70c8YaW+wnh8FKIe6Rz3X3j1fqde+j7h/nx+JceBpN
         pn8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=UB0tOhJR1Ys/esSmXJxLgMCU5bQ5KzWucZAd8zW0f+4=;
        b=NkVg5JzG+BGpjgge2vOv3IdDrREvfByfVfRYsbjWNlOWaa0EqR1aj7b/UpbIfL8C9E
         +m4c3/s73YFyiFGAMON7mTeSK4r8HABJ0Jo6bQuoib0nxuRas6yr7Sh+dL6pcyTs2EJN
         YVMSeK5h+0wPbvZpl8tgDqa9E9GS6TwMnuy57qJvnRN8JxDNbStPuKqu06WvTziXPl+x
         Murfed4cow0cYGNxag7wjn2ybkFgokmn/E8TJ0Q8wCJCUo68cwKp26uGuZQbRUCIvxzW
         6Z/hDuJm5oe1J9cjzmNBmx4ld2DeJuCkV2yam/11BgrFU/Czr+ZFfGnf987kGwhkgvt2
         Et6Q==
X-Gm-Message-State: APzg51DBRiLwygI0tunfqzpoOrB4uSh81FQqou+N4HEqmCbqVBqs2xRE
        /KAkNZNi8oowjiLaqRBzE1lrXWFP
X-Google-Smtp-Source: ANB0VdacoFa6SwztMOMFJE3lG0x2FREMdpXzukd+yrew+yhY19f+nZ1T8OdyRZPoCfPEFs+hvyetjg==
X-Received: by 2002:a1c:c501:: with SMTP id v1-v6mr6022622wmf.115.1537559958335;
        Fri, 21 Sep 2018 12:59:18 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id o19-v6sm35801833wro.50.2018.09.21.12.59.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Sep 2018 12:59:17 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH 2/3] transport.c: introduce core.alternateRefsCommand
References: <cover.1537466087.git.me@ttaylorr.com>
        <4c4900722cab253b3ce33cb28910c4602ce44536.1537466087.git.me@ttaylorr.com>
        <xmqqlg7ux0st.fsf@gitster-ct.c.googlers.com>
        <20180921174825.GA17718@syl> <20180921175739.GA21514@syl>
Date:   Fri, 21 Sep 2018 12:59:16 -0700
In-Reply-To: <20180921175739.GA21514@syl> (Taylor Blau's message of "Fri, 21
        Sep 2018 13:57:39 -0400")
Message-ID: <xmqqr2hmvcyz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> In fact, I think that we can go even further: since we don't need to
> catch the beginning '^.*' (without -o), we can instead:
>
>   extract_haves () {
>     depacketize - | grep '\.have' | sed -e 's/\\0.*$//g'
>   }

Do not pipe grep into sed, unless you have an overly elaborate set
of patterns to filter with, e.g. something along the lines of...

	sed -ne '/\.have/s/...//p'

