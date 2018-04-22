Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22C511F404
	for <e@80x24.org>; Sun, 22 Apr 2018 05:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750770AbeDVFPn (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Apr 2018 01:15:43 -0400
Received: from mail-ot0-f180.google.com ([74.125.82.180]:42466 "EHLO
        mail-ot0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750747AbeDVFPl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Apr 2018 01:15:41 -0400
Received: by mail-ot0-f180.google.com with SMTP id q10-v6so9077193oth.9
        for <git@vger.kernel.org>; Sat, 21 Apr 2018 22:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=pcT0bdvcxjJEiOfK7BeUXSbZOl8iN84ei5loGE5pNoA=;
        b=MhIOWQsTRCGx0plSzl2KZf1UXyyUGJ4lgUeYHrFVTY50PUqdcy3Zlxge16cLcO5mCv
         CREuTCcOcd98gtnYr8vuns5tmhaoqFsZyNpMqAoIZdggq+N6wzMfyRoq0nQk4oiBmcy6
         OFFxgCksepjFLLOGlcnk4TMUJynDbghey21fQJy6P67Fo4mCxNiZRDS393R/ctlQDqLK
         kROkDmcK1cp1Q9C/FcLwb7qkCTkttur8TM/Se2JzP9fpmQVHNVqJ08KnBPKRr+9KfVxU
         f7MXqm8DdHl24VK6SHaUIop/Fi1Re8q4ixijkDmCBdlDpGCl+PFDm7vZDfk/YFHRDZx9
         AvdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=pcT0bdvcxjJEiOfK7BeUXSbZOl8iN84ei5loGE5pNoA=;
        b=CCKzGQr72GfK4R4OCjGnn0VGv9QNVYa87zrpJoegeUrSRGeZb1PipWnZtaiUhdr6ig
         LsYCG5tNvgZQR7Hq7GuRYf0t+r89r5ZvCt7ooDln7xZfy82CBZQjkcZJ+qRwgy7re9dP
         tW1e3fBx/uVNiTXUG9lrnHhgIGv1e5FaArFyeApBO8ZRSNGGhpz5Wh4LhPfawfjNkvai
         uolNix9b98VyFWBL5KCQNoP9qwm3eZr0UiHPf6WewGiKeYN6yLnHFHxlVHS62N8/S3+j
         9QRZmVo5RrYK46XYADljnldkbDANdI0Qg4xXBoIbMQOybq/ZeS5d4XKMyHV3SXCcYlQT
         TP5Q==
X-Gm-Message-State: ALQs6tB5N0tdahU315LFCCh1T32ACGpqFPZPYV53ysLY+w1DG7R1nLwW
        RJ1e1/Z8E50vr6/ZmFwf9ahWtXQ3oSUplOcPflnUcw==
X-Google-Smtp-Source: AIpwx4/T1Zqt/nKCb4WPFvoMLU3bRrqSz5FJbCtZvsb/vILzLYKmCWGb9OOyb/I2IlOXcsfbrMnif+PfG4Rx3tK5cpQ=
X-Received: by 2002:a9d:21e5:: with SMTP id s92-v6mr11642651otb.165.1524374141183;
 Sat, 21 Apr 2018 22:15:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.201.102.138 with HTTP; Sat, 21 Apr 2018 22:15:40 -0700 (PDT)
In-Reply-To: <CAPig+cTw5GjB4VgFD2teDvMuyGPFFoNSCqbXbarEXCe3fVdLjQ@mail.gmail.com>
References: <CA+FnnTxbg97A4P3AP7n5RT8+=W8PY0yx3644Ay2Zi9xgKD2aoA@mail.gmail.com>
 <CAPig+cR19LS2vfjBQ71c3j2g61vSHnYRj1iSX1-V_E3Fj=kwOA@mail.gmail.com>
 <CA+FnnTzfJMBuSMAD7PgUurRu8jOpirEgM6=+=i91zdGLWmfUpg@mail.gmail.com>
 <CAPig+cQOzKbM0R6vKTg_BU6meEbAAJWL1T0jZkaCOF0uJ=_Lmw@mail.gmail.com>
 <CA+FnnTzqaPrLgYv-8X9BDW0DR7331morN33B81w8T3vzOwn+Pw@mail.gmail.com>
 <CA+FnnTz-qdVK5482GJo06QrvMktGYhJAJ6g-Naq0BgT-uoRvEA@mail.gmail.com>
 <CAPig+cS+gf5gGM3fmnxk-6k7ezbtS=KQFqkkxVtcytHfcQApEQ@mail.gmail.com>
 <CA+FnnTwvnA90nDARKW9r7p5iraoOGTvfDJ26n6Udc68bDSUASw@mail.gmail.com>
 <CAPig+cRjYju4zEgiY_TuOOk0e7A8zNz+hu+40vQUEGDX6FGDxw@mail.gmail.com>
 <CA+FnnTzFomd91d1F6O-a28hXQ6PxOiBd44da4nSVW0MuDKgkmw@mail.gmail.com> <CAPig+cTw5GjB4VgFD2teDvMuyGPFFoNSCqbXbarEXCe3fVdLjQ@mail.gmail.com>
From:   Igor Korot <ikorot01@gmail.com>
Date:   Sun, 22 Apr 2018 01:15:40 -0400
Message-ID: <CA+FnnTzkZS7HP61Ck3y5p0EC7J_h=ToR5tq5cvEpJ79vYuSxZw@mail.gmail.com>
Subject: Re: Is support for 10.8 dropped?
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,
Sorry for the long delay. Been busy with life things.

I built git from sources. The build was successful.

[code]
MyMac:git-2.17.0 igorkorot$ cat config.mak
NO_GETTEXT=Yes
NO_OPENSSL=Yes
[/code]

Next I tried to do git pull for my project:

[code]
MyMac:dbhandler igorkorot$ /Users/igorkorot/git-2.17.0/git pull
fatal: unable to access
'https://github.com/oneeyeman1/dbhandler.git/': error:1407742E:SSL
routines:SSL23_GET_SERVER_HELLO:tlsv1 alert protocol version
MyMac:dbhandler igorkorot$
[/code]

Thank you.


On Wed, Apr 11, 2018 at 5:44 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Wed, Apr 11, 2018 at 12:28 AM, Igor Korot <ikorot01@gmail.com> wrote:
>>>> Is there a way to check for OpenSSL presence?
>>>
>>> Not sure what you're asking. Are you asking how to determine if you
>>> already have OpenSSL built on your machine?
>>
>> Yes, that's what I was asking...
>
> Easiest way to determine it is to try to compile Git without setting NO_OPENSSL.
>
>> This is what I got trying to do just "make":
>>
>> MyMac:git-2.17.0 igorkorot$ make
>>     * new build flags
>>     CC credential-store.o
>> In file included from credential-store.c:1:
>> In file included from ./cache.h:9:
>> ./gettext.h:17:11: fatal error: 'libintl.h' file not found
>> #       include <libintl.h>
>>                 ^
>> 1 error generated.
>
> This is because you don't have gettext installed. You should be able
> to set NO_GETTEXT to work around this.
>
>> And I am also confused. Which file am I suppose to modify here?
>>
>> MyMac:git-2.17.0 igorkorot$ ls -la conf*
>> -rwxr-xr-x@ 1 igorkorot  staff  74461 Apr  2 10:13 config.c
>> -rwxr-xr-x@ 1 igorkorot  staff   9888 Apr  2 10:13 config.h
>> -rwxr-xr-x@ 1 igorkorot  staff    540 Apr  2 10:13 config.mak.in
>> -rwxr-xr-x@ 1 igorkorot  staff  16940 Apr  2 10:13 config.mak.uname
>> -rwxr-xr-x@ 1 igorkorot  staff  37509 Apr  2 10:13 configure.ac
>> -rw-r--r--  1 igorkorot  staff  37500 Apr  8 18:52 configure.ac+
>
> You should create a new file named "config.mak". For instance, the
> content of your config.mak file might be:
>
>     NO_GETTEXT=Yes
