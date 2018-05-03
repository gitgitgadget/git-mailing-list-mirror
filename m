Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFE78200B9
	for <e@80x24.org>; Thu,  3 May 2018 17:25:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751236AbeECRZ3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 13:25:29 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:42652 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750947AbeECRZ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 13:25:29 -0400
Received: by mail-yb0-f195.google.com with SMTP id 140-v6so6769926ybc.9
        for <git@vger.kernel.org>; Thu, 03 May 2018 10:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=smIEoFKDqC2lmBLDvwXPUnmcldOVRGvf04hnk1uIxi4=;
        b=HmQujRB3Mm1de9skAZHwGIKNLrAmnrnUIH+0Vi/8DRZujRXXOfd+qOD/+D0l+5FHVa
         SXrMgUKLKcjlVEh7mV6nrRXzWPtLBfPacA2Mvy8USd2aj1VLQVVcGD+7hLMofMStxjiA
         Dr2DHZ0gdpoqbYTdPMeqsuqr6C401C/+tw3lm8pIQpSYUPzrjvb4OWAeCNoywHIpKaig
         7SKSKr33CnGxolSzVtVGV6iKvv0KAL716oleHa2SeHqOpSA2GPqwyPDZ3W9xCKfX2S2I
         gevWac5io4uceU4emAQ8urekJgvqi1BMRg1pObgXKnnt4SNT/GcBHWN+TKtBhbo4KJ7L
         IHfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=smIEoFKDqC2lmBLDvwXPUnmcldOVRGvf04hnk1uIxi4=;
        b=nzHXZp8U6xGQuEioCU8fr3eI3FIUHk+z1HQ+mL3Num/+EZj1F4wLjMa16iuxYH2c8L
         7Mwa37zv9pDJzogiXwq7Pd68uVLdlgq2HTmnkUHeh/B/K13MyzP/qldNszpRS6daZdxX
         VjZN16XJ3QVrJl+9OOM2qBYyqW4vzThnHmcn+uK1tu4GKD/nM+9IWX0V0HMPCtZy1I2N
         nDN6GKRAIdu1zHOBPyfAk6h8moQQ/S8/PGo8vMr5xqdw721Bw0HdWNw3hXGuU0wYJTq4
         mVwHDgwgPTq3+qkBbhaT99+KT/vjAeDpoCyi52Hz71CVUF1axZY8E6SBH9+PWRTlVSfa
         X7uw==
X-Gm-Message-State: ALQs6tBvih1jeOmy7NgGe8b1PSh7yOEvWY6LOHQzwrAI6RzraWaiiRiv
        31TTGyjPEREHVeq/2UbfyctnuAfnSq2TkcDHnuhE8Q==
X-Google-Smtp-Source: AB8JxZr6I+T3pkkDhDFNpfDNi7LOJn3z5MMQstf+gpDDbO4BH5iPTAqQep5FRADGiTQQ/hzfwGOlU9o7wBCtCM2QY8Q=
X-Received: by 2002:a5b:14f:: with SMTP id c15-v6mr15517642ybp.292.1525368328032;
 Thu, 03 May 2018 10:25:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf90:0:0:0:0:0 with HTTP; Thu, 3 May 2018 10:25:27 -0700 (PDT)
In-Reply-To: <20180502135029.051dcaed75b18fb95ae6b28f@google.com>
References: <20180501213403.14643-1-sbeller@google.com> <20180501213403.14643-14-sbeller@google.com>
 <20180502135029.051dcaed75b18fb95ae6b28f@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 3 May 2018 10:25:27 -0700
Message-ID: <CAGZ79ka6rTsRL7e-Dr5TZZeQRDCq6m4C-_DsRpDuuxAh48=-VQ@mail.gmail.com>
Subject: Re: [PATCH 13/13] alloc: allow arbitrary repositories for alloc functions
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git <git@vger.kernel.org>, Jameson Miller <jamill@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 2, 2018 at 1:50 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
> On Tue,  1 May 2018 14:34:03 -0700
> Stefan Beller <sbeller@google.com> wrote:
>
>> +void *allocate_alloc_state(void)
>> +{
>> +     return xcalloc(1, sizeof(struct alloc_state));
>> +}
>> +
>> +void clear_alloc_state(struct alloc_state *s)
>> +{
>> +     while (s->slab_nr > 0) {
>> +             s->slab_nr--;
>> +             free(s->slabs[s->slab_nr]);
>> +     }
>> +}
>
> These functions are asymmetrical. I understand why it is this way
> (because we use pointers, and we want to use FREE_AND_NULL), but would
> still prefer _INIT and _release().
>
>>  static inline void *alloc_node(struct alloc_state *s, size_t node_size)
>>  {
>>       void *ret;
>> @@ -45,54 +63,56 @@ static inline void *alloc_node(struct alloc_state *s, size_t node_size)
>>       ret = s->p;
>>       s->p = (char *)s->p + node_size;
>>       memset(ret, 0, node_size);
>> +
>> +     ALLOC_GROW(s->slabs, s->slab_nr + 1, s->slab_alloc);
>> +     s->slabs[s->slab_nr++] = ret;
>> +
>>       return ret;
>>  }
>
> This unconditionally grows the slabs for each node allocation. Shouldn't
> more than one node fit in each slab?

Yes. I'll go with Duy's idea and make it a linked list by using the first
object as a pointer to the next slab.

>
>> +extern struct alloc_state the_repository_blob_state;
>> +extern struct alloc_state the_repository_tree_state;
>> +extern struct alloc_state the_repository_commit_state;
>> +extern struct alloc_state the_repository_tag_state;
>> +extern struct alloc_state the_repository_object_state;
>
> (Context: these were in alloc.h)
>
> These seem to be used only in object.c, and only in one function - could
> we declare them "static" inside that function instead?

ok

>
>> -struct object_parser *object_parser_new(void)
>> +struct object_parser *object_parser_new(int is_the_repo)
>>  {
>>       struct object_parser *o = xmalloc(sizeof(*o));
>>       memset(o, 0, sizeof(*o));
>> +
>> +     if (is_the_repo) {
>> +             o->blob_state = &the_repository_blob_state;
>> +             o->tree_state = &the_repository_tree_state;
>> +             o->commit_state = &the_repository_commit_state;
>> +             o->tag_state = &the_repository_tag_state;
>> +             o->object_state = &the_repository_object_state;
>> +     } else {
>> +             o->blob_state = allocate_alloc_state();
>> +             o->tree_state = allocate_alloc_state();
>> +             o->commit_state = allocate_alloc_state();
>> +             o->tag_state = allocate_alloc_state();
>> +             o->object_state = allocate_alloc_state();
>> +     }
>>       return o;
>>  }
>
> I don't think saving 5 allocations is worth the code complexity (of the
> additional parameter).

Ok, I'll remove this overhead.

Thanks,
Stefan
