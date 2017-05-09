Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 291521FC44
	for <e@80x24.org>; Tue,  9 May 2017 00:00:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751243AbdEIAAl (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 20:00:41 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:33877 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751087AbdEIAAk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 20:00:40 -0400
Received: by mail-io0-f171.google.com with SMTP id k91so60602271ioi.1
        for <git@vger.kernel.org>; Mon, 08 May 2017 17:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=wSw6Kd7O6udhdM8AsL95TcEqcQsBJgzsvy0f+7ypt5I=;
        b=mVkxogbW7jv1lB+S4xQ/1cNltL2Ip1YTvkdP2d8t/Ewhz5kdSH3a8dIOqIIq3hnQKj
         YY1dp239nTaaNnnYYXw66JUXlvQAqnQ4zpUTxzhOWuHHL8R/d0dOHVN01vnCxmNUx1zt
         60iFKsN3vO1ax63TpOJl/CIW9ddT3zfSA+WE9fKJj/WNAZzGUm71HsSpnsvFjlkRado6
         f6HC0E/71eDCkIHi/a/4x35v5I1qvmoomgP1LGIy8J0LyuP4ntz9S6g7e/HqE0ThPVa8
         IXtMb5+4xeboS+fgNkB9PT/Hb60zSucWX8nKy5gNL60R4W2DQ+eB8P/Fz4qCnU6p+9rw
         py/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=wSw6Kd7O6udhdM8AsL95TcEqcQsBJgzsvy0f+7ypt5I=;
        b=Lrd+EYuJiPUv6EO8wskYISb+8tZO39ExTlWX27IUIDUauqyi5tkvetGcMm/0+cbZiu
         4qDOn0/iHQvwLvM7Z/Rhtw3ULHpePzSjidq/R+gjrD8fPrhhGs5CCN2fGIUk3Lpk8lH1
         rD3fAp3Sxa3hwAGFGirw5Q1IRB9x/jrsbISWvD/hpxSa+lRQhg00Kpzvw7fIw/yojNMJ
         1kmNWa7IqjWRtW3NidUIynU/3lwrRWHEzjahQ5J2yPtrH8ZS004o4wb86+yRMa2XPRok
         myYRT1G+D1uSf3wv7e7N7kPiuxBgWlpoBIfZKJKSIGTnwscjLtNcGfZXeb49wVVXioMq
         s5LQ==
X-Gm-Message-State: AODbwcBDcsl3hBlgd5280iluxp4c/cnGQjCPcqkrbo4C8bij5UQpZHZ8
        LudkSnamqqN7xruAB+d69po5kxHq1V9fX7k=
X-Received: by 10.107.138.21 with SMTP id m21mr4045603iod.80.1494288039539;
 Mon, 08 May 2017 17:00:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Mon, 8 May 2017 17:00:18 -0700 (PDT)
In-Reply-To: <20170508233224.udpuuzlygjpsjogt@genre.crustytoothpaste.net>
References: <CACBZZX5M1Pnvw01wP8id75Ja9NJ3nwVfydsX6g0Ys_QD72r6dQ@mail.gmail.com>
 <alpine.DEB.2.20.1705021756530.3480@virtualbox> <CACBZZX6-qZLEGob6CEwpJ7jtEBG6WLPdHQsO4DsbkNZ8di5mjg@mail.gmail.com>
 <alpine.DEB.2.20.1705031139090.3480@virtualbox> <CACBZZX6_5krLp93PmsW639-N4f1efUT5rPnN+5im=d9-66=QbQ@mail.gmail.com>
 <alpine.DEB.2.21.1.1705041104070.4905@virtualbox> <CACBZZX5bPN3vZhE=0TSQNdRvKYuV3635=VCQAppAfcZ_tuGpvg@mail.gmail.com>
 <alpine.DEB.2.21.1.1705041328190.4905@virtualbox> <CACBZZX75nvfQft-gjUG+YP0Y-e-=Knm3bMeDWHSUF=Juz9Ua5Q@mail.gmail.com>
 <xmqqpofj7rim.fsf@gitster.mtv.corp.google.com> <20170508233224.udpuuzlygjpsjogt@genre.crustytoothpaste.net>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Tue, 9 May 2017 02:00:18 +0200
Message-ID: <CACBZZX4G_ThE55Gi53QJt1=9K4jQXqJ3QL8JSGpiSSSDRrKeNA@mail.gmail.com>
Subject: Re: PCRE v2 compile error, was Re: What's cooking in git.git (May
 2017, #01; Mon, 1)
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 9, 2017 at 1:32 AM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On Mon, May 08, 2017 at 04:10:41PM +0900, Junio C Hamano wrote:
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>
>> > This won't be in my next PCRE submission, but I have a path locally to
>> > simply import PCRE into git.git as compat/pcre2, so it can be compiled
>> > with NO_PCRE=3DY similar to how NO_REGEX=3DY works.
>> >
>> > This will hopefully address your concerns partially, i.e. when you do
>> > want to try it out it'll be easier.
>>
>> Eek, please don't.
>>
>> Until pcre2 becomes _so_ stable that all reasonable distros give
>> choice to the end-users to install it easily in a packaged form,
>> such a "not a fork, but a copy" will be a moving target that I'd
>> rather not to have in compat/.  IOW, our compat/$pkg should be a
>> last resort to help those on distros that are so hard to convince to
>> carry the version/variant of $pkg we would like to use.

The reason I'm looking into this is because the WIP part of my PCRE
branch has changes which start to use PCRE as a general matching
engine in git, even. I.e.:

* git grep -F will be powered by it rather than kwset (which'll be git rm'd=
)
* Long standing limitations with \0s in regexes go away.
* grep -G and -E will use PCRE via a WIP POSIX -> PCRE  pattern
translator (https://bugs.exim.org/show_bug.cgi?id=3D2106)
* Perhaps we can remove compat/regex/ entirely & use PCRE via its
POSIX emulation mode + pattern translator (we use regcomp/regexec a
lot for non-grep/log), I'm not sure yet.

I have messy but working code for this in a WIP branch, here's the
performance improvement against linux.git:

Test                                           v2.13.0-rc2       HEAD
---------------------------------------------------------------------------=
------------
7820.1: basic grep how.to                      0.31(1.20+0.46)
0.19(0.33+0.55) -38.7%
7820.2: extended grep how.to                   0.31(1.19+0.46)
0.19(0.33+0.55) -38.7%
7820.3: perl grep how.to                       0.30(1.12+0.46)
0.19(0.28+0.62) -36.7%
7820.5: basic grep ^how to                     0.31(1.24+0.39)
0.19(0.32+0.56) -38.7%
7820.6: extended grep ^how to                  0.30(1.18+0.44)
0.19(0.22+0.66) -36.7%
7820.7: perl grep ^how to                      0.55(2.68+0.41)
0.19(0.32+0.56) -65.5%
7820.9: basic grep [how] to                    0.47(2.17+0.44)
0.22(0.39+0.54) -53.2%
7820.10: extended grep [how] to                0.47(2.21+0.40)
0.22(0.39+0.55) -53.2%
7820.11: perl grep [how] to                    0.53(2.64+0.39)
0.21(0.37+0.58) -60.4%
7820.13: basic grep \(e.t[^ ]*\|v.ry\) rare    0.63(3.16+0.48)
0.21(0.48+0.53) -66.7%
7820.14: extended grep (e.t[^ ]*|v.ry) rare    0.64(3.28+0.38)
0.21(0.45+0.57) -67.2%
7820.15: perl grep (e.t[^ ]*|v.ry) rare        1.00(5.77+0.37)
0.21(0.50+0.53) -79.0%
7820.17: basic grep m\(=C3=BA\|u\)ult.b\(=C3=A6\|y\)te   0.31(1.23+0.51)
0.19(0.30+0.58) -38.7%
7820.18: extended grep m(=C3=BA|u)ult.b(=C3=A6|y)te      0.32(1.26+0.47)
0.19(0.27+0.61) -40.6%
7820.19: perl grep m(=C3=BA|u)ult.b(=C3=A6|y)te          0.36(1.61+0.37)
0.19(0.30+0.57) -47.2%
7821.1: fixed grep int                         0.52(1.71+0.64)
0.43(1.11+0.72) -17.3%
7821.2: basic grep int                         0.54(1.62+0.70)
0.42(1.14+0.62) -22.2%
7821.3: extended grep int                      0.53(1.67+0.64)
0.51(1.17+0.62) -3.8%
7821.4: perl grep int                          0.53(1.71+0.59)
0.72(1.13+0.63) +35.8%
7821.6: fixed grep -i int                      0.58(1.86+0.67)
0.47(1.32+0.62) -19.0%
7821.7: basic grep -i int                      0.62(1.94+0.61)
0.57(1.25+0.72) -8.1%
7821.8: extended grep -i int                   0.82(1.86+0.68)
0.50(1.41+0.56) -39.0%
7821.9: perl grep -i int                       0.70(1.88+0.68)
0.56(1.25+0.70) -20.0%
7821.11: fixed grep =C3=A6                          0.33(1.30+0.43)
0.19(0.22+0.64) -42.4%
7821.12: basic grep =C3=A6                          0.33(1.35+0.38)
0.18(0.26+0.59) -45.5%
7821.13: extended grep =C3=A6                       0.33(1.20+0.52)
0.18(0.32+0.53) -45.5%
7821.14: perl grep =C3=A6                           0.33(1.31+0.40)
0.18(0.28+0.56) -45.5%
7821.16: fixed grep -i =C3=A6                       0.25(0.87+0.50)
0.18(0.24+0.60) -28.0%
7821.17: basic grep -i =C3=A6                       0.26(0.88+0.48)
0.18(0.24+0.60) -30.8%
7821.18: extended grep -i =C3=A6                    0.26(0.92+0.44)
0.18(0.24+0.61) -30.8%
7821.19: perl grep -i =C3=A6                        0.25(0.79+0.45)
0.19(0.32+0.56) -24.0%

In case that comes out misformatted it's also available at
https://github.com/avar/git/commit/ee5b2040e2c697e22a73c7b5f07f1b1e591f07e3

I.e. grepping is sped up by 50% and more in many cases, even for -G
and -E patterns which now get translated internally into PCRE
patterns.

> PCRE and PCRE2 also tend to have a lot of security updates, so I would
> prefer if we didn't import them into the tree.  It is far better for
> users to use their distro's packages for PCRE, as it means they get
> automatic security updates even if they're using an old Git.
>
> We shouldn't consider shipping anything with a remotely frequent history
> of security updates in our tree, since people very frequently run old or
> ancient versions of Git.

I'm aware of its security record[1], but I wonder what threat model
you have in mind here. I'm not aware of any parts of git (except maybe
gitweb?) where we take regexes from untrusted sources.

I.e. yes there have been DoS's & even some overflow bugs leading code
execution in PCRE, but in the context of powering git-grep & git-log
with PCRE this falls into the "stop hitting yourself" category.

1. https://www.cvedetails.com/vendor/3265/Pcre.html
