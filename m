Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D509D1F42F
	for <e@80x24.org>; Thu,  6 Sep 2018 08:02:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbeIFMg7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Sep 2018 08:36:59 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45646 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbeIFMg7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Sep 2018 08:36:59 -0400
Received: by mail-wr1-f68.google.com with SMTP id 20-v6so10270501wrb.12
        for <git@vger.kernel.org>; Thu, 06 Sep 2018 01:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=pL/xBUqF9hXc2wYTsnfGG0zB+F+upE0BKktwfEY/MK0=;
        b=dMcWqNt8kbau0NwSKe8cWqTLYObr2kgNQQxMktakGTRuLHgKoEEJaxYONKxirv1Yf/
         MNpEiU35Bh6g09QthoRRxov+yhcmD+a14LliTBf3F6kMWS4mKIEm4Wdx7tUAnWkC3CJL
         YuQmEjuWaY5eEHTp7FgpyTC2AVfSJzBU+dOnUIRuwpBYoE1P3/n5td/5KT6ZXnuia4NZ
         edIX5XGJRYZVRy6KxCmxA1FYRv/OzHxydTAsDkPYNWRihO5g5TzvelwutJQlnLC7f6Ag
         wpRvLT6cBADxXiOLS27t/Jzf7xpKqlu8s5s62VYE62fbg6x5Iw9mKRC1RnnIOaTvidnB
         FfYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=pL/xBUqF9hXc2wYTsnfGG0zB+F+upE0BKktwfEY/MK0=;
        b=gGfBmVerK3ILPbOl985A5OfHzO6hBLEl0nsv2YkNASOGG2+YN4pg4BhI03ACxIBSaN
         ChXJfd4o+EmgdZGgiKe7wiKQmatQmeyXOdY+HL3SVXJnUIfUek0pdUDb2pniYp8EJ5y3
         wIvABpBQmPq89OXL67g355eOzsFmn8gzTnQ2+m5ouxsriqBmlcNEfVEQttr1hsQT8aCJ
         Y+WpcZHRv5hxRb5cBwJUvtybUOP4UNwknsNBT/Y5vj/vDC9XMJ9IR3rYtrZM1I8S4EDG
         bpc41Vr4s8atUjKZeON7cR2Xkq18UAXQgHp0fpXKrxMJslHlDrqo23Bykhv0/jZ+KUKQ
         J4jg==
X-Gm-Message-State: APzg51B9c/n4grQXI+gthhC3QFn2TL7kckFOYSq5Q6l4hsyg4NPAjMDu
        GQ/o4GzKbh8meEqXgiiWPWRaw0Pp
X-Google-Smtp-Source: ANB0VdaJVD1T3siV4s6Z0Ul29BATqgAIKTuutE3c6/pUJla5oZqGucO/dKrSdwcFVN9vjsexN8y9lw==
X-Received: by 2002:adf:f8ca:: with SMTP id f10-v6mr1325097wrq.237.1536220964588;
        Thu, 06 Sep 2018 01:02:44 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id b12sm1014904wrx.11.2018.09.06.01.02.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Sep 2018 01:02:43 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [RFC PATCH 4/5] t1700-split-index: date back files to avoid racy situations
References: <20180906024810.8074-1-szeder.dev@gmail.com> <20180906024810.8074-5-szeder.dev@gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180906024810.8074-5-szeder.dev@gmail.com>
Date:   Thu, 06 Sep 2018 10:02:43 +0200
Message-ID: <871sa7rr30.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Sep 06 2018, SZEDER Gábor wrote:

> +# Create a file named as $1 with content read from stdin.
> +# Set the file's mtime to a few seconds in the past to avoid racy situations.
> +create_file () {

Nit: Would be easier to read in the future as
e.g. s/create_file/create_old_file/ or something like that. I.e. so you
can see at a glance from the tests themselves what this is doing.

>  test_expect_success 'modify original file, base index untouched' '
> -	echo modified >one &&
> +	echo modified |create_file one &&

Style nit: missing whitespace after "|", i.e. should be "echo modified |
create_file one".
