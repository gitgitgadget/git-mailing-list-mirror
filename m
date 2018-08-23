Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 665931F954
	for <e@80x24.org>; Thu, 23 Aug 2018 14:27:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730300AbeHWR52 (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 13:57:28 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:37010 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727597AbeHWR52 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 13:57:28 -0400
Received: by mail-wm0-f43.google.com with SMTP id n11-v6so6039493wmc.2
        for <git@vger.kernel.org>; Thu, 23 Aug 2018 07:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=2zXs7Nl3Mzy7WjoIGsa95G9UeN0BG6hQRzxxFaAJEBU=;
        b=h2sOpZGLkM8ZmzEmMcgkMwQvhBkcGLhm5W+ggHsXUCo7lgT4ITOPq3q+XyzMzUHK7M
         33qUaA/L6viSZraDjiOeYtvNKbvutV4rTzcd+HgTgRzejoNyCq7xgw24Tz+IL25+AXJh
         CQquZunQfvGj0MO5er65D8/II+4SEeXaN/vru8emTO7n7tSYLm264gd3JrKpwYdQVexO
         uMCyT/iHBuMhWWzvRN5ehxZ/Erl7hsFFV+AItD/G8FxIE3JhG9bDoMa4czmuNR23Kzn4
         ZZLK2yeQkz4t08G3wmtIZ5gZMt/X7qSfAQHEyMxi6jh3C4n8rAN2cRkZhTxDNSMhqo2T
         tsBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=2zXs7Nl3Mzy7WjoIGsa95G9UeN0BG6hQRzxxFaAJEBU=;
        b=MiJ6dgKR82DGFEUlXjMpzTxTNG04cKh3rb+wrNXzyIPiRQj9DXteKi1D4lzRD4jwvU
         5/99TlQp0i2QEBdDMyj3DIn8OO8F75XuxkQ2OtVAaLzYo59fk6a5lr1p4o+HxjQ8qI/x
         4pccvlDZUCyzgDuLyBb+tRd/a/3U/6PT66qErtAYYj/6Sj67uSrmBOBxtP0NtB26UAqe
         lOvMiG0airQfdJKo1QBGVDuD7yOdDYY2GcjJ6cBThM/TWp3HAq+hr9DvXCeBTw9mfvS3
         5m2NH+GHk0hWTh6mxfZoFfK/x6L7XZoH9ff34Hu3QjAKNpev1O0cEYMZQgFGK9B7Hba5
         GnvQ==
X-Gm-Message-State: APzg51BNAFCjLxoBZHT//Fpy93Am2WLBp30lrNXJwdguLWbmChB2tIuW
        SnsAHpvO6KFNjqerP6hs/Z4=
X-Google-Smtp-Source: ANB0VdafkTxl11hkZR+zX7rBzIbrSucxCG2VhHSNRz+uWCX/h1S3oaF3s9sVlSrEC1EvzFEgnxhNTQ==
X-Received: by 2002:a1c:b213:: with SMTP id b19-v6mr5136450wmf.141.1535034451776;
        Thu, 23 Aug 2018 07:27:31 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id w4-v6sm6630570wro.24.2018.08.23.07.27.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Aug 2018 07:27:31 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Edward Thomson <ethomson@edwardthomson.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        demerphq <demerphq@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: Questions about the hash function transition
References: <878t4xfaes.fsf@evledraar.gmail.com>
Date:   Thu, 23 Aug 2018 07:27:30 -0700
In-Reply-To: <878t4xfaes.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Thu, 23 Aug 2018 16:02:51 +0200")
Message-ID: <xmqqy3cxjgz1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

>> - The trailer consists of the following:
>>   - A copy of the 20-byte SHA-256 checksum at the end of the
>>     corresponding packfile.
>>
>>   - 20-byte SHA-256 checksum of all of the above.
>
> We need to update both of these to 32 byte, right? Or are we planning to
> truncate the checksums?

https://public-inbox.org/git/CA+55aFwc7UQ61EbNJ36pFU_aBCXGya4JuT-TvpPJ21hKhRengQ@mail.gmail.com/
