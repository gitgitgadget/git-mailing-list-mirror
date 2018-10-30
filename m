Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57D3A1F453
	for <e@80x24.org>; Tue, 30 Oct 2018 02:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbeJ3LBb (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Oct 2018 07:01:31 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:40101 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbeJ3LBb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Oct 2018 07:01:31 -0400
Received: by mail-wr1-f49.google.com with SMTP id i17-v6so10750714wre.7
        for <git@vger.kernel.org>; Mon, 29 Oct 2018 19:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=U89SZ4dVH1P6s2ZklkqUPhpAoNzH1XoZMx7nyClmhik=;
        b=MvKI1hrGvnDfrAafxsjhjGZyK/N3YRszssSnGiLF1FEqUk/KNEDOT1TODCpDMySx0y
         aNrHoyHAZ3FY4cr/6lzh3MNTQaZk8BMJuYFkWFqcmHL4T0+Bpff9YReUOMqsYSxBnfH3
         HDQ0T46lZSOWtOTFj0M9/VPtljnxa2QzDWpkVoJNGcGr0LUc7CeB02qB97GupXDVipah
         CUGo2bXb8kmQfPoc9Pm7jV7SftuwER4nbglJmIV05/RXOnLDx7btXoVxINYU8vl5dhp5
         UkgUD6s2WRxHhdHZ+q3h9fJS/vOViPVxmEWhBZ6+SSM0nh9hkEhWRfiAfMdCLoLqoCO7
         jrhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=U89SZ4dVH1P6s2ZklkqUPhpAoNzH1XoZMx7nyClmhik=;
        b=Ro6XPhqC5lypYWb52Fu2uPE40hJATaj+2oafe29fRWXIZbyTARZ+lyTEQHPkMiCm+9
         G694QT7zNDFHWZLUaaYjbF3dqieP9rHrAhzAqgnFQx2qiq/50+jcZNGGscUxIvR0nepT
         BZm9RVJGXLwB83ULRRtjoc/7mPxzMA4JnyxilVSdGGJyHsSzonIBL6JV+Yyz9vDzN6e/
         ZuqQNIpa7QnmXZq7McXJkpMSWRXUEcabgLeAgO84qlMa79qZmYQIIQHepetHy2DcmYar
         rYrtAqkKSOMsUbMyPDICdQrTNO7V7QOxabp0u23UnsAo8h3Joji3nBSy3Tw4hcD7XU+v
         Bfqw==
X-Gm-Message-State: AGRZ1gK5eGTXAivNYOcL/X9NgDb64aFD0TQia0NOeX6y3a7YJX/cBbiy
        sG/vyc18C6x5aaR3yEcrpm8=
X-Google-Smtp-Source: AJdET5flVe6PUu/brfWO3c+3MwBxR5oaTZtBjtlIjpBquHw8gM06uIzKkvtAk/1wHoliSSgyWfCCOg==
X-Received: by 2002:adf:e5ca:: with SMTP id a10-v6mr11913742wrn.253.1540865402556;
        Mon, 29 Oct 2018 19:10:02 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id i11-v6sm13607731wrs.87.2018.10.29.19.10.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Oct 2018 19:10:00 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: js/mingw-http-ssl, was Re: What's cooking in git.git (Oct 2018, #05; Fri, 26)
References: <xmqqo9bhcf89.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1810261407030.4546@tvgsbejvaqbjf.bet>
        <xmqqftwsdevm.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1810291418300.4546@tvgsbejvaqbjf.bet>
Date:   Tue, 30 Oct 2018 11:09:59 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1810291418300.4546@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Mon, 29 Oct 2018 14:22:16 +0100
        (STD)")
Message-ID: <xmqqftwo2nig.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> >>  On Windows with recent enough cURL library, the configuration
>> >>  variable http.sslBackend can be used to choose between OpenSSL and
>> >>  Secure Channel at runtime as the SSL backend while talking over
>> >>  the HTTPS protocol.
>> ... 
>> Yeah, but "http.sslBackend can be used to choose betnween OpenSSL
>> and Scure Channel" applies only to Windows ...
> ...
>> > The two patches on top are Windows-only, of course, as they really apply
>> > only to the Secure Channel backend (which *is* Windows-only).
>> 
>> Yes, that is why the summary for the topic as a whole focuses on
>> Windows, as that is the primary audience who would benefit from the
>> topic.

How's this?

    On platforms with recent cURL library, http.sslBackend configuration
    variable can be used to choose different SSL backend at runtime.
    The Windows port uses this mechanism to switch between OpenSSL and
    Secure Channel while talking over the HTTPS protocol.

