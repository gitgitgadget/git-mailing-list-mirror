Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B51021F404
	for <e@80x24.org>; Fri,  9 Mar 2018 13:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751137AbeCINms (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Mar 2018 08:42:48 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:55206 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751096AbeCINmr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Mar 2018 08:42:47 -0500
Received: by mail-wm0-f41.google.com with SMTP id z81so3970115wmb.4
        for <git@vger.kernel.org>; Fri, 09 Mar 2018 05:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hIKzUqNQSgJw0uwjzZw1S56NSz0L46nVDE6QiLbedQo=;
        b=WhFsSKjj1nEbq5md7vDZYF736aOSWJ9rhCGdiEVCc/E6OxYPCpZV4jCSjYJkM8HRq6
         UvXcQxGNf9KxDC74V99gQQoioByhVOHzkdJmzdGjH9ppM5V/Sv4WzHPyEvzddpvTDas7
         lNWRsNMFPNMwt3eT0RYcgrmjCt+zykLO1QUDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hIKzUqNQSgJw0uwjzZw1S56NSz0L46nVDE6QiLbedQo=;
        b=SHzLBeLex9Skd0w+RES6dCSFczdKRtNFVpzWMQa2Y7kjVFiFI6sjL/KvW/lOC8hio4
         PwrfOvJ+G3sxkUpVGfHwbf16nZkGPVJvrzR1uE4Gl8+T/f4/htXBHrjnbalNmFXYnpIO
         P67M9jqNlXTTjYR1THwjakHDTE4n2vh+E6X5Jeo1bzKpk+xjegUmNtrqtni0StVHeLGx
         otmvCu22FROZLtA7I7rZ+gXLTG6eACMBzOQSUdk6QEG+H/hABZ1yXJbfYN9rQ6AxXc1v
         NHLrzIhOXoMRyVxkH6eGrpd41y8NY/r3HoVmU56218tBobeGvcNTn0Y8USbiyh2qvJ8G
         4HMA==
X-Gm-Message-State: APf1xPB9+7KZMqqdDAPEmr5GgWpBFpGkXg4Xd8nUiF2xcvwd2QKIDVVR
        hhbaAOJdkcNiy3RpHzVV1LjBNknNlI8=
X-Google-Smtp-Source: AG47ELt3+J8LVWyJ6bOkGL5tTTuDth+JgshP4R7Neeb1jal9WylvEC7AwTPGqIu6dNfTAQtxc7Hf6A==
X-Received: by 10.80.215.195 with SMTP id m3mr37238877edj.296.1520602965556;
        Fri, 09 Mar 2018 05:42:45 -0800 (PST)
Received: from mail-wm0-f47.google.com (mail-wm0-f47.google.com. [74.125.82.47])
        by smtp.gmail.com with ESMTPSA id x16sm880141edd.52.2018.03.09.05.42.44
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Mar 2018 05:42:44 -0800 (PST)
Received: by mail-wm0-f47.google.com with SMTP id z81so3969950wmb.4
        for <git@vger.kernel.org>; Fri, 09 Mar 2018 05:42:44 -0800 (PST)
X-Received: by 10.28.125.150 with SMTP id y144mr1979408wmc.75.1520602964010;
 Fri, 09 Mar 2018 05:42:44 -0800 (PST)
MIME-Version: 1.0
Received: by 10.28.142.20 with HTTP; Fri, 9 Mar 2018 05:42:03 -0800 (PST)
In-Reply-To: <c97772f1-dc36-3f2c-b328-6d8bd480ff79@web.de>
References: <20180308120639.109438-1-tikuta@chromium.org> <c97772f1-dc36-3f2c-b328-6d8bd480ff79@web.de>
From:   Takuto Ikuta <tikuta@chromium.org>
Date:   Fri, 9 Mar 2018 22:42:03 +0900
X-Gmail-Original-Message-ID: <CALNjmMofu9yupivCo7gHmOTVoFurgyp9CfR1uD-=cLWzq1hVtA@mail.gmail.com>
Message-ID: <CALNjmMofu9yupivCo7gHmOTVoFurgyp9CfR1uD-=cLWzq1hVtA@mail.gmail.com>
Subject: Re: [PATCH] fetch-pack.c: use oidset to check existence of loose object
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2018-03-09 2:19 GMT+09:00 Ren=C3=A9 Scharfe <l.s.r@web.de>:
> Am 08.03.2018 um 13:06 schrieb Takuto Ikuta:
>> +static int add_loose_objects_to_set(const struct object_id *oid,
>> +                                 const char *path,
>> +                                 void *data)
>> +{
>> +     struct oidset* set =3D (struct oidset*)(data);
>
> This cast is not needed (unlike in C++).  And the asterisk should be stuc=
k
> to the variable, not the type (see Documentation/CodingGuidelines).
>
>> +     oidset_insert(set, oid);
>
> In fact, you could just put "data" in here instead of "set" (without a
> cast), with no loss in readability or safety.
>

Thank you for review, changed to use data directly in v2.

>> +     return 0;
>> +}
>> +
>>   static int everything_local(struct fetch_pack_args *args,
>>                           struct ref **refs,
>>                           struct ref **sought, int nr_sought)
>> @@ -719,16 +728,21 @@ static int everything_local(struct fetch_pack_args=
 *args,
>>       int retval;
>>       int old_save_commit_buffer =3D save_commit_buffer;
>>       timestamp_t cutoff =3D 0;
>> +     struct oidset loose_oid_set =3D OIDSET_INIT;
>> +
>> +     for_each_loose_object(add_loose_objects_to_set, &loose_oid_set, 0)=
;
>>
>>       save_commit_buffer =3D 0;
>>
>>       for (ref =3D *refs; ref; ref =3D ref->next) {
>>               struct object *o;
>> +             unsigned int flag =3D OBJECT_INFO_QUICK;
>>
>> -             if (!has_object_file_with_flags(&ref->old_oid,
>> -                                             OBJECT_INFO_QUICK))
>> -                     continue;
>> +             if (!oidset_contains(&loose_oid_set, &ref->old_oid))
>> +                     flag |=3D OBJECT_INFO_SKIP_LOOSE;
>>
>> +             if (!has_object_file_with_flags(&ref->old_oid, flag))
>> +                     continue;
>>               o =3D parse_object(&ref->old_oid);
>>               if (!o)
>>                       continue;
>> @@ -744,6 +758,8 @@ static int everything_local(struct fetch_pack_args *=
args,
>>               }
>>       }
>>
>> +     oidset_clear(&loose_oid_set);
>> +
>
> This part looks fine to me.  (Except perhaps call the variable "flags"
> because you sometimes have two?)
>

Changed flag names.

> Why not include packed objects as well?  Probably because packs have
> indexes which can queried quickly to determine object existence, and
> because there are only few loose objects in typical repositories,
> right?
>

Correct. In my target repository, chromium, fetch-pack's slowness
comes from many lstat
to non-existing loose objects for remote refs. I focus on to remove such ls=
tat.

> A similar cache was introduced by cc817ca3ef (sha1_name: cache
> readdir(3) results in find_short_object_filename()) to speed up
> finding unambiguous shorts object hashes.  I wonder if it could be
> used here as well, but I don't see an easy way.
>
>>       if (!args->no_dependents) {
>>               if (!args->deepen) {
>>                       for_each_ref(mark_complete_oid, NULL);
>> diff --git a/sha1_file.c b/sha1_file.c
>> index 1b94f39c4..c903cbcec 100644
>> --- a/sha1_file.c
>> +++ b/sha1_file.c
>> @@ -1262,6 +1262,9 @@ int sha1_object_info_extended(const unsigned char =
*sha1, struct object_info *oi,
>>               if (find_pack_entry(real, &e))
>>                       break;
>>
>> +             if (flags & OBJECT_INFO_SKIP_LOOSE)
>> +                     return -1;
>> +
>>               /* Most likely it's a loose object. */
>>               if (!sha1_loose_object_info(real, oi, flags))
>>                       return 0;
>>
>
> This early return doesn't just skip checking loose objects.  It
> also skips reloading packs and fetching missing objects for
> partial clones.  That may not be a problem for fetch-pack, but
> it means the flag has a misleading name.  Do you get the same
> performance improvement if you make it only skip that
> sha1_loose_object_info() call?
>

I changed the flag name following Junio's suggestion. If we skip
sha1_loose_object_info call,
reprepare_packed_git(...) runs for every non-existing refs and git
fetch becomes slower.

Takuto
