Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02C50207BD
	for <e@80x24.org>; Sat, 22 Apr 2017 08:16:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1042986AbdDVIQZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Apr 2017 04:16:25 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:36816 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1042933AbdDVIQT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Apr 2017 04:16:19 -0400
Received: by mail-oi0-f65.google.com with SMTP id a3so19793930oii.3
        for <git@vger.kernel.org>; Sat, 22 Apr 2017 01:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rCp7cFYRSE1I8xQ0OVL/TuQAZkduQZUJde6VDOhRkdE=;
        b=qvcxld44RHJnyWq8eThICM0RMYhdsE2aPkJrBNCkJmHefcWu1JhI3XJiy/RQ/L73n0
         SsdQ51xmpruJ4vk1/H9W4d/6pl32du6OuDcPsL3RzQd/xpYbXzGqsx78/iuAWtOgz8wy
         OckZ+lgzvO5hPhWWvzIcyok4qYXeKiWaebaUEUxyhch9mDcBPtdcB95ANuOkCmeibAsR
         CSlJje0Gzo+VMsgG8/n5PnjVFxsIc+J/1LIEmiPKOh7dFs0Z1M+sELETAvb0fnhVF0zR
         F9J2WlVkuXOG7q6lba10sEu7sbSHFGLvQ6tgJK+G/Hj0xID16+boAhqACWbToKDhj80Z
         Y97w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rCp7cFYRSE1I8xQ0OVL/TuQAZkduQZUJde6VDOhRkdE=;
        b=sD/9vnakrPG6hEG61oWh47wez8jSzY0bQJn++0bNwLqCjLiTtBhh1d9LKLEn//NAzI
         0LH05ai9YHoZsnBiUY3tK12xoHF3u2ItKXUR30GXrkvonOLB5puBQPZ0UsGrmF1R1Qt5
         o93TsqiuB6c8+O25FyyMnCM7Gf7UsVni87zHoItn1DbGcqT6RVjJXIu70KGLSb6j4wZJ
         TmWuVlhLzFV9upzijNBXwt+NKtai/4pgQnVrL4KAaiuoTRXFGc+KhHNfL6qnQMfNNZ6j
         AUfXHIF5qAjYI/hPsrG191utmtftIZW0vNmAf/adr6eMEaApGgwU7KslLbiiqBSvli0B
         65ZA==
X-Gm-Message-State: AN3rC/4//taFAyQD40UzCt9yprceVh3tGGy6c0ARGd4VJ+fbKz+dkg2y
        pREvXQxyVNvil7A3p6prpuYIzFkiuw==
X-Received: by 10.202.80.150 with SMTP id e144mr9648679oib.65.1492848978119;
 Sat, 22 Apr 2017 01:16:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.158.70 with HTTP; Sat, 22 Apr 2017 01:15:47 -0700 (PDT)
In-Reply-To: <4519cd91-80e1-a416-658e-e10e542b41ff@alum.mit.edu>
References: <20170419110145.5086-1-pclouds@gmail.com> <20170419110145.5086-7-pclouds@gmail.com>
 <4519cd91-80e1-a416-658e-e10e542b41ff@alum.mit.edu>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 22 Apr 2017 15:15:47 +0700
Message-ID: <CACsJy8ADCVBiLoPg_Tz0L6CMdh_eFmK4RYzfQ-PmUgBK7w9e=A@mail.gmail.com>
Subject: Re: [PATCH v3 06/12] refs: add refs_head_ref()
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 22, 2017 at 1:37 PM, Michael Haggerty <mhagger@alum.mit.edu> wr=
ote:
> On 04/19/2017 01:01 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.=
com>
>> ---
>>  refs.c | 19 +++++++++----------
>>  refs.h |  2 ++
>>  2 files changed, 11 insertions(+), 10 deletions(-)
>>
>> diff --git a/refs.c b/refs.c
>> index 26474cb62a..a252ae43ee 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -1208,27 +1208,26 @@ int refs_rename_ref_available(struct ref_store *=
refs,
>>       return ok;
>>  }
>>
>> -int head_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_=
data)
>> +int refs_head_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data=
)
>>  {
>>       struct object_id oid;
>>       int flag;
>>
>> -     if (submodule) {
>> -             if (resolve_gitlink_ref(submodule, "HEAD", oid.hash) =3D=
=3D 0)
>> -                     return fn("HEAD", &oid, 0, cb_data);
>> -
>> -             return 0;
>> -     }
>> -
>> -     if (!read_ref_full("HEAD", RESOLVE_REF_READING, oid.hash, &flag))
>> +     if (!refs_read_ref_full(refs, "HEAD", RESOLVE_REF_READING,
>> +                             oid.hash, &flag))
>>               return fn("HEAD", &oid, flag, cb_data);
>>
>>       return 0;
>>  }
>>
>> +int head_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_=
data)
>> +{
>> +     return refs_head_ref(get_submodule_ref_store(submodule), fn, cb_da=
ta);
>> +}
>> +
>>  int head_ref(each_ref_fn fn, void *cb_data)
>>  {
>> -     return head_ref_submodule(NULL, fn, cb_data);
>> +     return refs_head_ref(get_main_ref_store(), fn, cb_data);
>>  }
>>
>>  /*
>> diff --git a/refs.h b/refs.h
>> index 447381d378..0572473ef7 100644
>> --- a/refs.h
>> +++ b/refs.h
>> @@ -233,6 +233,8 @@ typedef int each_ref_fn(const char *refname,
>>   * modifies the reference also returns a nonzero value to immediately
>>   * stop the iteration. Returned references are sorted.
>>   */
>> +int refs_head_ref(struct ref_store *refs,
>> +               each_ref_fn fn, void *cb_data);
>>  int refs_for_each_ref(struct ref_store *refs,
>>                     each_ref_fn fn, void *cb_data);
>>  int refs_for_each_ref_in(struct ref_store *refs, const char *prefix,
>>
>
> I'm seeing segfaults in t3600 after this patch, apparently because
> `refs=3D=3DNULL` gets passed from `head_ref_submodule()` to `refs_head_re=
f()`.

Eventually it's the caller's responsibility not to pass NULL ref store
to refs_* functions. That happens in "revision.c: use refs_for_each*()
instead of for_each_*_submodule()" patch, which is too late and would
break bisect. Will fix.
--=20
Duy
