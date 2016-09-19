Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 448D42070F
	for <e@80x24.org>; Mon, 19 Sep 2016 13:19:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938889AbcISNSl (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Sep 2016 09:18:41 -0400
Received: from mail-yb0-f171.google.com ([209.85.213.171]:33239 "EHLO
        mail-yb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S940551AbcISNSK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2016 09:18:10 -0400
Received: by mail-yb0-f171.google.com with SMTP id i66so84759136yba.0
        for <git@vger.kernel.org>; Mon, 19 Sep 2016 06:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=A37Z9PcN+SWbFF8FUzlY1EgKfS7m/PdalhGxt6XPHzs=;
        b=eXcvv7LRgmI5aQWST83GPvorRzHIfVqI0+I4MFxWCJyR9HB5COImh/sOpa7/nn5iKc
         DbCr+y+KMYoTxIl4jP76q+0DV255EdFBKclM5Y72rNzEIjDgR6Fd1aTCh6eowlwdVieN
         z4UGCuxs84iGpI0iS8T7CsaqpsHa3MXLBJ/ew/0o+6j76ZIJewKYcTa0KU+g0lHkk9Lp
         Pd9wS8jMrM7XxFg/Kc57EkW+BwBSklUq5OUYuvYVO6rcra3uqP3ciEkgs/vSPZmsNBFy
         pTyh2U4j0730zHPG+UNHtZgFAEfvomI837fiiZZ4Mfd4nJZ8T++hKI35/hMnQBvWWnCL
         4jpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=A37Z9PcN+SWbFF8FUzlY1EgKfS7m/PdalhGxt6XPHzs=;
        b=RHeXYXk+RKDhhlaRx/uT/TahvZsksciuJ7f3BWGwSA012jBfPWfSo9vsuolAMQhgD7
         elWs58FqC44bLHLjQ1RPxIulWMF3L70Wz8MFpcTSZOMEdWk9tz2a7pNVW4SrYvmQRXhw
         Bn/Uf7yD84/qSz71hLPHucT7KbewzYVGGMAwMFeWCcqMz4aosAjx9CGEY0TbFeDevacG
         XRlpDJfvEafGgJg/gIajMbG+t9W7INk7LC+V5GCqITjY9Wu3FX6xUJlc93fiTQGK1yfI
         OSEDCqYyZFFoI9HikRLDRTOagpzAGNOCXV0RV+sg9+bxKvFGL53OAyR4uLkPtNX99CuV
         PC7w==
X-Gm-Message-State: AE9vXwPn38JgJQNx3iVBVIWdc3rNrDyJvo0V33CetkITIQsfeBBG1DUC/JxVln/c75FKEg==
X-Received: by 10.37.170.212 with SMTP id t78mr15496272ybi.77.1474291089124;
        Mon, 19 Sep 2016 06:18:09 -0700 (PDT)
Received: from BenPeartHP ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id x68sm9393052ywx.10.2016.09.19.06.18.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Sep 2016 06:18:08 -0700 (PDT)
From:   "Ben Peart" <peartben@gmail.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>
Cc:     <pclouds@gmail.com>, <peartben@gmail.com>,
        "'Ben Peart'" <benpeart@microsoft.com>, <git@vger.kernel.org>
References: <20160913142628.15440-1-benpeart@microsoft.com> <xmqq7fafv376.fsf@gitster.mtv.corp.google.com> <BL2PR03MB3232D3128A72D4EC9ADC2C6F4F10@BL2PR03MB323.namprd03.prod.outlook.com>,<BL2PR03MB323E1B2F810C63CB01AA234F4F30@BL2PR03MB323.namprd03.prod.outlook.com>
In-Reply-To: <BL2PR03MB323E1B2F810C63CB01AA234F4F30@BL2PR03MB323.namprd03.prod.outlook.com>
Subject: RE: [PATCH v3] checkout: eliminate unnecessary merge for trivial checkout
Date:   Mon, 19 Sep 2016 09:18:08 -0400
Message-ID: <007401d21278$445eba80$cd1c2f80$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        boundary="----=_NextPart_000_0062_01D21254.CBE1A040";
        charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIN3XL6D2ztMgB+K51s/THd3oeh9QEnB8W1Ah2NUVkBTA8rgQHUDt8X
Content-Language: en-us
x-originating-ip: [52.34.82.168]
X-Forefront-Antispam-Report: SFV:SKI;SFS:;DIR:INB;SFP:;SCL:-1;SRVR:BY2PR0301MB0600;H:MWHPR03MB2958.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;;SKIP:1;
X-MS-Exchange-Organization-AuthSource: MWHPR03MB2958.namprd03.prod.outlook.com
x-ms-exchange-organization-authmechanism: 04
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Let me see if I can better explain what I=92m trying to accomplish with =
this
patch. =A0
=A0
"git checkout -b foo" (without -f -m or <start_point>) is defined in the
manual as being a shortcut for/equivalent to:
=A0
=A0=A0=A0=A0=A0=A0=A0 (1a) "git branch foo"
=A0=A0=A0=A0=A0=A0=A0 (1b) "git checkout foo"
=A0
However, it has been our experience in our observed use cases and all =
the
existing git tests, that it can be treated as equivalent to:
=A0
=A0=A0=A0=A0=A0=A0=A0 (2a) "git branch foo"
=A0=A0=A0=A0=A0=A0=A0 (2b) "git symbolic-ref HEAD refs/heads/foo"
=A0
That is, the common perception (use case) is to just create a new branch
"foo" (pointing at the current commit) and point HEAD at it WITHOUT =
making
any changes to the index or worktree.
=A0
However, the (1b) command has "git reset" connotations in that it should
examine and manipulate the trees, index, and worktree in the expectation
that there MIGHT be work to do.
=A0
Since this additional work in (1b) takes minutes on large repos and (2b)
takes less than a second, my intent was to identify the conditions that =
this
additional work will have no affect and thereby avoid it.
=A0
Alternatively, was the "-b" option just created as a shortcut only to =
avoid
calling the separate "git branch foo" command and we should not think =
about
the common perception and usage?
=A0
More comments inline...
=A0
> -----Original Message-----
> From: Junio C Hamano [mailto:gitster@pobox.com]
> Sent: Tuesday, September 13, 2016 6:35 PM
> To: Ben Peart <mailto:peartben@gmail.com>
> Cc: mailto:git@vger.kernel.org; mailto:pclouds@gmail.com; Ben Peart
> <mailto:Ben.Peart@microsoft.com>
> Subject: Re: [PATCH v3] checkout: eliminate unnecessary merge for =
trivial
> checkout
>=20
> Ben Peart <mailto:peartben@gmail.com> writes:
>=20
> > +static int needs_working_tree_merge(const struct checkout_opts =
*opts,
> > +=A0=A0=A0=A0=A0 const struct branch_info *old,
> > +=A0=A0=A0=A0=A0 const struct branch_info *new)
> > +{
> > +...
> > +}
>=20
> I do not think I need to repeat the same remarks on the conditions in =
this
> helper, which hasn't changed since v2.=A0 Many "comments" in the code =
do not
> explain why skipping is justified, or what they claim to check looks =
to me
just
> plain wrong.
>=20
> For example, there is
>=20
>=A0=A0=A0=A0=A0=A0=A0 /*
>=A0=A0=A0=A0=A0=A0=A0=A0 * If we're not creating a new branch, by =
definition we're changing
>=A0=A0=A0=A0=A0=A0=A0=A0 * the existing one so need to do the merge
>=A0=A0=A0=A0=A0=A0=A0=A0 */
>=A0=A0=A0=A0=A0=A0=A0 if (!opts->new_branch)
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return 1;
>=20
> but "git checkout" (no other argument) hits this condition.=A0 It =
disables
the
> most trivial optimization opportunity, because we are not "creating".
>=20
=A0
Disabling the optimization for "git checkout" with no argument was
intentional. This command does not create a new branch but instead, =
performs
a "soft reset" which will update the index and working directory to =
reflect
changes to the sparse-checkout (for example).=A0 If this was not =
disabled,
many tests fail as they expect this behavior.=A0 Because "git checkout" =
does
not actually change the refs, if we skipped the merge/index/working
directory update, this command becomes a no-op.
=A0
> "By definition, we're changing"?=A0 Really?=A0 Not quite.
>=20
=A0
What I was attempting to communicate is that if we aren't creating a new
branch any changes or updates will happen in the existing branch.=A0 =
Since
that could only be updating the index and working directory, we don't =
want
to skip those steps or we've defeated any purpose in running the =
command.=20
=A0
> If you disable this bogus check, "git checkout" (no other argument) =
would
be
> allowed to skip the merge_working_tree(), and that in turn reveals =
another
> case that the helper is not checking when
> unpack_trees() MUST be called.
>=20
>=A0=A0=A0=A0 Note: namely, when sparse checkout is in effect, switching =
from
>=A0=A0=A0=A0 HEAD to HEAD can nuke existing working tree files outside =
the
>=A0=A0=A0=A0 sparse pattern -- YUCK!=A0 See penultimate test in t1011 =
for
>=A0=A0=A0=A0 an example.
>=20
> This yuckiness is not your fault, but needs_working_tree_merge() logic =
you
> added needs to refrain from skipping unpack_trees() call when sparse =
thing
> is in effect. =A0I'd expect "git checkout -b foo"
> instead of "git checkout" (no other argument) would fail to honor the
sparse
> thing and reveal this bug, because the above bogus "!opts->new_branch"
> check will not protect you for that case.
>=20
=A0
It is correct that this optimization will skip updating the tree to =
honor
any changes to the sparse-checkout in the case of creating a new branch.
Unfortunately, I don't know of any way to detect the changes other than
actually doing all the work to update the skip work tree bit in the =
index.
If this behavior is required, then this optimization will need to check =
=A0if
sparse-checkout is enabled and skip the optimization just in case there =
have
been changes.
=A0
> In other words, these random series of "if (...) return 1" are bugs =
hiding
> other real bugs and we need to reason about which ones are bugs that =
are
> hiding what other bugs that are not covered by this function.=A0 As =
Peff
said
> earlier for v1, this is still an unreadable mess.=A0 We need to figure =
out a
way to
> make sure we are skipping on the right condition and not accidentally
hiding
> a bug of failing to check the right condition.=A0 I offhand do not =
have a
good
> suggestion on this; sorry.
>=20
=A0
Beyond this code review process and testing, I don't know how else we =
make
sure we're caught all the conditions where we are OK skipping some of =
the
steps.=A0 Any change has inherent risk - a change in behavior even more =
so.
=A0
> >=A0 static int merge_working_tree(const struct checkout_opts *opts,
> >=A0 =
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0struct =
branch_info *old,
> >=A0 =
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0struct =
branch_info *new,
> >=A0 =
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0int =
*writeout_error)
> >=A0 {
> > +=A0=A0=A0=A0=A0 /*
> > +=A0=A0=A0=A0=A0 * Optimize the performance of "git checkout -b foo" =
by avoiding
> > +=A0=A0=A0=A0=A0 * the expensive merge, index and working directory =
updates if
they
> > +=A0=A0=A0=A0=A0 * are not needed.
> > +=A0=A0=A0=A0=A0 */
> > +=A0=A0=A0=A0=A0 if (!needs_working_tree_merge(opts, old, new))
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
return 0;
> > +
> >=A0 =A0=A0=A0=A0=A0=A0=A0 int ret;
> >=A0 =A0=A0=A0=A0=A0=A0=A0 struct lock_file *lock_file =3D xcalloc(1, =
sizeof(struct
lock_file));
>=20
> With the change you made at the beginning of this function, it no =
longer
> compiles with -Wdecl-after-stmt, but that is the smallest of the =
problems.
=A0
I apologize, I didn't realize this was a requirement.=A0 It built and =
passed
all existing tests on Windows but I will reorder the declarations to =
prevent
causing issues with other platforms/compilers.
=A0
>=20
> It is a small step in the right direction to move the call to the =
helper
from the
> caller to this function, but it is a bit too small.
>=20
> Notice that the lines after the above context look like this:
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 hold_locked_index(lock_file, 1);
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (read_cache_preload(NULL) < 0)
> =
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 return error(_("index file corrupt"));
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 resolve_undo_clear();
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (opts->force) {
> =
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 ret =3D reset_tree(new->commit->tree, opts, 1,
> writeout_error);
> =
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 if (ret)
> =
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 } else {
> =
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 struct tree_desc trees[2];
> =
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 ...
>=20
> I would have expected that the check goes inside the "else" thing that
> actually does a two-tree merge, and the helper loses the check with =
opts-
> >force, at least.=A0 That would still be a change smaller than =
desired, but
at
> least a meaningful improvement compared to the previous one.=A0=20
=A0
I'll restructure it that way.
=A0
> As I have
> already pointed out, in the "else" clause there is a check "is the =
index
free of
> conflicted entries? if so error out", and that must be honored in
!opt->force
> case, no matter what your needs_working_tree_merge() says.=A0=20
=A0
Given we're not merging trees, updating the index, or work tree, why do =
we
need to error out in this case?=A0 We aren't attempting this =
optimization if
they pass "-m."=A0 If there are conflicted entries that haven't been =
fixed,
they will still exist.=A0 We're essentially just creating a new =
reference for
the existing commit/index/work tree.
=A0
> I also was
> hoping that you would notice, when you were told about the unmerged
> check, by reading the remainder of the merge_working_tree(), that we =
need
> to call show_local_changes() when we are not doing force and when we =
are
> not quiet---returning early like the above patch will never be able to
call that
> one downstream in the function.
=A0
It is a good point that my optimization skipped the call to
show_local_changes.=A0 Thanks for catching that, I've fixed it for my =
next
iteration.
=A0
>=20
> Regardless of what the actual checks end up to be, the right place to =
do
this
> "optimization" would look more like:
>=20
>=A0 builtin/checkout.c | 7 ++++++-
>=A0 1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/builtin/checkout.c b/builtin/checkout.c index
2b50a49..a6b9e17
> 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -508,14 +508,19 @@ static int merge_working_tree(const struct
> checkout_opts *opts,
>=A0 =
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 topts.dir->flags =
|=3D
DIR_SHOW_IGNORED;
>=A0 =
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
setup_standard_excludes(topts.dir);
>=A0 =
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 }
> +
> =
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 if ( we know we can skip the unpack ) {
> =
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D 0;
> =
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 } else {
>=A0 =
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 tree =3D
parse_tree_indirect(old->commit ?
>=A0
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0old->commit-
> >object.oid.hash :
>=A0
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0EMPTY_TREE_SHA1_BIN);
>=A0 =
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
init_tree_desc(&trees[0],
tree->buffer, tree->size);
>=A0 =
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 tree =3D
parse_tree_indirect(new->commit-
> >object.oid.hash);
>=A0 =
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
init_tree_desc(&trees[1],
tree->buffer, tree->size);
> -
>=A0 =
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D =
unpack_trees(2, trees,
&topts);
> =
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 }
> +
>=A0 =
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 if (ret =3D=3D -1) {
>=A0 =
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /*
>=A0 =
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0* Unpack couldn't =
do a
trivial merge; either
>=20
=A0
I'll restructure it to be like you suggest above however, given we will =
not
be merging the tress, we won't have any index changes to write out. I =
will
also skip the calls to cache_tree_update and write_locked_index.
=A0
> I'd think.=A0 Note that the determination of "we can skip" would =
involve
> knowing the object names of the two trees involved, so for performance
> reasons, some of the parse-tree calls may have to come before the call =
to
> "do we know we can skip?", but that does not fundamentally change the
> basic code structure.
>=20
> Thanks.
=A0
I don't understand why we'd need to know the object names of the two =
trees
given we have the IDs.=A0 What did you have in mind that would need =
those?
=A0

