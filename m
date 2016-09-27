Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7B37209A6
	for <e@80x24.org>; Tue, 27 Sep 2016 18:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751631AbcI0Shu (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 14:37:50 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:34427 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750899AbcI0Sht (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 14:37:49 -0400
Received: by mail-qt0-f196.google.com with SMTP id t63so655484qtd.1
        for <git@vger.kernel.org>; Tue, 27 Sep 2016 11:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=+F4C0obdLqxtxvnXgc6NBTXBI4MQZcojuR7xEpcxFEY=;
        b=mSGos8B2de/bzEu3KgaG7r1vOGFKr6ZyaXr8VzN7xDaiHySe7XmpeJoSrmnw5TjK1+
         bftMVnNvCEJNfG3VUBLuPwV0W9npleD+bRAgMHqXOck0RxnzL/0tCxmQ0tGNxX+84BsH
         S0ajmMPGsEom/dEiOrJ5HNnVIC7OQyiMTFKpHjkg2G15i9HWrOgKPOac7plaLLe66HzN
         2wZuWp+67cXosrC9tjABaFoF7jzDcM5S4VSJTUBBBFbwsnnWNIAigHPaDua0RdeKxFQd
         7mfrQr6VYpg4v/SlDquz1AginiHhmID+QIzPdWf4pDEyn8KsbQI00JAUA2bPXps7SAD6
         Nsbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=+F4C0obdLqxtxvnXgc6NBTXBI4MQZcojuR7xEpcxFEY=;
        b=IrzHAz+AZo+kZp8SsA7ejrpMZ90DzXQ+uAK+vMnoK1KApQDNrDOyCtiJZi0N+c1Z3o
         FFhx4CI7sgavxP0NUwjv4SVGWKSco/wzYZWEY7L7UOqdC/FEnKjMgGBpmjANNxQnHxq+
         s79XkJ6Bb7s7fPMD0wMKK03OLW7OK1oZ1oJJl5jvaotbFJPqIR5F3iJJOcQpMhss1pJa
         kkAE8AuHvWTXS2QFaWtTFOfqWA7UYcBa6f7NRt+9ZhuWsiC5w170V91q+Dgh/AxDPaEG
         0tAneNNjczG5E1wossZfL1qABaWaqNsBxT6r+9VNOmLVkfj2OceodVc1dHDKgzL0xmyL
         qiMQ==
X-Gm-Message-State: AA6/9RkPXaksGbseZ92uxNIeci8T7/1ooxQCuf/VUG3bmeFE/YU4iaQyQMZbwJzOYVIwvQ==
X-Received: by 10.237.55.97 with SMTP id i88mr28729400qtb.52.1475001467661;
        Tue, 27 Sep 2016 11:37:47 -0700 (PDT)
Received: from 172-16-18-121.dynapool.nyu.edu (NYUFWA-WLESSAUTHCLIENTS-06.NATPOOL.NYU.EDU. [216.165.95.77])
        by smtp.gmail.com with ESMTPSA id 37sm1885248qtv.20.2016.09.27.11.37.46
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 Sep 2016 11:37:47 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v2 1/5] gpg-interface, tag: add GPG_VERIFY_QUIET flag
From:   =?utf-8?Q?Lukas_P=C3=BChringer?= <luk.puehringer@gmail.com>
In-Reply-To: <CAGZ79kYitOd5-Cxr0VzhRH70B=z2gh1q2aB5xiwe+HwHuU7dYg@mail.gmail.com>
Date:   Tue, 27 Sep 2016 14:37:46 -0400
Cc:     Junio C Hamano <gitster@pobox.com>,
        Santiago Torres <santiago@nyu.edu>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>, walters@verbum.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <618EBDCB-0BD7-493D-AE08-67133B06CEA9@gmail.com>
References: <20160926224233.32702-1-santiago@nyu.edu> <20160926224233.32702-2-santiago@nyu.edu> <xmqqbmz9p7m0.fsf@gitster.mtv.corp.google.com> <15BEFDC3-81B2-47FC-A213-F37B4E6020D2@gmail.com> <xmqqponpnqyf.fsf@gitster.mtv.corp.google.com> <3D863101-CA73-4718-A1E7-A1664A5BDB58@gmail.com> <CAGZ79kYitOd5-Cxr0VzhRH70B=z2gh1q2aB5xiwe+HwHuU7dYg@mail.gmail.com>
To:     Stefan Beller <sbeller@google.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I made it a habit to use =E2=80=98ue=E2=80=99 instead of =E2=80=98=C3=BC' =
outside of German speaking countries and in coding. It makes my life =
easier.
But thanks for the hint.

Lukas
> On Sep 27, 2016, at 2:31 PM, Stefan Beller <sbeller@google.com> wrote:
>=20
> On Tue, Sep 27, 2016 at 11:25 AM, Lukas P=C3=BChringer
> <luk.puehringer@gmail.com> wrote:
>> Good, I will change it to 'Lukas Puehringer' then, when we send you =
the updated batch of patches, that address your latest comments.
>=20
> No need to stay full ASCII. German umlauts are fine.
> (See `git shortlog -s` for all the contributor names, there are also
> other alphabets in use)
>=20
> Stefan

