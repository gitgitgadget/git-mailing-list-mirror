Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEB0F1F453
	for <e@80x24.org>; Sat, 27 Oct 2018 11:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbeJ0UDA (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 16:03:00 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44343 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728413AbeJ0UDA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 16:03:00 -0400
Received: by mail-ed1-f66.google.com with SMTP id z21-v6so3423327edb.11
        for <git@vger.kernel.org>; Sat, 27 Oct 2018 04:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=c9ZgN/XHzTqLTn8zz5M3cRRTVa/mKj/n0snEtSWaeGU=;
        b=cNIkicxYzGAfdWs6Lzz/D5ehRX4hdrC9GsKXZ066Jkz4FpWkz8bspn/V27ifjBe0Ko
         9GpDG4hjwRE6U3AvamGPFcgLA69FfRbegniI8RZ6MT5r9AaWNKM4pYS9W7RC8ALlBoAM
         KJGarLmPKdd+xYyWrnQN8TldWzvSAZ47xZlZpMqIVn8lTIx2xNN0qg6SRN3VaBAocy5z
         QRh7S6xMPBFSEKS15QEaivIxtVlcQTwBsX2V5AhWCqHAzhGEn5z1yy3GP5lvj7+2cCbo
         g+4e8rkbzeAwYBUgc9qiaBPDI7cBu1vpKT758eelJxiok31+l5HHWwSUntzPxZAkEbfq
         rrpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=c9ZgN/XHzTqLTn8zz5M3cRRTVa/mKj/n0snEtSWaeGU=;
        b=Lvfhr+wPFqP8e0tzb9OmrXpNWqEpbspMYnjd/WlbXBfZ+V0xRZZhVt3/4jiB/9zbyW
         AuBc4TZpGdao4J393zgVpTKZHm/4NaMQbiccQckaKYJgbZxxyJnoV1qfPo6vAQKDV0r/
         YZhB1NYrbzQtcjTOiOltdnBNy3330ZoL/NIIFuqOfW2APAe63il9NgSMdLnFWwDHmY+w
         B96kT/M0QLnRaSxV1d0xOVyCmVoT/PYE2m/GKp+MdfFU2jvlHhouLr6jTmzyi2gnq/XE
         qfPl4BYkl/VKMYY3ZFqUmvu66E6yy+LYJXFbNpRDLCLb+kN7tCV2x0bumh/fJO/R+gNT
         QITA==
X-Gm-Message-State: AGRZ1gJQmkmvhu7s7+RILTL/RHygMGKBYRvT+8jLHFGZLUx1TZDLJYeE
        YjQ8Eo+jCtHtEPSlyE5Xu00=
X-Google-Smtp-Source: AJdET5cIBVzU0Fbcs1LDBrj4kCGjRA+l+6CAj/qkwPwDE6hKYi7ZEj9ImXUut+tguWdcrKsFDTLD/g==
X-Received: by 2002:a17:906:1659:: with SMTP id n25-v6mr5195792ejd.24.1540639340080;
        Sat, 27 Oct 2018 04:22:20 -0700 (PDT)
Received: from evledraar (223-81-146-85.ftth.glasoperator.nl. [85.146.81.223])
        by smtp.gmail.com with ESMTPSA id c50-v6sm4483341edc.4.2018.10.27.04.22.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 27 Oct 2018 04:22:18 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Jansen\, Geert" <gerardu@amazon.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH] index-pack: improve performance on NFS
References: <ED25E182-C296-4D08-8170-340567D8964A@amazon.com>
        <xmqqk1m5ftgj.fsf@gitster-ct.c.googlers.com>
        <87o9bgl9yl.fsf@evledraar.gmail.com>
        <xmqq1s8bc0jp.fsf@gitster-ct.c.googlers.com>
        <20181027093300.GA23974@sigill.intra.peff.net>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181027093300.GA23974@sigill.intra.peff.net>
Date:   Sat, 27 Oct 2018 13:22:16 +0200
Message-ID: <87lg6jljmf.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Oct 27 2018, Jeff King wrote:

> On Sat, Oct 27, 2018 at 04:26:50PM +0900, Junio C Hamano wrote:
>
>> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>>
>> > But as Junio notes the devil's in the details, another one I thought of
>> > is:
>> >
>> >     GIT_OBJECT_DIRECTORY=/some/other/repository git clone ...
>> >
>> > It seems to me that ...
>>
>> Actually I take all of that back ;-)
>>
>> For the purpose of this patch, use of existing .cloning field in the
>> transport is fine, as the sole existing user of the field wants the
>> field to mean "Are we starting with an empty object store?", and not
>> "Are we running the command whose name is 'git clone'?".
>
> Taking one step back, the root problem in this thread is that stat() on
> non-existing files is slow (which makes has_sha1_file slow).
>
> One solution there is to cache the results of looking in .git/objects
> (or any alternate object store) for loose files. And indeed, this whole
> scheme is just a specialized form of that: it's a flag to say "hey, we
> do not have any objects yet, so do not bother looking".
>
> Could we implement that in a more direct and central way? And could we
> implement it in a way that catches more cases? E.g., if I have _one_
> object, that defeats this specialized optimization, but it is probably
> still beneficial to cache that knowledge (and the reasonable cutoff is
> probably not 1, but some value of N loose objects).
>
> Of course any cache raises questions of cache invalidation, but I think
> we've already dealt with that for this case. When we use
> OBJECT_INFO_QUICK, that is a sign that we want to make this kind of
> accuracy/speed tradeoff (which does a similar caching thing with
> packfiles).
>
> So putting that all together, could we have something like:
>
> diff --git a/object-store.h b/object-store.h
> index 63b7605a3e..28cde568a0 100644
> --- a/object-store.h
> +++ b/object-store.h
> @@ -135,6 +135,18 @@ struct raw_object_store {
>  	 */
>  	struct packed_git *all_packs;
>
> +	/*
> +	 * A set of all loose objects we have. This probably ought to be split
> +	 * into a set of 256 caches so that we can fault in one directory at a
> +	 * time.
> +	 */
> +	struct oid_array loose_cache;
> +	enum {
> +		LOOSE_CACHE_UNFILLED = 0,
> +		LOOSE_CACHE_INVALID,
> +		LOOSE_CACHE_VALID
> +	} loose_cache_status;
> +
>  	/*
>  	 * A fast, rough count of the number of objects in the repository.
>  	 * These two fields are not meant for direct access. Use
> diff --git a/packfile.c b/packfile.c
> index 86074a76e9..68ca4fff0e 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -990,6 +990,8 @@ void reprepare_packed_git(struct repository *r)
>  	r->objects->approximate_object_count_valid = 0;
>  	r->objects->packed_git_initialized = 0;
>  	prepare_packed_git(r);
> +	oid_array_clear(&r->objects->loose_cache);
> +	r->objects->loose_cache_status = LOOSE_CACHE_UNFILLED;
>  }
>
>  struct packed_git *get_packed_git(struct repository *r)
> diff --git a/sha1-file.c b/sha1-file.c
> index dd0b6aa873..edbe037eaa 100644
> --- a/sha1-file.c
> +++ b/sha1-file.c
> @@ -1172,6 +1172,40 @@ int parse_sha1_header(const char *hdr, unsigned long *sizep)
>  	return parse_sha1_header_extended(hdr, &oi, 0);
>  }
>
> +/* probably should be configurable? */
> +#define LOOSE_OBJECT_CACHE_MAX 65536
> +
> +static int fill_loose_cache(const struct object_id *oid,
> +			    const char *path,
> +			    void *data)
> +{
> +	struct oid_array *cache = data;
> +
> +	if (cache->nr == LOOSE_OBJECT_CACHE_MAX)
> +		return -1;
> +
> +	oid_array_append(data, oid);
> +	return 0;
> +}
> +
> +static int quick_has_loose(struct raw_object_store *r,
> +			   struct object_id *oid)

The assumption with making it exactly 0 objects and not any value of >0
is that we can safely assume that a "clone" or initial "fetch"[1] is
special in ways that a clone isn't. I.e. we're starting out with nothing
and doing the initial population, that's probably not as true in an
existing repo that's getting concurrent fetches, commits, rebases etc.

But in the spirit of taking a step back, maybe we should take two steps
back and consider why we're doing this at all.

Three of our tests fail if we compile git like this, and cloning is much
faster (especially on NFS):

    diff --git a/builtin/index-pack.c b/builtin/index-pack.c
    index 2004e25da2..0c2d008ee0 100644
    --- a/builtin/index-pack.c
    +++ b/builtin/index-pack.c
    @@ -796,3 +796,3 @@ static void sha1_object(const void *data, struct object_entry *obj_entry,

    -       if (startup_info->have_repository) {
    +       if (0) {
                    read_lock();

Even on a local disk I'm doing 262759 lstat() calls cloning git.git and
spending 5% of my time on that.

But why do we have this in the first place? It's because of 8685da4256
("don't ever allow SHA1 collisions to exist by fetching a pack",
2007-03-20) and your 51054177b3 ("index-pack: detect local corruption in
collision check", 2017-04-01).

I.e. we are worried about (and those tests check for):

 a) A malicious user trying to give us repository where they have
    created an object with the same SHA-1 that's different, as in the
    SHAttered attack.

    I remember (but have not dug up) an old E-Mail from Linus saying
    that this was an important security aspect of git, i.e. even if
    SHA-1 was broken you couldn't easily propagate bad objects.

 b) Cases where we've ended up with different content for a SHA-1 due to
    e.g. a local FS corruption. Which is the subject of your commit in
    2017.

 c) Are there cases where fetch.fsckObjects is off and we just flip a
    bit on the wire and don't notice? I think not because we always
    check the pack checksum (don't we), but I'm not 100% sure.

I'm inclined to think that we should at the very least make this
configurable. Running into a) is the least of my worries when operating
some git server on NFS.

The b) case is also a concern, but in that case we'd actually be
improving things by writing out the duplicate object, if that was
followed-up with something like the "null" negotiator[2] and gc/repack
being able to look at the two objects, check their SHA-1/content and
throw away the bad one we'd have the ability to heal a corrupt
repository where we now just produce a hard error.

Even if someone wants to make the argument that this is behavior that we
absolutely *MUST* keep and not make configurable, there's still much
smarter ways to do it.

We could e.g. just unconditionally write out the packfile into a
quarantine environment (see 720dae5a19 ("config doc: elaborate on
fetch.fsckObjects security", 2018-07-27)), *then* loop over the loose
objects and packs we have and see if any of those exist in the new pack,
if they do, do the current assertion, and if not (and fetch.fsckObjects
passes) move it out of the quarantine.

I'm most inclined to say we should just have a config option to disable
this in lieu of fancier solutions. I think a) is entirely implausible
(and I'm not worrying about state-level actors attacking my git repos),
and b) would be no worse than it is today.

1. Although less so for initial fetch, think a) setup bunch of remotes b)
   parallel 'git fetch {}' ::: $(git remote)

2. https://public-inbox.org/git/87o9ciisg6.fsf@evledraar.gmail.com/
