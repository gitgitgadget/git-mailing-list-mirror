Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794850732;
	b=WlssQ91GBfFCwyjbYmfzHvGL4Ce9764DUcFj5mk9nIa+S7jeiWkkGG3oZmDrKQ/ybOJb
	 l8xsDjyZORxhWMNQbAk0KNxRn+W5fewqnlrMWK9NJANzOalgvZqhDgwoWQJM+PeDB7FKU
	 K/lMwCB6UT7DQ1F4Gin35Sv23iD0KYt+mVI8daSGSkQGIndoiUyUAHlp8Bor8LdiOClaC
	 uU/i0sDMThEo7PudORpP0kttq7pZn7F7iUWgJ87h6MNVPXdHuk1s7hFSlxw0O+Abo9zeT
	 mmMPrQKA29kBPmNoorQGVLZRFsrEHjXhbX4Az3/J6Ugh+6U4mzsYCR+fx+HhO8keVXw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794850732;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Content-Type;
	bh=EjQSJgO5KglReNtiRtLiRlKGWK9ce/zBYJ/8zfjqP4g=;
	b=T5vTBAhb/3ASEyJ6nrGJ2kmGLh10OrJRwEyYMselFDTJfR0sXG8/Douah88Dt/ZPbyQ4
	 t91egi4aDHftJpW40O6GAm5l4MJnpH6P3kOEUD9s4n6bxzu89Fa/X6fxwl5UjRvVjg8tW
	 Pml15ERhwbd6ZQWya15kyQNpdE0PK0C1uPxqcVLekkUAH5lQFEmlX6CJarJM2lDfSIrZR
	 ymeFzzL2dr+qOO0p5sxYpoje4iCV1mSxf4OltJAN5J36eQpLZ5fQHXZ4eHVOa6L0K4cJy
	 gHbSHBDUV+bXmGQnpMcBOgrHPJvON8pINjTG45i3sTUKG/4BMIiYlPsuSHEPKz681Yg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kpsCcYmL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.53
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41CD606A33D
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 17:38:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F41CD606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kpsCcYmL
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c505a0acbc1so45776966b.2
        for <git@vger.kernel.org>; Mon, 16 Nov 2026 09:38:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794850730; cv=none;
        d=google.com; s=arc-20260327;
        b=Izbg3m6cmFGmXMmjFOHd8w3iK/Z/DQxMZc2xjBeklvYvHe/o/K+urgXwwuNKCUFRxr
         9GT2CbvSE5wUnUjuLFe6JsZ8st/kKgI/sCrwepFl7LzZpE6mvO6MHW1QrlNtBsBDaG4g
         Cizr1flcSitkEfgs8PDlQmqFuOfnF8TfJh1fI2X/g1T+ZQXwPwGuMUa1G8e31tXld8cr
         kWYCF6gfzHlemqp+5SgJDMGispCBm8YC4/tucX54WI03YBSLLBjmXyWG9glV7OuWI+fW
         4hllnIZ+C8uw8aemMHkkJFTIh7C0BeXkSMd9vQqivZV5T0+BYcHb5LohbZ/ksu5yNaZ5
         peXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=EjQSJgO5KglReNtiRtLiRlKGWK9ce/zBYJ/8zfjqP4g=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=qtYLzf49xCFLMOW06JkW9IqXTa2ffy6tnY0CEV6Q3PEuHYe1XdOBl+vUopSowfB4FT
         EL4maOmw+q5fk6xg7/XPGAQOmxRjHU6WsyYQK7L5aZ6cgWaxpivmxMeb7CBgSOVyeNJk
         ffUC206ao/2EHNl+eRp47sGdfxuNKP8my2VK8De2lofG3ijKfM9a/sVxwsPtIe+Hqryl
         h7uhFipp9BQ/jYzYHvdyevQaof6esBr63VFIXlfIzQHzvwR5+XxoKDf2CGAg1J784Mth
         2tr3iAycf9Uhs0hKSQA/1Tkm4iTZTshQrSK/TI8J8A8uVSPtmvgqzUvNGVsAHN8EWzUI
         Salg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794850730; x=1795455530; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=EjQSJgO5KglReNtiRtLiRlKGWK9ce/zBYJ/8zfjqP4g=;
        b=kpsCcYmLYQwpVDi2X0z6XZItcvZ5X6z0C2l/HIL05Q3ULcTeVLfmyiGU+ERGlSIHPl
         ML697o/7VAWQqgUqmJuBABHDYhP7gkK5/w01Kci3TcY2ZSYHnwyGGONeUrVv4WEXUK2g
         xpmb+QNSmGgkVtAl6r0XCELlldCiQZhT3Ljd0XylPcQ2jvQElgqQBuaCwyLNjpGbH4Pf
         dimzj5cZoteGEUb4vMOVcuDbbgarpVpLoxujaOOLQ0YfpTZkEpaPv1yRAVl222frjSEd
         omGVFoFBssnINIbWw5W0iDY5AknT6W3gjyaD9bQ4z2pXDpecLpE2UZTq5S2A0mLItnLe
         osUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794850730; x=1795455530;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EjQSJgO5KglReNtiRtLiRlKGWK9ce/zBYJ/8zfjqP4g=;
        b=AZThyq3NflReqJPN7LIT9OZakUoq2DGFLW9+alvd1TO7EJm5AxlNV464Kl8XCTrEQz
         sz9Bj0lu/8k3ik3wfh5tZlfZQHRmaETOxkYw1GyN4aWNEEb9sB+yyLvUX4YjscKDThVH
         Pc4YBmf3o9xKWPlx/3TVjvfpLMJ58iMYk5HDQ9zzkMdoyTBmhgSHQwxNBgj15ik0vQn+
         DuIFs9E16IicbueaN4VcGBqRi3w6RtnGwp7LC+JJ/1F07UGv4z/U7LUTQnyTfRg7Yomu
         MrS7ssTzwtbnQLf0VVFv8CNyhzY5skat9qINX4Z07MqzV0qUjwPmCv9mwF0BezvlG/UP
         nKVg==
X-Gm-Message-State: APuU4Z+0R68t62v5A3DPriOqPydrdea/MwtB5B3Swa3cUul3LrKphH6g
	qvd8PQAt+4BiHqYTmGXWBdpHwHf3IeBTsuCIt6W9YrOGc4SuJnnVM8+l+SNv36O/v1xsTh8EMkS
	ebC6/qDhRdoDnhh9J6N6jLd7roL4idfGManzU+r8=
X-Gm-Gg: AYBFou1+aTaBQnURKpeGvOdTRI/UaN9I49rIOA6+MnpeQ4b+mE2/k9uBmkIPHNLsWAR
	i0rSze6GcCZaixDJU8SSSPtI11p/PDMMaIAqN1gMLCMjA5lkfJSSp9B2VQ4u+CftTU7V9w+fYMY
	MQ1TvnmZrpEylTolJJW51qBw2sZtmapsks2rNOsguxJVpypwjIcgJUHIADts9eA1RQDVBr1FSOI
	/vnaZPo4oYrNLyYirN2be1sJlqJYGUDj1YOgWGTwDaK5NtZMj0FyiJc7mxcABQ/JSoyYEhzyq1M
	vjrSdrUJaLDoVRIoSRnT0bfNvB28qQrwe9cMdGcW8I9RC6/RbRlUVdbnsOsYVID2cjJXLGDsmRg
	ayC6WWEhE9GaUzQHUCX8300ZkZ0oM2Ku6o+WrblpqVDbgJU6oZ5aXrDSHfFVz+KyXJK0vUgo=
X-Received: by 2002:a17:906:18a1:b0:c3f:98d4:dfda with SMTP id
 a640c23a62f3a-c509636d2f0mr909756666b.3.1794850730167; Mon, 16 Nov 2026
 09:38:50 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: =?UTF-8?B?15zXmdeo15XXnyDXoteT158=?= <lironeden@gmail.com>
Date: Mon, 16 Nov 2026 19:38:38 +0200
X-Gm-Features: AclHuK9g0UkFeFp9Dv3N7SUm_lPExX3IYoTgwC5TsOrfWQtgPH9WFzSix7YCBeI
Message-ID: <CAG7kbaYpxb1-4E9CCG_=DKK4K1RV0b3qsYfUf6Qp57fakW0XPQ@mail.gmail.com>
Subject: [BUG] index-pack lazily fetches REF_DELTA bases that are in the pack
 being indexed
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

In a blobless partial clone, I fetched new commits from a server that
sends a thin pack in which the deltas with a base inside the pack are
REF_DELTA (the client did not negotiate ofs-delta).

The script below reproduces it with stock git over file://. Setting
repack.useDeltaBaseOffset=false on the client stands in for a server
that does not support ofs-delta.

----- 8< -----
#!/bin/sh
# index-pack lazily fetches REF_DELTA bases that are inside the pack it
# is indexing (partial clone + thin pack + REF_DELTA for in-pack bases).
set -e
D=$(mktemp -d)
cd "$D"

commit () {
git add .
git -c user.name=t -c user.email=t@example.com commit -q -m "$1"
}

git init -q server
(
cd server
# One wide tree, so that later versions of it delta well.
for i in $(seq 1 300)
do
echo "base $i" >file$i
done
commit base
git config uploadpack.allowFilter true
git config uploadpack.allowAnySHA1InWant true
)

git clone -q --no-checkout --filter=blob:none "file://$D/server" client

# Do not ask for ofs-delta, so every delta arrives as REF_DELTA. This is
# what a client gets from a server that does not support ofs-delta.
git -C client config repack.useDeltaBaseOffset false

old=$(git -C server rev-parse HEAD)
(
cd server
# Each new commit changes one file, i.e. one entry of the tree.
for n in 1 2 3 4 5 6 7 8
do
echo "new $n" >>file$n
commit "new $n"
done
)
new=$(git -C server rev-parse HEAD)

GIT_TRACE2_EVENT="$D/trace2" GIT_TRACE_PACKET="$D/packet" \
git -C client fetch -q origin

echo "git version: $(git version)"
echo "processes spawned below 'git fetch':"
sed -n 's/.*"event":"cmd_name".*"hierarchy":"\([^"]*\)".*/\1/p' "$D/trace2" |
sort | uniq -c

git -C server rev-list --objects --filter=blob:none "$old..$new" |
cut -c1-40 | sort >"$D/in-pack"
sed -n 's/.*fetch> want \([0-9a-f]\{40\}\).*/\1/p' "$D/packet" |
grep -v "$new" | sort -u >"$D/lazy-wants"

echo "objects requested by the nested lazy fetch: $(wc -l <"$D/lazy-wants")"
echo "of those, already in the pack being indexed: $(comm -12
"$D/lazy-wants" "$D/in-pack" | wc -l)"
rm -rf "$D"
----- >8 -----

What did you expect to happen? (Expected behavior)

A single fetch. Every delta base is either in the received pack or
already in the local object store, so nothing has to be fetched lazily.

What happened instead? (Actual behavior)

index-pack starts a nested lazy fetch for delta bases that are in the
pack it is indexing. Output of the script with 2.56.0:

git version: git version 2.56.0
processes spawned below 'git fetch':
1 fetch
1 fetch/index-pack
1 fetch/index-pack/fetch
1 fetch/index-pack/fetch/index-pack
1 fetch/index-pack/fetch/maintenance
1 fetch/index-pack/fetch/upload-pack
1 fetch/index-pack/fetch/upload-pack/pack-objects
1 fetch/maintenance
1 fetch/upload-pack
1 fetch/upload-pack/pack-objects
objects requested by the nested lazy fetch: 6
of those, already in the pack being indexed: 6

With the repack.useDeltaBaseOffset line removed (ofs-delta negotiated)
there is no nested fetch and both counts are 0.

What's different between what you expected and what actually happened?

A redundant fetch is started from inside index-pack. In the script it
costs one extra round trip. Against a real server it turned into
unbounded recursion, described below.

Anything else you want to add:

Where it comes from, as far as I can tell: fix_unresolved_deltas() in
builtin/index-pack.c, which is reached only when the pack is thin. In a
repository with a promisor remote it first prefetches delta bases:

for (i = 0; i < nr_ref_deltas; i++) {
struct ref_delta_entry *d = sorted_by_pos[i];
if (!odb_read_object_info_extended(the_repository->objects,
&d->oid, NULL,
OBJECT_INFO_FOR_PREFETCH))
continue;
oid_array_append(&to_fetch, &d->oid);
}
promisor_remote_get_direct(the_repository, to_fetch.oid, to_fetch.nr);

This loop goes over all REF_DELTA entries, including the ones that were
already resolved against a base inside the pack. The loop right after
it skips those (real_type != OBJ_REF_DELTA), but the prefetch loop does
not. The objects of the incoming pack are not in the object store yet,
so their bases look missing and are requested from the promisor remote.

Skipping the already resolved entries would not cover everything: a
delta chained onto another in-pack delta whose own base is outside the
pack stays unresolved at this point, and its base has no known object
ID yet. Resolving with the locally available bases first, and only then
prefetching the bases of what is still unresolved, would avoid the
request in that case too. I have not written or tested a patch.

How I ran into it: clients 2.50.1.windows.1 and 2.53.0 (Linux) against
Azure DevOps Services, which did not advertise ofs-delta in the packet
trace. The flow was:

git clone --no-checkout --filter=blob:none --single-branch \
--depth 1 <url> .
git checkout <commit that is not in the clone>

The checkout lazily fetched the commit. The server answered with a thin
pack of about 44,000 objects (commits and trees). Its out-of-pack bases
were trees of the shallow commit, which the client had. index-pack then
lazily requested about 9,700 objects, all of them in that pack. The
server answered that request with another thin pack holding the same
objects, the nested index-pack did the same again, and so on. Every
level kept its fetch, remote-https, fetch-pack and index-pack processes
alive and downloaded about 14 MB again. I saw 12 levels in about a
minute before I interrupted it, and several hundred levels in an
unattended job that ended only when it hit its memory limit.

4360734e90 (promisor-remote: prevent infinite recursion when lazy
fetching, 2026-10-02) on master caps the nesting at 5, which bounds
this, but the redundant requests are still made. The prefetch block
above is the same in v2.56.1, master, next and seen as of 2026-11-15.

Fetching the commit explicitly before the checkout avoided it for me:

GIT_NO_LAZY_FETCH=1 git fetch --depth 1 origin <commit>
git checkout <commit>

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.56.0
cpu: arm64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
rust: disabled
feature: fsmonitor--daemon
gettext: enabled
libcurl: 8.23.0
zlib: 1.2.12
SHA-1: SHA1_DC
SHA-256: SHA256_BLK
default-ref-format: files
default-hash: sha1
uname: Darwin 25.6.0 Darwin Kernel Version 25.6.0: Mon Oct 12 00:41:41
PDT 2026; root:xnu-12377.161.15.701.48~2/RELEASE_ARM64_T6050 arm64
compiler info: clang: 21.0.0 (clang-2100.3.34.2)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/bash
