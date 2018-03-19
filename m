Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D94691F404
	for <e@80x24.org>; Mon, 19 Mar 2018 16:55:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935228AbeCSQzY (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 12:55:24 -0400
Received: from mail-ot0-f172.google.com ([74.125.82.172]:37337 "EHLO
        mail-ot0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935041AbeCSQzT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 12:55:19 -0400
Received: by mail-ot0-f172.google.com with SMTP id t2-v6so8844759otj.4
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 09:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=e+Z6hTXdpL9LcF1oAGCLZgipdjy0VVqJ6A/xZ1Za/v4=;
        b=Ku46j2EZpGnU4JURnqN57SXrpgU+ScrhfOEdDnWZQlL9Zah30nrHj1Nuo7k+qEdF16
         3NHoPqhfJAyiZNSUtLCfTaT1jyxDLislw4WCc53sWdFGwgfl2wAO+poQpgP0QerXK4hf
         nY9b5M4Rz2nUMflzngxnLWBXEeNNiKr44yMNUmYPSN3QeKsVZ0e4q2uNCH+DsXjz/ans
         ymiVBuOFEO7F9CuyJW4eN4/v62H/FSYzsyOsL44RPe17gEVZ89R2c4lWW5QCZ1NCGAmd
         bCqO1iZ1PZoBWw+dJeh6Hr5V0LsmeoYbhCjLhZIB121KZl1SFv00V7zzDZ54xevZhFyp
         vO5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=e+Z6hTXdpL9LcF1oAGCLZgipdjy0VVqJ6A/xZ1Za/v4=;
        b=mPcDQKF+Cy9fVZN6RE5zZwYNurYBtYmW0uxykAqRAMYS9ExbSzsi0m7HBsfeOep6zb
         i+AFQDBDnlCI3Gjl/seGwtA9+Q3/QS6PDKUqpKV2uC65K9D4emqAmvx5V4yuq6lq1tLD
         kKUe4jhnu6A4QvjowVAXLB6WO8uTwgB+QxnuSrOzMdflihVe1Ffv4Z5J7+uFHOZqZ0ls
         3HJxxNl8L2Ays1iR9CoCNUqVFO4zrcnJ07Wpkl/7O8oko1hDc1ygFU0n5THv9ni4/hjm
         tGxA7L4loowiL7TYur0H5WhG7RSFoYi/l+VpuxaKI7SgElu15q90BlBT7fxbdUetYMF9
         /Jpg==
X-Gm-Message-State: AElRT7FkxG2NQEE3b+3XAr8uNbjVXE4dPeLEiXKLE1YVTpQ0eLBxTAGx
        SRx323crMyaoXenmzNKZ6LpCOfWPixpDIRrJwG0=
X-Google-Smtp-Source: AG47ELtMC3LEeszE1GubVRZh2mqj2re5sDzuEDhr4Rl1m2TWwVfPbnJ9lxUPUty1YkAgAVxhLMh35oWIj4uolheecY4=
X-Received: by 2002:a9d:36cc:: with SMTP id s12-v6mr8582301otd.304.1521478518939;
 Mon, 19 Mar 2018 09:55:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.154.146 with HTTP; Mon, 19 Mar 2018 09:54:48 -0700 (PDT)
In-Reply-To: <xmqqsh8wvwwn.fsf@gitster-ct.c.googlers.com>
References: <20180317141033.21545-1-pclouds@gmail.com> <20180318142526.9378-1-pclouds@gmail.com>
 <20180318142526.9378-10-pclouds@gmail.com> <xmqqsh8wvwwn.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 19 Mar 2018 17:54:48 +0100
Message-ID: <CACsJy8AkJJQ4XNszxBsESN_WGOSZ+ExWdcCtn6NA+gW9+-mAqQ@mail.gmail.com>
Subject: Re: [PATCH v6 09/11] pack-objects: shrink size field in struct object_entry
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Wong <e@80x24.org>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 19, 2018 at 5:43 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:
>
>> +static inline void oe_set_size(struct object_entry *e,
>> +                            unsigned long size)
>> +{
>> +     e->size_ =3D size;
>> +     e->size_valid =3D e->size_ =3D=3D size;
>
> A quite similar comment as my earlier one applies here.  I wonder if
> this is easier to read?
>
>         e->size_valid =3D fits_in_32bits(size);
>         if (e->size_valid)
>                 e->size_ =3D size;
>
> Stepping back a bit in a different tangent,
>
>  - fits_in_32bits() is a good public name if the helper is about
>    seeing if the given quantity fits in 32bit uint,
>
>  - but that carves it in stone that our e->size_ *will* be 32bit
>    forever, which is not good.
>
> So, it may be a good idea to call it size_cacheable_in_oe(size) or
> something to ask "I have this 'size'; is it small enough to fit in
> the field in the oe, i.e. allow us to cache it, as opposed to having
> to go back to the object every time?"  Of course, this would declare
> that the helper can only be used for that particular field, but that
> is sort of the point of such a change, to allow us to later define
> the e->size_ field to different sizes without affecting other stuff.

This is why I do "size_valid =3D size_ =3D=3D size". In my private build, I
reduced size_ to less than 32 bits and change the "fits_in_32bits"
function to do something like

int fits_in_32bits(unsigned long size)
{
struct object_entry e;
e.size_ =3D size;
return e.size_ =3D=3D size.
}

which makes sure it always works. This spreads the use of "valid =3D xx
=3D=3D yy"  in more places though. I think if we just limit the use of
this expression in a couple access wrappers than it's not so bad.

>> +     if (!e->size_valid) {
>> +             unsigned long real_size;
>> +
>> +             if (sha1_object_info(e->idx.oid.hash, &real_size) < 0 ||
>> +                 size !=3D real_size)
>> +                     die("BUG: 'size' is supposed to be the object size=
!");
>> +     }
>
> If an object that is smaller than 4GB is fed to this function with
> an incorrect size, we happily record it in e->size_ and declare it
> is valid.  Wouldn't that be equally grave error as we are catching
> in this block?

That adds an extra sha1_object_info() to all objects and it's
expensive (I think it's one of the reasons we cache values in
object_entry in the first place). I think there are also a few
occasions we reuse even bad in-pack objects (there are even tests for
that) so it's not always safe to die() here.
--=20
Duy
