Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D8361FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 13:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754903AbcLSNhb (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 08:37:31 -0500
Received: from mout.gmx.net ([212.227.17.20]:56131 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753514AbcLSNh3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 08:37:29 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M2XkX-1cYzXd3Ae5-00sOtU; Mon, 19
 Dec 2016 14:37:16 +0100
Date:   Mon, 19 Dec 2016 14:37:14 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v2 02/34] sequencer (rebase -i): implement the 'noop'
 command
In-Reply-To: <xmqqfulr1s5z.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1612191436100.54750@virtualbox>
References: <cover.1472633606.git.johannes.schindelin@gmx.de>        <cover.1481642927.git.johannes.schindelin@gmx.de>        <934c8e420cc4a75b1f3e4489fa4a4135c48f78ae.1481642927.git.johannes.schindelin@gmx.de>
 <xmqqfulr1s5z.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:yYedwJv0sd2ao3T4NXAcDd755pkmb3h9aRAe+oqiIbR/mvjZJce
 6AjSG0paTeaNx3enJXPXFBFZIsIKXPaYJVSrN4NfoGS68SGHyBlsVLbWLXI4CtERU8btcng
 SL+rycwiwGBivTorwhNsQslpSbP5FC98Mxu3DujtX+rarJbX1/xF0owsrEsdq1+F9vWjL+2
 9FatueeqIzEITFo40+jOA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2CXQsaBMWL0=:Q9QHRjJbT0WC+Zvd2vXmDj
 /iVTcxi33sZ2aKAvS05+OYIDmdU4QQFkUyWAwQIjeR6jwhEDzPL1n92Keyxxx5r1i+o53UyZm
 IaExhPZ7FJkeo4JxldXd/KK6ik4gspefUHx9SPZuXb1hM0VQFycnCMfzhcajSGkFsLTAbYWz6
 Uox4tmNZQ0pYOn4Y7mpuRMqL7J3a9AywP3YAC86mSVXSfU/vpC2SkjaeBzULKkZhQhFao5/kX
 USHG4TIelro7oc3c75EiHQNG1nN9AMAjT7sjtZzRANIQhKRlaokEFlMrRFqHiHJFlv9Jnui1B
 o669dWejeSOV811Vd6l6Gmr2cjXAbudPAhURfU7FQlRp7QczrPsc/2ELKu0W3eNo+C1NngGv+
 CZ7T6iuyMovKa1TpM5uEawXXP9+WLsgkgq2Z1vahkqYuITq9mHZi5HhcShXDqQ8nke3twDQPG
 ymuH1GUUs0eKAuJO9o03Gd4fUfKeSA9S1/o9ZVBJZn/ccE5cUWBUXaTdR+HyW//d2KPml3ZIM
 TTRs98dT0WevPgxYd2CpqscxLujzZHrJducK5udeQG/+RPkCUhJzvk1RpC8lLhB1FRef+bWIV
 mf2fQ2dO6BnvhnIaZOKAZELkFG9Q80YKNL/E8ELMZCEPcfJMEHZFx6v313BWZ84WfzNTWB1eP
 GDA9tD7CqIZK1VA6v8jwQOk7TFgLDdrIbfHGYgPCIgNu8Erxg/7c3/cJraG/QZx04OEnyR1H/
 kgAZhetom/VWe/MUkSHtP7akGDaj0q8Dcg888jRwjye7mRScoafGrA6vzvM2tNwrkRV2oDaPe
 WmIP/sn
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 13 Dec 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > @@ -1292,7 +1316,12 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
> >  		struct todo_item *item = todo_list->items + todo_list->current;
> >  		if (save_todo(todo_list, opts))
> >  			return -1;
> > -		res = do_pick_commit(item->command, item->commit, opts);
> > +		if (item->command <= TODO_REVERT)
> > +			res = do_pick_commit(item->command, item->commit,
> > +					opts);
> > +		else if (item->command != TODO_NOOP)
> > +			return error(_("unknown command %d"), item->command);
> 
> I wonder if making this a switch() statement is easier to read in
> the longer run.  The only thing at this point we are gaining by "not
> only mapping and enum must match, the orders matter" is so that this
> codepath can do the same thing for PICK and REVERT, but these two
> would become more and more minority as we learn more words.

I doubt that this is easier to read. There are essentially three
categories we are handling: exec, comments, and everything else. IMO the
current code is the easiest to understand.

Ciao,
Dscho
