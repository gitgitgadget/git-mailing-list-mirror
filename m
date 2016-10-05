Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB63E1F4F8
	for <e@80x24.org>; Wed,  5 Oct 2016 12:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751803AbcJEMlq (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 08:41:46 -0400
Received: from mout.gmx.net ([212.227.17.21]:55883 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751392AbcJEMlp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 08:41:45 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LzGV3-1anmq22ThZ-014RbX; Wed, 05 Oct 2016 14:41:39
 +0200
Date:   Wed, 5 Oct 2016 14:41:38 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 17/25] sequencer: support amending commits
In-Reply-To: <xmqq8tuwztpd.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1610051437050.35196@virtualbox>
References: <cover.1472457609.git.johannes.schindelin@gmx.de> <cover.1473590966.git.johannes.schindelin@gmx.de> <68f995eaaad2448f5793f0030f96aa501b985ed5.1473590966.git.johannes.schindelin@gmx.de> <xmqq8tuwztpd.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:+nX//kNZ6pd9qtXDV3B9STceELW/mM21Tp5kg2oCeabjO92wCsK
 AVlsIQM5KDu4ztodqvH0zXEvXDCrsuFkVVjmjvJMA7SnsloIKKyS5UbqD8xYcUr1zNbkhBI
 hfTbqTy1JI+0VOZk+ilD0LTLsyHUAUa0PljtNuaeLVA2YT6knnBfvehKODU4BkMriZB1x+f
 XiBaAFG3fACdAGPEAH8sg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fqVfYkN/poM=:C63ksU+yPBRCt0zh5y+FNh
 ZE+eGtgzkgpodux170gLJ2yGBIuGRbFKiyL12vWuZpsztjBe8R9n5EkaW8ZXGwoCLldzC4t5v
 j8v7Pjlm3/Wcfde8TPEjGK3Q1s8tJE7t89AA++fZQZDatM8LZuUmo6qpBjcmfCh2kKiw1ESBY
 tsbccXOkU/K2E9xgGKIWR9N3Xz+32N9JllCuup5lW4d8INjPAXhdAKSQtg9NgKAJzgt1m84vu
 PE1El9MNif7O9+VUmeNiUKCKBXpqLsEKUpRmZsgkZt5OTh89EWptp3wWJcpVfhHoyQyej93Az
 b5si0CiArcq/ERP5f4ZLYPuC2444t1lZHNDADOSDBqt8RMfEPihiGJdkCWK5cWjAVyccUqeoH
 d21iFF0+XcQdf8LW/2FxZQx0V5psjkkenqjIUO81Ml0yDE3PCO0UFy1jmWLv7RZUeI0UXzRQG
 +8IfUOWQbPNtWyeegFKDlb3QCYt64iNWIhAwg46MEEeQmW2NVIvnnKJeBRjKbtNInKgd7BV6J
 wFKkxfqmG5YLQX7soJ1iEVQXNU9nSe4o7yRP1SQzBHVwRUgQC1TPHeytndZ+VQb935oXX17eA
 EaSQPGq+qWAH+pov50oZm2KthtBo5z6LEaOzwjxtSAKaBVx9IccNbCJcbTm0xcit1CEBJLqJ/
 AJHBD6yiAiwYZEi1MaUiExK2RjDfaOUthzhBX7by7DiqtVcY7HjAOlfoQh36RTyuuf6LSwbQ6
 /Q30c7HJlFanr/CO54/+bEQL7LZ5qnBjcyq2BnDV3uacQBRkMEz3vheq7TVv0E3LPQHKWbMxx
 /hQbTNa
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 12 Sep 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > This teaches the sequencer_commit() function to take an argument that
> > will allow us to implement "todo" commands that need to amend the commit
> > messages ("fixup", "squash" and "reword").
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  sequencer.c | 6 ++++--
> >  sequencer.h | 2 +-
> >  2 files changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/sequencer.c b/sequencer.c
> > index 6e9732c..60b522e 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -485,7 +485,7 @@ static char **read_author_script(void)
> >   * author metadata.
> >   */
> >  int sequencer_commit(const char *defmsg, struct replay_opts *opts,
> > -			  int allow_empty, int edit)
> > +			  int allow_empty, int edit, int amend)
> >  {
> >  	char **env = NULL;
> >  	struct argv_array array;
> > @@ -514,6 +514,8 @@ int sequencer_commit(const char *defmsg, struct replay_opts *opts,
> >  	argv_array_push(&array, "commit");
> >  	argv_array_push(&array, "-n");
> >  
> > +	if (amend)
> > +		argv_array_push(&array, "--amend");
> >  	if (opts->gpg_sign)
> >  		argv_array_pushf(&array, "-S%s", opts->gpg_sign);
> >  	if (opts->signoff)
> > @@ -786,7 +788,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
> >  	}
> >  	if (!opts->no_commit)
> >  		res = sequencer_commit(opts->edit ? NULL : git_path_merge_msg(),
> > -			opts, allow, opts->edit);
> > +			opts, allow, opts->edit, 0);
> >  
> >  leave:
> >  	free_message(commit, &msg);
> 
> Hmm, this is more about a comment on 18/25, but I suspect that
> "amend" or any opportunity given to the user to futz with the
> contents in the editor invites a wish for the result to be treated
> with stripspace.

The point of separating the cleanup_commit_message from the edit flag is
to allow final fixup commands to stripspace, even without letting the user
edit the message.

So while you are correct that "edit != 0" should imply
"cleanup_commit_message != 0", I would rather keep that explicit.

> No existing callers use "amend" to call this function, so there is
> no change in behaviour, but at the same time, we do not have enough
> information to see if 'amend' should by default toggle cleanup.

It should not. Non-final fixup/squash commands *need* to keep the
comment lines.

Keeping things explicit makes it easier to understand the flow, methinks.

Ciao,
Dscho
