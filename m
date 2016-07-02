Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E7FF1FE4E
	for <e@80x24.org>; Sat,  2 Jul 2016 07:20:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750942AbcGBHUd (ORCPT <rfc822;e@80x24.org>);
	Sat, 2 Jul 2016 03:20:33 -0400
Received: from mout.gmx.net ([212.227.17.20]:51628 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750789AbcGBHUc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jul 2016 03:20:32 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MSuYT-1arN6N1Mfd-00RraM; Sat, 02 Jul 2016 09:20:26
 +0200
Date:	Sat, 2 Jul 2016 09:20:24 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	git@vger.kernel.org
Subject: Re: [PATCH 2/9] merge-recursive: clarify code in was_tracked()
In-Reply-To: <xmqq7fd51ijr.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1607020906560.12947@virtualbox>
References: <cover.1467199553.git.johannes.schindelin@gmx.de> <dd3e2cf842fd5e11e31914aa55b8b995e8d3d75c.1467199553.git.johannes.schindelin@gmx.de> <xmqq4m8b4zdd.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1607011057180.12947@virtualbox>
 <xmqq7fd51ijr.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:n7IeqM881a1mj55oQ96nSth4zg4JKglGtyRJzaHtjpjRZqgrI+3
 ndQHUJYHQsvDKDiYmJJKJIyf5NGyCq7vMrvYv7SaMwmc/L4+w90IypoSTleZgRccxsplBpC
 ZHegJIGgMavw4wEsbwRKC6sdS+oeZtlaBlC6aB1JXSKMQlTgi72+NyPLR8NBOAXsEQoYYUP
 FbLQTvmlerD+s4fvT0POA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:YxTP189Tdkk=:7vkMa5yyCrYFuQptYnNprb
 NdqhUTLnXVs424hvvA6UeLnC2u6xg2zR/NdhF7YXhk/fG+uKOFfRgqcwn/IS5l7xYDmLtBhjq
 N6bXNEAJAO7ZWgcPZJP5S+ZMDZLtzoEeNlNu2JNQkjb39qkfwWhaSSWD4uOSRnhZc30gQqaLZ
 xKmmT8tXKtRsdBcV0dbgCPZEhe0/i0pCeRxMLhWodLBaBtK/hiwZWHiNgJGG0kNsueJk4SCXz
 456nyPTu0GKC26h7ePFdJsf+YeMCXxMslG5pXju8rofLRkZwqRYUkDcvUZIYpHPxcnEbTIP1T
 kO1HEj5zvyKj0npacxnatzjLDyyVjaMSkMYbT5Dt+ph5kyy9AF1TxbZ9oxwgsQSh8U3RvAaaL
 Lrz1RRmB6u5xDPlHH8T0B/wSHc15MO/T5wUwOdUssfdald0BntQk1C0TmofwUCo72fETJlJoL
 Aul+NDKccZC1JbpxNeiyr/I4xIuHz06w3XdodlD+l19/+pT3y2ShvAAjT2xaQv3NKhNPJiLST
 rVDDnFj1I18BsKeSsnmiTydVdvj1ufRJKpUa9LFpLhhzmFnf55LuKEAImlubBKkbvAsopVzvs
 39oeD9kfRNMsYXjjJO4FQjrDJ4XyYPhTEVpeuDRQHenHounoxboxj6oUHzYEEj3vug21wGtmW
 38DCy1pm6CKRN9JaWTXI0XeEfdnTw8tNhMLcjAwgiauKY+VsBvH1VFA90aDTwZwRNKu/XLV+n
 4nBMnbP+YrqMObrrfvB11UYxEuTjFBZB9Lu0XBLxWEOzCEFqXJxXVoqUPjYeKUTN/MKqJHxIV
 e9YEe1J
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Fri, 1 Jul 2016, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > I would like to propose this diff instead (it is larger, but with a net
> > savings of one line):
> >
> > -- snipsnap --
> > diff --git a/merge-recursive.c b/merge-recursive.c
> > index d5a593c..0eda51a 100644
> > --- a/merge-recursive.c
> > +++ b/merge-recursive.c
> > @@ -658,24 +658,22 @@ static int was_tracked(const char *path)
> >  {
> >  	int pos = cache_name_pos(path, strlen(path));
> >  
> > -	if (pos < 0)
> > -		pos = -1 - pos;
> > -	while (pos < active_nr &&
> > -	       !strcmp(path, active_cache[pos]->name)) {
> > +	if (pos >= 0)
> > +		return pos < active_nr;
> > +	/*
> > +	 * cache_name_pos() looks for stage == 0, even if we did not ask for
> > +	 * it. Let's look for stage == 2 now.
> > +	 */
> 
> I think this keeps the same phrasing from the original that makes
> the comment misleading.  It "looks for stage == 0" is not the whole
> story but only half.

Yes, it is the relevant part of the story to explain why we're not done
when pos < 0.

To understand why we're not done yet, the crucial point is *not* that the
return value encodes the insert position. The crucial point is that
despite asking for an index entry matching a specific name, we might not
find one, *even if there is one*. And the reason is that cache_name_pos()
does not quite do what the name suggests.

I am sorry to disagree with you here: I really find it important to
document this potential misunderstanding.

> It looks for a place to insert the path at stage #0" is.  Your half is
> used by the "if (0 <= pos)" you split out into a separate statement
> above already, and the untold half is needed to explain why this loop is
> correct.

True. I did not bother to document that part. Because even if I was
puzzled by the logic handling a negative return value, the assignment "pos
= -1 - pos" made it very clear to me what was happening. I am not *that*
easily puzzled.

> It returns the place to insert stage #0 entry, so if you are looking
> for stage #1 or higher, you only have to loop while the path
> matches, because the entries are sorted by <path, stage>.
> 
> And with that understanding, there is no strong reason to special
> case "ah, we found stage #0 entry" at all.

There is one, and I mentioned it. In the common case (i.e. we found an
entry right away because it is in stage 0), the loop unnecessarily
compares the name *again*: index_name_pos() already performed that
comparison and if it returned a non-negative value, we know that that
comparison was successful.

I find the combination of clarification, code reduction, and separation
between conflated cases (stage 0 does not need that loop at all)
compelling enough to state that my patch is an improvement overall. We can
discuss about wording and what details to mention in the comments, of
course.

Ciao,
Dscho
