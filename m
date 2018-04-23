Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 965B91F424
	for <e@80x24.org>; Mon, 23 Apr 2018 21:21:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932312AbeDWVVb (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 17:21:31 -0400
Received: from mail-oi0-f48.google.com ([209.85.218.48]:35039 "EHLO
        mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932191AbeDWVV3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 17:21:29 -0400
Received: by mail-oi0-f48.google.com with SMTP id a6-v6so6650831oia.2
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 14:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+1hK2+33heRBhUvLZGYBQnPyTdgPQ5SaLlz0+yyEbcY=;
        b=HHWWLS90Vom4WvemCmGe2sy9yM7X/vt293scqygTPGFVwQkBk6LKO9xFGxRe+n+9tx
         4+ZGlA2dF5RASF+AIgokPo67SYlgjV+NcyLpUyqbCh5fk2M5CSnFtX099G+M5Ln58a/L
         8Kr4M+vbTRVbzDyGP5s8DjuN5JZoVyudfjg8SJnOJX39puiwhVQq4967rHA8xbLFAEbn
         8YO+hWeLGPygw6mfOliQD/RZArh9MaHgDP9TBENxLOyTphjFESAWPYtP9y2NVu9Mt6GA
         f2mfMDSOAvSTZU246qw/Qg4Z92qm3W1Icoma2EF2Qvex3ZvF3yvqjWHYXW9GqLMYio/w
         /+Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+1hK2+33heRBhUvLZGYBQnPyTdgPQ5SaLlz0+yyEbcY=;
        b=TSkHHtqsYX2FySMzj7M64mMmFl6CdjgoNV84pBD/MeWE4Jy0Nvn1icHxIMUdchgNWV
         NgXHYdLGupNFdei/x5UAuphPOtRL26OvcRWE5u0PyybpI1Io+9uhQXh5Xst8jWftcW2j
         xWwUeMJ8HPyvJhpemyoxnU7VCb+et3oitAkEh1DO8DkKrLOJ0SDAUjpKBk41iA22jZaT
         TXVJoaXp26Fbbop4p9Dgn8ipC/p1/c6Xe5Y+kZ0zS4GdYXJBjUNeL8zIek4gZWR+dxM4
         OwmJ5sTQtZKQ4pAX2iKG8/JNVb3k/b24E3FNQVzHNDcMLebg7X2R25s06aLvNQFW/8ZN
         aSSg==
X-Gm-Message-State: ALQs6tDF2TOyTPXQmQhU82cmVEqCCP4ED3e6w7UFW6ZM2oJ75x2ZB52U
        K4pV5YkspcXAJr/QrL+JB0RijMkBKQrWQnuoZ4Y=
X-Google-Smtp-Source: AIpwx49PJFWOAkGKiciBYgUuwZMlITW7Fwf8O+8sdTNOFl2ytOmE80+B3/HY+dxOv1HKSymXwlSu9WIsDR+plIfHG7g=
X-Received: by 2002:aca:bec1:: with SMTP id o184-v6mr10002063oif.357.1524518489089;
 Mon, 23 Apr 2018 14:21:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.201.112.67 with HTTP; Mon, 23 Apr 2018 14:21:28 -0700 (PDT)
In-Reply-To: <CAPig+cSbAaNby++AvCx4CkJ0KcRkx5Q=xs8VSbNmY=dgi-F9jg@mail.gmail.com>
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
From:   Igor Korot <ikorot01@gmail.com>
Date:   Mon, 23 Apr 2018 16:21:28 -0500
Message-ID: <CA+FnnTy1spOxnPYFb3=xCxUZJB3D=shoOGV-SQr=4LDZEHVSkQ@mail.gmail.com>
Subject: Re: Is support for 10.8 dropped?
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?UTF-8?Q?Totsten_B=C3=B6gershausen?= <tboegi@web.de>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric,

On Mon, Apr 23, 2018 at 4:04 PM, Eric Sunshine <sunshine@sunshineco.com> wr=
ote:
> On Mon, Apr 23, 2018 at 3:58 PM, Totsten B=C3=B6gershausen <tboegi@web.de=
> wrote:
>> On 2018-04-23 18:53, Eric Sunshine wrote:
>>> On Mon, Apr 23, 2018 at 12:31 PM, Igor Korot <ikorot01@gmail.com> wrote=
:
>>>> 1. Is the file name "config.mak" or "config.make"?
>>>
>>> "config.mak"
>>
>> I am confused, I have these file in my tree:
>> config.mak.in  config.mak.uname   Makefile
>> Setting options is documentend in Makefile
>
> You can place custom build settings in a file named "config.mak" which
> you create; it's not part of the distribution. The other files are not
> intended for modification.
>
>> I would actually try to install openssl / openssl-dev (or however it is
>> called) via "mac ports" or "home brew".
>>
>> Both should work (but I don't have a system to test on)
>
> Igor indicated earlier[1] in the thread that he wanted to avoid
> Homebrew (and Macports, etc., presumably). If he'd be willing to use
> Homebrew, then easiest would be simply to install Git itself via
> Homebrew: "brew install git"

Yes.
This laptop is old and doesn't have too big of a hard drive.
And I'm trying to create a big program

Thank you.

>
> [1]: https://public-inbox.org/git/CA+FnnTzfJMBuSMAD7PgUurRu8jOpirEgM6=3D+=
=3Di91zdGLWmfUpg@mail.gmail.com/
