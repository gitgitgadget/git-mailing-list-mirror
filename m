Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D1E31F4DD
	for <e@80x24.org>; Wed,  6 Sep 2017 22:00:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753167AbdIFWAB (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Sep 2017 18:00:01 -0400
Received: from mail-yw0-f180.google.com ([209.85.161.180]:34294 "EHLO
        mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752609AbdIFWAA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Sep 2017 18:00:00 -0400
Received: by mail-yw0-f180.google.com with SMTP id r85so10503758ywg.1
        for <git@vger.kernel.org>; Wed, 06 Sep 2017 14:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5GT0H1O+bE/t5slIPcirIksV7Hl0I75zZzD2E8qw/gg=;
        b=vssygeG3ZpRnDxaSG3zcNzJUIr3hXceLF2osv7+7Nv9dzWT1vu5lqCw5675nCW/BZK
         c2IdUbbZ7lUhFeLcNdsLdfUVgc6wN/n8rp+wV+B0rt2D4FCswCZ9bD3FnKR9retQ+OsF
         /OEfStgT29Qh7UYGa/sA4a3NHNUuBphTv/MF1rnLkkQkxwxl6etmK9FpkrsfnuXy4xIZ
         SjylyWTdqcZhAq3ZxAhW3GVwbbomLOoQwQVMlJljlcWDRUFvPfulxnFKjTgsh/eHmo9+
         EgYmDAIkK07AifO3XAseUaT6Qs96Xd0a8B7qzONOGYkUb5oJ7WGZtjf80YUuh8Y82IOh
         WcwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5GT0H1O+bE/t5slIPcirIksV7Hl0I75zZzD2E8qw/gg=;
        b=UmTb1JFvIujbvx+JirjUjU0tca5EJfvO5GHJo1cVyqsvB8dyn/RQ3xxJ5bp8l/Fwbn
         RMAYBHgdMUezNoSKkujr7yFuNqKZ6OYP1JTqN+p7qDVaUN5qjUb7e5i7GAk7Ks8OXjgc
         f7NDo08MWWKlcXQYnB65W6VaTcnHHGs/3nGJsuJJNeH/g16ha7ehMkB/gqispqTr44c2
         OzjCWtwF5OWzGoa7RHiVoIR4gSvlBLmVpWerlxDqrdqygZLEd2CguZ50AMRKSDAvH4rh
         I7wJKBl74sBjfri8uyaQp1PtpTt99kNg/vSbexqy52SYy/baBaZly/xETOYrnS8TjlMM
         2LPg==
X-Gm-Message-State: AHPjjUj17ntdJG+q/ST58n9+a6QRzgTEcVd89TQKlC9PQS2JMVQkNV0r
        ddGM1eb9VmZNrFbWXmlIv27tou7k/5sx
X-Google-Smtp-Source: ADKCNb5hxxozUNMAEi2fKRbZnCg3yH4PRZxb0Zza2KjQfyDRjzWrpNhIBEyeovuzVpEioh13JYSRgZcSidcn7fX1ie0=
X-Received: by 10.129.69.34 with SMTP id s34mr479099ywa.29.1504735199219; Wed,
 06 Sep 2017 14:59:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.116.7 with HTTP; Wed, 6 Sep 2017 14:59:58 -0700 (PDT)
In-Reply-To: <xmqqd1734mvg.fsf@gitster.mtv.corp.google.com>
References: <20170830064634.GA153983@aiede.mtv.corp.google.com>
 <20170830070812.GZ153983@aiede.mtv.corp.google.com> <xmqqd1734mvg.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 6 Sep 2017 14:59:58 -0700
Message-ID: <CAGZ79kb+GDvh8+HZ6Hu8ydj6BUNY4YckvyXtvZbsxaME9zyWYQ@mail.gmail.com>
Subject: Re: [PATCH 25/39] sha1_file: allow alt_odb_usable to handle arbitrary repositories
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 6, 2017 at 1:01 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>  sha1_file.c | 16 +++++++++-------
>>  1 file changed, 9 insertions(+), 7 deletions(-)
>>
>> diff --git a/sha1_file.c b/sha1_file.c
>> index e7c86e5363..b854cad970 100644
>> --- a/sha1_file.c
>> +++ b/sha1_file.c
>> @@ -25,6 +25,7 @@
>>  #include "repository.h"
>>  #include "object-store.h"
>>  #include "streaming.h"
>> +#include "path.h"
>>  #include "dir.h"
>>  #include "mru.h"
>>  #include "list.h"
>> @@ -281,17 +282,18 @@ static const char *alt_sha1_path(struct alternate_object_database *alt,
>>  /*
>>   * Return non-zero iff the path is usable as an alternate object database.
>>   */
>> -#define alt_odb_usable(r, p, n) alt_odb_usable_##r(p, n)
>> -static int alt_odb_usable_the_repository(struct strbuf *path,
>> -                                      const char *normalized_objdir)
>> +static int alt_odb_usable(struct repository *r, struct strbuf *path,
>> +                       const char *normalized_objdir)
>
> These token-pasting macros introduced in 07-24/39 were certainly
> cute but they may be rather misleading and useless.  e.g. a natural
> expectaion would be
>
>         struct repository *r = &the_repository;
>         prepare_alt_odb(r);
>
> to work, but obviously it wouldn't.  And this step and later in
> 25-39/39 corrects them one by one.

Yes. The intent was to deliver patches that are easiest to review as
that is usually the crux with long series. To do that we came up with this
way:
* patches  07-24 can be reviewed easily by only looking at
   the textual replacement, no need to think about implications.
   It should be boring(in a good way) to review these.
* patches 25-39, that allow arbitrary repositories to be handled
   only need to be reviewed inside its function bounds, because
   each function call that takes a repository argument will be verified
   by the compiler, precisely because the above won't work!
   That way the reviewer can rely on the compile output
   that the conversion was done in the correct order and no
   small function was missed. All review attention can go into
   just looking at the one function that is converted in such a
   patch. no need to double check with other parts of the code.
   We discussed we'd send the patches 25-39 with --function-context.
   The follow ups will do so.

> I suspect that you used the token-pasting cuteness because you
> thought that the callsite would not have to change in the later step
> like 25/39 that removes the trick.

No. We did these two different phases to ease review specifically.

Note how the call site is the function itself, ( --function-context would
have been really neat here)


>  I also suspect that you thought
> that it may be a good thing that prepare_alt_odb(r) does not work
> immediately after 07/39, as the callee is not prepared.  But both of
> these are misguided.
>
> If you have two functions, A and B, that we want to update to
> eventually take a "struct repository *" argument, and if A uses B in
> its implementation, the endgame would be
>
>         A(struct repository *r, ...)
>         {
>                 ...
>                 B(r, ...);
>                 ...
>         }
>
> but with the ##r approach, the call to B in A in the initial
> token-pasting phase would say B(the_repository, ...) so the call
> will need to be changed in the step you update A's implementation to
> take a caller-supplied respotory object anyway.  And the fact that a
> function's first parameter is not the_repository (i.e. leaving B()'s
> signature unchanged while it is not ready to take a repository) is
> sufficient to mark that a function is not yet prepared to take a
> caller-supplied repository object.

The absence of a repository argument is not sufficient that a function
(or any function called by it) does not rely on some global state, which
needs to be put into the repository struct.

So when converting function A (above), the careful reviewer needs to
inspect B, C, D... if they touch global state. Using the current approach,
most functions (maybe just B and C here) would take a repository struct
already, and the compiler would yell if these were not ready for anything
except the_repository. So the reviewer only has to worry about D.

> I found that this aspect of the structure of the series was somewhat
> irritating in that (1) combining the earlier ##r thing with its fix
> would have made the code that needs to be reviewed much cleaner,

agreed.

> (2) it wouldn't have made the patch that longer,

but more complicated to review (and write actually; as it was easy
to reason about functions to be ready for conversion, not using
global state)

> and most importantly
> (3) it is unclear why 24-7 != 39-25, i.e. it is hard to answer "is
> there any ##r hack still remaining after this series?  if so why?"

Jonathan is currently OOO, but last week we continued developing this
series and ended up with ca. 90 patches in the series.

> The end-result of the whole series makes me think that it is going
> in the right direction, though.

We'll revisit if we can squash commits before sending out.

Thanks for the feedback,
Stefan
