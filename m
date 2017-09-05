Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67579208E3
	for <e@80x24.org>; Tue,  5 Sep 2017 18:35:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753369AbdIESf2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Sep 2017 14:35:28 -0400
Received: from mail-ua0-f179.google.com ([209.85.217.179]:37787 "EHLO
        mail-ua0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753323AbdIESfN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2017 14:35:13 -0400
Received: by mail-ua0-f179.google.com with SMTP id k23so9946479uaf.4
        for <git@vger.kernel.org>; Tue, 05 Sep 2017 11:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=G72Nmk3YGyhadY7CgbqvkWI7Xrdq5f3bmqKCYd+IiRE=;
        b=ozIuoBCbYJ0dpm3oVlLtpJSuVejYpOyTb0AW+YdOcmNEUk1GRGNaB3ejsTM+gc6il3
         GIfwAbASYz5de2/IdTsFgBlbtfC+zdglWtYr1c+Yb6avz6ruIn+UhckRJSlzIjlDMKas
         718AJNTv13x5en7DJAhtB23DAoAHlLPtxFznt7FaK8RbDOumaU7a9kXKqfW3YXkoN4PQ
         /5qmXYf6zbhj8KZa2S2nyMGf+QvWb8bPzwy4Eisdhs2/vaT9raWaYdcTXFkomkoA6QUQ
         Cit1P6CIo5IN2aUJ/yAIQQMm9OlGcjxDXKZt+sOWXmbLde7/LnQTVgeZjY6YVa58QKfU
         Dw2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=G72Nmk3YGyhadY7CgbqvkWI7Xrdq5f3bmqKCYd+IiRE=;
        b=Lbrk/+bPX1BXI4Gbqb2PAHU8Y3u5uP6GEggKZ1BDGA7VVZr2Hx33nMUFgJ0Euy0jUP
         hZfsBXoiVaap3uBuELgLPWUkEujUBt/w0gl0Z3AX3PVoB1oenqx3dNCFr3J+HJfw/GEx
         GOk+SuAf6JjeOQCp2u0AoEOglXM+sbbr0PabisXMbCtKAqg7vI1fqaxh3XkS9XWmOjXd
         jzm9LLNPO3wXOzTCHwK/iP9N/4Sdf1635qVJACpqwRczIZo9Ky2BPkXoYj0KOIVbs+ZB
         frfLbtJglRdRVeAcgqpWpZ6in29gdzn2xiDoXgPH+kip5E7CgJHYpoEwOjCB5UQ+2mta
         Fkww==
X-Gm-Message-State: AHPjjUg0W5H3rlqwmZBCoF40ljO6TxoMFCNvU3vXMnQ5VbMZMdzbTbyh
        LQ5q7WB5CacLwKeB98Cyxb0lG45AtjAyymk=
X-Google-Smtp-Source: ADKCNb5vdGh0cGbFdQDhfwfAQhMdDDLDaf7vV/+pcMt1NsL2PFLBl9sptG0oH6AdZQJCnNU9tNWR9sSjaSNuXtMyudY=
X-Received: by 10.176.77.195 with SMTP id b3mr14166uah.118.1504636512498; Tue,
 05 Sep 2017 11:35:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.89.35 with HTTP; Tue, 5 Sep 2017 11:34:52 -0700 (PDT)
In-Reply-To: <0e626914-05b1-651c-9c61-b1ef0b6c190a@grubix.eu>
References: <CAH_OBieqSY8To9okRTL-z5dnjW=_NLzA+n5-7=eou=Lx33hBdQ@mail.gmail.com>
 <0e626914-05b1-651c-9c61-b1ef0b6c190a@grubix.eu>
From:   shawn wilson <ag4ve.us@gmail.com>
Date:   Tue, 5 Sep 2017 14:34:52 -0400
Message-ID: <CAH_OBickeYBWE-ygQY=pjh33_mFMXYqcwvVieRTA2cuCwzXcHA@mail.gmail.com>
Subject: Re: signing commits using gpg2
To:     Michael J Gruber <git@grubix.eu>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Apparently you need to set the GPG_TTY for git to work (I also set the
gpg.program so I know it shouldn't /need/ that variable set)
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D840687#10

I'm not sure if there's anything that has or can be done upstream to
make this easier (I feel this was a bigger PITA than it needed to be),
I'm on git 2.7.5 from Fedira.

On Tue, Sep 5, 2017 at 9:40 AM, Michael J Gruber <git@grubix.eu> wrote:
> shawn wilson venit, vidit, dixit 02.09.2017 23:11:
>> tl;dr - how do I get git to use gpg2 to sign things?
>>
>> I'm using gpg2 (so no agent options are configured but an agent is
>> running) which is configured w/ a Nitrokey (Pro if it matters):
>>
>>  % git commit -m "Initial."
>>
>>                                  gits/bash-libs (master =E2=9A=A1) local=
host
>> gpg: detected reader `Nitrokey Nitrokey Pro (000034670000000000000000) 0=
0 00'
>> gpg: pcsc_connect failed: sharing violation (0x8010000b)
>> gpg: apdu_send_simple(0) failed: locking failed
>> Please insert the card and hit return or enter 'c' to cancel:
>> gpg: pcsc_connect failed: sharing violation (0x8010000b)
>> gpg: pcsc_connect failed: sharing violation (0x8010000b)
>> gpg: apdu_send_simple(0) failed: locking failed
>> Please insert the card and hit return or enter 'c' to cancel: c
>> gpg: selecting openpgp failed: general error
>> gpg: signing failed: general error
>> gpg: signing failed: general error
>> error: gpg failed to sign the data
>> fatal: failed to write commit object
>>
>> This works with gpg and ssh:
>
> Not really...
>
>>  % touch foo
>>
>>                                                          ~ localhost
>>  % gpg2 --sign foo
>
> ... because you're using gpg2, not gpg.
>
>>
>>                                                          ~ localhost
>> gpg: using "846FF490" as default secret key for signing
>>  % cat foo*
>>
>>                                                          ~ localhost
>> -----BEGIN PGP MESSAGE-----
>> Version: GnuPG v2
>>
>> owEBuQFG/pANAwAKAYwdY7SEb/SQAcsJYgNmb29ZqxfviQGcBAABCgAGBQJZqxfv
>> AAoJEIwdY7SEb/SQAcEL/jonw+HymnlmfebtEwlvfx2Gl1Sbuw0xWWPpQ2Dtjljz
>> HtpD+LWczjpOSMTHFNK9xPR2kcs1WNY+mO8M45QI7iDgFkKRzaxEqeNUJkoyF/+I
>> 81VMmXDQMXFs4+8jy00b+UxTdvwdXaHMsOtu+6YCtmCR5Bzohg07ADsnXnGGn3Sd
>> WTjVMzV6Dlh8LRF+coGJ8JuErBsRAI6vdNgJRVHYBULGNXci4uF/4a+58uiTL4/U
>> PvC4ruXCNxCKi89nMERhwlnOvglseX3TDR5ldrc4Hzb+pLsj/l6N4sBW0Zmb8UcE
>> 9BG3WjOs4eZvnLmk5XHrwisD2CXuHvyWMl0yH7LTrg+m4Itj0PJ4Px4H9E5t/zfs
>> C1vcB/okcigeIyXnO06um02a5oZAYOKadB+6NRnBjULz5GvP2yxj/AO1VPmZprpt
>> budMuHZcA0zNE3uBmcnQY5+1tdkyTrlTxsL58lQrn/U3wvgah3AXMEvjRGqbYWHj
>> jDikQVJ7ESoevNqlfLPj8Q=3D=3D
>> =3DhV6v
>> -----END PGP MESSAGE-----
>>
>> However, if I try this w/ the old gpg:
>>
>>  % gpg -ae -o foo.gpg foo
>>
>>                                                          ~ localhost
>>  % gpg -d foo.gpg
>>
>>                                                          ~ localhost
>> gpg: detected reader `Nitrokey Nitrokey Pro (000034670000000000000000) 0=
0 00'
>> gpg: pcsc_connect failed: sharing violation (0x8010000b)
>> gpg: apdu_send_simple(0) failed: locking failed
>> Please insert the card and hit return or enter 'c' to cancel: c
>> gpg: selecting openpgp failed: general error
>> gpg: encrypted with 3072-bit RSA key, ID 41826CFB, created 2017-03-13
>>       "Shawn Wilson <ag4ve.us@gmail.com>"
>> gpg: public key decryption failed: general error
>> gpg: decryption failed: secret key not available
>>  % gpg2 -d foo.gpg
>>
>>                                                          ~ localhost
>> gpg: encrypted with 3072-bit RSA key, ID E27FA0B841826CFB, created 2017-=
03-13
>>       "Shawn Wilson <ag4ve.us@gmail.com>"
>> foo
>>
>> (yeah I added data to the file)
>>
>> And just to prove basic competency checking:
>>
>>  % git config --global -l | grep sign
>>
>>                                                          ~ localhost
>> user.signingkey=3D846FF490
>> filter.gitconfig-rmuser.clean=3Dsed -e "s/^\( *email =3D\).*/\1 <email
>> address>/" -e "s/^\( *name =3D\).*/\1 <real name>/" -e "s/^\(
>> *signingkey =3D\).*/\1 <gpg key>/"
>> filter.gitconfig-rmuser.smudge=3Degrep "^ *(email|name|signingkey) =3D "
>> commit.gpgsign=3Dtrue
>>
>
> So, gpg2 works and gpg does not. This is typical for the way in which
> the gpg upgrade path is broken, and your distro installs gpg because it
> still relies on it.
>
> git sees two executables gpg and gpg2 and uses the first, so as to not
> migrate your secrete key store inadvertently.
>
> Short answer: Use
>
> git config --global gpg.program gpg2
>
> to make git use gpg2 which apparantly is your working gnupg setup.
>
> Michael
