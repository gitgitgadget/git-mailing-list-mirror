Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DA491F404
	for <e@80x24.org>; Sat,  1 Sep 2018 13:52:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbeIASEh (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Sep 2018 14:04:37 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:38319 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbeIASEh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Sep 2018 14:04:37 -0400
Received: by mail-ed1-f54.google.com with SMTP id h33-v6so10985060edb.5
        for <git@vger.kernel.org>; Sat, 01 Sep 2018 06:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=/qjP6RICR/OyfSieY5lv7zURguklfCS45ZfVJTctX6c=;
        b=WaFT76fvcoR22HHKJoBZvfpnT69xJDEcwqKHhCBlBD5es+vIWRqHpwrGcjNotGS4rX
         VDmoLlesTAQ8QwRD0P6Qwkq4kZLL9SZ1UEYmyakxlwBLZErZAtiZnFeIftOAVgnyJWiH
         BgdeZEH8Rgzee8fAPSE3ZarasPIJmGUR+BwOzFKVDWrhLgG2l+VlwaoDp59kMuzcoBNS
         8iBM6FVEdgSI69jX2FKsMqJIDfdBroU7x6Zt/p1+7VPup7he30EuqID3yOq8iBnwN998
         blyR5BE7S3cZf2iOfqYBK1RdmQI0n2ydRlk5OS2Ky4AuqxGT3t3z5gRy5a5y5oCted0D
         DwJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=/qjP6RICR/OyfSieY5lv7zURguklfCS45ZfVJTctX6c=;
        b=bsfotmLrvSeGBkSHVZhKX/jtHFzTPtUU+bxkPgifSElvT9YA4IpVxwLYpd0XJxxesj
         /ndAk2o2JwXu0FiAGBx/aen8krecLv0gXMWJovCcM0xakCRy+9gokr7Q2/Hxl9VcO+cO
         kHHQXuceBE3RkMMYoEldWuQmrhXHV+D77QtOQy2buNEe7RZsHOaD0Tebtro46IONNuui
         AFSMvTOXz8NpLIQ7I+SCZOJ1+XH0Xj1ee+NIUYLSHgsoi7VnSa1WKwrZQterjyhBKfG9
         VyjpZOMOvYmTmRf/mrqJFxHnTUllZGWRp60XYloq0dCiBxIlVhJReh/8q2JfIlW9lkzl
         CtbA==
X-Gm-Message-State: APzg51BaluVP0cEsPin+ZTKHuYPMYp1HjfX19JFlOJk+/Ll+65+4BD/F
        21jYKuc9hdoIRn7ZEab0Vfg=
X-Google-Smtp-Source: ANB0VdbOW12fwX1UYBqpugJLtajwMI+MNect4F/uNKQOhxfHoDDxfLyi9a8hgWj8CX6tGHc2sWKP6A==
X-Received: by 2002:a50:ac1b:: with SMTP id v27-v6mr23667309edc.260.1535809946307;
        Sat, 01 Sep 2018 06:52:26 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id f13-v6sm8521719edf.50.2018.09.01.06.52.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 01 Sep 2018 06:52:25 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>,
        git@vger.kernel.org
Subject: Re: non-smooth progress  indication for git fsck and git gc
References: <5B751FA1020000A10002CD2F@gwsmtp1.uni-regensburg.de> <20180816155714.GA22739@sigill.intra.peff.net> <87bma2qcba.fsf@evledraar.gmail.com> <87y3clbcqf.fsf@evledraar.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <87y3clbcqf.fsf@evledraar.gmail.com>
Date:   Sat, 01 Sep 2018 15:52:24 +0200
Message-ID: <87wos5ba07.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Sep 01 2018, Ævar Arnfjörð Bjarmason wrote:

> On Thu, Aug 16 2018, Ævar Arnfjörð Bjarmason wrote:
>
>> On Thu, Aug 16 2018, Jeff King wrote:
>>
>>> On Thu, Aug 16, 2018 at 08:54:25AM +0200, Ulrich Windl wrote:
>>>
>>>> I'd like to point out some minor issue observed while processing some
>>>> 50000-object repository with many binary objects, but most are rather
>>>> small:
>>>>
>>>> Between the two phases of "git fsck" (checking directories and
>>>> checking objects) there was a break of several seconds where no
>>>> progress was indicated.
>>>>
>>>> During "git gc" the writing objects phase did not update for some
>>>> seconds, but then the percentage counter jumped like from 15% to 42%.
>>>>
>>>> I understand that updating the progress output too often can be a
>>>> performance bottleneck, while upating it too rarely might only bore
>>>> the user... ;-)
>>>
>>> We update the counter integer for every object we process, and then
>>> actually update the display whenever the percentage increases or a
>>> second has elapsed, whichever comes first.
>>>
>>> What you're seeing is likely an artifact of _what_ we're counting:
>>> written objects. Not all objects are the same size, so it's not uncommon
>>> to see thousands/sec when dealing with small ones, and then several
>>> seconds for one giant blob.
>>>
>>> The only way to solve that is to count bytes. We don't have a total byte
>>> count in most cases, and it wouldn't always make sense (e.g., the
>>> "Compressing objects" meter can show the same issue, but it's not really
>>> putting through bytes in a linear way).  In some cases we do show
>>> transmitted size and throughput, but that's just for network operations.
>>> We could do the same for "gc" with the patch below. But usually
>>> throughput isn't all that interesting for a filesystem write, because
>>> bandwidth isn't the bottleneck.
>>>
>>> Possibly we could have a "half throughput" mode that counts up the total
>>> size written, but omits the speed indicator. That's not an unreasonable
>>> thing to show for a local pack, since you end up with the final pack
>>> size. The object counter would still be jumpy, but you'd at least have
>>> one number updated at least once per second as you put through a large
>>> blob.
>>>
>>> If you really want a smooth percentage, then we'd have to start counting
>>> bytes instead of objects. Two reasons we don't do that are:
>>>
>>>   - we often don't know the total byte size exactly. E.g., for a
>>>     packfile write, it depends on the result of deflating each object.
>>>     You can make an approximation and just pretend at the end that you
>>>     hit 100%.  Or you can count the pre-deflate sizes, but then your
>>>     meter doesn't match the bytes from the throughput counter.
>>>
>>>   - for something like fsck, we're not actually writing out bytes.  So I
>>>     guess you'd be measuring "here's how many bytes of objects I
>>>     fsck-ed". But is that on-disk compressed bytes, or decompressed
>>>     bytes?
>>>
>>>     If the former, that's only marginally better as a measure of effort,
>>>     since delta compression means that a small number of on-disk bytes
>>>     may require a big effort (imagine processing a 100 byte blob versus
>>>     a 100 byte delta off of a 100MB blob).
>>>
>>>     The latter is probably more accurate. But it's also not free to
>>>     pre-generate the total. We can get the number of objects or the size
>>>     of the packfile in constant-time, but totaling up the uncompressed
>>>     size of all objects is O(n). So that's extra computation, but it
>>>     also means a potential lag before we can start the progress meter.
>>>
>>>     I'm also not sure how meaningful a byte count is for a user there.
>>>
>>> So there. That's probably more than you wanted to know about Git's
>>> progress code. I think it probably _could_ be improved by counting
>>> more/different things, but I also think it can be a bit of a rabbit
>>> hole. Which is why AFAIK nobody's really looked too seriously into
>>> changing it.
>>>
>>> -Peff
>>
>> This is all interesting, but I think unrelated to what Ulrich is talking
>> about. Quote:
>>
>>     Between the two phases of "git fsck" (checking directories and
>>     checking objects) there was a break of several seconds where no
>>     progress was indicated
>>
>> I.e. it's not about the pause you get with your testcase (which is
>> certainly another issue) but the break between the two progress bars.
>>
>> Here's a test case you can clone:
>> https://github.com/avar/2015-04-03-1M-git (or might already have
>> "locally" :)
>>
>> If you fsck this repository it'll take around (on my spinning rust
>> server) 30 seconds between 100% of "Checking object directories" before
>> you get any output from "Checking objects".
>>
>> The breakdown of that is (this is from approximate eyeballing):
>>
>>  * We spend 1-3 seconds just on this:
>>    https://github.com/git/git/blob/63749b2dea5d1501ff85bab7b8a7f64911d21dea/pack-check.c#L181
>>
>>  * We spend the majority of the ~30s on this:
>>    https://github.com/git/git/blob/63749b2dea5d1501ff85bab7b8a7f64911d21dea/pack-check.c#L70-L79
>>
>>  * Wes spend another 3-5 seconds on this QSORT:
>>    https://github.com/git/git/blob/63749b2dea5d1501ff85bab7b8a7f64911d21dea/pack-check.c#L105
>>
>> I.e. it's not about objects v.s. bytes, but the structural problem with
>> the code that we pass a progress bar down to verify_pack() which does a
>> lot of work in verify_pack_index() and verify_packfile() before we even
>> get to iterating over the objects in the file, and only then do we start
>> displaying progress.
>
> This patch almost entirely fixes the problem, except for the 1-3 seconds
> we take on the qsort:
>
>     diff --git a/sha1dc/sha1.c b/sha1dc/sha1.c
>     index df0630bc6d..6d6b9b54c4 100644
>     --- a/sha1dc/sha1.c
>     +++ b/sha1dc/sha1.c
>     @@ -25,6 +25,7 @@
>
>      #include "sha1.h"
>      #include "ubc_check.h"
>     +#include "../progress.h"
>
>      #if (defined(__amd64__) || defined(__amd64) || defined(__x86_64__) || defined(__x86_64) || \
>           defined(i386) || defined(__i386) || defined(__i386__) || defined(__i486__)  || \
>     @@ -1820,6 +1821,8 @@ void SHA1DCSetCallback(SHA1_CTX* ctx, collision_block_callback callback)
>      void SHA1DCUpdate(SHA1_CTX* ctx, const char* buf, size_t len)
>      {
>             unsigned left, fill;
>     +       struct progress *progress;
>     +       size_t len_cp = len, done = 0;
>
>             if (len == 0)
>                     return;
>     @@ -1836,6 +1839,8 @@ void SHA1DCUpdate(SHA1_CTX* ctx, const char* buf, size_t len)
>                     len -= fill;
>                     left = 0;
>             }
>     +
>     +       progress = start_delayed_progress(_("Hashing"), len_cp);
>             while (len >= 64)
>             {
>                     ctx->total += 64;
>     @@ -1848,7 +1853,12 @@ void SHA1DCUpdate(SHA1_CTX* ctx, const char* buf, size_t len)
>      #endif /* defined(SHA1DC_ALLOW_UNALIGNED_ACCESS) */
>                     buf += 64;
>                     len -= 64;
>     +               done += 64;
>     +               display_progress(progress, done);
>             }
>     +       display_progress(progress, len_cp);
>     +       stop_progress(&progress);
>     +
>             if (len > 0)
>             {
>                     ctx->total += len;
>
> With this we'll get output like:
>
>     $ ~/g/git/git  -C ~/g/2015-04-03-1M-git/  --exec-path=$PWD fsck
>     Checking object directories: 100% (256/256), done.
>     Hashing: 100% (452634108/452634108), done.
>     Hashing: 100% (1073741824/1073741824), done.
>     Hashing: 100% (1073741824/1073741824), done.
>     Hashing: 100% (1008001572/1008001572), done.
>     Checking objects:   2% (262144/13064614)
>     ^C
>
> All tests pass with this. Isn't it awesome? Except it's of course a
> massive hack, we wouldn't want to just hook into SHA1DC like this.
>
> The problem comes down to us needing to call git_hash_sha1_update() with
> some really huge input, that function is going to take a *long* time,
> and the only way we're getting incremental progress is:
>
>  1) If we ourselves split the input into N chunks
>  2) If we hack into the SHA1 library itself
>
> This patch does #2, but for this to be acceptable we'd need to do
> something like #1.
>
> The least hacky way I can think of doing this is something like the
> following: We'd define two git_hash_algo entries for SHA-1, one that could give you
> progress reports, and that one would only ever hash in chunks of at most
> size N, and would wrap git_SHA1_Update() in something similar to the
> progress code above.
>
> We'd also need to extend the git_hash_algo struct to e.g. have a char *
> we'd use as a description, instead of just "Hashing".
>
> Then the caller here could just switch out the hash algo if
> show_progress was true, temporarily some "int do_progress" and "char
> *progress_description" entries in the struct, and off we go:
>
>     https://github.com/git/git/blob/63749b2dea5d1501ff85bab7b8a7f64911d21dea/pack-check.c#L69-L80
>
> Still a hack, but I can't see another way of making it work without
> compromising all hashing performance with some progress reporting.

Here's a POC version which does #1, the chunk size is 1 byte (just for
simplicity), this one's SHA-1 hash implementation independent:

    diff --git a/hash.h b/hash.h
    index 7c8238bc2e..f0cc96586d 100644
    --- a/hash.h
    +++ b/hash.h
    @@ -52,8 +52,9 @@
     #define GIT_HASH_UNKNOWN 0
     /* SHA-1 */
     #define GIT_HASH_SHA1 1
    +#define GIT_HASH_SHA1_WITH_PROGRESS 2
     /* Number of algorithms supported (including unknown). */
    -#define GIT_HASH_NALGOS (GIT_HASH_SHA1 + 1)
    +#define GIT_HASH_NALGOS (GIT_HASH_SHA1_WITH_PROGRESS + 1)

     /* A suitably aligned type for stack allocations of hash contexts. */
     union git_hash_ctx {
    @@ -95,7 +96,11 @@ struct git_hash_algo {

     	/* The OID of the empty blob. */
     	const struct object_id *empty_blob;
    +
    +	/* Are we showing hashing progress? And if so what are we doing? */
    +	int show_progress;
    +	char *progress_title;
     };
    -extern const struct git_hash_algo hash_algos[GIT_HASH_NALGOS];
    +extern struct git_hash_algo hash_algos[GIT_HASH_NALGOS];

     #endif
    diff --git a/pack-check.c b/pack-check.c
    index d3a57df34f..a96a8f4d10 100644
    --- a/pack-check.c
    +++ b/pack-check.c
    @@ -66,6 +66,9 @@ static int verify_packfile(struct packed_git *p,
     	if (!is_pack_valid(p))
     		return error("packfile %s cannot be accessed", p->pack_name);

    +	repo_set_hash_algo(the_repository, GIT_HASH_SHA1_WITH_PROGRESS);
    +	the_hash_algo->show_progress = 1;
    +	the_hash_algo->progress_title = xstrdup("Hashing");
     	the_hash_algo->init_fn(&ctx);
     	do {
     		unsigned long remaining;
    @@ -78,6 +81,9 @@ static int verify_packfile(struct packed_git *p,
     		the_hash_algo->update_fn(&ctx, in, remaining);
     	} while (offset < pack_sig_ofs);
     	the_hash_algo->final_fn(hash, &ctx);
    +	free(the_hash_algo->progress_title);
    +	repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
    +
     	pack_sig = use_pack(p, w_curs, pack_sig_ofs, NULL);
     	if (hashcmp(hash, pack_sig))
     		err = error("%s pack checksum mismatch",
    diff --git a/repository.h b/repository.h
    index 9f16c42c1e..1d2954773c 100644
    --- a/repository.h
    +++ b/repository.h
    @@ -88,7 +88,7 @@ struct repository {
     	struct index_state *index;

     	/* Repository's current hash algorithm, as serialized on disk. */
    -	const struct git_hash_algo *hash_algo;
    +	struct git_hash_algo *hash_algo;

     	/* Configurations */

    diff --git a/sha1-file.c b/sha1-file.c
    index 97b7423848..9caf1f02e7 100644
    --- a/sha1-file.c
    +++ b/sha1-file.c
    @@ -32,6 +32,7 @@
     #include "packfile.h"
     #include "fetch-object.h"
     #include "object-store.h"
    +#include "progress.h"

     /* The maximum size for an object header. */
     #define MAX_HEADER_LEN 32
    @@ -61,7 +62,33 @@ static void git_hash_sha1_init(git_hash_ctx *ctx)

     static void git_hash_sha1_update(git_hash_ctx *ctx, const void *data, size_t len)
     {
    -	git_SHA1_Update(&ctx->sha1, data, len);
    +	void *chunk;
    +	int i;
    +
    +	for (i = 0; i < len; i++) {
    +		chunk = (void *)data + i;
    +		git_SHA1_Update(&ctx->sha1, chunk, 1);
    +	}
    +}
    +
    +static void git_hash_sha1_update_progress(git_hash_ctx *ctx, const void *data, size_t len)
    +{
    +	struct progress *progress;
    +	void *chunk;
    +	int i;
    +
    +	if (len >= 100000) {
    +		progress = start_delayed_progress(_(the_hash_algo->progress_title), len);
    +		for (i = 0; i < len; i++) {
    +			chunk = (void *)data + i;
    +			git_SHA1_Update(&ctx->sha1, chunk, 1);
    +			display_progress(progress, i);
    +		}
    +		display_progress(progress, i);
    +		stop_progress(&progress);
    +	} else {
    +		git_SHA1_Update(&ctx->sha1, data, len);
    +	}
     }

     static void git_hash_sha1_final(unsigned char *hash, git_hash_ctx *ctx)
    @@ -84,7 +111,7 @@ static void git_hash_unknown_final(unsigned char *hash, git_hash_ctx *ctx)
     	BUG("trying to finalize unknown hash");
     }

    -const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
    +struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
     	{
     		NULL,
     		0x00000000,
    @@ -95,6 +122,8 @@ const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
     		git_hash_unknown_final,
     		NULL,
     		NULL,
    +		0,
    +		NULL,
     	},
     	{
     		"sha-1",
    @@ -107,6 +136,22 @@ const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
     		git_hash_sha1_final,
     		&empty_tree_oid,
     		&empty_blob_oid,
    +		0,
    +		NULL,
    +	},
    +	{
    +		"sha-1",
    +		/* "sha1", big-endian */
    +		0x73686131,
    +		GIT_SHA1_RAWSZ,
    +		GIT_SHA1_HEXSZ,
    +		git_hash_sha1_init,
    +		git_hash_sha1_update_progress,
    +		git_hash_sha1_final,
    +		&empty_tree_oid,
    +		&empty_blob_oid,
    +		0,
    +		NULL,
     	},
     };

Now, setting hash_algos to s/const // is scary, also the whole notion of
needing to store the "do progress" and "title" info there is a bit
nasty.

I don't actually make use of the "show_progress" member, instead I just
hardcode a large input size that we'll start showing this at.

Consider this an RFC. I'd like to submit some patch like this (with
obvious bugs like it should chunk in some sane size fixed). It's nasty,
but very useful. We'll get progress output during fsck where currently
we just hang for 30s on this large repo.
