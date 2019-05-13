Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,RCVD_IN_SBL_CSS shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE2CE1F461
	for <e@80x24.org>; Mon, 13 May 2019 12:48:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729550AbfEMMsq (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 08:48:46 -0400
Received: from mout.gmx.net ([212.227.17.21]:56415 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727690AbfEMMsq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 May 2019 08:48:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1557751715;
        bh=sneaKpN8n0381QKPWTRd9fMw4jpvh8t+b8AABCymKyQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=TIyH4sne4ZqNNj0SPz7NWn0cX39As3x9cz1w3cAVlBbpnqGL7oFOXyLXiIlBSyqE9
         BXtUtlnKzKcKLS45kaAHX5lDbYViOwluBo+Pvl8/lstirf+2CzS6MOG3gSaLoU1xFL
         Ia96/2BvrrDXDDmuaqE6pMwuoGbzikCjlCw8Nz7M=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LcWSI-1h1Vvp1asA-00jpnB; Mon, 13
 May 2019 14:48:35 +0200
Date:   Mon, 13 May 2019 14:48:18 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff Hostetler <git@jeffhostetler.com>
cc:     Slavica Djukic via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Slavica Djukic <slawica92@hotmail.com>
Subject: Re: [PATCH 07/11] Add a function to determine unique prefixes for
 a list of strings
In-Reply-To: <1be9b470-6daa-a50e-ba3a-432520721b0f@jeffhostetler.com>
Message-ID: <nycvar.QRO.7.76.6.1905131405210.44@tvgsbejvaqbjf.bet>
References: <pull.170.git.gitgitgadget@gmail.com> <db1ede363645b0620d4924639efe5ec708441aa7.1554917868.git.gitgitgadget@gmail.com> <1be9b470-6daa-a50e-ba3a-432520721b0f@jeffhostetler.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:pmg4upII24GmpukKykLzAAa701RpObvPsX6N0d6+df8Fc7fJv5/
 bI5o+aPlIEAdmdVMoUlGNe+F358jgSlg7Zamu386RW0VuoSy48+xbCD7Yc19pkIphiGK9XF
 r2EG0hm+w4fi424sFIYQL1GQH94MM4HuWlIFS7QZn4uWHSYSVEy3JopF/bUaaEjinGsrhWx
 phz8I/GCITyuhQooFN6JQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JVRz3RvBIao=:PyTv5XbfslWaghyCcYyQG7
 /zEhHPN+8pYNMFJvfKKuiYjrW7PKB24saIT9VUqYc/7OPjduORdFzX+WCn3pOxbSLUQNo9T3Q
 tK0ectKXG/h8D29vYPs0jXUj2Ey+75ua6mmFL2nZDvXvKnD1u4tH54QT+vkW8li7b1FgwsaBB
 eyKqYBL+BSmwALYtzq3js1hz1MYP60hA+mnoY1EVLqRvNH0Hp3DeYzZNmJq12fUQLZ3mUCkn4
 AwT89YCFrSOdwc36PbSNWHzF0reJbXdOpluzHaVdM49YqoArB35IKlRLIBhJyU0rb3ie/SS1E
 gkVLP1rR3jTY+fZFVHVs3awhdV7ZM1+jCUBPxnN/BHXzr9/UpDFC0EwheJsw2XknYWFPAnISl
 BgUyAAeKez15vM/x2lOjm6eGAUBmdfAADlUXeJHqfb2VwabAKga0l4HnCB80ilWwWWCXoVMvJ
 7MQZGHYEglZGQ6grBYvXUkrjuLPSPNDMiuGyfsojqr7KQVwtcbYvABRTYa3lMt/i9gX3UQ7+G
 iZwh3oVGZHMiJsfFeuJ2ILjvdQi4Oi2xkk91NbcyRIBgxKmWKcA6GhqKvLdbf6e+pqfwxQGgd
 ivFMw4+YxU/H4/wDllKEa/1MbWfF5edGuIRsRltngxTsviqLZv3jlarYYYwkIite8zY2KxvdX
 F894fJ920MutRvmaJVW1VPiz5cBAhSIqKoyYGFGMmh1i3qIDx5u96DaEiH2BoVpGwhKukK0at
 yXR9tg0MFiWZxCHqKJu4DkbrjWaY0JTxkeJTuUCxZYBBHeQCQ3BIW+IYmZKU1yQ0F3D6M5bJq
 HqKd4PsmhXGo+W1adsiM0wSMNV5as7CnMxHUnYbZeZpoSu09TXb+xo5z20XDz76Yad64vmdZF
 6D8edvtS42llOQvHWlJ0Salef/u1mjdEbh1xpHkwKjW0DD7VD67qWXnzmbypjfvrGuRZhv42X
 UHnP8f26NYw==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeff,

On Thu, 18 Apr 2019, Jeff Hostetler wrote:

> On 4/10/2019 1:37 PM, Slavica Djukic via GitGitGadget wrote:
> > From: Slavica Djukic <slawica92@hotmail.com>
> >
> > In the `git add -i` command, we show unique prefixes of the commands a=
nd
> > files, to give an indication what prefix would select them.
> >
> > Naturally, the C implementation looks a lot different than the Perl
> > implementation: in Perl, a trie is much easier implemented, while we
> > already have a pretty neat hashmap implementation in C that we use for
> > the purpose of storing (not necessarily unique) prefixes.
> >
> > The idea: for each item that we add, we generate prefixes starting wit=
h
> > the first letter, then the first two letters, then three, etc, until w=
e
> > find a prefix that is unique (or until the prefix length would be
> > longer than we want). If we encounter a previously-unique prefix on th=
e
> > way, we adjust that item's prefix to make it unique again (or we mark =
it
> > as having no unique prefix if we failed to find one). These partial
> > prefixes are stored in a hash map (for quick lookup times).
> >
> > To make sure that this function works as expected, we add a test using=
 a
> > special-purpose test helper that was added for that purpose.
> >
> > Note: We expect the list of prefix items to be passed in as a list of
> > pointers rather than as regular list to avoid having to copy informati=
on
> > (the actual items will most likely contain more information than just
> > the name and the length of the unique prefix, but passing in `struct
> > prefix_item *` would not allow for that).
> >
> > Signed-off-by: Slavica Djukic <slawica92@hotmail.com>
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> > diff --git a/prefix-map.c b/prefix-map.c
> > new file mode 100644
> > index 0000000000..3c5ae4ae0a
> > --- /dev/null
> > +++ b/prefix-map.c
> > @@ -0,0 +1,111 @@
> > +#include "cache.h"
> > +#include "prefix-map.h"
> > +
> > +static int map_cmp(const void *unused_cmp_data,
> > +		   const void *entry,
> > +		   const void *entry_or_key,
> > +		   const void *unused_keydata)
> > +{
> > +	const struct prefix_map_entry *a =3D entry;
> > +	const struct prefix_map_entry *b =3D entry_or_key;
> > +
> > +	return a->prefix_length !=3D b->prefix_length ||
> > +		strncmp(a->name, b->name, a->prefix_length);
> > +}
> > +
> > +static void add_prefix_entry(struct hashmap *map, const char *name,
> > +			     size_t prefix_length, struct prefix_item *item)
> > +{
> > +	struct prefix_map_entry *result =3D xmalloc(sizeof(*result));
> > +	result->name =3D name;
> > +	result->prefix_length =3D prefix_length;
> > +	result->item =3D item;
> > +	hashmap_entry_init(result, memhash(name, prefix_length));
> > +	hashmap_add(map, result);
> > +}
> > +
> > +static void init_prefix_map(struct prefix_map *prefix_map,
> > +			    int min_prefix_length, int max_prefix_length)
> > +{
> > +	hashmap_init(&prefix_map->map, map_cmp, NULL, 0);
> > +	prefix_map->min_length =3D min_prefix_length;
> > +	prefix_map->max_length =3D max_prefix_length;
> > +}
> > +
> > +static void add_prefix_item(struct prefix_map *prefix_map,
> > +			    struct prefix_item *item)
> > +{
> > +	struct prefix_map_entry *e =3D xmalloc(sizeof(*e)), *e2;
> > +	int j;
> > +
> > +	e->item =3D item;
> > +	e->name =3D e->item->name;
> > +
> > +	for (j =3D prefix_map->min_length; j <=3D prefix_map->max_length; j+=
+) {
> > +		if (!isascii(e->name[j])) {
>
> This feels odd, if I understand the intent.
>
> First, why "isascii()" rather than just non-zero?

That's to imitate `git-add--interactive.perl`'s

	if (ord($letters[0]) > 127 ||
	    ($soft_limit && $j + 1 > $soft_limit))

See https://github.com/git/git/blob/v2.21.0/git-add--interactive.perl#L410
for more complete context.

I think the main benefit here is that we avoid running into the trap of
using incomplete UTF-8 multi-byte sequences in prefixes.

I guess we could throw in an extra safety on the C side by excluding
control characters, too. But that would be a deviation from Perl, and I
actually do not even feel strongly about excluding, say, a HT (horizontal
tab) from the prefixes.

> But mainly, can we walk off the end of the array and read
> potentially uninitialized memory?  Shouldn't we have something
> at the top of the function like:
>
>     len =3D strlen(item->name);
>     if (len < prefix_map->min_length)
>         return;

Ooops, you're right. But I would not use `strlen() here, we can easily
just add `&& e->name[j]` to the loop condition.

> (And maybe avoid the xmalloc() too?)

Hmm. At first, I thought: no, we use `*e` *both* for lookup and for adding
a new item once we did not find any existing for the current prefix
length.

But it does indeed become a lot clearer when I separate those. It's not
even performance or memory critical a code path.

> And maybe do " j <=3D min(len, max_length) " in the loop?
> But I see you're modifying "j" down in the body of the loop,
> so I'll wait on suggesting that.
>
> > +			free(e);
> > +			break;
> > +		}
> > +
> > +		e->prefix_length =3D j;
> > +		hashmap_entry_init(e, memhash(e->name, j));
> > +		e2 =3D hashmap_get(&prefix_map->map, e, NULL);
> > +		if (!e2) {
> > +			/* prefix is unique so far */
> > +			e->item->prefix_length =3D j;
> > +			hashmap_add(&prefix_map->map, e);
> > +			break;
> > +		}
> > +
> > +		if (!e2->item)
> > +			continue; /* non-unique prefix */
> > +
> > +		if (j !=3D e2->item->prefix_length)
> > +			BUG("unexpected prefix length: %d !=3D %d",
> > +			    (int)j, (int)e2->item->prefix_length);
>
> IIUC, this assurance comes directly from map_cmp(), right?
> We could strengthen this to
>      (j !=3D e2->item->prefix_length || strncmp(...))
> if we wanted to, right?

Right, I'll actually go for `memcmp()` here, but the idea is the same.

> > +
> > +		/* skip common prefix */
> > +		for (; j < prefix_map->max_length && e->name[j]; j++) {
> > +			if (e->item->name[j] !=3D e2->item->name[j])
> > +				break;
>
> Same comment here about walking off of the defined end of both arrays.

Actually, no, not here, as I already test for `e->name[j]` in the loop
condition. If we reach the end of `e2->item->name`, the inner condition
will break out of the loop.

> I'm going to stop here.  I'm getting confused.

Oh no ;-)

Thank you for your helpful comments!

Ciao,
Dscho
