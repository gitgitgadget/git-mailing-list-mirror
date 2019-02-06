Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 864B71F453
	for <e@80x24.org>; Wed,  6 Feb 2019 11:56:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728994AbfBFL4t (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Feb 2019 06:56:49 -0500
Received: from mout.gmx.net ([212.227.15.15]:40031 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727085AbfBFL4t (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Feb 2019 06:56:49 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0McVns-1gZgPT3Ejw-00HjE7; Wed, 06
 Feb 2019 12:56:43 +0100
Date:   Wed, 6 Feb 2019 12:56:42 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Johannes Sixt <j6t@kdbg.org>
cc:     Junio C Hamano <gitster@pobox.com>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH ps/stash-in-c] strbuf_vinsertf: provide the correct buffer
 size to vsnprintf
In-Reply-To: <ef5f66fb-7467-93be-00fd-7900ce961f72@kdbg.org>
Message-ID: <nycvar.QRO.7.76.6.1902061242380.41@tvgsbejvaqbjf.bet>
References: <896ae9dd-7ac3-182e-6692-c09bc4864de0@kdbg.org> <xmqqd0o7tdxt.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1902051140060.41@tvgsbejvaqbjf.bet> <ef5f66fb-7467-93be-00fd-7900ce961f72@kdbg.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:db3ECR8a8j0nd7mMNOWdXDo42n5uP16xESIQ0WBfiby3ldTbYYW
 i38JZQsMiImhBFeDZdYHMTjOytM6dZv1Vw0BtZTrISo7q5gHovW5qEAktwbmeQIvnnIDv47
 kkuJyu4rgyXMppRi4syWaDrcl6D3gMBjsdsQOq8D6fjkGbXRXgPRPnznKfvXpv8G//cQ08F
 JBzHiwG6NmzvkEZX7MqwA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dJtqterfivQ=:moso4H0SbA/mDB6kxNlLU6
 um0tTYKIPjO+KIbnqAck2J/qlIEzF0B8+udB/JvIqAKMbv5nAar/arMwtYDP67clozv4/WrWS
 4xzW4rSB+INgVp7aQTjt9cn5xhFfJx022dQmZNhNLJA2wubZrcxPPqJ09LXwf4r+xVIySCO+h
 rqLWj2KtwUExI/r+5yPeWXXyE2EsdR4r0PdZdqgE+a/+dt4/7hMQaN+wQVRrGRlMdNXzQXjJt
 CNfSaDxQleLyZLx60C0CJOT5IKuh8dmQAatObNMf7tXlOcWJvnadrwHutqJtEvJDqqj/Lulwr
 aO1ESMVGa5qdwUrflOrcXXPWFc/EkoH5Kk9ywiw/Xe90CqbB2X/0D0uBdBw7CjwsTf4JoIs0Y
 f1SPgpFoIgBtpA88bCuvl64eSrihUqhwYFb3piEizEfMonXYspU8J8vBStXHPiRY6I7R3WRW7
 AoWDVBpbU1j3KfDKYp1Ry9/XwQMrdiS0j+1C+XyizSR1uE6F4MDc40wl1hzffWpk3P/9m9gq7
 j5BXyzApZIRYqaxVRgVYsYn6XssLFjquduKZH8Tn/4tcf8mHT68oYCtFrIr+8fRaFceEFqVXd
 F+xd+JlHidpQwrbkaFchQQtFXlw2OmHdkiD6kue/tosVE1CAECX3iapRfdpbbQDd5pP3iq6Oh
 1hEJ39zZi8j+8hRlqXhvmj1IM65DCuvFYpEJ3f8cimDGlKGgGIEH7dqqAESD2EGjuX2RlZ/Ad
 s1IfVlBOpM6vA95zvgRATHxg81EszVfgTcdTpF5xk2tMoxUxVOOeZ+0N5btfnTTvdBrApZPJ6
 Zz8gFdrHWB4/7gaaDiH1VYWq/T0oq32hNgtuHi/6Y+PIQzWKxDm8/EUkf9V4LdciBdmV+OOPi
 Va+L1f5wuBB8NOh926Ssg9g2jqBAyScZO6C0DvEJaDGksjk+fr63Tz3U1XK9+7GL8/ABk08cz
 oFLZxIHYeMw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hannes,

On Tue, 5 Feb 2019, Johannes Sixt wrote:

> Am 05.02.19 um 12:06 schrieb Johannes Schindelin:
> > The real examples are much more mundane, and very different from what you
> > suspected, e.g. inserting the tag header before the tag message in
> > `create_tag()` in `builtin/tag.c`. Basically, it is building up a strbuf
> > for the sake of calling `strbuf_insert()` to insert that string elsewhere.
> 
> I had a look, and this example does not convince me at all. If
> separation of concerns were applied well around the launch_editor APIs,
> you would not need strbuf_insert() in the first place. But, alas, these
> functions focus more on DRY, and that is often the opposite of
> separation of concerns.

So you actually are convinced that it is needed in this instance. Good.

> > In any case, the mere existence, and use, of `strbuf_insert()` is a
> > pretty clear counter case to the idea that `strbuf_vinsertf()` would
> > encourage invalid code flows.
> 
> Nobody wants to get rid of strbuf_insert(). I have worked with at least
> 3 string APIs. All have insert operations, and some have string
> formatting capabilities, but none of them conflate the two operations
> into one. Maybe, there is a plan behind it? strbuf is the first (my 4th)
> API that does, and it was non-trivial to get it right...

Sorry, by that token `strbuf_vaddf()` would already be a violation of the
separation of concerns: it also makes space first, and then it also
formats a string.

Render me unconvinced.

I am still glad you found and fixed the bug,
Dscho
