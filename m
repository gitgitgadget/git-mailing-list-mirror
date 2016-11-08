Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA5852035F
	for <e@80x24.org>; Tue,  8 Nov 2016 23:52:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753402AbcKHXwZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Nov 2016 18:52:25 -0500
Received: from mail-yw0-f194.google.com ([209.85.161.194]:34838 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752060AbcKHXwY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2016 18:52:24 -0500
Received: by mail-yw0-f194.google.com with SMTP id b66so4695775ywh.2
        for <git@vger.kernel.org>; Tue, 08 Nov 2016 15:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=k2mzLuPk8vhu4g5Dmb38j4XUph+LbPixMmIEzsFmJqk=;
        b=yXsr9HYMrnc6SVNTqHjSs6ex2HjvEfYVlXW5O6JynPyc10OTbEUm17+dsm23QbXpmR
         EZLipyXtkD2W2FQihRQhinP2FsM4FdKOci5UpxaMVoOU4zTRtl3COkvEWRLfjU5+i4w1
         JahNcxmEPOrftqtkRYQZM3kaeDHhhCQq+zMNYSlsnbQGAXvdIWpc0RvraYO5vAGVuBEx
         CTcdGNk7ZySGKeHNjAc6wqR3XgGFAf5kC5JKXNURGniE5BQCQfK1jF1Z2rC8hPfOboWu
         +DYOdNhS4p0BHlNsaFk9W2hPoGe3V6Yxrm/ffalXatUgFw/k58lW/L+LDundcIHJpUVF
         wQtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=k2mzLuPk8vhu4g5Dmb38j4XUph+LbPixMmIEzsFmJqk=;
        b=DMlz2f448FGj70he4P8bL9hDne3iC0eqsNisNufJn/bfFI7dvpBg1QINuONT4cN30b
         lkygaPpiVllqkrYlOOSGuVT2NJ88WVntvsO9EMK43X3+lt10/BRr8t2dztAYuXZxh51r
         jEv1buZt2ERQfXoTmL88kETI9K/QmturjcBpDCMnGwxJc7iAyCKhemDZBQ6fpeyRDq7t
         tkKFfi7NA+KpmlxoxvdThgmmWwT/crV0YCP4kZeePGZIJb3RGvaKRVLvFTxdE3d0ixpl
         Tn93Hra/FDL5zVwH5y7hib+mZr7hFiEHKUalPJchE9Ctxr5oKHNkLxP0FE76/g2vOAss
         bJ5A==
X-Gm-Message-State: ABUngvdCDCpj864ErzMc30v+fMXhxTJ9f0/TriR36R8WuIAx/xSTlVmX15b9uT3GBQ6g9Q36aGRxuWY4MNvWfQ==
X-Received: by 10.13.254.71 with SMTP id o68mr11400679ywf.318.1478649143645;
 Tue, 08 Nov 2016 15:52:23 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.33.132 with HTTP; Tue, 8 Nov 2016 15:52:03 -0800 (PST)
In-Reply-To: <20161108201211.25213-12-Karthik.188@gmail.com>
References: <20161108201211.25213-1-Karthik.188@gmail.com> <20161108201211.25213-12-Karthik.188@gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 8 Nov 2016 15:52:03 -0800
Message-ID: <CA+P7+xrHRMZemNfo3gjJryBRR5b4T8VT3t9_CBE5hJJfv+D3PQ@mail.gmail.com>
Subject: Re: [PATCH v7 11/17] ref-filter: introduce symref_atom_parser() and refname_atom_parser()
To:     Karthik Nayak <karthik.188@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 8, 2016 at 12:12 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> From: Karthik Nayak <karthik.188@gmail.com>
>
> Using refname_atom_parser_internal(), introduce symref_atom_parser() and
> refname_atom_parser() which will parse the atoms %(symref) and
> %(refname) respectively. Store the parsed information into the
> 'used_atom' structure based on the modifiers used along with the atoms.
>
> Now the '%(symref)' atom supports the ':strip' atom modifier. Update the
> Documentation and tests to reflect this.
>

One minor nit is that the first part is actually identical so I wonder
if it's worth having two separate functions?

Thanks,
Jake

> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
> ---
>  Documentation/git-for-each-ref.txt |  5 +++
>  ref-filter.c                       | 78 ++++++++++++++++++++++----------------
>  t/t6300-for-each-ref.sh            |  9 +++++
>  3 files changed, 59 insertions(+), 33 deletions(-)
>
> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
> index 3953431..a669a32 100644
> --- a/Documentation/git-for-each-ref.txt
> +++ b/Documentation/git-for-each-ref.txt
> @@ -166,6 +166,11 @@ if::
>         the value between the %(if:...) and %(then) atoms with the
>         given string.
>
> +symref::
> +       The ref which the given symbolic ref refers to. If not a
> +       symbolic ref, nothing is printed. Respects the `:short` and
> +       `:strip` options in the same way as `refname` above.
> +
>  In addition to the above, for commit and tag objects, the header
>  field names (`tree`, `parent`, `object`, `type`, and `tag`) can
>  be used to specify the value in the header field.
> diff --git a/ref-filter.c b/ref-filter.c
> index aad537d..f1d27b5 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -176,6 +176,16 @@ static void objectname_atom_parser(struct used_atom *atom, const char *arg)
>                 die(_("unrecognized %%(objectname) argument: %s"), arg);
>  }
>
> +static void symref_atom_parser(struct used_atom *atom, const char *arg)
> +{
> +       return refname_atom_parser_internal(&atom->u.refname, arg, atom->name);
> +}
> +
> +static void refname_atom_parser(struct used_atom *atom, const char *arg)
> +{
> +       return refname_atom_parser_internal(&atom->u.refname, arg, atom->name);
> +}
> +

What's the reasoning for using separate functions here if they are
exactly identical except for name? Do we intend to add separate
options for this? I don't really have a problem with separate
functions here since it helps avoid confusion but they are identical
otherwise...

>  static align_type parse_align_position(const char *s)
>  {
>         if (!strcmp(s, "right"))
> @@ -244,7 +254,7 @@ static struct {
>         cmp_type cmp_type;
>         void (*parser)(struct used_atom *atom, const char *arg);
>  } valid_atom[] = {
> -       { "refname" },
> +       { "refname" , FIELD_STR, refname_atom_parser },
>         { "objecttype" },
>         { "objectsize", FIELD_ULONG },
>         { "objectname", FIELD_STR, objectname_atom_parser },
> @@ -273,7 +283,7 @@ static struct {
>         { "contents", FIELD_STR, contents_atom_parser },
>         { "upstream", FIELD_STR, remote_ref_atom_parser },
>         { "push", FIELD_STR, remote_ref_atom_parser },
> -       { "symref" },
> +       { "symref", FIELD_STR, symref_atom_parser },
>         { "flag" },
>         { "HEAD" },
>         { "color", FIELD_STR, color_atom_parser },
> @@ -1058,21 +1068,16 @@ static inline char *copy_advance(char *dst, const char *src)
>         return dst;
>  }
>
> -static const char *strip_ref_components(const char *refname, const char *nr_arg)
> +static const char *strip_ref_components(const char *refname, unsigned int len)
>  {
> -       char *end;
> -       long nr = strtol(nr_arg, &end, 10);
> -       long remaining = nr;
> +       long remaining = len;
>         const char *start = refname;
>
> -       if (nr < 1 || *end != '\0')
> -               die(_(":strip= requires a positive integer argument"));
> -
>         while (remaining) {
>                 switch (*start++) {
>                 case '\0':
> -                       die(_("ref '%s' does not have %ld components to :strip"),
> -                           refname, nr);
> +                       die(_("ref '%s' does not have %ud components to :strip"),
> +                           refname, len);
>                 case '/':
>                         remaining--;
>                         break;
> @@ -1081,6 +1086,16 @@ static const char *strip_ref_components(const char *refname, const char *nr_arg)
>         return start;
>  }
>
> +static const char *show_ref(struct refname_atom *atom, const char *refname)
> +{
> +       if (atom->option == R_SHORT)
> +               return shorten_unambiguous_ref(refname, warn_ambiguous_refs);
> +       else if (atom->option == R_STRIP)
> +               return strip_ref_components(refname, atom->strip);
> +       else
> +               return refname;
> +}
> +
>  static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
>                                     struct branch *branch, const char **s)
>  {
> @@ -1153,6 +1168,21 @@ char *get_head_description(void)
>         return strbuf_detach(&desc, NULL);
>  }
>
> +static const char *get_symref(struct used_atom *atom, struct ref_array_item *ref)
> +{
> +       if (!ref->symref)
> +               return "";
> +       else
> +               return show_ref(&atom->u.refname, ref->symref);
> +}
> +
> +static const char *get_refname(struct used_atom *atom, struct ref_array_item *ref)
> +{
> +       if (ref->kind & FILTER_REFS_DETACHED_HEAD)
> +               return get_head_description();
> +       return show_ref(&atom->u.refname, ref->refname);
> +}
> +
>  /*
>   * Parse the object referred by ref, and grab needed value.
>   */
> @@ -1181,7 +1211,6 @@ static void populate_value(struct ref_array_item *ref)
>                 struct atom_value *v = &ref->value[i];
>                 int deref = 0;
>                 const char *refname;
> -               const char *formatp;
>                 struct branch *branch = NULL;
>
>                 v->handler = append_atom;
> @@ -1192,12 +1221,10 @@ static void populate_value(struct ref_array_item *ref)
>                         name++;
>                 }
>
> -               if (starts_with(name, "refname")) {
> -                       refname = ref->refname;
> -                       if (ref->kind & FILTER_REFS_DETACHED_HEAD)
> -                               refname = get_head_description();
> -               } else if (starts_with(name, "symref"))
> -                       refname = ref->symref ? ref->symref : "";
> +               if (starts_with(name, "refname"))
> +                       refname = get_refname(atom, ref);
> +               else if (starts_with(name, "symref"))
> +                       refname = get_symref(atom, ref);
>                 else if (starts_with(name, "upstream")) {
>                         const char *branch_name;
>                         /* only local branches may have an upstream */
> @@ -1273,21 +1300,6 @@ static void populate_value(struct ref_array_item *ref)
>                 } else
>                         continue;
>
> -               formatp = strchr(name, ':');
> -               if (formatp) {
> -                       const char *arg;
> -
> -                       formatp++;
> -                       if (!strcmp(formatp, "short"))
> -                               refname = shorten_unambiguous_ref(refname,
> -                                                     warn_ambiguous_refs);
> -                       else if (skip_prefix(formatp, "strip=", &arg))
> -                               refname = strip_ref_components(refname, arg);
> -                       else
> -                               die(_("unknown %.*s format %s"),
> -                                   (int)(formatp - name), name, formatp);
> -               }
> -
>                 if (!deref)
>                         v->s = refname;
>                 else
> diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
> index b06ea1c..3d28234 100755
> --- a/t/t6300-for-each-ref.sh
> +++ b/t/t6300-for-each-ref.sh
> @@ -589,4 +589,13 @@ test_expect_success 'Verify usage of %(symref:short) atom' '
>         test_cmp expected actual
>  '
>
> +cat >expected <<EOF
> +master
> +EOF
> +
> +test_expect_success 'Verify usage of %(symref:strip) atom' '
> +       git for-each-ref --format="%(symref:strip=2)" refs/heads/sym > actual &&
> +       test_cmp expected actual
> +'
> +
>  test_done
> --
> 2.10.2
>
