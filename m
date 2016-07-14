Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26EF320196
	for <e@80x24.org>; Thu, 14 Jul 2016 14:04:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbcGNOEA (ORCPT <rfc822;e@80x24.org>);
	Thu, 14 Jul 2016 10:04:00 -0400
Received: from mout.gmx.net ([212.227.15.19]:58792 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751054AbcGNOD6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2016 10:03:58 -0400
Received: from virtualbox ([37.24.141.198]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0M8laO-1bXcqy0NaO-00CAOt; Thu, 14 Jul 2016 16:03:36
 +0200
Date:	Thu, 14 Jul 2016 16:03:33 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v3 00/16] Use merge_recursive() directly in the builtin
 am
In-Reply-To: <xmqqpoqi35u3.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1607141414180.6426@virtualbox>
References: <cover.1467717729.git.johannes.schindelin@gmx.de> <cover.1467902082.git.johannes.schindelin@gmx.de> <xmqqpoqi35u3.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:w9sinFnECMQcZKuvbwprOt8MTeNtj7cxtUOKf6UbbcRWKF1WuE6
 BWvtU/iSkl1dB1lJm7sc5AfxeMWFL+otObp7iK/LWNcti3HSo1SXISfZG4FiITG+LoVrArC
 d8zHnuvVUFn3kaTLDq7AhqerrlGw0dLzF63Ry6ukoQoVEgW0XaFeH4JlWI93qv3t1G0AkDE
 eL3PQH4+SUqS9wcq6i5Cg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:fL0zdkemnQU=:SQ0pg9L/pp4HElY5CDd+Nz
 rJHpAq7cPC0mq48RSbCfY9T2de0qw4jyV3LgKIqp2ITW05FbaOJoBR8iysPX/rsVLWI9wR8Mo
 mz6lUPjieGgHYQ6XQVXysp78VB9q/bCf7AAp3kE+33t/wQUDX0I10uCM9OPo3VJ0SMQLncQgI
 5p2jCEheCqs4tJvPmQJEDqLYI67XOXQC9kwbDwY5YZy8KkKM4v9HZA6yvbfNgVRqZ8FRsM+qG
 9/agc9VMFeKzWc+Q0UD17hgVw1QG/pta9S+fuNuPDnUlvPMCnzgPnepWWWUI/VXjwqvf74EgI
 rB5uIYVZTzUDfw78w9ST3v08/gR7P9L+UCMWXYgIyYBNA944Q63dciLtJaNhRYqYh6FKp71cf
 9riW2iq7C5vsX69CdQBB1mHl++h7T/95VB0bwx0IkgQkuKTjp71oimOv16dgobUZ/QEFKQhki
 wqpHyYMmxcIP5tI27KW5qKfZFC8Be4ReU7Q/F8B2vDE9Ru7UnByTRd4qhdkKmqGc4tnWR+vcg
 OsBTuMXbnu2K1aPRzHAuwap4qINlDJoky67tqpxS5wMiUhhdF9SQSiPF+LGPsjBJ9eYslZn//
 gUO9lTIGTXiJgXenhAEwC4K7VpSXrGeGBMLumYaDypdRPJJsH1jG0nxcScAX7P7iIo+Zr18e9
 cjalPphf0oumCaRMicrHjNPLVIYyejuGPub3cL1vWv6rB+VQSKonuo7f1deQSoh49zeJrTOAB
 vEEXSQHoOSAclIILuzpwRjUxxSMTVjgNEpfrq8XvHNg88s0ISuGPQ5LheULwaOOyPloX8BuKh
 mjiKX6M
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Tue, 12 Jul 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > This is the second iteration of the long-awaited re-roll of the attempt to
> > avoid spawning merge-recursive from the builtin am and use merge_recursive()
> > directly instead.
> 
> This is actually the third iteration.

It is.

> I am trying to tease dependencies apart and apply this on a more
> reasonable base than a commit that happened to be at 'pu' on one
> day, but this would probably take some time, and I may give up
> merging it anywhere for today's integration cycle.  We'll see.

The two topics that are in 'pu' and conflict with this series are
'jh/clean-smudge-annex' and 'bc/cocci'.

It also conflicted with 'va/i18n-even-more', but that one was merged to
'master'.

Now, I think it would be okay to wait for 'bc/cocci' to go to 'master'
before integrating the 'am-3-merge-recursive-direct' branch, but I would
want to avoid waiting for 'jh/clean-smudge-annex'.

Do you concur? If so, I will rebase onto 'master' as soon as 'bc/cocci'
lands in there.

Ciao,
Dscho
