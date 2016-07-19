Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FD0D1FEAA
	for <e@80x24.org>; Tue, 19 Jul 2016 14:28:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753733AbcGSO2z (ORCPT <rfc822;e@80x24.org>);
	Tue, 19 Jul 2016 10:28:55 -0400
Received: from mout.gmx.net ([212.227.17.20]:58003 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753514AbcGSO2y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2016 10:28:54 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LezI3-1b01d71X5D-00qk3M; Tue, 19 Jul 2016 16:28:34
 +0200
Date:	Tue, 19 Jul 2016 16:28:30 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	Joey Hess <joey@kitenet.net>
Subject: Re: [PATCH v3 00/16] Use merge_recursive() directly in the builtin
 am
In-Reply-To: <alpine.DEB.2.20.1607191427400.3472@virtualbox>
Message-ID: <alpine.DEB.2.20.1607191602520.3472@virtualbox>
References: <cover.1467717729.git.johannes.schindelin@gmx.de> <cover.1467902082.git.johannes.schindelin@gmx.de> <xmqqpoqi35u3.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1607141414180.6426@virtualbox> <xmqq1t2wqaa3.fsf@gitster.mtv.corp.google.com>
 <xmqqshv6h460.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1607191427400.3472@virtualbox>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:wtndqYzNccQ5kusVFlmSOCDJnqvTsSDE2VTRCtG4xCJRaGtuKwS
 9/RolopW+qA4vd6Y7bc6sbqv6H5j7+3HepR3DvLjc2hh2gxRbuT7hZoOwOZF1KKB2BHNIvW
 uEsg2eUmcCkpzFmr5GHK6DsFaoR7dLazE8c5UEt7EI7Frpa62yCcLqpxJrulfL20yPgOV0j
 CqVI55EXyH4d6qL6zmUhA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:N8KRdc9JzIk=:6R7XmhJPlLqpB1YZDTnvZN
 zYYqvCPkEd806eoWEFKPNn47nQLqdBWFas9r74wzb65T8odjDyuZ9znDjaVU8qTK6n4DbHnet
 xBq12d/g7TtJ/mXmzmfSrcC458PiR7Mq6h0Nq1UMbL8yAXcnhNKoqNDKHAy5YIq9SJyQhOdqx
 /yhLI9I+nMDZ1tq6IY58OvPPhK0TJxpeA6+jS7OJnlE7piQp8oh5sTApqK6Ahg2eeNLL1MPQd
 KXkxm4DvXDkBg0jzsQBm2IQycqDjqlLDdSq0PQvgVlmQajQAaj8coqEHufqpr1KdzqujlKGvt
 CQdDqA759SvrGUOSmcLAAOqTZF/rPDCQX6V0A9GsHtxuTbOxoUSzDi5MQFhl5qfNJSZz1qmlG
 1YmhgdPJrPKl8uMlLTjuOWgvJTDEEK51qh4dkXb+FZVvJMpMqvVTIVRXkLd7pa/faRYAG5xih
 5J8B1pVxtaXzflOwNoAWur/bfHMat/6IJl0BhLUqPDql+LRGVDzR4KGPRJyKESg2J3FwtFNgZ
 z+ky665lZhqqFjqC829A1M3o+5dqWXVgsHjMMgK64/H3sFFNG06Uj4UOyHKGb4AiCorrOPw7U
 FbYxXH9fCreVnauz+7Xh/Q6EVWS8h4AbqGRkrBXBxCYDoq0bE+NiuH8luJT8buS3HnUtR0wlq
 spZDj8B6RnW+/AcXpoBObANjoNT3zf3g3YmnsC1+c8CUPektvTFMCnv3hWOWZkh8OMZC6ya1y
 cxdLDfiJ/G8xY9oefYSvkKEbQ331lfAkMoyANj4i7LKc/MbfctpG9L60ErC8xV4WzueXX84cR
 iBnnF8k
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Tue, 19 Jul 2016, Johannes Schindelin wrote:

> On Mon, 18 Jul 2016, Junio C Hamano wrote:
> 
> > Junio C Hamano <gitster@pobox.com> writes:
> > 
> > You can assume that I'll merge bc/cocci and
> > js/am-call-theirs-theirs-in-fallback-3way to 'master' during that time,
> > so an appropriate base to use would be the result of
> > 
> >     git checkout master^0
> >     git merge bc/cocci
> >     git merge js/am-call-theirs-theirs-in-fallback-3way
> >     git merge cc/apply-am
> > 
> > if you want a semi-solid base to rebuild am-3-merge-recursive-direct
> > on.

I do not need cc/apply-am at all, it turns out, but my patch series has a
minor conflict with 'jc/renormalize-merge-kill-safer-crlf'.

Since you indicated that you want to cook that branch a bit in 'next'
first, I will rebase to master+bc/cocci+js/am-call-theirs-theirs and
re-submit.

Ciao,
Dscho
