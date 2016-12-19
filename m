Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21D1B1FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 12:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755281AbcLSMv1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 07:51:27 -0500
Received: from mout.gmx.net ([212.227.17.22]:61267 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755247AbcLSMv0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 07:51:26 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MRkhB-1cC3W132Yz-00T0SC; Mon, 19
 Dec 2016 13:51:16 +0100
Date:   Mon, 19 Dec 2016 13:51:14 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>,
        Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v2 02/34] sequencer (rebase -i): implement the 'noop'
 command
In-Reply-To: <xmqqtwa7ze9i.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1612191237400.54750@virtualbox>
References: <cover.1472633606.git.johannes.schindelin@gmx.de> <cover.1481642927.git.johannes.schindelin@gmx.de> <934c8e420cc4a75b1f3e4489fa4a4135c48f78ae.1481642927.git.johannes.schindelin@gmx.de> <xmqqfulr1s5z.fsf@gitster.mtv.corp.google.com>
 <CA+55aFzxFFNY+dL6s7dLZeVXBsBKD0aeof5Bj2wcD1CpefVSAA@mail.gmail.com> <xmqqtwa7ze9i.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:PDXFz0c7n1gWRErzyC59ZQqIOeto0278v41JGT6gWmh0oCJBPMP
 FizJ55oic7ioDaT+AbZqrkCqN8gtm4JZeMkwGDlMHG+8MSFWy+eWqeYw/gCMoAJf+cgDPs5
 SvzqMoZK0xs3H7+vlArvZuLMjW468lYEG8kPOGaD9OhJKNzsx6hIJnSgfkS3u34gY7X1KmA
 Y/4Wg8l4wfrZEZpxDxgmQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fmtFj8avq84=:vdLuWeiXgLtyQ5kzc4iox9
 xMivaDDRomBRjEJVPswwrMPAOIVwpgD/OKuqdbjkGaOxGa+c850LebIA4kpO8zycqF6KVbifc
 BwEQvkbGZBxhExsU9rUrpNWX+qlFlP5YbWMNaeC4W0uEqfEyLwgBTR9OffRIAGEgY2POJpmVo
 OJ49oBmirdB2r6CX5/OTqaZtfJA9uwMPO0YYuMMMfYsDCxO6ul2JNfB7N8DTeOmIrF7DbHxgs
 Y7GAOhbR7/4jp4RGWR/gwo8E8PatP/L04ahqv7JUFYwZR2vYePE4frT2uK8+QHEmsKgmYrQhE
 hDEOINjohpyGKS2GFHYApqEmIFUvAMI+rN7B8XbxHoC22Xvbr55NstuRFju4Slaoz1IJJ/s7A
 CQDYLFw88F01QF9n7LGftEWWCEedOJAmNrtDM/y8xkzc+7iWpQgN6LosMNufW5zfWBtJ5tKL4
 LhWJmelRmGVJ95hGJPbqiHezjXMlbA/MdLgCrgDJxRe3HsizPccPZSFRXGfZjpolUm3Vy1/Os
 YcRiWTEIT0NriioGY5l0z1jf7uv4mEWCpOa/PDiZ6fbQnmIYdhx545FoAqYa4QheZ0uQXwtrD
 3QgVbJRALtgnotGALC/AD3y6yRldiThGEEGrq2qLvW3//owivBRhw/bIc0md7VBY5Wim6AfJb
 FvWNl+6HkyEfql0Ua5WpEbBFkFaZtJgvD2eUzeGM/5uQ6h5wuJ1nwSui0A/mnkdspRHXi2C1P
 4SaHBI7EMnDKJSiqWMUBMGEvitSejERFJMRlyXgHoNFUUps5P80EwW7Vt5aaiplbdopGwKlmt
 35C/+32
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, 13 Dec 2016, Junio C Hamano wrote:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
> > On Tue, Dec 13, 2016 at 12:38 PM, Junio C Hamano <gitster@pobox.com> wrote:
> >> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> >>
> >>> +/*
> >>> + * Note that ordering matters in this enum. Not only must it match the mapping
> >>> + * below, it is also divided into several sections that matter.  When adding
> >>> + * new commands, make sure you add it in the right section.
> >>> + */
> >>
> >> Good thinking.

Not my thinking... This was in direct response to a suggestion by Dennis
Kaarsemaker, I cannot take credit for the idea.

> Makes me wish C were a better language, though ;-)
> >
> > Do this:
> >
> >   static const char *todo_command_strings[] = {
> >       [TODO_PICK] = "pick",
> >       [TODO_REVERT] = "revert",
> >       [TODO_NOOP] = "noop:,
> >   };
> >
> > which makes the array be order-independent. You still need to make
> > sure you fill in all the entries, of course, but it tends to avoid at
> > least one gotcha, and it makes it more obvious how the two are tied
> > together.
> 
> Yes, I know.  But I do not think the variant of C we stick to is not
> new enough to have that.

Let me try to express this without double negation: our coding guidelines
state very explicitly that we do not use C99 initializers, and it also
explains why: we want to support a broader range of compilers. For
details, see:

https://github.com/git/git/blob/v2.11.0/Documentation/CodingGuidelines#L179-L181

TBH I briefly considered going the same route as I did for the fsck
warnings (taking a lot of heat for the ugliness):

https://github.com/git/git/blob/v2.11.0/fsck.c#L17-L85

It would have looked somewhat like this:

	#define FOREACH_TODO(FUNC) \
		FUNC(PICK, 'p', "pick") \
		FUNC(REVERT, 0, "revert") \
		FUNC(EDIT, 'e', "edit") \
		...
		FUNC(COMMENT, 0, NULL)

	#define TODO(id, short, long) TODO_##id,
	enum todo_command {
		FOREACH_TODO(TODO)
		TODO_MAX
	};
	#undef TODO

	#define TODO(id, short, long) { short, long },
	static struct {
		char c;
		const char *str;
	} todo_command_info[] = {
		FOREACH_TODO(TODO)
		{ 0, NULL }
	};
	#undef TODO

I have to admit that even I prefer the version I provided in my
contribution over the "fsck method" outlined above.

Ciao,
Dscho
