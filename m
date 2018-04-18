Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 860481F404
	for <e@80x24.org>; Wed, 18 Apr 2018 21:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752166AbeDRVQs (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Apr 2018 17:16:48 -0400
Received: from mout.gmx.net ([212.227.15.18]:53509 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751256AbeDRVQr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Apr 2018 17:16:47 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M0PdN-1eIs7E0ZY5-00uci3; Wed, 18
 Apr 2018 23:16:21 +0200
Date:   Wed, 18 Apr 2018 23:16:03 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Kim Gybels <kgybels@infogroep.be>
cc:     "Randall S. Becker" <rsbecker@nexbridge.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] daemon: use timeout for uninterruptible poll
In-Reply-To: <20180415170859.GA30197@infogroep.be>
Message-ID: <nycvar.QRO.7.76.6.1804182307450.4241@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180412210757.7792-1-kgybels@infogroep.be> <20180412210757.7792-2-kgybels@infogroep.be> <nycvar.QRO.7.76.6.1804131433250.65@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <20180415170859.GA30197@infogroep.be>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:2d7bCReXi27ZiudEd5QtQqnC3xkI9iqtATmlijGq+bePClKSqID
 Jj4WUS6et/nTCOJMbIczSW/MxAOUCNL8fTgVb37KnGWdH3P5hyf7cYgLV/ol4T5lcr61ss8
 FoH0hJMdSybBCaiVLWpkh0Esi6jxHyUL2diF1oCM/BSZjVVKAm9rAh7fxOeHqqK1g0vBIZy
 lvynllG5ww9C1IuvsBfeQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:X2WahGKOXs0=:hldVsIGMo0tnLEUoau4+jY
 sU4rnOBEZdjK/HWbKBEXXpcOrtMC79+6Ajsl7st2ZGW39EQR4LQc+it7shK2zyScK94SJvZ1l
 2Qoc9CjeiyR3ZklIDt8/wV+/TEFYsI/X2i1u7oK0gr+JOmOZCLwPuFH/oh4NqjBYbFu9I5jpl
 J6u/0miIqrtPqtW7C3BeY89iCoOx2HiCxXOuLgDtHRcGS7IPrDnKI0bH/E8ciOtDfsifF+SbS
 I3eZPEHiQ5PbZmGKIvBKhTS13NrUkSq5DLow65tNfI4rsReTwRdlak+3lMfTV967Woo7+jL1U
 rZx7OD2VoJgOdPdlAzvxzvais6O98u5rnWNvs/d83xIg+vvNqKnplmDBNZTn1CtyAVkBZ2Yrj
 pN+Yyg8DgX9XaXVWjywDpcVhD316b5nyYt6VYwllya51nq0pBxqD7Wu3WUBrQeqZqKkgJ6i1E
 rOpOqjv9s+xvKNzQPdgCwxlj1swa39XQQiTxqEJvtfcNN1Mnle1qx22mKHaLLbp7Kh0XvZiZb
 5ATSPJqWywtAUs0yBbTLvxcY9P9J0iqYiMHfQ1sZpRS6LLk+aA/FrHkIEL9IAHw3Et7AyDEda
 wD7AJHs8OwlGc7Z2xFgLt5Xc9wPEzS02w7lI77aZMAJlQwjdZg9jjBlcpjdtvSpIiU5pYYolS
 R/X0RNW/cQTo4AYUAMi072R1vT1Fr5j0qwx2+iHkpMpWj+Ya6GRHHEYTusVJjGdgLTEx5AlGW
 djIzumtY8/SYMzGorWMGQB1RP4EWleCKrremfMrBNejvBTQ6/+b+9LhTvNquQm9Qhebvw6bIP
 lVOdfu59n6H0eWJRo0TVousL9JgHiQtMlm5S+Dj36IfGy3W4v0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Kim,

On Sun, 15 Apr 2018, Kim Gybels wrote:

> On (13/04/18 14:36), Johannes Schindelin wrote:
> > > The poll provided in compat/poll.c is not interrupted by receiving
> > > SIGCHLD. Use a timeout for cleaning up dead children in a timely
> > > manner.
> > 
> > Maybe say "When using this poll emulation, use a timeout ..."?
> 
> I will rewrite the commit message when I reroll the patch. Calling the
> poll "uninterruptible" might be wrong as well, although the poll
> doesn't return with EINTR when a child process terminates, it might
> still be interruptible in other ways. On a related note, the handler
> for SIGCHLD is simply not called in Git-for-Windows' daemon.

Right. There is no signal infrastructure on Windows that is an exact
equivalent of what Junio desires.

> > > @@ -1161,8 +1162,13 @@ static int service_loop(struct socketlist *socklist)
> > >  		int i;
> > >  
> > >  		check_dead_children();
> > > -
> > > -		if (poll(pfd, socklist->nr, -1) < 0) {
> > > +#ifdef NO_POLL
> > > +		poll_timeout = live_children ? 100 : -1;
> > > +#endif
> > > +		int ret = poll(pfd, socklist->nr, poll_timeout);
> > > +		if  (ret == 0) {
> > > +			continue;
> > > +		} else if (ret < 0) {
> > 
> > I would find it a bit easier on the eyes if this did not use curlies, and
> > dropped the unnecessary `else` (`continue` will take care of that):
> > 
> > 		if (!ret)
> > 			continue;
> > 		if (ret < 0)
> > 			[...]
> 
> Funny, that's how I would normally write it, if I wasn't so focused on
> trying to follow the coding quidelines. While I'm at it, I will also
> fix that sneaky double space after the if.

:-)

> Is it ok to add the timeout for all platforms using the poll
> emulation, since I only tested for Windows?

From my reading of the patch, it changes only one thing, and only in the
case that the developer asked to build with NO_POLL (which means that the
platform does not have a native poll()): instead of waiting indefinitely,
the poll() call is interrupted in regular intervals to give
reap_dead_children() a chance to clean up.

And that's all it does.

So it is a simply heartbeat for platforms that require it, and that
heartbeat would not even hurt any platform that would *not* require it.

In short: from my point of view, it is fine to add the timeout for all
NO_POLL platforms, even if it was only tested on Windows.

Of course, we *do* know that there is one other user of NO_POLL: the
NonStop platform.

Randall, would you mind testing these two patches on NonStop?

Thanks,
Johannes
