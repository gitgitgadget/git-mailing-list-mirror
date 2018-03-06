Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 584A71F404
	for <e@80x24.org>; Tue,  6 Mar 2018 23:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754039AbeCFXMv (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Mar 2018 18:12:51 -0500
Received: from mail-pg0-f53.google.com ([74.125.83.53]:43564 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753805AbeCFXMu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Mar 2018 18:12:50 -0500
Received: by mail-pg0-f53.google.com with SMTP id e9so140692pgs.10
        for <git@vger.kernel.org>; Tue, 06 Mar 2018 15:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=tW5yQWw3LxbBIvZ6pfVu1TfQhhf90ty9XQSJR17iYG8=;
        b=juXkHgrwH3tSzfi2XdnEmQCcGHC7om70mtNjdo/Yp+K/huArskaN8D+FDo6+aTvY7f
         EU3zE5QAom1ZKvi2ujs/42wAh0NZxWkDU51sJHKVMGg/M0onx9sbmxQWLi8d89NFz0j3
         DLgGG73FFIta37JZKL5L1EkEheR6DV0xVHI00x3AK9iyC9BvZQM+TmRWhbEwLp33+iJF
         vhgj963FhpK0nJ6ks6jX5rh2DdRaf9797S10FTl4ijIYoMiWMcbQuUldTqYifhkmOO2f
         TyzVoZgaJcEVyeA9RwmBME4EydF2DhOUUGNfOdNldi/uvc0WFiro93n6E+7l82hycxct
         Y6Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=tW5yQWw3LxbBIvZ6pfVu1TfQhhf90ty9XQSJR17iYG8=;
        b=Tdrm49Th3NyjCUv5X/GPlXWNfIrxDEDtpJhMNlD0RZ85gDG+K6SKNIq5NSl54+01W6
         4q33nxu8T4pwVtFZ5kYlZdMd5OSd/5LVcjBI9C/L5lwPUIv6mIqJbZOIBNxxzbrZGCKp
         nzHpVcyyrLSjzbRn8d2omj1/XU/CxuiowUyOwLQduNCpBCR5diXRRqk0lUad2Dgh2O1O
         ATrk6hjIhyFCKEYdd0wX+TGLk2s4d9CGd0FlxlWkLNw+a7dHIk1okAFmzAnitaxaUNwj
         zyBdOG6aQ0K0LIYVLUeX4U30V52+bY4bQd+3mjF0eu5gwOyGWP0AMmrgAmpDUjQ7aNYe
         TXYg==
X-Gm-Message-State: APf1xPDait/C7MfNb1dV45thUvFSZNFayqXkHuFqxCLXS2a3te+GKWxW
        +jnlZ33/zjPhO3/CqruVIq8=
X-Google-Smtp-Source: AG47ELvNUoRXLfFqmCkIFYkuE8T7N8yHFdQx4jfYF1sgBEuM+/0lQTAOrbSqe3GvmsCL5pZnf0kVAQ==
X-Received: by 10.98.238.2 with SMTP id e2mr20455154pfi.68.1520377970167;
        Tue, 06 Mar 2018 15:12:50 -0800 (PST)
Received: from neu8r3hm32.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id h80sm32394374pfj.181.2018.03.06.15.12.47
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Mar 2018 15:12:49 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v9 4/8] utf8: add function to detect a missing UTF-16/32 BOM
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqq4lls3irx.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 7 Mar 2018 00:12:44 +0100
Cc:     lars.schneider@autodesk.com, git@vger.kernel.org, tboegi@web.de,
        j6t@kdbg.org, sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de
Content-Transfer-Encoding: quoted-printable
Message-Id: <EC8DF4D3-CDF5-4CEB-BD18-585341BBB2C5@gmail.com>
References: <20180304201418.60958-1-lars.schneider@autodesk.com> <20180304201418.60958-5-lars.schneider@autodesk.com> <xmqqvae92ajv.fsf@gitster-ct.c.googlers.com> <0DCED348-C6DB-49B2-8C0A-E4E1F485B255@gmail.com> <xmqq8tb43jfe.fsf@gitster-ct.c.googlers.com> <xmqq4lls3irx.fsf@gitster-ct.c.googlers.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 07 Mar 2018, at 00:07, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> Junio C Hamano <gitster@pobox.com> writes:
>=20
>> Lars Schneider <larsxschneider@gmail.com> writes:
>>=20
>>>> Also "UTF16" or other spelling
>>>> the platform may support but this code fails to recognise will go
>>>> unchecked.
>>>=20
>>> That is true. However, I would assume all iconv implementations use =
the
>>> same encoding names for UTF encodings, no? That means UTF16 would =
never be
>>> valid. Would you agree?
>>=20
>> After seeing "UTF16" and others in "iconv -l | grep -i utf" output,
>> I am not sure what you mean by "Would you agree?"  People can say in
>> their .gitattributes file that this path is in "UTF16" without dash
>> and that is what will be fed to this code, no?
>=20
> FWIW, "iconv -f utf8 -t utf16" seems not to complain, so I am
> reasonably sure that people expect downcased ones to work as well.

Sure! That's why I normalized it to upper case:
=
https://public-inbox.org/git/CAPig+cQE0pKs-AMvh4GndyCXBMnx=3D70jPpDM6K4jJT=
e-74FecQ@mail.gmail.com/

After thinking about it I wonder if we should barf on "utf16" without
dash. Your Linux iconv would handle this correctly. My macOS iconv would =
not.
That means the repo would checkout correctly on your machine but not on =
mine.

What do you think?

- Lars

