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
	by dcvr.yhbt.net (Postfix) with ESMTP id CF60F20248
	for <e@80x24.org>; Wed, 13 Mar 2019 16:22:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfCMQW3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 12:22:29 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46389 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbfCMQW3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 12:22:29 -0400
Received: by mail-ed1-f68.google.com with SMTP id n17so2038763edt.13
        for <git@vger.kernel.org>; Wed, 13 Mar 2019 09:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=+Q7o9/Oh3os7kpn84caBExAQu5HHMf2CxrWf31k0Q/A=;
        b=pT3KOViKvBrIyhwLeC+tHlFmxd9VnUWrcorX2Jo8azIoYWk2YAQoFPb1IMy4EXmCph
         P+EvUBVh2y9sjZo2oq6RFrvo+YjOZ19gtiRCIWi9IJEd77d/N5No0eyoFqJRT7yoA7JT
         1AQ/zx9ZdgrqMu5QTc8+CRDlJ5ViF15Hltg4/CeK5Vk+hNvEp82yo/roa5hmopcwVuDQ
         uDjONi3y5hmS5M/NBN01swH5qYVyxJJMoiVECDSwS2WJ7MYUGXFwHW2kxhpUAxgluIgu
         zWtampK/Di/2jh5FCTwv5afgdKI0BN8u9uHERKWaYmL7a7esTL5Un3DpmS6K73hTntyI
         t9WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=+Q7o9/Oh3os7kpn84caBExAQu5HHMf2CxrWf31k0Q/A=;
        b=p9pnTysmqR5vOh1+0ynU1JzWaVrlhltJydv6TY/nmdWDKQOcbJMUNf3KnE5FRXr4JU
         Zt10DGN/xv71WVmrUktc5Mw8Sdr8qBy7xTtOVVyV5dq6N3xyZZKzLoxMX80WE+JVEa3g
         vwCYQO9kY69cyuTY2fYIjNbDh/5FRgCiWbqxy9AcVs42MCau+I0WjUV3ZOT4AC1KEx9C
         eVVCvHK/Qmn5ZoFB2oR4NGB5hRLSja9ifOfyUvnyBcH8znXV6XmS+T8u2W+E31k8Iamr
         1CsEiutSgWDLfgqJ3G8ZSnzGxYwjigiIfw/mOci+V/riOBDwWU77vKynUdnE3xfz/w4m
         f9SQ==
X-Gm-Message-State: APjAAAXKa46FTVtDW4wOfCXJOfJK5NGuduPt4XJmhvybF+UnjDVK/XVG
        cBtvMkayJJrz0kxzWbew6sw=
X-Google-Smtp-Source: APXvYqwUydeJ+qHHFwa6OfGxhrT5jB7MtB8OQngvgrHCPXXl8uwSjFaonsLd4QDHtot83h5JAkHIeQ==
X-Received: by 2002:a50:aa83:: with SMTP id q3mr8285353edc.63.1552494146517;
        Wed, 13 Mar 2019 09:22:26 -0700 (PDT)
Received: from evledraar ([5.57.21.49])
        by smtp.gmail.com with ESMTPSA id x22sm538193eje.48.2019.03.13.09.22.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Mar 2019 09:22:25 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: BUG: Race condition due to reflog expiry in "gc"
References: <87tvg7brlm.fsf@evledraar.gmail.com> <xmqq1s3bh7ky.fsf@gitster-ct.c.googlers.com> <87sgvrax0o.fsf@evledraar.gmail.com> <20190313160204.GD24101@sigill.intra.peff.net>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190313160204.GD24101@sigill.intra.peff.net>
Date:   Wed, 13 Mar 2019 17:22:22 +0100
Message-ID: <87imwmbv7l.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 13 2019, Jeff King wrote:

> On Wed, Mar 13, 2019 at 11:28:39AM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> I was under the impression that git-gc was supposed to support operating
>> on a repository that's concurrently being modified, as long as you don't
>> set the likes of gc.pruneExpire too aggressively.
>
> To some degree. If it has to take locks to modify items, then inherently
> there's going to be lock contention. But we may be able to work around
> it some.
>
> A big one we used to hit at GitHub is that running `git pack-refs` needs
> to take the individual ref locks when pruning loose refs that have just
> been packed. We dealt with that by adding retry-with-timeout logic to
> ref lock acquisition, in 4ff0f01cb7 (refs: retry acquiring reference
> locks for 100ms, 2017-08-21). Since then, I can't remember seeing a
> single instance of this coming up in production use.
>
> I don't think we use a timeout with the reflog lock. Maybe we ought to.
> It might need to be longer than the 100ms default for refs, since I
> think we'd do more significant work during the reflog expiration. On the
> other hand, I think we hold the lock on the ref itself, too, during that
> expiration.
>
> We don't actually expire reflogs regularly at GitHub, so I can't say one
> way or the other if there would be lock contention there.
>
>> Running a "gc" in a loop without "git reflog expire --all" and when
>> watching the repository being GC'd with:
>>
>>     fswatch -l 0.1 -t -r . 2>&1 | grep lock
>>
>> We only create .git/MERGE_RR.lock, .git/gc.pid.lock and
>> git/packed-refs.lock. These are all things that would only cause another
>> concurrent GC to fail, not a normal git command.
>
> The packed-refs.lock can conflict with a normal operation; regular
> writers need to update it when they delete a ref.
>
> You'd also be locking regular refs as part of "pack-refs --prune", but
> you probably don't see it running gc in a loop, because all of the loose
> refs are pruned after the first run.
>
>> I'm just including that as illustration that add_reflogs_to_pending() in
>> revision.c during "gc" already iterates over the reflogs without locking
>> anything, but of course it's just reading them.
>
> Right. It's always safe to read without locking (refs, packed-refs, and
> reflogs).
>
>> So just this fixes that:
>>
>>     diff --git a/refs/files-backend.c b/refs/files-backend.c
>>     index ef053f716c..b6576f28b9 100644
>>     --- a/refs/files-backend.c
>>     +++ b/refs/files-backend.c
>>     @@ -3037,7 +3037,7 @@ static int files_reflog_expire(struct ref_stor=
e *ref_store,
>>      	 * reference itself, plus we might need to update the
>>      	 * reference if --updateref was specified:
>>      	 */
>>     -	lock =3D lock_ref_oid_basic(refs, refname, oid,
>>     +	lock =3D lock_ref_oid_basic(refs, refname, NULL,
>>      				  NULL, NULL, REF_NO_DEREF,
>>      				  &type, &err);
>>      	if (!lock) {
>>
>> Which seems sensible to me. We'll still get the lock, we just don't
>> assert that the refname we use to get the lock must be at that
>> SHA-1. We'll still use it for the purposes of expiry.
>
> I _think_ this should be OK, because we don't open the reflog until
> after we hold the lock. So we don't really care what the value was at.
> Wherever we got the lock, we'll do the expiration process atomically at
> that point.
>
> I don't think this makes all your problems go away, though, because
> you'd still have the immediate contention of actually taking the lock
> (at any value).

Yeah, but as far as I can tell core.filesRefLockTimeout added in
4ff0f01cb7 (refs: retry acquiring reference locks for 100ms, 2017-08-21)
solves that.

I.e. the problem after that patch isn't the contention, but the call to
lock_ref_oid_basic() in files_reflog_expire() above which *after* we get
the lock effectively asserts that the value must be at the old OID.

It would then hard-die, so git-reflog would leave behind stay *.lock
files that e.g. a concurrent "commit" would die on (still there after
100ms, and beyond). Whereas if we're not picky about the OID the two
will have contention, but core.filesRefLockTimeout will work around it.

I've been running this whole thing in a loop for a while with that
s/oid/NULL/ fix, and it just works. To the extent that it doesn't (due
to load) I can just bump core.filesRefLockTimeout up a bit.

So with the benefit of some sleep & your comment I'm pretty sure that's
the right fix. Ideally it would have a test, do we have some simliar
contention-creating tests I can piggy-back on, or maybe we should just
change this and hope for the best...

>> But maybe I've missed some caveat in reflog_expiry_prepare() and friends
>> and we really do need the reflog at that OID, then this would suck less:
>
> If I'm reading the code correctly, we don't call reflog_expiry_prepare()
> until we're holding the lock (because we pass it in as a callback to
> reflog_expire()). So I think that would be OK.
>
>>      	if (!lock) {
>>     +		if (errno =3D=3D EBUSY) {
>>     +			warning("cannot lock ref '%s': %s. Skipping!", refname, err.buf);
>>     +			strbuf_release(&err);
>>     +			return -2;
>>     +		}
>>      		error("cannot lock ref '%s': %s", refname, err.buf);
>>      		strbuf_release(&err);
>>      		return -1;
>>
>> I.e. we just detect the EBUSY that verify_lock() sets if the OID doesn't
>> match, and don't prune that reflog.
>
> That saves git-gc from failing. But do we have the problem in the other
> direction? I.e., that the gc would take a lock, and the actual user
> request to update a ref would fail?

No, because as with s/oid/NULL/ above core.filesRefLockTimeout saves the
day.

> That's what the retry-with-timeout is supposed to address, so maybe it
> works. But I wouldn't be surprised if it's insufficient in practice,
> since the reflog code may walk big parts of the graph under lock,
> checking reachability.

I suppose this can happen if the reflog for a given branch is so big
that it takes us more than 100ms to parse it, but e.g. O(n) refs
shouldn't matter, since we only hold the lock on one ref at a time.
