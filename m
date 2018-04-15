Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11BF81F404
	for <e@80x24.org>; Sun, 15 Apr 2018 16:54:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752493AbeDOQyQ (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Apr 2018 12:54:16 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:34580 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752460AbeDOQyP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Apr 2018 12:54:15 -0400
Received: by mail-pg0-f49.google.com with SMTP id p10so2753194pgn.1
        for <git@vger.kernel.org>; Sun, 15 Apr 2018 09:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=keT/QKlCp0JoleugnS8JDP8fnAgC8nEIGTIWwfnO/CI=;
        b=cJX3s4FZr5JQGQPdpeXyQM1Xl3+kjiL9Q2MS4vCBXxlOyKZin9Fgxjs6UVzusMXkEY
         pdEToDw3hujkS2Rf2jtKQblIWBYe9TPFTxHNArgmSbikosWMkkhg1KJFGZTIDRTCQM9N
         t4RjxL8jxqSpIH0JNgkr7eWgRKmCTU2e1OQ8CSMv3wKgPBlWFUv4oX3SJUJ1S0cegEXn
         s6UHgjE/kBtY2ULElzrsOvbfAH6ndO8LuRvHUxejKbtjhDm/MLVkxF+50+zGHt64BBbW
         BwzSvjC/K5GBniaQSn8Jfm7+8JaT2QWhrsGii7uj3GrIEgZczaOby7ISZyr/SAERMsvS
         NGbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=keT/QKlCp0JoleugnS8JDP8fnAgC8nEIGTIWwfnO/CI=;
        b=h1wX6RodHCDbmtGaO3CEnkLRugzh8qkaWnCJ9CKe5Vd//Rw4ZFix7NQAkpykgQQvG/
         yI5JYhHWtxPhuDEoIKHbd87dCHEKnzfId30rQ1HRxZXwE/FRtNq34zTi/vMNg5GDslm3
         35CRfJBnEKuec3sxsLOO86YFuM1pvnjJ7MoLlU0ptSp+RpaTDYGSbI+PXLHDRJUmwFUv
         hxVa/PnyGuwEN/On+Ek2qFMAnqkCmS/wRxnhsNptL+R353h04tSdhhXQppZyd6BHRmHI
         97mlq7a9NJFgxn9PeKqEpiCV9rSsopeUeegv5+w8ADS5UNLYO8HqJUBshOEdGczftldR
         fepg==
X-Gm-Message-State: ALQs6tDZ/QOdqKXWQbeQVoRYjdh4Bxq1myuHdtfbQS8LjRPUpmng9pkT
        Xtquq/5SRV/xCN2DEXMc7ic=
X-Google-Smtp-Source: AIpwx499w01XryAZPX1BycxxQosG5FzLOwQPqUk4tlBd7CAkqngiY+GX2ImaF3hE7UJja0a63A8QGg==
X-Received: by 10.99.114.78 with SMTP id c14mr7685123pgn.195.1523811254295;
        Sun, 15 Apr 2018 09:54:14 -0700 (PDT)
Received: from remj8gtty1.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id d4sm19076449pgc.43.2018.04.15.09.54.07
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 15 Apr 2018 09:54:13 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v11 06/10] convert: add 'working-tree-encoding' attribute
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <583f9ec3-3aef-d823-9fd6-3cc126ac47f6@web.de>
Date:   Sun, 15 Apr 2018 18:54:02 +0200
Cc:     Lars Schneider <lars.schneider@autodesk.com>, git@vger.kernel.org,
        gitster@pobox.com, j6t@kdbg.org, sunshine@sunshineco.com,
        peff@peff.net, ramsay@ramsayjones.plus.com,
        Johannes.Schindelin@gmx.de, pclouds@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <8EBD3571-D5FA-471B-BD5F-D8401043D503@gmail.com>
References: <20180309173536.62012-1-lars.schneider@autodesk.com> <20180309173536.62012-7-lars.schneider@autodesk.com> <20180318072435.GA24190@tor.lan> <0FEBEFB2-46D6-4688-AF07-654B56FFF9D8@gmail.com> <583f9ec3-3aef-d823-9fd6-3cc126ac47f6@web.de>
To:     =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 05 Apr 2018, at 18:41, Torsten B=C3=B6gershausen <tboegi@web.de> =
wrote:
>=20
> On 01.04.18 15:24, Lars Schneider wrote:
>>> TRUE or false are values, but just wrong ones.
>>> If this test is removed, the user will see "failed to encode "TRUE" =
to "UTF-8",
>>> which should give enough information to fix it.
>>=20
>> I see your point. However, I would like to stop the processing right
>> there for these invalid values. How about=20
>>=20
>>  error(_("true/false are no valid working-tree-encodings"));
>>=20
>> I think that is the most straight forward/helpful error message
>> for the enduser (I consider the term "boolean" but dismissed it
>> as potentially confusing to folks not familiar with the term).
>>=20
>> OK with you?
>=20
> Yes.

Great!


> Another thing that came up recently, independent of your series:
>=20
> What should happen if a user specifies "UTF-8" and the file
> has an UTF-8 encoded BOM ?
> I ask because I stumbled over such a file coming from a Windows
> which the java compiler under Linux didn't accept.
>=20
> And because some tools love to put an UTF-8 encoded BOM
> into text files.
>=20
> The clearest thing would be to extend the BOM check in 5/9
> to cover UTF-32, UTF-16 and UTF-8.
>=20
> Are there any plans to do so?

If `working-tree-encoding` is not defined or defined as UTF-8,
then we would return from encode_to_git() early. That means we
would never run validate_encoding() which would check the BOM.

However, adding the UTF-8 BOM would still make sense. This way
Git could scream if a user set `working-tree-encoding` to UTF-16
but the file is really UTF-8 encoded.


> And thanks for the work.

Thanks :-)


- Lars=
