Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B51E1F453
	for <e@80x24.org>; Wed, 31 Oct 2018 14:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729628AbeJaXse (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 19:48:34 -0400
Received: from mout.gmx.net ([212.227.17.21]:44749 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729570AbeJaXse (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 19:48:34 -0400
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MeQ43-1fv0RJ11tH-00QCvc; Wed, 31
 Oct 2018 15:50:02 +0100
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MeQ43-1fv0RJ11tH-00QCvc; Wed, 31
 Oct 2018 15:50:02 +0100
Date:   Wed, 31 Oct 2018 15:50:00 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: Re*: [PATCH v3] fetch: replace string-list used as a look-up
 table with a hashmap
In-Reply-To: <xmqqk1m3c2dz.fsf_-_@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1810311542560.4546@tvgsbejvaqbjf.bet>
References: <xmqqin2sj6df.fsf@gitster-ct.c.googlers.com> <20180927053418.GB14178@sigill.intra.peff.net> <xmqq5zyn91ku.fsf@gitster-ct.c.googlers.com> <xmqqy3au1tr1.fsf_-_@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1810221140510.4546@tvgsbejvaqbjf.bet>
 <xmqqk1m3c2dz.fsf_-_@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:BBJqOENHjjnQ/6sGNAQqC9FLmAFxPLRVCUoLH/t9WFXOkWiMhPT
 c+pVVDVFWgNum9JG/rOtcgp0hVuuLObswszASG8TTUkrbzDRzG4QyRfQPMaaZuGx5NVqA5Z
 6e6PaV0anRMArLfRW8pOX96M5z8hI5Gfjk5WqZYA+iulIOQJbzZa3v1FNsXOWXsFzOcKZPZ
 0Efpa9IIXLxptz+il8dlw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:oXYWHQ0XE+I=:pz7QoL3gUVw53+JmXb9do1
 zB3qP4/qDunzZJbf8uH1471BepDdAUiUDTDkMC95DQqaU7XMYg3eYCAzQkLAn27BGBu+gSVa+
 vQCEm6caAq7Utw4Up1ki+V68oDu4sWw7qiHR8z3Wa9wNFRXchk27Z8IgcMZ4sEtY87W1m4gbL
 h02OvulGEyccZCGUQmAnp7Ynhsg+WCE9fbheVvIyFJPMaj9I9HvQx0kl0hcoh7rI//q3RyvOb
 7YqDwd8QrdZYEr69rgkvlb9WM3dm4NI/6Z8eN01aDuoIYxOs3SQtGOqvjFjQSAh0WqnwyrAxH
 JxOVEIcvwRnbD2t32rFYZHiqbeKpG+FarfvEyR/xg5atw/d62qCXAULDdO158IilWVedf1i+p
 3YmsXndpk2MIL4pRTCvcm+ZSEPoLtDKW1p7pwdURg+/+vxYCcnJjf0MiSZIbKvC4FxOqr4Qgd
 tXlGpRtrWGp0UyWe8GCzbA+psmasZGhyoC/qloSe/H+kSJKqz4fmpv11bNpxgcw/1wHnyFUuU
 nqEojS5MIWiidrjXuxTVTbttH50SXt4VtTeFyP79S917hPAh7UtFsIh+xHIhF4bWtoPrJTgru
 cMYMtciYEnywfMKZ0aJ+wBjuBm3dKw/4XGstVB/kkhZjQBnBdxZhi3M+hIt+r7xz/FFSr75xN
 ln4c30oGcIYyIJGl2LCzKba0fKogJID/vRePr+f+x3J7/cWPJB1xrTDDGiUbBPXOeJgn12mbk
 M3lH/yew2OKKpbm1DOW3CByGu55tzluASBOZEpuEvUe6k3u/BhBiw5TwVhW/EK3Ubwd3f7T9E
 CQa4lVSm6T9LkFv4XaUqWwbssxHhbOXWeXrWvjwVM+V9ATyknI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sat, 27 Oct 2018, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Just one thing^W^Wa couple of things:
> >
> > It would probably make more sense to `hashmap_get_from_hash()` and
> > `strhash()` here (and `strhash()` should probably be used everywhere
> > instead of `memhash(str, strlen(str))`).
> 
> hashmap_get_from_hash() certainly is much better suited for simpler
> usage pattern like these callsites, and the ones in sequencer.c.  It
> is a shame that a more complex variant takes the shorter-and-sweeter
> name hashmap_get().

I agree, at least in part.

From what I understand, hashmap_get_from_hash() needs a little assistance
from the comparison function with which the hashmap is configured, see
e.g. this function in the sequencer:

	static int labels_cmp(const void *fndata, const struct labels_entry *a,
			      const struct labels_entry *b, const void *key)
	{
		return key ? strcmp(a->label, key) : strcmp(a->label, b->label);
	}

See how that first tests whether `key` is non-`NULL`, and then takes a
shortcut, not even looking at `b`? This is important, because `b` does not
refer to a complete `labels_entry` when we call `hashmap_get_from_hash()`.
It only refers to a `hashmap_entry`. Looking at `b->label` would access
some random memory, and do most certainly the wrong thing.

> I wish we named the latter hashmap_get_fullblown_feature_rich() and
> called the _from_hash() thing a simple hashmap_get() from day one,
> but it is way too late.
> 
> I looked briefly the users of the _get() variant, and some of their
> uses are legitimately not-simple and cannot be reduced to use the
> simpler _get_from_hash variant, it seems.  But others like those in
> builtin/difftool.c should be straight-forward to convert to use the
> simpler get_from_hash variant.  It could be a low-hanging fruit left
> for later clean-up, perhaps.

Right. #leftoverbits

> >> @@ -271,10 +319,10 @@ static void find_non_local_tags(const struct ref *refs,
> >>  			    !has_object_file_with_flags(&ref->old_oid,
> >>  							OBJECT_INFO_QUICK) &&
> >>  			    !will_fetch(head, ref->old_oid.hash) &&
> >> -			    !has_sha1_file_with_flags(item->util,
> >> +			    !has_sha1_file_with_flags(item->oid.hash,
> >
> > I am not sure that we need to test for null OIDs here, given that...
> > ...
> > Of course, `has_sha1_file_with_flags()` is supposed to return `false` for
> > null OIDs, I guess.
> 
> Yup.  An alternative is to make item->oid a pointer to oid, not an
> oid object itself, so that we can express "no OID for this ref" in a
> more explicit way, but is_null_oid() is already used as "no OID" in
> many other codepaths, so...

Right, and it would complicate the code. So I am fine with your version of
it.

> >> +	for_each_string_list_item(remote_ref_item, &remote_refs_list) {
> >> +		const char *refname = remote_ref_item->string;
> >> +		struct hashmap_entry key;
> >> +
> >> +		hashmap_entry_init(&key, memhash(refname, strlen(refname)));
> >> +		item = hashmap_get(&remote_refs, &key, refname);
> >> +		if (!item)
> >> +			continue; /* can this happen??? */
> >
> > This would indicate a BUG, no?
> 
> Possibly.  Alternatively, we can just use item without checking and
> let the runtime segfault.

Hahaha! Yep. We could also cause a crash. I do prefer the BUG() call.

> Here is an incremental on top that can be squashed in to turn v3
> into v4.

Nice.

Thanks!
Dscho

> 
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 0f8e333022..aee1d9bf21 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -259,7 +259,7 @@ static struct refname_hash_entry *refname_hash_add(struct hashmap *map,
>  	size_t len = strlen(refname);
>  
>  	FLEX_ALLOC_MEM(ent, refname, refname, len);
> -	hashmap_entry_init(ent, memhash(refname, len));
> +	hashmap_entry_init(ent, strhash(refname));
>  	oidcpy(&ent->oid, oid);
>  	hashmap_add(map, ent);
>  	return ent;
> @@ -282,11 +282,7 @@ static void refname_hash_init(struct hashmap *map)
>  
>  static int refname_hash_exists(struct hashmap *map, const char *refname)
>  {
> -	struct hashmap_entry key;
> -	size_t len = strlen(refname);
> -	hashmap_entry_init(&key, memhash(refname, len));
> -
> -	return !!hashmap_get(map, &key, refname);
> +	return !!hashmap_get_from_hash(map, strhash(refname), refname);
>  }
>  
>  static void find_non_local_tags(const struct ref *refs,
> @@ -365,12 +361,10 @@ static void find_non_local_tags(const struct ref *refs,
>  	 */
>  	for_each_string_list_item(remote_ref_item, &remote_refs_list) {
>  		const char *refname = remote_ref_item->string;
> -		struct hashmap_entry key;
>  
> -		hashmap_entry_init(&key, memhash(refname, strlen(refname)));
> -		item = hashmap_get(&remote_refs, &key, refname);
> +		item = hashmap_get_from_hash(&remote_refs, strhash(refname), refname);
>  		if (!item)
> -			continue; /* can this happen??? */
> +			BUG("unseen remote ref?");
>  
>  		/* Unless we have already decided to ignore this item... */
>  		if (!is_null_oid(&item->oid)) {
> @@ -497,12 +491,12 @@ static struct ref *get_ref_map(struct remote *remote,
>  
>  	for (rm = ref_map; rm; rm = rm->next) {
>  		if (rm->peer_ref) {
> -			struct hashmap_entry key;
>  			const char *refname = rm->peer_ref->name;
>  			struct refname_hash_entry *peer_item;
>  
> -			hashmap_entry_init(&key, memhash(refname, strlen(refname)));
> -			peer_item = hashmap_get(&existing_refs, &key, refname);
> +			peer_item = hashmap_get_from_hash(&existing_refs,
> +							  strhash(refname),
> +							  refname);
>  			if (peer_item) {
>  				struct object_id *old_oid = &peer_item->oid;
>  				oidcpy(&rm->peer_ref->old_oid, old_oid);
> 
