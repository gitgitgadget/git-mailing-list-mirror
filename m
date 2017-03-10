Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BEAF1FBEC
	for <e@80x24.org>; Fri, 10 Mar 2017 14:25:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934874AbdCJOZK (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Mar 2017 09:25:10 -0500
Received: from mail-io0-f173.google.com ([209.85.223.173]:35553 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937887AbdCJOXy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2017 09:23:54 -0500
Received: by mail-io0-f173.google.com with SMTP id z13so49445922iof.2
        for <git@vger.kernel.org>; Fri, 10 Mar 2017 06:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9Thyfpcx7gF71icJR9zFDiyjZgUNSYOQEh1okOQcwCY=;
        b=iyFPQuU6jF4VpcxcWVo8CCGPxJgLP7jt/kUU0AGnvONyVnm/J7WQn2rNPP1YdbSsA/
         246Nn71/U+cSUhQJwET8Ubw9/yxkel44TMbApOpBWwJXn3TYlWBK5gU784gD7ymh/Q29
         Snmvx5U8LvlDWWOgr9MRCBkJWtRsnPcaeiaQKEbAn2NE9ELXIc+07n9Jd1FBG+aYPDwb
         XFaqII0wbKFuYWyp436fIGfzXBgdp/umTmMLtUfqdd4AncQdeFrhB9CNFy1wKAhe13Fh
         d1zbVRk47QqSuA8EQT+wXXvosJ79s1XbzURJSbet8iZ/Lon89MUb0HURO4NxJWTbgfhl
         oVJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9Thyfpcx7gF71icJR9zFDiyjZgUNSYOQEh1okOQcwCY=;
        b=D2Ofs+6dLSLQ/cYMoT2cjAERzUy/vPKtUJh7yUDDjvLHTYzhB290jKkgfl1Ou2w5E/
         BVKYrapOXIyHKSqEsRc9T+Z0JYAoMZOaGMaBjeRuU4mf1dSjUq9CTrk7NHg8hiJPYpEx
         uH0Cm01CcPcdhs1XP3++dRSXuN2pxU+3nTV+nPUcnZp3hanGN3Qe/di3ey76p22+Rwi/
         1ZrgEsBMrq+z0u3ZJyVv171a/7cJfI9IghMtRFA56NYEZruygqG4cLp01T5pwTLrSsVK
         T/kkwz2EaXDf/XR8dPYpu94fpuTodXIgQY+5TAHJJEujkznRT6DRkDM/1gNgdr70+NX5
         inUg==
X-Gm-Message-State: AMke39kOYGsMCWvPTGu5ndmo692ciE/oOSrxYQXrWb8MVl1HXk9besYYeco8vwyPWY33z1tzcC+7Q1to0m+Jbw==
X-Received: by 10.107.200.139 with SMTP id y133mr18100243iof.147.1489155827996;
 Fri, 10 Mar 2017 06:23:47 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Fri, 10 Mar 2017 06:23:27 -0800 (PST)
In-Reply-To: <201703101100.15214.bernhard.reiter@intevation.de>
References: <201703101100.15214.bernhard.reiter@intevation.de>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Fri, 10 Mar 2017 15:23:27 +0100
Message-ID: <CACBZZX4Av-D6hxE9ceDFPuG-_qUQbH_6KW5JKsJf0SuH62jkuQ@mail.gmail.com>
Subject: Re: Stable GnuPG interface, git should use GPGME
To:     "Bernhard E. Reiter" <bernhard.reiter@intevation.de>
Cc:     Git Mailing List <git@vger.kernel.org>, gnupg-devel@gnupg.org,
        Lukas Puehringer <luk.puehringer@gmail.com>,
        Michael J Gruber <git@drmicha.warpmail.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 10, 2017 at 11:00 AM, Bernhard E. Reiter
<bernhard.reiter@intevation.de> wrote:
> Dear Git-Devs,

I haven't contributed to Git's GPG code, but I'm taking the liberty of
CC-ing some people who have.

> git uses an pipe-and-exec approach to running a GnuPG binary
> as writen in the documentation [1]:
>
>     gpg.program
>            Use this custom program instead of "gpg" found on $PATH when m=
aking
>            or verifying a PGP signature. The program must support the sam=
e
>            command-line interface as GPG
>
> please consider using libgpgme interfacing to GnuPG, because the gpg
> command-line interface is not considered an official API to GnuPG by the
> GnuPG-devs and thus potentially unstable.
>
> =3D=3D Details
>
> I'm involved in GnuPG development. For most applications using libgpgme i=
s the
> way what GnuPG-devs would recommend, also see
>
>   https://wiki.gnupg.org/APIs .
>
> GnuPG devs are making a good effort of trying to keep the command-line
> interface stable, though it is not for sure. Git is only using a small pa=
rt
> of the interface, so the risk when keeping the current way is small.
> Still I believe git's stability and usability would profit when moving to
> libgpgme, especially with the coming move to GnuPG 2.2, better diagnosing
> messages and for cross-plattform usage.
>
> =3D=3D Usability problem with `gpg2` vs `gpg`
>
> My use case today was signing and git by default found the `gpg` binary b=
y
> default and the command failed. The reason is that I have `gpg2` installe=
d
> and most applications use it right away. So git failed signing because
> the .gnupg configuration of the user was not ready for the old `gpg` whic=
h is
> still installed on Debian GNU/Linux for purposes of the operating system.=
 If
> git would have used libgpgme, gpgme would have choosen the most uptodate
> version of `gpg` available (or configured) without me intervening via
> gpg.program. Now because of this problem you could adding a check for `gp=
g2`
> and fallback to `gpg`, but even better would be to move to libgpgme. >:)

I'm on Debian but haven't had these issues. What's your gpg & gpg2
--version & Debian release? And what in particular failed?

And what git version was this? I see we've had a couple of workarounds
for gpg2, in particular Linus's v2.8.4-1-gb624a3e67f, but if you have
v2.10.0 or later that won't fix whatever issue you had.

Using the library sounds good, but a shorter-term immediate fix would
be to figure out what bug you encountered in our use of the
command-line version, and see if we've fixed that already or not.
Regardless of what we do with a gpg library in the future some distros
might want to backport such a small patch if we can come up with it.

> Best Regards and thanks for maintaining Git as Free Software,
> Bernhard
>
> =3D=3D how to respond
>
> ps: Please copy me on replies as I am not on git@vger.kernel.org.
> pps: I've copied gnupg-devel@ so they can see I've send this report, you =
don't
> have to.
>
>
> [1]
> https://github.com/git/git/blob/3bc53220cb2dcf709f7a027a3f526befd021d858/=
Documentation/config.txt
> search for 'gpg.program'.
>
> --
> www.intevation.de/~bernhard (CEO)     +49 541 33 508 3-3
> Intevation GmbH, Osnabr=C3=BCck, Germany; Amtsgericht Osnabr=C3=BCck, HRB=
 18998
> Owned and run by Frank Koormann, Bernhard Reiter, Dr. Jan-Oliver Wagner
