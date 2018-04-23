Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B24091F424
	for <e@80x24.org>; Mon, 23 Apr 2018 21:04:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932295AbeDWVEg (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 17:04:36 -0400
Received: from mail-qt0-f181.google.com ([209.85.216.181]:38551 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932157AbeDWVEf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 17:04:35 -0400
Received: by mail-qt0-f181.google.com with SMTP id z23-v6so19457852qti.5
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 14:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=1HvKOOtH57zP7OhSGumiAOKd9lc43zbq3Tr4Unreui8=;
        b=a78/MR2m0Q1vKmvamJiuara5Tts6RTbEFrOR9VzylI081CjabdJD03cTZTxqua3YVU
         UVsshVr0NxTTm1EaJoo7/wBzw0dlMCvSnp4LLkwj+WfCEDVImESXmMfPtdBvcFYOd0XZ
         awL+dAL0kz3pgvoy6uX1PEjlIEu85uNTaZUhO14rFTaHDRGET6a7zhhbc2I+47WGjiCn
         4f1xHWWE4jsq5yFE+/fF6OZCBNxMmKaFXNo6lU9/0mWjxifU620GQhSd0h1s5UMjp5pJ
         cm3Twqt6bABymqW1I2hDsdcHDemwKfmK7DnbETqbo8N87+FC7LNGRikErbYKI7d4X/Ej
         ljjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=1HvKOOtH57zP7OhSGumiAOKd9lc43zbq3Tr4Unreui8=;
        b=tImGVd7QSPO8Upo2rUmwwy01MSAPb10O5jnXHDtuAjybMqlD4fElN9ExnocfPvZuNr
         s7Q4gluoQ5kIKvTK7nCdZPVKcnr04qs86KwMXmEygbSPgImAKjHDFwfy5ugB7nDwzUq7
         UgnaEl3/RE065StneDW+H3atU5ErLOS20s80tAs1PToiDqztz5RSsJOVzXi/65dW4Y5n
         sp4RM4dy8RNsGcQvyVgOXqd743PCIXlGO9PZVahkEMVloliTiKy2vwOd9BcRv/+gU0mG
         kIrjzUjCYMEH4KfGKqApTBC0JmKb68Fl885gE9KkT7KhPR/B5PWLCObJywghz1xqnkek
         r1jg==
X-Gm-Message-State: ALQs6tANupzBxdOnWybnKRrY/gSg8wiJWp7tI3aBuOCEOH4uL0LUWT4F
        DWccNSFvk4cxKcRwKay8YlfHlTF90eNxVJ4IbW8=
X-Google-Smtp-Source: AB8JxZrwv2rpbdMVhrfa0Gl83VlqWLqpU71kesyic8yk7SNaF+DFWOvJkZJQ7WYyxJQlWCiwOA8wvKtxJeZg/5BbcAU=
X-Received: by 2002:aed:26a4:: with SMTP id q33-v6mr24312977qtd.165.1524517474810;
 Mon, 23 Apr 2018 14:04:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Mon, 23 Apr 2018 14:04:34 -0700 (PDT)
In-Reply-To: <05560086-232c-f14c-f82b-e21b7ecce1b3@web.de>
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
 <CAPig+cQzX04JuoUOnxOxWtqMCpHCUi=hMOSDL+jpNuML0iE+Tw@mail.gmail.com> <05560086-232c-f14c-f82b-e21b7ecce1b3@web.de>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 23 Apr 2018 17:04:34 -0400
X-Google-Sender-Auth: iQMCLE90zFXiwULls8kNhrkL_yE
Message-ID: <CAPig+cSbAaNby++AvCx4CkJ0KcRkx5Q=xs8VSbNmY=dgi-F9jg@mail.gmail.com>
Subject: Re: Is support for 10.8 dropped?
To:     =?UTF-8?Q?Totsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Igor Korot <ikorot01@gmail.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 23, 2018 at 3:58 PM, Totsten B=C3=B6gershausen <tboegi@web.de> =
wrote:
> On 2018-04-23 18:53, Eric Sunshine wrote:
>> On Mon, Apr 23, 2018 at 12:31 PM, Igor Korot <ikorot01@gmail.com> wrote:
>>> 1. Is the file name "config.mak" or "config.make"?
>>
>> "config.mak"
>
> I am confused, I have these file in my tree:
> config.mak.in  config.mak.uname   Makefile
> Setting options is documentend in Makefile

You can place custom build settings in a file named "config.mak" which
you create; it's not part of the distribution. The other files are not
intended for modification.

> I would actually try to install openssl / openssl-dev (or however it is
> called) via "mac ports" or "home brew".
>
> Both should work (but I don't have a system to test on)

Igor indicated earlier[1] in the thread that he wanted to avoid
Homebrew (and Macports, etc., presumably). If he'd be willing to use
Homebrew, then easiest would be simply to install Git itself via
Homebrew: "brew install git"

[1]: https://public-inbox.org/git/CA+FnnTzfJMBuSMAD7PgUurRu8jOpirEgM6=3D+=
=3Di91zdGLWmfUpg@mail.gmail.com/
