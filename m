Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57EEA1F71B
	for <e@80x24.org>; Mon,  1 Aug 2016 09:42:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752522AbcHAJmE (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 05:42:04 -0400
Received: from mout.gmx.net ([212.227.15.19]:54589 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752265AbcHAJlo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 05:41:44 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0LfBX6-1axIvy2gLA-00orno; Mon, 01 Aug 2016 11:40:50
 +0200
Date:	Mon, 1 Aug 2016 11:40:49 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v5 15/16] Ensure that the output buffer is released after
 calling merge_trees()
In-Reply-To: <xmqq8twmvib5.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1608011138110.149069@virtualbox>
References: <cover.1469187652.git.johannes.schindelin@gmx.de> <cover.1469547160.git.johannes.schindelin@gmx.de> <a2af8827e4df9f1555821111aac92606496006be.1469547160.git.johannes.schindelin@gmx.de> <xmqq8twmvib5.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:hUFbCc31+8GnkwA0mP2KBKlgN/8nwq2rNW1t55sAifbjtT8+lRo
 jgGXg8Bg4XxsOfYhSbaeIHebCyfePrQ7bohqGhHFw7Vf8F87iR0979uvhCkSKcnpYeVfT42
 EYW8tlPo7SYZTijIN+/VaHeUwsiuPeGztrF85wk4Cr6S7RCFBuKMNP3zG5Zj5h3/A/k+gzE
 +vlt1Fyyb3mb2PFE+NjXg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:TyfZD4p9Ask=:qSaABu2qMb9FdGqI0lO+/E
 qVrmLL2rk8U7StMllKY0r0MiBGSqOTNeVCN0qA0gcOyZQblNVHusSCDHlFNvXTfo88trVAU46
 4sK6koWfn4IpMdA/s6UGBK1NqFtWa+ktEBJmq20B5R9M6HsyVirL74+sOTNt8aedmAYKvDj9+
 l2iLYuyJKaFwtRvCQVY/BrZoeAsG0fpJVfJWZBHI4V+MCAwZbwZtySKOVe8KG9ZBRa13Nrj+4
 ltKFFYVB6GvFhR1M1RYiysdz1oMQbxwu5LQyyaOqeHu1CMwATpVNyIIJ0tNH9/gVZxrnz/S2P
 +9BM4CFi8BZFUO72hTDy+mGKTHjeIuJ1klwuRR2bQ6ir3/0EKi/OFJNQTu3c8a2IkJaCAtegk
 liU4fYlXUHHEhrFqqhjn4LsR/w/WJlkmKbts66cU601yQdySp8i8YG1F0prpLFojkESXEldw6
 /QDGeS4t0XE6u/yOQxy3wB81NZxGA0NbfhFSafEg9EfMx9Oh1kKnnzbii0vSMUvWWWhG3lb8u
 Z2BUaWnbd3Ln0JJZBLhwAGn1o9JYJaj+QyWz4wB8bB7hXAoOKF5JShJHxJjMYct1eQcWBuwZO
 l0Fw0wig/pVA7c1RtbLTINdJ5Bz53z7B4Jwc6VdEsfpD2hu3aUZThUmRuN+Gjw3ajh7Rlp+5m
 VgqreujKLfaZyFoQpY8w2ZbZqz+iEORQmD5MIbBLUKZQHzooP4hYW2OolTkRkMWWRiwpfinZB
 +SkCYbrwHTQBK0YRrHVdfx+sTu4ugrg40PeT16fM28NwD2KeU37Z8P1CqQj4d/cS4aX7k+zoB
 d2Yfuvc
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Wed, 27 Jul 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > diff --git a/merge-recursive.c b/merge-recursive.c
> > index 311cfa4..a16b150 100644
> > --- a/merge-recursive.c
> > +++ b/merge-recursive.c
> > @@ -2078,6 +2078,8 @@ int merge_recursive(struct merge_options *o,
> >  		commit_list_insert(h2, &(*result)->parents->next);
> >  	}
> >  	flush_output(o);
> > +	if (o->buffer_output < 2)
> > +		strbuf_release(&o->obuf);
> >  	if (show(o, 2))
> >  		diff_warn_rename_limit("merge.renamelimit",
> >  				       o->needed_rename_limit, 0);
> 
> Other two hunks looked good, but this one I am not sure what is
> going on.  It this were "if call-depth says we are called by another
> merge_recursive, do not discard the buffer", I would understand, but
> why does this have to be tied to o->buffer_output being "we buffer
> the output but not errors"?

Good point. I changed it to test for !o->call_depth in addition.

We must not release the output buffer here if buffer_output >= 2: the
level "2" of the buffer_output field says that the caller of the recursive
merge expects the output to remain in the buffer until after
`merge_recursive()` returns.

Ciao,
Dscho
