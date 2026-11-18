Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795010638;
	b=TSdvMHnTueripKZqftMIeUUjOXgudBiVNMjneHkyHCdsdRlYRTjcGlMBNIDwU2101WKy
	 N/cktahnq+pJXy0P1cAGWh0oussdHCAvLHlYzc08b6D675pJUqGimla+ArbLoQb5TK2/x
	 fePnjBYkRrcxFfYNQ6cTMKP/uEouGR8SZ+BqTU1zpH1DJjQXCYAAQqsBEe2yaaKb3KK9q
	 rhsSzZWDEITujenSid+eLJr3LCFkhv7jVXXAUitA+SCLfKUIq8VY7FFEXPBTGtkT5Va/B
	 5J7A0C8hp4Lyo+fVC5ecqnrgayEfSBePkBTmEBuf3td9RxQE3r9lIjRMhyZnrGQ6j5g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795010638;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=OAq9UxRO90lckz5M/0L7hFkhTBed6NxVplIgHkjqP5Y=;
	b=YVc20WoxXByd/9JPPIi3UMBHmeobIYriezyOkk74yt5i71DTRp65jqM/pmQoKg8RxP8V
	 C4yipw0wzkcrmPmyGPtkoV4+rKTkZSk0F35tzHcAmgSya6R4l4dy5Fogg2LA2dbrmXyDL
	 Pyu8qJeE8cPwkL/0wkNqBTeDhaF8kFPsdbJ/09pT/kMQ9XvK5yS3o3drzJpUgu+iOkVet
	 0bnBGimFStmE50NpbxFaYLINnzoCjCMvn+cGEkmUFE3wptG+qE1g1xSgo0Ls9MLkA05Wd
	 qowLaKRWrsMrbvs8eVrJI+jbBGNszRdvw+1+b/rXF5w+00IWC4t5LhX0aWpU196uRWw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=CbGWiIh4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.180
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2837606A31C
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 14:03:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2837606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=CbGWiIh4
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3ae22dcfdc3so8862341fa.1
        for <git@vger.kernel.org>; Wed, 18 Nov 2026 06:03:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795010636; cv=none;
        d=google.com; s=arc-20260327;
        b=Iq593/gvD0jqN0fcNEmAHl4yYrFB6L0iNO4AmAvsP8qNOTY3MXSIthNnZ7MegWTWfX
         oPC/xRY8wD13yl+x++Y/T/yeset4eB4VF4phTlOrjN4dDKXp4laAQyb/DwV2uE8aku86
         ekrEn2RNdmMeGDcnFbL15WRsYu+WYO6miJzi/vOTSWkm+KPFvUStLrp5+IkbOQGLRcI+
         xVCk5DIPtdCtHjlC42gjgcX1wqMgRTref8QGfIsFzdxMXRbFMsH3DkP730SQvYXOblFx
         GQJ2mt0klkkzNRlnY9vpOdYYMkn7S6xFc7UQh3oWwmM3Kw0izfq/Xim8jwcaBQHKrWKH
         hC8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=OAq9UxRO90lckz5M/0L7hFkhTBed6NxVplIgHkjqP5Y=;
        fh=vihsUN31oCSdlAH+A9PWNcftk/V3pNwNrt/NXi4KMqs=;
        b=eCmEBfirHmiMxRtHT3BPIaumTr5GTRVdai5zmqK87Y/NEsp8Ov18ck/XDu48i9k4up
         XjTeThzoVdWZpKLYkC31jassDrUTljhW+GqASUxhAa+fRbNXuvJ0ea5JMWQzDQWPi3Ps
         JIkXaWlnQGqS5l54DbDuDcaJaXNMdVarOXl6hyAxRhylFQxhq1pGNUlOoQPMt86/hZDG
         KoZDlTFM2VZ4msk5xsl5eFb2bvN1OHRjy8ikH32zn9eYYJD1mMTNenR15VAmL9ztmhYu
         A1Yj5QmBPgrS2qEK41CcDDPzXBXcuL6SBCY/VJHTQTA+XEfeRVVJAXIxJIPbufAGquRI
         yUsg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795010636; x=1795615436; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OAq9UxRO90lckz5M/0L7hFkhTBed6NxVplIgHkjqP5Y=;
        b=CbGWiIh4l0C1k5SVag9cO9YBQlkT2Wfm4faFdyMAReE+lzLAdYRbxcF35mkeUnGkry
         kDLdx/Sh+HEKc95j9/N0eTMEKI4lc1NGZhkftg1NCsuMVqu54z/gZvNHU4jxQnQvTaqg
         7O18P1HfOfUvm0qeEmDI0CH59KEvsoO72lTMe2QwhfRn997RG7urmyfmHOnPNs1uGMM4
         mENMlo/Pby4MlScdTDoDmwDRjtcK00kuX/uGhFNPv9LhDlXrkfTdjt3E6QCEWS63XgIL
         KtUVceEnHdAOaUKZxdsXPENzQ71EIeXLqlo0oormLnyFzUvgVT+KpRfhtYLavUrBtBju
         UPXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795010636; x=1795615436;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=OAq9UxRO90lckz5M/0L7hFkhTBed6NxVplIgHkjqP5Y=;
        b=pYOyAYjeWvi0cfR6626eatABbBaAGSRUnCw8SrZwLUjpmr13PpSrJyXYvwKz5adP3u
         YYdQgDWOa2du+dd10OhWf7lMJPMr0CKBjKI2C10VKYr6BHM9jSj6pC1CeNSrbtxpkYoG
         gO95IMD0iob7+yV1sEerFvQYyu7K7ICJvzv03ofhcz1JKP7Rk5s0jf1EvwkKAVj4dIcJ
         QC+Nt2xpgG3ux4xnD+dqdKijjhW1eVWG2jrDE/qQ1qN8yHeEfaLfqfUsawys6jjn/qpV
         yZJ5Re4ylVjJcMjMvhhr7jKNdPxo3Muajsrvtv3iKbrysn3qNpglaYq9x1xc9ApmNtmU
         Le0g==
X-Gm-Message-State: APuU4Z+IYrmgVR6HKby9W8NeewxyXf7oYASGltYhNSBMw7+c5Ok1sQrn
	phvZhehzNHcYhIP7makH17ciCxLsxF+l4bz0MYBOBjC++pNxrQ5cxMBOwerYBXdKcoPjgBteb9p
	Kr8mtUl1WNiAaAgOD7irAAf6dMg+0OgQqsYP7WfRt1VlJ41jJxzKDbQlAlko=
X-Gm-Gg: AYBFou1eAuNN7lTH/ai8/Jt+4cO9T02MVwgLV512D43a0iTDaMiKo54oXqYl5S4zAU4
	xEzZtYTXKjrEKeWnWM3dEcZywtokSpCCehV/6yeVIFA7StRJOTHHv2HGuFaNby2ZCvSMO8qSxhr
	dEs3GO11g/99dHsa0YZOPKjM8DqDR4i7WjZlM3vl7vL+AWVzUA9uHiQ+qgRfJL4WX2P3sPlnizC
	TJbu5SQ/wFS/JXfv4Ki76GJPQNmgV9qKIoIilIQpv4daKoEVoL8+ssBKezA9PPojiKbAWS+AHHS
	QuVztE2whQscFcIT9aWtGeUd3nxtr9oOn0zKR3otxzKiq9mMGAxiwHWC+3ygZ9zO7qa5U5IwBaj
	aR1nioGM6IlBCZ3QfI4R7plRM2qjL6QFrUCjBLw656LfzkmoWPPmrzks9XjUx6N0BuaQ=
X-Received: by 2002:a2e:bea0:0:b0:3ad:f19b:f8e5 with SMTP id
 38308e7fff4ca-3ae670cf703mr9115151fa.17.1795010635201; Wed, 18 Nov 2026
 06:03:55 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: John Mellor <johnme@google.com>
Date: Wed, 18 Nov 2026 14:03:43 +0000
X-Gm-Features: AclHuK9b8TGe3NYeybD_ijurbnHUOcYGIPQcpTkijLXKYldQYIA-oHOkFrvAZAs
Message-ID: <CAG_kaUYEjQhiPMatcPXr00q3oO77BM2Mu7KUZyP0aSGGwKTsJA@mail.gmail.com>
Subject: [BUG] fsmonitor (Linux): directory moved into working tree is not watched
To: git@vger.kernel.org
Cc: Paul Tarjan <github@paulisageek.com>
Content-Type: text/plain; charset="UTF-8"

What did you do before the bug happened? (Steps to reproduce your issue)

Whilst I had the built-in fsmonitor daemon enabled on Linux, I moved
a directory into the working tree from outside it (a plain rename on
the same filesystem), committed it, then edited one file directly
inside it and one in a subdirectory of the moved directory.

Steps to reproduce:

    git init fsm-repro && cd fsm-repro
    git config core.fsmonitor true
    git commit -q --allow-empty -m init
    git status --short          # starts the daemon
    mkdir -p ../fsm-outside/pkg/sub
    echo a >../fsm-outside/pkg/top.txt
    echo a >../fsm-outside/pkg/sub/f.txt
    mv ../fsm-outside/pkg pkg
    git add pkg && git commit -qm add
    echo b >>pkg/top.txt
    echo b >>pkg/sub/f.txt
    git status --short

What did you expect to happen? (Expected behavior)

I expected both edited files to be listed as modified:

     M pkg/sub/f.txt
     M pkg/top.txt

What happened instead? (Actual behavior)

Only the file in the subdirectory is listed:

     M pkg/sub/f.txt

`git -c core.fsmonitor=false status --short` lists both files.

What's different between what you expected and what actually happened?

Edits to files directly inside the moved directory are invisible to
status, diff, add -u, commit -a and stash, with no warning. It's not
a race: it happens every time, and later edits in that directory are
missed too, until the daemon is restarted.

checkout and rm don't see the edit either, so they can accidentally
discard it. Continuing from the steps above:

    git restore pkg/sub/f.txt   # discard the edit that git can see
    git checkout HEAD~          # should refuse: local modifications

This incorrectly succeeds, silently deleting pkg/top.txt along with
its uncommitted edit. Similarly, running `git rm pkg/top.txt` instead
of the checkout deletes it rather than refusing due to local
modifications.

Anything else you want to add:

Running the steps above in /tmp, GIT_TRACE_FSMONITOR shows the move
and the edit in pkg/sub/, but nothing for pkg/top.txt:

    inotify_event: '/tmp/fsm-repro/pkg', mask=0x40000080 IN_MOVED_TO|IN_ISDIR
    no matching cookie for rename to '/tmp/fsm-repro/pkg'
    inotify_event: '/tmp/fsm-repro/pkg/sub/f.txt', mask=0x00000002 IN_MODIFY

I think the cause is in compat/fsmonitor/fsm-listen-linux.c. On
IN_MOVED_TO|IN_ISDIR, process_event() calls rename_dir() and then
register_inotify(path). As the directory came from outside the working
tree, there is no matching IN_MOVED_FROM cookie, so rename_dir() takes
its "Directory was moved from outside the watch tree" branch, which
only logs "no matching cookie" and returns. register_inotify() then
adds watches for the subdirectories of path, but not for path itself
(whereas the IN_CREATE branch calls add_watch(path) first). So pkg/
is never watched while pkg/sub/ is. A possible fix might be to call
add_watch(path, data) in that branch of rename_dir()?

This looks related to, but separate from, Erik Cervin-Edin's report
about subdirectories of a directory renamed within the working tree:
https://lore.kernel.org/git/as4z1SskiPyrSKIa@vader/

I reproduced it on 2.56.1 and on next (720f3f593):

[System Info]
git version:
git version 2.56.1.831.g720f3f593
cpu: x86_64
built from commit: 720f3f59372f7249d3b84f824ca9f570b40301ab
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
rust: disabled
feature: fsmonitor--daemon
OpenSSL: OpenSSL 3.6.5 29 Sep 2026
zlib: 1.3.2
SHA-1: SHA1_DC
SHA-256: SHA256_BLK
default-ref-storage-format: files
default-hash: sha1
uname: Linux 7.1.6 x86_64 (Debian-based)
compiler info: gnuc: 15.2
libc info: glibc: 2.43
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]
