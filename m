Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AB791F404
	for <e@80x24.org>; Mon, 22 Jan 2018 23:05:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751151AbeAVXFX (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jan 2018 18:05:23 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:43373 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751060AbeAVXFW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jan 2018 18:05:22 -0500
Received: by mail-wm0-f47.google.com with SMTP id g1so19301130wmg.2
        for <git@vger.kernel.org>; Mon, 22 Jan 2018 15:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=QdfBeYsMhzUU9SlHaBFkd0iGO6xhEnWt9XkPDGENW50=;
        b=pT6eGrZkWuRmkUgTGUSlgEohUEu4LdTZIBcUFlQjClWgTOZtVWPjaBVCzMCurxN3IY
         jvOryQBxOeOOPtzdJDN8aUWB9q3IAu+A1gRxG/NxnTFO5XVAeuokfIELxKqwtJkpVnyb
         h2BjPco2Xa7zKOhnCDYTnnKOlpOG+H9137rwMLjsVWJ/n/EXamEli1EpDq4F1iOM4nZy
         QiThduVWcyV4W6TqY2z8BUEqCQhO59UmGm6vXr5iLPCMdTprt8xU1oR1HXSjXDoLM4X3
         CKbsCmIZ3Ep5kabu/e5zF4huJpM1yND2ckHLo0Ni6AIY+sC0gJNnsPKMQCTK0MIXVqEy
         PUmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=QdfBeYsMhzUU9SlHaBFkd0iGO6xhEnWt9XkPDGENW50=;
        b=MLma/Y1kCYS+pbenzN3o4D/eCeHzZUwQb9wm/jEVmTU9+rlSEQzh1OXXVYos8w65jl
         d2xPtonvRlq5fF8rRSX33JKbEJQbD3Wzc85G7z80dpfQYYiKOZxYPxoF/cJO2OiyEwAy
         3RNh1L5R8gOawpTLlMdK78NXftHlzv6mxtK7hgURVIKzkTgpuoxaog0P8KRu9PkZgt6W
         CI/jBQADgKTCKj58xK+CL5F9dacLfNcibL7jWmBhKCXEiWss2WOZ7qpQNLec4oqvK+AA
         iOBYmJkjAWCUP6AZ1YV5eSpjr02Bee0TMtNIDP62DzzTAKw4Pq4T4n34C8PHeyKED9Fl
         nJcg==
X-Gm-Message-State: AKwxytew+EtGAVTrLNMjp2tRRKZR73rghOjTlc3om8mjTrOhynNu+Ndi
        gXLkWUwBdU2MDbvu3OUzlH0=
X-Google-Smtp-Source: AH8x225D/bQg6V4u1wMZ27IuTYw2voRP1HNRCdIMT+LUFXAMvjlDsSBslkWqQ6mq/bYRNQXJjuGZqw==
X-Received: by 10.80.165.21 with SMTP id y21mr16359824edb.148.1516662321636;
        Mon, 22 Jan 2018 15:05:21 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id w17sm12269853eda.96.2018.01.22.15.05.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Jan 2018 15:05:20 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Michael Giuffrida <michaelpg@chromium.org>,
        Michael Schubert <mschub@elegosoft.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 07/12] git remote doc: correct dangerous lies about what prune does
References: <20180121000304.32323-1-avarab@gmail.com> <20180119000027.28898-1-avarab@gmail.com> <20180121000304.32323-8-avarab@gmail.com> <xmqq7es9mzna.fsf@gitster.mtv.corp.google.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.0-alpha3
In-reply-to: <xmqq7es9mzna.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 23 Jan 2018 00:05:19 +0100
Message-ID: <87vafth4uo.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jan 22 2018, Junio C. Hamano jotted:

> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>
>> +Deletes stale references associated with <name>. By default stale
>> +remote-tracking branches under <name>, but depending on global
>> +configuration and the configuration of the remote we might even prune
>> +local tags....
>
> An optional clarification
>
>     s/prune local tags/& that haven't been pushed there/
>
>> +... Equivalent to `git fetch <name> --prune`, except that no
>> +new references will be fetched.
>
> `git fetch --prune <name>` (dashed options first and then non
> options), just like you wrote in the previous step.

Thanks. Will fix both.
