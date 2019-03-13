Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4180320248
	for <e@80x24.org>; Wed, 13 Mar 2019 10:28:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725926AbfCMK2o (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 06:28:44 -0400
Received: from mail-ed1-f45.google.com ([209.85.208.45]:47008 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbfCMK2o (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 06:28:44 -0400
Received: by mail-ed1-f45.google.com with SMTP id n17so991648edt.13
        for <git@vger.kernel.org>; Wed, 13 Mar 2019 03:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=B2bn32e9hhhF+A6oc5tiOpHq0phfpJ4AwNELyPoJT98=;
        b=KejT4+C5N+6Cnt18uGy3/WaRKG0Tk146iJnf55Hwm8jXiAUDsPLGhJZsw1+Q16AAJI
         +F9m6WRlXGldLYaCtHjhBJGi1s3WIiekA2tcPsa5kQ/GeytfMpSGH0E4rK+kT+Hfk3v6
         03w+2RBuOWIWgZ/629tQ3phGXdtx9hwW4E5aK8ZEjQYNOt0gMFBoob1NXDQXoRaqVrdK
         n003vR2jcspSY3+Pj1Mx9eIFW4/kGu9OD1yV5l1WvHWxmFkgzbkHRpKsf6v2pPZbegs2
         /oATpWQ4TWNPCgqAnL3+q8/xZ3r7c1BGJ09rX8OBs/V5fEulzvqQJTh7Wsdy4dTe1QCQ
         lMzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=B2bn32e9hhhF+A6oc5tiOpHq0phfpJ4AwNELyPoJT98=;
        b=bpV84S7E2a60HlrfAMPQ7s6RQsebm7GJxxgIbrcdEhOjbWNpt2tZAZ6vURstC8gLZ7
         +5nrTa9cFK2NtueqhKj5VMcOnBn7lH0nX4G0YVLv0fSVo1lmJm68js9B8OZ+yFpZM9VT
         eIunZm7mhUex2A4EU6+oXu/XLTUSlXoNsos8B+sIPDJ//KwFSSD/ydjEaegGVoCbmIr/
         18Ky46fErzs9hKcwyi2IK7gacqoEf2+RZiQfx/1wJFN0nHIB5LJsCM72BAksDrZenXo7
         l1ENGIKpywbzrNeErA5ZjUvQtgC5p22TQcVx0J4UNajHo9KxoJtObfFlYGQ5SGbe01uE
         acoA==
X-Gm-Message-State: APjAAAUxo/40v96gyd/f/fswH0amUHOyesPNnGN9W6GHy72hAsvi3vei
        nld8y1QlXhLeIozB7Ub4S/w=
X-Google-Smtp-Source: APXvYqwItoeOu25CjqQTsJ4e2oHlFtJHR/FMOZDFgCGq6IYafc0bgqMo4RIHVjpQLXKmwy1O6n11hQ==
X-Received: by 2002:a50:858a:: with SMTP id a10mr7426058edh.1.1552472921853;
        Wed, 13 Mar 2019 03:28:41 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id y21sm468041edb.54.2019.03.13.03.28.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Mar 2019 03:28:40 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <stefanbeller@gmail.com>,
        "Jeff King" <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: BUG: Race condition due to reflog expiry in "gc"
References: <87tvg7brlm.fsf@evledraar.gmail.com> <xmqq1s3bh7ky.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <xmqq1s3bh7ky.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 13 Mar 2019 11:28:39 +0100
Message-ID: <87sgvrax0o.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 13 2019, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> I'm still working on fixing a race condition I encountered in "gc"
>> recently, but am not 100% sure of the fix. So I thought I'd send a
>> braindump of what I have so far in case it jolts any memories.
>>
>> The problem is that when we "gc" we run "reflog expire --all". This
>> iterates over the reflogs, and takes a *.lock for each reference.
>>
>> It'll fail intermittendly in two ways:
>>
>>  1. If something is concurrently committing to the repo it'll fail
>>     because we for a tiny amount of time hold a HEAD.lock file, so HEAD
>>     can't be updated.
>>
>>  2. On a repository that's just being "git fetch"'d by some concurrent
>>     process the "gc" will fail, because the ref's SHA1 has changed,
>>     which we inspect as we aquire the lock.
>
> Both sounds very much expected and expectable outcome.  I am not
> sure how they need to be called bugs.

Let's leave aside that I started the subject with "BUG:" and let me
rephrase.

I was under the impression that git-gc was supposed to support operating
on a repository that's concurrently being modified, as long as you don't
set the likes of gc.pruneExpire too aggressively.

Running a "gc" in a loop without "git reflog expire --all" and when
watching the repository being GC'd with:

    fswatch -l 0.1 -t -r . 2>&1 | grep lock

We only create .git/MERGE_RR.lock, .git/gc.pid.lock and
git/packed-refs.lock. These are all things that would only cause another
concurrent GC to fail, not a normal git command.

So the only reason a concurrent commit (case #1) fails is because of the
refs being locked during the reflog iteration, and similarly "gc" itself
will fail due to a concurrently updating ref (case #2).

It seems that first of all we need this, I'll submit that as a separate
patch sometime soon:

    diff --git a/builtin/gc.c b/builtin/gc.c
    index 020f725acc..ae488646e1 100644
    --- a/builtin/gc.c
    +++ b/builtin/gc.c
    @@ -127,6 +127,12 @@ static void gc_config(void)
     			pack_refs =3D git_config_bool("gc.packrefs", value);
     	}

    +	if (!git_config_get_value("gc.reflogexpire", &value) && value &&
    +	    !strcmp(value, "never") &&
    +	    !git_config_get_value("gc.reflogexpireunreachable", &value) && va=
lue &&
    +	    !strcmp(value, "never"))
    +		prune_reflogs =3D 0;
    +
     	git_config_get_int("gc.aggressivewindow", &aggressive_window);
     	git_config_get_int("gc.aggressivedepth", &aggressive_depth);
     	git_config_get_int("gc.auto", &gc_auto_threshold);

I.e. now even if your gc.* config says you don't want the reflogs
touched, we still pointlessly iterate over all of them. The case I'm
running into (a variant of #2) is one solved by that patch, i.e. I'm
fine "gc" just having the reflogs kept forever as a workaround in this
case.

Something like that should have been added back in 62aad1849f ("gc
--auto: do not lock refs in the background", 2014-05-25), i.e. now the
"prune_reflogs" variable is never used, it's just cargo-culted from a
copy/pasting of the "pack_refs" code.

In other "gc" phases in "pack-objects" and "prune" we also look at the
reflogs. This obviously bad patch ignores them entirely:

    diff --git a/builtin/prune.c b/builtin/prune.c
    index 97613eccb5..bccee7813e 100644
    --- a/builtin/prune.c
    +++ b/builtin/prune.c
    @@ -41,7 +41,7 @@ static void perform_reachability_traversal(struct rev=
_info *revs)

     	if (show_progress)
     		progress =3D start_delayed_progress(_("Checking connectivity"), 0);
    -	mark_reachable_objects(revs, 1, expire, progress);
    +	mark_reachable_objects(revs, 0, expire, progress);
     	stop_progress(&progress);
     	initialized =3D 1;
     }
    diff --git a/builtin/repack.c b/builtin/repack.c
    index 67f8978043..618ffbfe0a 100644
    --- a/builtin/repack.c
    +++ b/builtin/repack.c
    @@ -364,7 +364,6 @@ int cmd_repack(int argc, const char **argv, const c=
har *prefix)
     				 keep_pack_list.items[i].string);
     	argv_array_push(&cmd.args, "--non-empty");
     	argv_array_push(&cmd.args, "--all");
    -	argv_array_push(&cmd.args, "--reflog");
     	argv_array_push(&cmd.args, "--indexed-objects");
     	if (repository_format_partial_clone)
     		argv_array_push(&cmd.args, "--exclude-promisor-objects");

I'm just including that as illustration that add_reflogs_to_pending() in
revision.c during "gc" already iterates over the reflogs without locking
anything, but of course it's just reading them.

So one thing that would mitigate things a lot is if
files_reflog_expire() and its call to expire_reflog_ent() via
refs_for_each_reflog_ent() would lazily aquire the lock on the ref.

Digging a bit further that's actually what we're doing now since
4ff0f01cb7 ("refs: retry acquiring reference locks for 100ms",
2017-08-21).

But this runs into the logic we've had for a long time, or since your
bda3a31cc7 ("reflog-expire: Avoid creating new files in a directory
inside readdir(3) loop", 2008-01-25) where we first loop over all the
refs in the process of finding the reflogs, and then will try to lock
those refs at those expected SHA-1s. If they've changed in the meantime
we error out don't clean up the lockfile.

So just this fixes that:

    diff --git a/refs/files-backend.c b/refs/files-backend.c
    index ef053f716c..b6576f28b9 100644
    --- a/refs/files-backend.c
    +++ b/refs/files-backend.c
    @@ -3037,7 +3037,7 @@ static int files_reflog_expire(struct ref_store *=
ref_store,
     	 * reference itself, plus we might need to update the
     	 * reference if --updateref was specified:
     	 */
    -	lock =3D lock_ref_oid_basic(refs, refname, oid,
    +	lock =3D lock_ref_oid_basic(refs, refname, NULL,
     				  NULL, NULL, REF_NO_DEREF,
     				  &type, &err);
     	if (!lock) {

Which seems sensible to me. We'll still get the lock, we just don't
assert that the refname we use to get the lock must be at that
SHA-1. We'll still use it for the purposes of expiry.

But maybe I've missed some caveat in reflog_expiry_prepare() and friends
and we really do need the reflog at that OID, then this would suck less:

    diff --git a/builtin/reflog.c b/builtin/reflog.c
    index 4d3430900d..4bb272fdc8 100644
    --- a/builtin/reflog.c
    +++ b/builtin/reflog.c
    @@ -625,12 +625,16 @@ static int cmd_reflog_expire(int argc, const char=
 **argv, const char *prefix)
     		free_worktrees(worktrees);
     		for (i =3D 0; i < collected.nr; i++) {
     			struct collected_reflog *e =3D collected.e[i];
    +			int st;
     			set_reflog_expiry_param(&cb.cmd, explicit_expiry, e->reflog);
    -			status |=3D reflog_expire(e->reflog, &e->oid, flags,
    -						reflog_expiry_prepare,
    -						should_expire_reflog_ent,
    -						reflog_expiry_cleanup,
    -						&cb);
    +			st =3D reflog_expire(e->reflog, &e->oid, flags,
    +					   reflog_expiry_prepare,
    +					   should_expire_reflog_ent,
    +					   reflog_expiry_cleanup,
    +					   &cb);
    +			if (st =3D=3D -2)
    +				continue;
    +			status |=3D st;
     			free(e);
     		}
     		free(collected.e);
    diff --git a/refs/files-backend.c b/refs/files-backend.c
    index ef053f716c..8b0b6b7b85 100644
    --- a/refs/files-backend.c
    +++ b/refs/files-backend.c
    @@ -3041,6 +3041,11 @@ static int files_reflog_expire(struct ref_store =
*ref_store,
     				  NULL, NULL, REF_NO_DEREF,
     				  &type, &err);
     	if (!lock) {
    +		if (errno =3D=3D EBUSY) {
    +			warning("cannot lock ref '%s': %s. Skipping!", refname, err.buf);
    +			strbuf_release(&err);
    +			return -2;
    +		}
     		error("cannot lock ref '%s': %s", refname, err.buf);
     		strbuf_release(&err);
     		return -1;

I.e. we just detect the EBUSY that verify_lock() sets if the OID doesn't
match, and don't prune that reflog. As seen above "pack-objects" and
"prune" will still iterate over the same logs later for the purposes of
reachability, so this shouldn't get us into a corrupt state due to
throwing away objects referenced in those logs, we'll just prune fewer
things than we could have.

So I think I'll use the first patch noted above as a hack to solve the
narrow problem I have now, but any comments on the above most
welcome. I'm not very familiar with the ref code in case that wasn't
obvious already.

B.t.w. the mention of f3b661f766 ("expire_reflog(): use a lock_file for
rewriting the reflog file", 2014-12-12) upthread is irrelevant. That's a
commit where we use the lockfile code to write out the *new* reflog,
which is unrelated to all of this.
