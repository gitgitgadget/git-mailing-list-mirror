Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 704B01F404
	for <e@80x24.org>; Mon, 27 Aug 2018 15:23:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbeH0TKV (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Aug 2018 15:10:21 -0400
Received: from mout.web.de ([212.227.15.3]:45267 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726946AbeH0TKV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Aug 2018 15:10:21 -0400
Received: from [192.168.178.36] ([91.20.53.4]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lnmpz-1fRYm62YH9-00hzCK; Mon, 27
 Aug 2018 17:23:05 +0200
Subject: Re: [PATCH v2 2/2] fsck: use oidset for skiplist
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <c1ea6be5-57f7-68f1-0215-b4dceb07603a@web.de>
 <ae61a845-16fa-e2d6-935d-ce5eb1e33e5a@web.de>
 <87r2ikdzvc.fsf@evledraar.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <c7cbc289-d86e-09dc-bdb3-b5496cf0b7ce@web.de>
Date:   Mon, 27 Aug 2018 17:23:01 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <87r2ikdzvc.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:mB91CH1JdQvq5lAD/XIBp3QGTzF0fK+d/aIQuBFor7JwY7v30TK
 SWgC6m4QwGIiDd7aNXGbchegBYNahyK68ydpwVDa/VmivlJplNVFEbGArkNY61Cnk1NSdiG
 3SlkhhLopKQ7AN7ZrG+2bw8fbaQ+/Arlg5pmzTkI9+frdAZldcTn99RFoTzCfn+TETsERiH
 HgdXUJXcGzFcZ0IChgJPw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:y5FiL4CCddM=:xFCsTbfRoZ/SdtInqKzAMF
 nWo0jD6V7TEd4YwdXK5uVu5yQ5husT+ggois0vTUkzC3Lg33D2WeogwtDmWw4M485Rkl4QGzz
 EpIk5hkvrxteb2MQrnyGkV4UGSwZ36D9Rxf+jKfriONJgXXA6LpIocuFG3KKvEIw8GjWmKwEX
 pw7qcR+EJ81lDEAs5L3mBiX55uGXbPetM86wHWGC/ji5gsxt/2Cc5KH0QCgC9S8Z8b9HkLJqd
 ELg1z4K1QGJgUvec6I5vj8J0KbtZscYDxbAq6pwkB8dpYmwBOclExc35EENsmvqhzP6yfFomM
 pnSfvVybPcvZVk4kUdxT5f/n26bYUGArGU673Eb9gINjzNHUZiV2icXEncQIHIOgjTP6GCkoW
 MtW/0Aqljwn2GIjpd8kmbvBMMZmjQsgxnUC3ml0/tibvnOW9M4PaSheVA6w6utKC81YXnnznE
 hYdbDRRg3ryiFUpvDwIACNo9Em5NLrE3M4DEfg4+ptAMiY3coeZEAgV3Opl0lW3fvVE6tKqv9
 vDQBjDIb4ptmx7cpeOE5x/M5wSMy60H8uUU54Jay1xGK2R65kfZCetUZj40E6tYFxGPkzCSVY
 t0iqS8pxHdJeSZZo4E3ORFi8iOZBuehHsvEWA/2XAjEZCyb4wE469fp8zIN+gnbtNMsF8OF1n
 RKeYf/5RFTyRNf0S1BiniE0TRo/RiHwiz1zvTD72ea8DXi4lVKdRI7PA8ZpdD1HKRARV7ofSA
 mQzmoIcKLK5XFJ8c6HSSnIXMQ8KmQGkY5mvdXCFXqQ6Vrs+1E1/0Tzh3NL84rX2u4ry0hnKyi
 5UURO98
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 27.08.2018 um 09:37 schrieb Ævar Arnfjörð Bjarmason:
> 
> On Sat, Aug 25 2018, René Scharfe wrote:
> 
>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>> index 2fa65b7516..80ab570579 100644
>> --- a/Documentation/config.txt
>> +++ b/Documentation/config.txt
>> @@ -1715,7 +1715,7 @@ doing the same for `receive.fsck.<msg-id>` and `fetch.fsck.<msg-id>`
>>  will only cause git to warn.
>>
>>  fsck.skipList::
>> -	The path to a sorted list of object names (i.e. one SHA-1 per
>> +	The path to a list of object names (i.e. one SHA-1 per
>>  	line) that are known to be broken in a non-fatal way and should
>>  	be ignored. This feature is useful when an established project
>>  	should be accepted despite early commits containing errors that
> 
> I was going to say that since this is a file format we're likely to
> support across versions we should make a note that "up to version
> so-and-so this needed to be sorted, but that's longer the case. So
> e.g. someone wouldn't test this on 2.20 (or read the online docs) and
> then deploy this for older clients..
> 
> But...
> 
>> -	if (options->skiplist)
>> -		sorted = options->skiplist->sorted;
>> -	else {
>> -		sorted = 1;
>> -		options->skiplist = &skiplist;
>> -	}
>> -
>>  	fp = fopen(path, "r");
>>  	if (!fp)
>>  		die("Could not open skip list: %s", path);
>> @@ -202,19 +192,12 @@ static void init_skiplist(struct fsck_options *options, const char *path)
>>  		const char *p;
>>  		if (parse_oid_hex(sb.buf, &oid, &p) || *p != '\0')
>>  			die("Invalid SHA-1: %s", sb.buf);
>> -		oid_array_append(&skiplist, &oid);
>> -		if (sorted && skiplist.nr > 1 &&
>> -				oidcmp(&skiplist.oid[skiplist.nr - 2],
>> -				       &oid) > 0)
>> -			sorted = 0;
>> +		oidset_insert(&options->skiplist, &oid);
> 
> ...reading this implementation, where we always called
> oid_array_append(), but then just kept track of whether the set was
> sorted...
> 
>>  	}
>>  	if (ferror(fp))
>>  		die_errno("Could not read '%s'", path);
>>  	fclose(fp);
>>  	strbuf_release(&sb);
>> -
>> -	if (sorted)
>> -		skiplist.sorted = 1;
> 
> ...and here where we assigned to the .sorted member of the oid_array...
> 
>>  static int object_on_skiplist(struct fsck_options *opts, struct object *obj)
>>  {
>> -	if (opts && opts->skiplist && obj)
>> -		return oid_array_lookup(opts->skiplist, &obj->oid) >= 0;
>> -	return 0;
>> +	return opts && obj && oidset_contains(&opts->skiplist, &obj->oid);
>>  }
> 
> ....and here where we'd always do the lookup if the skiplist was
> initialized, *not* just if it's sorted, and how the sha1-array.c code
> has looked ever since cd94c6f91 ("fsck: git receive-pack: support
> excluding objects from fsck'ing", 2015-06-22) when this was first added:
> 
>     $ git show cd94c6f91:sha1-array.c|grep -A5 sha1_array_lookup
>     int sha1_array_lookup(struct sha1_array *array, const unsigned char *sha1)
>     {
>             if (!array->sorted)
>                     sha1_array_sort(array);
>             return sha1_pos(sha1, array->sha1, array->nr, sha1_access);
>     }
> 
> So I think it makes sense to make this series a three-part, where in the
> first part we only change these docs to say s/sorted //, and modify the
> tests I added in 65a836fa6b ("fsck: add stress tests for fsck.skipList",
> 2018-07-27) to assert that an unsorted & sorted list of SHA-1s works
> just as well.
> 
> Then following up with your [12]/2, where the internal implementation is
> changed, but we make it clear that it's *just* the internal
> implementation. I.e. from a UI perspective the list never had to be
> pre-sorted, we'd just spend some work sorting it on the first lookup if
> it wasn't sorted already.
> 
> Now without some very careful reading it's not clear what "we don't need
> to worry about any sort order anymore" in the commit message means,
> i.e. what it really means is "for the purposes of the internal
> implementation, and as an opt-in user-side optimization ...".
> 
> I.e. an alternate version of this whole patch series could also be:
> 
>     diff --git a/Documentation/config.txt b/Documentation/config.txt
>     index 1c4236498..930807e43 100644
>     --- a/Documentation/config.txt
>     +++ b/Documentation/config.txt
>     @@ -1709,5 +1709,5 @@ will only cause git to warn.
> 
>      fsck.skipList::
>     -       The path to a sorted list of object names (i.e. one SHA-1 per
>     +       The path to a list of object names (i.e. one SHA-1 per
>             line) that are known to be broken in a non-fatal way and should
>             be ignored. This feature is useful when an established project
>     diff --git a/fsck.c b/fsck.c
>     index a0cee0be5..9d4e938ad 100644
>     --- a/fsck.c
>     +++ b/fsck.c
>     @@ -184,14 +184,10 @@ static void init_skiplist(struct fsck_options *options, const char *path)
>      {
>             static struct oid_array skiplist = OID_ARRAY_INIT;
>     -       int sorted, fd;
>     +       int fd;
>             char buffer[GIT_MAX_HEXSZ + 1];
>             struct object_id oid;
> 
>     -       if (options->skiplist)
>     -               sorted = options->skiplist->sorted;
>     -       else {
>     -               sorted = 1;
>     +       if (!options->skiplist)
>                     options->skiplist = &skiplist;
>     -       }
> 
>             fd = open(path, O_RDONLY);
>     @@ -208,13 +204,6 @@ static void init_skiplist(struct fsck_options *options, const char *path)
>                             die("Invalid SHA-1: %s", buffer);
>                     oid_array_append(&skiplist, &oid);
>     -               if (sorted && skiplist.nr > 1 &&
>     -                               oidcmp(&skiplist.oid[skiplist.nr - 2],
>     -                                      &oid) > 0)
>     -                       sorted = 0;
>             }
>             close(fd);
>     -
>     -       if (sorted)
>     -               skiplist.sorted = 1;
>      }
> 
> Now, I like yours much better. I'm just saying that currently the
> patch/commit message combo is confusing about *what* it's
> doing. I.e. let's not mix up the correction of docs that were always
> wrong with a non-change in the user facing implementation, and some
> internal optimization all in one patch.

Now you have me confused.  Unsorted lists were always accepted, but the
documentation asked for a sorted one anyway, probably to avoid sorting
it with every use.  Switching the underlying data structure makes that a
moot point -- sortedness is no longer a concern at all -- not in the
code, and not for users.

Inviting users to run the array implementation with unsorted lists is
not incorrect, but it also doesn't help anyone.  We could clarify that
sorted lists are preferred or recommended instead of required.  I don't
see value in perfecting the documentation of a quirk just before
removing it, though.

René
