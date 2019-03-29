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
	by dcvr.yhbt.net (Postfix) with ESMTP id 53CF820248
	for <e@80x24.org>; Fri, 29 Mar 2019 22:12:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730459AbfC2WMc (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Mar 2019 18:12:32 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36079 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730357AbfC2WMb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Mar 2019 18:12:31 -0400
Received: by mail-ed1-f67.google.com with SMTP id s16so3322571edr.3
        for <git@vger.kernel.org>; Fri, 29 Mar 2019 15:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=pNKc8irWd/F4WKAxntz/GXga5pSOQV9bD2VIPVorol0=;
        b=PAnzoldmXDmBUAL8qVYtpCLRkVmhQT6l9fhlra/77pwobIyehtwf/G3M5WqGsf5DEq
         Sv0+uRUChTVjqSyN3fEvTtAu62w//saMV9EkPX9qV8K0XLBoiPCAB/V5uHVg7XJkPOLv
         HBU+xvhXGe5Hv81+R4jxbYlooa5HmQmx6UuifKI1Nlu3sFdikLVFzJFuugwA8xqxYcdU
         KbNYDUapN8Z3ZFlMBPGNh1dARxHISUPd5OmnJ5o41ykvIUAMewibWNG2DHrs3fMJG8hD
         0cZGilchlwfQV9ejjx2sjaDZZTPefteoefKyeo9t/6x+wmYa6lztAcBIZsstJ+pi/nJB
         7HGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=pNKc8irWd/F4WKAxntz/GXga5pSOQV9bD2VIPVorol0=;
        b=Rj6zogHDTFFcpjol1BAkSnJ5e/09T8+VteZD9GWZDaa94mDmLfNiXlehNyMUTv3Zjn
         v6gNbU/iDDRCWidnRwl9l8AWPNWNi4xlTbI+f2rYHypGRDh4fXreJqV0PR8c2VMI7nfu
         xOXoBiY+1ikRQ2t+Ol6HYxl3Pw9VJdskAOQES4w9zDXt58pS0pLv869Nr+veS4JfaGfh
         hKslwcN/L/NkPbrIjfKSuCaAukqp5vZQPPylYbJsQ8PaRViyVVH/n5u8K6hzma6PpTZR
         /U6lRToxNJ2i62Q6wKwE8rvaGSI/+ua/wRZ4Fue13ovO0MkweWY8K06m2iax2QE4oj/T
         cOCw==
X-Gm-Message-State: APjAAAXRa2yT9LPtD8g+zbl4QFqzF6jtLoLcMoTtBZADk/qrLZ1ZVyGA
        ovMBz1kaJ0D/F2Jdvj3Tg2eneSSS
X-Google-Smtp-Source: APXvYqygbbgdN2JfYgL1BI8AGwThkyYsn2NoR5aaPfjaQHvZ6OqxjAvxQ2gaB7okAbzOJG0oQcUwxA==
X-Received: by 2002:a50:86dc:: with SMTP id 28mr34384289edu.258.1553897549635;
        Fri, 29 Mar 2019 15:12:29 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id x54sm978319edd.35.2019.03.29.15.12.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Mar 2019 15:12:28 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, jrnieder@gmail.com,
        steadmon@google.com, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 7/7] trace2: make SIDs more unique
References: <pull.169.git.gitgitgadget@gmail.com> <pull.169.v2.git.gitgitgadget@gmail.com> <4352952677a11776a18ec9b6862cf358307cfafd.1553879063.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <4352952677a11776a18ec9b6862cf358307cfafd.1553879063.git.gitgitgadget@gmail.com>
Date:   Fri, 29 Mar 2019 23:12:28 +0100
Message-ID: <87lg0x9voz.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Mar 29 2019, Jeff Hostetler via GitGitGadget wrote:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> Update SID component construction to use the current UTC datetime
> and a portion of the SHA1 of the hostname.
>
> Use an simplified date/time format to make it easier to use the
> SID component as a logfile filename.
> [...]
> +static void tr2_sid_append_my_sid_component(void)
> +{
> +	const struct git_hash_algo *algo = &hash_algos[GIT_HASH_SHA1];
> +	struct tr2_tbuf tb_now;
> +	git_hash_ctx ctx;
> +	unsigned char hash[GIT_MAX_RAWSZ + 1];
> +	char hex[GIT_MAX_HEXSZ + 1];
> +	char hostname[HOST_NAME_MAX + 1];
> +
> +	tr2_tbuf_utc_datetime_for_filename(&tb_now);
> +	strbuf_addstr(&tr2sid_buf, tb_now.buf);
> +	strbuf_addch(&tr2sid_buf, '-');
> +
> +	if (xgethostname(hostname, sizeof(hostname)))
> +		xsnprintf(hostname, sizeof(hostname), "localhost");
> +
> +	algo->init_fn(&ctx);
> +	algo->update_fn(&ctx, hostname, strlen(hostname));
> +	algo->final_fn(hash, &ctx);
> +	hash_to_hex_algop_r(hex, hash, algo);
> +	strbuf_add(&tr2sid_buf, hex, 8);
> +
> +	strbuf_addch(&tr2sid_buf, '-');
> +	strbuf_addf(&tr2sid_buf, "%06"PRIuMAX, (uintmax_t)getpid());
> +}
> +

Thanks for turning my shitty half-formed idea into a patch :)

I wrote this on top to bikeshed this a bit further, wonder what you
think:
https://github.com/gitgitgadget/git/compare/pr-169/jeffhostetler/core-tr2-startup-and-sysenv-v2...avar:pr-169/jeffhostetler/core-tr2-startup-and-sysenv-v2

So e.g.:

    Before: 20190329-220413-446441-c2f5b994-018702
    After:  20190329T220431.244562Z-Hc2f5b994-P19812F

I.e:

 * Using <date>T<time> as is ISO 8601 convention/easier to read

 * <dateime>.<microseconds>Z, so seperating with "." to indicate it's
   the same value + add "Z" for "it's UTC". I'm least sure about the
   ".". Is that going to cause issues on Windows these days (the rest
   being the "extension"...).

 * I changed the hostname discovery so if gethostbyname() fails we'll
   print "-H00000000-" for that part, instead of "-H<first 8 chars of
   the sha1 for 'localhost'>-". Also prefix with "H" for "Host".

 * Wrap pids to 0xffff, prefix with "P" (Pid)" and trail with either "F"
   = Full or "W" = Wrapped (not the real PID).

 * I didn't add "T<datetime>" like "H" and "P" for the rest, since it's
   obvious what sort of value it is.

Maybe this is going a bit overboard, but I think it's easier to read at
a glance for humans, and since it's meant to be opaque to machines
anyway and the length is simliar enough not to matter I figure it's
worth it.

