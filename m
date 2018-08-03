Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3A721F597
	for <e@80x24.org>; Fri,  3 Aug 2018 21:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731986AbeHCXpS (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 19:45:18 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53604 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729828AbeHCXpS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 19:45:18 -0400
Received: by mail-wm0-f66.google.com with SMTP id s9-v6so7672563wmh.3
        for <git@vger.kernel.org>; Fri, 03 Aug 2018 14:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=hezpz5hSlPXSzDJ2I1IYrVi7C8Hibr3RyIVrScg+DVY=;
        b=qU1tl237PT6huIc8kyvlari08D7rZgjYCkCbBiNZUKC03hKbxtrEo4hxwaSn8rcRSh
         1tAy3e03WLphmidPCqbaaKykeL5X5ihRG2l1/H5Sx192IdN8E0BJlGgpxCtduoKGk1sW
         O/+88GJJS3hLr6SE6jMVJOWAl9NzCtAORTxr0pXvaa2VzSJv5t4eEOwL9zrj10KqFTJ5
         Veb+/4tqESYcCMUQP+zsuV/VL31qWiG0DVA+QvqubZz9FoLVKC/0ozNTWq6oF3haZpe+
         BpfiRNUkxJ8hvFDlQP10JAl7+Zgo21fOARr+JLAWGKMkU9ZyXgb+ijsfw+Go34zEPH06
         uVhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=hezpz5hSlPXSzDJ2I1IYrVi7C8Hibr3RyIVrScg+DVY=;
        b=WnWhZtgdsJf2Z4MDU+KCWEoEE7AC/QBWo7Pl9qfm/sR2S5LsnB9wME9UPdU0LhGEus
         hKHULQQRwHs4aDQCBV9WOb8yaM0gm9bsxB9lDT4XfKxipPxksRKCpv91jCaM3EDfj/uj
         IlG9tdKnImO1U7KPFXEIsHz6+0g8P6nr+lHK67enj8XI8vnzOw1Q2drS9KiY+6yPMj/X
         yI2MQWeJzB1ZW81qmcOaGrqG7S+tuyOG6TLbFOgo//sm1cy5OCF64i//w3iLxIbU11Ia
         4w0LqUaSsE9ncoWUtYbiDwrvHPxsN8fpvwNm9dxwIhxJSn5W1HF00TdA8bASn0DOMwbX
         SDRA==
X-Gm-Message-State: AOUpUlG0ODbJuSalR3M/yAyUqd1jPFNdLBoyOKyVDxn2zoXDt8j8QEcN
        1pRtrZ+0XteqnLBOi3SwDcA=
X-Google-Smtp-Source: AAOMgpf1qxpAgDanrAtcUr7kFGiuqr2tLrhAVatNhiAJfXRDDVjYKCAY5ZbyyDPeNbWlDqGYC5329w==
X-Received: by 2002:a1c:10d4:: with SMTP id 203-v6mr5639651wmq.158.1533332831414;
        Fri, 03 Aug 2018 14:47:11 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id w8-v6sm6193504wrp.72.2018.08.03.14.47.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Aug 2018 14:47:10 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] add a script to diff rendered documentation
References: <20180803205204.GA3790@sigill.intra.peff.net>
        <CAPig+cSDM4vjuhwfuapuPpjjOmXbrhz-i0eVhtShp+nOYReLnA@mail.gmail.com>
Date:   Fri, 03 Aug 2018 14:47:10 -0700
In-Reply-To: <CAPig+cSDM4vjuhwfuapuPpjjOmXbrhz-i0eVhtShp+nOYReLnA@mail.gmail.com>
        (Eric Sunshine's message of "Fri, 3 Aug 2018 17:33:17 -0400")
Message-ID: <xmqq1sbfw2ap.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

>> +               shift; break ;;
>> +       *)
>> +               usage ;;
>
> There doesn't seem to a usage() function defined anywhere (and
> OPTIONS_SPEC doesn't seem to be used).

Isn't this using the parse-options thing git-sh-setup gives us for
free?
