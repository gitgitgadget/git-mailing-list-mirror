Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B91221F4C0
	for <e@80x24.org>; Fri, 25 Oct 2019 12:11:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504277AbfJYMLh (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Oct 2019 08:11:37 -0400
Received: from mout.gmx.net ([212.227.15.19]:39693 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2410306AbfJYMLh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Oct 2019 08:11:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572005490;
        bh=fe7muR8WTpxLWXOpEkyaHrZ/IVEgTZbzdndIEPj+CA0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=AD2Jh9CpwHEPLdV5S6MydCiEz9+85zfJQPcugblsBeZG2TLNnYPSr9NOBv7pk/p3z
         nWi0sRcCLGdNoG+4IQ2oJJMyq97Aw6ArdLP52dTCrP6tpcZD2C3UjpIZTWODx34w9g
         tVUPGA2GtqZ/J+sApnWxob/xJLs1bshGIhQHoKK8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MIMbO-1iBqwY2yxA-00EQmG; Fri, 25
 Oct 2019 14:11:30 +0200
Date:   Fri, 25 Oct 2019 14:11:13 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Subject: Re: [PATCH 0/3] commit: fix advice for empty commits during
 rebases
In-Reply-To: <xmqqr234i2q0.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1910251402190.46@tvgsbejvaqbjf.bet>
References: <pull.417.git.1571787022.gitgitgadget@gmail.com> <xmqqr234i2q0.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:JQJCzWk/etx+Q5ILhMyfNihemh0UgQMUSzjHKP3XOkxQ55WPQgd
 lFpLekKighfDPOYByThroucQaY6Dq8DBncNLIic9F+PI2/u2BnW5kWdNu+ww43ZpGcw1jtB
 troN+PCQljRrpUc36chjuR2TG0RgCGW6PbSp7x6zo97ZAQAFm0JjG83MPZ8r5p5l1Zo64wP
 /fBJAKbU9nvyErAPoCodA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Sbp+Yf8Vb+s=:jp0dfA1MgTTWICelUjmSCC
 cDW8wx2noJ5mQ+uMpry0cxh4F94hQTFQM+j4dOlCpUmA1opbbcHauf1z1LHRlJ06n5tAdi1Ge
 ftF9dM+gfq8t7eWZWj4O1JJf+R9wY1z1J8OOqjKkGju3OWBIW9eOSVt2pfJQUErVI9aHKELfv
 M3Mrpqg/bhEfoOhOeegPnkftY0IDS9sI0TKN3ErZluU0gurfw9XIGzo7NVFX6kCnyEwBiJBm4
 y1iGRMLagVdZWT1x2l3dEab3/tj9OFH0qmJDg2qWJ7VTlX7OGll/EtGRw3T5q3Tbi72+qmfMe
 1V7vOgMBKtie54B1SRKFXI/Y8AozrTLwSKb7AnsZMXNR504rBzh366+vb/BQ9LJQ0ON0AijYO
 8E03iiMH7u9LW3zQKBw7piJ9LxAPRzzG1K4EvKC+5y2Oobq6z9dU6xbV3q3uyIy85uvgBMxrL
 rTfeRJUEXsjd0eaaiMwBAwsOz+sbEIT/7GdcKp7Mn+lup71hfpHeQakzjvNhA75zLVmV2tFUz
 DOT34LolwY91+qwoo28JoL6H4Ls43AKygVl/GSzS7MKFquN/5cuSyGs1tXDrQjX0I463uFquO
 i4mUTNZAlbFs75v0zZNJnBcYExazTyuzswxOSxBEgqmp7Xrv+vC1JSwYzSzT+8V0ML0Yj6rec
 Z4ieBIIsw/+gxx+JcHHcrJJgL6gGjPJdkSlAuZqXqjjtOPXlD737uykj4S4tQEd+uOUV59+cu
 PQPy8aB1eJdBupOu9Fptqu2dkwtltUmWXIRk+4GBtlv9jid5Dlzi2u8AdgE0erzla4bLbQqUC
 29Z8eeTzCz4LBasFmXsV5zL7OmcF9HwSSdjrCrnPztb4/LmcfrDzkb3sdBbXufBRvbdH6TX3Q
 HmPPHxf1M0kWWyp7lbfYZtv7Bkf8TyhZhUupyR1I08RrwJ8fG1zj3PwKCC0lLgveabEegNoE6
 1XcDTG4elwZFSuQFpBJKeY6uJjMfU/rFkTZjY4AurOsyah/lPZ8qfNaGcy8wCZn+/PPnIxUvZ
 BAmK77obVNuCJQOi/gHOtO8QvBshvPYJ46h1OI1SMatzB3nXaTWVO+of0h0EmUsWlyD68DCWb
 ipmTRKJ7HSc4aohkzDm6RQtzjv+fY/vkqMmm1KLxV4IW9zyquNWZuvJxM42YcQ0bDWZgeR0e5
 mMyjJyn08vOMnOCbb17w6vI/sTdUXArZOx88wumtQnidjj+mXEW9XmEYO4Xog4qn8DvBFm5Ky
 XQVQzo1rNz1cMI7e2KUvnYa7BrRHk2z6yRvRcU6GUYCwJqaGAC261hi5KF5Y=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 23 Oct 2019, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > In dcb500dc16c (cherry-pick/revert: advise using --skip, 2019-07-02), =
we
> > introduced a helpful message that suggests to run git cherry-pick --sk=
ip
> > (instead of the previous message that talked about git reset) when a
> > cherry-pick failed due to an empty patch.
> >
> > However, the same message is displayed during a rebase, when the patch
> > to-be-committed is empty. In this case, git reset would also have work=
ed,
> > but git cherry-pick --skip does not work. This is a regression introdu=
ced in
> > this cycle.
> >
> > Let's be more careful here.
> >
> > Johannes Schindelin (3):
> >   cherry-pick: add test for `--skip` advice in `git commit`
> >   sequencer: export the function to get the path of `.git/rebase-merge=
/`
> >   commit: give correct advice for empty commit during a rebase
>
> Overall they looked nicely done.

Thank you!

> The last one may have started its life as "let's fix advice for
> empty", but no longer is.

Indeed. Sorry, I should have said so in the commit message...

> The old code used the sequencer_in_use boolean to tell between two
> states ("are we doing a single pick, or a range pick?"), but now we
> have another boolean rebase_in_progress, and depending on the shape
> of the if statements existing codepaths happen to have, these two
> are combined in different ways to deal with new states.  E.g. some
> places say
>
> 	if (rebase_in_progress && !sequencer_in_use)
> 		we are doing a rebase;
> 	else
> 		we are doing a cherry-pick;
>
> and some others say
>
> 	if (sequencer_in_use)
> 		we are doing a multi pick;
> 	else if (rebase_in_progress)
> 		we are doing a rebase;
> 	else
> 		we are doing a single pick;
>
> I wonder if it makes the resulting logic simpler to reason about if
> these combination of two variables are rewritten to use a single
> variable that enumerates three (or is it four, counting "we are
> doing neither a cherry-pick or a rebase"?) possible state.

That's a good idea! I'd like to postpone that until after the -rc
period, as it is not strictly necessary to fix the bug.

As the bug was introduced in this cycle, I would like to see the bug fix
in v2.24.0, though; I frequently rebase interactively, usually Git for
Windows' patch thicket on top of one of git.git's branches, which often
results in now-empty patches, and I'd like to see the correct advice ;-)

So as not to forget about introducing that `enum`, I opened a ticket at
https://github.com/gitgitgadget/git/issues/426.

Thanks,
Dscho

>
> Other than that, looked sensible.  Will queue.
>
> Thanks.
>
