Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB6CC1F89D
	for <e@80x24.org>; Fri, 28 Jul 2017 16:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751991AbdG1QEl (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Jul 2017 12:04:41 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:38000 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751882AbdG1QEk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jul 2017 12:04:40 -0400
Received: by mail-it0-f68.google.com with SMTP id h199so10818126ith.5
        for <git@vger.kernel.org>; Fri, 28 Jul 2017 09:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CitiqXbv2mMBI7KtWegObSnaxxu1RYamFBv8kz+k1kI=;
        b=Vm5TuJ/IueJapd4PmUm7R9nbffD+yFWCCnWjmci03Lz31drGRzJIA/n+ptM9IiXeDz
         f6B3rPXdOPrKrppaJ+QNIwkgDlfU3MNe2BhHvKRWjFLNNjdxhXpN4DhAaLG+ZGL4Eb8i
         KvzfpJqw8e+pqQ1mDkclABrT9q+zVyKEgzU3lqeLGs9R/9nJazhSqtr7zWfNe2tH9HYZ
         3bFMcgatp7v9ERQ7zZpVMz89Tam8CZbfVwEpizp5byz01ZJmFq7Y2K+zzycSuLrfOXQn
         xxI24XR94F9wj1rNuy9QfVtGAzePm8qbynI1uRWM0xJNuQ/rbqNNyiFZNIU2fXaBgFhC
         Olqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CitiqXbv2mMBI7KtWegObSnaxxu1RYamFBv8kz+k1kI=;
        b=CbaVR7A0ugrmy8AW5BZqcQitrNHlNuqNurPhjnLWC3c8JHnQfaaqRiZbf9UaWQyRym
         jTMjDVLRXLY1B9Cb7tcsJ4wr0PgSO2bEbWps6+GxrzCaluv14ho+pF7O2SISZcjlbLN/
         ZG/hpnHgWvtYQwnSHbORQo+blswBRRYdchmspU7SatKqJRHJCsqoPBXSatErsVqWTAB0
         /y+kSHYE0yIh6xsIeexY4E1fW+u0TuWl8qHTufijBEdJpvm94Fduu565PHnhiy2utRsr
         lzbj9iL4Y0K4zNNJmoGWEGHC7UW0RPHxJrKLfwXN0G3WGcTzWyOfcO/2e7maoVCDBm08
         +Vpg==
X-Gm-Message-State: AIVw112LyPCLSz5RJDdqXvQc2oRYNMy9YOMvjyXjG0alPP0E5PvDYf7m
        YyMtWyKbtugDqErt/TANELXhI4gEMg==
X-Received: by 10.36.104.140 with SMTP id v134mr9410051itb.11.1501257879583;
 Fri, 28 Jul 2017 09:04:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.155.195 with HTTP; Fri, 28 Jul 2017 09:04:18 -0700 (PDT)
In-Reply-To: <CACBZZX5yv-NzL7H-CH1yMeM9dWkz=PUhx=2wek_jBGpsz1=EAA@mail.gmail.com>
References: <s5hh8y19hyg.wl-tiwai@suse.de> <CACBZZX5yv-NzL7H-CH1yMeM9dWkz=PUhx=2wek_jBGpsz1=EAA@mail.gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Fri, 28 Jul 2017 18:04:18 +0200
Message-ID: <CACBZZX7M=H8tNkZXpHBvv0rbY58EJk4dkoUzGKMftWoKUqF8sA@mail.gmail.com>
Subject: Re: [PATCH] hash: Allow building with the external sha1dc library
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Andreas Stieger <astieger@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 28, 2017 at 5:58 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> On Tue, Jul 25, 2017 at 7:57 AM, Takashi Iwai <tiwai@suse.de> wrote:
>> Some distros provide SHA1 collision detect code as a shared library.
>> It's the very same code as we have in git tree, and git can link with
>> it as well; at least, it may make maintenance easier, according to our
>> security guys.
>>
>> This patch allows user to build git linking with the external sha1dc
>> library instead of the built-in sha1dc code.  User needs to define
>> DC_SHA1_EXTERNAL explicitly.  As default, the built-in sha1dc code is
>> used like before.
>
> This whole thing sounds sensible. I reviewed this (but like Junio
> haven't tested it with a lib) and I think it would be worth noting the
> following in the commit message / Makefile documentation:
>
> * The "sha1detectcoll" *.so name for the "sha1collisiondetection"
> library is not something you or suse presumably) made up, it's a name
> the sha1collisiondetection.git itself creates for its library. I think
> the Makefile docs you've added here are a bit confusing, you talk
> about the "external sha1collisiondetection library" but then link
> against sha1detectcoll". It's worth calling out this difference in the
> docs IMO. I.e. not talk about the sha1detectcoll.so library form of
> sha1collisiondetection, not the sha1collisiondetection project name as
> a library.
>
> * It might be worth noting that this is *not* linking against the same
> code we ship ourselves due to the difference in defining
> SHA1DC_INIT_SAFE_HASH_DEFAULT for the git project's needs in the one
> we build, hence your need to have a git_SHA1DCInit() wrapper whereas
> we call SHA1DCInit() directly. It might be interesting to note that
> the library version will always be *slightly* slower (although the
> difference will be trivial).
>
> * Nothing in your commit message or docs explains why DC_SHA1_LINK is
> needed. We don't have these sorts of variables for other external
> libraries we link to, why the difference?
>
> Some other things I observed:
>
> * We now have much of the same header code copy/pasted between
> sha1dc_git.h and sha1dc_git_ext.h, did you consider just always
> including the former but making what it's doing conditional on
> DC_SHA1_EXTERNAL? I don't know if it would be worth it from a cursory
> glance, but again your commit message doesn't list that among options
> considered & discarded.
>
> * I think it makes sense to spew out a "not both!" error in the
> Makefile if you set DC_SHA1_EXTERNAL=3DY and DC_SHA1_SUBMODULE=3DY. See m=
y
> 94da9193a6 ("grep: add support for PCRE v2", 2017-06-01) for an
> example of how to do this.
>
> * The whole business of "#include <sha1.h>" looks very fragile, are
> there really no other packages in e.g. suse that ship a sha1.h? Debian
> has libmd-dev that ships /usr/include/sha1.h that conflicts with this:
> https://packages.debian.org/search?searchon=3Dcontents&keywords=3Dsha1.h&=
mode=3Dexactfilename&suite=3Dunstable&arch=3Dany
>
> Shipping a sha1.h as opposed to a sha1collisiondetection.h or
> sha1detectcoll.h or whatever seems like a *really* bad decision by
> upstream that should be the subject of at least seeing if they'll take
> a pull request to fix it before you package it or before we include
> something that'll probably need to be fixed / worked around anyway in
> Git.

I sent this last bit a tad too soon in a checkout of sha1collisiondetection=
.git:

    $ make PREFIX=3D/tmp/local install >/dev/null 2>&1 && find /tmp/local/ =
-type f
    /tmp/local/include/sha1dc/sha1.h
    /tmp/local/bin/sha1dcsum
    /tmp/local/bin/sha1dcsum_partialcoll
    /tmp/local/lib/libsha1detectcoll.a
    /tmp/local/lib/libsha1detectcoll.so.1.0.0
    /tmp/local/lib/libsha1detectcoll.la

So the upstream library expects you (and it's documented in their README) t=
o do:

    #include <sha1dc/sha1.h>

But your patch is just doing:

    #include <sha1.h>

At best this seems like a trivial bug and at worst us encoding some
Suse-specific packaging convention in git, since other distros would
presumably want to package this in /usr/include/sha1dc/sha1.h as
upstream suggests. I.e. using the ambiguous sha1.h name is not
something upstream's doing by default, it's something you're doing in
your package.

>> Signed-off-by: Takashi Iwai <tiwai@suse.de>
>> ---
>>  Makefile         | 12 ++++++++++++
>>  hash.h           |  4 +++-
>>  sha1dc_git_ext.c | 11 +++++++++++
>>  sha1dc_git_ext.h | 25 +++++++++++++++++++++++++
>>  4 files changed, 51 insertions(+), 1 deletion(-)
>>  create mode 100644 sha1dc_git_ext.c
>>  create mode 100644 sha1dc_git_ext.h
>>
>> diff --git a/Makefile b/Makefile
>> index 461c845d33cb..f1a262d56254 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -162,6 +162,12 @@ all::
>>  # algorithm. This is slower, but may detect attempted collision attacks=
.
>>  # Takes priority over other *_SHA1 knobs.
>>  #
>> +# Define DC_SHA1_EXTERNAL in addition to DC_SHA1 if you want to build /=
 link
>> +# git with the external sha1collisiondetection library.
>> +# Without this option, i.e. the default behavior is to build git with i=
ts
>> +# own sha1dc code.  If any extra linker option is required, define them=
 in
>> +# DC_SHA1_LINK variable in addition.
>> +#
>>  # Define DC_SHA1_SUBMODULE in addition to DC_SHA1 to use the
>>  # sha1collisiondetection shipped as a submodule instead of the
>>  # non-submodule copy in sha1dc/. This is an experimental option used
>> @@ -1472,6 +1478,11 @@ ifdef APPLE_COMMON_CRYPTO
>>         BASIC_CFLAGS +=3D -DSHA1_APPLE
>>  else
>>         DC_SHA1 :=3D YesPlease
>> +ifdef DC_SHA1_EXTERNAL
>> +       LIB_OBJS +=3D sha1dc_git_ext.o
>> +       BASIC_CFLAGS +=3D -DSHA1_DC -DDC_SHA1_EXTERNAL
>> +       EXTLIBS +=3D $(DC_SHA1_LINK) -lsha1detectcoll
>> +else
>>  ifdef DC_SHA1_SUBMODULE
>>         LIB_OBJS +=3D sha1collisiondetection/lib/sha1.o
>>         LIB_OBJS +=3D sha1collisiondetection/lib/ubc_check.o
>> @@ -1492,6 +1503,7 @@ endif
>>  endif
>>  endif
>>  endif
>> +endif
>>
>>  ifdef SHA1_MAX_BLOCK_SIZE
>>         LIB_OBJS +=3D compat/sha1-chunked.o
>> diff --git a/hash.h b/hash.h
>> index bef3e630a093..dce327d58d07 100644
>> --- a/hash.h
>> +++ b/hash.h
>> @@ -8,7 +8,9 @@
>>  #elif defined(SHA1_OPENSSL)
>>  #include <openssl/sha.h>
>>  #elif defined(SHA1_DC)
>> -#ifdef DC_SHA1_SUBMODULE
>> +#if defined(DC_SHA1_EXTERNAL)
>> +#include "sha1dc_git_ext.h"
>> +#elif defined(DC_SHA1_SUBMODULE)
>>  #include "sha1collisiondetection/lib/sha1.h"
>>  #else
>>  #include "sha1dc/sha1.h"
>> diff --git a/sha1dc_git_ext.c b/sha1dc_git_ext.c
>> new file mode 100644
>> index 000000000000..359439fc3d93
>> --- /dev/null
>> +++ b/sha1dc_git_ext.c
>> @@ -0,0 +1,11 @@
>> +/* Only for DC_SHA1_EXTERNAL; sharing the same hooks as built-in sha1dc=
 */
>> +
>> +#include "cache.h"
>> +#include <sha1.h>
>> +#include "sha1dc_git.c"
>> +
>> +void git_SHA1DCInit(SHA1_CTX *ctx)
>> +{
>> +       SHA1DCInit(ctx);
>> +       SHA1DCSetSafeHash(ctx, 0);
>> +}
>
>
>
>> diff --git a/sha1dc_git_ext.h b/sha1dc_git_ext.h
>> new file mode 100644
>> index 000000000000..d0ea8ce518db
>> --- /dev/null
>> +++ b/sha1dc_git_ext.h
>> @@ -0,0 +1,25 @@
>> +/*
>> + * This file is included by hash.h for DC_SHA1_EXTERNAL
>> + */
>> +
>> +#include <sha1.h>
>> +
>> +/*
>> + * Same as SHA1DCInit, but with default save_hash=3D0
>> + */
>> +void git_SHA1DCInit(SHA1_CTX *);
>> +
>> +/*
>> + * Same as SHA1DCFinal, but convert collision attack case into a verbos=
e die().
>> + */
>> +void git_SHA1DCFinal(unsigned char [20], SHA1_CTX *);
>> +
>> +/*
>> + * Same as SHA1DCUpdate, but adjust types to match git's usual interfac=
e.
>> + */
>> +void git_SHA1DCUpdate(SHA1_CTX *ctx, const void *data, unsigned long le=
n);
>> +
>> +#define platform_SHA_CTX SHA1_CTX
>> +#define platform_SHA1_Init git_SHA1DCInit
>> +#define platform_SHA1_Update git_SHA1DCUpdate
>> +#define platform_SHA1_Final git_SHA1DCFinal
>> --
>> 2.13.3
>>
