Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A26051F453
	for <e@80x24.org>; Mon, 22 Oct 2018 03:35:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbeJVLwV (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Oct 2018 07:52:21 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38394 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbeJVLwV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Oct 2018 07:52:21 -0400
Received: by mail-wm1-f67.google.com with SMTP id 193-v6so8713888wme.3
        for <git@vger.kernel.org>; Sun, 21 Oct 2018 20:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=PN0hIQI8qxn7rEowir13tNc0OzmCi0FocGFh+D4IaZs=;
        b=EZNehZFXk9448+uJ4hq3xyGlhvcknCTdTqbXoLOB6G6xUS1kKX+WFkPuMUI4GbPh+L
         KFrBiWviXFL90fNFlJMbgMMzoJ87hlLB3D7yKljTfjINEqSPJw/geIPbZgbSgFuwD71A
         N3Hl2sy3+Wwqgo2qDSkzqeGdSKAtfIKTTVEdthbsKqtnBRO6fGIsEtqCMFCUl30hqVVK
         rgx7QQvHDZNxFLcVgS4Y4VpK63e/vEpo6HAl8pTpfmmC8mwgk8itHIM+c20Vz/zBbOgo
         lJO+ZsxIywMd0EzuYi2aMVeqjYIiQWH6jOWbEU/JBmURP7mHtLo53W3XlqcOgsVXcPg6
         El6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=PN0hIQI8qxn7rEowir13tNc0OzmCi0FocGFh+D4IaZs=;
        b=tZfmjynIEdTqFhEZqSY1AiH3V2beAhgxeIs6I9t/I0dyziGEtuM/dh+CszIFR145e7
         NzlfY7YKzcPEsQcLUB/9IsTf7B4IqqcSOghSShI4+JQP4aGMeWRpRsCnbH9ZZVXYMcxV
         odNfqKfzZmKCX8MGVOg22P/qpEQjNWPKWgBlzIhSTLMqQ+TCZrfHEPcpeI8ft2R50Nl5
         cCX6FeD/5DPrA1C0Gg35GT6XqRhUmvafbYNcszyHmvc+sap91QKIY267ary/rUhd9lgp
         yAokjsuj7wuN09dv6kl/qIOT77fo+VxF4dq5Wy6UU0eUopvPfYgfYEcIb3dHbT3gAlDM
         tXeQ==
X-Gm-Message-State: ABuFfojoZ+LleS+kU2CBIRGwTiraV8ymvOOy5+Sh4qFXt+jLZYGyUdQP
        vAr6K4+B1SP7G4DDDOfWZXw=
X-Google-Smtp-Source: ACcGV60XfB8EprBCVuwa1dNGyUXCnBnyXOtPObmj+e9qRsoCmvFAhKwq4GmD2KJMYfkR/yiCx0AdQg==
X-Received: by 2002:a7b:c08c:: with SMTP id r12-v6mr14469602wmh.108.1540179338486;
        Sun, 21 Oct 2018 20:35:38 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id x139-v6sm17992135wme.3.2018.10.21.20.35.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 21 Oct 2018 20:35:37 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] builtin/receive-pack: dead initializer for retval in check_nonce
References: <20181020070859.48172-1-carenas@gmail.com>
        <20181020164526.GA1077@tor.lan>
Date:   Mon, 22 Oct 2018 12:35:36 +0900
In-Reply-To: <20181020164526.GA1077@tor.lan> ("Torsten =?utf-8?Q?B=C3=B6ge?=
 =?utf-8?Q?rshausen=22's?= message
        of "Sat, 20 Oct 2018 18:45:26 +0200")
Message-ID: <xmqqzhv6wt4n.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten Bögershausen <tboegi@web.de> writes:

> Initializing a variable to "BAD" in the beginning can be a good thing
> for two reasons:
> - There is a complex if-elseif chain, which should set retval
>   in any case, this is at least what I expect taking a very quick look at the
>   code:
> ...
> # The second reason is that some compilers don't understand this complex
> # stuff either, and through out a warning, like
> # "retval may be uninitialized" or something in that style.
> # This is very compiler dependent.

And to help humans that unless some if/else chain explicitly says it
is OK, the caller receives BAD by default.  In other words, it is
being defensive.

At least that was the reasoning behind the original code that did
not support SLOP.

> So yes, the current code may seem to be over-eager and ask for
> optimization, but we don't gain more that a couple of nano-seconds
> or so.  The good thing is that we have the code a little bit more
> robust, when changes are done in the future.

True.

