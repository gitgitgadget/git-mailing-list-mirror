Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14979208E3
	for <e@80x24.org>; Sat,  2 Sep 2017 21:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752769AbdIBVMN (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Sep 2017 17:12:13 -0400
Received: from mail-ua0-f177.google.com ([209.85.217.177]:37179 "EHLO
        mail-ua0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752761AbdIBVMM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Sep 2017 17:12:12 -0400
Received: by mail-ua0-f177.google.com with SMTP id k23so3924708uaf.4
        for <git@vger.kernel.org>; Sat, 02 Sep 2017 14:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=WkMWbsQwBcZP9qOUCG+KaQeVey2kTwHFbI5bUmO772o=;
        b=pUrZq+2vdqpi4fx4btEV45l+231iWUulzOt54IpQFc+zyj1bXLcxZ2QqWd6oQBO80d
         o1yLmZlm4UY9cKPWqoMO2yo629K1/45sgbzsYulo7d2cV+u/pX5ZLLYfuaH6lR8/qBs+
         goWZebnNMMzuuKnsek45ooSD6gAI2eEiQ5BoA8Fj4J+ptzPq7xfuB2ml1DFvbWE7FDZ2
         7VZDpzueX28p7O3Tvo5nwBBZwfM31qzWukJeVX4k3UPGT1IfXKyeNTOsJSF9VMSGrNkA
         H/E3c7ymQ0J2mKB9R2cEyy04GI33807L0Ln8W2Ppe1MP1/+fYyeIEz/pDjYR+EIkyg92
         RMBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=WkMWbsQwBcZP9qOUCG+KaQeVey2kTwHFbI5bUmO772o=;
        b=ccaWaK00OIQDZqHKPIWoGIAFglUv8agXC+8u9m6WVP447ltY3897QiuP0W9Svndx5v
         Tft86CrOOXud1qCHsyhBAWw5TfOt6iRUZZPEjhmWsRBvmb/hBN00VNwMpU7xon2/Kvcl
         +6AlHOvPkCW92Ql1rgZlLlESZPkoD8UKfP7rymfqu75H3rBZ1kDy1AepN97KURgMrd4S
         27vSpPze6Efp/2qVHPt2SGdGuR3vLttCfGFBYjREjH+h1efMGZM9ol3AXT50aUVDGkbV
         qRU7uMfcdeRLsIzGTDEiDR4MFUGsTuOy3+iF4K+SKSkTkMQXmz9BYqeV4Bai6CkfXK92
         rofw==
X-Gm-Message-State: AHPjjUj/8yz96zhZj8w4a+DEJ20cXRk8+jm+tLZlnqVsXS/UMWI61GG9
        hsS4i0qpApmja2BZet4kiIWLfET+7/sEob4=
X-Google-Smtp-Source: ADKCNb60IHHzNzZKCWdUYFASRtIQUDciInf9Bnj7adLfZugqr3qdZUZbmEYNaKqRfm78WCF/wEP8YgnV7DcCzEl3nGY=
X-Received: by 10.159.59.9 with SMTP id i9mr3969279uah.167.1504386731450; Sat,
 02 Sep 2017 14:12:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.89.35 with HTTP; Sat, 2 Sep 2017 14:11:50 -0700 (PDT)
From:   shawn wilson <ag4ve.us@gmail.com>
Date:   Sat, 2 Sep 2017 17:11:50 -0400
Message-ID: <CAH_OBieqSY8To9okRTL-z5dnjW=_NLzA+n5-7=eou=Lx33hBdQ@mail.gmail.com>
Subject: signing commits using gpg2
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

tl;dr - how do I get git to use gpg2 to sign things?

I'm using gpg2 (so no agent options are configured but an agent is
running) which is configured w/ a Nitrokey (Pro if it matters):

 % git commit -m "Initial."

                                 gits/bash-libs (master =E2=9A=A1) localhos=
t
gpg: detected reader `Nitrokey Nitrokey Pro (000034670000000000000000) 00 0=
0'
gpg: pcsc_connect failed: sharing violation (0x8010000b)
gpg: apdu_send_simple(0) failed: locking failed
Please insert the card and hit return or enter 'c' to cancel:
gpg: pcsc_connect failed: sharing violation (0x8010000b)
gpg: pcsc_connect failed: sharing violation (0x8010000b)
gpg: apdu_send_simple(0) failed: locking failed
Please insert the card and hit return or enter 'c' to cancel: c
gpg: selecting openpgp failed: general error
gpg: signing failed: general error
gpg: signing failed: general error
error: gpg failed to sign the data
fatal: failed to write commit object

This works with gpg and ssh:
 % touch foo

                                                         ~ localhost
 % gpg2 --sign foo

                                                         ~ localhost
gpg: using "846FF490" as default secret key for signing
 % cat foo*

                                                         ~ localhost
-----BEGIN PGP MESSAGE-----
Version: GnuPG v2

owEBuQFG/pANAwAKAYwdY7SEb/SQAcsJYgNmb29ZqxfviQGcBAABCgAGBQJZqxfv
AAoJEIwdY7SEb/SQAcEL/jonw+HymnlmfebtEwlvfx2Gl1Sbuw0xWWPpQ2Dtjljz
HtpD+LWczjpOSMTHFNK9xPR2kcs1WNY+mO8M45QI7iDgFkKRzaxEqeNUJkoyF/+I
81VMmXDQMXFs4+8jy00b+UxTdvwdXaHMsOtu+6YCtmCR5Bzohg07ADsnXnGGn3Sd
WTjVMzV6Dlh8LRF+coGJ8JuErBsRAI6vdNgJRVHYBULGNXci4uF/4a+58uiTL4/U
PvC4ruXCNxCKi89nMERhwlnOvglseX3TDR5ldrc4Hzb+pLsj/l6N4sBW0Zmb8UcE
9BG3WjOs4eZvnLmk5XHrwisD2CXuHvyWMl0yH7LTrg+m4Itj0PJ4Px4H9E5t/zfs
C1vcB/okcigeIyXnO06um02a5oZAYOKadB+6NRnBjULz5GvP2yxj/AO1VPmZprpt
budMuHZcA0zNE3uBmcnQY5+1tdkyTrlTxsL58lQrn/U3wvgah3AXMEvjRGqbYWHj
jDikQVJ7ESoevNqlfLPj8Q=3D=3D
=3DhV6v
-----END PGP MESSAGE-----

However, if I try this w/ the old gpg:

 % gpg -ae -o foo.gpg foo

                                                         ~ localhost
 % gpg -d foo.gpg

                                                         ~ localhost
gpg: detected reader `Nitrokey Nitrokey Pro (000034670000000000000000) 00 0=
0'
gpg: pcsc_connect failed: sharing violation (0x8010000b)
gpg: apdu_send_simple(0) failed: locking failed
Please insert the card and hit return or enter 'c' to cancel: c
gpg: selecting openpgp failed: general error
gpg: encrypted with 3072-bit RSA key, ID 41826CFB, created 2017-03-13
      "Shawn Wilson <ag4ve.us@gmail.com>"
gpg: public key decryption failed: general error
gpg: decryption failed: secret key not available
 % gpg2 -d foo.gpg

                                                         ~ localhost
gpg: encrypted with 3072-bit RSA key, ID E27FA0B841826CFB, created 2017-03-=
13
      "Shawn Wilson <ag4ve.us@gmail.com>"
foo

(yeah I added data to the file)

And just to prove basic competency checking:

 % git config --global -l | grep sign

                                                         ~ localhost
user.signingkey=3D846FF490
filter.gitconfig-rmuser.clean=3Dsed -e "s/^\( *email =3D\).*/\1 <email
address>/" -e "s/^\( *name =3D\).*/\1 <real name>/" -e "s/^\(
*signingkey =3D\).*/\1 <gpg key>/"
filter.gitconfig-rmuser.smudge=3Degrep "^ *(email|name|signingkey) =3D "
commit.gpgsign=3Dtrue
