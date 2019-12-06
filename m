Return-Path: <SRS0=yMBz=Z4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDBB5C43603
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 15:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC9F62173E
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 15:57:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="HK1CoEL5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbfLFP5P (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Dec 2019 10:57:15 -0500
Received: from mout.gmx.net ([212.227.15.15]:51291 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbfLFP5O (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Dec 2019 10:57:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1575647828;
        bh=KFEMBsfKgtJ3uLJGsChoYSb/BQQvBxK8MWpno7wVVEE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=HK1CoEL51Nw9sNOwCS0OCqa/TKNKE8JxH3sogN/HCs+n0aCiIiTJ6yemlmQB3i1XN
         1eXfcYpwcgXiMJSL0pms7gIZCZZWuNReg+8/Jswu34t/9+YyryHNDGoS450M9BgTTB
         waRcd0tO3ralQ2bAqE7S1RKWPP8WeNxhb35iJPbo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MrQIv-1i0Ze725yh-00oY0B; Fri, 06
 Dec 2019 16:57:08 +0100
Date:   Fri, 6 Dec 2019 16:56:53 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
cc:     git@vger.kernel.org
Subject: js/advise-rebase-skip, was Re: What's cooking in git.git (Dec 2019,
 #02; Thu, 5)
In-Reply-To: <xmqqzhg6xuvc.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1912061653370.31080@tvgsbejvaqbjf.bet>
References: <xmqqzhg6xuvc.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:N0/QGHi4V/iU4U9r9DRgQ6rPH93s6lvX3XOSXupgCtPQTXAKSc/
 ACTht9vstZTOTPAZxZrKWLsCn9cJUnN90THh0TuulMzLh0XVtnW+dJ3o6R5/KOnTHvrlRDh
 3bxpnQgL2E+aCoF7IRojYM5CPNmRHX+qEkVviUUeRJX5vt8szko9FBMPYyZNYeJY8aAA8kO
 Pc16TrMCkGCHPWTAtTGaA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:D7SUYmarQmc=:5WfDOgUdAIxsb+g99J6dUd
 PoRJV6cEWA/3ZEM4MPuIaYe0MW9obPj+SfC4y60gqGfqTUDL8ur4n7W9DdMA3/JY8jC0hiYRc
 Amt8er+9Xohf7tqLahlqd/8Ok0eqG/llZjgMD8Sz1vXJCzFeIBZeLrIGkNue2hrvl8aTrAOj4
 FUM8AKP2sDUMyrpO7XNJ2eOUdWgqQS+u8jd14NRroh0W9j9PdOsBsbcNMnPmgdyQjzRPQsUm4
 qsm9tecAYf86IlCLVBuAtoaek/1X48qaou5hMViDdQA5zYNRyU3n0xIPTgdBAGJ1bPcEQT3xh
 bW0pXiTgUrKV7aL14vLF7w8PTyCLZIN8uidKlz7N6CH2mvFdtQvrfgWy4+ouP+q5D0NBePR7a
 ulL9iQPLjtUP7fCE+J+fQVzyh7jyrqBdpy50noFtb8Ebfgdpw6lDYCrv7Im4N9rDjyTn3NByv
 Hb55Mh8BvmCXhvMhWdfM4XZh1a5mteKDlOT1YdOb7lteJsY3yzbwp53qM3H//tE7ssG0/rzKi
 4/K216ADDknouBwX4aK8dGs7dm6BFMrqifb8tZl6MIVqJJVedc+bi8HnJK7wl0aYouFEzH73J
 Nmec67HWCRQfVF9BbOCk+pWS5U6SMvGSB7cza/mlwPIhtpcL1SgXGByYI6JUjkB/FxQc6AD+y
 +zyXsk1wx/BRZhEywIVhqrPd7RpiBIX7GfMRw5V5nWNgkhFzZzoADH9lOH6lJHSP672MkVOeQ
 idjToZm3Kpr455bLYrvO36JnOjM6rmO8T0IIOg5q+OxYP8/ivxr8ArYtfYds117tW1DyX6jTt
 ruGT+gQGBcwozVK2k276Zi+vgtEYF/Iaf8EuirwTfiScLArmn/Rr0C1inFBE51ZCiZ3UeAb6y
 vcroXjScfXHlF+Ttj6qVApVyU+8b4iXmC2m/a64jMQPGns4hkr1Oh2LLBWEf5IiyOUVrL1y2c
 +Ux003oVMZDxDGUj4iiR7Zw/lbGVBLyVcLeOgb5dOFaDWne3WPMBgch1Dv/VLSdN+ep1WI1QE
 wsq8NMy673mYZMtfdvf0JuCYJPDWosT4rdukucpL9WLi85kM7UM65UgZOeisKW0M08S7Gx0Ci
 siRJO/u9Hm04WGxj1vBLsboKuC8Jk3hzGubtuBEUyWG6tnWnkz3UEjW5CxYX0XIzPXjy4Mt3l
 JneqEzSAmRaqNGUmdrUHBiOcjTMhHw/NeI70yh2nEI+sv4Y9Pflvx2Gd0vtgbE5gaUOtAReBe
 DMMizYYpNK/efXEI1KZOzxkwAUKm7HbFeCHPeHC3ksavP57nAOb86dCfDprQ=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 5 Dec 2019, Junio C Hamano wrote:

> * js/advise-rebase-skip (2019-10-23) 3 commits
>  - commit: give correct advice for empty commit during a rebase
>  - sequencer: export the function to get the path of `.git/rebase-merge/=
`
>  - cherry-pick: add test for `--skip` advice in `git commit`
>
>  The logic used in "git commit" to give hints and errors depending
>  on what operation was in progress learned to distinguish rebase and
>  cherry-pick better.
>
>  Kicked back to 'pu'.
>  cf. <nycvar.QRO.7.76.6.1911081508560.46@tvgsbejvaqbjf.bet>

Phillip already opened a GitGitGadget PR to replace this, and it will soon
hit the Git mailing list, I think (or it already did and I missed it):
https://github.com/gitgitgadget/git/pull/484

Feel free to drop my patches as soon as you integrate Phillips'.

Ciao,
Dscho
