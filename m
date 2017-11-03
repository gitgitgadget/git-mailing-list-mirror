Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 738EC20450
	for <e@80x24.org>; Fri,  3 Nov 2017 14:47:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755549AbdKCOrf (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Nov 2017 10:47:35 -0400
Received: from mout.gmx.net ([212.227.15.15]:59890 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755519AbdKCOrd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Nov 2017 10:47:33 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MI5Ve-1e7th616re-003xON; Fri, 03
 Nov 2017 15:47:22 +0100
Date:   Fri, 3 Nov 2017 15:46:44 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Simon Ruderich <simon@ruderich.org>
cc:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH 1/2] sequencer: factor out rewrite_file()
In-Reply-To: <20171103103248.4p45r4klojk5cf2g@ruderich.org>
Message-ID: <alpine.DEB.2.21.1.1711031425420.6482@virtualbox>
References: <6150c80b-cb0e-06d4-63a7-a4f4a9107ab2@web.de> <20171101194732.fn4n46wppl35e2z2@sigill.intra.peff.net> <alpine.DEB.2.21.1.1711012240500.6482@virtualbox> <20171101221618.4ioog7jlp7n2nd53@sigill.intra.peff.net>
 <20171103103248.4p45r4klojk5cf2g@ruderich.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:J0OOcebqnbHKBFCiM9OFyhvbMmInI+yxNGyZPsEllCu7TPmMytj
 C2ImV5fda4eHemxy6MSlApK2nnROBIpRwy6wg0xhK4PKnmwF1AmT10oRLXF3I+ePA+Q0ivJ
 f0hWRAjC0fhVsTGOy0ChX8sMq7rwSgY7zwY02FJq+hZGjGfosk60Pv1q0Vr/VDt2DP8L4hr
 JJ7is5OWM3LwBnDqSY19Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:TZFAxzUIdCY=:ESKXdCBLDaKXC0CvEndkAP
 m3S57ziMUXkvzj8BIQqAD6OZWO0QHQ98GB7XFx17uBd9m/w9joPX1RcpKWO/1L1Nbs0P5vfxn
 3GynMUNbrJRnbAyRoaLL5h3JAkWroo7x318+YRM4nMKs+EzY2gXlPQLFlZSr87nBBihDUBgUx
 mXtklNv6rknDF4oXQ42XUpw61OmsHMuUiR8sbbXfZ40OeZQh7Z60xA5/VIw0D6VDc9Ll1i/Ab
 gsGqugDonSFJgY+WfrujsFR51hf4lLuJNrLqawTKQ4xXJrXW+cRxtgq7DtxcdtEe+nV9meLtk
 H+xBdyGcxHCHSwQsU3KL2R7Wwmk35jOjS+rjF1N3hdSlE0CAQCw3LxNI2bastUXMaZ8IeWr7+
 QSucbZOtMNEMDDcI4Tw03q1obSpB5tSe/Z+5QJaMKpWfjTDKOBmx3aJPIw5iEWocr3bQkE5JD
 rs4a+BkA+jMKwVL8XbJdiha5xVA5WKTsYzmxJ3PhNaH/dI2KHk8OwWBN/zouZVeMv6cJVSidP
 uo0/U4O0zTP1SQidXLHhIVYMQKV7q92xP9dIz7k3TsZxBM3iGqM0mQyPryjtLbTXeoAbz/Baf
 +YcSd/MGdTO6C9w8g/XeKgn4Bb10KJTZ5xrpArr5KmoN7XqaeM6nP0BJpVa2VcH5cERW3087C
 6OOZFgsZn95qrIzsMQE/HC4Ldv1bdYS1rq1Ru40mxITC4nB+tcLoqoWzcx9gtuASKsxKY+N0w
 onROBRl0uM48FbK5Szwek9gK8Z0ZQmx0aMoOHFezEm0jKis7rb13sFkAzIR1O0Unze4JQ/+fs
 Ph2DlgDldyyOhzIplAveAivEJxecG3IEPQ/+cACtU5pQ24nCKU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Simon,

On Fri, 3 Nov 2017, Simon Ruderich wrote:

> On Wed, Nov 01, 2017 at 06:16:18PM -0400, Jeff King wrote:
> > On Wed, Nov 01, 2017 at 10:46:14PM +0100, Johannes Schindelin wrote:
> >> I spent substantial time on making the sequencer code libified (it was far
> >> from it). That die() call may look okay now, but it is not at all okay if
> >> we want to make Git's source code cleaner and more reusable. And I want
> >> to.
> >>
> >> So my suggestion is to clean up write_file_buf() first, to stop behaving
> >> like a drunk lemming, and to return an error value already, and only then
> >> use it in sequencer.c.
> >
> > That would be fine with me, too.
> 
> I tried looking into this by adding a new write_file_buf_gently()
> (or maybe renaming write_file_buf to write_file_buf_or_die) and
> using it from write_file_buf() but I don't know the proper way to
> handle the error-case in write_file_buf(). Just calling
> die("write_file_buf") feels ugly, as the real error was already
> printed on screen by error_errno() and I didn't find any function
> to just exit without writing a message (which still respects
> die_routine). Suggestions welcome.

In my ideal world, we could use all those fancy refactoring tools that are
currently en vogue and simply turn *all* error()/error_errno() calls into
context-aware functions that can be told to die() right away, or to return
the error in an error buffer, depending hwhat the caller (or the call
chain, really) wants.

This is quite a bit more object-oriented than Git's code base, though, and
besides, I am not aware of any refactoring tool that would make this
painless (it's not just a matter of adding a parameter, you also have to
pass it through all of the call chain, something you get for free when
working with an object-oriented language).

So what I did in the sequencer when faced with the same conundrum was to
simply return -1 if the function I called returned a negative value. The
top-level builtin (in that case, `rebase--helper`) simply returns !!ret as
exit code (so that `-1` gets translated into the exit code `1`).

BTW I would not use the `_or_die()` convention, as it suggests that that
function will *always* die() in the error case. Instead, what I would
follow is the `, int die_on_error` pattern e.g. of `real_pathdup()`, and
simply *add* that parameter to the signature (and changing the return
value to `int`).

Ciao,
Dscho
