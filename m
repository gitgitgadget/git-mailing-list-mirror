Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90BE51F6AC
	for <e@80x24.org>; Tue,  3 Jul 2018 17:59:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934229AbeGCR7y (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jul 2018 13:59:54 -0400
Received: from mail-wr0-f178.google.com ([209.85.128.178]:33943 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934194AbeGCR7x (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jul 2018 13:59:53 -0400
Received: by mail-wr0-f178.google.com with SMTP id a12-v6so2864262wro.1
        for <git@vger.kernel.org>; Tue, 03 Jul 2018 10:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=WnRkk/sOROdidBLaFSni7ydVq4KqT/gPVvWfBfCTv8s=;
        b=f8zYCeA+E2bPq10flBKzfXIJoG4tuH5hUhUuzrKYEdUTbw9DBqiucpF3YofrmkNBOI
         M65Elu84ULYWQT+FcQn3t/ByjV9dVRJzeqwSyewj4ZFoBBeTl6u73/2ztBGlOX4cHETD
         nkiKbgIitqM17WiZEaqZLSi8cBBbC9Kis1jkoJ7xudvGjgao5WldxucPGebA3oAPRRF6
         Ts/WF+77WGEJTJVTIzrXvf8MSzl3Id1j0X174SYP8qg1cPjUON4RarYdcdVuf5CIHrZl
         rNhvHepMONlU5bHL/wg+7JmdRzczD4GLR1d1JXz2oSiy3A1d9sAmFOIG/uRXUuUIqiEy
         tYUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=WnRkk/sOROdidBLaFSni7ydVq4KqT/gPVvWfBfCTv8s=;
        b=pgt4+3AX9IyYfiqsCiHWwUDUT8IYI5V2N2l/Lrl7eC24Syzlu3HMkRwwzJdPfGzT8r
         VGyYrMxjCSZpa8osVl3SGsk0cFkfrs7u7nEx3C6P9AQHPcMpaQPg5QUidG1+qWhxiI1I
         M1N3IBeDWtZRX5KcNXEYEX/5h7yDWYEq7vVrBP4X390jV73RGa1hf7p974m7Mp6EgXhB
         cqymGuLceFtWrITTgrNJVvGH1VLjx0ABvp30WAVs6nUaNhazeYAOpciFix//K4yB+BTT
         NZtBFZpVNRvyCOnG6exQhVWmqA8H4hBK7hUPRhTuyW+66D/6/SCt1h9p/auFWASYNfE3
         k8YQ==
X-Gm-Message-State: APt69E1VDeZHZw9vEjTgOCvuUWjI35uVxbvg6EdpfQat+mMX5zBC6GTI
        f7JcKG2PgJawa+J629BPAYg=
X-Google-Smtp-Source: AAOMgpcBEDRi1pgGop8AdbTJoBV/JMbX/y22i6cEnFApBn2oT4Et1YtK2rMfUTzBabSRWEnQlcIpDw==
X-Received: by 2002:adf:e887:: with SMTP id d7-v6mr7572569wrm.43.1530640792272;
        Tue, 03 Jul 2018 10:59:52 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id a184-v6sm3060491wmf.30.2018.07.03.10.59.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 10:59:51 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: as/safecrlf-quiet-fix, was Re: What's cooking in git.git (Jun 2018, #07; Thu, 28)
References: <xmqqd0wawpwy.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1807031344080.75@tvgsbejvaqbjf.bet>
Date:   Tue, 03 Jul 2018 10:59:50 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1807031344080.75@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 3 Jul 2018 13:44:35 +0200 (DST)")
Message-ID: <xmqqd0w4ryi1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Thu, 28 Jun 2018, Junio C Hamano wrote:
>
>> * as/safecrlf-quiet-fix (2018-06-11) 1 commit
>>   (merged to 'next' on 2018-06-13 at b163674843)
>>  + config.c: fix regression for core.safecrlf false
>> 
>>  Fix for 2.17-era regression around `core.safecrlf`.
>
> Is this `maint` material?

Possibly.  Why do you ask?

