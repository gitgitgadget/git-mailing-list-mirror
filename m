Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58E0B1F404
	for <e@80x24.org>; Mon,  9 Apr 2018 17:44:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751954AbeDIRo5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 13:44:57 -0400
Received: from mail-yb0-f173.google.com ([209.85.213.173]:40838 "EHLO
        mail-yb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751549AbeDIRo4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 13:44:56 -0400
Received: by mail-yb0-f173.google.com with SMTP id y18-v6so3308428ybb.7
        for <git@vger.kernel.org>; Mon, 09 Apr 2018 10:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BUHw/m0eUMJlDqUUEpV05EjTNWW2plqRbX+AQ293pmo=;
        b=BuzG4JAjsMGApqj/sgneQ9HCxgcJ+DYQ54hMSkFq8kwAA2dfxgnXpCbrpaX8qbYMZB
         pdI1sxXyiL0LPhwwgs1xlL7eA+he2M4TtHlzPEaFhTm4JcQ1x+EY0Vn2sjdswOg0TCd+
         OZxTvtlDtFcT5dQp/ENLSQoGaiuBa5uRCZseJI9d3v4pBYd7TOhNEOl+2ws8u4OkkWvg
         DXACzNmaTiCHVa5tV1KHjwuTKyAkgEAyFhdDinL9vEaBx42ylHsKkfEIfQpoZq/NTHE0
         V8giz4Fum4KGI1E7pMUp5JT3S5Sk2Xo3xMO1q7ta7+KED5aeqhTNyw39UYkSxHcyB/M2
         Ymew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BUHw/m0eUMJlDqUUEpV05EjTNWW2plqRbX+AQ293pmo=;
        b=Zf4l+JKBAzH5gl/rgh2FR38FGn5W/9NzPJZBVowOjnz1UO3iIbqAXo0PZE/J0yuoIJ
         T2+hbQ1yGo31DBXOVicK36J0nC9zea3JMMJTbucq3FJ1sZsP0nQ6PiUiUcdN1Li6tWeu
         jKwtnFxx9EUc/wSUP3C6RNWr+jA5uU3JIyXJubJccLqqXMFZivUvGStqsIQ5pGVX+KB8
         Bt/LYzXRLsTMZfAEbyUyM721MmZcc0yCE4BJdB8N1bIY7F0Z83F8wI+Z3u6UypndbAbY
         Y9n/lnkjt/NTBBSPqngZrZnCTYIhBnC0cNCJDboIqEnrVvBqVVMlLwWotDUgIArtYZKc
         dM5g==
X-Gm-Message-State: ALQs6tAy6d2y9FgKpwiu1lgKgSnt0NQ7PHK01rg5wjofDo9wdGt8C3Ci
        RWdt08dvvo+AcH3fbUpYFtOaVDk0bpwvAu8msNRQpQ==
X-Google-Smtp-Source: AIpwx4+Q7RaIUkFfYfhGlJRekPbnADvlbKMQgoeVQw/JnEOVvYu+5+zEJNugBWJv7jNW3Rj2Dy0Ldc9HS4SzGF+r0HE=
X-Received: by 2002:a25:8e0e:: with SMTP id p14-v6mr2858611ybl.352.1523295894929;
 Mon, 09 Apr 2018 10:44:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf81:0:0:0:0:0 with HTTP; Mon, 9 Apr 2018 10:44:54 -0700 (PDT)
In-Reply-To: <38962a15-1081-bbdb-b4c4-6b46222b5f64@web.de>
References: <20180406232136.253950-1-sbeller@google.com> <38962a15-1081-bbdb-b4c4-6b46222b5f64@web.de>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 9 Apr 2018 10:44:54 -0700
Message-ID: <CAGZ79kZvi9J-V2rYzY=vsf5NMbjambNvZP22cuOfurJZAM3fWw@mail.gmail.com>
Subject: Re: [RFC PATCH 00/19] object-store refactoring 3 (replace objects,
 main ref store)
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ren=C3=A9,

On Fri, Apr 6, 2018 at 9:58 PM, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
> Am 07.04.2018 um 01:21 schrieb Stefan Beller:
>> This applies on top of 464416a2eaadf84d2bfdf795007863d03b222b7c
>> (sb/packfiles-in-repository).
>> It is also available at https://github.com/stefanbeller/git/tree/object-=
store-3
>
> This series conflicts with 1731a1e239 (replace_object: convert struct
> replace_object to object_id) and b383a13cc0 (Convert
> lookup_replace_object to struct object_id), which are in next.

ok, I'll investigate. Maybe the reroll will be on top of a merge
of brians series and sb/packfiles-in-repository, both of which go to master
quickly now that 2.17 is out?

>
>> This series will bring the replacement mechanism (git replace)
>> into the object store.
>
> Good idea.

heh, thanks. I think this is the smallest unit in which the community is
willing to digest it. (The largest coherent patch series was the demo of
"everything in struct repo"[1])

[1] https://public-inbox.org/git/20180205235508.216277-1-sbeller@google.com=
/

>
>>   $ git diff 464416a2eaadf84d2bfdf795007863d03b222b7c..HEAD -- object-st=
ore.h repository.h
>> diff --git a/object-store.h b/object-store.h
>> index fef33f345f..be90c02db6 100644
>> --- a/object-store.h
>> +++ b/object-store.h
>> @@ -93,6 +93,22 @@ struct raw_object_store {
>>          struct alternate_object_database *alt_odb_list;
>>          struct alternate_object_database **alt_odb_tail;
>>
>> +       /*
>> +        * Objects that should be substituted by other objects
>> +        * (see git-replace(1)).
>> +        */
>> +       struct replace_objects {
>> +               /*
>> +                * An array of replacements.  The array is kept sorted b=
y the original
>> +                * sha1.
>> +                */
>> +               struct replace_object **items;
>> +
>> +               int alloc, nr;
>> +
>> +               unsigned prepared : 1;
>> +       } replacements;
>
> An oidmap would be a better fit -- lookups should be quicker and
> memory consumption not much worse.  I meant to submit something like
> this eventually after Brian's series lands:
>
> -- >8 --
> Subject: [PATCH] replace_object: use oidmap
>
> Load the replace objects into an oidmap to allow for easy lookups in
> constant time.
>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
> This is on top of next.

So this is on top of brians series (modulo other next-ish stuff)
which this series ought to merge with?

The patch looks good -- just from the diff stat alone.

Thanks,
Stefan


>
>  replace_object.c | 76 ++++++++++--------------------------------------
>  1 file changed, 16 insertions(+), 60 deletions(-)
>
> diff --git a/replace_object.c b/replace_object.c
> index 336357394d..a757a5ebf2 100644
> --- a/replace_object.c
> +++ b/replace_object.c
> @@ -1,54 +1,14 @@
>  #include "cache.h"
> -#include "sha1-lookup.h"
> +#include "oidmap.h"
>  #include "refs.h"
>  #include "commit.h"
>
> -/*
> - * An array of replacements.  The array is kept sorted by the original
> - * sha1.
> - */
> -static struct replace_object {
> -       struct object_id original;
> +struct replace_object {
> +       struct oidmap_entry original;
>         struct object_id replacement;
> -} **replace_object;
> -
> -static int replace_object_alloc, replace_object_nr;
> +};
>
> -static const unsigned char *replace_sha1_access(size_t index, void *tabl=
e)
> -{
> -       struct replace_object **replace =3D table;
> -       return replace[index]->original.hash;
> -}
> -
> -static int replace_object_pos(const unsigned char *sha1)
> -{
> -       return sha1_pos(sha1, replace_object, replace_object_nr,
> -                       replace_sha1_access);
> -}
> -
> -static int register_replace_object(struct replace_object *replace,
> -                                  int ignore_dups)
> -{
> -       int pos =3D replace_object_pos(replace->original.hash);
> -
> -       if (0 <=3D pos) {
> -               if (ignore_dups)
> -                       free(replace);
> -               else {
> -                       free(replace_object[pos]);
> -                       replace_object[pos] =3D replace;
> -               }
> -               return 1;
> -       }
> -       pos =3D -pos - 1;
> -       ALLOC_GROW(replace_object, replace_object_nr + 1, replace_object_=
alloc);
> -       replace_object_nr++;
> -       if (pos < replace_object_nr)
> -               MOVE_ARRAY(replace_object + pos + 1, replace_object + pos=
,
> -                          replace_object_nr - pos - 1);
> -       replace_object[pos] =3D replace;
> -       return 0;
> -}
> +static struct oidmap replace_map =3D OIDMAP_INIT;
>
>  static int register_replace_ref(const char *refname,
>                                 const struct object_id *oid,
> @@ -59,7 +19,7 @@ static int register_replace_ref(const char *refname,
>         const char *hash =3D slash ? slash + 1 : refname;
>         struct replace_object *repl_obj =3D xmalloc(sizeof(*repl_obj));
>
> -       if (get_oid_hex(hash, &repl_obj->original)) {
> +       if (get_oid_hex(hash, &repl_obj->original.oid)) {
>                 free(repl_obj);
>                 warning("bad replace ref name: %s", refname);
>                 return 0;
> @@ -69,7 +29,7 @@ static int register_replace_ref(const char *refname,
>         oidcpy(&repl_obj->replacement, oid);
>
>         /* Register new object */
> -       if (register_replace_object(repl_obj, 1))
> +       if (oidmap_put(&replace_map, repl_obj))
>                 die("duplicate replace ref: %s", refname);
>
>         return 0;
> @@ -84,7 +44,7 @@ static void prepare_replace_object(void)
>
>         for_each_replace_ref(register_replace_ref, NULL);
>         replace_object_prepared =3D 1;
> -       if (!replace_object_nr)
> +       if (!replace_map.map.tablesize)
>                 check_replace_refs =3D 0;
>  }
>
> @@ -100,21 +60,17 @@ static void prepare_replace_object(void)
>   */
>  const struct object_id *do_lookup_replace_object(const struct object_id =
*oid)
>  {
> -       int pos, depth =3D MAXREPLACEDEPTH;
> +       int depth =3D MAXREPLACEDEPTH;
>         const struct object_id *cur =3D oid;
>
>         prepare_replace_object();
>
>         /* Try to recursively replace the object */
> -       do {
> -               if (--depth < 0)
> -                       die("replace depth too high for object %s",
> -                           oid_to_hex(oid));
> -
> -               pos =3D replace_object_pos(cur->hash);
> -               if (0 <=3D pos)
> -                       cur =3D &replace_object[pos]->replacement;
> -       } while (0 <=3D pos);
> -
> -       return cur;
> +       while (depth-- > 0) {
> +               struct replace_object *repl_obj =3D oidmap_get(&replace_m=
ap, cur);
> +               if (!repl_obj)
> +                       return cur;
> +               cur =3D &repl_obj->replacement;
> +       }
> +       die("replace depth too high for object %s", oid_to_hex(oid));
>  }
> --
> 2.17.0
