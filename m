Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61AFB1F6C1
	for <e@80x24.org>; Tue, 30 Aug 2016 18:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753512AbcH3STB (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Aug 2016 14:19:01 -0400
Received: from mout.gmx.net ([212.227.17.20]:52298 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752300AbcH3STA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2016 14:19:00 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0M6SE3-1augBi35it-00yTEz; Tue, 30 Aug 2016 20:18:45
 +0200
Date:   Tue, 30 Aug 2016 20:18:42 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH 14/22] sequencer: prepare for rebase -i's commit
 functionality
In-Reply-To: <xmqqfupm5fix.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1608302005440.129229@virtualbox>
References: <cover.1472457609.git.johannes.schindelin@gmx.de>        <1d83fa095c03eac9abfd1038ff7791bae8ace984.1472457609.git.johannes.schindelin@gmx.de>        <xmqq8tvf8dmz.fsf@gitster.mtv.corp.google.com>        <alpine.DEB.2.20.1608300836030.129229@virtualbox>
 <xmqqfupm5fix.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:lb26Ls8TVZYvB/4wib/Qm8z53L/jiOvA1p4SfehbcbZq+oYDsIH
 54+w1mkA1WYeFnC8zS5e4SFBiecjEA3Tsi7qfEvypYs+Ix6H/xvhWMmtE2kjZFNG4Mjd1Dk
 mUcWart9TLQUthCBxP3+VGYADewQul2PU+p92r9gIM3EHmgQSSxe2Rb+aiGWsWrtdjxJXRI
 2/VWeINYhfHz1Je10/ZTA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/sek+wUXXE8=:mycdCdzxe9p9EsIzfPtXvH
 h3jR/k5R3+10dlKXZZHsHJM3prNbQomYMWwkL1tYNja6unKHN75BvnKeAeFPyGGymoUQigERC
 sGbmDZLEQtdtTBBGh/yQ5pwksKzH2PPtL5mUZMq+hHYwYuPMwd/pzkvctr0KgNU6LzHtTCLU8
 KlP8E+Uz9aRibZVs7pVX5bf85OTMZ5DaHZAXzUnc4+aW+1PL1N2Bwu/N3VpRv1V5yrRuXMgGC
 Zb6oCIcw0h3XGpJ6gnDw+bTutmdPd6Iks4JnQoVIVzO+qWkNuD5NvOLacK0HfgTVWDVDRXQcy
 oiCGV9AH2YAbqLKgCdELP/hIrhtxnzTCRIm/dT34Hynzd/dxxALTI00r+KW0MjRy071rUCq7w
 NKgT4L2mYNnSVphy98d49afXKeJg+BEn7DnShuATu1W5mqE2mysAf+Lus2rqEPwljmCtVQjNZ
 zCqwhOo/ZsscGxc82nlhSAdtVcfXDehqZHLADx7vOTTNFZCAcESAYP6XbULAp3ob4MYzzHhBY
 NRuHg3TKgrDNeOfuNO0kqXzj+EUfjGflPiNhdGhe/gSrNIWuKZH+XXT6EixhwGmiftinAXzAi
 zgsmtj+W/goYtcTDqI4eo/SupVwjt5v6Tr8gg5OhzWryQ8Y55NRqP7hSrmZEe/ki750+Spk44
 s1RwMDnPzVPLQgDbk2fwAFvuhso7dVe6m3FvS+YmmAi4bBjfH+Ux0HThppubLYIvZThFqRjfg
 DEINRgRZsWmPirVOaSdRw6xkRIhsidqHt2Ma2WEpyyWjKzh+cMcSv+gHKdBpEXjq+dYp1r3Hx
 JJDAfu2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 30 Aug 2016, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> > +static char **read_author_script(void)
> >> > +{
> >> > +	struct strbuf script = STRBUF_INIT;
> >> > +	int i, count = 0;
> >> > +	char *p, *p2, **env;
> >> > +	size_t env_size;
> >> > +
> >> > +	if (strbuf_read_file(&script, rebase_path_author_script(), 256) <= 0)
> >> > +		return NULL;
> >> > +
> >> > +	for (p = script.buf; *p; p++)
> >> > +		if (skip_prefix(p, "'\\\\''", (const char **)&p2))
> >> > +			strbuf_splice(&script, p - script.buf, p2 - p, "'", 1);
> >> > +		else if (*p == '\'')
> >> > +			strbuf_splice(&script, p-- - script.buf, 1, "", 0);
> >> > +		else if (*p == '\n') {
> >> > +			*p = '\0';
> >> > +			count++;
> >> > +		}
> >> 
> >> Hmph.  What is this loop doing?  Is it decoding a sq-quoted buffer
> >> or something?  Don't we have a helper function to do that?
> >
> > Well, it is not just decoding an sq-quoted buffer, but several lines with
> > definitions we sq-quoted ourselves, individually.
> >
> > The quote.[ch] code currently has no code to dequote lines individually.
> 
> There is a function with exactly the same name in builtin/am.c and I
> assume that it is reading from a file with the same format, which
> uses a helper to read one variable line at a time.  Hopefully that
> can be refactored so that more parsing is shared between the two
> users.
> 
> Two functions with the same name reading from the same format, even
> when they expect to produce the same result in different internal
> format, without even being aware of each other is a bad enough
> "regression" in maintainability of the code.  One of them not even
> using sq_dequote() helper and reinventing is even worse.

First of all, builtin/am's read_author_script() really, really, really
only wants to read stuff into the am_state struct.

That alone is already so incompatible that I do not think it can be
repaired.

Further, builtin/am's read_author_script() reads *only* the
GIT_AUTHOR_NAME, GIT_AUTHOR_EMAIL and GIT_AUTHOR_DATE lines (opening the
file three times for the task). And then it *requires* the corresponding
values to be sq-quoted.

I do not have a use case for this myself, but rebase -i explicitly eval's
the author script, so it is conceivable that some enterprisey user makes
use of this feature to set other environment variables. The thing is that
rebase -i cannot necessarily expect all of those files in its state
directory to be under tight control -- in stark contrast to git-am.

I could imagine that this could be fixed by abstracting the functionality
more, and use your favored sq_dequote() (which may actually fail in case
of an enterprisey usage as outlined above), and adapting builtin/am's
read_author_script() to make use of that refactored approach.

This is a huge task, make no mistake, in particular because we need to
ensure compatibility with non-standard usage. So I do not think I can
tackle that any time soon. Certainly not as part of an iteration of this
here patch series.

Ciao,
Dscho
