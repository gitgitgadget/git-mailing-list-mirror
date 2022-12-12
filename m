Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E3BEC00145
	for <git@archiver.kernel.org>; Mon, 12 Dec 2022 13:29:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbiLLN3s (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Dec 2022 08:29:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232286AbiLLN3q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2022 08:29:46 -0500
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057D9B21
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 05:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1670851782; bh=3Jc8wCyVfSrqfBRDWTnKVeK7CiLDpxyllUpvPd0YHqQ=;
        h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:In-Reply-To;
        b=SfCQp50T03lSDJiV8wtwWR9GOQ6rg2toFG4xKEL+/RiwO5sHeSX85Rmv7ocV7YcxB
         QQ2gp3j9XKqT6aivdIXg4Sr0HutDy89Sopp1jyNGwy9KHky3oiIX9qtSDAJi7DKK/p
         /sl9HZtDww9I4C+BQoE9U7NJfoT+pFRALA1kZC0zwd7c8OXWC62JRkbqxK5UQ+MUxD
         jhGck/CxnknP7c2w7UVazkxSp3rh0Am0Gf3U/LVYf7D/vGtXGz5x94/Oow7SAMGNql
         wxgj32Y9p1+rSrU6E9GYY5YVBcmfxGDIYxTnynmuTsnuAuWEmZo2ftYXUBcLP0oA3V
         jSxl1C/m1SATw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.151.35]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MKuKF-1pNCfL0nZF-00L53K; Mon, 12
 Dec 2022 14:29:42 +0100
Message-ID: <30f80aa4-d5c1-4fce-f1c9-710eabeaa022@web.de>
Date:   Mon, 12 Dec 2022 14:29:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: Issue with git > 2.36.1 and pre-commit hook on macOS M1
To:     Piotrek <piotrekkr@o2.pl>
References: <51d5993f-a1e0-519e-ffa9-ec5205c5e96d@o2.pl>
Content-Language: en-US
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <51d5993f-a1e0-519e-ffa9-ec5205c5e96d@o2.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TmxhXcGFVKeWubZmQ6gyw5qeqELmc5NKW3EZfAAY2GcKuh7jWq5
 W6vlFwpfJQSJ7kuOki0pN7fgRSzt+Ii6IbWZwRIboA80ZF8nGfE7WtAIuLLksXT3ANtlLKW
 hCbGhv+pOZXsxm3KCp3YpxGqjk5lTieBM4nBnjo/QNmcUBbDK07EdzPtbBcAcfNfKO66i1t
 fHLFfrjZy5QX0zWSfACWQ==
UI-OutboundReport: notjunk:1;M01:P0:OTV/rv1HriM=;WpeiJC5JOk5WY1IxutwNh+yF8kn
 KzVp9sZeP2UjOaiNaERyfsAUQM0HuianSefQTCBYgh+Qx3MPdOdKDUEqckP/Te7IK40ORPmbA
 Rpahdz2F99oVgkqx06EaCZVDRsjo9jR1Nu5qwBwUXwM8Ku9eYgbEiMCSmfcyJj/CjnSEGGDW7
 uBmKlGUMVUIcMfuraB7JlsdF6HyCwsCoMCK/pi9BmbTYhQ1drsLratiGdsdRWv2dh1/62Ns9y
 iy1JEJp/RnL+2Qf4+UxawJyK+5NIBJVg62fm4R/z5gjcePN7jQUHHmgA+8y0DUWYLiA6XMMn+
 yAWGV4xvwNf0i+/o5o9+mqkx6saUMwxtXN3M/ZTmKPPLd5AxpPk5UT90TTevJ1MRvxvEEF9XA
 l9VLzvgM8L759ng4SouiEvp7GrP2Nc0fxba6tjkxmmIyc0M3qb/402xP9t+rFXCC3P/gu/QIE
 D0qg/ZE6t4Dj0f3B95udmwqJdZqXMuADAc2uvgtVPAGQbw3iZYIDAyp0We8slx47U6cIoRQ2Y
 VUZdKQJPQUk8cN1jWKfgqeRPBzwytgDtfEQO0Q26TaB9dalDpmDbzw9QTAHVwCC3RO1RfGzmZ
 gK3I1yJ4TyQRkxTO+6ksyjsPY9Ls4Ia8LyPT0JEr2wWwGlg7H6qJoiU+lDhI4Z7wSP2wi584U
 r7WtYUXY12iaBQVDFlHW9LJzGnQQUtikeu6w2gVJ0OTQeCgTyWSgf+TTpACcwPhWPwbLoVV82
 Hx0QQ41Yy/uuq9NP7pOCgIzJaPPSeohZgzvr0zQlhmcdLOmQ33zDtwC7tEAiFmc1je6nwcXKr
 4qYY50dDpIcvkToGeAw3JTsmJ2+h4tA7hCbX73TIoGgBQJ5diQOQ/kD+urum0bui8whl9qWeE
 5T0dJvTI9A1u6ZxRw7Df/50LodPN9afNriI6IbrEjPcpjp4KrGKg93oeTVoSFHaaT0cf70GZO
 4doQCA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 11.12.22 um 22:11 schrieb Piotrek:
> Hello.
>
> On MacOS 12.6.1 with M1 chip, git >=3D2.37.0 (installed by homebrew)
> and pre-commit hook that is calling *make* target, that is calling
> *docker compose run* command, we get error:
>
> the input device is not a TTY
>
> All works file with homebrew git version 2.36.1

Bisects to a082345372 (hook API: fix v2.36.0 regression: hooks should be
connected to a TTY, 2022-06-07).

Adding "for fd in 0 1 2; do test -t $fd; printf %d $?; done; echo" to
the shell script .git/hook/pre-commit yields 100 since a082345372, i.e.
fd 1 (stdout) and fd 2 (stderr) are associated with a terminal, while
fd 0 (stdin) is not.  Before we got 111, i.e. none of the standard file
descriptors were associated with a terminal.

v2.37.0 includes a082345372.  v2.35.0 gives 100 as well, as expected, so
older versions of Git should have "docker compose" complain as well.

While "docker compose" is right in that stdin is not a TTY, it never
was.  Redirecting the output its seems to help.  So I guess it checks if
stdout is connected to a terminal and then expects stdin to be a TTY as
well.  Try appending " | cat" to the command in the pre-commit hook,
which breaks the connection for stdout.

Ren=C3=A9
