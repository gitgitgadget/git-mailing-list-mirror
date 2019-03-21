Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D477820248
	for <e@80x24.org>; Thu, 21 Mar 2019 14:10:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728339AbfCUOKN (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 10:10:13 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:43917 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727823AbfCUOKN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 10:10:13 -0400
Received: by mail-ed1-f54.google.com with SMTP id d26so1283378ede.10
        for <git@vger.kernel.org>; Thu, 21 Mar 2019 07:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=PoTTFIw4oJJDCe39GnGDU6I0lY3Carqm3TykR9d/NmI=;
        b=MGhbBRj0jq8UNbGY4kbzbbvWeOwr3rBoDTflYvuUkynG1dKLo2Uo7CDSBRhczM3QG4
         CHuZpEnCZDvw/TmWS6uwjg46JmwNN02Ug0OWPCZiIlyewEcTtPhnaQO8HcbjY6dmJOjT
         CItrDxlBI5/Iqx6Jz+8XPxa+X6B3Hf5SyzE72jep7gXCALkgd96sAWa5eQxA7M6oTkEQ
         ZnfRWY1wwOHGP7BT1mYMPWBF96muBmCe7GoVYAFJtdAzx/+usyQbo95nwzxXllE84z5D
         1mPf5V6Gd3bLeLpgTwwCLNt+lHdG/gTuBm4U7GR65V3hT4ZmWIK2BbERt3TVXrOqpc8H
         oOLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=PoTTFIw4oJJDCe39GnGDU6I0lY3Carqm3TykR9d/NmI=;
        b=TN1XG7PmxaNUpPQ0wQnm67JcQ98pvCKAiRxbfbdq8sKiM3bNJkvtC8r2OcHs25xVlP
         lQz8lqhz+5nFAxsOCWUYhP5NoBi/+4T4LXB2QCKfw+mxoqdqbSt+0CXZQdWjIQxQwyoN
         /5h4kfHzXdnHT252Hk6eqcYS8YhCUS7juiM7mp0xnJN5KnFiDCR/sYhmXO8z6cbd7TRH
         K5gqueFhNnTARzUuHP8mZg6lpbJgyUvqfxhgiWvODGdcONKSczxbuSdwVaBmECFp7I+v
         sU0aLwvYUj9EybOb6PdbY408junQJnqmJkzI4LiACs8kAIyeU6uw8ndH5svo8xhQ0Kfh
         M9NQ==
X-Gm-Message-State: APjAAAV6JDEcmWjwCKKRXDEmKdiewq07Y8pmWgZZkT/lz3Vi44G9YXQ/
        kHYtewEZ3ORPYvvMkCXqeoA=
X-Google-Smtp-Source: APXvYqwkaorT4xikEC18td6cb/0rx/9K/w1VDLZJzYmcXL6rA5N49UwKIkud/C/K59N1hSbpAy0uwQ==
X-Received: by 2002:a50:91eb:: with SMTP id h40mr2556116eda.285.1553177410659;
        Thu, 21 Mar 2019 07:10:10 -0700 (PDT)
Received: from evledraar ([5.57.21.49])
        by smtp.gmail.com with ESMTPSA id s3sm1092894ejk.17.2019.03.21.07.10.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Mar 2019 07:10:09 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Jeff King <peff@peff.net>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 8/8] reflog expire: don't assert the OID when locking refs
References: <20190314123439.4347-1-avarab@gmail.com> <20190315155959.12390-9-avarab@gmail.com> <b870a17d-2103-41b8-3cbc-7389d5fff33a@alum.mit.edu>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <b870a17d-2103-41b8-3cbc-7389d5fff33a@alum.mit.edu>
Date:   Thu, 21 Mar 2019 15:10:08 +0100
Message-ID: <87pnqkco8v.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 19 2019, Michael Haggerty wrote:

> Thanks for your work and for your thorough explanation of the change!

Hi. Yes, thanks a lot for the feedback. Just hadn't gotten around to
looping back to this yet & digging into the issue you raised.

> On 3/15/19 4:59 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> During reflog expiry, the cmd_reflog_expire() function first iterates
>> over all reflogs in logs/*, and then one-by-one acquires the lock for
>> each one to expire its reflog by getting a *.lock file on the
>> corresponding loose ref[1] (even if the actual ref is packed).
>>
>> This lock is needed, but what isn't needed is locking the loose ref as
>> a function of the OID we found from that first iteration. By the time
>> we get around to re-visiting the reference some of the OIDs may have
>> changed.
>
> Instead of "what isn't needed is locking the loose ref as a function of
> the OID we found from that first iteration", I suggest "what isn't
> needed is to insist that the reference still has the OID that we found
> in that first iteration".
>
>> Thus the verify_lock() function called by the lock_ref_oid_basic()
>> function being changed here would fail with e.g. "ref '%s' is at %s
>> but expected %s" if the repository was being updated concurrent to the
>> "reflog expire".
>>
>> By not passing the OID to it we'll try to lock the reference
>> regardless of it last known OID. Locking as a function of the OID
>
> s/it/its/
>
>> would make "reflog expire" exit with a non-zero exit status under such
>> contention, which in turn meant that a "gc" command (which expires
>> reflogs before forking to the background) would encounter a hard
>> error.
>
> The last sentence seems mostly redundant with the previous paragraph.
>
>> This behavior of considering the OID when locking has been here ever
>> since "reflog expire" was initially implemented in 4264dc15e1 ("git
>> reflog expire", 2006-12-19). As seen in that simpler initial version
>> of the code we subsequently use the OID to inform the expiry (and
>> still do), but never needed to use it to lock the reference associated
>> with the reflog.
>>
>> By locking the reference without considering what OID we last saw it
>> at, we won't encounter user-visible contention to the extent that
>> core.filesRefLockTimeout mitigates it. See 4ff0f01cb7 ("refs: retry
>> acquiring reference locks for 100ms", 2017-08-21).
>>
>> Unfortunately this sort of probabilistic contention is hard to turn
>> into a test. I've tested this by running the following three subshells
>> in concurrent terminals:
>>
>>     (
>>         cd /tmp &&
>>         rm -rf git &&
>>         git init git &&
>>         cd git &&
>>         while true
>>         do
>>             head -c 10 /dev/urandom | hexdump >out &&
>>             git add out &&
>>             git commit -m"out"
>>         done
>>     )
>>
>>     (
>>         cd /tmp &&
>>         rm -rf git-clone &&
>>         git clone file:///tmp/git git-clone &&
>>         cd git-clone &&
>>         while git pull
>>         do
>>             date
>>         done
>>     )
>>
>>     (
>>         cd /tmp/git-clone &&
>>         while git reflog expire --all
>>         do
>>             date
>>         done
>>     )
>>
>> Before this change the "reflog expire" would fail really quickly with
>> a "but expected" error. After this change both the "pull" and "reflog
>> expire" will run for a while, but eventually fail because I get
>> unlucky with core.filesRefLockTimeout (the "reflog expire" is in a
>> really tight loop). That can be resolved by being more generous with
>> higher values of core.filesRefLockTimeout than the 100ms default.
>>
>> As noted in the commentary being added here we also need to handle the
>> case of references being racily deleted, that can be tested by adding
>> this to the above:
>>
>>     (
>>         cd /tmp/git-clone &&
>>         while git branch topic master && git branch -D topic
>>         do
>>             date
>>         done
>>     )
>>
>> We could change lock_ref_oid_basic() to always pass down
>> RESOLVE_REF_READING to refs_resolve_ref_unsafe() and then
>> files_reflog_expire() to detect the "is it deleted?" state. But let's
>> not bother, in the event of such a race we're going to redundantly
>> create a lock on the deleted reference, and shortly afterwards handle
>> that case and others with the refs_reflog_exists() check.
>>
>> 1. https://public-inbox.org/git/54857871.5090805@alum.mit.edu/
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>  refs/files-backend.c | 15 ++++++++++++++-
>>  1 file changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/refs/files-backend.c b/refs/files-backend.c
>> index ef053f716c3..c7ed1792b3b 100644
>> --- a/refs/files-backend.c
>> +++ b/refs/files-backend.c
>> @@ -3036,8 +3036,14 @@ static int files_reflog_expire(struct ref_store *=
ref_store,
>>  	 * The reflog file is locked by holding the lock on the
>>  	 * reference itself, plus we might need to update the
>>  	 * reference if --updateref was specified:
>> +	 *
>> +	 * We don't pass down the oid here because we'd like to be
>> +	 * tolerant to the OID of the ref having changed, and to
>> +	 * gracefully handle the case where it's been deleted (see oid
>> +	 * -> mustexist -> RESOLVE_REF_READING in
>> +	 * lock_ref_oid_basic()) ...
>>  	 */
>> -	lock =3D lock_ref_oid_basic(refs, refname, oid,
>> +	lock =3D lock_ref_oid_basic(refs, refname, NULL,
>>  				  NULL, NULL, REF_NO_DEREF,
>>  				  &type, &err);
>
> This seems totally reasonable. But then later, where `oid` is passed to
> `(*prepare_fn)()`, I think you must pass `&(lock->old_oid)` instead,
> since we no longer have a guarantee that `oid` reflects the correct
> state of the reference. And after that, there is no need for this
> function to take an `oid` parameter at all (which also makes sense from
> an abstract point of view). Which means that the signatures of
> `refs_reflog_expire()`, `reflog_expire()`, `packed_reflog_expire()`, and
> `reflog_expire_fn` can also be changed, along with callers.
>
> I haven't had time yet to inspect those callers to see whether they
> might actually care that the `oid` that they used to pass to
> `reflog_expire()` isn't necessarily the one that gets passed back to
> their callbacks, but following the trail that I just outlined should
> make it possible to determine that.
>
>>  	if (!lock) {
>> @@ -3045,6 +3051,13 @@ static int files_reflog_expire(struct ref_store *=
ref_store,
>>  		strbuf_release(&err);
>>  		return -1;
>>  	}
>> +	/*
>> +	 * When refs are deleted their reflog is deleted before the
>> +	 * loose ref is deleted. This catches that case, i.e. when
>> +	 * racing against a ref deletion lock_ref_oid_basic() will
>> +	 * have acquired a lock on the now-deleted ref, but here's
>> +	 * where we find out it has no reflog anymore.
>> +	 */
>>  	if (!refs_reflog_exists(ref_store, refname)) {
>>  		unlock_ref(lock);
>>  		return 0;
>>
>
> Cheers,
> Michael
