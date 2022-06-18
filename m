Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C65C43334
	for <git@archiver.kernel.org>; Sat, 18 Jun 2022 22:04:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbiFRWEe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Jun 2022 18:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiFRWEc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Jun 2022 18:04:32 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60093D91
        for <git@vger.kernel.org>; Sat, 18 Jun 2022 15:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655589854;
        bh=ag3Bi0hR0ZjrCAZwIaWJTC/UERXadPME2ObjYYR9sfE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=W/0ONqBKtZjIqqOUKY3RaMiT0Mfe0RX0sd/APUf16xpPZkmTsbNcTa6XdxAPOH4/n
         jl1VJ9jwwk4DuEPbdQbbN7yi6y8bw64hrtF3uTkAZ0dQ5XBhv/wPvbgVq9Ysuj6Cpx
         S88DooRVV077LGMNoOgybOuPHor4iI4fewenCoVg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.60.234] ([89.1.215.185]) by mail.gmx.net (mrgmx104
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Msq24-1niwhp40OO-00tCs5; Sun, 19
 Jun 2022 00:04:14 +0200
Date:   Sun, 19 Jun 2022 00:04:08 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Tao Klerks <tao@klerks.biz>, git <git@vger.kernel.org>
Subject: Re: Plumbing for mapping from a remote tracking ref to the remote
 ref?
In-Reply-To: <xmqqilp1znn1.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2206182358350.349@tvgsbejvaqbjf.bet>
References: <CAPMMpogUxq59zj+=7UDiURYbydAwvymOqhEWaheT9fkU8HaP4Q@mail.gmail.com> <xmqqilp1znn1.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:+pT8DYS6mckN9vqbO3p26emXt6PR+HI76AVMaqSKLNKQDFWO7JD
 xYRyJnHVmiXFE8KVEKfgEN8VGVnYg5IZa/nRwcJXcSKF4PTgsEShoREkg/GXkgic2S/7QBw
 x7BWeifKKnSBAjnBpc09WrvbSOk0vYwm6Yf1RhNtMdR4Nom+DW1dDfMdy1zt3GunYF+4IZC
 lHaM7gxeazo109wHp5tkQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ADzL8SQqJ5c=:Vc8z9f7H6I1WTlHyctgI30
 96cvzJ9/DZftkjXA7GImi6/j/xuM3bUomOcov+/3itm5PmTHaGdEFkgK0e5ZEIZ/IBvw54RO+
 OwtfWOvROo5XtO0IP4yYjxN0i2n58JpCpp7a/9PD9Hlf3oIYpC2Ptsf8lce5pBvIHNTn3G6X7
 lpzYRkYYQc37B5bOjLCA3r5o2I3tC6Dw+eczdudvKoFRPRYX6CWQb2u5w9pXWHwSlPnpNeUK0
 4jpiV0md8tzxnHQAVqCiD8y2j1uNyMrb4641miOt/FzKuELg69oOc3HjsVIgWMqM8BP+UDwKB
 1Ygun+wYClTiTlCRn0unWbGGFzAUqGguH5eyPjCHqtC5uZlaf98eJSpAmUv5TnWuM3mTVCF5b
 fLRV7ShZ3suclT3BjLSOILU1dyQcqZbf9VfzY0w615WdZQIXpA9wphXDMEYKm5tLXOsTL9nhV
 iik55+Vcwx0P5zFV3tF7QuULsMQUyHxUTWU3urI/SZ4TITiSvtcqN+Vfa0paRpkXdna8mU434
 xjwCVdEo7n/8Pkikt69/+H/et/7tA3AieC07wWsWdYiLsu638Tq8WxhmtbPy66cjh1DdbDUxV
 Xyd07C04ZmKlyPxU81Dkiit9gE9ecN8Lt7NAvo/CwmczmGJGO9FUMOiaqKP1Nm8NMF6tsac0u
 caq308Ubx+v2H+pAn2gV+ZcLXJYh5BYO4/6JXgOo0fo/clbhmKoWuFSmRT1HxF6rqKjfO4uFx
 momznaaRpXfuRWbY4lLemJ9TkV8bKszXtImAo+6AUuuteNoMsAUWb7CZrmL5QmZb5yM2maxtM
 jnzUkiWlG4wVLAY1H9YPEi6nuJUxgOUOT0KHhcQgrKtqvfCCTUEjdWgP4MauxdPfjOG9C6FM+
 GlMvXoJs53XrghJa9bee2aQH/NIXwpBZfVuZkjM0cmvLCNAIMoydSlfWAU+ac4mM7AnLYniY7
 1jAFK+MPhRjU0zCd/AOciIOihW8TM3/RLKd91wPZfRCM/MYmEbtDf878s5TrHW+920JamO/O/
 Xt0FyGL5SMvdBNR+hN4zJb83QtHOhjGuhSY8pLIH7D+sni9RxXgfkOmwPiL4khk5reB6I2zSR
 xpE8BRWhHweT7sp3ggkew/phrM3sUx/m9VlFABB8++C7bVLO3U3VbD/jQ==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 15 Jun 2022, Junio C Hamano wrote:

> Tao Klerks <tao@klerks.biz> writes:
>
> > Given the following configured fetch refspec for a remote:
> >
> > [remote "origin"]
> >         url =3D git@someserver:somerepo.git
> >         fetch =3D +refs/heads/*:refs/remotes/somepath/*
> >
> > And given a ref of the form "refs/remotes/somepath/branch_A",
> >
> > I'm wondering whether there is any plumbing that would be able to tell
> > me what to put in a "fetch" command, to get
> > "refs/remotes/somepath/branch_A" fetched - in other words, is there
> > any plumbing that can use the configured fetch refspecs to map
> > "refs/remotes/somepath/branch_A" to "refs/heads/branch_A" for me, so
> > that I can then do "git fetch origin refs/heads/branch_A".
>
> I am fairly certain that I never have written one myself ;-)

I looked for something like that, but did not find it. We seem to have the
functions `apply_refspecs()`, `query_refspecs()` and
`remote_find_tracking()` that could be used to that end, but I do not see
any of them being used in plumbing that would expose the ref mapping in
the desired way.

> I wonder how the end-user experience should look like.
>
> 	$ git refmap refs/remotes/somepath/branch-A
> 	origin refs/heads/branch-A
>
> 	$ git refmap refs/remotes/somepath/{branch-A,branch-B}
> 	origin refs/heads/branch-A
> 	origin refs/heads/branch-B
>
> IOW, you give name(s) of remote-tracking branches and then you get
> the remote and their ref for these?

Modulo introducing a new top-level command (a subcommand of `git remote`
would make much more sense and make the feature eminently more
discoverable), and modulo allowing patterns in the ref to match, I agree.

> I do not oppose to such a command existing, but I do not know what
> the right answer should be for a case like this:
>
> 	[remote "origin"]
> 		url =3D ... the official project repository ...
> 		fetch =3D +refs/heads/*:refs/remotes/upstream/*
>
> 	[remote "mirror"]
> 		url =3D ... a local mirror you'd use regularly ...
> 		fetch =3D +refs/heads/*:refs/remotes/upstream/*
>
> In order to support such a "more than one can update the same" case
> sensibly, the output may have to repeat the input, e.g.
>
> 	$ git refmap refs/remotes/upstream/main
> 	refs/remotes/upstream/main	origin refs/heads/main
> 	refs/remotes/upstream/main	mirror refs/heads/main
>
> perhaps?

Sounds like a good plan to me.

Ciao,
Dscho
