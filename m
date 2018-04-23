Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C28281F424
	for <e@80x24.org>; Mon, 23 Apr 2018 16:31:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755115AbeDWQbq (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 12:31:46 -0400
Received: from mail-oi0-f51.google.com ([209.85.218.51]:35854 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754788AbeDWQbp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 12:31:45 -0400
Received: by mail-oi0-f51.google.com with SMTP id v2-v6so1089286oif.3
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 09:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=U7Nj+pQL4VGe62HNL8LPha5qkQckG1M2U7ayIACgK4s=;
        b=Y+SlnQvUazDx+9M/UtR1mXwx5SdmT+hYc3Ls/YPJEmdr54VTisbrVhgTMq9+lnhnXW
         rBeDchy7uS3BLPaFa5+DGT67IV56tS9hRNQQAxfh38YF2Hh5thWxUFPvOFR3ry14YMOX
         WoKBP7MjxgWa6qLuu58rwHQztWW03+MWRKRtFZvR2+wvCDChyTm1OSxzu8fJUj1AUxj9
         u1herkqWI8m9IQEfiHOeT1qElbQc+uWoAFalswI9VhD9g5tp5dFRcZiBM6SVIxiRs9KY
         XvX71xzrWGXR0B1k0fAUlhvrOhid+7W67skIJOpy9WlKAnCXyDFphvSv21bjlfILgWMX
         O/PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=U7Nj+pQL4VGe62HNL8LPha5qkQckG1M2U7ayIACgK4s=;
        b=HumjfyOLUpy6tDSoId52gSGPi44LMvTlAHjzHHQAHPSag7XdwikzMlkkd7fT+01zLi
         N2DOvRMfbR16ybwbyISllZkUt/r/yS/PY4kjj3SnkwSBOmCAWap4CfznfgIlIhVOi8Ev
         QOu5kGF0H2I4EKmvt2lQDuJtSJxB2bqcRAfzT+XouDkNsrt3A8FMkI1xiUWT5BWI6yWx
         4ICLV6tp88sX4uJPWSDcgF4L8qJL/qu4xr55jBi5mW3OJXoku1VivDyG00FxrBgfOTxg
         otQx1cojkM1c4HWQPWLm9Q5/QrkfHciaHqfGsp6JeUaZiIxq/8rN+eHU8uF1d0Hxm2qQ
         20gA==
X-Gm-Message-State: ALQs6tBHoahb9qs7Jyx/4osZS9nTuMW2trVN//3ImjZKs8brRehiE+zh
        NkwUc/MiE2GspX43GV5Shj9yS5ufBJbZBBFGRPI=
X-Google-Smtp-Source: AIpwx48lprfCVatnH75ClO3EYt94O7ZCK7mKcT2M2glESSb+fp8SXCXP+RJxfiz0oqo2qDF7BT8viRWcznh9VY8Jpcg=
X-Received: by 2002:aca:d16:: with SMTP id 22-v6mr8778030oin.245.1524501104965;
 Mon, 23 Apr 2018 09:31:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.201.112.67 with HTTP; Mon, 23 Apr 2018 09:31:44 -0700 (PDT)
In-Reply-To: <CAPig+cT0ogLmiviWhdZTLxDM7+VN3hk7wgkKnvX96Ym-yXR5bA@mail.gmail.com>
References: <CA+FnnTxbg97A4P3AP7n5RT8+=W8PY0yx3644Ay2Zi9xgKD2aoA@mail.gmail.com>
 <CAPig+cR19LS2vfjBQ71c3j2g61vSHnYRj1iSX1-V_E3Fj=kwOA@mail.gmail.com>
 <CA+FnnTzfJMBuSMAD7PgUurRu8jOpirEgM6=+=i91zdGLWmfUpg@mail.gmail.com>
 <CAPig+cQOzKbM0R6vKTg_BU6meEbAAJWL1T0jZkaCOF0uJ=_Lmw@mail.gmail.com>
 <CA+FnnTzqaPrLgYv-8X9BDW0DR7331morN33B81w8T3vzOwn+Pw@mail.gmail.com>
 <CA+FnnTz-qdVK5482GJo06QrvMktGYhJAJ6g-Naq0BgT-uoRvEA@mail.gmail.com>
 <CAPig+cS+gf5gGM3fmnxk-6k7ezbtS=KQFqkkxVtcytHfcQApEQ@mail.gmail.com>
 <CA+FnnTwvnA90nDARKW9r7p5iraoOGTvfDJ26n6Udc68bDSUASw@mail.gmail.com>
 <CAPig+cRjYju4zEgiY_TuOOk0e7A8zNz+hu+40vQUEGDX6FGDxw@mail.gmail.com>
 <CA+FnnTzFomd91d1F6O-a28hXQ6PxOiBd44da4nSVW0MuDKgkmw@mail.gmail.com>
 <CAPig+cTw5GjB4VgFD2teDvMuyGPFFoNSCqbXbarEXCe3fVdLjQ@mail.gmail.com>
 <CA+FnnTzkZS7HP61Ck3y5p0EC7J_h=ToR5tq5cvEpJ79vYuSxZw@mail.gmail.com> <CAPig+cT0ogLmiviWhdZTLxDM7+VN3hk7wgkKnvX96Ym-yXR5bA@mail.gmail.com>
From:   Igor Korot <ikorot01@gmail.com>
Date:   Mon, 23 Apr 2018 11:31:44 -0500
Message-ID: <CA+FnnTxXOwORs_qYvOdSj41UX1aBfj+Hd1+kxPa8j+34xgjhgQ@mail.gmail.com>
Subject: Re: Is support for 10.8 dropped?
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Eric,

On Sun, Apr 22, 2018 at 12:37 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sun, Apr 22, 2018 at 1:15 AM, Igor Korot <ikorot01@gmail.com> wrote:
>> MyMac:git-2.17.0 igorkorot$ cat config.mak
>> NO_GETTEXT=Yes
>> NO_OPENSSL=Yes
>>
>> MyMac:dbhandler igorkorot$ /Users/igorkorot/git-2.17.0/git pull
>> fatal: unable to access
>> 'https://github.com/oneeyeman1/dbhandler.git/': error:1407742E:SSL
>> routines:SSL23_GET_SERVER_HELLO:tlsv1 alert protocol version
>> MyMac:dbhandler igorkorot$
>
> Try re-building with OpenSSL enabled (remove NO_OPENSSL from
> config.make). You may need to build/install OpenSSL yourself to get
> this to work.

2 things:
1. Is the file name "config.mak" or "config.make"?
2. Do I have to do "make clean" or just remove the line and o "make"?

Thank you.
