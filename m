From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH 01/11] packed_object_info_detail(): do not return a string
Date: Mon, 16 May 2011 21:45:09 -0300
Message-ID: <BANLkTinxfNH85v6AfWaVNRzhP-fJ0tjNNg@mail.gmail.com>
References: <1305505831-31587-1-git-send-email-gitster@pobox.com>
	<1305505831-31587-2-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 17 02:45:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QM8Q6-000533-Ep
	for gcvg-git-2@lo.gmane.org; Tue, 17 May 2011 02:45:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752074Ab1EQApL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 May 2011 20:45:11 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:48188 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751868Ab1EQApK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 May 2011 20:45:10 -0400
Received: by iwn34 with SMTP id 34so10500iwn.19
        for <git@vger.kernel.org>; Mon, 16 May 2011 17:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=rc7j2k92HtjSFZtwXkxbvhbYSEeonExW/Kjd2NOamMg=;
        b=NZUzqcLXeobLmrzUq0mv4qfbFVcqrBW5reqerc16st9hwBq00xRZsXzfU4ktYiVVWq
         lRdiFsvfFMY0fMxXCbhkiQHxIkIah+ZhcZAc3W1IoKR5zB1v5j+KKMpqAxw/29PFOJCt
         Y25V0ONcFDiJPdTn7E5S8XvYm8qW0dorVTqlc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=QXNeJ9IzFwWYDhA+Z5J++IkqPXRAjtgCVMWnEjvU5MO3SPKkHhrUBWKey1Obw6Zam+
         IMh3YYqy5ehkRu1fhTW/YCWXJt1l0du8J4VWywPR79AoubEgbIFIMh1wT4+WMhB0I+nc
         IMJgNbgLjtN1CCSIeEPphv1KAyTy4eaLHXQEg=
Received: by 10.42.239.10 with SMTP id ku10mr672icb.477.1305593109876; Mon, 16
 May 2011 17:45:09 -0700 (PDT)
Received: by 10.42.230.193 with HTTP; Mon, 16 May 2011 17:45:09 -0700 (PDT)
In-Reply-To: <1305505831-31587-2-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173776>

On Sun, May 15, 2011 at 9:30 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Instead return enum object_name just like everybody else does.
> The caller can turn it into a string with typename() easily.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> =C2=A0builtin/verify-pack.c | =C2=A0 =C2=A04 ++--
> =C2=A0cache.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0=
 =C2=A02 +-
> =C2=A0sha1_file.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A04=
 ++--
> =C2=A03 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/builtin/verify-pack.c b/builtin/verify-pack.c
> index b6079ae..3a919b1 100644
> --- a/builtin/verify-pack.c
> +++ b/builtin/verify-pack.c
> @@ -33,9 +33,9 @@ static void show_pack_info(struct packed_git *p, un=
signed int flags)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!sha1)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0die("internal error pack-check nth-packed-object");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0offset =3D nth=
_packed_object_offset(p, i);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 type =3D packed_ob=
ject_info_detail(p, offset, &size, &store_size,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 type =3D typename(=
packed_object_info_detail(p, offset, &size, &store_size,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &delta_chain_length,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0base_sha1);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0base_sha1));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!stat_only=
)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0printf("%s ", sha1_to_hex(sha1));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!delta_cha=
in_length) {
> diff --git a/cache.h b/cache.h
> index b1b5bb5..cdb5112 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1020,7 +1020,7 @@ extern off_t find_pack_entry_one(const unsigned=
 char *, struct packed_git *);
> =C2=A0extern void *unpack_entry(struct packed_git *, off_t, enum obje=
ct_type *, unsigned long *);
> =C2=A0extern unsigned long unpack_object_header_buffer(const unsigned=
 char *buf, unsigned long len, enum object_type *type, unsigned long *s=
izep);
> =C2=A0extern unsigned long get_size_from_delta(struct packed_git *, s=
truct pack_window **, off_t);
> -extern const char *packed_object_info_detail(struct packed_git *, of=
f_t, unsigned long *, unsigned long *, unsigned int *, unsigned char *)=
;
> +extern int packed_object_info_detail(struct packed_git *, off_t, uns=
igned long *, unsigned long *, unsigned int *, unsigned char *);

In the commit message you say to return "enum object_name". Maybe
change from int to enum object_name here and below?

Also, |type| below is enum object_type not object_name.

>
> =C2=A0/* Dumb servers support */
> =C2=A0extern int update_server_info(int);
> diff --git a/sha1_file.c b/sha1_file.c
> index 064a330..4f96eb1 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -1549,7 +1549,7 @@ static int unpack_object_header(struct packed_g=
it *p,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return type;
> =C2=A0}
>
> -const char *packed_object_info_detail(struct packed_git *p,
> +int packed_object_info_detail(struct packed_git *p,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0off_t ob=
j_offset,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned=
 long *size,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned=
 long *store_size,
> @@ -1580,7 +1580,7 @@ const char *packed_object_info_detail(struct pa=
cked_git *p,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case OBJ_BLOB:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case OBJ_TAG:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0unuse_pack(&w_curs);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 return typename(type);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 return type;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case OBJ_OFS_D=
ELTA:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0obj_offset =3D get_delta_base(p, &w_curs, &curpos, type, =
obj_offset);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0if (!obj_offset)
> --
> 1.7.5.1.365.g32b65
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
