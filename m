Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C47C433ED
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 14:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 769A6613FA
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 14:12:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240162AbhD1OMr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Apr 2021 10:12:47 -0400
Received: from mout.gmx.net ([212.227.17.20]:50519 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231375AbhD1OMr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Apr 2021 10:12:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1619619117;
        bh=8rBGCQ9Q5PWlKB+JUA18vKXpCZt77VNfUTfNz9z4V2w=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=JfjuSFAbglyN2yx8pUAlH2rcYjeMKz6wOTnb9adSukJhGEXqgn69kpp04L/zMa/DF
         yi0cTswak7RxYEXBWAXBJ+bTqeriTH8Dw+ABXaJ1oYsesSP4mS9e1cW9xRtKBm5tX4
         ImTdFDnm68ZXA3XoXQo55xxKTawxtvAPcnnCzUBg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.111.181] ([89.1.213.207]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MybGX-1lNFq41QIX-00z10Y; Wed, 28
 Apr 2021 16:11:57 +0200
Date:   Wed, 28 Apr 2021 02:27:18 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Adam Dinwoodie <adam@dinwoodie.org>
cc:     RyotaK <security@ryotak.me>, Git Mailing List <git@vger.kernel.org>
Subject: Re: [RFC PATCH] cygwin: disallow backslashes in file names
In-Reply-To: <CA+kUOamYmFcKA+_on83=EbitvL4FQo9teMEbRHsQ=xo2ave1yQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2104280226530.54@tvgsbejvaqbjf.bet>
References: <20210424212117.6165-1-adam@dinwoodie.org> <nycvar.QRO.7.76.6.2104250413320.54@tvgsbejvaqbjf.bet> <CA+kUOan3vk1zJezpieRhKwZ8gsYrCxDBefkXJ1fUC61O+gb12A@mail.gmail.com> <CA+kUOamYmFcKA+_on83=EbitvL4FQo9teMEbRHsQ=xo2ave1yQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-501121260-1619569640=:54"
X-Provags-ID: V03:K1:Jgq9zSXjxBkdQuMZ4pEXBIJKpiBxagJ1Ijc6ln3ObvpNxpDKPcE
 Y0q7OKCRh241aoCZQicbMLvOpvzduCJSePIunkuU5nrr0vZTiv6G2jrZNV0lPbj9sSEQToH
 mmrZCOcPawmunItNgmr2cDOSGvVVF5HeocAt60HbUj7nX1LgDC/omkYdXx+P+8hmtFKtVSP
 eMepzVH6yUfM1s8Zj/H+A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0VAJ2eB5Nas=:/KvWipQXEyHVlNLIll6dEV
 VWglQwpH7PJal3AJmVPz3un+zDJqtJ9QlRo1SNH0Sea+YQLR9YH5HALCKbLrCvy2926+aOq3s
 YG4uLm8eSGk/wMBhtoocE68ws39Wwzhira5qlT7ZODZ307GRy9/qzYErxVOD65KxX7zfQnF14
 Rex17pgl9Pz2gTHJVpCmjSyg08enqz27JDJb8iG1Vy6Z3f46zgAQS6NnvxhbRkh7bcWC2pmd7
 YycYHQc89BzUoqwA5OUIvLjUOhz/qGuq9N3bEmwZ+reylSR+IRpaGIU532YYDCNrsgW2574Au
 uFvxnnf/kV4/KbKJBX5dffftzFgV5X9lbSSHfPTwU283T0fJ1mucC8buKqxCMYO5XLnPDMF4m
 JS7Net+NHbgdQjb0Un8sdsKXYNlKd3SKLGjCBn+LxbSsW7za+P/+jetnjOWBpY0iypKyOJEWd
 Ou7XsO7Vt5fd2Tkjz2vBXu0V6/jgopE0OPTerz2W17emcJIBU4+DC5H7a805TXw72MSfs0quO
 FfXvbKFnnAxSJe3Q2Tt4/XAvIQYCJEb9NAh7WNGeIsa/7FML8xrL7Gx7aBFs2x6v5n4vTEV6c
 Y6ibtQyfVZW729gIwnnRMvOFj357hdyaezEDTjcXJgo0AMvrzspirgLRi9PEjY1xCrbT7UaTc
 zmKI6Sr89lRMHJlaAtM58uKriXJkcCIGJQqWlZ1vHrDCq6OEn4kNeZSTAwMmngK34WzZeCEFp
 94SbOMxS+8/MliyoZ47GCOZ42STznTW3oA8m8uaYWC4xk9f9/hOMk8DbNehj3Jg4/dN1f+jrq
 0hRxiXcmeS59rtT2Evhd8sPcvfkNKtkpTXdeMIXTV2WfnIThlMxkrUZ3MJXMqZ2yRfiWO1hqc
 C5pmT+xo9JTiyVku5xSfuVLlL/MXVf4Qd0B292TTPRHS+NaV7fTTxw8TGtzZhW3B7IUmaPjlL
 2eOSM/hX/aBFA2a/N0+3H0hCOLOVR11Wcz0n24EmJV76gWyUDESYrNWSrwB93elqXQapV8y5h
 y9AhXRjQIcCEQPZNDvKdS1SvFuGEMDWHCSD3u99FmcUe/8ZTS+AP9m4dnj8rjKMRQIsEb66Wh
 iyVYkAz34XJ6OMIlzttDEcjyf9WGL/xX2j7IyzX90gQ0EX67XmisC5tRi2eeFJrCp4sYtgqru
 OX2gupc8t1/4bqdc5ANWdZJ5ISSs4Joi+lhBxXQRTU4G2B9p8QC0dCv44gXOPAZKfdloOHlJX
 3nmq74jK7t2s0ba05
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-501121260-1619569640=:54
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Adam,

On Tue, 27 Apr 2021, Adam Dinwoodie wrote:

> On Mon, 26 Apr 2021 at 20:56, Adam Dinwoodie wrote:
> >
> > On Mon, 26 Apr 2021 at 15:08, Johannes Schindelin wrote:
> > >
> > > Hi Adam,
> > >
> > > On Sat, 24 Apr 2021, Adam Dinwoodie wrote:
> > > > Notes:
> > > >     The patch to read-cache.c is the one I've applied downstream a=
s the Cygwin Git
> > > >     maintainer to resolve this vulnerability, and I've manually te=
sted that it
> > > >     resolves the vulnerability, so that's the change I'd recommend=
 anyone who needs
> > > >     to build Git on Cygwin themselves take until there's something=
 officially in
> > > >     the Git source code.
> > > >
> > > >     I'm much less convinced by my approach for the test script.  I=
 definitely think
> > > >     it's worth having a test here, but the test as written still f=
ails, as the test
> > > >     seems to be looking for the error message "directory not empty=
", but running
> > > >     the test on Cygwin produces the error "cannot create submodule=
 directory d\a".
> > > >     I'm not sure why that difference exists, and whether the corre=
ct approach would
> > > >     be to (a) ensure the error messages are consistent across plat=
forms or (b) to
> > > >     change the test to expect the appropriate error on the appropr=
iate platform.
> > >
> > > Wasn't there something in Cygwin that _allowed_ backslashes as file =
name
> > > characters? I vaguely remember that the ASCII characters forbidden b=
y
> > > Windows were mapped into some "private page".
> > >
> > > Maybe that is responsible for the difference here?
> >
> > So there is special handling of a bunch of characters like ":" that
> > are valid as parts of filenames on most *nix systems, but which aren't
> > valid on Windows, by substituting them for characters in the Unicode
> > "private use area" space. Backslash isn't one of those characters,
> > though; quoting
> > https://cygwin.com/cygwin-ug-net/using-specialnames.html (which I just
> > checked myself to be sure): "The backslash has to be exempt from this
> > conversion, because Cygwin accepts Win32 filenames including
> > backslashes as path separators on input."
> >
> > Which is not to say this special handling _isn't_ the cause of the
> > difference here, but it's not so simple as that. If nobody spots an
> > explanation I've missed, I'll start digging into the code and strace
> > to work out exactly what's causing the difference in behaviour.
>
> I've worked out what's going wrong here: the "prevent git~1 squatting
> on Windows" test is actually testing a selection of different Windows
> path oddities, which are handled differently between Git for Windows
> and Cygwin Git. The specific behaviour here is the handling of a
> directory called "d."; Git for Windows (I assume in the MSYS2 layer)
> follows the standard Windows convention of treating "d." and "d" as
> identical filenames, while Cygwin sticks to its general design
> philosophy of mostly emulating *nix systems, allowing objects with
> both filenames to exist in the same directory (and causing pain for
> most non-Cygwin applications that try to interact with them).
>
> Essentially this test is checking a bunch of different oddities about
> path handling on Windows. Some things =E2=80=93 such as handling backsla=
shes =E2=80=93
> are common to both Cygwin and MSYS2; some =E2=80=93 such as handling tra=
iling
> periods =E2=80=93 aren't. So I expect the solution here will be to have
> separate tests for (a) Git for Windows, (b) Cygwin Git, and (c) common
> behaviour.

Ah, that would explain things. Thank you so much for digging!

Ciao,
Dscho

>
> > > >     I'm also not convinced by my approach of adding a "WINDOWS" pr=
erequisite to
> > > >     test-lib.sh. I went with this as I couldn't immediately see a =
way to pass
> > > >     prerequisites on an "any" rather than "all" basis to test_expe=
ct_success, and
> > > >     this would allow us to simplify all the tests that currently h=
ave
> > > >     "!MINGW,!CYGWIN" as prerequisites, but it still feels a bit cl=
unky to me.
> > >
> > > Right, the only way I could think of it would be
> > >
> > >         test_lazy_prereq 'test_have_prereq MINGW || test_have_prereq=
 CYGWIN'
> > >
> > > Your approach looks fine to me, though.
> >
> > Grand, okay. I'll stick with that for now, then, and follow up with a
> > patch to tidy up the other prerequisites at some point in the future.
> >
> > Adam
>

--8323328-501121260-1619569640=:54--
