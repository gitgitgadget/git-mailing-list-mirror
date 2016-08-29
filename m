Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E007D1F6C1
	for <e@80x24.org>; Mon, 29 Aug 2016 09:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932824AbcH2Jkr (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 05:40:47 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:35502 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932762AbcH2Jkq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 05:40:46 -0400
Received: by mail-wm0-f44.google.com with SMTP id f65so70588288wmi.0
        for <git@vger.kernel.org>; Mon, 29 Aug 2016 02:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=5vmVINMx8GuIBXQ5bw6Y819I6wl1cJFLVK+cBNikkrg=;
        b=hurfKrsaMK+f6ugbv9/+Squ5pbRT5W0fyVhXzRJkX5MiCTtPBaUDU93TW8jJLxsZ6D
         WzkU+hRXFrOFYhTD/cZb01z4IGZfMx7ER3PMhsD7s201vK5meYR5mXd3of5hpElc5qdw
         HEHGM11YR9KXKI4/eKiThqqjJDhHU/2ADUJZRmr70w3shVeyR/Rdme+e5llZdHz9gmBY
         qIbwcaG8r9NOhvzSpHIgmRn0gJaQKdrKFR8f3Y8T9XzVBjC8z8Yb6IJnlDFPRjdUePkB
         Qd9R7beDy28f2uG9g4+o1/DMeskrfoN1JISZpj+7juJyD7hkc0/PBPsWZCpZz0VH7ExC
         ldXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=5vmVINMx8GuIBXQ5bw6Y819I6wl1cJFLVK+cBNikkrg=;
        b=FWSYvLuB1QcA2+pY0+Ov8ySVG+ahBJTsc5NGo7/fy4+zRZ9ngblktUL+8pLFiRN+et
         PZelsZTLhuIQdThVZ0KmQIprIrWCj3TWEyKQ05Z86vvwYqfg9h60ktRQekOKP2syYDJ1
         u4TAXahnrQoHzm1QU1sA50kYXvDeBx4JEPg9pX59bKa039NchU935bqwfyMA46f4mkGz
         HefHvaUKWID1Z7XyuylXtQZNlnfJgUEf1KXh9RvTxQhSfYZLttUSMrC5kM36LltnRP1A
         hmzDf3WrjY0gOyOx8GR/LO1/nCOltI/xbEmzEmTgz3PcL1w+7zjRQ5ddxybjpYI02cPG
         apvg==
X-Gm-Message-State: AE9vXwOvaFj18VOfpoYq9+a+iBxl8vFclAm3b+R5XB5lgXTjT8QPsJo4IAnergZwxi5rKQ==
X-Received: by 10.194.81.137 with SMTP id a9mr16817437wjy.106.1472463644634;
        Mon, 29 Aug 2016 02:40:44 -0700 (PDT)
Received: from [10.32.248.244] (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id ub8sm33495544wjc.39.2016.08.29.02.40.43
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 29 Aug 2016 02:40:44 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v6 05/13] pkt-line: add packet_write_gently()
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqeg5bih8h.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 29 Aug 2016 11:40:42 +0200
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>, Johannes.Schindelin@gmx.de,
        =?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        mlbright@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <40503C79-2041-4928-B9A1-04D720D95492@gmail.com>
References: <20160825110752.31581-1-larsxschneider@gmail.com> <20160825110752.31581-6-larsxschneider@gmail.com> <xmqq4m68ldrg.fsf@gitster.mtv.corp.google.com> <0BD3A97F-A9FD-45A6-AF82-E01CC6B9BA89@gmail.com> <xmqqeg5bih8h.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 26 Aug 2016, at 19:15, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> Lars Schneider <larsxschneider@gmail.com> writes:
>=20
>>> Do you anticipate future need of non-gently variant of this
>>> function?  If so, perhaps a helper that takes a boolean "am I
>>> working for the gently variant?" may help share more code.
>>=20
>> With helper you mean "an additional boolean parameter"? I don't=20
>> see a need for a non-gently variant right now but I will
>> add this parameter if you think it is a good idea. How would the
>> signature look like?
>>=20
>> int packet_write_gently(const int fd_out, const char *buf, size_t =
size, int gentle)
>>=20
>> This would follow type_from_string_gently() in object.h.
>=20
> I actually imagined it would be more like your packet_write_fmt vs
> packet_write_fmt_gently pair of functions.  If you do not have an
> immediate need for a non-gentle packet_write() right now, but you
> still forsee that it is likely some other caller may want one, you
> could still prepare for it by doing a static
>=20
> 	packet_write_1((const int fd_out, const char *buf, size_t size, =
int gentle)
>=20
> and make packet_write_gently() call it with gentle=3D1, without
> actually introducing packet_write() nobody yet calls.

I see. In that case I would like to keep packet_write_gently() as is
because I don't see the need for a non-gently variant right now.

If there is a need for packet_write() then we could just add it and
move the packet_write_gently() code to packet_write_1() following your
suggestion. No caller would need to change for this refactoring.

If you strongly disagree then I would use the "two function" approach
you suggested above right away, though.

Thanks,
Lars=
