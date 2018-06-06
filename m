Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A51A01F403
	for <e@80x24.org>; Wed,  6 Jun 2018 04:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750955AbeFFE6K (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 00:58:10 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:42592 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750808AbeFFE6J (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 00:58:09 -0400
Received: by mail-oi0-f67.google.com with SMTP id k190-v6so4245997oib.9
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 21:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OFQJGN/Z/N34G+XmgwSRg9JgCfJJeCJddgL1FBj5Qc4=;
        b=pOZ9nt9oLJc6h+IZ330pYYAYHvxu94/6nxI9JXVzIHWc2nLLHt0qb3F7CJXpKT/1I2
         8g9/HEv4XW76ocZBunks5crg+2M25WaC7726jHPLXE0WX1+NEAAaJx8et+LZpOMcQ6Si
         OQcSZFfMcYFgd2vGbMtEfDgVAJCAhqBHD/sJHjgXJrouqC5gD8j6bqHLi2izQhBwjNr/
         H8XwVAHF2jlJmIqwzN8iuolv5kEFjgEf70QJZwpsM5UfTZXvgKnWSdekipr9hoGp7bIM
         yGVsg/wwHVt5huHXpJSIzS8NqXg62WMqZ4lv6xMZQGSjtAFaxq9THhHouVhlzNNVEB3o
         sZEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OFQJGN/Z/N34G+XmgwSRg9JgCfJJeCJddgL1FBj5Qc4=;
        b=T8SjA1E2dXyqyOW956lYjBGYW2u8TpqIyJnrngM45xRe99VMKn9RGIoC+Ol9kXV+RD
         ivVeTMs80op6EjtNcM4kkP+UK9lK1fdxBvidsSzOc8i6F4qBq7zbOXW5fIKevCYFnH9u
         o8OtXQvgp6i+DVyNNbLTkyNbJinWQd2/2tfSoauEFBQ2TpSKYa0Y9fMT8SZeUXUTUqdC
         lWKUuoemsHnOQfsClZkYMIh8oEIxe80JApcZd2BDE0qbrKEHS5jW5lYYj8ineG9rPzWM
         u7meQZwEDTrTASvoii3Dcew2wxfcvQd7QHU/LfK4tz1FpXtrpftgHE10yu+y5rrP/+eh
         w3nw==
X-Gm-Message-State: APt69E0nOiVUSG0470cUl+0VUcg+/pokHt9jBOAS+eXy1RARdZpECz2b
        3YsdOyPvm1iTLxaX1uYqIMZf3dMhIVsk/ljQoC0=
X-Google-Smtp-Source: ADUXVKKRfgtYADFkIMLWC37Hu56xGpCrA4eG+FxEQs7pW5hMKa095/ZY/jQH7BMWjF3DArCyBEJEHPWBzetP8iFFmzY=
X-Received: by 2002:aca:ed53:: with SMTP id l80-v6mr902235oih.281.1528261089184;
 Tue, 05 Jun 2018 21:58:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:2082:0:0:0:0:0 with HTTP; Tue, 5 Jun 2018 21:57:38 -0700 (PDT)
In-Reply-To: <20180605165826.GB158365@google.com>
References: <20180601161153.15192-1-pclouds@gmail.com> <20180605154334.22613-1-pclouds@gmail.com>
 <20180605154334.22613-7-pclouds@gmail.com> <20180605165826.GB158365@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 6 Jun 2018 06:57:38 +0200
Message-ID: <CACsJy8CB4-vVNY7dhyv=2ZyZgbKb9XVgB9djxBbJKa9AtxvYVg@mail.gmail.com>
Subject: Re: [PATCH 6/6] Forbid "the_index" in dir.c and unpack-trees.c
To:     Brandon Williams <bmwill@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 5, 2018 at 6:58 PM, Brandon Williams <bmwill@google.com> wrote:
> On 06/05, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>> Use of global variables like the_index makes it very hard to follow
>> the code flow, especially when it's buried deep in some minor helper
>> function.
>>
>> We are gradually avoiding global variables, this hopefully will make
>> it one step closer. The end game is, the set of "library" source files
>> will have just one macro set: "LIB_CODE" (or something). This macro
>> will prevent access to most (if not all) global variables in those
>> files. We can't do that now, so we just prevent one thing at a time.
>>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.=
com>
>> ---
>>  Should I keep my trick of defining the_index to
>>  the_index_should_not_be_used_here? It may help somewhat when people
>>  accidentally use the_index.
>
> We already have a set of index compatibility macros which this could
> maybe be a part of.

I like it. Only attr.c and submodule.c fail to build if I make
the_index declaration part of NO_THE_INDEX_COMPATIBILITY_MACROS. So
I'm going to drop this patch for now, work on kicking the_index out of
submodule.c and attr.c then move the_index decl there in a separate
series.

> Though if we want to go this way I think we should
> do the reverse of this and instead have GLOBAL_INDEX which must be
> defined in order to have access to the global.  That way new files are
> already protected by this and it may be easier to reduce the number of
> these defines through our codebase than to add them to every single
> file.
>
>>
>>  cache.h        | 2 ++
>>  dir.c          | 2 ++
>>  unpack-trees.c | 2 ++
>>  3 files changed, 6 insertions(+)
>>
>> diff --git a/cache.h b/cache.h
>> index 89a107a7f7..ecc96ccb0e 100644
>> --- a/cache.h
>> +++ b/cache.h
>> @@ -330,7 +330,9 @@ struct index_state {
>>       struct ewah_bitmap *fsmonitor_dirty;
>>  };
>>
>> +#ifndef NO_GLOBAL_INDEX
>>  extern struct index_state the_index;
>> +#endif
>>
>>  /* Name hashing */
>>  extern int test_lazy_init_name_hash(struct index_state *istate, int try=
_threaded);
>> diff --git a/dir.c b/dir.c
>> index ccf8b4975e..74d848db5a 100644
>> --- a/dir.c
>> +++ b/dir.c
>> @@ -8,6 +8,8 @@
>>   *            Junio Hamano, 2005-2006
>>   */
>>  #define NO_THE_INDEX_COMPATIBILITY_MACROS
>> +/* Do not use the_index. You should have access to it via function arg =
*/
>> +#define NO_GLOBAL_INDEX
>>  #include "cache.h"
>>  #include "config.h"
>>  #include "dir.h"
>> diff --git a/unpack-trees.c b/unpack-trees.c
>> index 3ace82ca27..9aebe9762b 100644
>> --- a/unpack-trees.c
>> +++ b/unpack-trees.c
>> @@ -1,4 +1,6 @@
>>  #define NO_THE_INDEX_COMPATIBILITY_MACROS
>> +/* Do not use the_index here, you probably want o->src_index */
>> +#define NO_GLOBAL_INDEX
>>  #include "cache.h"
>>  #include "argv-array.h"
>>  #include "repository.h"
>> --
>> 2.18.0.rc0.333.g22e6ee6cdf
>>
>
> --
> Brandon Williams



--=20
Duy
