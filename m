Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96DE320989
	for <e@80x24.org>; Wed, 12 Oct 2016 11:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753781AbcJLLvO (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Oct 2016 07:51:14 -0400
Received: from mout.gmx.net ([212.227.15.15]:62070 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753558AbcJLLvM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2016 07:51:12 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0M3igT-1b3yQr1Ehd-00rJCl; Wed, 12 Oct 2016 13:49:28
 +0200
Date:   Wed, 12 Oct 2016 13:49:27 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 12/25] sequencer: remember the onelines when parsing
 the todo file
In-Reply-To: <xmqq1szmaemr.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1610121347361.3492@virtualbox>
References: <cover.1473590966.git.johannes.schindelin@gmx.de> <cover.1476120229.git.johannes.schindelin@gmx.de> <f22bdcda3f748813e6b9fd08dc65f11c6f9f4b1e.1476120229.git.johannes.schindelin@gmx.de> <xmqq1szmaemr.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:FQ319KQJQ8iK69lL0WyEWo+GUuaECCDtmcb9JspFX91ehTMsuVz
 PKKt2RKCWrXrkAcLsjRKk7W4jOT12d1lnfwbC6RZy2jpXIiUe3yapmWfULllQwZWZgZaaxm
 6FJXnCyec5uuwJ/jSeo0WeDgQnqw+vUzgiK63l6Ox7QG2A3zC0PgCkn8Wc4ZQAYscMNA7CV
 rVmth0QIANSGjE7tBX0XA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:uiquAF18KRE=:Aje7c9vvcXarnKDHGt7Yj7
 xq6nk5kyc8wnGRQrxDSCqSFBT5Wl1OUtMvIGsCxmloBh1o7sYBilMJPONcAdo3WF0x9E4KSj6
 x5JuAtfwjXI+bGC9ycFWOMZykRkmC+9Me9QdGxuRYiQozEpWmZ/veiNlmPIak+92dMhJdEWSv
 PHB9PBhdq9v/DKuQsQbKZripsNOXdBQPV3zmyoBTLkJugQJMIytK5rbzlaDOh4H92JV+vXbkB
 Tn4B+nrsmcKxzWn6rmqh9dGrCeXSKWIMkixdiKmu27XBS2mom4N3i4bXGz/6KEOMCiW+bLK4Q
 rRJKYV8/mrhzRejdczbnXaf17kMlxaFKc5tXV4iO3HTgbpO6So8Preau6QHLC1fNjGUJp7Q81
 n8xtjOVDkvt4tbMsohabi1jsF/p1SXlZVZ2B90OeGBsWUUpe/bt4v6ksD+miulgPzwFMmgT9q
 1YA4AW4Jckzf7Uh3DCXZkqYJWvKfrGzcMAoOXxI4IAtL3K8WVHWBhDZl4NE+hkCXPJBAU/Gtk
 3zS+DNwF0ok/C5so6gGg3R7JDyvPZHqdVcqH3mPknoLB7xHXM09tijdJATsaUTaB5VsLaB6/B
 wM58+qSPssbdPJD5IxKD0TyqSTmShHWX35G9uf881eIVc/qbvRG+y3gpg4LpblnTa+B+VwKdj
 vkYEkw1CLofoNhRsBib1Or2f4o/nROXERtlCZW023OfmSLx1i/kRhpco7pvhIyx/sba4Lrg4i
 9g4PB5PYJHvmCwtZqOla7PLJKc+aT/iCxRyvdniB37EBUWUYKkY2Yfu9atLnLbJbL1qUE7w0P
 eQDs/Q4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 11 Oct 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > diff --git a/sequencer.c b/sequencer.c
> > index afc494e..7ba5e07 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -708,6 +708,8 @@ static int read_and_refresh_cache(struct replay_opts *opts)
> >  struct todo_item {
> >  	enum todo_command command;
> >  	struct commit *commit;
> > +	const char *arg;
> > +	int arg_len;
> >  	size_t offset_in_buf;
> 
> micronit: you can make it to size_t and lose the cast below, no?

No. The primary users of arg_len call a printf() style function with %.*s,
expecting an int. So your suggestion would lose one cast, but introduce at
least four casts in return.

Ciao,
Dscho
