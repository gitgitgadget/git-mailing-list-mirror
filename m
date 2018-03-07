Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF4E91FAE2
	for <e@80x24.org>; Wed,  7 Mar 2018 10:49:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751220AbeCGKtc (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Mar 2018 05:49:32 -0500
Received: from mail-ot0-f174.google.com ([74.125.82.174]:38962 "EHLO
        mail-ot0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751171AbeCGKta (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Mar 2018 05:49:30 -0500
Received: by mail-ot0-f174.google.com with SMTP id h8so1626983oti.6
        for <git@vger.kernel.org>; Wed, 07 Mar 2018 02:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=c909Cr7/8bRNiEszY/K2c9+1vXtlOa3pWjmT8pG2KGo=;
        b=NWi8Hii7yKqCTQ6U68c32S8E4clQHnuocPa2TiNR92md74/h4RODKaoYWCOHw9jw4y
         Nj897Nj2kRG8em0sF/mcUS8sBqbHvbNJsqAZOyWrCB8zd9AgE7oxiQjN4MNM/yPF1YXp
         tOkHvxO7qptVD430zyq9DOIPHHRmkKQmFaU04V/SeNsc3rEFaZgZbsLssU10UbiYwvst
         cnZE0q4EJ7VDLFZ6EyYw1RhPAVMkdJJ0js4zF/BmhZRb6xSAy7pQxzCu48gF4aRfMAF/
         9el2JxssveRu7/DNdGPyQQDEyBMNn6jvuGZs2mzbmuuU/YUoskFLnCQOBzQrmNF2FgjZ
         6d+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=c909Cr7/8bRNiEszY/K2c9+1vXtlOa3pWjmT8pG2KGo=;
        b=Fpli2c7/3CbVUIct+MAtbpIEfDsEatCc37YinP1peGhxlu0fM7lZzM7+RG8qCEa7yV
         Bg/jqGFr9VxBibBstyakOLg3x5f2JdXW2Jvq1/Z61/8bvlI3Ha+YYqfaDQ2Ip7tcxO6w
         1BgrrmHmTlkvZazLLs5QyTdv35EcZlUspvjBfVydZWXcx7QWCPqASYjO78aDOC4tRk0O
         G/FHWbZmWAUACXsA9fCGkAArNpJcNR5QunYsV2ZREqAmo9pxJ/CK1EhJKcOAc5rquRcV
         rRb7siiOY1kBBkpOJHFyt994VPOpxsX7RVwspGcbCzAcvn7DVkBDACmFEBwPK9RB5BaT
         LTpg==
X-Gm-Message-State: AElRT7HSDEMz104zVhiuOJO8F5YDFozkXuB66NqGl18D+t9JovURzcc8
        wcSfyigKjXtpB+MbIPS+phk5VNni4ujhmVpRxdw=
X-Google-Smtp-Source: AG47ELujPSfEPA2tEbDhv58am1p2eZxMvFpgujW58zjxRXwoLGm21JmWVj5tHBD76MI9qUijiLEqYI0ZXWmSwv2Mix8=
X-Received: by 10.157.24.42 with SMTP id b39mr16040125ote.356.1520419770208;
 Wed, 07 Mar 2018 02:49:30 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.25.140 with HTTP; Wed, 7 Mar 2018 02:48:59 -0800 (PST)
In-Reply-To: <xmqqfu5d3tbn.fsf@gitster-ct.c.googlers.com>
References: <20180301092046.2769-1-pclouds@gmail.com> <20180306104158.6541-1-pclouds@gmail.com>
 <20180306104158.6541-4-pclouds@gmail.com> <xmqqfu5d3tbn.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 7 Mar 2018 17:48:59 +0700
Message-ID: <CACsJy8C2j2dLozhHf4zE--KYPZ2VjOW2tobmczh3rf6L==Q1vw@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] gc --auto: exclude base pack if not enough mem to
 "repack -ad"
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Wong <e@80x24.org>, Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 7, 2018 at 2:19 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> +--keep-base-pack::
>> +     All packs except the base pack are consolidated into a single
>> +     pack. The largest pack is considered the base pack.
>
> This makes it sound as if packs with .keep are also repacked unless
> they meet the threshold for "base pack".  Is that what you actually
> implemented?

Copy/paste problem. That is, I copied this from --auto description,
but I missed the "(except those marked with a `.keep` file)" part. No,
I don't think ignoring .keep files is a good idea, at least no by
default.

> In order to do so, [2/5] needs to allow the "--keep-pack" option
> override the on-disk .keep files.  In an earlier message, I wondered
> if such an arrangement is useful in some use cases; I think it is,
> and because those who do want to see the on-disk .keep files honored
> can collect and include them in the set of packs to be kept via
> "--keep-pack" (after all this is an option for low-level scripting
> anyway).

At gc level I don't think we need to allow this. But yeah git-repack
has --pack-kept-objects to ignore .keep. If they specify this, then
repack should ignore .keep (but still follow whatever --keep-pack is
specified). There's some interesting interaction between .keep and
pack bitmap feature in pack-objects though. I'm not so sure what
happens down there yet.

>> +Set environment variable `GIT_TRACE` in order to see the memory usage
>> +estimation in `git gc --auto` that determines whether the base pack is
>> +kept.
>
> This is somewhat a puzzling use of trace.  It sounds more like a way
> to find out "how" memory usage estimation is done and arriving at a
> wrong value for those who want to debug the feature.

Yeah. I'm not sure if this estimation could be really problematic that
people need to debug this way. A cleaner way (if we think people will
need this often) is just add a new option in "git gc" to report this
estimation breakdown and do nothing else.

>> +static struct packed_git *find_the_base_pack(void)
>> +{
>> +     struct packed_git *p, *base = NULL;
>> +
>> +     prepare_packed_git();
>> +
>> +     for (p = packed_git; p; p = p->next) {
>> +             if (p->pack_local &&
>> +                 (!base || base->pack_size < p->pack_size))
>> +                     base = p;
>> +     }
>> +
>> +     return base;
>> +}
>
> This is finding the largest pack.

The discussion on .keep files raises one question for me, what if the
largest pack already has a .keep file, do we still consider it the
base pack, or should we find the next largest non-kept pack?

I'm guessing we keep things simple here and ignore .keep files.

>> +#ifdef HAVE_SYSINFO
>> +     struct sysinfo si;
>> +
>> +     if (!sysinfo(&si))
>> +             return si.totalram;
>> +#elif defined(HAVE_BSD_SYSCTL) && defined(HW_MEMSIZE)
>> +     int64_t physical_memory;
>> +     int mib[2];
>> +     size_t length;
>> +
>> +     mib[0] = CTL_HW;
>> +     mib[1] = HW_MEMSIZE;
>> +     length = sizeof(int64_t);
>> +     if (!sysctl(mib, 2, &physical_memory, &length, NULL, 0))
>> +             return physical_memory;
>> +#elif defined(GIT_WINDOWS_NATIVE)
>> +     MEMORYSTATUSEX memInfo;
>> +
>> +     memInfo.dwLength = sizeof(MEMORYSTATUSEX);
>> +     if (GlobalMemoryStatusEx(&memInfo))
>> +             return memInfo;ullTotalPhys;
>
> Is this legal C in Microsoft land?

That's the problem with writing code without a way to test it. At
least travis helped catch a compiler bug on mac.

I'm torn between just #error here and let Windows/Mac guys implement
it (which they may scream "too much work, I don't wanna") but if I
help write something first, yes things are potentially broken and need
verification from those guys. I guess I'll just fix this up and hope
non-linux guys do the rest.

>> +#else
>> +     fprintf(stderr, _("unrecognized platform, assuming %lu GB RAM\n"),
>> +             default_ram);
>> +#endif
>> +     return default_ram * 1024 * 1024 * 1024;
>> +}
>
> I wonder if the above should go somewhere under compat/ without
> ifdef but split into separate files for individual archs (I do not
> know the answer to this question).

My first choice too. I chose this way after seeing online_cpus()
thread-utils.c. Not sure which way is best either.

>> @@ -427,8 +557,19 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
>>                        */
>>                       daemonized = !daemonize();
>>               }
>> -     } else
>> -             add_repack_all_option();
>> +     } else {
>> +             struct packed_git *base_pack = find_the_base_pack();
>> +             struct packed_git *exclude = NULL;
>> +
>> +             if (keep_base_pack != -1) {
>> +                     if (keep_base_pack)
>> +                             exclude = base_pack;
>
> OK, --keep-base-pack option always wins if given...
>
>> +             } else if (base_pack && big_base_pack_threshold &&
>> +                        base_pack->pack_size >= big_base_pack_threshold)
>> +                     exclude = base_pack;
>
> ...and then if the largest one is larger than the threshold, it (and
> it alone) is kept, but otherwise nothing is kept automatically.
>
> But to those who say "packs larger than this value is too big" via
> configuration, keeping only the largest of these above-threshold
> packs would look counter-intuitive, wouldn't it, I wonder?

I think I'll just clarify this in the document. There may be a use
case for keeping multiple large packs, but I don't see it (*). We can
deal with it when it comes.

(*) Well I see one. In submodule setting, we if merge object stores of
all submodules back to the supermodule, we have multiple base packs
and probably want to keep them that way. It's still a long way to get
there (not even sure if submodule people want to get there)

>> diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
>> index 41b0be575d..863fdbb0fd 100755
>> --- a/t/t6500-gc.sh
>> +++ b/t/t6500-gc.sh
>> @@ -5,6 +5,13 @@ test_description='basic git gc tests
>>
>>  . ./test-lib.sh
>>
>> +test_expect_success 'setup' '
>> +     # do not let the amount of physical memory affects gc
>> +     # behavior, make sure the pack_objects_uses_too_much_memory()
>> +     # always returns false
>> +     git config gc.bigBasePackThreshold 2g
>
> Hmph, that is because the configuration wins and we know the trash
> repository will never have a pack that large.  OK.

Credit goes to travis linux32 job. I wouldn't notice this otherwise.

A thought came across me when I wrote this though. Should we support
special value "infinite" (or just "max")- in our config code?

The use of super large gc.bigBasePackThreshold to disable this keeping
base pack is intended. But I can't go too high here it may break
limits on 32 bit platforms. And 2g sounds really arbitrary.
-- 
Duy
