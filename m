Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43B8C1F461
	for <e@80x24.org>; Wed,  3 Jul 2019 11:27:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfGCL1N (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jul 2019 07:27:13 -0400
Received: from mout.gmx.net ([212.227.17.22]:43203 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726544AbfGCL1N (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jul 2019 07:27:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1562153214;
        bh=YjaowlWRg0U2bjiWggZq6vfC+ttj0c8EEPXKqOdbdk4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=YD+7bbjuAERDYzv0gyxx3ZHtWocOZ2ki9RAgi5k/xUNZse0sEpba8lIxU76g8h2ho
         iqAy2o1y5tfsuoF2lqzhAK9Evl2rpZjqZJRkSBaraYtmU0tthKkhaCgIw34KqshEZa
         NEjy2EtgUeK6i7e2AcWGuSoaefJam2ICnyhUY6jw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mv31c-1iZMUQ2G2K-00r2we; Wed, 03
 Jul 2019 13:26:54 +0200
Date:   Wed, 3 Jul 2019 13:27:22 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     git@vger.kernel.org, git-packagers@googlegroups.com,
        gitgitgadget@gmail.com, gitster@pobox.com, peff@peff.net,
        sandals@crustytoothpaste.net, szeder.dev@gmail.com
Subject: Re: [PATCH v3 00/10] grep: move from kwset to optional PCRE v2
In-Reply-To: <nycvar.QRO.7.76.6.1907031213220.44@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.1907031326300.44@tvgsbejvaqbjf.bet>
References: <20190627233912.7117-1-avarab@gmail.com> <20190701212100.27850-1-avarab@gmail.com> <nycvar.QRO.7.76.6.1907021417050.48@tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.1907031213220.44@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1207080342-1562153244=:44"
X-Provags-ID: V03:K1:fNn7txl0Chu2gLAygmF4iXNRLDGbT5LvlHgVOi1IMAX/kWhBq8Q
 rM65nQJDlrHJ7P13fO4kM4+cY8gBHwkLVEMZ0mSbfUONRgk5ICsv+HDX0hJfK/f1TVV6wNA
 462EFviZaNfU3WDBRmJR7xgZ+0GGv3I2oK3/Anu5SNSsju0g+BK+Luk1w0hcpBMBNtbdsri
 ouCpCrxOGt6Q0d2alzyrA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZN06RetMGUQ=:r66zJVK3RHDlWvhSqZIrrf
 kdb46ddxHzdMh1dtJmz8s4xF/UEmWRNDE/IvGznBKf+R5cQYyvKVBjhfdfUkvhc3r/Hxf1wA1
 SvXoLDY6pH77ZtGxPGAgH0wxLD+IDRIzYfYSxDUFqkWts72Wsv0Mkyd/Ma8t3FJj9KPz3ZHtf
 s88lR99QGrRmioJk6n2bp4jKCC1PLgchNFgdZGuK3vFerJPcjVDQEFkMbabV3mxCVkr2D0QKt
 F8WpxHseIDjERmeNVf1lK6u+qNh/AlOetusVjxlAOyy15Tbgxw3D3yDLqKCxrM9s0ivwzmSAK
 w5n5Aq67BJxl2UQg0qOhThOFLYbl+sfWgUHXx/FltXSPSGW4Zk0KplpquPIdm94Ds++EO4QRY
 8zSFvUnbDjG7G6wT3HY0o/8USnR3JkeZLn+GqFFoEprTBIdeIyds7wVqs/rFZMHmIyRUjstS9
 M5SsN6Jw2RypjuRIXuNO8MzABCeV4QOsA6/NoOcSqKay+F1s7jmTXHbbQvIJ2FRUO4BgdSZ0/
 N516JtQRJM7PyuRbcyQ69L77s7U9V+YMJqGNiHCPkNiX4WxnchR9VJhGN9UqEHOkpMNUwfsKV
 WQlMFavxgNarYwnWZQx9ZKzAvQrThdeGjcyydeXX+B8xSsmsGqrXWZLG2VZBI/A9L5WrI6Lbw
 oHRkOIzdvVkuX2NhJWCBmOVhGgNhf7Lel5rho9bIc52Pmg9bU+MQ8g79r01XnCENB2QMkEcyG
 3tui1Qv0sqwz1KN1Uz1fl9qbGXQGxauiZEOaeY5tDw2JcNM4Atdf1AePrSWksRvTOK1PwQiNm
 KsO2nzYvyBi+GUCo7uhq/sasw7anf6zQq0Nvsqz2zUv4fSBqPcui/xsL9LnsJ7snx9OoCIlzn
 FQh/nqNXA7wYcy54sh0XgSJGY+2WkGTCSJr89Jea6MFUj9nc3V2wdTjrqMnyJJMP/YPuAYS8Y
 aJMoisoyUK4iFgAIu8rijgu/ZlHq2rMVSfhPpvXOsI33ZiuO1z90TWjkeI6jje1qDJMpJnZ8T
 gCCo1+Fj2vLK2qrjjjPfEd/ky/JLc15Yh/g/CsjiHkPsrebygIau5gcZC9gosDJQOAttIiqUt
 U1eXz4GdJOLzqRbeyQ/IE4+AUpkMphKdkyr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1207080342-1562153244=:44
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, 3 Jul 2019, Johannes Schindelin wrote:

> Hi,
>
> On Tue, 2 Jul 2019, Johannes Schindelin wrote:
>
> > [...] I probably failed to mention another breakage, though...:
> >
> > not ok 54 - LC_ALL=3D'C' git grep -P -f f -i '=C3=86<NUL>[=C3=90]' a
> >
> >  expecting success:
> > 			>stderr &&
> > 			printf '=C3=86Q[=C3=90]' | q_to_nul >f &&
> > 			test_must_fail env LC_ALL=3D"C" git grep -P -f f -i a 2>stderr &&
> > 			test_i18ngrep ! 'This is only supported with -P under PCRE v2' stde=
rr
> >
> > ++ printf '=C3=86Q[=C3=90]'
> > ++ q_to_nul
> > ++ perl -pe 'y/Q/\000/'
> > ++ command /usr/bin/perl -pe 'y/Q/\000/'
> > ++ /usr/bin/perl -pe 'y/Q/\000/'
> > ++ test_must_fail env LC_ALL=3DC git grep -P -f f -i a
> > ++ case "$1" in
> > ++ _test_ok=3D
> > ++ env LC_ALL=3DC git grep -P -f f -i a
> > Binary file a matches
> > ++ exit_code=3D0
> > ++ test 0 -eq 0
> > ++ list_contains '' success
> > ++ case ",$1," in
> > ++ return 1
> > ++ echo 'test_must_fail: command succeeded: env LC_ALL=3DC git grep -P=
 -f f -i a'
> > test_must_fail: command succeeded: env LC_ALL=3DC git grep -P -f f -i =
a
> > ++ return 1
> > error: last command exited with $?=3D1
> >
> > There are three more test cases in that test script that fail similarl=
y. See
> > https://dev.azure.com/Git-for-Windows/git/_build/results?buildId=3D388=
52&view=3Dms.vss-test-web.build-test-results-tab&runId=3D1019770&resultId=
=3D101368&paneView=3Ddebug
> >
> > I ran out of time to look into this in more detail :-(
>
> I figured it out. It does not happen with your `ab/no-kwset` patch serie=
s
> in isolation, it's only when it is merged into `pu`, and the culprit is
> the bad interaction with the `js/mingw-use-utf8` branch.

Whoops, it is the `kb/windows-force-utf8` branch instead.

Ciao,
Dscho

--8323328-1207080342-1562153244=:44--
