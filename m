Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9431E200B9
	for <e@80x24.org>; Fri,  4 May 2018 02:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751404AbeEDCYn (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 22:24:43 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:55267 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751229AbeEDCYm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 22:24:42 -0400
Received: by mail-wm0-f67.google.com with SMTP id f6so1750028wmc.4
        for <git@vger.kernel.org>; Thu, 03 May 2018 19:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=AuKzfkbcVIA91LGUpu6fCaA4hp4lm1SX/foKD7Lk2eY=;
        b=LtyxEQWKnceBwZQJzCS10x8RZUDSNiYY+4pnMKFPCkcjZnNSNK7O2fUYkPNzN7WrSB
         YrDnJwEoK4gMI4rWOp6F01Cfxf4CgwWJGYNxMreroU2rP8z0JvoVPVj38FKCrP9sp4Eh
         7DXrtP/rxjOfN5OxVUuOX/74pINwI08glSDAwAfHChrE4n+WRWDcZiKN4NBfaLdazw5G
         ZJXOqKR4vQnxtlLMnNCMZany5omBugwQjTc2CZGi1z9+K4bhcEfaTvZYEQMFF24IjEIQ
         pS1PX0XrZHDN0N5XCtXvYgcy2h42jbU/6VFG1cVnuZq99fssL+aHYD76CVRvatKhrYlS
         0I9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=AuKzfkbcVIA91LGUpu6fCaA4hp4lm1SX/foKD7Lk2eY=;
        b=ibMvhLHgerTzRauusPQob0qeW3z3Alg3EkqwCvVYS/iChFqSxT+4PLjVafuLWRW5pv
         if8IHjr+I3ZqCKusw/6BjqCT3uj96wifFZH2BwCITrnMFWYT//fJkq2rRaEOSRcE9rzV
         7kxUv44ZayCRePm8Eqw1l/HvElAQpMh5JeiUWq5RbpNego3LxUNjnZmlgiuee6Xffm+n
         FOEAHdGCm8HtTmLkix7/zxjPMh0Q+KfC68wBczfkWnEJEUh3sGJOAJGwiBJaR/2Jqs7D
         wTPcvLoudJ6BYF5B2QHFcD9ZNaleJyxmKaP157uT3F3QidfmqbtrXEJWUVdRuZrqBLoY
         e47g==
X-Gm-Message-State: ALQs6tBgYgjMyqyeRami+z6CtVU7W1+2NpDPMfDPlvpOgtkfE0GJx5SO
        T2cFfQPP2cWdnqHtYapZC5E=
X-Google-Smtp-Source: AB8JxZpuO92axBWxV17/NyM48+WvXWbJdzwf8Y3vC+GeF3nV6S/gfTJcMFMuZRY8cOr88OWibYDF0w==
X-Received: by 10.28.178.72 with SMTP id b69mr16535109wmf.112.1525400681099;
        Thu, 03 May 2018 19:24:41 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id a14-v6sm19106923wra.84.2018.05.03.19.24.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 May 2018 19:24:40 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH v2 1/3] upload-pack: fix error message typo
References: <cover.1525213052.git.jonathantanmy@google.com>
        <cover.1525220786.git.jonathantanmy@google.com>
        <177c6eb7058adc1996f0595ddc3cc848c91b578f.1525220786.git.jonathantanmy@google.com>
        <CAGZ79kbTwqzKgZjN7GSXn-NpKX0kkDVYbXmdz6CC6TrDWbqyQg@mail.gmail.com>
        <20180503164155.6112764a927d50e23600dc49@google.com>
Date:   Fri, 04 May 2018 11:24:39 +0900
In-Reply-To: <20180503164155.6112764a927d50e23600dc49@google.com> (Jonathan
        Tan's message of "Thu, 3 May 2018 16:41:55 -0700")
Message-ID: <xmqqr2mstaxk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> On Thu, 3 May 2018 11:58:59 -0700
> Stefan Beller <sbeller@google.com> wrote:
>
>> > +       test_must_fail git -C server serve --stateless-rpc <in >/dev/null 2>err &&
>> 
>> Minor nit:
>> Why do we pipe stdout to /dev/null ?
>
> Usually there's a binary packfile produced, but not in this case. I'll
> remove it.

Hmm, when somebody breaks "git server serve", we probably would not
want to see the binary spewed to the output while debugging it.  So
I'd probably keep the redirection---it may be an improvement to use
">out" and then checking it is empty after the expected failure.
