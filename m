Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F5851F404
	for <e@80x24.org>; Thu, 25 Jan 2018 20:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751321AbeAYUtn (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jan 2018 15:49:43 -0500
Received: from mail-ua0-f169.google.com ([209.85.217.169]:33157 "EHLO
        mail-ua0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751138AbeAYUtl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jan 2018 15:49:41 -0500
Received: by mail-ua0-f169.google.com with SMTP id p12so5846339uad.0
        for <git@vger.kernel.org>; Thu, 25 Jan 2018 12:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=L/JLwJcvlAUCfUlZDzzKtdBAQk9XNJWfI0P81syFvrE=;
        b=XgrQUpMU6NXH/VTqoc67+LkQadH3g+eTj21pmGIpGIFSO7h/AweVIySXGQe73qW/h4
         W3Y5gZ8rPme5v6fwSTc4KUMpzw27V3+rzY+FYunS752kl9B8hQhyEbxotP6wCRhO4GeR
         R6WZX2kvuJEAe1JWpm0Vy++qDFD/OpGwHwSDVlsZDEn59QWGT9eE5C1elHRvEMgs6RlE
         fZHozHiUE+2+Xw8gppgK+uitZniEODKfOKYU9MUX+TSN5IcHwJJg8LNGKlWcx9DcpVma
         pLmBNLV865ksFr83G08F3TPhu8YjI8O6EmQJM8cbcrPcxsPMlfZfOrSomEPxRqGiTMJ7
         SkJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=L/JLwJcvlAUCfUlZDzzKtdBAQk9XNJWfI0P81syFvrE=;
        b=iewMHUA40OwILr0Q4fL4IjIR+RwR8tc+9ukLK5CwrP01Zisifkpmto/X8Qoy97xY3e
         FpVJNul8eTkXnYQNz4IYCMVu/RxsGyHBnFkFpdoMsJ8WiQyYuTA3w/AUhPbatbpXqypm
         o1mGLcb6m0kYEBJgjWGq1QQ4K49t2wJffa0wKNrJjuTLDpNqLv9O84qMglUvX7w1W4Cc
         2ShUCUIlnvmChWMZzCXt0rZkTVDWVRl8zkhxNFeFVEhAmVf+ikmdHL58xN5tOMIxOhHD
         I+YwvDmAi9ZZkl1jdfrMOHc42vjQuvCH04zxGIILZ2gI6+qGRCI88RAJ2uhz/+aC+8zJ
         wttA==
X-Gm-Message-State: AKwxytebSN2ca5rbSQXDtnuEgZUg1HUPdqPwes/89LyiuH659wYMmO2z
        hrWp0c8MmEYuIP7zXA7+k0/udsprLyfuXudWBPI=
X-Google-Smtp-Source: AH8x2259D6MsA4fWPYsjdBVgkfsZaH8I+NxGEiw9V8a9/NVAw/1UwKedRDtooMJIQRzFmqgRPyuOOxSvIiimOUbb3uM=
X-Received: by 10.176.11.138 with SMTP id c10mr8865881uak.94.1516913381053;
 Thu, 25 Jan 2018 12:49:41 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.32.12 with HTTP; Thu, 25 Jan 2018 12:49:40 -0800 (PST)
In-Reply-To: <20180125201250.30171-1-szeder.dev@gmail.com>
References: <14657461479715884@web21h.yandex.ru> <CA+P7+xrKfqOb-3FhKxXdnF6g9PktNWNzY+ZnHJS=yuVo1YdXzg@mail.gmail.com>
 <CAGZ79kZbGPneUXVEqJYhQAn+dfYve7qCjhO7QFaV1JBs3HD1aA@mail.gmail.com>
 <CA+P7+xqMUPLC-aKW-fiS629_Owat8sCa5vp_bOwQTO8LP4hCzw@mail.gmail.com>
 <12531516812201@web36o.yandex.ru> <446801516908691@web22j.yandex.ru> <20180125201250.30171-1-szeder.dev@gmail.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Thu, 25 Jan 2018 21:49:40 +0100
Message-ID: <CAM0VKj=ZMbYPBcXCU9T4iKCLhQ1O8wK8737KQTfiAEF9GWZs3Q@mail.gmail.com>
Subject: Re: Feature request: Improve diff algorithm
To:     KES <kes-kes@yandex.ru>
Cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 25, 2018 at 9:12 PM, SZEDER G=C3=A1bor <szeder.dev@gmail.com> w=
rote:
>> One yet more:
>>
>> @@ -141,5 +86,9 @@
>>       // }
>>
>>
>> -     OP* o;

Oops, when trying to reproduce I overlooked that here the * is stuck
after OP ...

>> +     SV *tvs =3D  newSVpvs( "ScalarHistory" );
>> +     SV *tva =3D  newSVpvs( "ArrayHistory"  );
>> +     SV *tvh =3D  newSVpvs( "HashHistory"   );
>> +
>> +     OP *o;

... but here it's stuck to o.

With that adjusted I do get the same diff as you, and I think that's the
right output in this case.
