Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8D60200B9
	for <e@80x24.org>; Mon,  7 May 2018 15:20:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752117AbeEGPUp (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 11:20:45 -0400
Received: from mail-ot0-f181.google.com ([74.125.82.181]:35810 "EHLO
        mail-ot0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752166AbeEGPUo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 11:20:44 -0400
Received: by mail-ot0-f181.google.com with SMTP id h8-v6so32388558otb.2
        for <git@vger.kernel.org>; Mon, 07 May 2018 08:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GWu7BiwuwI+k32N0YNfTT94veM6tFQtUVPw+OnXN4n0=;
        b=m2AgZFaQzBg3KFmzFFJEyfdctSgmlMfqj3i52XLtJQ+JqKVJ57c1SZs/Rzeq3oukqD
         nodyIAQYYZMfacrWCzFd1XtXy6PwPIAzpSXpIQZdu7s0wvvgH5q9TvLLWgDmoQgG3kIR
         /3idZ6CUaf0b6UfWWLGMGYfq8KLJyI1a0t5Jhb8kASM84rv+/j3UDtbHEdyORFN+aHW4
         6/hU7rnM4m6izfd3F3kd1WK7HL4i+B3J/JMjvLW+lKrEST2VClKcBoWaS5UnB7lTPsYo
         iIlakunYnywvsJvlXYqwCuBILAXzO2yMrtsjeWf+qQnNiKG+VLAxUqq+bn7z7QX5I47w
         O+TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GWu7BiwuwI+k32N0YNfTT94veM6tFQtUVPw+OnXN4n0=;
        b=d+uCvFJ08WC0BYa1IF+AXyicJ8wkXcCTVJsz2ju6+6oP+AqhgTuYeYHlzJOFekRL2S
         gwONDSYvpR4VpaKoRxnr6PhjmAWHvhRmDOlEZcmS6jB49plan1guKjbcMUNbDm1yZjJ9
         kOPEj34+cnPdGSOo1jIpdmzI1pKSlPswcniaFwpYhdjNttfeEiVo1DXHuqt9bI0BRNBj
         H6s5Y1F3KVvObuKjb0jYhoK8bA8sh9LEob+L22/fss6K5zECPbmYmX9gmS6VEI/TriuN
         k05LkIydqHoV4vaDfpKixZhqwde5GIhDYyz+fd2zRoMjOtPb7u2NiEkBDUqFr/FvERMg
         6yEQ==
X-Gm-Message-State: ALQs6tAptIZ3Gp7QJvna8DadyLSb1gmiK1VPGe5bDSzgWkG5b/s078lh
        IhfY19s7HauAft/7Boekrug+3dU2GZUqePXeQFhpvw==
X-Google-Smtp-Source: AB8JxZqdjAHbtBhcvxkY6K+tc4og/uKon4IUZOKCHyZyeGggao2rzWsH1ylKtmx89nFlo3cgkGcrBYExNWLf8CmQ4kc=
X-Received: by 2002:a9d:1869:: with SMTP id t38-v6mr28435109ott.134.1525706443472;
 Mon, 07 May 2018 08:20:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.138.1.203 with HTTP; Mon, 7 May 2018 08:20:43 -0700 (PDT)
In-Reply-To: <5ade6958.+rSvEziDyo1bWxZm%perryh@pluto.rain.com>
References: <CA+FnnTxbg97A4P3AP7n5RT8+=W8PY0yx3644Ay2Zi9xgKD2aoA@mail.gmail.com>
 <CA+FnnTzfJMBuSMAD7PgUurRu8jOpirEgM6=+=i91zdGLWmfUpg@mail.gmail.com>
 <CAPig+cQOzKbM0R6vKTg_BU6meEbAAJWL1T0jZkaCOF0uJ=_Lmw@mail.gmail.com>
 <CA+FnnTzqaPrLgYv-8X9BDW0DR7331morN33B81w8T3vzOwn+Pw@mail.gmail.com>
 <CA+FnnTz-qdVK5482GJo06QrvMktGYhJAJ6g-Naq0BgT-uoRvEA@mail.gmail.com>
 <CAPig+cS+gf5gGM3fmnxk-6k7ezbtS=KQFqkkxVtcytHfcQApEQ@mail.gmail.com>
 <CA+FnnTwvnA90nDARKW9r7p5iraoOGTvfDJ26n6Udc68bDSUASw@mail.gmail.com>
 <CAPig+cRjYju4zEgiY_TuOOk0e7A8zNz+hu+40vQUEGDX6FGDxw@mail.gmail.com>
 <CA+FnnTzFomd91d1F6O-a28hXQ6PxOiBd44da4nSVW0MuDKgkmw@mail.gmail.com>
 <CAPig+cTw5GjB4VgFD2teDvMuyGPFFoNSCqbXbarEXCe3fVdLjQ@mail.gmail.com>
 <CA+FnnTzkZS7HP61Ck3y5p0EC7J_h=ToR5tq5cvEpJ79vYuSxZw@mail.gmail.com>
 <CAPig+cT0ogLmiviWhdZTLxDM7+VN3hk7wgkKnvX96Ym-yXR5bA@mail.gmail.com>
 <CA+FnnTxXOwORs_qYvOdSj41UX1aBfj+Hd1+kxPa8j+34xgjhgQ@mail.gmail.com>
 <CAPig+cQzX04JuoUOnxOxWtqMCpHCUi=hMOSDL+jpNuML0iE+Tw@mail.gmail.com>
 <05560086-232c-f14c-f82b-e21b7ecce1b3@web.de> <CAPig+cSbAaNby++AvCx4CkJ0KcRkx5Q=xs8VSbNmY=dgi-F9jg@mail.gmail.com>
 <CA+FnnTy1spOxnPYFb3=xCxUZJB3D=shoOGV-SQr=4LDZEHVSkQ@mail.gmail.com> <5ade6958.+rSvEziDyo1bWxZm%perryh@pluto.rain.com>
From:   Igor Korot <ikorot01@gmail.com>
Date:   Mon, 7 May 2018 10:20:43 -0500
Message-ID: <CA+FnnTwy_xXf3xvQWu6JXfszQS8WhfCvEjPaojeyz38946sy0g@mail.gmail.com>
Subject: Re: Is support for 10.8 dropped?
To:     Perry Hutchison <perryh@pluto.rain.com>
Cc:     =?UTF-8?Q?Totsten_B=C3=B6gershausen?= <tboegi@web.de>,
        git <git@vger.kernel.org>, sunshine@sunshineco.us
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi guys,
I am going to try and build the OpenSSL and Git locally.
Search brought me here:
https://wiki.openssl.org/index.php/Compilation_and_Installation#OS_X.

Which options do I absolutely have to have for configuring OpenSSL?
Should I exclude "no--ssl2"? "no-ssl3"?

Thank you.


On Mon, Apr 23, 2018 at 6:16 PM, Perry Hutchison <perryh@pluto.rain.com> wrote:
> Igor Korot <ikorot01@gmail.com> wrote:
>> This laptop is old and doesn't have too big of a hard drive.
>> And I'm trying to create a big program
>
> Building OpenSSL via homebrew or MacPorts would likely take less
> space than building all of git that way, but if even that is
> too much perhaps it is time to consider moving the development
> environment onto an external hard drive (via USB, eSATA, or even
> FireWire) -- the presumption being that the development environment
> may not need to be lugged around when using the laptop as a laptop.
