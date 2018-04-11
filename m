Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F7451F404
	for <e@80x24.org>; Wed, 11 Apr 2018 04:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751617AbeDKE2i (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Apr 2018 00:28:38 -0400
Received: from mail-ot0-f181.google.com ([74.125.82.181]:34237 "EHLO
        mail-ot0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751553AbeDKE2f (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Apr 2018 00:28:35 -0400
Received: by mail-ot0-f181.google.com with SMTP id m7-v6so571387otd.1
        for <git@vger.kernel.org>; Tue, 10 Apr 2018 21:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=IR1cLg4r+IzzsJLkAt9IJ4ISeFpMDEvPjlKAAHFh4i4=;
        b=cEUxk/b68TN376Ztha/BCgr8PCTeKRg32Wn7KU+eNXo5XALVExv0BPXjdhaI9PVb/D
         t/0ud1diXasZfFWoBwWACxmYKHLBe++GA/IqKXx6eaDgFtCQkvlxg1nog3wHXes5dulF
         VbeBOsFpLCe+H3qYKZiQB9c9oNi7W6qi0s74e1SAHtHbLsTAPYtw+lbSHjUR5Ypqd6ew
         UpZ4tFY9ifq0knYtyfWzse1TShAV7lNdikBlaLgFI3sX6qXIvb1wFSMCnZNrMNos+tZR
         CcQLLZNcoyMw2YpIffDgVg9NrjxjtPD2Ya9j/zXNy0MCOg8XBLebVoHB2CEB+oix0aVL
         q5bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=IR1cLg4r+IzzsJLkAt9IJ4ISeFpMDEvPjlKAAHFh4i4=;
        b=Y59sr2x7NJ6QpfmSLUK1ro7rfSwTfvesUnjIiRqOrUNJYiNhLn4oiy8RMJ51xFxPSr
         NlQbNEvTM7uFlWUREQhU9pkksZ/372lM3eGgeMF0V9FM2Eum1Ap6Nz8Zed0Fit6drjeC
         WrkRFmxNO1LFCV/opKYhS7x5SpgR/hIcMtOeLYdDXIPhmDoZhpZvkAekDBnjPCu5/3S8
         8RjDlqxnE/eOPqehWWjiIckkPlGQxI2PRoOe145e7jjBWwQu+fcPWSKifpzC0fXRztkv
         1NPmmqlxbRUJ3jFtQXmiBQRdfdH+FtX/UqPjPj2WTqm8qmPyWlf3qs93euwl4BWTlJ/y
         bMXw==
X-Gm-Message-State: ALQs6tB/3Y8Io+VJuD+8+IvGWhXbLPXp3Iwo0BvrDSG2U+BOlCF0VUvS
        jIZ590Zi4NMYDrK0yxexIM0Tv0/l69WOGMzAmYFCfQ==
X-Google-Smtp-Source: AIpwx4+XdEMiS4xLv/HMLp89nsbthEuG1R892RvfI7txLt4YFFx7bCQM+Mg/sgfAedqitPlk1ctPVS8gTcazaYpCqt4=
X-Received: by 2002:a9d:21e5:: with SMTP id s92-v6mr2218715otb.165.1523420914733;
 Tue, 10 Apr 2018 21:28:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.201.102.138 with HTTP; Tue, 10 Apr 2018 21:28:34 -0700 (PDT)
In-Reply-To: <CAPig+cRjYju4zEgiY_TuOOk0e7A8zNz+hu+40vQUEGDX6FGDxw@mail.gmail.com>
References: <CA+FnnTxbg97A4P3AP7n5RT8+=W8PY0yx3644Ay2Zi9xgKD2aoA@mail.gmail.com>
 <CAPig+cR19LS2vfjBQ71c3j2g61vSHnYRj1iSX1-V_E3Fj=kwOA@mail.gmail.com>
 <CA+FnnTzfJMBuSMAD7PgUurRu8jOpirEgM6=+=i91zdGLWmfUpg@mail.gmail.com>
 <CAPig+cQOzKbM0R6vKTg_BU6meEbAAJWL1T0jZkaCOF0uJ=_Lmw@mail.gmail.com>
 <CA+FnnTzqaPrLgYv-8X9BDW0DR7331morN33B81w8T3vzOwn+Pw@mail.gmail.com>
 <CA+FnnTz-qdVK5482GJo06QrvMktGYhJAJ6g-Naq0BgT-uoRvEA@mail.gmail.com>
 <CAPig+cS+gf5gGM3fmnxk-6k7ezbtS=KQFqkkxVtcytHfcQApEQ@mail.gmail.com>
 <CA+FnnTwvnA90nDARKW9r7p5iraoOGTvfDJ26n6Udc68bDSUASw@mail.gmail.com> <CAPig+cRjYju4zEgiY_TuOOk0e7A8zNz+hu+40vQUEGDX6FGDxw@mail.gmail.com>
From:   Igor Korot <ikorot01@gmail.com>
Date:   Wed, 11 Apr 2018 00:28:34 -0400
Message-ID: <CA+FnnTzFomd91d1F6O-a28hXQ6PxOiBd44da4nSVW0MuDKgkmw@mail.gmail.com>
Subject: Re: Is support for 10.8 dropped?
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Eric,

Sorry for the long delay.

On Sun, Apr 8, 2018 at 7:59 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sun, Apr 8, 2018 at 7:55 PM, Igor Korot <ikorot01@gmail.com> wrote:
>> On Sun, Apr 8, 2018, 6:23 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>>> And, as noted earlier, before running "make", you may need to create
>>> config.mak to override some settings documented at the top of Makefile
>>> (in particular, you may want to set NO_GETTEXT if you don't want to
>>> install gettext and don't think you'll need it). As prerequisite,
>>> you'll probably need to install OpenSSL.
>>
>> Is there a way to check for OpenSSL presence?
>
> Not sure what you're asking. Are you asking how to determine if you
> already have OpenSSL built on your machine?

Yes, that's what I was asking...

>
> Note that you might be able to get by without installing OpenSSL since
> Git will try to use Apple's "Common Crypto" instead, so you could
> define NO_OPENSSL in config.mak and see if the project builds.

This is what I got trying to do just "make":

MyMac:git-2.17.0 igorkorot$ make
    * new build flags
    CC credential-store.o
In file included from credential-store.c:1:
In file included from ./cache.h:9:
./gettext.h:17:11: fatal error: 'libintl.h' file not found
#       include <libintl.h>
                ^
1 error generated.
make: *** [credential-store.o] Error 1

And I am also confused. Which file am I suppose to modify here?

MyMac:git-2.17.0 igorkorot$ ls -la conf*
-rwxr-xr-x@ 1 igorkorot  staff  74461 Apr  2 10:13 config.c
-rwxr-xr-x@ 1 igorkorot  staff   9888 Apr  2 10:13 config.h
-rwxr-xr-x@ 1 igorkorot  staff    540 Apr  2 10:13 config.mak.in
-rwxr-xr-x@ 1 igorkorot  staff  16940 Apr  2 10:13 config.mak.uname
-rwxr-xr-x@ 1 igorkorot  staff  37509 Apr  2 10:13 configure.ac
-rw-r--r--  1 igorkorot  staff  37500 Apr  8 18:52 configure.ac+

Thank you.
