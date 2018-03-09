Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59F321F404
	for <e@80x24.org>; Fri,  9 Mar 2018 14:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751183AbeCIOMw (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Mar 2018 09:12:52 -0500
Received: from mail-wm0-f43.google.com ([74.125.82.43]:52988 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751077AbeCIOMv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Mar 2018 09:12:51 -0500
Received: by mail-wm0-f43.google.com with SMTP id t3so4157522wmc.2
        for <git@vger.kernel.org>; Fri, 09 Mar 2018 06:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=klg9Sci3ZgK5bLaoIf3xx/Nq2j/N2rSD5FjOo9BhVm0=;
        b=GugN3H3rFlc+PtO9McbQypmaeO2vTjY8AUJgGIs5OyxR56p4KHXnH0nmdFaw0WotG6
         i9mgdOODQlmf+Y9YTy5heliqJLpFwt6sQNey1G6F8S5b4f0wHfmBDnDF3jUTHirWThLQ
         X6ef1RpI58VyPqPzr+aLULme5JrskOmiIZsLA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=klg9Sci3ZgK5bLaoIf3xx/Nq2j/N2rSD5FjOo9BhVm0=;
        b=ojEQKksrGPw6Kux8n7TSEFRxsYc0C18TkfzIs9jPv2ve+B2iqK9UdzDZk43rX2jI+L
         l0A1JOM9icoGfn6GKHkYe1lwjMIa/r+Mctjxz95cWG0oT6ApOu0zZwS4XnQNTohKaRG+
         cYxU1KBrCrDWIIbrBI+WLTRzJefoAh5SkUsAWSKkUobxem/Fm5idwXxSbS6U0jUo794W
         RP7PgqhmXkXwvi86mywH1mZUc/KntlVlHCgdC0nb7AuBxxDMz8x3k+nOea2glMd0uHJ1
         fTvLBuIG/JnKBfxlSdSchNJaHIODEZT00cVA19gLJ/jWpUXFKlqmFhZeIm5BpqvOeBRu
         FP7Q==
X-Gm-Message-State: AElRT7G11OdD10oRN2OwNf4QJI41buETVjf/Poaj3M9vYTzGQj8lbwjv
        n2Cg9/7tFvaIP+lPR3FNH4LmFic/F7Y=
X-Google-Smtp-Source: AG47ELsVDmE3urHhJxZRwn4zYxMZRDci/ULE3hy81pEyatmATQOM0XMrl5uARNpMogXDHZUVfXiVOw==
X-Received: by 10.80.243.145 with SMTP id g17mr12605001edm.6.1520604769355;
        Fri, 09 Mar 2018 06:12:49 -0800 (PST)
Received: from mail-wr0-f175.google.com (mail-wr0-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id z7sm915741edb.46.2018.03.09.06.12.48
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Mar 2018 06:12:48 -0800 (PST)
Received: by mail-wr0-f175.google.com with SMTP id f14so9150666wre.8
        for <git@vger.kernel.org>; Fri, 09 Mar 2018 06:12:48 -0800 (PST)
X-Received: by 10.223.182.156 with SMTP id j28mr25659359wre.66.1520604767726;
 Fri, 09 Mar 2018 06:12:47 -0800 (PST)
MIME-Version: 1.0
Received: by 10.28.142.20 with HTTP; Fri, 9 Mar 2018 06:12:06 -0800 (PST)
In-Reply-To: <xmqqr2ouwgsd.fsf@gitster-ct.c.googlers.com>
References: <20180308120639.109438-1-tikuta@chromium.org> <xmqqr2ouwgsd.fsf@gitster-ct.c.googlers.com>
From:   Takuto Ikuta <tikuta@chromium.org>
Date:   Fri, 9 Mar 2018 23:12:06 +0900
X-Gmail-Original-Message-ID: <CALNjmMq9gvRzkoYCfXppTVTR5UtvmBZ_4hVuBLB0t7YzR36Wbg@mail.gmail.com>
Message-ID: <CALNjmMq9gvRzkoYCfXppTVTR5UtvmBZ_4hVuBLB0t7YzR36Wbg@mail.gmail.com>
Subject: Re: [PATCH] fetch-pack.c: use oidset to check existence of loose object
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2018-03-09 3:42 GMT+09:00 Junio C Hamano <gitster@pobox.com>:
> Takuto Ikuta <tikuta@chromium.org> writes:
>> This patch stores existing loose objects in hashmap beforehand and use
>> it to check existence instead of using lstat.
>>
>> With this patch, the number of lstat calls in `git fetch` is reduced
>> from 411412 to 13794 for chromium repository.
>>
>> I took time stat of `git fetch` disabling quickfetch for chromium
>> repository 3 time on linux with SSD.
>
> Now you drop a clue that would help to fill in the blanks above, but
> I am not sure what the significance of your having to disable
> quickfetch in order to take measurements---it makes it sound as if
> it is an articificial problem that does not exist in real life
> (i.e. when quickfetch is not disabled), but I am getting the feeling
> that it is not what you wanted to say here.
>

Yes, I just wanted to say 'git fetch' invokes fetch-pack.
fetch-pack is skipped when running git fetch repeatedly while
remote has no update by quickfetch. So I disabled it to see the
performance of fetch-pack. In chromium repository, master branch
is updated several times in an hour, so git fetch invokes fetch-pack
in such frequency.

> In any case, do_fetch_pack() tries to see if all of the tip commits
> we are going to fetch exist locally, so when you are trying a fetch
> that grabs huge number of refs (by the way, it means that the first
> sentence of the proposed log message is not quite true---it is "When
> fetching a large number of refs", as it does not matter how many
> refs _we_ have, no?), everything_local() ends up making repeated
> calls to has_object_file_with_flags() to all of the refs.
>

I fixed description by changing 'refs' to 'remote refs'. In my understanding,
git tries to check existence of remote refs even if we won't fetch such refs.

> I like the idea---this turns "for each of these many things, check
> if it exists with lstat(2)" into "enumerate what exists with
> lstat(2), and then use that for the existence test"; if you need to
> try N objects for existence, and you only have M objects loose where
> N is vastly larger than M, it will be a huge win.  If you have very
> many loose objects and checking only a handful of objects for
> existence check, you would lose big, though, no?
>

Yes. But I think the default limit for the number of loose objects, 7000,
gives us small overhead when we do enumeration of all objects.

>> diff --git a/fetch-pack.c b/fetch-pack.c
>> index d97461296..1658487f7 100644
>> --- a/fetch-pack.c
>> +++ b/fetch-pack.c
>> @@ -711,6 +711,15 @@ static void mark_alternate_complete(struct object *obj)
>>       mark_complete(&obj->oid);
>>  }
>>
>> +static int add_loose_objects_to_set(const struct object_id *oid,
>> +                                 const char *path,
>> +                                 void *data)
>> +{
>> +     struct oidset* set = (struct oidset*)(data);
>
> Style: in our codebase, asterisk does not stick to the type.
>
>         struct oidset *set = (struct oidset *)(data);
>
>> @@ -719,16 +728,21 @@ static int everything_local(struct fetch_pack_args *args,
>>       int retval;
>>       int old_save_commit_buffer = save_commit_buffer;
>>       timestamp_t cutoff = 0;
>> +     struct oidset loose_oid_set = OIDSET_INIT;
>> +
>> +     for_each_loose_object(add_loose_objects_to_set, &loose_oid_set, 0);
>
> OK, so this is the "enumerate all loose objects" phase.
>
>>       save_commit_buffer = 0;
>>
>>       for (ref = *refs; ref; ref = ref->next) {
>>               struct object *o;
>> +             unsigned int flag = OBJECT_INFO_QUICK;
>
> Hmm, OBJECT_INFO_QUICK optimization was added in dfdd4afc
> ("sha1_file: teach sha1_object_info_extended more flags",
> 2017-06-21), but since 8b4c0103 ("sha1_file: support lazily fetching
> missing objects", 2017-12-08) it appears that passing
> OBJECT_INFO_QUICK down the codepath does not do anything
> interesting.  Jonathan (cc'ed), are all remaining hits from "git
> grep OBJECT_INFO_QUICK" all dead no-ops these days?
>

Yes the flag is no-op now, but let me untouched the flag in this patch.

>> diff --git a/sha1_file.c b/sha1_file.c
>> index 1b94f39c4..c903cbcec 100644
>> --- a/sha1_file.c
>> +++ b/sha1_file.c
>> @@ -1262,6 +1262,9 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
>>               if (find_pack_entry(real, &e))
>>                       break;
>>
>> +             if (flags & OBJECT_INFO_SKIP_LOOSE)
>> +                     return -1;
>> +
>
> I cannot quite convince myself that this is done at the right layer;
> it smells to be at a bit too low a layer.  This change makes sense
> only to a caller that is interested in the existence test.  If the
> flag is named after what it does, i.e. "ignore loose object", then
> it does sort-of make sense, though.
>

Couldn't come up with good alternative for this, I followed your
flag name suggestion in patch v3.

Takuto
