Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64E0220401
	for <e@80x24.org>; Sun, 18 Jun 2017 13:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752950AbdFRNWf (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Jun 2017 09:22:35 -0400
Received: from mail-wr0-f182.google.com ([209.85.128.182]:34061 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752888AbdFRNWd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Jun 2017 09:22:33 -0400
Received: by mail-wr0-f182.google.com with SMTP id 77so58852891wrb.1
        for <git@vger.kernel.org>; Sun, 18 Jun 2017 06:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=97THTnxrOOcfgx4nFnvzjVgOT5eu1ZWyDZwXb8gPWB0=;
        b=I9CWNrgsqdJ0pTziLiJ/KDvyfqxRaI/F8ffiJrR5iNOtkF1PhEqqa6gUKyzXNOYzgf
         VUADlvhx0xNmi/pICIhbLRERgFGJVlR0z6gS82zfvLBl0Md+w0CCgkpIj8tteKVY2E8f
         CcyiBeWnW2jxAQdA4XmAmIjXkp1NzAjyZvpfHzjzdMXJiwZ0334SHuTEtX2mCcnVlMYT
         eb1hkFWL6QHs6QPhjotC/mh31dY90dYFEoVS1+YdFp2gQxqDTwqrlDqPIIA3vjJp5ZZ1
         GfRPt1BXgpiEXEYC/nXY5ctIjPuIZFbGYr5ZgI1OAk2t1QwV34u+egWxnkk4D/DskWUC
         c8Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=97THTnxrOOcfgx4nFnvzjVgOT5eu1ZWyDZwXb8gPWB0=;
        b=QDAbNtBlePR0FJ5spwBbHdH37y2qVBJXQvtDzkN1ZYc07xAsaf51ADFV5KGaH8KFd/
         vbln/pO5e9SHY9hI0yA1If558RUJYcyZogH21gMjRPvTZdFhrERYJ02KWzeTjlf3EDrC
         W+s00sPSDMyksWa3WHRDL0Pt0OITFIZV7o0W9TqF6ixi55GEH/ud1HcsWG8xz1qRsOuO
         ImJPoZvkj/07rrixkA+1VgIK+eZSDXqEsXPc+asADhPxM/6UAdZ6msCZku+L3XxcIQnu
         Qhdfx7PkWUZefMZSre+jsGDDD3jCBebdbYDCZqNAZACUhTKkNezgknqro/qZjZ2NtIGT
         aAmg==
X-Gm-Message-State: AKS2vOxJ9P3+K42vLnL2HWA5jJKrNQAfXE4cBJV7cxJa0PL1ghd+Y8gc
        qOaH6v3jdJqvmw==
X-Received: by 10.223.176.164 with SMTP id i33mr12121555wra.165.1497792151791;
        Sun, 18 Jun 2017 06:22:31 -0700 (PDT)
Received: from [10.32.248.164] (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id k56sm7578186wrk.45.2017.06.18.06.22.30
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 18 Jun 2017 06:22:31 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: "There are too many unreachable loose objects" - why don't we run 'git prune' automatically?
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20170610080626.sjujpmgkli4muh7h@sigill.intra.peff.net>
Date:   Sun, 18 Jun 2017 15:22:29 +0200
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <EDF2B923-8A5F-436E-BDB8-82249C6052ED@gmail.com>
References: <9C2F2EA2-0C59-4EA2-8C8E-10228FB82D90@gmail.com> <20170609052755.dsuqd4gizi2opoya@sigill.intra.peff.net> <7497DFA7-3F4E-4DB2-B31B-FDDEB2F30BB8@gmail.com> <20170610080626.sjujpmgkli4muh7h@sigill.intra.peff.net>
To:     Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 10 Jun 2017, at 10:06, Jeff King <peff@peff.net> wrote:
>=20
> On Fri, Jun 09, 2017 at 02:03:18PM +0200, Lars Schneider wrote:
>=20
>>> I agree the existing message isn't great. There should probably be a =
big
>>> advise() block explaining what's going on (and that expert users can
>>> disable).
>>=20
>> How about this?
>>=20
>> diff --git a/builtin/gc.c b/builtin/gc.c
>> index c2c61a57bb..12ee212544 100644
>> --- a/builtin/gc.c
>> +++ b/builtin/gc.c
>> @@ -473,9 +473,18 @@ int cmd_gc(int argc, const char **argv, const =
char *prefix)
>> 	if (pack_garbage.nr > 0)
>> 		clean_pack_garbage();
>>=20
>> -	if (auto_gc && too_many_loose_objects())
>> -		warning(_("There are too many unreachable loose objects; =
"
>> -			"run 'git prune' to remove them."));
>> +	if (auto_gc && too_many_loose_objects()) {
>> +		warning(_("Auto packing did not lead to optimal results =
as the "
>> +			"repository contains too many unreachable =
objects."));
>> +		advice(_("Unreachable objects are Git objects (commits, =
files, ...) "
>> +			"that are not referenced by any branch or tag. =
This might happen "
>> +			"if you use 'git rebase' or if you delete =
branches. Auto packing "
>> +			"only prunes unreachable objects that are older =
than 2 weeks "
>> +			"(default, overridable by the config variable =
'gc.pruneExpire'). "
>> +			"Please run 'git prune' to prune all unreachable =
objects for "
>> +			"optimal repository performance."));
>> +	}
>=20
> s/advice/advise/, of course. This probably be protected by a new entry
> in advice_config[] in advice.c.
>=20
> But I assume you are most interested in the text. I think it
> simultaneously goes into too much and too little detail. I think the
> warning itself should just say _what_ we observed: after garbage
> collection, there were still enough objects to trigger a gc.  And then
> the hint doesn't need to go into the details of why we prune or what
> unreachable objects are. Those can be cross-referenced with other
> documentation. I think we need to focus on what the warning means, and
> whether and how they would correct it.
>=20
> Maybe:
>=20
>  warning: too many loose objects remain after garbage collection
>  hint: Automatic garbage collection is triggered when there are a
>  hint: large number of unpacked objects in the repository. Unreachable
>  hint: objects that are more recent than gc.pruneExpire are not
>  hint: pruned. If there are too many of these recent loose
>  hint: objects, automatic garbage collection may be triggered more
>  hint: frequently than necessary. You may run "git prune" now to
>  hint: prune all unreachable objects, regardless of their age.
>=20
> I was tempted to suggest that we find and report the correct "prune"
> cutoff that would let us avoid auto-gc. I.e., sort the unreachable
> objects by timestamp and find the cutoff that will drop enough to =
leave
> fewer than `gc.auto`. That in theory makes things a bit safer. That's
> probably not a good idea, though:
>=20
>  1. Telling the user to run `git prune --expire=3D37.minutes.ago` is
>     just going to confuse them. We could hide it behind a command line
>     option like `git prune --expire-auto-gc` or something, though.
>=20
>  2. Now that we try to keep recent chunks, the analysis isn't quite so
>     easy. You may have a single recent commit that references a ton of
>     old history, and only dropping that commit would help. So the
>     analysis is harder than a simple sort-and-cutoff, but it also =
means
>     that the prune times are likely to skew close to "now".
>=20
>  3. If we just show them how to prune the minimal amount, then they're
>     likely to just hit this message again soon.
>=20
> So that's probably a dead end.
>=20
> To be honest, the fact that we have to write this warning at all is a
> sign that Git is not doing a very good job. The best place to spend
> effort would be to teach git-gc to pack all of the unreachable objects
> into a single "cruft" pack, so this problem doesn't happen at all (and
> it's way more efficient, as well).
>=20
> The big problem with that approach is that we lose individual-object
> timestamps. Each object just gets the timestamp of its surrounding =
pack,
> so as we continually ran auto-gc, the cruft-pack timestamp would get
> updated and we'd never drop objects. So we'd need some auxiliary file
> (e.g., pack-1234abcd.times) that stores the per-object timestamps. =
This
> can be as small as a 32- or 64-bit int per object, since we can just
> index it by the existing object list in the pack .idx.

Why can't we generate a new cruft-pack on every gc run that detects too
many unreachable objects? That would not be as efficient as a single
cruft-pack but it should be way more efficient than the individual
objects, no?

Plus, chances are that the existing cruft-packs are purged with the next
gc run anyways.

- Lars

> The trickiest part would be when an object's timestamp gets freshened
> (because somebody tried to write it again but we optimized out the
> write). Updating the timestamps in the .times file would probably work
> atomically, though we usually avoid writing in the middle of a file =
(we
> certainly can't portably do so via mmap, and I can't think of another
> case where we do seeked writes). It might be sufficient for objects in
> the cruft pack to just do the actual loose object write instead of
> optimizing it out. It should happen very rarely.

