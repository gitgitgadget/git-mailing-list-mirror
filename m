Return-Path: <SRS0=8LOk=DA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E37E7C2D0A8
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 21:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DF15221EF
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 21:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="bUFlOiP4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgIWVXx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Sep 2020 17:23:53 -0400
Received: from mout.gmx.net ([212.227.15.15]:46349 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726632AbgIWVXx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Sep 2020 17:23:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600896230;
        bh=pYJKU8lBGu7LzJpS4//eIkBKOp1n5Y+tgqPiqLqERpI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=bUFlOiP4or1e41QP6R+f92w+7daRLeRoouVLc/4RYZLnGA9viDG1ANy0wCujCq7Tn
         LxRua0CyKvB7LojUwcfBzGh7OYSn5TPUMJVZdnYqBEXQQUQnBEwFJMw7M/kLC1Ev+P
         cKnyWg45/HZ0tmB6Pu6NWY5ye93YneLnPPE2tzcc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.89.169] ([89.1.212.22]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MO9zH-1k5ZAl2wET-00OYe5; Wed, 23
 Sep 2020 23:23:50 +0200
Date:   Wed, 23 Sep 2020 23:23:49 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "Miriam R." <mirucam@gmail.com>
cc:     git <git@vger.kernel.org>
Subject: Re: [PATCH v7 00/13] Finish converting git bisect to C part 2
In-Reply-To: <nycvar.QRO.7.76.6.2009231647370.5061@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.2009232316570.5061@tvgsbejvaqbjf.bet>
References: <20200831105043.97665-1-mirucam@gmail.com> <nycvar.QRO.7.76.6.2009031403510.56@tvgsbejvaqbjf.bet> <CAN7CjDDVp_i7dhpbAq5zrGW69nE6+SfivJQ-dembmu+WyqKiQQ@mail.gmail.com> <nycvar.QRO.7.76.6.2009231647370.5061@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:fTbSANdBbmXj9mvLrsDCxuUZWFvtj7vDDVhi8sw50Xc65aGgmlD
 sKhkDGn0bfOKJvCROYNcT2kl4Dux68VT8bRmGjl+Yu2+y4GJNVF0vBY2dAwk0oBCOSPI44D
 Ml0+pcAlQVfl/own6wrUNSEENgWgUHe/sIT06AOPZRaguJKEanSRFts6lg/k9Xf4THaTkN0
 xk86CiRE0pD6dkzyKwMiA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uqdBSpWMkQs=:KOEWh5QTOQ2OEMooYsie96
 wjtQ6pxjDcc+UDMsiLfbU8vdXNuumBq3zxjTmZPI5y/Bbyj5+jCsfEblh0jerQpkeLwpkW40o
 Ot4fLUGuBIZvr9HP9PWZER0LZt5vHVujeMj675NtYs+0d00GzaN7tYeD9isdFWaojJgM1CE5w
 mWINfcJM/ekjpWHCSKZ0Zd8dwgwanIGGyZQCDStfrKkQZZFzwycP6eQ2GhcVzfX0Uw1rMVX3W
 u6oFwGeBweKQtBCvzMfy8bCG+AtmUqeAbm3eySTGoYgEZ5pbYgZb5Z57pm2I1E6mF/Rt2yUDQ
 Z/n5/ggmSb2uq8w4AvOmbHJAfWfzkvryVTu+u2lrcODxhdWUwuFBtcBmKdbNAQ965JC1WK0Lz
 copgnRpDkrBPJSgPZDogtIiaLVvYqvDX94GxJBA1W6GcCT1WgVOFUWbEKexNtINcp0kLZkX1j
 82ifs8m9GLZJ8iWfUQJKut38FAgDKi8RWcm306Zkz4TK4/BfwaRMylADgEN7nX37ta5QrawIf
 C7StNvHgBeBDhnKHGJU+7K1mOWbCDHSOyXsvFUNubTtKZBdUxZuN07wVH0lsAJXeMIfpTEdqU
 /p05jlTGaJO8jLiVZVrkNg1u0+AoupfDDIBNPnv7M2aTSHb5rIXLuoa59bTCHNdrZNZFQot6x
 Wu1JuADSeP7wtviHp79D6jeZE14ieSCFu0l712RWpC9tzhuXJ5otWHvvNXrlEPaCG0E5w6OEn
 vo2IFd+XI03fhAmhusVBbmBRlZ81ytEWjSsuMGMSPHbBdIBZMKttcMQaLgSNxSaOz7kLoVirw
 8J2Y5JkN1VLGFiuSITKOtCHL2FZrd5tJh2mYAIT47+mHXHaVEiIkzvBbJX5ztJVFWWyG52vup
 H44J6l6u3ZROQMf//ls6EJo95DqXUQ4I9iNu3R8T6C+lPLAEVh3OR9yt//BVTzNYmNcB6euFE
 uUTlvttK3Vla5FOtqLH68AUemeZKvznPpHGaqDityNdvIAOA31ae+nV0yVRK1IsgVcddICd6i
 fPUpubRJUBU/olmGg3IQJIEwHpJlY+fkjdMcSzpmiXCTuxL3fuLIGmSvV7rlUYXism15YKh3z
 03PycfD1E6f83ck5UpJrtFhVv/J4TUg+40/i8IUVt2X46Jc5p6SMUK5zAyJODounvwdLEbRQP
 t7Ko/rd5WyDgDHHbiLEFEDJ52WV3MrikShbuuuF8sYVIRc2VQer8bN98st7m5rgEKSnHwvgHK
 d+QsKxRWF4SPbrwQ5zRVNOM/yO3tR2G7o3hf4bA==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Miriam,

On Wed, 23 Sep 2020, Johannes Schindelin wrote:

> On Wed, 23 Sep 2020, Miriam R. wrote:
>
> > Applying some of your suggestions related to removing some 'eval' in
> > git-bisect shell script, a bug has appeared. It seems it is related to
> > a previous code merged before my internship.
>
> Now you got me curious: what bug did you see?

I found your fork and ran the test, and this is the first symptom:

=2D- snip --
[...]
++ git bisect skip
Bisecting: 1 revision left to test after this (roughly 1 step)
[32a594a3fdac2d57cf6d02987e30eec68511498c] Add <4: Ciao for now> into <hel=
lo>.
++ git bisect good
++ grep '3082e11d3a0f2edca194c8ce1eb802256e38e75e is the first bad commit'=
 my_bisect_log.txt
3082e11d3a0f2edca194c8ce1eb802256e38e75e is the first bad commit
++ git bisect log
++ git bisect reset
Previous HEAD position was 32a594a Add <4: Ciao for now> into <hello>.
Switched to branch 'other'
ok 22 - bisect skip: add line and then a new test

expecting success of 6030.23 'bisect skip and bisect replay':
        git bisect replay log_to_replay.txt > my_bisect_log.txt &&
        grep "$HASH5 is the first bad commit" my_bisect_log.txt &&
        git bisect reset

++ git bisect replay log_to_replay.txt
error: update_ref failed for ref 'refs/bisect/bad': cannot update ref 'ref=
s/bisect/bad': trying to write ref 'refs/bisect/bad' with nonexistent obje=
ct 10006d020000000068986d020000000054f65f00
error: last command exited with $?=3D1
not ok 23 - bisect skip and bisect replay
#
#               git bisect replay log_to_replay.txt > my_bisect_log.txt &&
#               grep "$HASH5 is the first bad commit" my_bisect_log.txt &&
#               git bisect reset
=2D- snap --

So I dug a little bit further (and applied Christian's patch in the
meantime), and it turns out that the `eval` has nothing to do with what I
originally thought it would be required for: I thought that it wanted to
prevent `exit` calls from actually exiting the script.

Instead, those `eval` calls are required because the arguments are
provided in quoted form. For example, during the execution of t6030.68,
the `eval` would expand the call

	eval "git bisect--helper --bisect-start $rev $tail"

to

	git bisect--helper --bisect-start '--term-old' 'term2' '--term-new' 'term=
1'

Therefore, the `eval` really needs to stay in place (also the other `eval`
I had originally suggested to remove, for the same reason).

I would still recommend appending `|| exit`, even if it just so happens
that we will eventually abort when the `bisect--helper` command failed
anyway, because the next command will then fail, and abort. But it's
cleaner to abort already when this invocation failed rather than relying
on that side effect.

Ciao,
Dscho

