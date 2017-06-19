Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=AWL,BAYES_00,FREEMAIL_FROM,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F10CA1FA7B
	for <e@80x24.org>; Mon, 19 Jun 2017 13:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750907AbdFSNS2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 09:18:28 -0400
Received: from mout.gmx.net ([212.227.15.18]:53827 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750733AbdFSNS1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 09:18:27 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MPUZ7-1dR5Pv2O7F-004o2M; Mon, 19
 Jun 2017 15:16:50 +0200
Date:   Mon, 19 Jun 2017 15:16:48 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Joel Teichroeb <joel@teichroeb.net>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v4 5/5] stash: implement builtin stash
In-Reply-To: <xmqqvanvv9be.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1706191516350.57822@virtualbox>
References: <20170608005535.13080-1-joel@teichroeb.net> <20170608005535.13080-6-joel@teichroeb.net> <xmqqvanvv9be.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:zHIG0ZSPJelRH5b2I+6TTgxqQTmiYff/wRqvf9m70YypuVvG9+O
 rh0S7LS4QbMMdaYzin5NnQvYtTg50K0dbaNWiDvngm8Hq5klzz/KM0RVNyLuMNxjhGoyE6c
 Z0cX+w4lApAqWMbaCe2si9Al+u8QTKcKDoCzI2YddLhg63OKJLeRcNeoiAGna1M24qHmL+6
 RPVG4+1ZRV+HpbIY9vyKQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:OEVHqtcVq5o=:vthsGLNe8mkFnmxVnBKcxm
 Raud4AuY45TpuWw7TTbdZtUeARlKCRHrW4sNFRJy66ApgGPnE3u4DMHHyQcaAOGnyH9+JC6bD
 TQVp4lYy6NT9E6bfd4XG+lqeAe6FmipWHvCdYh1U6Ng4F8rBFqvfOG+CKO7688ql+rHFTsk2T
 PN2Lg/XQK0Io/LUOk+YqahbU4A7E+JDoks+yFJ2dxCrODDgdT5DW+JS5KtOeb2Ldz+OaBWANT
 FzYBe8DPrpFNAp3CKaoHQ1UfJVNJ+WYlgHzpRJ8SR3JHeTmc9Z+IQU68gSpTD9cuxtwJ4JmDv
 5jDuZWARu8Scc9ULBST39wMPeZndctKxSlCd1xEZjupbPAPln5/3g3MBAkZB8ubs6ci8Nuo65
 Aa6toUJcMhEQtVhmG7PwMME0qENV8fW3Ql6Ur5MTjchKC+fCLbDzjBuUcWyo9IuPiPJhRmHOG
 Av8eJPFnh6jyyre6d/Trhhzl8weqSkbyxulQ/tfnG29Ignu8Ds4u8jdGGiPPcyZFJdpicL7ar
 st3HRGISbgtwht9Gr/ESPGCfYcrBTIAwOL3wn7N5ZKebIxRFUI8WvlK36GcM5EiPj/b/GuGJ7
 BXMjUpeb8IDszUc18LQdobUJt4eK88CqX9du85Zh86WxtUQhXgVrsZILuUAeTxOxgoFJXJHA5
 M5vY2yiNvu7s1HDbf/JDDLUAYGtIK+fAqE4hq4jCj8ncybb57BUs+a6gzhnrDNkgWBWkJH41Q
 i0sFbH+ETclKLqpAHd+h12TrOpEwvdGfkcmfxLf/G4Em00Wygx0HwUm2Br4mx1maXJAGwKKpb
 555EyO6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 16 Jun 2017, Junio C Hamano wrote:

> Joel Teichroeb <joel@teichroeb.net> writes:
> 
> > +static void stash_create_callback(struct diff_queue_struct *q,
> > +				struct diff_options *opt, void *cbdata)
> > +{
> > +	int i;
> > +
> > +	for (i = 0; i < q->nr; i++) {
> > +		struct diff_filepair *p = q->queue[i];
> > +		const char *path = p->one->path;
> > +		struct stat st;
> 
> The order is somewhat ugly.  Move "struct stat st;" that does not
> have any initialization at the beginning.

Let's not call it "ugly". You may find it ugly, but maybe you may want to
avoid contributors feeling judged negatively, either.

Instead, let's say that it is preferred in Git's source code to declare
uninitialized variables first, and then declare variables which are
initialized at the same time.

This convention, however, would need to be documented in CodingGuidelines
first. We do not want to make contributors feel dumb now, do we?

In this particular case, I also wonder whether it is worth the time to
point out an unwritten (and not always obeyed) rule. The variable block is
small enough that it does not matter much in which order the variables are
declared.

However, trying to be very strict even in such a small matter may well
cost us contributors (and it is dubious whether the most critical parts of
our technical debt has anything to do with small code style issues similar
to this one). It's not like our bar of entry to new contributors is very
low, exactly...

And if you disagree with this assessment, you should point out the same
issues in literally all of my patches, as I always put initialized
variables first, uninitialized last.

> > +	strbuf_reset(&out);
> > +
> > +	discard_cache();
> > +	read_cache_from(stash_index_path);
> > +
> > +	write_index_as_tree(orig_tree.hash, &the_index, stash_index_path, 0,NULL);
> 
> SP before "NULL".

If only we had automated source code formatting, saving us from these
distractions during patch review.

The rest of the review, modulo all the "Hmpf"s, seems helpful enough that
I will try to find time to review the next iteration of this patch series
(with a fresh mind, as I only skimmed the previous iteration) instead of
adding my comments here.

Ciao,
Dscho
