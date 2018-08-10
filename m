Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7E2B1F404
	for <e@80x24.org>; Fri, 10 Aug 2018 15:52:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbeHJSWf (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 14:22:35 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:33338 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727542AbeHJSWf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 14:22:35 -0400
Received: by mail-it0-f67.google.com with SMTP id d16-v6so5049531itj.0
        for <git@vger.kernel.org>; Fri, 10 Aug 2018 08:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A09J8xj0pny06G22r9n9CcqgW78DRmbUk9le1N31Tbw=;
        b=mnf64zBZA76UUdRYAT+xBM7d9bewSsZjAvNDFssgVAUN9LywAChnVfW3nmUFZMOuXC
         ZjwV19t4wK6nj2RzyqGegwdb8+3kdtqCOwRoc/M7hl5djt1Ff/aFRiEQUxLwY2ZkuIy2
         TRwm/Fn20DGSSz7z6teAc+VzoEYvKTHGOeh9DEHKxKWH44cGpAbknr8iB/x5HmBQvvNe
         1xg6VgtZvV4gZi5ZXpzPpDnEpYUX8NSFCjhM4wDE9nb8DVOPwxDhcuH6ff0nkX8hYwx9
         V4WwEQFnZ+tvvf0ppzUCnQNaQCVrxO8/Dh112CMqXIKdtPaUbS+wf8deI6cZKPwTJrNi
         nuxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A09J8xj0pny06G22r9n9CcqgW78DRmbUk9le1N31Tbw=;
        b=joSS7Mfw1O47/qU+B1AJg0o3xqX9WPmRzhliWqnD9QEO8EXA/4u0R2aCt+HRK+Age7
         tpt2xjwYohiCyUrO+jyLwMJwSw4VIblFep03A+JKtsto/3Z47xxUKOydx563uoiba8ZL
         OOYZ3RiANGcWk0EOeYXIIQcY+HgAmktZiDoJYP4qkfHfWSXRVhPJM01fH5gdAgND4SJu
         J8IO3VpLlggYvc2qyPNMOVSBU2cGOK+8msi+cTjD+vEPLtO6/GjsyBLscieNx8QWsKdY
         s9lvzhMqB+PSNhnOxwF8WIX3lfZ3ChOK2coyNKOcixoTx7IEUc63DlhXiuYH0qg4UI4J
         vDGw==
X-Gm-Message-State: AOUpUlFSm7UjOidNCdGt0FqLVyOSFADgVqydb9R1oVzPY63v5UJ40e+I
        fblEp63KpjNZk8MnGnpdiiu7tcdKCvAestlYynU=
X-Google-Smtp-Source: AA+uWPxKK2uTaugx4r37+ioPW3z4bgTpgy3rJPKI4ChROuCnd4/ueIpxSObZT4jez0ktScZfJw8KIP+MpXdNhkNxeNk=
X-Received: by 2002:a24:b101:: with SMTP id o1-v6mr2539731itf.121.1533916329415;
 Fri, 10 Aug 2018 08:52:09 -0700 (PDT)
MIME-Version: 1.0
References: <20180727154241.GA21288@duynguyen.home> <20180729103306.16403-1-pclouds@gmail.com>
 <9a9a309c-7143-e642-cfd8-6df76e77995a@gmail.com> <CACsJy8BUBjPngHz=icHomor-LJOkMLwZ9bQ6YJDxnoXGg++vjg@mail.gmail.com>
 <cc3c4dbb-d545-6a6c-b20e-6a8ca66fc210@gmail.com> <57d146a2-9bf8-66c9-9cb4-c05f93b63319@gmail.com>
 <20180801163830.GA31968@duynguyen.home> <ccec34c9-b81a-bcb4-7d05-48dccc059cc8@gmail.com>
In-Reply-To: <ccec34c9-b81a-bcb4-7d05-48dccc059cc8@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 10 Aug 2018 17:51:43 +0200
Message-ID: <CACsJy8B9=HL3mnBVuPEmAR=ukCysxGtpAbr3KY-duL7cQ4D=CQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Speed up unpack_trees()
To:     Ben Peart <peartben@gmail.com>
Cc:     Ben Peart <Ben.Peart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 8, 2018 at 10:53 PM Ben Peart <peartben@gmail.com> wrote:
>
>
>
> On 8/1/2018 12:38 PM, Duy Nguyen wrote:
> > On Tue, Jul 31, 2018 at 01:31:31PM -0400, Ben Peart wrote:
> >>
> >>
> >> On 7/31/2018 12:50 PM, Ben Peart wrote:
> >>>
> >>>
> >>> On 7/31/2018 11:31 AM, Duy Nguyen wrote:
> >>
> >>>>
> >>>>> In the performance game of whack-a-mole, that call to repair cache-tree
> >>>>> is now looking quite expensive...
> >>>>
> >>>> Yeah and I think we can whack that mole too. I did some measurement.
> >>>> Best case possible, we just need to scan through two indexes (one with
> >>>> many good cache-tree, one with no cache-tree), compare and copy
> >>>> cache-tree over. The scanning takes like 1% time of current repair
> >>>> step and I suspect it's the hashing that takes most of the time. Of
> >>>> course real world won't have such nice numbers, but I guess we could
> >>>> maybe half cache-tree update/repair time.
> >>>>
> >>>
> >>> I have some great profiling tools available so will take a look at this
> >>> next and see exactly where the time is being spent.
> >>
> >> Good instincts.  In cache_tree_update, the heavy hitter is definitely
> >> hash_object_file followed by has_object_file.
> >>
> >> Name                                 Inc %        Inc
> >> + git!cache_tree_update               12.4      4,935
> >> |+ git!update_one                     11.8      4,706
> >> | + git!update_one                    11.8      4,706
> >> |  + git!hash_object_file              6.1      2,406
> >> |  + git!has_object_file               2.0        813
> >> |  + OTHER <<vcruntime140d!strchr>>    0.5        203
> >> |  + git!strbuf_addf                   0.4        155
> >> |  + git!strbuf_release                0.4        143
> >> |  + git!strbuf_add                    0.3        121
> >> |  + OTHER <<vcruntime140d!memcmp>>    0.2         93
> >> |  + git!strbuf_grow                   0.1         25
> >
> > Ben, if you work on this, this could be a good starting point. I will
> > not work on this because I still have some other things to catch up
> > and follow through. You can have my sign off if you reuse something
> > from this patch
> >
> > Even if it's a naive implementation, the initial numbers look pretty
> > good. Without the patch we have
> >
> > 18:31:05.970621 unpack-trees.c:1437     performance: 0.000001029 s: copy
> > 18:31:05.975729 unpack-trees.c:1444     performance: 0.005082004 s: update
> >
> > And with the patch
> >
> > 18:31:13.295655 unpack-trees.c:1437     performance: 0.000198017 s: copy
> > 18:31:13.296757 unpack-trees.c:1444     performance: 0.001075935 s: update
> >
> > Time saving is about 80% by the look of this (best possible case
> > because only the top tree needs to be hashed and written out).
> >
> > -- 8< --
> > diff --git a/cache-tree.c b/cache-tree.c
> > index 6b46711996..67a4a93100 100644
> > --- a/cache-tree.c
> > +++ b/cache-tree.c
> > @@ -440,6 +440,147 @@ int cache_tree_update(struct index_state *istate, int flags)
> >       return 0;
> >   }
> >
> > +static int same(const struct cache_entry *a, const struct cache_entry *b)
> > +{
> > +     if (ce_stage(a) || ce_stage(b))
> > +             return 0;
> > +     if ((a->ce_flags | b->ce_flags) & CE_CONFLICTED)
> > +             return 0;
> > +     return a->ce_mode == b->ce_mode &&
> > +            !oidcmp(&a->oid, &b->oid);
> > +}
> > +
> > +static int cache_tree_name_pos(const struct index_state *istate,
> > +                            const struct strbuf *path)
> > +{
> > +     int pos;
> > +
> > +     if (!path->len)
> > +             return 0;
> > +
> > +     pos = index_name_pos(istate, path->buf, path->len);
> > +     if (pos >= 0)
> > +             BUG("No no no, directory path must not exist in index");
> > +     return -pos - 1;
> > +}
> > +
> > +/*
> > + * Locate the same cache-tree in two separate indexes. Check the
> > + * cache-tree is still valid for the "to" index (i.e. it contains the
> > + * same set of entries in the "from" index).
> > + */
> > +static int verify_one_cache_tree(const struct index_state *to,
> > +                              const struct index_state *from,
> > +                              const struct cache_tree *it,
> > +                              const struct strbuf *path)
> > +{
> > +     int i, spos, dpos;
> > +
> > +     spos = cache_tree_name_pos(from, path);
> > +     if (spos + it->entry_count > from->cache_nr)
> > +             return -1;
> > +
> > +     dpos = cache_tree_name_pos(to, path);
> > +     if (dpos + it->entry_count > to->cache_nr)
> > +             return -1;
> > +
> > +     /* Can we quickly check head and tail and bail out early */
> > +     if (!same(from->cache[spos], to->cache[spos]) ||
> > +         !same(from->cache[spos + it->entry_count - 1],
> > +               to->cache[spos + it->entry_count - 1]))
> > +             return -1;
> > +
> > +     for (i = 1; i < it->entry_count - 1; i++)
> > +             if (!same(from->cache[spos + i],
> > +                       to->cache[dpos + i]))
> > +                     return -1;
> > +
> > +     return 0;
> > +}
> > +
> > +static int verify_and_invalidate(struct index_state *to,
> > +                              const struct index_state *from,
> > +                              struct cache_tree *it,
> > +                              struct strbuf *path)
> > +{
> > +     /*
> > +      * Optimistically verify the current tree first. Alternatively
> > +      * we could verify all the subtrees first then do this
> > +      * last. Any invalid subtree would also invalidates its
> > +      * ancestors.
> > +      */
> > +     if (it->entry_count != -1 &&
> > +         verify_one_cache_tree(to, from, it, path))
> > +             it->entry_count = -1;
> > +
> > +     /*
> > +      * If the current tree is valid, don't bother checking
> > +      * inside. All subtrees _should_ also be valid
> > +      */
> > +     if (it->entry_count == -1) {
> > +             int i, len = path->len;
> > +
> > +             for (i = 0; i < it->subtree_nr; i++) {
> > +                     struct cache_tree_sub *down = it->down[i];
> > +
> > +                     if (!down || !down->cache_tree)
> > +                             continue;
> > +
> > +                     strbuf_setlen(path, len);
> > +                     strbuf_add(path, down->name, down->namelen);
> > +                     strbuf_addch(path, '/');
> > +                     if (verify_and_invalidate(to, from,
> > +                                               down->cache_tree, path))
> > +                             return -1;
> > +             }
> > +             strbuf_setlen(path, len);
> > +     }
> > +     return 0;
> > +}
> > +
> > +static struct cache_tree *duplicate_cache_tree(const struct cache_tree *src)
> > +{
> > +     struct cache_tree *dst;
> > +     int i;
> > +
> > +     if (!src)
> > +             return NULL;
> > +
> > +     dst = xmalloc(sizeof(*dst));
> > +     dst->entry_count = src->entry_count;
> > +     oidcpy(&dst->oid, &src->oid);
> > +     dst->subtree_nr = src->subtree_nr;
> > +     dst->subtree_alloc = dst->subtree_nr;
> > +     ALLOC_ARRAY(dst->down, dst->subtree_alloc);
> > +     for (i = 0; i < src->subtree_nr; i++) {
> > +             struct cache_tree_sub *dsrc = src->down[i];
> > +             struct cache_tree_sub *down;
> > +
> > +             FLEX_ALLOC_MEM(down, name, dsrc->name, dsrc->namelen);
> > +             down->count = dsrc->count;
> > +             down->namelen = dsrc->namelen;
> > +             down->used = dsrc->used;
> > +             down->cache_tree = duplicate_cache_tree(dsrc->cache_tree);
> > +             dst->down[i] = down;
> > +     }
> > +     return dst;
> > +}
> > +
> > +int cache_tree_copy(struct index_state *to, const struct index_state *from)
> > +{
> > +     struct cache_tree *it = duplicate_cache_tree(from->cache_tree);
> > +     struct strbuf path = STRBUF_INIT;
> > +     int ret;
> > +
> > +     if (to->cache_tree)
> > +             BUG("Sorry merging cache-tree is not supported yet");
> > +     ret = verify_and_invalidate(to, from, it, &path);
> > +     to->cache_tree = it;
> > +     to->cache_changed |= CACHE_TREE_CHANGED;
> > +     strbuf_release(&path);
> > +     return ret;
> > +}
> > +
> >   static void write_one(struct strbuf *buffer, struct cache_tree *it,
> >                         const char *path, int pathlen)
> >   {
> > diff --git a/cache-tree.h b/cache-tree.h
> > index cfd5328cc9..6981da8e0d 100644
> > --- a/cache-tree.h
> > +++ b/cache-tree.h
> > @@ -53,4 +53,6 @@ void prime_cache_tree(struct index_state *, struct tree *);
> >
> >   extern int cache_tree_matches_traversal(struct cache_tree *, struct name_entry *ent, struct traverse_info *info);
> >
> > +int cache_tree_copy(struct index_state *to, const struct index_state *from);
> > +
> >   #endif
> > diff --git a/unpack-trees.c b/unpack-trees.c
> > index cd0680f11e..cb3fdd42a6 100644
> > --- a/unpack-trees.c
> > +++ b/unpack-trees.c
> > @@ -1427,12 +1427,22 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
> >       ret = check_updates(o) ? (-2) : 0;
> >       if (o->dst_index) {
> >               if (!ret) {
> > -                     if (!o->result.cache_tree)
> > +                     if (!o->result.cache_tree) {
> > +                             uint64_t start = getnanotime();
> > +#if 0
> >                               o->result.cache_tree = cache_tree();
> > -                     if (!cache_tree_fully_valid(o->result.cache_tree))
> > +#else
> > +                             cache_tree_copy(&o->result, o->src_index);
> > +#endif
> > +                             trace_performance_since(start, "copy");
> > +                     }
> > +                     if (!cache_tree_fully_valid(o->result.cache_tree)) {
> > +                             uint64_t start = getnanotime();
> >                               cache_tree_update(&o->result,
> >                                                 WRITE_TREE_SILENT |
> >                                                 WRITE_TREE_REPAIR);
> > +                             trace_performance_since(start, "update");
> > +                     }
> >               }
> >               move_index_extensions(&o->result, o->src_index);
> >               discard_index(o->dst_index);
> > -- 8< --
> >
>
> I like the idea (and the perf win!) but it seems like there is an
> important piece missing.  If I'm reading this correctly, unpack_trees()
> will copy the source cache tree (instead of creating a new one) and then
> verify_and_invalidate() will walk the cache tree and for any tree that
> is dirty, it will flag its ancestors as dirty as well.

That, and the verification part. The for loop at the bottom of
verify_one_cache_tree() makes sure that the cache-tree is valid. That
is, if we recreate cache-tree from scratch in the destination index,
it should produce the same OID as the cache-tree we copy over.

But I think I'm a bit loose in that check. Suppose in the source index we have

abc
foo/abc
foo/def
xyz

the for loop tries to make sure that for cache-tree of 'foo', the
destination index must have foo/abc and foo/def (with same mode,
oid....) but it fails to catch this

abc
foo/abc
foo/def
foo/xyz
xyz

If we recreate cache-tree from scratch, the cache-tree for 'foo'
should cover three items and have different oid than one we copied
from the source index. Same problem could happen if we have something
in foo, but before foo/abc.

> What I don't understand is how any cache tree entries that became
> invalid as a result of the merge of the n-trees are marked as invalid.
> It seems like something needs to walk the cache tree and call
> cache_tree_invalidate_path() for all entries that changed as a result of
> the merge before the call to verify_and_invalidate().

I'm not sure I understand but anyway the way I understand it, when we
merge from o->src_index to o->result, we start o->result with empty
cache-tree. There's nothing in there to invalidate, even though we do
call cache_tree_invalidate_path() (from invalidate_ce_path() in
unpack-trees.c)

I don't think the merge operation is related to this at all. This
problem can be stated as "I have a set of good cache-trees that are
associated with index 'A' and a new index 'B' with no cache-tree at
all. Can I (cheaply) reuse some  cache-tree from 'A'?". My answer in
this patch is yes, for each cache-tree in A, make sure that the list
of cache-entries associated with it is present in B (which is almost
correct).
-- 
Duy
