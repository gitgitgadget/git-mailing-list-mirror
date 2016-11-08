Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C41A32035F
	for <e@80x24.org>; Tue,  8 Nov 2016 23:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751244AbcKHX2R (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Nov 2016 18:28:17 -0500
Received: from mail-yw0-f194.google.com ([209.85.161.194]:36853 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751111AbcKHX2P (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2016 18:28:15 -0500
Received: by mail-yw0-f194.google.com with SMTP id r204so7577375ywb.3
        for <git@vger.kernel.org>; Tue, 08 Nov 2016 15:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0pk6fPg0YqgHK41+XFau1+ZQdeYF74aES4ZbzvR/DGY=;
        b=mKQsyV0eiTeDbWtK97105HREPTFwIQFetwRR5vNQ5GQ4KcJViunyacuBpXk1x5vHCD
         pRmrnqqxtgZoQKbDpPE/xKwqO+49sCvHYG9Rnnc+bhUDBCl9LaBWC4mtD2PBCBUN6cY1
         p1gLw+4t9GtLMkWRNfXjkJw6GNGIotAwGCAOJMBx2f+93wzLPz0PdyRZqJB3p+WiwX3L
         fSw4wcXkf78abLIPTalsGwpR0WNpvFMD4VfE2LMo7htQ7xczRnq7y0Au/FGrZCy3pJMP
         DNoKIiwQ0ewVGgzWMobrKjUrCcrfw/VI5IH9xNMPwYOT0a3817ZWPkW7gPdpogpLOFFg
         2YaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0pk6fPg0YqgHK41+XFau1+ZQdeYF74aES4ZbzvR/DGY=;
        b=G49MvKwogGrPW26jrVYncr43izCSx0ebK4nb+o2lwDbJsA132DGt8eF+xaTXpGQZKK
         y72X2E7KGt+zU01alSTmhqTFT6xcp7f4cDDo5Y5y8Z1Icht/ZnFkxJq4gHmLadc32Glh
         OayYBAVxVUfLFjW5PRFl23tMiEXCzUcNxiGLcoGcYuWZMTnmY9U7aXnNR5BeocNH60xS
         U6xzCPG/4J3O2j8yEnQ3PwLbW9vDMJQlRrOZD4232drdkb9L20TE/Mla/e4XpTjxHg4t
         4OjniapQJlIYiZy0adidckQwhxKIbZM1kpffZZl6FucvPdJZczHXNFgwwfLkOWUsyDLj
         Dgvw==
X-Gm-Message-State: ABUngvdc9h6sKP9v9NuN7QaH+1p7CwGYgO0BqHCg4zt/JRB5Hp9uDg8sv8++dTdGeGSepGy7pdOI7thhJ49H/w==
X-Received: by 10.13.234.213 with SMTP id t204mr16007808ywe.204.1478647694922;
 Tue, 08 Nov 2016 15:28:14 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.33.132 with HTTP; Tue, 8 Nov 2016 15:27:54 -0800 (PST)
In-Reply-To: <20161108201211.25213-5-Karthik.188@gmail.com>
References: <20161108201211.25213-1-Karthik.188@gmail.com> <20161108201211.25213-5-Karthik.188@gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 8 Nov 2016 15:27:54 -0800
Message-ID: <CA+P7+xqG5ACT2ZB=M8gLmDaYgSgX202+afJmZJKat6NzbFzL=g@mail.gmail.com>
Subject: Re: [PATCH v7 04/17] ref-filter: modify "%(objectname:short)" to take length
To:     Karthik Nayak <karthik.188@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 8, 2016 at 12:11 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> From: Karthik Nayak <karthik.188@gmail.com>
>
> Add support for %(objectname:short=<length>) which would print the
> abbreviated unique objectname of given length. When no length is
> specified, the length is 'DEFAULT_ABBREV'. The minimum length is
> 'MINIMUM_ABBREV'. The length may be exceeded to ensure that the provided
> object name is unique.
>

Ok this makes sense. It may be annoying that the length might go
beyond the size that we wanted, but I think it's better than printing
a non-unique short abbreviation.

I have one suggested change, which is to drop O_LENGTH and have
O_SHORT store the length always, setting it to DEFAULT_ABBREV when no
length provided. This allows you to drop some code. I don't think it's
actually worth a re-roll by itself since the current code is correct.

Thanks,
Jake

> Add tests and documentation for the same.
>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
> Helped-by: Jacob Keller <jacob.keller@gmail.com>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  Documentation/git-for-each-ref.txt |  4 ++++
>  ref-filter.c                       | 25 +++++++++++++++++++------
>  t/t6300-for-each-ref.sh            | 10 ++++++++++
>  3 files changed, 33 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
> index b7b8560..92184c4 100644
> --- a/Documentation/git-for-each-ref.txt
> +++ b/Documentation/git-for-each-ref.txt
> @@ -107,6 +107,10 @@ objectsize::
>  objectname::
>         The object name (aka SHA-1).
>         For a non-ambiguous abbreviation of the object name append `:short`.
> +       For an abbreviation of the object name with desired length append
> +       `:short=<length>`, where the minimum length is MINIMUM_ABBREV. The
> +       length may be exceeded to ensure unique object names.
> +
>
>  upstream::
>         The name of a local ref which can be considered ``upstream''
> diff --git a/ref-filter.c b/ref-filter.c
> index 44481c3..fe4ea2b 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -55,7 +55,10 @@ static struct used_atom {
>                         const char *if_equals,
>                                 *not_equals;
>                 } if_then_else;
> -               enum { O_FULL, O_SHORT } objectname;
> +               struct {
> +                       enum { O_FULL, O_LENGTH, O_SHORT } option;
> +                       unsigned int length;
> +               } objectname;
>         } u;
>  } *used_atom;
>  static int used_atom_cnt, need_tagged, need_symref;
> @@ -118,10 +121,17 @@ static void contents_atom_parser(struct used_atom *atom, const char *arg)
>  static void objectname_atom_parser(struct used_atom *atom, const char *arg)
>  {
>         if (!arg)
> -               atom->u.objectname = O_FULL;
> +               atom->u.objectname.option = O_FULL;
>         else if (!strcmp(arg, "short"))
> -               atom->u.objectname = O_SHORT;
> -       else
> +               atom->u.objectname.option = O_SHORT;
> +       else if (skip_prefix(arg, "short=", &arg)) {
> +               atom->u.objectname.option = O_LENGTH;
> +               if (strtoul_ui(arg, 10, &atom->u.objectname.length) ||
> +                   atom->u.objectname.length == 0)
> +                       die(_("positive value expected objectname:short=%s"), arg);
> +               if (atom->u.objectname.length < MINIMUM_ABBREV)
> +                       atom->u.objectname.length = MINIMUM_ABBREV;

One way to reduce some code is to set O_SHORT and O_LENGTH as the same
(either O_SHORT or O_LENGTH) and when no length is found simply set it
to the DEFAULT_ABBREV.

> +       } else
>                 die(_("unrecognized %%(objectname) argument: %s"), arg);
>  }
>
> @@ -591,12 +601,15 @@ static int grab_objectname(const char *name, const unsigned char *sha1,
>                            struct atom_value *v, struct used_atom *atom)
>  {
>         if (starts_with(name, "objectname")) {
> -               if (atom->u.objectname == O_SHORT) {
> +               if (atom->u.objectname.option == O_SHORT) {
>                         v->s = xstrdup(find_unique_abbrev(sha1, DEFAULT_ABBREV));
>                         return 1;

That would allow dropping an entire section here.

I don't think this is worth a re-roll by itself, and I think either
approach is probably ok.

> -               } else if (atom->u.objectname == O_FULL) {
> +               } else if (atom->u.objectname.option == O_FULL) {
>                         v->s = xstrdup(sha1_to_hex(sha1));
>                         return 1;
> +               } else if (atom->u.objectname.option == O_LENGTH) {
> +                       v->s = xstrdup(find_unique_abbrev(sha1, atom->u.objectname.length));
> +                       return 1;
>                 } else
>                         die("BUG: unknown %%(objectname) option");
>         }
> diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
> index 19a2823..2be0a3f 100755
> --- a/t/t6300-for-each-ref.sh
> +++ b/t/t6300-for-each-ref.sh
> @@ -60,6 +60,8 @@ test_atom head objecttype commit
>  test_atom head objectsize 171
>  test_atom head objectname $(git rev-parse refs/heads/master)
>  test_atom head objectname:short $(git rev-parse --short refs/heads/master)
> +test_atom head objectname:short=1 $(git rev-parse --short=1 refs/heads/master)
> +test_atom head objectname:short=10 $(git rev-parse --short=10 refs/heads/master)
>  test_atom head tree $(git rev-parse refs/heads/master^{tree})
>  test_atom head parent ''
>  test_atom head numparent 0
> @@ -99,6 +101,8 @@ test_atom tag objecttype tag
>  test_atom tag objectsize 154
>  test_atom tag objectname $(git rev-parse refs/tags/testtag)
>  test_atom tag objectname:short $(git rev-parse --short refs/tags/testtag)
> +test_atom head objectname:short=1 $(git rev-parse --short=1 refs/heads/master)
> +test_atom head objectname:short=10 $(git rev-parse --short=10 refs/heads/master)
>  test_atom tag tree ''
>  test_atom tag parent ''
>  test_atom tag numparent ''
> @@ -164,6 +168,12 @@ test_expect_success 'Check invalid format specifiers are errors' '
>         test_must_fail git for-each-ref --format="%(authordate:INVALID)" refs/heads
>  '
>
> +test_expect_success 'arguments to %(objectname:short=) must be positive integers' '
> +       test_must_fail git for-each-ref --format="%(objectname:short=0)" &&
> +       test_must_fail git for-each-ref --format="%(objectname:short=-1)" &&
> +       test_must_fail git for-each-ref --format="%(objectname:short=foo)"
> +'
> +
>  test_date () {
>         f=$1 &&
>         committer_date=$2 &&
> --
> 2.10.2
>
