Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58C841F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 17:35:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731636AbeKNDeE (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 22:34:04 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34531 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731537AbeKNDeE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 22:34:04 -0500
Received: by mail-ed1-f67.google.com with SMTP id w19-v6so11253893eds.1
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 09:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Q5as8fgCFT8dU7gHu7ExisvCfot255YYQKal0zRub9I=;
        b=EQmW8MD7kzTO+oaTbMKIVDhR0Iqk/wax/K/9Ms7T5x55zHl0ZaXt7TeJpQs0ocMQcE
         eYVfcZ+AH13XubN2mqjW3Ranb8T83VTHONi+a+SYYj8ylcsgS7zD9kTSl0fMCTxfwXN0
         G6JpNwmQ1srTj5bFFbVbjVnwr+9r2PR2+m3bNojkML/lcst+En7bfCdYU/nO6voDuh9M
         +MeU3URGtd/RZiGiq7nJhO0a+6AqRQ2MPufg0r25A6oquS6mR9amU3ipltL1cOkr4B2l
         Z5VCR5PJ1t3HaGMNtdaUFBvZeTJKPV/l0I6aO0BdRKD0vf8h7wrW5mW7dYMOt119IJvK
         MvXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=Q5as8fgCFT8dU7gHu7ExisvCfot255YYQKal0zRub9I=;
        b=SgrEdAdbJ3JTbWTeb2wWowYKzVV0gShO912fwq7Q/ClEYoKAZgGsJ47qQc8Z5rTAKE
         CSZT40Iu8QNRvqbH3s+cR3ISi5AnwFX+qg6LBKnJPmn5Dnzfyw2n0Ydwu3bFPwYUC4aY
         l5Mu7zfg0OTlnT78LxY/iNZWUQzqMhibdrsGYwrPwcIbHkE3LKtGQtN36lxIRu3+VUpX
         DnwPaUXWBYt8YKuC4v67Ngcmdgi8VcWoydC1mKY+y6LnDIuDFEyJu6hu/MYsKd8Co+kj
         1cZndYDCtFmGfRutgRvoLM169FU6e7ixD3XBPZ02RZuPLkdQ+Buny0Dzx6tdZ0rFWqMi
         iOtw==
X-Gm-Message-State: AGRZ1gLNYh94aL8zqMxYD4AbvxBC5ibMq8DxcMuvqeXwzF+ZO6LebbWo
        zJig0pcxo1Swp0iplyzcESeUAevb0EE=
X-Google-Smtp-Source: AJdET5cTz2NhzEvXLCQHWgOtwFRXEpO/HfyYBzPZtLNwcarq4XODQAlXeBxOr5qdglAVzXOsYwv0Nw==
X-Received: by 2002:a50:b082:: with SMTP id j2-v6mr16984834edd.150.1542130497391;
        Tue, 13 Nov 2018 09:34:57 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id q4sm953084eda.50.2018.11.13.09.34.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Nov 2018 09:34:56 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [RFC/PATCH] read-cache: write all indexes with the same permissions
References: <874lcl2e9t.fsf@evledraar.gmail.com> <20181113153235.25402-1-avarab@gmail.com> <CACsJy8CaAC0UP+VxYU7zbdQc6DtKYa-FzOnbpNf+_P2L3zfUvQ@mail.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <CACsJy8CaAC0UP+VxYU7zbdQc6DtKYa-FzOnbpNf+_P2L3zfUvQ@mail.gmail.com>
Date:   Tue, 13 Nov 2018 18:34:55 +0100
Message-ID: <8736s43mps.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 13 2018, Duy Nguyen wrote:

> On Tue, Nov 13, 2018 at 4:32 PM Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
>> I won't have time to finish this today, as noted in
>> https://public-inbox.org/git/874lcl2e9t.fsf@evledraar.gmail.com/
>> there's a pretty major bug here in that we're now writing out literal
>> sharedindex_XXXXXX files.
>
> It's not the end of the world because create_tempfile opens with
> O_EXCL so if two processes try to create it at the same time, one will
> fail, but no corruption or such.

Right, no race there.

>> Obviously that needs to be fixed, and the fix is trivial, I can use
>> another one of the mks_*() functions with the same mode we use to
>> create the index.
>>
>> But we really ought to have tests for the bug this patch introduces,
>> and as noted in the E-Mail linked above we don't.
>>
>> So hopefully Duy or someone with more knowledge of the split index
>> will chime in to say what's missing there...
>
> I don't have any bright idea how to catch the literal _XXXXX file.
> It's a temporary file and will not last long enough for us to verify
> unless we intercept open() calls with LD_PRELOAD.

Sorry for being unclear. I don't mean how can we catch this specific
bug, that would be uninteresting and hard to test for.

I'm asking whether the bug in this patch isn't revealing an existing
issue with us not having any tests for N number of sharedindex.*
files. I.e. we have >1 of them, merge them and prune them, don't we?
