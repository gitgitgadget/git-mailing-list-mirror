Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52AE91F404
	for <e@80x24.org>; Thu, 15 Mar 2018 20:47:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752720AbeCOUrU (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 16:47:20 -0400
Received: from mail-wr0-f180.google.com ([209.85.128.180]:39768 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752011AbeCOUrT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 16:47:19 -0400
Received: by mail-wr0-f180.google.com with SMTP id k3so9645457wrg.6
        for <git@vger.kernel.org>; Thu, 15 Mar 2018 13:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xcyyd42teGGYZUwanW7p/mvSc9HPrwQtOhQx2xoAh28=;
        b=WoAjEwRD7g6Dz1U3eAD9uLvy+q0yOrux4DUL78heySfjqYivJMDD6Q7GkKgnDlKU6C
         7ZUBW//s3fp6oWKoCa9ID21CD77ElbldBvOk6NXAsKLGEo0fvnP86HEFFITbA39FwOrf
         XaE/XWxauXkIryRbUNnv9le1Y0Tyc7jEObgq96+gnDvukzahjzx9B9NDS7a1td0B5YcQ
         4mKqB+KxPUxEL+i6inJQfhyFo1BoNwfHvvlBwejbKnsdHuj32ExC51b6mZ8nl+mv/v/l
         yOBN9Sdx4H5NKH7EZX9eAlOQFc0Vyode6ENHcnmPPNNVNk1YxpJqNgmidq561N7jLyGw
         NHiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xcyyd42teGGYZUwanW7p/mvSc9HPrwQtOhQx2xoAh28=;
        b=AQ588qI7ynK9syLFvvryCKNkN8CXZ7pKfLnISwsMR54eqULK9Vj62mMG9+y61hNhK/
         zGmElx9UdTZKDvqG1tSzGDhIof7lN+PL5MFvLM27XVMj10RzUqNr9Lhn2ZANmlmuNRnx
         rsFuiEnCaKSE7ZZ/F5ZzND7QxagnUg212iuwgndmCT3ZhISfhIizNTFqY454gNLYCGmp
         4qZwNKcRJvamZaIhiLPlECi4Q83qC2OmXOIWMdX3Y322Rv0NRK0kb4g6tZgPdHYeGXyH
         /wHoXpPr1l1hf3aaXs0aHx64W0sJn51Y26r7dhVDuRlf4m9h7DRUbQG0FElC5VLZFdKW
         4bGg==
X-Gm-Message-State: AElRT7GDZ56OxVMK34+bpjjvK/ymtHjbWh+1rXqayiQM5WSiKcGfIZa1
        5qAVirqtHqT4pixH2D+1RDHod6km
X-Google-Smtp-Source: AG47ELtZ4JzQqtlyR2Jvlpw12WyX7tW22aMFum1CuSQWrJTa5JqHJE1XARFgc4J3W1Ck3Fy0uce5qA==
X-Received: by 10.223.190.15 with SMTP id n15mr8915190wrh.82.1521146837554;
        Thu, 15 Mar 2018 13:47:17 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id 41sm5759183wrc.33.2018.03.15.13.47.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Mar 2018 13:47:16 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     Olga Telezhnaya <olyatelezhnaya@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 5/5] ref-filter: get_ref_atom_value() error handling
Date:   Thu, 15 Mar 2018 21:47:09 +0100
Message-Id: <20180315204709.1900787-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.16.2.246.ga4ee44448f
In-Reply-To: <0102016225e61cc2-0d0c05ef-b999-4bf2-88ac-db9840dd2a87-000000@eu-west-1.amazonses.com>
References: <0102016225e61cc2-0d0c05ef-b999-4bf2-88ac-db9840dd2a87-000000@eu-west-1.amazonses.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I skimmed the first four patches of this v2. It seems that patches 1 and
4 are identical to v2. Patches 2 and 3 have very straightforward changes
based on my earlier comments. Let's see what this patch is about. :-)

On 14 March 2018 at 20:04, Olga Telezhnaya <olyatelezhnaya@gmail.com> wrote:
> Finish removing any printing from ref-filter formatting logic,
> so that it could be more general.
>
> Change the signature of get_ref_atom_value() and underlying functions
> by adding return value and strbuf parameter for error message.
>
> It's important to mention that grab_objectname() returned 1 if
> it gets objectname atom and 0 otherwise. Now this logic changed:
> we return 0 if we have no error, -1 otherwise. If someone needs to
> know whether it's objectname atom or not, he/she could use
> starts_with() function. It duplicates this checking but it does not
> sound like a really big overhead.
>
> Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
> ---
>  ref-filter.c | 109 +++++++++++++++++++++++++++++++++++++----------------------
>  1 file changed, 69 insertions(+), 40 deletions(-)
>
> diff --git a/ref-filter.c b/ref-filter.c
> index 62ea4adcd0ff1..3f0c3924273d5 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -831,26 +831,27 @@ static void *get_obj(const struct object_id *oid, struct object **obj, unsigned
>  }
>
>  static int grab_objectname(const char *name, const unsigned char *sha1,
> -                          struct atom_value *v, struct used_atom *atom)
> +                          struct atom_value *v, struct used_atom *atom,
> +                          struct strbuf *err)
>  {
>         if (starts_with(name, "objectname")) {
>                 if (atom->u.objectname.option == O_SHORT) {
>                         v->s = xstrdup(find_unique_abbrev(sha1, DEFAULT_ABBREV));
> -                       return 1;
>                 } else if (atom->u.objectname.option == O_FULL) {
>                         v->s = xstrdup(sha1_to_hex(sha1));
> -                       return 1;
>                 } else if (atom->u.objectname.option == O_LENGTH) {
>                         v->s = xstrdup(find_unique_abbrev(sha1, atom->u.objectname.length));
> -                       return 1;
> -               } else
> -                       die("BUG: unknown %%(objectname) option");
> +               } else {
> +                       strbuf_addstr(err, "BUG: unknown %(objectname) option");
> +                       return -1;
> +               }
>         }
>         return 0;
>  }

This is interesting. This die() is never ever supposed to actually
trigger, except to allow a developer adding some new O_xxx-value to
quickly notice that they have forgotten to add code here.

>  /* See grab_values */
> -static void grab_common_values(struct atom_value *val, int deref, struct object *obj, void *buf, unsigned long sz)
> +static int grab_common_values(struct atom_value *val, int deref, struct object *obj,
> +                             void *buf, unsigned long sz, struct strbuf *err)
>  {
>         int i;
>
> @@ -868,8 +869,10 @@ static void grab_common_values(struct atom_value *val, int deref, struct object
>                         v->s = xstrfmt("%lu", sz);
>                 }
>                 else if (deref)
> -                       grab_objectname(name, obj->oid.hash, v, &used_atom[i]);
> +                       if (grab_objectname(name, obj->oid.hash, v, &used_atom[i], err))
> +                               return -1;
>         }
> +       return 0;
>  }

So if that conversion I commented on above had not happened, this would
not have been necessary. Let's read on...

>  /* See grab_values */
> @@ -1225,9 +1228,11 @@ static void fill_missing_values(struct atom_value *val)
>   * pointed at by the ref itself; otherwise it is the object the
>   * ref (which is a tag) refers to.
>   */
> -static void grab_values(struct atom_value *val, int deref, struct object *obj, void *buf, unsigned long sz)
> +static int grab_values(struct atom_value *val, int deref, struct object *obj,
> +                      void *buf, unsigned long sz, struct strbuf *err)
>  {
> -       grab_common_values(val, deref, obj, buf, sz);
> +       if (grab_common_values(val, deref, obj, buf, sz, err))
> +               return -1;
>         switch (obj->type) {
>         case OBJ_TAG:
>                 grab_tag_values(val, deref, obj, buf, sz);
> @@ -1247,8 +1252,10 @@ static void grab_values(struct atom_value *val, int deref, struct object *obj, v
>                 /* grab_blob_values(val, deref, obj, buf, sz); */
>                 break;
>         default:
> -               die("Eh?  Object of type %d?", obj->type);
> +               strbuf_addf(err, "Eh?  Object of type %d?", obj->type);
> +               return -1;
>         }
> +       return 0;
>  }

This seems similar. The string here is quite sloppy, and I do not
believe that the author intended this to be user-visible. I believe this
is more like a very short way of saying "how could we possibly get
here??". It could also be written as die("BUG: unknown object type %d",
obj->type), or even better: BUG(...).

>  static inline char *copy_advance(char *dst, const char *src)
> @@ -1335,8 +1342,9 @@ static const char *show_ref(struct refname_atom *atom, const char *refname)
>                 return refname;
>  }
>
> -static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
> -                                   struct branch *branch, const char **s)
> +static int fill_remote_ref_details(struct used_atom *atom, const char *refname,
> +                                  struct branch *branch, const char **s,
> +                                  struct strbuf *err)
>  {
>         int num_ours, num_theirs;
>         if (atom->u.remote_ref.option == RR_REF)
> @@ -1362,7 +1370,7 @@ static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
>         } else if (atom->u.remote_ref.option == RR_TRACKSHORT) {
>                 if (stat_tracking_info(branch, &num_ours, &num_theirs,
>                                        NULL, AHEAD_BEHIND_FULL) < 0)
> -                       return;
> +                       return 0;
>
>                 if (!num_ours && !num_theirs)
>                         *s = "=";
> @@ -1391,8 +1399,11 @@ static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
>                         *s = xstrdup(merge);
>                 else
>                         *s = "";
> -       } else
> -               die("BUG: unhandled RR_* enum");
> +       } else {
> +               strbuf_addstr(err, "BUG: unhandled RR_* enum");
> +               return -1;
> +       }
> +       return 0;
>  }

This one too.. I start to think it is overkill to wire through these
strbufs just to collect messages that should never ever be produced.  It
almost seems to me like if 1) we want to collect errors using strbufs,
and 2) we want to use BUG() for these sorts of assertions, then 3) we
will be wiring error-strbufs through more or less all of our code. I am
exaggerating, but there is something to it: A small change deep down a
callstack where you want to add a BUG() "to be safe", and you might need
to wire a strbuf all the way through.

According to d8193743e0 (usage.c: add BUG() function, 2017-05-12), a
good thing about BUG() is that we can get a core dump, a filename and a
line number. That opportunity gets lost if we do these sort of
transformations. Of course, these were only die("BUG: "), not BUG(), but
my point is that they should perhaps have been BUG().

>  char *get_head_description(void)
> @@ -1447,28 +1458,33 @@ static const char *get_refname(struct used_atom *atom, struct ref_array_item *re
>         return show_ref(&atom->u.refname, ref->refname);
>  }
>
> -static void get_object(struct ref_array_item *ref, const struct object_id *oid,
> -                      int deref, struct object **obj)
> +static int get_object(struct ref_array_item *ref, const struct object_id *oid,
> +                      int deref, struct object **obj, struct strbuf *err)
>  {
>         int eaten;
>         unsigned long size;
>         void *buf = get_obj(oid, obj, &size, &eaten);
> -       if (!buf)
> -               die(_("missing object %s for %s"),
> -                   oid_to_hex(oid), ref->refname);
> -       if (!*obj)
> -               die(_("parse_object_buffer failed on %s for %s"),
> -                   oid_to_hex(oid), ref->refname);
> -
> -       grab_values(ref->value, deref, *obj, buf, size);
> +       if (!buf) {
> +               strbuf_addf(err, _("missing object %s for %s"), oid_to_hex(oid),
> +                           ref->refname);
> +               return -1;
> +       }
> +       if (!*obj) {
> +               strbuf_addf(err, _("parse_object_buffer failed on %s for %s"),
> +                           oid_to_hex(oid), ref->refname);
> +               return -1;
> +       }
> +       if (grab_values(ref->value, deref, *obj, buf, size, err))
> +               return -1;
>         if (!eaten)
>                 free(buf);
> +       return 0;
>  }

These are "real" errors and yield several more changes in the remainder.
Ignoring those BUG-type messages at the beginning of this patch would
give a patch like the one below. Maybe that would be a bit less
intrusive for the same gain.

Thanks for working on this. I feel that your patches are really
interesting. They open up many possibilities for philosophical exercises
about how errors should be collected and reported. ;-) I would be
interested in knowing your thoughts, and others'.

Martin

---
 ref-filter.c | 51 ++++++++++++++++++++++++++++++++-------------------
 1 file changed, 32 insertions(+), 19 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 62ea4adcd0..e41505b3c0 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1447,28 +1447,32 @@ static const char *get_refname(struct used_atom *atom, struct ref_array_item *re
 	return show_ref(&atom->u.refname, ref->refname);
 }
 
-static void get_object(struct ref_array_item *ref, const struct object_id *oid,
-		       int deref, struct object **obj)
+static int get_object(struct ref_array_item *ref, const struct object_id *oid,
+		       int deref, struct object **obj, struct strbuf *err)
 {
 	int eaten;
 	unsigned long size;
 	void *buf = get_obj(oid, obj, &size, &eaten);
-	if (!buf)
-		die(_("missing object %s for %s"),
-		    oid_to_hex(oid), ref->refname);
-	if (!*obj)
-		die(_("parse_object_buffer failed on %s for %s"),
-		    oid_to_hex(oid), ref->refname);
-
+	if (!buf) {
+		strbuf_addf(err, _("missing object %s for %s"), oid_to_hex(oid),
+			    ref->refname);
+		return -1;
+	}
+	if (!*obj) {
+		strbuf_addf(err, _("parse_object_buffer failed on %s for %s"),
+			    oid_to_hex(oid), ref->refname);
+		return -1;
+	}
 	grab_values(ref->value, deref, *obj, buf, size);
 	if (!eaten)
 		free(buf);
+	return 0;
 }
 
 /*
  * Parse the object referred by ref, and grab needed value.
  */
-static void populate_value(struct ref_array_item *ref)
+static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 {
 	struct object *obj;
 	int i;
@@ -1590,16 +1594,17 @@ static void populate_value(struct ref_array_item *ref)
 			break;
 	}
 	if (used_atom_cnt <= i)
-		return;
+		return 0;
 
-	get_object(ref, &ref->objectname, 0, &obj);
+	if (get_object(ref, &ref->objectname, 0, &obj, err))
+		return -1;
 
 	/*
 	 * If there is no atom that wants to know about tagged
 	 * object, we are done.
 	 */
 	if (!need_tagged || (obj->type != OBJ_TAG))
-		return;
+		return 0;
 
 	/*
 	 * If it is a tag object, see if we use a value that derefs
@@ -1613,20 +1618,23 @@ static void populate_value(struct ref_array_item *ref)
 	 * is not consistent with what deref_tag() does
 	 * which peels the onion to the core.
 	 */
-	get_object(ref, tagged, 1, &obj);
+	return get_object(ref, tagged, 1, &obj, err);
 }
 
 /*
  * Given a ref, return the value for the atom.  This lazily gets value
  * out of the object by calling populate value.
  */
-static void get_ref_atom_value(struct ref_array_item *ref, int atom, struct atom_value **v)
+static int get_ref_atom_value(struct ref_array_item *ref, int atom,
+			      struct atom_value **v, struct strbuf *err)
 {
 	if (!ref->value) {
-		populate_value(ref);
+		if (populate_value(ref, err))
+			return -1;
 		fill_missing_values(ref->value);
 	}
 	*v = &ref->value[atom];
+	return 0;
 }
 
 /*
@@ -2150,9 +2158,13 @@ static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array_item *a, stru
 	int cmp;
 	cmp_type cmp_type = used_atom[s->atom].type;
 	int (*cmp_fn)(const char *, const char *);
+	struct strbuf err = STRBUF_INIT;
 
-	get_ref_atom_value(a, s->atom, &va);
-	get_ref_atom_value(b, s->atom, &vb);
+	if (get_ref_atom_value(a, s->atom, &va, &err))
+		die("%s", err.buf);
+	if (get_ref_atom_value(b, s->atom, &vb, &err))
+		die("%s", err.buf);
+	strbuf_release(&err);
 	cmp_fn = s->ignore_case ? strcasecmp : strcmp;
 	if (s->version)
 		cmp = versioncmp(va->s, vb->s);
@@ -2231,7 +2243,8 @@ int format_ref_array_item(struct ref_array_item *info,
 			append_literal(cp, sp, &state);
 		if (parse_ref_filter_atom(format, sp + 2, ep, &pos, error_buf))
 			return -1;
-		get_ref_atom_value(info, pos, &atomv);
+		if (get_ref_atom_value(info, pos, &atomv, error_buf))
+			return -1;
 		if (atomv->handler(atomv, &state, error_buf))
 			return -1;
 	}
-- 
2.16.2.246.ga4ee44448f

