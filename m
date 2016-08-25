Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C514F1F859
	for <e@80x24.org>; Thu, 25 Aug 2016 19:54:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754592AbcHYTyo (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Aug 2016 15:54:44 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36404 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751723AbcHYTyn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2016 15:54:43 -0400
Received: by mail-wm0-f68.google.com with SMTP id i138so8690468wmf.3
        for <git@vger.kernel.org>; Thu, 25 Aug 2016 12:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=references:mime-version:in-reply-to:content-transfer-encoding
         :message-id:cc:from:subject:date:to;
        bh=Q1mjaEf7VtHak9AHT5R09Tlf4WO/i0Km7Vo/Z7T2gg4=;
        b=EZsy1sCQCPTTUyOBMsoJuUsQcDbMm0XCnFLnATU9b+g04Wzrhz5gaQ1vlPhqED89FF
         aqR0FPTPc3X5623s6oDiMUt3G1NEMmCZcR6+MVFPR9+PXQz2549hGst0j39ZFKedwcQA
         gi6YwLEDCi87zSb07PF1ffYPMwIFqqcbMY2r6BvFOzEgcWeHf0CqxsIANNSLw65ie7uk
         Xd6ywfA63k1sZvhWAR6UXuAAuT1XlJxjNqt4mLuf/sgd/uusYAA2UuqZZzHEk96AH6nl
         prFIVeAQKbDivICHkENuLqgEMQzsr66tUzsF5KR2ggpz7NLTcn7lywXm03U/jJkmAxsJ
         txAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:references:mime-version:in-reply-to
         :content-transfer-encoding:message-id:cc:from:subject:date:to;
        bh=Q1mjaEf7VtHak9AHT5R09Tlf4WO/i0Km7Vo/Z7T2gg4=;
        b=kll0U+HIZaY0ttxKEjax4nwF+QeZyNCy60C8SIjzGAiyO/tNhiK0SRIoZxGa4Mqypp
         4SBm7xXu0l0Q84HFmFVy0jFYx0haG9iCGgiZVIboFnpydfWFk55Z19zIjzpckjVRZqXl
         7Lewqu8ggASzoMSE3KzO10cb0TUPYctojpWANcwG9vkRYcq+cFBhDUYiFadU/V5atd0m
         6WC/IFOUqCklYwEROop1ipYB8GvGqtpaI4dXcwUFvhq87uNrS4B0fLpA1w7tNTVxyZbd
         kHBSo4NPZ6f7jMXQR/OQArMFeqUgSjKHffoXTLCcAdMvJ8Rw4vQ+IbNorTCJVQ/eVGiH
         Imsw==
X-Gm-Message-State: AEkoouuVEsJE/h1HsAnIZnvko9DzJQB/3d9djHvFpNnMytFhFaW17XEnHCuv9QxW+S4onw==
X-Received: by 10.28.113.151 with SMTP id d23mr32245929wmi.89.1472154882195;
        Thu, 25 Aug 2016 12:54:42 -0700 (PDT)
Received: from [10.93.255.233] (tmo-096-248.customers.d1-online.com. [80.187.96.248])
        by smtp.gmail.com with ESMTPSA id za2sm16581360wjb.34.2016.08.25.12.54.41
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Aug 2016 12:54:41 -0700 (PDT)
References: <20160825110752.31581-1-larsxschneider@gmail.com> <20160825110752.31581-11-larsxschneider@gmail.com> <CAGZ79kZ5utc+0iXKPh=tu4rD9H6+AKZmc08_jLxQhgiuFUA+Yw@mail.gmail.com>
Mime-Version: 1.0 (1.0)
In-Reply-To: <CAGZ79kZ5utc+0iXKPh=tu4rD9H6+AKZmc08_jLxQhgiuFUA+Yw@mail.gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Message-Id: <E574E25A-F87F-416C-88E5-E3CE1F6B54D0@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Martin-Louis Bright <mlbright@gmail.com>
X-Mailer: iPhone Mail (13G35)
From:   Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v6 10/13] convert: generate large test files only once
Date:   Thu, 25 Aug 2016 21:54:36 +0200
To:     Stefan Beller <sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> On 25 Aug 2016, at 21:17, Stefan Beller <sbeller@google.com> wrote:
>=20
>> On Thu, Aug 25, 2016 at 4:07 AM,  <larsxschneider@gmail.com> wrote:
>> From: Lars Schneider <larsxschneider@gmail.com>
>>=20
>> Generate more interesting large test files
>=20
> How are the large test files more interesting?
> (interesting in the notion of covering more potential bugs?
> easier to debug? better to maintain, or just a pleasant read?)

The old large test file was 1MB of zeros and 1 byte with a one, repeated 204=
8 times.

Since the filter uses 64k packets we would test a large number of equally lo=
oking packets.

That's why I thought the pseudo random content is more interesting.


>> with pseudo random characters
>> in between and reuse these test files in multiple tests. Run tests
>> formerly marked as EXPENSIVE every time but with a smaller data set.
>=20
> Sounds good to me.

Thank you.
Lars=
