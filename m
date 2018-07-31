Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEA861F597
	for <e@80x24.org>; Tue, 31 Jul 2018 19:52:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732643AbeGaVec (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 17:34:32 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:42779 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732639AbeGaVec (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 17:34:32 -0400
Received: by mail-vk0-f68.google.com with SMTP id t4-v6so8132926vke.9
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 12:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r2v1Fa2t4LAaB2c/UMfRHgcJgdqmu5leJxL6XamwK0k=;
        b=mtpVqpD6ce+SZTvxtImxRK+xD7/uPoXpKGYH7tm4H03sbPCCRAvShkok+S7i1ega63
         dXNmjeLaNBD9pn3Aft6PR8xUX6LM2Tn5ZxELM/gxaB7ieSmFV8LLa9Cb/r/Z6+7LZ0kU
         31iBqhGl3Drcpt5vHXrNj2+p04uz7CcprrZ2/aIX2a4yK37bzSw0/UlWLq07Vf3Ioa4G
         kHwKVJ0rCzed1c7C6rovsgNSaABfQ4nqKD3avw6So2J3s7UMrxi5ATg4S1QNGUCHhIQY
         0HOB1pNHeT8gJx4p+ZhSnx1VThOuhMQRP2n0Uuy1+E7u88aqJ3DLJ7nMQWVZjbszwXw+
         rskQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r2v1Fa2t4LAaB2c/UMfRHgcJgdqmu5leJxL6XamwK0k=;
        b=TOEU/Vzdbr0RKqPkm3gp/QoXIvnSkWhSxlKfNiyDjbz00yvvvbn5cACSdBl27UKB/p
         Foi8TNy2D2/ihCELXZ+anievTCaR/KBaCFhXrTK8lv2+EGcLw/qkCE6VqOemlJ6ML+Z3
         fDbscpy40OWZOOaBVh8Ht+ML4qYzFC4+A9PHjQ6+R3dStzup6TXfWBUpzfx3zJZLn5QN
         c+Nr9tQCfkn+gQK3dk5NsHIw2qBTe9yye6mVGuGtMasAOpnuprOK5RbtUi6q0jVqlytk
         WU6Bl2bE+gl9LxyieOkgEBAM/VlwK6v82syovL1/l0BwvpFiJ1jOJ0+2vhlq3GY2F43Y
         Em8Q==
X-Gm-Message-State: AOUpUlGcNvYiJ0Q2rZZhafj7A+DPkZ8HVvfSFfmIZnRZJZvxhKUHvUej
        u8WK8UV0AUKYOQjMiiG/S7PDKqL9/vv+4ZBbN9RnrYGW
X-Google-Smtp-Source: AAOMgpfb4AImrh9xUblJ7PdGiEXcByZnTe6NlK+ZUDR2ytZGisXUgtZ4uhAex6O/RiEXoEG64GgMOlAOa79yYj1Cgxs=
X-Received: by 2002:a1f:654:: with SMTP id 81-v6mr14128045vkg.159.1533066757888;
 Tue, 31 Jul 2018 12:52:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAF1Ko+FBP5UmETmh071dvn9iv8-N-3YgaP61q-4jQvxFdN0GTA@mail.gmail.com>
 <CAF1Ko+FNfjWMteccfKDBjPEW76rGBLQkGb1icUHmzEZ0fKQJBA@mail.gmail.com>
 <xmqqtvofcsgc.fsf@gitster-ct.c.googlers.com> <20180731161559.GB16910@sigill.intra.peff.net>
 <xmqqh8kfcokk.fsf@gitster-ct.c.googlers.com> <20180731172304.GA16977@sigill.intra.peff.net>
 <20180731190459.GA3372@sigill.intra.peff.net>
In-Reply-To: <20180731190459.GA3372@sigill.intra.peff.net>
From:   George Shammas <georgyo@gmail.com>
Date:   Tue, 31 Jul 2018 15:52:26 -0400
Message-ID: <CAF1Ko+FHsvmqzwVHh+fEnk=UGUftNW8VkFwaWTSKu3xYprb+wg@mail.gmail.com>
Subject: Re: git merge -s subtree seems to be broken.
To:     peff@peff.net
Cc:     Junio C Hamano <gitster@pobox.com>, l.s.r@web.de,
        git@vger.kernel.org
Content-Type: multipart/alternative; boundary="000000000000856240057250ebb5"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--000000000000856240057250ebb5
Content-Type: text/plain; charset="UTF-8"

This is the fastest I ever seen an open source project respond to an issue
I reported. Thanks for being awesome!

On Tue, Jul 31, 2018 at 3:05 PM Jeff King <peff@peff.net> wrote:

> On Tue, Jul 31, 2018 at 01:23:04PM -0400, Jeff King wrote:
>
> > On Tue, Jul 31, 2018 at 10:17:15AM -0700, Junio C Hamano wrote:
> >
> > > Jeff King <peff@peff.net> writes:
> > >
> > > > +...
> > > > +         } else if (cmp > 0) {
> > > >                   /* path2 does not appear in one */
> > > > +                 score += score_missing(two.entry.mode,
> two.entry.path);
> > > > +                 update_tree_entry(&two);
> > > > +                 continue;
> > > > +         } if (oidcmp(one.entry.oid, two.entry.oid)) {
> > >
> > > As the earlier ones do the "continue at the end of the block", this
> > > does not affect the correctness, but I think you either meant "else if"
> > > or a fresh "if/else" that is disconnected from the previous if/else
> if/...
> > > chain.
> >
> > Yes, thanks. I actually started to write it without the "continue" at
> > all, and a big "else" that checked the "we have both" case. But I backed
> > that out (in favor of a smaller diff), and forgot to add back in the
> > "else if".
>
> So here it is fixed, and with a commit message. I'm not happy to omit a
> regression test, but I actually couldn't come up with a minimal one that
> tickled the problem, because we're playing around with heuristics. So I
> compensated by probably over-explaining in the commit message. But
> clearly this is not a well-tested code path given the length of time
> between introducing and detecting the bug.
>
> -- >8 --
> Subject: [PATCH] score_trees(): fix iteration over trees with missing
> entries
>
> In score_trees(), we walk over two sorted trees to find
> which entries are missing or have different content between
> the two.  So if we have two trees with these entries:
>
>   one   two
>   ---   ---
>   a     a
>   b     c
>   c     d
>
> we'd expect the loop to:
>
>   - compare "a" to "a"
>
>   - compare "b" to "c"; because these are sorted lists, we
>     know that the second tree does not have "b"
>
>   - compare "c" to "c"
>
>   - compare "d" to end-of-list; we know that the first tree
>     does not have "d"
>
> And prior to d8febde370 (match-trees: simplify score_trees()
> using tree_entry(), 2013-03-24) that worked. But after that
> commit, we mistakenly increment the tree pointers for every
> loop iteration, even when we've processed the entry for only
> one side. As a result, we end up doing this:
>
>   - compare "a" to "a"
>
>   - compare "b" to "c"; we know that we do not have "b", but
>     we still increment both tree pointers; at this point
>     we're out of sync and all further comparisons are wrong
>
>   - compare "c" to "d" and mistakenly claim that the second
>     tree does not have "c"
>
>   - exit the loop, mistakenly not realizing that the first
>     tree does not have "d"
>
> So contrary to the claim in d8febde370, we really do need to
> manually use update_tree_entry(), because advancing the tree
> pointer depends on the entry comparison.
>
> That means we must stop using tree_entry() to access each
> entry, since it auto-advances the pointer. Instead:
>
>   - we'll use tree_desc.size directly to know if there's
>     anything left to look at (which is what tree_entry() was
>     doing under the hood)
>
>   - rather than do an extra struct assignment to "e1" and
>     "e2", we can just access the "entry" field of tree_desc
>     directly
>
> That makes us a little more intimate with the tree_desc
> code, but that's not uncommon for its callers.
>
> There's no regression test here, as it's a little tricky to
> trigger this with a minimal example. The user-visible effect
> is that the heuristics fail to correlate two trees that
> should be. But in a minimal example, there aren't a lot of
> other trees to match, so we often end up doing the right
> thing anyway.
>
> A real-world example (from the original bug report) is:
>
> -- >8 --
> git init repo
> cd repo
>
> echo init >file
> git add file
> git commit -m init
>
> git remote add tig https://github.com/jonas/tig.git
> git fetch tig
> git merge -s ours --no-commit --allow-unrelated-histories tig-2.3.0
> git read-tree --prefix=src/ -u tig-2.3.0
> git commit -m 'get upstream tig-2.3.0'
>
> echo update >file
> git commit -a -m update
>
> git merge -s subtree tig-2.4.0
> -- 8< --
>
> Before this patch, we fail to realize that the tig-2.4.0
> content should go into the "src" directory.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  match-trees.c | 43 ++++++++++++++++++++++++++-----------------
>  1 file changed, 26 insertions(+), 17 deletions(-)
>
> diff --git a/match-trees.c b/match-trees.c
> index 4cdeff53e1..37653308d3 100644
> --- a/match-trees.c
> +++ b/match-trees.c
> @@ -83,34 +83,43 @@ static int score_trees(const struct object_id *hash1,
> const struct object_id *ha
>         int score = 0;
>
>         for (;;) {
> -               struct name_entry e1, e2;
> -               int got_entry_from_one = tree_entry(&one, &e1);
> -               int got_entry_from_two = tree_entry(&two, &e2);
>                 int cmp;
>
> -               if (got_entry_from_one && got_entry_from_two)
> -                       cmp = base_name_entries_compare(&e1, &e2);
> -               else if (got_entry_from_one)
> +               if (one.size && two.size)
> +                       cmp = base_name_entries_compare(&one.entry,
> &two.entry);
> +               else if (one.size)
>                         /* two lacks this entry */
>                         cmp = -1;
> -               else if (got_entry_from_two)
> +               else if (two.size)
>                         /* two has more entries */
>                         cmp = 1;
>                 else
>                         break;
>
> -               if (cmp < 0)
> +               if (cmp < 0) {
>                         /* path1 does not appear in two */
> -                       score += score_missing(e1.mode, e1.path);
> -               else if (cmp > 0)
> +                       score += score_missing(one.entry.mode,
> one.entry.path);
> +                       update_tree_entry(&one);
> +               } else if (cmp > 0) {
>                         /* path2 does not appear in one */
> -                       score += score_missing(e2.mode, e2.path);
> -               else if (oidcmp(e1.oid, e2.oid))
> -                       /* they are different */
> -                       score += score_differs(e1.mode, e2.mode, e1.path);
> -               else
> -                       /* same subtree or blob */
> -                       score += score_matches(e1.mode, e2.mode, e1.path);
> +                       score += score_missing(two.entry.mode,
> two.entry.path);
> +                       update_tree_entry(&two);
> +               } else {
> +                       /* path appears in both */
> +                       if (oidcmp(one.entry.oid, two.entry.oid)) {
> +                               /* they are different */
> +                               score += score_differs(one.entry.mode,
> +                                                      two.entry.mode,
> +                                                      one.entry.path);
> +                       } else {
> +                               /* same subtree or blob */
> +                               score += score_matches(one.entry.mode,
> +                                                      two.entry.mode,
> +                                                      one.entry.path);
> +                       }
> +                       update_tree_entry(&one);
> +                       update_tree_entry(&two);
> +               }
>         }
>         free(one_buf);
>         free(two_buf);
> --
> 2.18.0.796.g4bfd63b683
>
>

--000000000000856240057250ebb5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><span style=3D"font-size:small;text-decoration-style:initi=
al;text-decoration-color:initial;float:none;display:inline">This is the fas=
test I ever seen an open source project respond to an issue I reported. Tha=
nks for being awesome!</span></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr">On Tue, Jul 31, 2018 at 3:05 PM Jeff King &lt;<a href=3D"mailto:pe=
ff@peff.net">peff@peff.net</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-lef=
t:1ex">On Tue, Jul 31, 2018 at 01:23:04PM -0400, Jeff King wrote:<br>
<br>
&gt; On Tue, Jul 31, 2018 at 10:17:15AM -0700, Junio C Hamano wrote:<br>
&gt; <br>
&gt; &gt; Jeff King &lt;<a href=3D"mailto:peff@peff.net" target=3D"_blank">=
peff@peff.net</a>&gt; writes:<br>
&gt; &gt; <br>
&gt; &gt; &gt; +...<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (cmp &gt; 0) {<=
br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0/* path2 does not appear in one */<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0score +=3D score_missing(two.entry.mode, two.entry.path);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0update_tree_entry(&amp;two);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0continue;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} if (oidcmp(one.entry.oi=
d, two.entry.oid)) {<br>
&gt; &gt; <br>
&gt; &gt; As the earlier ones do the &quot;continue at the end of the block=
&quot;, this<br>
&gt; &gt; does not affect the correctness, but I think you either meant &qu=
ot;else if&quot;<br>
&gt; &gt; or a fresh &quot;if/else&quot; that is disconnected from the prev=
ious if/else if/...<br>
&gt; &gt; chain.<br>
&gt; <br>
&gt; Yes, thanks. I actually started to write it without the &quot;continue=
&quot; at<br>
&gt; all, and a big &quot;else&quot; that checked the &quot;we have both&qu=
ot; case. But I backed<br>
&gt; that out (in favor of a smaller diff), and forgot to add back in the<b=
r>
&gt; &quot;else if&quot;.<br>
<br>
So here it is fixed, and with a commit message. I&#39;m not happy to omit a=
<br>
regression test, but I actually couldn&#39;t come up with a minimal one tha=
t<br>
tickled the problem, because we&#39;re playing around with heuristics. So I=
<br>
compensated by probably over-explaining in the commit message. But<br>
clearly this is not a well-tested code path given the length of time<br>
between introducing and detecting the bug.<br>
<br>
-- &gt;8 --<br>
Subject: [PATCH] score_trees(): fix iteration over trees with missing entri=
es<br>
<br>
In score_trees(), we walk over two sorted trees to find<br>
which entries are missing or have different content between<br>
the two.=C2=A0 So if we have two trees with these entries:<br>
<br>
=C2=A0 one=C2=A0 =C2=A0two<br>
=C2=A0 ---=C2=A0 =C2=A0---<br>
=C2=A0 a=C2=A0 =C2=A0 =C2=A0a<br>
=C2=A0 b=C2=A0 =C2=A0 =C2=A0c<br>
=C2=A0 c=C2=A0 =C2=A0 =C2=A0d<br>
<br>
we&#39;d expect the loop to:<br>
<br>
=C2=A0 - compare &quot;a&quot; to &quot;a&quot;<br>
<br>
=C2=A0 - compare &quot;b&quot; to &quot;c&quot;; because these are sorted l=
ists, we<br>
=C2=A0 =C2=A0 know that the second tree does not have &quot;b&quot;<br>
<br>
=C2=A0 - compare &quot;c&quot; to &quot;c&quot;<br>
<br>
=C2=A0 - compare &quot;d&quot; to end-of-list; we know that the first tree<=
br>
=C2=A0 =C2=A0 does not have &quot;d&quot;<br>
<br>
And prior to d8febde370 (match-trees: simplify score_trees()<br>
using tree_entry(), 2013-03-24) that worked. But after that<br>
commit, we mistakenly increment the tree pointers for every<br>
loop iteration, even when we&#39;ve processed the entry for only<br>
one side. As a result, we end up doing this:<br>
<br>
=C2=A0 - compare &quot;a&quot; to &quot;a&quot;<br>
<br>
=C2=A0 - compare &quot;b&quot; to &quot;c&quot;; we know that we do not hav=
e &quot;b&quot;, but<br>
=C2=A0 =C2=A0 we still increment both tree pointers; at this point<br>
=C2=A0 =C2=A0 we&#39;re out of sync and all further comparisons are wrong<b=
r>
<br>
=C2=A0 - compare &quot;c&quot; to &quot;d&quot; and mistakenly claim that t=
he second<br>
=C2=A0 =C2=A0 tree does not have &quot;c&quot;<br>
<br>
=C2=A0 - exit the loop, mistakenly not realizing that the first<br>
=C2=A0 =C2=A0 tree does not have &quot;d&quot;<br>
<br>
So contrary to the claim in d8febde370, we really do need to<br>
manually use update_tree_entry(), because advancing the tree<br>
pointer depends on the entry comparison.<br>
<br>
That means we must stop using tree_entry() to access each<br>
entry, since it auto-advances the pointer. Instead:<br>
<br>
=C2=A0 - we&#39;ll use tree_desc.size directly to know if there&#39;s<br>
=C2=A0 =C2=A0 anything left to look at (which is what tree_entry() was<br>
=C2=A0 =C2=A0 doing under the hood)<br>
<br>
=C2=A0 - rather than do an extra struct assignment to &quot;e1&quot; and<br=
>
=C2=A0 =C2=A0 &quot;e2&quot;, we can just access the &quot;entry&quot; fiel=
d of tree_desc<br>
=C2=A0 =C2=A0 directly<br>
<br>
That makes us a little more intimate with the tree_desc<br>
code, but that&#39;s not uncommon for its callers.<br>
<br>
There&#39;s no regression test here, as it&#39;s a little tricky to<br>
trigger this with a minimal example. The user-visible effect<br>
is that the heuristics fail to correlate two trees that<br>
should be. But in a minimal example, there aren&#39;t a lot of<br>
other trees to match, so we often end up doing the right<br>
thing anyway.<br>
<br>
A real-world example (from the original bug report) is:<br>
<br>
-- &gt;8 --<br>
git init repo<br>
cd repo<br>
<br>
echo init &gt;file<br>
git add file<br>
git commit -m init<br>
<br>
git remote add tig <a href=3D"https://github.com/jonas/tig.git" rel=3D"nore=
ferrer" target=3D"_blank">https://github.com/jonas/tig.git</a><br>
git fetch tig<br>
git merge -s ours --no-commit --allow-unrelated-histories tig-2.3.0<br>
git read-tree --prefix=3Dsrc/ -u tig-2.3.0<br>
git commit -m &#39;get upstream tig-2.3.0&#39;<br>
<br>
echo update &gt;file<br>
git commit -a -m update<br>
<br>
git merge -s subtree tig-2.4.0<br>
-- 8&lt; --<br>
<br>
Before this patch, we fail to realize that the tig-2.4.0<br>
content should go into the &quot;src&quot; directory.<br>
<br>
Signed-off-by: Jeff King &lt;<a href=3D"mailto:peff@peff.net" target=3D"_bl=
ank">peff@peff.net</a>&gt;<br>
---<br>
=C2=A0match-trees.c | 43 ++++++++++++++++++++++++++-----------------<br>
=C2=A01 file changed, 26 insertions(+), 17 deletions(-)<br>
<br>
diff --git a/match-trees.c b/match-trees.c<br>
index 4cdeff53e1..37653308d3 100644<br>
--- a/match-trees.c<br>
+++ b/match-trees.c<br>
@@ -83,34 +83,43 @@ static int score_trees(const struct object_id *hash1, c=
onst struct object_id *ha<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int score =3D 0;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (;;) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct name_entry e=
1, e2;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int got_entry_from_=
one =3D tree_entry(&amp;one, &amp;e1);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int got_entry_from_=
two =3D tree_entry(&amp;two, &amp;e2);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int cmp;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (got_entry_from_=
one &amp;&amp; got_entry_from_two)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0cmp =3D base_name_entries_compare(&amp;e1, &amp;e2);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else if (got_entry_=
from_one)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (one.size &amp;&=
amp; two.size)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0cmp =3D base_name_entries_compare(&amp;one.entry, &amp;two.entry)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else if (one.size)<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 /* two lacks this entry */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 cmp =3D -1;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else if (got_entry_=
from_two)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else if (two.size)<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 /* two has more entries */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 cmp =3D 1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 break;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (cmp &lt; 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (cmp &lt; 0) {<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 /* path1 does not appear in two */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0score +=3D score_missing(e1.mode, e1.path);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else if (cmp &gt; 0=
)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0score +=3D score_missing(one.entry.mode, one.entry.path);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0update_tree_entry(&amp;one);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (cmp &gt;=
 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 /* path2 does not appear in one */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0score +=3D score_missing(e2.mode, e2.path);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else if (oidcmp(e1.=
oid, e2.oid))<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0/* they are different */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0score +=3D score_differs(e1.mode, e2.mode, e1.path);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0/* same subtree or blob */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0score +=3D score_matches(e1.mode, e2.mode, e1.path);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0score +=3D score_missing(two.entry.mode, two.entry.path);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0update_tree_entry(&amp;two);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0/* path appears in both */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (oidcmp(one.entry.oid, two.entry.oid)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* they are different */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0score +=3D score_differs(one.entry.mo=
de,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 two.entry.mode,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 one.entry.path);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0} else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* same subtree or blob */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0score +=3D score_matches(one.entry.mo=
de,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 two.entry.mode,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 one.entry.path);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0update_tree_entry(&amp;one);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0update_tree_entry(&amp;two);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 free(one_buf);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 free(two_buf);<br>
-- <br>
2.18.0.796.g4bfd63b683<br>
<br>
</blockquote></div>

--000000000000856240057250ebb5--
