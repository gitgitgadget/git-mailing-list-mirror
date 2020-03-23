Return-Path: <SRS0=3T2S=5I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BDFAC54EEB
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 14:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 157B920784
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 14:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="jis70XYi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbgCWOh5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Mar 2020 10:37:57 -0400
Received: from mout.web.de ([212.227.15.4]:36067 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbgCWOh4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Mar 2020 10:37:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1584974274;
        bh=asHPBli9XKmNvqI8Rt9solla30sVOgGV0NgcjNi+te8=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=jis70XYiSKhzwC0RhPm4tu6e3gB7j7J44zg8t7ayTlw4lHHEYUk+xRBSeKp+74Tlh
         zugNxOdX2W7N1AjwflYYW5vBvng+LKzKyE7ZL3CNMs8kQmxkQvJnABo+Bjzuq/hKTc
         CRtG5V6p4P6DRHhUzRBQDDPZgEwDFIsVtRN9q5ic=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MJlGW-1jHUfu2BKG-0018c1; Mon, 23
 Mar 2020 15:37:54 +0100
Date:   Mon, 23 Mar 2020 15:37:54 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 6/8] t7063: drop non-POSIX argument "-ls" from find(1)
Message-ID: <20200323143754.zagvr6xrz3x3nrpa@tb-raspi4>
References: <cover.1584838148.git.congdanhqx@gmail.com>
 <59e3f73784b2a3bd9ccec87412e6178411c3708e.1584838148.git.congdanhqx@gmail.com>
 <nycvar.QRO.7.76.6.2003231509150.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <nycvar.QRO.7.76.6.2003231509150.46@tvgsbejvaqbjf.bet>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:vAEmzdi5wnbcZegQZ6QfZ/r9sjsQbmbkcMpD6VBSMnYCnElcJ6Q
 04By0EhRYriZ5+jXXue87jyigthBnjpihm6ah/86fR8P1ElV76brSGHJ6jFUwooOCyVSwVs
 9iT2arZMVAquyVHlGLl6aY1kMEhAKBAmWDkpn31f+Qe5UpwQz75eMH37anrfdblwey9fDsw
 SuR9+myvAOctFSgHPA7CA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QsIx5b2Y5pw=:2Bxhnz2R2HdlqEiQSnCw2b
 u0jjFH8a6I6rxp3vpxhbla0XBQniYYRdtahLq3h3xoBWhLipy7n8VZpSToRg3qPDi1F+bQ7Jq
 AAwro77gcRKbVetDQp2ZmiLSlRRzaLz/gEiGeSt7vuNyDbWIQIFAkiy3Tw61B68tB/0TsfOnz
 W+NlgHTNejjKCA9OL3v1J+zod0cOM64wariEX47yqNPR/8bXNJdbI5OscV40CEo/t+BtWOj6E
 L3+kn3jF9fPe5IEjeWHW5abT7p+LgFwneltbkww21at36wNu8BmZDNTFXUAkLqlgndjTxQW31
 XDC+bYiMtI4RfGgPKBC1PILFOIGu6yiC+xcTZzKC8iIkRI5fQtytZu0w9Qe53Riuyz15KqOJJ
 WDdI9DrD+67/zWtUQurXuVa8iSGHrpdeI5Yq/nSIpz9Pvt0C5hDrrvK1Wiw829+Q3zGNg2Y3E
 dldkH2W/0pv2B89sEYn/1dnWXSS8jSfjgAtEwO6/JYRBOGGDUyo7i1TcU4iljhz/9U5zcxtHq
 mXzwhLKONUF7wNsF/lVoRbMaqrZTlyt6G7ZVLoNycSVeEz8OyI0m3NWqTkmVB+/d7QVpLKtZu
 vJCzkN2LCDWMIc9EGj8YANEfaTWCY2YlO/waSci61qGihqd5vcikYbAyDnF/UMmlGr/I1+sS5
 vT0IlIFptk+3mmJOTUPCEWfXV1m5pko7GJPScEe9rS6UeDgk8Sk/ZPSWjjyMGyApn4QaxYi9G
 nBv59WoQXHnXR/q63cKZPR9yp1vqKlJkIKVosYE3qTTXJWIPI2RVRQNu4fPeoMXZIAl55PImD
 OqhaeEBuwm0dayvCTEg9wA+v/CTTN2VIU/9ulGfj3WGWADdPa33gQscPlUV2uwIj11j2eVpIS
 iJ+Hi+AEbPUWb+LIBieieAtdsP2Fv0qIV6YiEr65l6aaGvxBip9s3cMAgleJszGoQvP2JUHPI
 01tycS/Gdjz+G2sa8ceMJMYTXZxx6zsb2e8Jo/tfzePcjpjGBg7x2dBChsMV3shWWxXxO9S2M
 cU69AIImObTVr5a4Yio4Oyab26YdOTi2D3Yy5tcIVX6YTMlfxkAN9vR2w/tiClU9l4sv7nWc6
 OnfHGdHUL6iq2yWrYdfP/f/vxnYqz2chsT1YF8o3FVvPB284+Fm+485R+kVvcg25nM2EXbdjT
 7E8iZ4bRHVsC+OcRS8qsKWYjgr4FCGM5ZecmY+PZiaofhkhMprLlh/YW/dkp0ZfCUnXqElycb
 X/KvXbU/7aXq+yswt
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 23, 2020 at 03:11:50PM +0100, Johannes Schindelin wrote:
> Hi,
>
> On Sun, 22 Mar 2020, =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh wrote:
>
> > Since commit 6b7728db81, (t7063: work around FreeBSD's lazy mtime
> > update feature, 2016-08-03), we started to use ls as a trick to update
> > directory's mtime.
> >
> > However, `-ls` flag isn't required by POSIX's find(1), and
> > busybox(1) doesn't implement it.
> >
> > >From the original conversation, it seems like find(1) with "-type d"
> > could trigger enough "lstat(2)" to ask FreeBSD update mtime.
>
> This rationale  makes me uneasy: why did Duy add _both_ `-type d` *and*
> `-ls` if the former would have been enough?

man readdir on my Linux gives:
[]
DESCRIPTION
       The  readdir() function returns a pointer to a dirent structure rep=
resenting the next
       directory entry in the directory stream pointed to by dirp.  It ret=
urns
       NULL on reaching the end of the directory stream or if an error occ=
urred.

       In the glibc implementation, the dirent structure is defined as fol=
lows:

           struct dirent {
               ino_t          d_ino;       /* Inode number */
               off_t          d_off;       /* Not an offset; see below */
               unsigned short d_reclen;    /* Length of this record */
               unsigned char  d_type;      /* Type of file; not supported
                                              by all filesystem types */
               char           d_name[256]; /* Null-terminated filename */
           };

So we could imagine that `find` is clever enough to extract "-type d" alre=
ady
when calling readdir(), and the "good old" following stat() is not needed =
here.

So I would strongly agree with Dscho to keep the `ls`

[snip]
