Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF1211F404
	for <e@80x24.org>; Sat, 21 Apr 2018 04:07:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750776AbeDUEHk (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Apr 2018 00:07:40 -0400
Received: from mail-wr0-f169.google.com ([209.85.128.169]:44890 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750740AbeDUEHj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Apr 2018 00:07:39 -0400
Received: by mail-wr0-f169.google.com with SMTP id o15-v6so27546595wro.11
        for <git@vger.kernel.org>; Fri, 20 Apr 2018 21:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ZgfH5dIyPYCmfmXCAQgjQYI3cXpiGYMl2JIl5MCaj/o=;
        b=dcO5l29mZ2yOjLzCIDsu7290V/Hhmnk1GkLF13Ev88YBMN4r1CdkB6McaaCggS6mgh
         iHC88V+IanNQG5RBe6kXAxhoh0fb7X94j58NP28Uwz5rmXXK123DPAFqzndQe4XB7LWx
         FLt6pRZMCOuwu2uohidPJ9u73BI+IS8AXnZ5q+929QN39ksuDs1lN9iFAn9Vmx9YpfPK
         O+1Y5iAzmihrE9TmA2KwcMm5kADL3DQ5QVFSWSNFiMmMN9CaIHi7EcsOZlI4aS8v4coB
         iXwphySslBwSJFQAzDMq9xgJ2SEQYzRuuiEydjilGwP86c7WudNHWzj4v/iH/82qM8vz
         M4rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ZgfH5dIyPYCmfmXCAQgjQYI3cXpiGYMl2JIl5MCaj/o=;
        b=sqMiwYRtvssOHuuAfKhMvSrmD1QoyfhfjTY9wwe+BHEhOyvTLelG6of1/h/8GgtsAN
         yKSBnoCgUPs56gB54yrWlIag+3UW8moQ/jpmoRYyH22/faT9zMbxyoBa+4HKypcayRS/
         inVWCiIaCqreXeljReza4wmyFVgy/QIN1GvztYxEznrtWfDwZ8JsYl+FxhUKEQ7vvTEy
         qYlZvlwZTRj0Fh2+Ao3dMQvj2UPpARoBZcxveKYAAnFhCkJ+jLFne2R5sMcNHxcdJU1D
         ZGttB2i90FI3iu76uv+n6GpF9fCO072DoopVmIzAHGNpZbZtk/SvDBiAi4hFToaGKBeB
         8smQ==
X-Gm-Message-State: ALQs6tDaCHGL8tagtdeio4Y+0JrMb0B8Jp+D+B7F4zrpLeVr+/srkF2R
        5vLvps/tdoPzy7Ns7B40xT4=
X-Google-Smtp-Source: AIpwx4+J+4/iDQFKLUvYhahirfguBiFYcco3ucv/cLUckiGTYwIL2Nmro0YorOqV56FFYo1whNoXwg==
X-Received: by 10.28.11.14 with SMTP id 14mr3481622wml.34.1524283658208;
        Fri, 20 Apr 2018 21:07:38 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 19sm3539698wmv.18.2018.04.20.21.07.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Apr 2018 21:07:37 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, l.s.r@web.de, peff@peff.net
Subject: Re: [PATCH 5/6] builtin/grep.c: show column numbers via --column-number
References: <cover.1524281843.git.me@ttaylorr.com>
        <20180421034540.GF24606@syl.local>
Date:   Sat, 21 Apr 2018 13:07:37 +0900
In-Reply-To: <20180421034540.GF24606@syl.local> (Taylor Blau's message of
        "Fri, 20 Apr 2018 20:45:40 -0700")
Message-ID: <xmqq8t9hb3sm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> This commit teaches 'git-grep(1)' a new option, '--column-number'. This
> ...
> +`columnnumber`;;
> +	column number prefix (when using `-m`)

Is there other people's tool (preferrably some variant of "grep")
that has an option to tell it to show the column number of the hit?
What is the option called there?  Does that tool let the option
squat on short-and-sweet '-m'?

Thanks.
