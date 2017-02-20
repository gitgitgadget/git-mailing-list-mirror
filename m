Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,TVD_SUBJ_WIPE_DEBT shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31364201A9
	for <e@80x24.org>; Mon, 20 Feb 2017 12:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752767AbdBTMeC (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Feb 2017 07:34:02 -0500
Received: from mail-oi0-f53.google.com ([209.85.218.53]:34536 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752520AbdBTMeB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Feb 2017 07:34:01 -0500
Received: by mail-oi0-f53.google.com with SMTP id y140so21931191oie.1
        for <git@vger.kernel.org>; Mon, 20 Feb 2017 04:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xOxGiO41kREf1ceBJnUrfQHxwtNqh66CUVUlEioL3O8=;
        b=LahXZNfFRA6JldtuYrRlCZ/gFXqL+sIIo9FU/jLmh9ciADgcbYG7wBzU5qgrGYzIzM
         +u2f6MLzdgR0+wgLhWInaYhxRpFRkl48sW6/gdrVo/Yf6FyDMkqMMBw4kFevLxnlRuQZ
         GQvg8QYzfr5r1gZK8aOPEvenl9qGrP6eDzP8IChZWKyuLiAMIHAw19WqfApwNPiiqIVr
         2bJMbQMm+SrKDpxUVkOMF7QgPfdUIemW0puVrt0bEM+Oe3vDxcONjbQuFz+kMG1j+jth
         cPoP46R5rxG3cGBDuH9MozCWMYK5053f4e4WZYL3HekSeGt1ABkj83E5D/jjNOzLaRou
         Pm9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xOxGiO41kREf1ceBJnUrfQHxwtNqh66CUVUlEioL3O8=;
        b=dmW1ADKp3Q6gyCcyz7qdwKGmn2EUgR3ru/OLa6UpDuXBbrhKqJVuH7vYkuyTSnmeHN
         FAkM/1eemgzuH6sFcww9u7CEPei3L9ymgCbsOIx2t9pZx/8xh/ZeL8ONUybo10226qqS
         cysnPOgZAkI9Mn8N9JT4qsLhYTXG2QtVPsJtvpd6/5gsp30ODRWd5TTc8e88EbOQ0qwB
         PzcTbINIBZbkESWpZO2vZHvVmZR00NHelqso0FF21PaAGpNmVR9awPBP07Z5EtqCD3YI
         lbk/pVRYypOf9BM+UY9HvTjBoGT1aJowGxGsCJE246bklVUw7O+zLEP4pusnnQt/uysV
         ycRA==
X-Gm-Message-State: AMke39lfIPEdAHD9VtNyjSG3GRJAXZeBsIJy13asIbSEp+M+7jS2nKjcYfBbqP155MVXZXPqWA0RkEwYkj+q6Q==
X-Received: by 10.202.78.214 with SMTP id c205mr11250022oib.65.1487594040566;
 Mon, 20 Feb 2017 04:34:00 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.158.84 with HTTP; Mon, 20 Feb 2017 04:33:30 -0800 (PST)
In-Reply-To: <c4265faf-a04a-552b-fd72-1631a220f788@alum.mit.edu>
References: <20170217140436.17336-1-pclouds@gmail.com> <20170218133303.3682-1-pclouds@gmail.com>
 <20170218133303.3682-15-pclouds@gmail.com> <25fcb527-595a-7865-41e3-ee7c4c1ad668@alum.mit.edu>
 <CACsJy8AZ27O-pxTqHOzYXRBuyv8dkxdGJ_5Z0u3eaxkNdnaEYA@mail.gmail.com> <c4265faf-a04a-552b-fd72-1631a220f788@alum.mit.edu>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 20 Feb 2017 19:33:30 +0700
Message-ID: <CACsJy8ChAwwPawTrq4gqZqAO3k6PrgzzvceVFjbJmxkE0Rn8SQ@mail.gmail.com>
Subject: Re: [PATCH v4 14/15] files-backend: remove submodule_allowed from files_downcast()
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        David Turner <novalis@novalis.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 20, 2017 at 7:30 PM, Michael Haggerty <mhagger@alum.mit.edu> wr=
ote:
> On 02/20/2017 01:21 PM, Duy Nguyen wrote:
>> On Mon, Feb 20, 2017 at 7:11 PM, Michael Haggerty <mhagger@alum.mit.edu>=
 wrote:
>>> On 02/18/2017 02:33 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote=
:
>>>> Since submodule or not is irrelevant to files-backend after the last
>>>> patch, remove the parameter from files_downcast() and kill
>>>> files_assert_main_repository().
>>>>
>>>> PS. This implies that all ref operations are allowed for submodules. B=
ut
>>>> we may need to look more closely to see if that's really true...
>>>
>>> I think you are jumping the gun here.
>>>
>>> Even after your changes, there is still a significant difference betwee=
n
>>> the main repository and submodules: we have access to the object
>>> database for the main repository, but not for submodules.
>>>
>>> So, for example, the following don't work for submodules:
>>>
>>> * `parse_object()` is used to ensure that references are only pointed a=
t
>>> valid objects, and that branches are only pointed at commit objects.
>>>
>>> * `peel_object()` is used to write the peeled version of references in
>>> `packed-refs`, and to peel references while they are being iterated
>>> over. Since this doesn't work, I think you can't write `packed-refs` in
>>> a submodule.
>>>
>>> These limitations, I think, imply that submodule references have to be
>>> treated as read-only.
>>
>> Behind the scene submodule does add_submodule_odb(), which basically
>> makes the submodule's odb an alternate of in-core odb. So odb access
>> works. I was puzzled how submodules could by pass odb access at the
>> beginning only to find that out. technical/api-ref-iteration.txt also
>> mentions that you need to add_submodule_odb(), so I think it's
>> deliberate (albeit hacky) design.
>
> That's interesting. I didn't know it before.
>
> But I still don't think that means that reference writing can work
> correctly. If I try to set a submodule branch to an SHA-1 and I verify
> that the SHA-1 points to a valid commit, how do I know that the commit
> is in the same submodule that holds the reference?

Good point. So will the new flag be "read_only" (no reference to
submodule), or "submodule"? This flag will be passed in at ref-store
init time and kept in files_ref_store.
--=20
Duy
