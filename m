Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05BBB200B9
	for <e@80x24.org>; Tue,  8 May 2018 18:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755691AbeEHSiF (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 May 2018 14:38:05 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:42417 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755402AbeEHSiD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 May 2018 14:38:03 -0400
Received: by mail-yw0-f194.google.com with SMTP id q7-v6so1631466ywd.9
        for <git@vger.kernel.org>; Tue, 08 May 2018 11:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XFJfeX7IX/YZVglkLQuAVKh1dwNx2sRc1bRVwVVUfUg=;
        b=PH8SBEXgXHpPwMajmPRgYbOFWXHsRe5Pj5BCkyfEt20lS2Es5ofHdVkgOmB+3S31Ug
         EjrTlt7D2poytwMj7DnueZ/ThSveJv1Ke+NQHZknrsO/+T8Edr2rAJ16TnU+VgPjjwQf
         7ntEDiP9BuYnZ3JieaLH5y27OFvhNYz8i960TpgEP1kHEjMrqHpyoprptPhHZUwO68tz
         Ai2NvvmlAe3Z6shtZAT991cQgdeSZBYtDYhD+zm96Li2zE8Hn+OLMQ3GS6YYGUIGylOo
         KGkWqX/KtrCT/xGATX0raBWXU0Z3DyirfgDjMj5jUcbKoQxeUlPHZjtMVB5EmNOdEnBL
         ybwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XFJfeX7IX/YZVglkLQuAVKh1dwNx2sRc1bRVwVVUfUg=;
        b=LtIHKLKCPwIBFXgX5pseud1xbeN/zyfmhC7ZVrb7GMq9ANo8+6TT0lx5+OKLj+ZOjT
         RZ2nJov218vl/glSp4xQ+NuVa/Fz1g6OfjmCkfI4PyjXj3igoJ/qI+Td2MMOwiRrDBBY
         7GddUQzuVXY5wJoVxymDpwOSTz33hVdFWFDwPjUgGWLq39pNnYvQqQgHRxvbErlQJVKS
         Uku73Ro5rCAP5mbteyRpVG93aIaKNOqtTWGHXAcpf2rAC/rTRp5sfsaHAyGzue92gdhC
         7euC2zaYwmFzuVHAcJxhADIqFsJQf9iRMhZu0D+3svzK12OCvAMZ+RcPMfoRRVaXuxKI
         YNIg==
X-Gm-Message-State: ALQs6tA17Ds4VaL+xlMY/5INf2jyDtrfftVgDdsZd3ExhE6NJNpsOTZv
        GA8+3HDn2XxNsxaEBYZXpiWktJ78HxgO7mqYYSBEJQ==
X-Google-Smtp-Source: AB8JxZp09I6rm8i2xJ/vg8CmQ9JcyvbcohzeVEny0/Y80Rtgl34UmiWcq/r1hE4h58TjsI9ozmVB0nrd8Er6pjXqD/s=
X-Received: by 2002:a81:4ec9:: with SMTP id c192-v6mr23824177ywb.421.1525804682075;
 Tue, 08 May 2018 11:38:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf90:0:0:0:0:0 with HTTP; Tue, 8 May 2018 11:38:01 -0700 (PDT)
In-Reply-To: <CACsJy8D-e-bff3S+LQAMfwB-w8OpkjrfFrV9O5S3ku+M5aAjQA@mail.gmail.com>
References: <20180501213403.14643-1-sbeller@google.com> <20180507225916.155236-1-sbeller@google.com>
 <20180507225916.155236-14-sbeller@google.com> <CACsJy8D-e-bff3S+LQAMfwB-w8OpkjrfFrV9O5S3ku+M5aAjQA@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 8 May 2018 11:38:01 -0700
Message-ID: <CAGZ79kZhAjArSksrWMzJc49BKu1HF-R6kBHEzkus-in4fbTZvQ@mail.gmail.com>
Subject: Re: [PATCH v2 13/13] alloc: allow arbitrary repositories for alloc functions
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jameson Miller <jamill@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 8, 2018 at 8:00 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Tue, May 8, 2018 at 12:59 AM, Stefan Beller <sbeller@google.com> wrote:
>> @@ -501,9 +509,31 @@ void raw_object_store_clear(struct raw_object_store *o)
>>  void parsed_object_pool_clear(struct parsed_object_pool *o)
>>  {
>>         /*
>> -        * TOOD free objects in o->obj_hash.
>> -        *
>>          * As objects are allocated in slabs (see alloc.c), we do
>>          * not need to free each object, but each slab instead.
>> +        *
>> +        * Before doing so, we need to free any additional memory
>> +        * the objects may hold.
>>          */
>> +       unsigned i;
>> +
>> +       for (i = 0; i < o->obj_hash_size; i++) {
>> +               struct object *obj = o->obj_hash[i];
>> +
>> +               if (!obj)
>> +                       continue;
>> +
>> +               if (obj->type == OBJ_TREE) {
>> +                       free(((struct tree*)obj)->buffer);
>
> It would be nicer to keep this in separate functions, e.g.
> release_tree_node() and release_commit_node() to go with
> alloc_xxx_node().

ok, I can introduce that, although it seems unnecessary complicated
for now.

On top of this series I started an experiment (which rewrites alloc
and object.c a whole lot more; for performance reasons), which gets
rid of the multiple alloc_states. There will be only one allocation for
one repository, it can allocate across multiple types without alignment
overhead. It will reduce memory footprint of obj_hash by half, via
storing indexes instead of pointers in there.
That said, the experiment shall not influence the
direction of this series. Will fix.

>> +               } else if (obj->type == OBJ_COMMIT) {
>> +                       free_commit_list(((struct commit*)obj)->parents);
>> +                       free(&((struct commit*)obj)->util);
>> +               }
>> +       }
>
> I still don't see who frees obj_hash[] (or at least clears it if not
> freed). If I'm going to use this to free memory in pack-objects then
> I'd really prefer obj_hash[] freed because it's a big _big_ array.

gah!

> Just to be clear, what I mean is
>
> FREE_AND_NULL(o->obj_hash);
> o->obj_hash_size = 0;

ok, I just put it here, just before the calls
to clear_alloc_state()s.
