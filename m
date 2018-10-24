Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72E501F453
	for <e@80x24.org>; Wed, 24 Oct 2018 15:56:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbeJYAZ0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 20:25:26 -0400
Received: from mout.gmx.net ([212.227.15.15]:35321 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726685AbeJYAZ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 20:25:26 -0400
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M2cYX-1fPqxw2FZV-00sRUk; Wed, 24
 Oct 2018 17:56:41 +0200
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M2cYX-1fPqxw2FZV-00sRUk; Wed, 24
 Oct 2018 17:56:41 +0200
Date:   Wed, 24 Oct 2018 17:56:45 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jonathan Tan <jonathantanmy@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 2/3] shallow: offer to prune only non-existing
 entries
In-Reply-To: <nycvar.QRO.7.76.6.1810240941230.4546@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.1810241756390.4546@tvgsbejvaqbjf.bet>
References: <pull.9.v2.git.gitgitgadget@gmail.com> <pull.9.v3.git.gitgitgadget@gmail.com> <f085eb4f728f5cd102f56b7a90ce9b10fdb59dee.1540245934.git.gitgitgadget@gmail.com> <xmqqmur4ovjt.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1810240941230.4546@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:bNkNH8F3holqe4bd5EdmY2JfA8abROhP4dxrXJ1H89vSlRBbubk
 e+Uuc4cj/uCASR8Vn7JSuoLqX/wqKl8r0wSEGPk8HiQObZ7zQ4CrQNMGRI+tT3mkbSwaLBO
 ubjsJUA1Sk00AtsJsZTADbqwos1WvDTkKEs8vcD2dnVUYAATrcr0oVJgSXoNDWeGtg48t1G
 +jK6lZcQyqdjpm/j337kQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GH/F/Pii+Zo=:EIkDqnppZngejIe+21hAym
 cp39u621y7pe+dtsma6E46PtVnacuel1jZlDBM4/nR2YMKNK5TqBCtWdYy5gOLPZ5k4B9W9hO
 /RwyYXOmtHthYROKuqXTz2pB1VZgsp4ADQTHZ/rM7IYr9joa8ON+hvdoC6C1WfOWFaDw2FT9W
 O/KqHuWdYUgc6UoZ9oKxjfmUMLEiiPUGPEQOx5EHojVeVvscmGBHEIFtgfY7XDEPY7yQ3qrrr
 zRX7vElrVggN91j/FEJv1BvGj3VOgk16EnjTfLaALhaEfTi7/PLsoEDoIo+o9y9w/ieEXDZi6
 nnDg2zO2pT3Y0OHyvHA20xzEkw60XZOA3kg1iotZZ2iqC+5Y7LuP/APMFwbkGpTiw4yHQGFQG
 ewj7RUAT++9rHKBvTq+whXS89X0Yv5u7SSJZT0uEvwsCGshoE0e6Z1ALR3pmUe9HSMgX5qPPS
 dHhQB93Dk1aUxrHjBBY6QxN9SJEocxnAYrxWFhnrIWoWB1i+IXo05+oi7B99RvumPUJViMtfN
 8LtpNa6W8lbF7oZsS3LfdZUnlP9xsBr5B9Ix5UZnrHHbJwk5+mxQsTps60DwF+3tmIDu8INKy
 3DNKSotGpg/NzEKmztv5Lf+n+b7vHLrwFF9MYWKVClaJIM9OtpyS8nksgMLsXHs6XIrt4/kVS
 Ycbt9NVIVDH2/0OFqbF6ysdeLKyvapTXd+kE5HqElfN8iaKQraAJqsUDJRBPcFN0SopiERnlc
 lUHlBilLVZ5LUHkTc32EuyRLESk0JWQcX5+pQIe1KVP7dh/8pnQrZmP88AvZHnkGIZki9bDif
 d27TzoMkCZ12Li6xIRlAHJkBhspKOCtSMO25KEB33iXShI1/EA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, 24 Oct 2018, Johannes Schindelin wrote:

> On Wed, 24 Oct 2018, Junio C Hamano wrote:
> 
> > Jonathan, do you see any issues with the use of lookup_commit() in
> > this change wrt lazy clone?  I am wondering what happens when the
> > commit in question is at, an immediate parent of, or an immediate
> > child of a promisor object.  I _think_ this change won't make it
> > worse for two features in playing together, but thought that it
> > would be better to double check.
> 
> Good point.
> 
> Instinctively, I would say that no promised object can be a shallow
> commit. The entire idea of a shallow commit is that it *is* present, but
> none of its parents.
> 
> Also, I would claim that the shallow feature does not make sense with lazy
> clones, as lazy clones offer a superset of shallow clone's functionality.
> 
> However, I am curious whether there is a better way to check for the
> presence of a local commit? Do we have an API function for that, that I
> missed? (I do not really want to parse the commit, after all, just verify
> that it is not pruned.)

Okay, I looked around a bit. It seems that there is an
`is_promisor_object(oid)` function in `pu` to see whether an object was
promised. If need be (and I am still not convinced that there is a need),
then we can always add a call to that function to the condition.

Coming back to my question whether there is a better way to check for the
presence of a local commit, I figured that I can use `has_object_file()`
instead of looking up and parsing the commit, as this code does not really
need to verify that the shallow entry refers to a commit, but only that it
refers to a local object.

So I'll send another iteration shortly, with this diff applied to 2/3:

-- snip --
diff --git a/shallow.c b/shallow.c
index 9c3faa8af243..02fdbfc554c4 100644
--- a/shallow.c
+++ b/shallow.c
@@ -263,8 +263,7 @@ static int write_one_shallow(const struct commit_graft *graft, void *cb_data)
 	if (graft->nr_parent != -1)
 		return 0;
 	if (data->flags & QUICK) {
-		struct commit *c = lookup_commit(the_repository, &graft->oid);
-		if (!c || parse_commit(c))
+		if (!has_object_file(&graft->oid))
 			return 0;
 	} else if (data->flags & SEEN_ONLY) {
 		struct commit *c = lookup_commit(the_repository, &graft->oid);
--snap --

Ciao,
Dscho

> 
> > 
> > "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> > writes:
> > 
> > > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> > >
> > > The `prune_shallow()` function wants a full reachability check to be
> > > completed before it goes to work, to ensure that all unreachable entries
> > > are removed from the shallow file.
> > >
> > > However, in the upcoming patch we do not even want to go that far. We
> > > really only need to remove entries corresponding to pruned commits, i.e.
> > > to commits that no longer exist.
> > >
> > > Let's support that use case.
> > >
> > > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > > ---
> > >  builtin/prune.c |  2 +-
> > >  commit.h        |  2 +-
> > >  shallow.c       | 22 +++++++++++++++++-----
> > >  3 files changed, 19 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/builtin/prune.c b/builtin/prune.c
> > > index 41230f821..6d6ab6cf1 100644
> > > --- a/builtin/prune.c
> > > +++ b/builtin/prune.c
> > > @@ -161,7 +161,7 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
> > >  	free(s);
> > >  
> > >  	if (is_repository_shallow(the_repository))
> > > -		prune_shallow(show_only);
> > > +		prune_shallow(show_only, 0);
> > >  
> > >  	return 0;
> > >  }
> > > diff --git a/commit.h b/commit.h
> > > index 1d260d62f..ff34447ab 100644
> > > --- a/commit.h
> > > +++ b/commit.h
> > > @@ -249,7 +249,7 @@ extern void assign_shallow_commits_to_refs(struct shallow_info *info,
> > >  					   uint32_t **used,
> > >  					   int *ref_status);
> > >  extern int delayed_reachability_test(struct shallow_info *si, int c);
> > > -extern void prune_shallow(int show_only);
> > > +extern void prune_shallow(int show_only, int quick_prune);
> > >  extern struct trace_key trace_shallow;
> > >  
> > >  extern int interactive_add(int argc, const char **argv, const char *prefix, int patch);
> > > diff --git a/shallow.c b/shallow.c
> > > index 732e18d54..0a2671bc2 100644
> > > --- a/shallow.c
> > > +++ b/shallow.c
> > > @@ -247,6 +247,7 @@ static void check_shallow_file_for_update(struct repository *r)
> > >  
> > >  #define SEEN_ONLY 1
> > >  #define VERBOSE   2
> > > +#define QUICK_PRUNE 4
> > >  
> > >  struct write_shallow_data {
> > >  	struct strbuf *out;
> > > @@ -261,7 +262,11 @@ static int write_one_shallow(const struct commit_graft *graft, void *cb_data)
> > >  	const char *hex = oid_to_hex(&graft->oid);
> > >  	if (graft->nr_parent != -1)
> > >  		return 0;
> > > -	if (data->flags & SEEN_ONLY) {
> > > +	if (data->flags & QUICK_PRUNE) {
> > > +		struct commit *c = lookup_commit(the_repository, &graft->oid);
> > > +		if (!c || parse_commit(c))
> > > +			return 0;
> > > +	} else if (data->flags & SEEN_ONLY) {
> > >  		struct commit *c = lookup_commit(the_repository, &graft->oid);
> > >  		if (!c || !(c->object.flags & SEEN)) {
> > >  			if (data->flags & VERBOSE)
> > > @@ -371,16 +376,23 @@ void advertise_shallow_grafts(int fd)
> > >  
> > >  /*
> > >   * mark_reachable_objects() should have been run prior to this and all
> > > - * reachable commits marked as "SEEN".
> > > + * reachable commits marked as "SEEN", except when quick_prune is non-zero,
> > > + * in which case lines are excised from the shallow file if they refer to
> > > + * commits that do not exist (any longer).
> > >   */
> > > -void prune_shallow(int show_only)
> > > +void prune_shallow(int show_only, int quick_prune)
> > >  {
> > >  	struct lock_file shallow_lock = LOCK_INIT;
> > >  	struct strbuf sb = STRBUF_INIT;
> > > +	unsigned flags = SEEN_ONLY;
> > >  	int fd;
> > >  
> > > +	if (quick_prune)
> > > +		flags |= QUICK_PRUNE;
> > > +
> > >  	if (show_only) {
> > > -		write_shallow_commits_1(&sb, 0, NULL, SEEN_ONLY | VERBOSE);
> > > +		flags |= VERBOSE;
> > > +		write_shallow_commits_1(&sb, 0, NULL, flags);
> > >  		strbuf_release(&sb);
> > >  		return;
> > >  	}
> > > @@ -388,7 +400,7 @@ void prune_shallow(int show_only)
> > >  				       git_path_shallow(the_repository),
> > >  				       LOCK_DIE_ON_ERROR);
> > >  	check_shallow_file_for_update(the_repository);
> > > -	if (write_shallow_commits_1(&sb, 0, NULL, SEEN_ONLY)) {
> > > +	if (write_shallow_commits_1(&sb, 0, NULL, flags)) {
> > >  		if (write_in_full(fd, sb.buf, sb.len) < 0)
> > >  			die_errno("failed to write to %s",
> > >  				  get_lock_file_path(&shallow_lock));
> > 
> 
