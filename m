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
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F9A41F4C0
	for <e@80x24.org>; Fri, 25 Oct 2019 13:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439667AbfJYNnn (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Oct 2019 09:43:43 -0400
Received: from mout.gmx.net ([212.227.17.22]:38447 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726453AbfJYNnn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Oct 2019 09:43:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572011013;
        bh=Ql+ltTaNyJIofmx6ue7UW8OfQULIzB8s7xUJA3P2oxY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=f7zhDsljdmZ1+Fo2KjAmuGVUM2dFKpMRNrPxWRzdVt0sjYsxu+6Iz3OsxCLh3uluI
         oi7uJJ43TsDaKV+KART0eOqGO3EIPS6xq987EQI5dkED/zN1Yi7P/p0pX3Pt5UZvP2
         ywdDeVJaYGhdJrLiAWwydhGTLkqu2LfLmRwyqlmw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mz9Ux-1i1VJe0AyZ-00wI6C; Fri, 25
 Oct 2019 15:43:33 +0200
Date:   Fri, 25 Oct 2019 15:43:16 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Wong <e@80x24.org>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [RFC/WIP] range-diff: show old/new blob OIDs in comments
In-Reply-To: <20191025001254.GA29496@dcvr>
Message-ID: <nycvar.QRO.7.76.6.1910251531350.46@tvgsbejvaqbjf.bet>
References: <20191017121045.GA15364@dcvr> <nycvar.QRO.7.76.6.1910222111430.46@tvgsbejvaqbjf.bet> <20191023015629.GA15495@dcvr> <xmqq5zkghzid.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1910250014240.46@tvgsbejvaqbjf.bet> <20191025001254.GA29496@dcvr>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:t/EVjx5qx1oUgBYsyQAs7MdaypkyjZhcfKxrQZ0ayAPYBUT3pDs
 3OqGHulnaJWgbwXMQOWZkjEe/BgTRgSSAqB1nebT/GKKwSpGb907os1viQlNPpyD1MZj0V0
 5znkiErB0gI+q4iDjs6ukLkmwTmIcY2aapZZ3G4R0QW1MzagFmNpMjNjTLZr+kw4uE2/epY
 5LdIwPZBGT5/LMsCqhxmA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:n3tUUja+YHs=:CtMV4PbuySlOSfrlq1cRhq
 L1SB63GKC+8ElAmCEbZMv+Zt9qlob7APA5aZNjElnd4LFwyDWrxLKFP+W1RBiunc1fdLc3CIC
 CZvcMVSq+71ekXbpEfKHaFWggUSN34NyF6oSsTJ/sJhM23NckvN6H5RfWbVZRgddNQnSgM0ez
 K1Kot6FqAW0P34n1UuC9z6E3AaeazfOgSDe9VR4knihc14nA4XEZIqFFoqbBon4H4J8Qz7F9G
 h9L31aQtghnb++uTtrsNt/FYGMdAcDHYjs00mc4b5uj2JgD32Ehz5nIjpSNZitfGQgliPGT59
 VPIrVq+ZefRls9/7nmPA8bk5UaHbCkR/5qjY7/0GEZ99B+wzOlOUqnWYBGUQQI16bbKQAvt6d
 LwyZBtWorngHmxTp3K3OanogUoANTMoIWrJapqzsGmtwmUdj+pmyjzmLIeAFPYScJrQhATosC
 H6hnyXhoaRF6yTNHsg0fGMRGC9mjQV3te+q+Fw9ffmjf0tkfCuRLKw87+IXxvQ+ELJHdFu2tR
 f5PFoCNf9MmoDP1odBhBuF33Hi+3BDfPOBt09xFNmF63DyY95Ev/aNJjVg01uhQBFOpYY/Umk
 aQ5bYZxxvdViuNA4raXd/cX075kQ7Yo+Vla5KsG1+b/pUm6pwpSSrb9Jws09X0oOqqNXKlOhZ
 6yuzhO9rslZdycD9KMmvkGJ25fWYijddfAgvxwI700NVMP8x0/4b81fyNS7Xbhc0meCE1gBNG
 9KKjxRJ24Xn2L4OnOZJ8cKSyLUlw8i5TT/WckSO2vT/dC9BFRD6WAINMJpkP7YW+gnS7Llyd7
 WZT2EKwcIcph1pmo3df/OUAorE86gwqkWzziNJE5rvB+wHHkvyQVKhXDsN2t298dCYxPpYtRG
 W+FzrP/TpT5IHUCUyv1c8huJlY6bnMEdlS4LMckxJh8DTna9B3+ZQnDTHK1IDyfvEVdtQBBJS
 jrFO9UjZmfdpUWDOaw97R2Ed1SnF6DPPAqjzy1r7qmaQFwlW98lgof1eCeG7eTfUZsVt8Nh3H
 W2KvKVRL4XIWQkjHJ6MC0zGsSpoqlOKKJIqxkKNtgyu99BsskMfVojm4j40KUSDGxeTU2ek5o
 VQBD1nD0g5iiIvkspTs3UbBy6ADl3va2YqEFWzqODmM/wFfqHjyez5kiUN94ziDdVB5ghFGxW
 CaGuI28F32OGikwUdOLl26hCQBmFR3hr6BuwkrIcSDNvEerfZ/ji1ilkmC+shyUzkTCpfBkWi
 bQEa1X/2vWqKpjdvmi8XQQHiGtIlIei/ZfjBBcmLPR27isEhIMuojhECV4c0=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Fri, 25 Oct 2019, Eric Wong wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > On Wed, 23 Oct 2019, Junio C Hamano wrote:
> > > Eric Wong <e@80x24.org> writes:
> > > > Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > >> Instead, we will have to rely on your centralized, non-distribute=
d
> > > >> service...
> > > >
> > > > I'm curious how you came to believe that, since that's the
> > > > opposite of what public-inbox has always been intended to be.
> > >
> > > I think the (mis)perception comes from the fact that the website and
> > > the newsfeed you give are both too easy to use and directly attract
> > > end users, instead of enticing them to keep their own mirrors for
> > > offline use.
> > >
> > > Thanks for injecting dose of sanity.
> >
> > Maybe your dose of sanity can inject a statement about the case when
> > public-inbox.org/git differs from a mirror, and not in a
> > fast-forwardable way? What is the authoritative source of truth, then?
>
> Why does authoritative source of truth matter?  My
> anti-authoritarian ethos is what drew me to DVCS in the first
> place.
>
> If senders want to attest to the integrity of their messages;
> they can sign, and/or publish a copy/log of their sent messages
> on their homepage/social media/whatever.  That's up to THEM,
> not anybody else.
>
> If somebody wants to fork public-inbox.org/git and run
> public-inbox-watch from their own Maildir, they're more than
> welcome to.

I am _more_ than happy to rely on public-inbox.org/git. And I will never
kid myself about relying on a central service, is all.

> If somebody wants to write their own importers since they don't
> like the code I write, they are more than welcome to.  There's
> already mail-archive.com, marc.info, news.gmane.org (which
> public-inbox.org/git forked from) and some others.
>
> Going farther, if people want to fork entire mailing lists and
> communities, they should be able to do so.  I don't like mail
> subscriber lists being centralized on any host, either.
>
> I have never, ever asked anybody to trust me or public-inbox;
> in fact, I've stated the opposite and will continue to do so.

Well, too bad. I trust you, Eric. I do trust you and will probably
continue to trust you because I don't expect you to do anything, ever,
to break that trust. So far, you haven't disappointed me even a single
time, and we've concurrently been Git contributors for, sheesh, has it
already been almost 14 years? I have benefitted from your work greatly,
mostly via `git svn` in the olden days, and I hope that I could return
the favor every once in a while.

Without public-inbox.org/git, GitGitGadget would not be possible. My
scripts to map commits to mails and vice versa (mirrored to
https://github.com/gitgitgadget/git as `refs/notes/mail-to-commit` and
`commit-to-mail`) would remain a pipe dream of mine.

(Yes, yes, there are holes in that mapping, but even if I only have to
look up manually one out of 30 mails when I want to comment on a
specific commit, that already saves me so much time, not to mention
nerves.)

So please understand that I am deeply grateful that you came up with
these projects, in particular with public-inbox. It is a life saver. I
might not share all of your philosophy regarding centralized vs
decentralized, even so, what you did helps me multiple times every
single day.

Therefore: a heart-felt Thank You, I owe you more than one,
Dscho
