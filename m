Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48E501F424
	for <e@80x24.org>; Wed, 11 Apr 2018 09:44:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752445AbeDKJoK (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Apr 2018 05:44:10 -0400
Received: from mail-qk0-f170.google.com ([209.85.220.170]:34671 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752369AbeDKJoG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Apr 2018 05:44:06 -0400
Received: by mail-qk0-f170.google.com with SMTP id g7so1159432qkm.1
        for <git@vger.kernel.org>; Wed, 11 Apr 2018 02:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=n5sVHinIRyD4mwNwgQ40qZzreAY17YqM7A0rEOeQS7E=;
        b=gd3oPclBjxOyBGInzk+c2HI8Fu2ljT7rGi2BKLaeXYFQvaxP2m61zZ5aJxOvqfYzUB
         8kKc34kWP9zVfK6EHx22SNQ2NdRW0lwL/yyMShRqjdzcvgf278//iqhPUMeM1TyLfRBC
         qPDtcuKggdvpEqsFeZMzPLYkiPZ5m/++BHpJzOgqBAPXY7B6aiyQpWW35avB4kf7oTV8
         NEuZviZC+ERZOtWuzpwQ/azFstUCcBgVrI9EGGi86UR5k1ZJC0+tIakxwQvTCKqHrw+Q
         SoecFqj3TSC//Ur79zbHpcuRVZTVCw2Na2WOc67u/dOp2mNU3fkrd2UGiiZos6fKd8bC
         qLDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=n5sVHinIRyD4mwNwgQ40qZzreAY17YqM7A0rEOeQS7E=;
        b=faWJeDH7f/ey1RzT+5gnZ4d2r2MGIs3sxnf2cmx2GrP0kyQ8pwavNJcYvtfmBjcRXi
         TiHoe4zZpeQZhBqCB4WjNyjfTd90Ksfw4nrGHvtOjM4QUcEOjBP72vZCReVfKFNpQiab
         g+sdeb4KyYMQPUBRhsfCmsmVBU1cVKtk/Yyi4M4bvnaQGeLY19HtZAS+uUxVN+OcIyam
         Rp6NidkAxvRwU6C+M4d13Ky3MyL4HfxdMEeYNiVSpKugREMOZR9RAfSifA24EzUFQDyU
         m+KW5SK+28Q0byXe8SIpiYGeKalR5cbdLVKuftuCwcizTDy18zecfLCyMLFOGwO1Go+7
         xyDg==
X-Gm-Message-State: ALQs6tCJ2yyPUi5hEH1Zcn3VJZXq3y7dG4l/dmVaTj2tkJ/LtyBmnqL2
        iZYqGgobk3ORUDoUzmzP7jPob+6yApJstPaz0kU8NA==
X-Google-Smtp-Source: AIpwx48x9qw7a/atUIPNb4FVU/dGzzpzbOgXa/A6BGN/d2a80hS5pvSnH5OApvzYUqVQwFwMq2a+dQVxcWu9krH1jD8=
X-Received: by 10.55.156.79 with SMTP id f76mr5657807qke.36.1523439845691;
 Wed, 11 Apr 2018 02:44:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Wed, 11 Apr 2018 02:44:05 -0700 (PDT)
In-Reply-To: <CA+FnnTzFomd91d1F6O-a28hXQ6PxOiBd44da4nSVW0MuDKgkmw@mail.gmail.com>
References: <CA+FnnTxbg97A4P3AP7n5RT8+=W8PY0yx3644Ay2Zi9xgKD2aoA@mail.gmail.com>
 <CAPig+cR19LS2vfjBQ71c3j2g61vSHnYRj1iSX1-V_E3Fj=kwOA@mail.gmail.com>
 <CA+FnnTzfJMBuSMAD7PgUurRu8jOpirEgM6=+=i91zdGLWmfUpg@mail.gmail.com>
 <CAPig+cQOzKbM0R6vKTg_BU6meEbAAJWL1T0jZkaCOF0uJ=_Lmw@mail.gmail.com>
 <CA+FnnTzqaPrLgYv-8X9BDW0DR7331morN33B81w8T3vzOwn+Pw@mail.gmail.com>
 <CA+FnnTz-qdVK5482GJo06QrvMktGYhJAJ6g-Naq0BgT-uoRvEA@mail.gmail.com>
 <CAPig+cS+gf5gGM3fmnxk-6k7ezbtS=KQFqkkxVtcytHfcQApEQ@mail.gmail.com>
 <CA+FnnTwvnA90nDARKW9r7p5iraoOGTvfDJ26n6Udc68bDSUASw@mail.gmail.com>
 <CAPig+cRjYju4zEgiY_TuOOk0e7A8zNz+hu+40vQUEGDX6FGDxw@mail.gmail.com> <CA+FnnTzFomd91d1F6O-a28hXQ6PxOiBd44da4nSVW0MuDKgkmw@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 11 Apr 2018 05:44:05 -0400
X-Google-Sender-Auth: jt7bZS8Cb9QpOmilDXKwT74Ep7A
Message-ID: <CAPig+cTw5GjB4VgFD2teDvMuyGPFFoNSCqbXbarEXCe3fVdLjQ@mail.gmail.com>
Subject: Re: Is support for 10.8 dropped?
To:     Igor Korot <ikorot01@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 11, 2018 at 12:28 AM, Igor Korot <ikorot01@gmail.com> wrote:
>>> Is there a way to check for OpenSSL presence?
>>
>> Not sure what you're asking. Are you asking how to determine if you
>> already have OpenSSL built on your machine?
>
> Yes, that's what I was asking...

Easiest way to determine it is to try to compile Git without setting NO_OPENSSL.

> This is what I got trying to do just "make":
>
> MyMac:git-2.17.0 igorkorot$ make
>     * new build flags
>     CC credential-store.o
> In file included from credential-store.c:1:
> In file included from ./cache.h:9:
> ./gettext.h:17:11: fatal error: 'libintl.h' file not found
> #       include <libintl.h>
>                 ^
> 1 error generated.

This is because you don't have gettext installed. You should be able
to set NO_GETTEXT to work around this.

> And I am also confused. Which file am I suppose to modify here?
>
> MyMac:git-2.17.0 igorkorot$ ls -la conf*
> -rwxr-xr-x@ 1 igorkorot  staff  74461 Apr  2 10:13 config.c
> -rwxr-xr-x@ 1 igorkorot  staff   9888 Apr  2 10:13 config.h
> -rwxr-xr-x@ 1 igorkorot  staff    540 Apr  2 10:13 config.mak.in
> -rwxr-xr-x@ 1 igorkorot  staff  16940 Apr  2 10:13 config.mak.uname
> -rwxr-xr-x@ 1 igorkorot  staff  37509 Apr  2 10:13 configure.ac
> -rw-r--r--  1 igorkorot  staff  37500 Apr  8 18:52 configure.ac+

You should create a new file named "config.mak". For instance, the
content of your config.mak file might be:

    NO_GETTEXT=Yes
