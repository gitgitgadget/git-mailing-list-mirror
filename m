Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93757200C2
	for <git@vger.kernel.org>; Tue,  6 Jan 2026 16:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767717218; cv=none; b=j5mGZmsDTD7+/1m3Qo227J+eE20Q6G0f9RhUhE4BpzTj7YIFP9Id/4vdAmYjXiCogr/CSlb0yPlN06EQP9JimtqPWtRYdbHdeO1Iyzl5E9tdciMA9VfjtGwKGDuy5WvRr7eMLMTIPiY9gEoYXrT/8BfNl0//ACi27R9x+uvMTNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767717218; c=relaxed/simple;
	bh=OWXlmAZCfiu92tJJBz/PshxLhZWKEXQC+L6lLafX2hM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YRmqN92lwVuomguJHcUbz7iLYrGv29Npg2SNM7cPWrweOypHC942THLtES035zu+OSRLLNsMAtNECHsvu+yeY2spRuS02AncZwS4RWjWG92vB3mUpzghpO4+eJashlV3Iuu96FXLUIu/MWJiXZn0Zc3q8Wysp5T+GLIwnyoGyjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X3rtSsNp; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X3rtSsNp"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-94121102a54so639163241.1
        for <git@vger.kernel.org>; Tue, 06 Jan 2026 08:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767717215; x=1768322015; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=EiXPJX6LvqfbdXUbQTGibt4mDqXvi53+LdOjF754wNo=;
        b=X3rtSsNp9mgiD56e8P62huu9BGZjP8wLTLhuO8gA+X97ZIvDIWncsyxiAbG6c0e57j
         u9JqGGgtdl2yF918lhH6n30MK4tMFHZEZG81rz6Pg2WRQQvefGx4GYgrZ+NP3zdfF21z
         x7Lj6S9XRa872k3iQeahGZz6S00hzKAKA07L3kIyQLpM6k9H9TOrJX2syxlARBbj0xQ0
         kRTCCxniKIfH3HaPw5LGzTBfsIG9pGsvzcDNVzZqU+VVtRCYD4sexPEHgfBitdbzF91T
         1LJ/eskOm7gzM36LaSHOeJN+sgztMdMD9TvEo7kBWLlhuxsrizsGeyAfXtxTzzSLETzf
         j0hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767717215; x=1768322015;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EiXPJX6LvqfbdXUbQTGibt4mDqXvi53+LdOjF754wNo=;
        b=DGvYovA6OMmgdy75dlU02s1/ehEAJ5KP3plRp+jvwEcGsIo++Cnoh5L5thPspeeeta
         c5D0TgqCQ4A+FmXDb4Ofx60HV7OXVDQZUMRrzCTquK0Y/Gg9X9TQjQrl6AAPXs4QUs0j
         sU8ZiKCsdBi6ODihbPenwMQC2036bO9W1uhuHwvi1jRsz3Tji1g+RxUIjb52kZiVVckz
         iaw7FkjVAmI8w2SYdSfrmaqclUReXfAKbKJ3DUkOhj29YxA7UhFoGhWrkK4bXFmZ4+As
         z1kNErqxQqRWq5hsutItDqZ2giN0QwTGTMb+sBcUDGTWvvEtCjrS3KWPby4LsQRpnD9F
         RFBg==
X-Gm-Message-State: AOJu0YyDRKJ6U0McLbIac0+rUb7V0yx5mxxzBsFF4e1QDafr85QI3tC6
	G48S8zbm1LB7u5MswQiZMQfSNhBuUEsq6piIkB8KIHshNDcnxM3mdIghmf1MxVRmCYSfjddS6i/
	Y957fmE+H6yuQZVP3I3X3aodlerMOXsg=
X-Gm-Gg: AY/fxX7NfS+4mdIzgVwgfPUKQ3ZUiUM6KpITHJB5s3Lh6drT/LO6EbohWWuyqxPHeXt
	+mdBWqOOWw5+jXCol9gVxDk/6+QMF6n0VOGebEUwDWBwNSeOePBZA5k9IM7kwtBpaK98c0xzW+i
	r9G1ioNp0037XHgNTd6Qe8jRskbFZhuKcdRrizvKaWovoONPnqqSd2+5B7QsunPloekEJs62ogI
	gioVfeD2saMicFa7E4ZS9QLfIM0+YgoSsdOPEodRYiIvwyI5LccAwaxMh/CTzy32qgho6ERBLue
	PjXs0ANZc52SKWb8YMBRj1EEvgBhy+KtmZqUV9XN
X-Google-Smtp-Source: AGHT+IGlZ6toukN6uOZjDkK5l8SSX4mMwifqAu5lNu3qy1w8jT6hla4EfiAZDC4oA90vxLfVgxt0S5asKhPZzQgiAAk=
X-Received: by 2002:a05:6102:f10:b0:5d6:27c7:e6b2 with SMTP id
 ada2fe7eead31-5ec74378126mr1136884137.3.1767717215392; Tue, 06 Jan 2026
 08:33:35 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 6 Jan 2026 08:33:33 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 6 Jan 2026 08:33:33 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aVz4G-gRf-mA2N56@pks.im>
References: <20251211-odb-related-fixes-v2-0-bdf875ce51fc@pks.im>
 <20251211-odb-related-fixes-v2-1-bdf875ce51fc@pks.im> <CAOLa=ZSZ9PKCi=vQY8WKhwAHVZT-keA5XOXBMVrB4ZW+u2uNhg@mail.gmail.com>
 <aVz4G-gRf-mA2N56@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 6 Jan 2026 08:33:33 -0800
X-Gm-Features: AQt7F2pdOsNKyHP04aUezHZoZyYWXxnny3_fSxNCE0wj5AcjCXEgEoOmzPDcyk4
Message-ID: <CAOLa=ZSawYRJ5_P=YQuG1zCPb=9hJS52O_JiAdbHCjb2wbohQg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] builtin/gc: fix condition for whether to write
 commit graphs
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Justin Tobler <jltobler@gmail.com>, 
	Eric Sunshine <sunshine@sunshineco.com>
Content-Type: multipart/mixed; boundary="000000000000aff3780647babc2f"

--000000000000aff3780647babc2f
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, Jan 06, 2026 at 03:27:29AM -0800, Karthik Nayak wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>>
>> > When performing auto-maintenance we check whether commit graphs need to
>> > be generated by counting the number of commits that are reachable by any
>> > reference, but not covered by a commit graph. This search is performed
>> > by iterating through all references and then doing a depth-first search
>> > until we have found enough commits that are not present in the commit
>> > graph.
>> >
>> > This logic has a memory leak though:
>> >
>> >   Direct leak of 16 byte(s) in 1 object(s) allocated from:
>> >       #0 0x55555562e433 in malloc (git+0xda433)
>> >       #1 0x555555964322 in do_xmalloc ../wrapper.c:55:8
>> >       #2 0x5555559642e6 in xmalloc ../wrapper.c:76:9
>> >       #3 0x55555579bf29 in commit_list_append ../commit.c:1872:35
>> >       #4 0x55555569f160 in dfs_on_ref ../builtin/gc.c:1165:4
>> >       #5 0x5555558c33fd in do_for_each_ref_iterator ../refs/iterator.c:431:12
>> >       #6 0x5555558af520 in do_for_each_ref ../refs.c:1828:9
>> >       #7 0x5555558ac317 in refs_for_each_ref ../refs.c:1833:9
>> >       #8 0x55555569e207 in should_write_commit_graph ../builtin/gc.c:1188:11
>> >       #9 0x55555569c915 in maintenance_is_needed ../builtin/gc.c:3492:8
>> >       #10 0x55555569b76a in cmd_maintenance ../builtin/gc.c:3542:9
>> >       #11 0x55555575166a in run_builtin ../git.c:506:11
>> >       #12 0x5555557502f0 in handle_builtin ../git.c:779:9
>> >       #13 0x555555751127 in run_argv ../git.c:862:4
>> >       #14 0x55555575007b in cmd_main ../git.c:984:19
>> >       #15 0x5555557523aa in main ../common-main.c:9:11
>> >       #16 0x7ffff7a2a4d7 in __libc_start_call_main (/nix/store/xx7cm72qy2c0643cm1ipngd87aqwkcdp-glibc-2.40-66/lib/libc.so.6+0x2a4d7) (BuildId: cddea92d6cba8333be952b5a02fd47d61054c5ab)
>> >       #17 0x7ffff7a2a59a in __libc_start_main@GLIBC_2.2.5 (/nix/store/xx7cm72qy2c0643cm1ipngd87aqwkcdp-glibc-2.40-66/lib/libc.so.6+0x2a59a) (BuildId: cddea92d6cba8333be952b5a02fd47d61054c5ab)
>> >       #18 0x5555555f0934 in _start (git+0x9c934)
>> >
>> > The root cause of this memory leak is our use of `commit_list_append()`.
>> > This function expects as parameters the item to append and the _tail_ of
>> > the list to append. This tail will then be overwritten with the new tail
>> > of the list so that it can be used in subsequent calls. But we call it
>> > with `commit_list_append(parent->item, &stack)`, so we end up losing
>> > everything but the new item.
>> >
>> > This issue only surfaces when counting merge commits. Next to being a
>> > memory leak, it also shows that we're in fact miscounting as we only
>> > respect children of the last parent. All previous parents are discarded,
>> > so their children will be disregarded unless they are hit via another
>> > reference.
>>
>> Yikes. So we never go down the path of the first N-1 parents? Does that
>> inversely mean, commit-graph generation would be slower now in
>> repositories with lots of merges, since it is fixed to follow all paths
>> correctly?
>
> Yeah, this was quite broken indeed. I don't think that the fixed walk
> should result in a significant slowdown:
>
>   - We stop walking the parent chain whenever we see a commit that is
>     covered by the commit-graph.
>

Yup that holds true.

>   - And our walk of commits that are not covered by the commit-graph is
>     bounded by "maintenance.commit-graph.auto", which defaults to 100
>     commits.

Ah, I didn't know this. Okay so there is a sensible cap here.

> So in practice, the cost should be negligible.
>
> There's going to be some exceptions thoulgh. Most importantly, the
> complexity of the computation scales directly with the number of refs as
> we use `refs_for_each_ref()`. So if you have a gazillion refs I'd expect
> the performance impact to become noticeable. But that's already been the
> case before this commit.
>
> We may want to revisit this in the future if we ever notice that this
> does become an issue.
>

Fair enough. Either ways, your fixes were _required_. So glad that we
got it fixed.

[snip]

--000000000000aff3780647babc2f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 3580b14c708fd9fb_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1sZE9Wc1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mODBVREFDVlFDWlErSkRiYzN4K1UrclA1S0N0T0JKNwpOTzJmWU5tWDZm
R3B1SXlMdVU2WEwzbGIwTUFmQnFiY2NPM2ZRdkZzbnR3Z09yU21MNlI0SVBtQUtsckhyWHd1Cktp
M2ozS0IzbGZkdzM0bDMwOStXVUloRVVMdjN3ZGNtYm5LNU5hRTZjeGFpNUMxcysvYVFTaFIrbkdY
WUJEdGkKK3JsRlJtbUxRR2F6bEUyeE5qY0xXRUp0cTZaay9yZmxxK2pKT20rNm5DbjFWcFgxdGVq
VmNhaC83TzJUcUxTQQpHd3V6aEpnVFFxd2VlUVMzZEtZWFVoRURMTk5MdHY0OFhBcFlweXJDNVdl
TXAxVTBuNnFvOTlHQ1Y1WkU3SytJCmJZRXpUZHpYUjhxOWdMOHRGajJZK3V2T1dTZzNsd3NNNGc4
ODdWdlNsUGkwcEwvMHlzdnZXWDR4cUQ4TUpHbzEKZVFUSkFScjY0Z1lOOUZXaVEyNWVxeVJuQW9U
UXNoVkpQOVlYYi9vbVdDamUvYUsxb3JKc1BjR3RjNm5PWnBsQQorUjlhSVd1bHEvbWM0R1hybml1
TUh6Um1EK3lmVlBtNUdqT3pBb3hvbm5TVU9TOUtLWmNzNHorNTQ3L3ovNEhsCk1BRmI5aGYvVGNm
M1ZVRGdRWEU3dUYwbis0T3EzVzFRUzRQVmoyND0KPXBxK1UKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000aff3780647babc2f--
