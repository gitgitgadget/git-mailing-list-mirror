Return-Path: <SRS0=kv1d=5J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C4BC43331
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 19:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96DA620753
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 19:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="bFB0Xeka"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbgCXTzK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Mar 2020 15:55:10 -0400
Received: from mout.gmx.net ([212.227.17.22]:34795 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725866AbgCXTzK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Mar 2020 15:55:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1585079704;
        bh=D/7ZbwVzuEo4VShHXZMLgKD5M/uphXujDgF6Q8RnSOM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=bFB0XekaJGGFcIzIJM6RAPFJM6c877oxNByk+ztBbvuw/kWgrJEeAuwW54GPzoBkg
         H9jp5EGhb+UJh5Y33SUhaUdwC4lxCPg0UyR8surCW58SxIdRpAWSd9vjdFCo3sRf1L
         mBNx3HfyHJcTKDluXbSaQwuskt8TMe/DZOB6tkzg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([213.196.213.32]) by mail.gmx.com
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MvK0X-1jYlzt1is5-00rHhA; Tue, 24 Mar 2020 20:55:04 +0100
Date:   Tue, 24 Mar 2020 20:55:04 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/2] tests(gpg): allow the gpg-agent to start on
 Windows
In-Reply-To: <xmqqd09355h7.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2003242043050.46@tvgsbejvaqbjf.bet>
References: <pull.728.git.git.1584968990.gitgitgadget@gmail.com> <287a21f1033b2a74420029c529ad4db956051a85.1584968990.git.gitgitgadget@gmail.com> <xmqqd09355h7.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:av9SJAboQPGOiieNdqNykYMekky/+NXvxetGQ23cfrHblIIVeRf
 ODaDWrdgsVX7kq1hHptSVBqGjzb1jgNq+QKu8Dhl1LXBmcnfvTFpFTFzkfZaudgRmsLX4WQ
 ZVaD7vt00EJLTzxPIv3eX+s/wNGzctWX+SrriBuxaDYTW+h0dQEEU1SDXLcGXPkEzoq/6bJ
 Laeh9u/z71z9YVyCWf/5g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jVVTMYEgbQk=:2kAJW8rSgUErvzJkqG9Mof
 95Tla7ryGbqLKChKBfXSJ39N/MqrDd/6KuOhEjUIhoykE2136qcJf1WnDjaxkVUC0+iCjHuLG
 DGMX4KTFSYCBLV5qvD/XjlGnamq7oP8GmeR/DRThqPRAHsiKwL/0x+tpZa3VgounHqSNrPEpv
 PjqfvYaYmaLxUvyfkUSkaAK8dQ/Bwu3BUA6O191rzlciRg2DO29u6YkiKee/DgnaXdG1PBLM8
 24lY7PVte/WJer6agJ2mbUeMeaOJBnSqnNZTJYU4JFbMc5Fur4YhQ8SpqNQaKnFb7PgRCw1KG
 Nnrpfigm9mYGOoXmegUtXH5Hc4QuKsunJ47dEIPcBGJlTBuYHy4egjm7uxAREXgergDZo73oK
 rbhiqex8qwEJJo4W7ZUKD+LCeBZ7IDu1SPMi2p3XSpCBpGtMz9uACIjrkHLDgje0OBG7Y91mz
 eZqqYkrCu16Y+VpsQGPFAri5kUaWYeB8XZAxFQY/teI7FZM4HYqAacUZBafAdx/r2Who8ftjW
 SUwlKofbGhsPMWDiZZe5NvcOfFnF+bQC7vrEKQTbRjsBdd8cJZYj+a5wlG1Ov6u5fXuazXdq7
 MW5JF4rSdArXkwLZNFGxlS+taQe7VMld9iWq7HGPSeCnTPVNTTcYzDXS0hhmbgIKt/zJX4hXD
 LB43s4pl4v0LzoXL7WiIr3LshmpK2KKZxfUpa1YTeKvPKZZyfKrWHC7ePoFVSt6GhSFMsS/TB
 tebW9o+nxSYEYeSAdHd0Hb0aRMK4dcSl1uhK89fjPPb/C8OyD3CC5eIC6Eyl9UfgoMjmg+ErA
 od/lv13RW7HDAY07huwWHR5j3Zw1Civ+uIaIxCwIgoeIVzmPfuQcM9rwcpuEmxhJi917Fcoqm
 0FwRKMfHOdw945JmCuoXu/IjueBqeStgwybfir964oP5JgE4M2SyjGpYp5gmB0X/zMqSCC51m
 zmQKPJMmVsIf5VzqefK5zTKJuQGt8qDN37huJlHgTQ9a23Y9LESfSlNBv1NA5F0RXcExa5bvQ
 lMBIBri5HfP0GYk3K5li4cBahz5b2WGL4QImnYx0iHshuQe2jW3I9Hj5lgC647OvaC47Xi2hS
 omZvDNXYxLt1SxkChxy05/BJhiWFYS6eHZRSahYFM1QtfPPk4nR9UdoFb9ohjxbqEyXIAoJru
 lTpWqg8GHtMzh5XeIxiuk7X9QQxlvyJ9SccsRBI5eF9X/H2N3CTIUwwz/BElWhwKk8tUjtsgR
 Vgara/T5KAasFwrWB
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 23 Mar 2020, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > In Git for Windows' SDK, we use the MSYS2 version of OpenSSH, meaning
> > that the `gpg-agent` will fail horribly when being passed a `--homedir=
`
> > that contains colons.
> >
> > Previously, we did pass the Windows version of the absolute path,
> > though, which starts in the drive letter followed by, you guessed it, =
a
> > colon.
> >
> > Let's use the same trick found elsewhere in our test suite where `$PWD=
`
> > is used to refer to the pseudo-Unix path (which works only within the
> > MSYS2 Bash/OpenSSH/Perl/etc, as opposed to `$(pwd)` which refers to th=
e
> > Windows path that `git.exe` understands, too).
>
> Makes sense.
>
> Do we have a short/concise instruction, e.g. "You should use $(pwd)
> in most cases, but for such and such purposes use $PWD instead", in
> t/README for test writers, who are not familiar with the distinction
> between $(pwd) and $PWD, to help them decide which one to use in
> what situation?  I see this kind of fix-ups from time to time, and
> am wondering if there is a way to reduce the need for you or J6t to
> spot and fix the new ones.

I fear that this distinction really is lost on anybody who does not have
to deal with MSYS2 on Windows.

It is subtle enough a distinction, too: whenever Bash or Perl is
concerned, we _might_ run into this issue. I say _might_ because _some_
scripts actually handle Windows paths correctly, but others don't (testing
for absolute paths by looking for a slash at the beginning would be an
example, and it gets really hairy when you slap Windows paths at the end
of `PATH`, separated by, you guessed it, a colon).

It gets even worse: you might think that you have to use `$(pwd)` when
passing the path to `git.exe` (because it is a non-MSYS2 program). But you
don't, in many cases. For example, when you call

	git config my.pwd "$PWD"

it totally works (because the MSYS2 runtime on top of which Bash runs will
convert the parameters that are passed to a non-MSYS2 program when they
look like paths).

The problem solved by _this here_ patch is the opposite, of course: we are
passing a Windows path (`$(pwd)` implicitly calls `$(pwd -W)` in our test
suite on Windows) to an _MSYS2_ program: `gpg.exe`. And how would
contributors whose main development platform isn't Windows be able to
guess that `gpg.exe` is an MSYS2 program as opposed to, say, `tclsh.exe`
which is a non-MSYS2 program? They wouldn't.

In short: I am convinced that this is a subtlety in our test suite that we
cannot reasonably expect any contributors other than Windows-based ones to
get right, and I am fairly certain that we will just have to keep
monitoring the CI/PR builds for similar issues and then help the
contributors by suggesting the appropriate fixes.

Ciao,
Dscho

> Thanks.
>
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  t/lib-gpg.sh | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
> > index 8d28652b729..11b83b8c24a 100755
> > --- a/t/lib-gpg.sh
> > +++ b/t/lib-gpg.sh
> > @@ -29,7 +29,7 @@ then
> >  		#		> lib-gpg/ownertrust
> >  		mkdir ./gpghome &&
> >  		chmod 0700 ./gpghome &&
> > -		GNUPGHOME=3D"$(pwd)/gpghome" &&
> > +		GNUPGHOME=3D"$PWD/gpghome" &&
> >  		export GNUPGHOME &&
> >  		(gpgconf --kill gpg-agent >/dev/null 2>&1 || : ) &&
> >  		gpg --homedir "${GNUPGHOME}" 2>/dev/null --import \
>
