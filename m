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
	by dcvr.yhbt.net (Postfix) with ESMTP id DEF8B1F454
	for <e@80x24.org>; Thu,  7 Nov 2019 12:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388378AbfKGM61 (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 07:58:27 -0500
Received: from mout.gmx.net ([212.227.15.19]:37985 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726873AbfKGM60 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 07:58:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1573131500;
        bh=DjcAlx7TJrwfOZBDPPRt6T/ELHd6KS9+PCeUBgu2sE0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=MWBg68QOmh0+tQHylLqS+Y2Ooc9OlItyurNspS3JSugvLfKWITS8uJaPjyesNT1LU
         BDETURMRo0E9twIsxuc7+YHxl7ar0Rm5b55yXuZZENhGw4V5Exk/oMv80MdYRFeejA
         WlRht7PUW2skiZWeVjz7df8pB/XaEnz2TycZmCdg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MJVDW-1iDNP22DwO-00JnqR; Thu, 07
 Nov 2019 13:58:20 +0100
Date:   Thu, 7 Nov 2019 13:58:04 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org
Subject: Re: [BUG] "fatal: bad object .alternate" during fetch with
 alternates
In-Reply-To: <20191106214201.GB8521@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1911071349590.46@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.1911041053190.46@tvgsbejvaqbjf.bet> <20191106205907.GA4122@sigill.intra.peff.net> <20191106214201.GB8521@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:4kV5d+bo0Qzq1aePPIUdt+NBJLUR5NWkaaPKL2O6DqbrLO0G4R/
 EG/kI3wlrh3Cn3yaj8taNLL+EhoFXzEXkYClWGDwnzpgZVhPfXY/13Atd5aGv1Ir7RlHHtb
 ys+b/acUC659tkhZRZtl/qt9A5a4bo4tfYN0ePLO6gbV6/OGcwct/5fK5Mvuz7LWY5gB/bC
 lPBvefeXcTh6rLPnaFs/A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ivBAhUTYBek=:Nxiar0g43varAwe4EEoZ8W
 hSEvbY0Jf7sChvgh8N1daWWwuNyK2PVmYUDxXC8IalL9L8e5/vm8eUVWWM55F92YfEeGNsCwT
 iwCFkvGRBmDFWP7TUO0/sa1B61XpGznyxONDaHX3HovAzogRgKU9QCHjXuv1ZeWBXSWuJVQim
 bNdxnZx1STTMB5mzCq3uAAvBNtpuUCqF1bNU5a+czAAyK3Ajj7eOY6CchU1ifb2Rir5McDYWQ
 HXEbooCld4tJLdZeSW2WGz1SZzMlHgIiTO/vhBxleAGnnung+L7fw7vtzNaGNTbK7iVpcbYai
 EENAQCrQh5WHQGZt82/KU5FRPKoLIQ02DOAK616/1n2r/6kcedl3vG8Q55D/Hxl03eJCXKv0z
 lfw2QfY8pHsoxZj7EpfVaQt3BvX2vcfxQ3YrcqNXRE5+ltFr+vekXZCAjEG3sl6u8RAYY8Tru
 /GQivNzKrZ6N2/hwMQMSE1iQaEc+IV4gaMywUZoHQZq+rQNQJLTaxRMStYZqVXT9ZflbLKaJu
 8oL0j/UBYmY6ie6XWYPLLIR+bdEsbwCgXR/YX0tFaMGT0EmAzYFWJSCf8KAEN72JBeRjVV1LH
 LOPA0PyQqtKw8xPcNfyNeNbrQpmtsqUScgtPFveOsOvMmLmKxg8AqNV0UUGSRrHs4DNAtIQEj
 OgVxt+dd4amEsgnBIT0gmC9f734ZjsI8Hb6kgwZi2CesnlGzeX3qoVLbkjWg7HKxdr5wayrJg
 b0kdlzWXmI628eNRZ8SO5E//+NUb1Dyp3awFXCizBeCQa/Bqu8bqXUkkoVwWFoc971DqRcc5p
 psZazgNEGuIS8woP1OKA4la5e6cBorEHdR1/ax6tIc2ZT7g8CDIDF4LbSRT9ljwU3qMvJ/52h
 GRuQuRRKV+BRR8uGWcZepU8HXKUVVUcC94Fwi9Se3MGUeNJt14cKi/XtLTRr8W+9TmF1bFWA+
 cP2QUaDOyb8cW0bhvqLGjTJiyMQHbRR+54yR/mb+vHK1eK6YloevQPWfNW1IgzxlVRSAYBGyt
 tu8pH+8BSAa6Lv3+uInEfvHtEoNHuEbSIREFw9+//XDSc6vsXtNWcITKQvTQ1PFbvkTwij2zq
 or6P578if3e/x4RbcUFpWe1nR8pTGIkfJmyKEhBKK7BAsZ7/9l9j+7MSz75dHs95+cdtG+THI
 kLFA+T26YQDi4r6Qa1ThbHneXZ/Xlod/3MeHlOpIcd9Tztn4J39OvEc7aLcfW+xKp6fcBF85B
 XC3rVHpRhi5cSBGogzggyVx0qK4Ee9o0JlU77P9jaVQ+8Plxm/OAOTdhwNK0=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Wed, 6 Nov 2019, Jeff King wrote:

> On Wed, Nov 06, 2019 at 03:59:07PM -0500, Jeff King wrote:
>
> > > So I see two problems with this error message:
> > >
> > > - It is not helpful. It should not say `.alternate`, it should menti=
on
> > >   the ref itself, and ideally even the path of the alternate.
> >
> > It doesn't know the refname. The data transfer between the alternate a=
nd
> > the borrowing repo was tightened to just pass over object names. We
> > could probably pass the alternate path, though.
>
> The patch to do that is pretty simple (there's a little collateral
> damage from having to update the callback signature). I've included it
> at the end of this message.
>
> But I feel a little iffy stuffing arbitrary strings into what's usually
> a refname (or a syntactically invalid pseudo-refname like ".alternate").

Hmm. I hoped that it would be simpler than this, indeed.

So what about the idea of ignoring (with a warning) them instead,
without bothering to try saying much about the alternate itself? I.e.
something like this patch (which is admittedly a bit verbose because it
_also_ has to update a signature):

=2D- snip --
diff --git a/revision.c b/revision.c
index 0e39b2b8a59..0170ae16166 100644
=2D-- a/revision.c
+++ b/revision.c
@@ -357,7 +357,7 @@ void add_head_to_pending(struct rev_info *revs)

 static struct object *get_reference(struct rev_info *revs, const char *na=
me,
 				    const struct object_id *oid,
-				    unsigned int flags)
+				    unsigned int flags, int ignore_missing)
 {
 	struct object *object;

@@ -376,7 +376,7 @@ static struct object *get_reference(struct rev_info *r=
evs, const char *name,
 	}

 	if (!object) {
-		if (revs->ignore_missing)
+		if (revs->ignore_missing || ignore_missing)
 			return object;
 		if (revs->exclude_promisor_objects && is_promisor_object(oid))
 			return NULL;
@@ -389,7 +389,7 @@ static struct object *get_reference(struct rev_info *r=
evs, const char *name,
 void add_pending_oid(struct rev_info *revs, const char *name,
 		      const struct object_id *oid, unsigned int flags)
 {
-	struct object *object =3D get_reference(revs, name, oid, flags);
+	struct object *object =3D get_reference(revs, name, oid, flags, 0);
 	add_pending_object(revs, object, name);
 }

@@ -1356,7 +1356,7 @@ static int handle_one_ref(const char *path, const st=
ruct object_id *oid,
 	if (ref_excluded(cb->all_revs->ref_excludes, path))
 	    return 0;

-	object =3D get_reference(cb->all_revs, path, oid, cb->all_flags);
+	object =3D get_reference(cb->all_revs, path, oid, cb->all_flags, 0);
 	add_rev_cmdline(cb->all_revs, object, path, REV_CMD_REF, cb->all_flags);
 	add_pending_oid(cb->all_revs, path, oid, cb->all_flags);
 	return 0;
@@ -1569,7 +1569,11 @@ static void add_one_alternate_ref(const struct obje=
ct_id *oid,
 	struct add_alternate_refs_data *data =3D vdata;
 	struct object *obj;

-	obj =3D get_reference(data->revs, name, oid, data->flags);
+	if (!(obj =3D get_reference(data->revs, name, oid, data->flags, 1))) {
+		warning("ignoring stale alternate reference to '%s'",
+			oid_to_hex(oid));
+		return;
+	}
 	add_rev_cmdline(data->revs, obj, name, REV_CMD_REV, data->flags);
 	add_pending_object(data->revs, obj, name);
 }
@@ -1600,7 +1604,7 @@ static int add_parents_only(struct rev_info *revs, c=
onst char *arg_, int flags,
 	if (get_oid_committish(arg, &oid))
 		return 0;
 	while (1) {
-		it =3D get_reference(revs, arg, &oid, 0);
+		it =3D get_reference(revs, arg, &oid, 0, 0);
 		if (!it && revs->ignore_missing)
 			return 0;
 		if (it->type !=3D OBJ_TAG)
@@ -1905,7 +1909,7 @@ int handle_revision_arg(const char *arg_, struct rev=
_info *revs, int flags, unsi
 		return revs->ignore_missing ? 0 : -1;
 	if (!cant_be_filename)
 		verify_non_filename(revs->prefix, arg);
-	object =3D get_reference(revs, arg, &oid, flags ^ local_flags);
+	object =3D get_reference(revs, arg, &oid, flags ^ local_flags, 0);
 	if (!object)
 		return revs->ignore_missing ? 0 : -1;
 	add_rev_cmdline(revs, object, arg_, REV_CMD_REV, flags ^ local_flags);
@@ -2647,7 +2651,7 @@ int setup_revisions(int argc, const char **argv, str=
uct rev_info *revs, struct s
 		struct object_context oc;
 		if (get_oid_with_context(revs->repo, revs->def, 0, &oid, &oc))
 			diagnose_missing_default(revs->def);
-		object =3D get_reference(revs, revs->def, &oid, 0);
+		object =3D get_reference(revs, revs->def, &oid, 0, 0);
 		add_pending_object_with_mode(revs, object, revs->def, oc.mode);
 	}
=2D- snap --

What do you think?

Ciao,
Dscho

>
> E.g., here's the output of t5618 with this patch:
>
>   expecting success of 5618.6 'log --source shows .alternate marker':
>   	git log --oneline --source --remotes=3Dorigin >expect.orig &&
>   	sed "s/origin.* /.alternate /" <expect.orig >expect &&
>   	git log --oneline --source --alternate-refs >actual &&
>   	test_cmp expect actual
>
>   --- expect	2019-11-06 21:37:06.435427982 +0000
>   +++ actual	2019-11-06 21:37:06.439427949 +0000
>   @@ -1,3 +1,3 @@
>   -e9067a7	.alternate two
>   -eae7140	.alternate one
>   -00f38a4	.alternate base
>   +e9067a7	.alternate from /home/peff/compile/git/t/trash directory.t561=
8-alternate-refs/.git two
>   +eae7140	.alternate from /home/peff/compile/git/t/trash directory.t561=
8-alternate-refs/.git one
>   +00f38a4	.alternate from /home/peff/compile/git/t/trash directory.t561=
8-alternate-refs/.git base
>   not ok 6 - log --source shows .alternate marker
>
>
> I wonder if a better approach would be to improve the "bad object"
> message. It prints the "name", but never even mentions the bogus oid it
> found! So with this much simpler change:
>
>   diff --git a/revision.c b/revision.c
>   index 309cd31488..4e55a9248c 100644
>   --- a/revision.c
>   +++ b/revision.c
>   @@ -380,7 +380,7 @@ static struct object *get_reference(struct rev_inf=
o *revs, const char *name,
>                           return object;
>                   if (revs->exclude_promisor_objects && is_promisor_obje=
ct(oid))
>                           return NULL;
>   -               die("bad object %s", name);
>   +               die(_("bad object %s (from %s)"), oid_to_hex(oid), nam=
e);
>           }
>           object->flags |=3D flags;
>           return object;
>
> You'd get something like:
>
>   fatal: bad object: 1234abcd... (from refs/heads/master)
>
> or
>
>   fatal: bad object: 1234abcd... (from .alternate)
>
> which seems strictly better in the first case, and passably less
> confusing in the second.
>
> -Peff
>
> ---
> Here's the "name objects after their alternate path" patch:
>
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index 411e0b4d99..300249b44a 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -280,7 +280,8 @@ static int show_ref_cb(const char *path_full, const =
struct object_id *oid,
>  	return 0;
>  }
>
> -static void show_one_alternate_ref(const struct object_id *oid,
> +static void show_one_alternate_ref(const char *altpath,
> +				   const struct object_id *oid,
>  				   void *data)
>  {
>  	struct oidset *seen =3D data;
> diff --git a/fetch-pack.c b/fetch-pack.c
> index 0130b44112..553741341b 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -75,7 +75,8 @@ struct alternate_object_cache {
>  	size_t nr, alloc;
>  };
>
> -static void cache_one_alternate(const struct object_id *oid,
> +static void cache_one_alternate(const char *altpath,
> +				const struct object_id *oid,
>  				void *vcache)
>  {
>  	struct alternate_object_cache *cache =3D vcache;
> diff --git a/object-store.h b/object-store.h
> index 7f7b3cdd80..0066a14f66 100644
> --- a/object-store.h
> +++ b/object-store.h
> @@ -33,7 +33,7 @@ void prepare_alt_odb(struct repository *r);
>  char *compute_alternate_path(const char *path, struct strbuf *err);
>  typedef int alt_odb_fn(struct object_directory *, void *);
>  int foreach_alt_odb(alt_odb_fn, void*);
> -typedef void alternate_ref_fn(const struct object_id *oid, void *);
> +typedef void alternate_ref_fn(const char *altpath, const struct object_=
id *oid, void *);
>  void for_each_alternate_ref(alternate_ref_fn, void *);
>
>  /*
> diff --git a/revision.c b/revision.c
> index 0e39b2b8a5..077a47f2e6 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -1560,27 +1560,34 @@ void add_index_objects_to_pending(struct rev_inf=
o *revs, unsigned int flags)
>  struct add_alternate_refs_data {
>  	struct rev_info *revs;
>  	unsigned int flags;
> +	struct strbuf *name;
>  };
>
> -static void add_one_alternate_ref(const struct object_id *oid,
> +static void add_one_alternate_ref(const char *altpath,
> +				  const struct object_id *oid,
>  				  void *vdata)
>  {
> -	const char *name =3D ".alternate";
>  	struct add_alternate_refs_data *data =3D vdata;
>  	struct object *obj;
>
> -	obj =3D get_reference(data->revs, name, oid, data->flags);
> -	add_rev_cmdline(data->revs, obj, name, REV_CMD_REV, data->flags);
> -	add_pending_object(data->revs, obj, name);
> +	strbuf_reset(data->name);
> +	strbuf_addf(data->name, ".alternate from %s", altpath);
> +
> +	obj =3D get_reference(data->revs, data->name->buf, oid, data->flags);
> +	add_rev_cmdline(data->revs, obj, data->name->buf, REV_CMD_REV, data->f=
lags);
> +	add_pending_object(data->revs, obj, data->name->buf);
>  }
>
>  static void add_alternate_refs_to_pending(struct rev_info *revs,
>  					  unsigned int flags)
>  {
> +	struct strbuf name =3D STRBUF_INIT;
>  	struct add_alternate_refs_data data;
>  	data.revs =3D revs;
>  	data.flags =3D flags;
> +	data.name =3D &name;
>  	for_each_alternate_ref(add_one_alternate_ref, &data);
> +	strbuf_release(&name);
>  }
>
>  static int add_parents_only(struct rev_info *revs, const char *arg_, in=
t flags,
> diff --git a/sha1-file.c b/sha1-file.c
> index 188de57634..e1709fdf30 100644
> --- a/sha1-file.c
> +++ b/sha1-file.c
> @@ -793,7 +793,7 @@ static void read_alternate_refs(const char *path,
>  			break;
>  		}
>
> -		cb(&oid, data);
> +		cb(path, &oid, data);
>  	}
>
>  	fclose(fh);
>
