Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC2CC433B4
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 22:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8DF261008
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 22:29:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232532AbhCaW3X (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 18:29:23 -0400
Received: from mout.gmx.net ([212.227.17.21]:36779 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230380AbhCaW3P (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 18:29:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1617229745;
        bh=zSafgBnq9WChy+9zJG79FsFXjz+gQQrbsStwaO3zRdk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=EsdAH3RKjycGY7BQCZZxfW9Xxd8CvJhcBHb5kXFgy5YQF/WQKC4HP0jWHUPfhjNtK
         dpRN101k2OCh31mhS37paHo1JAKacN5R9qzMO9MIHByBjSGLHSSr/IRRtVUSclF8HA
         IR0zivb4o2dboiiYUm5Xvg0e/AvVyZfFBPunChoA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.17.1.223] ([213.196.212.198]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MhD6g-1m5iiJ0pz0-00eNoS; Thu, 01
 Apr 2021 00:29:05 +0200
Date:   Thu, 1 Apr 2021 00:29:03 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 4/5] Makefile: add the ".DELETE_ON_ERROR" flag
In-Reply-To: <xmqq35wb891a.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2104010026440.54@tvgsbejvaqbjf.bet>
References: <20210307132001.7485-1-avarab@gmail.com> <cover-0.6-00000000000-20210329T161723Z-avarab@gmail.com> <patch-4.6-2ff6359c273-20210329T161723Z-avarab@gmail.com> <xmqqblb1kd47.fsf@gitster.g> <87a6qlmt9f.fsf@evledraar.gmail.com> <YGM/i+k4r0q8FKg2@coredump.intra.peff.net>
 <xmqqft0cebft.fsf@gitster.g> <YGQdpkHAcFR/zNOx@coredump.intra.peff.net> <xmqq35wb891a.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:eiwuhjCxCnSbGo2ZxHmy9pSSjeP128RRpP5MSvVw1/duGGB0QCu
 5QpC0RV7ipRwgpqmdZrAvDvWC1mlyneqIqbqfchz7KTnqqLr3y8LqRvDAYWNccnCP7U6Zrc
 Oh4LDW1bF47G68reRPyeyGKRxlMkxBVvFhp041IFpxOHv6H68TX8dfNomQiFlkMZo6vl1WG
 Uo1yj6DAK4kl0PaextEVw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zoZ5OGi8A7c=:npDnaniqA+hbWpdqlmCfXd
 cEAbIJ9R7zZWJgZFNe+AvjkQCPfqeUAfv6WPdxbejoFnlcQV+wx2SvHtqjk7XXXQb93D+KIEn
 Rw5FMftFInzFN50W+UKLdFnx28wK4yWxcxhXvJ18NpbGAeAFdvKbxE2rP1CC8Aw8cmKrqJlef
 V0O1JwjYWQvgHTPRUzlV5VZemUYXGZO+ANfr82qD+qOmDeV3VnnpLUTAsWX8Dv7EK5932PeGR
 8M6bv8gKoQkpjfC3S6pZP1NApu2o8d4U3zkb7soWBF3/1dFfrEdlG+D/W5QeIuVc0r2V+WKOi
 13syl0rKHMDIbcixgwGaI9GUwgmfnpAbdfL+EfTfBAN8n6BYa5r9skboRigIqhI8j5lYCulwC
 /QA9slB7WSLXXWW6H4jG3pu7y91+Zm5qyzNy/PP/MmII7q2ACjouB+een/BS93Ip/GnkEr4n4
 NB/oxOa236f2WBBMibnT/iZjWdPPZGmeCOh9rrAYRnL8unIb+ulkappN2L9nCPzJCmfuFsUur
 qYBXWfuLgKWKQ+xOZsFyoDdvVUZmZ57wcK7Lg5TYh13iphCGxxYuvrT8DFX8d58FiTOtZ5UV1
 6usdYl3Gf9nfSVDUkTl+lolCvlxjpkL1AVR1pxaDahGQFWjIhx2Zt/wJfXQAS+qhhV0yzlOwt
 +5oD7sjSDcAKhlxoZD++aUBStNEhUYhQClWAMJgMmzjIYg2cKIoIa7Scl9D4cXGa73ExU0gjW
 Vt8r+h2LGQ2BR+/F1CBPl2V1Zcm+wJANy4iiylzGyk5HM0DCFvscHqUo6On/kZ6B4xuse2onI
 +Pcvel0S8d+Eows7EiiZ9ZKN4uCrQ4t9ak+lbBfAARERDBq0FdHbUo43FCELh7yZaTpud/UIw
 ktlEzachUzsDXOUMYGbH2oN4Iia156w2kBzjFF+VU0p5q+T4IhHCmZlJc1nNpuXREML3pwpPl
 xvBo+zna/EaVRqRJFrEzzoU8tZbHX0Z++CBxpKPACKPQM4kD5bBSD1364t2B4zyk25zDz44IY
 +MF9XN7TzJGj/eEbEMHC6JaUGWl7Tjji34nD3FSqTyk4nRQ2VlriiKWwXx69HvzqQO3T8whgp
 NYDLeAUpNdzRVEmdlSIy36YZY50DlBU/1C8Bd3BDnnfEPHtx1LX+GXxPTah2Osw/rJtsY8K/W
 lYwgM9Ja8QcILIBbs9XW4NkXMaHAUbBt9tBvmr2ZaRgdJuCbT07L0aaa0I/MsNuTr+S9K2VMK
 UBcDLEyrqMac+BIQp
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, 31 Mar 2021, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
>
> > I don't know how paranoid we want to be about this, especially the
> > latter. My general inclination is to prefer "commit" systems as more
> > robust, but it is just a Makefile.
>
> ;-)
>
> As an old timer, I've written "gen >$@+ && mv $@+ $@" all the time
> myself, but it is ugly and felt a bit too conservative.  I do not
> think it is wise to overnight remove all the existing "generate in
> temporary, move to the final" patterns and delegate $(MAKE) to take
> care of failed generator with this mechanism, but I actually would
> feel it probably gives us a cleaner Makefile in the longer term.  At
> least "bugs in $(MAKE)" won't be our sole problem (i.e. all other
> projects that rely on the feature would share the incentives to see
> them fixed).

Another point in favor of removing that hack is this: `+` is not a valid
character in Windows' filenames. It just so _happens_ that Cygwin (and
therefore the MSYS2 Bash/`make` we use to compile Git for Windows)
_pretends_ that it is a valid filename character, but regular Win32
programs cannot read/write such files, and it would preclude Git from
being compiled with more native versions of a POSIX shell or `make`.

Ciao,
Dscho
