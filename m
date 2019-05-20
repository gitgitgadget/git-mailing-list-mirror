Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B21311F461
	for <e@80x24.org>; Mon, 20 May 2019 10:01:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732274AbfETKBa (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 May 2019 06:01:30 -0400
Received: from mout.gmx.net ([212.227.17.21]:33501 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727866AbfETKBa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 May 2019 06:01:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1558346480;
        bh=sVainbvD1qAmb3ribj4UgTsiWKATe4Bwgc3FZpQkVq8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Aj32X0oBaHMGSDTHeIEHXpPHzhj7Pwoqqs/tGPDyujyWvWFFvPakr+8uIE1WLhU66
         mu5XUe2B9lZFfcijBqr7tPYW+su+QSkykkI6DjnrL8OxXD8kLslHr8rntoSFezGz4K
         g4J3iTbAD7oU84kJP57bazz0Z/YAqCaWdNwClw7o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MlNtF-1goL4X1ymb-00lozs; Mon, 20
 May 2019 12:01:20 +0200
Date:   Mon, 20 May 2019 12:01:04 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, avarab@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 3/3] packfile: close_all_packs to close_object_store
In-Reply-To: <0e948f639fb5209f07f8e3eb356b5886c41ff2be.1558118506.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1905201141000.46@tvgsbejvaqbjf.bet>
References: <pull.208.git.gitgitgadget@gmail.com> <0e948f639fb5209f07f8e3eb356b5886c41ff2be.1558118506.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:mbcNjwYhM5l4TQSKKR1Yum149+B3WTnxsbORVG4VQo48XJ/epvn
 DKCElrjvKHw4um2JLcQfiowa3wcOSf1+h08IVqbGKbePpAe2QxN5Y40Vjosl1yL+SFoRMtY
 HSXuPDzFspSc7kTQs/UgddTFj/UBwk92RbiFS+70U6m6sl6BQUTmpNGEG5MRyYECkuhUVp7
 MSj3CeM0eJsIiOAQQB3zw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lv9CMHionRk=:5Iymf4ZtdVraGgnZWYpPP2
 qpM7Qb0+UDPmp40z+dLr6+pNmn02b0l3iX4HHMfABaAUV17m84BJzmgREWuZ+QLhcXqItHBXf
 Pv+IyaH2M/u9fBCxlwUpjEO9oGGlyUQ+QfQyrq7he5ouKS2/PBIdG2sbodI1m1f1y0Fwx8hBm
 x6w/2FI3jglYd4dysgS65ZZEIX7AAyBQZhAPSxbr+G+/5HS9IegKUQGH3lJ5MXzIAN3zD+dYP
 ppYTA29u+aFUn7kQI9QaRxkvFgmLLyE6+IrNowY1kjtUAhG/GoKJEIXUyOx2VkjJU4ko3MxmH
 jypUR8vZMgNTSxXWDzEMme7JdlmlMYI3/YKhXN2Dfcu4EDyPLhr9Yufq88OKTaUNeGTnHDPQG
 dPdl61D55+v2clnpoJ/qvRfhw7YGL8F3c2Bj3U86xd4syJxbIa/imYKekQ+6k5t0Pl2Gf4LMt
 /QaUuz92YRUAnyLGktnETrDrDC3eF/TtNKfTTTTfZyRAThK1Mh4pZ/cX1K9Jpoms/qUrD0IeJ
 +NwU0hsK5T7EHbBkgur0jiPrmx6OjswzMjgFrmVU4TTax1vxbs88Ax82btPWeBZchzHK7CrKg
 8dDCKw4w3sNCmbnDq4MQoTE04QMSzYlGQUO3kI4HsiCSLCxxGPVMLwHwsVxbFQ+Ma/1mK+oJX
 xP/er/c+auwBiDq46UMQKxyKOMfS6FE5ZjPMKJTDgWLiPQqfoLu0uyHOC2NBedM+F29stmqVu
 E49GvnW+JsqV9uNHXMq1Q6ynA4I356n35aPvkmZxTm0yfX+4lHBIbMJyznba7R9r+osffX/ZZ
 nJNDM9aiGu0njJgyUpNNSp9We1k8p19gf8TX4o/rF23maeTrQ3GSvIZus0XtqVhrTZvldMIYI
 0Pzq3oVu9UHRfTls/Pi4n9fQhdlquKcOh4lfgtlc6xdP5AugPPfdjxc0vjH9uL0RW7nFW2R1X
 vnVIuJSo5Q41/rnHY+cEWHFX1oHAhJnhiVIWFb/5Jsx2QhlvywEeY
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee,

*really* minor nit: the commit subject probably wants to have a "rename"
after the colon ;-)

The patch looks sensible to me. Since Junio asked for a sanity check
whether all of the call sites of `close_all_packs()` actually want to
close the MIDX and the commit graph, too, I'll do the "speak out loud"
type of patch review here (spoiler: all of them check out):

On Fri, 17 May 2019, Derrick Stolee via GitGitGadget wrote:

> diff --git a/builtin/am.c b/builtin/am.c
> index 58a2aef28b..9315d32d2a 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -1800,7 +1800,7 @@ static void am_run(struct am_state *state, int res=
ume)
>  	 */
>  	if (!state->rebasing) {
>  		am_destroy(state);
> -		close_all_packs(the_repository->objects);
> +		close_object_store(the_repository->objects);
>  		run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);

Here, we run `git gc --auto`, so we obviously really want to close all
read handles.

Check.

>  	}
>  }
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 50bde99618..82ce682c80 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -1240,7 +1240,7 @@ int cmd_clone(int argc, const char **argv, const c=
har *prefix)
>  	transport_disconnect(transport);
>
>  	if (option_dissociate) {
> -		close_all_packs(the_repository->objects);
> +		close_object_store(the_repository->objects);
>  		dissociate_from_references();

Here, we prepare for disassociating the reference repository specified via
`git clone --reference <directory>`. Obviously, we need to let go of all
the handles we might have open there.

Check.

>  	}
>
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index b620fd54b4..3aec95608f 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1670,7 +1670,7 @@ int cmd_fetch(int argc, const char **argv, const c=
har *prefix)
>
>  	string_list_clear(&list, 0);
>
> -	close_all_packs(the_repository->objects);
> +	close_object_store(the_repository->objects);
>
>  	argv_array_pushl(&argv_gc_auto, "gc", "--auto", NULL);

Again, a `git gc --auto` that needs closing of all read handles to the
files that might be overwritten by the garbage collection.

Check.

>  	if (verbosity < 0)
> diff --git a/builtin/gc.c b/builtin/gc.c
> index df2573f124..20c8f1bfe8 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -632,7 +632,7 @@ int cmd_gc(int argc, const char **argv, const char *=
prefix)
>  	gc_before_repack();
>
>  	if (!repository_format_precious_objects) {
> -		close_all_packs(the_repository->objects);
> +		close_object_store(the_repository->objects);
>  		if (run_command_v_opt(repack.argv, RUN_GIT_CMD))

Here, we want to repack. AFAICT it is the only sane thing we can do to
invalidate whatever we read from the object store into memory.

Check.

>  			die(FAILED_RUN, repack.argv[0]);
>
> @@ -660,7 +660,7 @@ int cmd_gc(int argc, const char **argv, const char *=
prefix)
>  	report_garbage =3D report_pack_garbage;
>  	reprepare_packed_git(the_repository);
>  	if (pack_garbage.nr > 0) {
> -		close_all_packs(the_repository->objects);
> +		close_object_store(the_repository->objects);
>  		clean_pack_garbage();

This wants to delete a number of files that are now obsolete, and it makes
sense to make sure that there are no open read handles to those anymore.
It is a bit unclear from just reading the code what types of files are
accumulated into the `pack_garbage` string list, but then, we're in the
last throngs of a garbage collection, and *just* about to write a new
commit graph (if `gc.writeCommitGraph=3Dtrue`), so I think it is quite oka=
y
to close not only the packs here, but everything we opened from the object
store.

So I'd give this a check mark, too.

>  	}
>
> diff --git a/builtin/merge.c b/builtin/merge.c
> index e47d77baee..72d7a7c909 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -449,7 +449,7 @@ static void finish(struct commit *head_commit,
>  			 * We ignore errors in 'gc --auto', since the
>  			 * user should see them.
>  			 */
> -			close_all_packs(the_repository->objects);
> +			close_object_store(the_repository->objects);
>  			run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);

Obviously yet another `git gc --auto`, so yes, we need to close the object
store handles we have.

Check.

>  		}
>  	}
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 7c7bc13e91..ed30fcd633 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -328,7 +328,7 @@ static int finish_rebase(struct rebase_options *opts=
)
>
>  	delete_ref(NULL, "REBASE_HEAD", NULL, REF_NO_DEREF);
>  	apply_autostash(opts);
> -	close_all_packs(the_repository->objects);
> +	close_object_store(the_repository->objects);
>  	/*
>  	 * We ignore errors in 'gc --auto', since the
>  	 * user should see them.

Yet another `git gc --auto`.

Check.

> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index d58b7750b6..92cd1f508c 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -2032,7 +2032,7 @@ int cmd_receive_pack(int argc, const char **argv, =
const char *prefix)
>  			proc.git_cmd =3D 1;
>  			proc.argv =3D argv_gc_auto;
>
> -			close_all_packs(the_repository->objects);
> +			close_object_store(the_repository->objects);
>  			if (!start_command(&proc)) {

This `proc` refers to another `git gc --auto` (see a couple lines above,
still within the hunk).

Check.

>  				if (use_sideband)
>  					copy_to_sideband(proc.err, -1, NULL);
> diff --git a/builtin/repack.c b/builtin/repack.c
> index 67f8978043..4de8b6600c 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -419,7 +419,7 @@ int cmd_repack(int argc, const char **argv, const ch=
ar *prefix)
>  	if (!names.nr && !po_args.quiet)
>  		printf_ln(_("Nothing new to pack."));
>
> -	close_all_packs(the_repository->objects);
> +	close_object_store(the_repository->objects);
>
>  	/*
>  	 * Ok we have prepared all new packfiles.

Ah, the joys of un-dynamic patch review. What you, dear reader, cannot see
in this hunk is that the code comment at the end continues thusly:

         * First see if there are packs of the same name and if so
         * if we can move them out of the way (this can happen if we
         * repacked immediately after packing fully.
         */

Meaning: we're about to rename some pack files. So the pack file handles
need to be closed, all right, but what about the other object store
handles? There is no mention of the commit graph (more on that below), but
the loop following the code comment contains this:

                        if (!midx_cleared) {
                                clear_midx_file(the_repository);
                                midx_cleared =3D 1;
                        }

So yes, I would give this a check.

It does puzzle me, I have to admit, that there is no (opt-in) code block
to re-write the commit graph. After all, the commit graph references the
pack files, right? So if they are repacked, it would at least be
invalidated at this point...

> diff --git a/object.c b/object.c
> index e81d47a79c..cf1a2b7086 100644
> --- a/object.c
> +++ b/object.c
> @@ -517,7 +517,7 @@ void raw_object_store_clear(struct raw_object_store =
*o)
>  	o->loaded_alternates =3D 0;
>
>  	INIT_LIST_HEAD(&o->packed_git_mru);
> -	close_all_packs(o);
> +	close_object_store(o);

We're in the middle of a function called `raw_object_store_clear()`. So...

Check.

>  	o->packed_git =3D NULL;
>  }
>
> diff --git a/packfile.c b/packfile.c
> index ce12bffe3e..017046fcf9 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -337,7 +337,7 @@ void close_pack(struct packed_git *p)
>  	close_pack_index(p);
>  }
>
> -void close_all_packs(struct raw_object_store *o)
> +void close_object_store(struct raw_object_store *o)
>  {
>  	struct packed_git *p;
>
> diff --git a/packfile.h b/packfile.h
> index d70c6d9afb..e95e389eb8 100644
> --- a/packfile.h
> +++ b/packfile.h
> @@ -81,7 +81,7 @@ extern uint32_t get_pack_fanout(struct packed_git *p, =
uint32_t value);
>  extern unsigned char *use_pack(struct packed_git *, struct pack_window =
**, off_t, unsigned long *);
>  extern void close_pack_windows(struct packed_git *);
>  extern void close_pack(struct packed_git *);
> -extern void close_all_packs(struct raw_object_store *o);
> +extern void close_object_store(struct raw_object_store *o);
>  extern void unuse_pack(struct pack_window **);
>  extern void clear_delta_base_cache(void);
>  extern struct packed_git *add_packed_git(const char *path, size_t path_=
len, int local);
> --
> gitgitgadget

And this concludes my review.

Thank you!
Dscho
