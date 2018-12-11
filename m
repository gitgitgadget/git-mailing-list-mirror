Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D31A20A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 16:28:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbeLKQ22 (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 11:28:28 -0500
Received: from mail-wr1-f42.google.com ([209.85.221.42]:46004 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbeLKQ22 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 11:28:28 -0500
Received: by mail-wr1-f42.google.com with SMTP id b14so14731365wru.12
        for <git@vger.kernel.org>; Tue, 11 Dec 2018 08:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=EqbROdsTCDSeU278Ga//XLRe4QgHVxlnExqytJKX8ew=;
        b=cbt14y9trcOsjiPBJGfKFL6fT7GLpVg7ADqa7VvdCcfY8W9tl4rb60NgC3Fnb+0oB1
         GLteXmwPPVbYJhJeslikOYK9ZEpyzg5/uCcqVEmVhib8nvwtEqSFnEBoGgBokzm9G7nj
         yUpVcKHG2M6AWCfYgVeVELvO48XnhGGQEtCoxIY1sZUpbCPUZq1/g4ekv6mL7EMVazib
         TQr998Qy1QYjvBM5n4Bv5AndzvUzsQmhjNRNqhbwKYodWNQ3XuHx5ijFFIbOq0ejsnIV
         WC/JBQ3rtvNjihuBqY7f778pOTpsgHT+OBHOUEQPxIZsjKfjsgJXL86apSJnCP30sPYc
         AKJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=EqbROdsTCDSeU278Ga//XLRe4QgHVxlnExqytJKX8ew=;
        b=BPABrG6lBWv5fvz0tXalUAcmU5ebloDjA5MzORpeAT07Ue80F90vPPh4U3wzuIPFBY
         SZ4Txe1fRL6mvdy7ij4pQGA9LqC3c7Cu4rcqxspOZAV04hQCnxZhKwAw0KqdKvHLCQqu
         b8eGqu1VK60aXvrvr/jqdaq6EG3wnhSFKDIc/jnSCX5IfOscRGCp+QEA8oClZn2+xArf
         Av0JNfVl0o6J54u3i+C5TtGjLdafKsU6nnLxKjYDWTo54N4octCkjqtMtoDCfD5suH6G
         od7GSHUqHf0nb1+axdXXBbGkky0K3N+SpYisfJXSKw1rN8QUftWE8bkxevg9s9ewG79r
         q0Aw==
X-Gm-Message-State: AA+aEWaZGNCsex3ZGrhE2Dy7RdQW+MfKcwVqEhVnvwU/Fdu9b4hlImJX
        20IVbyFiyBpdBg+J1sfnXjzCxW7F
X-Google-Smtp-Source: AFSGD/WyNecXhSZI7xkpY1aJKeyBfAP5OsD+CoftTyShX+42xfaxvtWb60tTYdkhMP0Qo0EFqqZvnA==
X-Received: by 2002:adf:e488:: with SMTP id i8mr14641153wrm.10.1544545706642;
        Tue, 11 Dec 2018 08:28:26 -0800 (PST)
Received: from evledraar ([5.57.21.48])
        by smtp.gmail.com with ESMTPSA id o8sm13924791wrx.15.2018.12.11.08.28.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 08:28:25 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>, george.w.king@gmail.com,
        git <git@vger.kernel.org>
Subject: Re: Difficulty with parsing colorized diff output
References: <799879BD-A2F0-487C-AA05-8054AC62C5BD@gmail.com>
        <20181208071634.GA18272@sigill.intra.peff.net>
        <CAGZ79kbd=2_eHdbVYwmNoAYupwnP3YDn6nT0m=v1CL0AkWXk=Q@mail.gmail.com>
        <20181211101742.GE31588@sigill.intra.peff.net>
User-agent: Debian GNU/Linux buster/sid; Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181211101742.GE31588@sigill.intra.peff.net>
Date:   Tue, 11 Dec 2018 17:28:25 +0100
Message-ID: <871s6oni3a.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Dec 11 2018, Jeff King wrote:

> On Mon, Dec 10, 2018 at 07:26:46PM -0800, Stefan Beller wrote:
>
>> > Context lines do have both. It's just that the default color for context
>> > lines is empty. ;)
>>
>> The content itself can contain color codes.
>>
>> Instead of unconditionally resetting each line, we could parse each
>> content line to determine if we actually have to reset the colors.
>
> Good point. I don't recall that being the motivation back when this
> behavior started, but it's a nice side effect (and the more recent line
> you mentioned in emit_line_0 certainly is doing it intentionally).
>
> That doesn't cover _other_ terminal codes, which could also make for
> confusing output, but I do think color codes are somewhat special. We
> generally send patches through "less -R", which will pass through the
> colors but show escaped versions of other codes.

I wonder if optimizing this one way or the other matters for some
terminals. I.e. if we print out some huge diff of thousands of
consecutive "green" added lines is it faster/slower on some of them to
do one "begin green" and "reset" at the end, or is one line at a time
better, or doesn't it matter at all?
