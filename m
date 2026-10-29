Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793303540;
	b=JyFattLM0KaAX2jDa+5sHjz7p57JhRe7zpYFMOdLpJm6YyKtGZFGDynsoiEJqougU9R/
	 ZQNSHSZqYwVxCGscXAOAhRreQmeF9SH1aUZl70oJfH2Rmw0xPgs29PmGxjiLQ6MdAe58W
	 GVlwxr0rrMEZy5CIjQlgvTMR13vvss+K38abaSZvYgqTiCVvx85inYNcFOcrzRwkFhIak
	 YMrF4I/K3J5b8t7CmfB48CwvzrTZzPkUs8OawWFnYwXVqjIXv+gIcUCeC3y61UJSfvmNb
	 oagrKo1SbYuJORm1m8s2zk4RlWUSi22LuOTpx7HwSkThcK0V1W6jfJwVSg+3X5tcTrg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793303540;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=w8KRbL/5fDLf5ihJmuixp6rX3EvCCXYdR349ODGPuH8=;
	b=uZmnUmDnCMsH1RBD8GIWGkD3eZqLbm1Ta3mp1+Z+I6UQ5sTk++8sn6I/j8egWwzqoAgD
	 M8tLCQtXeC0hZ6RMAyROONNPM6ERuD0zu8qcEUIiyjukjr7gK1TFoMgOvKg5Rx5jWKzte
	 C3q5Tolx1DWC+uzC5pF+ImYBca1REcDNRPAG5IrQ7LSQh8H/SIvuOY+xRzHDTEYMtOKFI
	 OjXAfKU+BxygdDYeGD22FyGGbfLh0QI38gr+M1nv6ZMeR6MV6zN+2uz8KMDKmgiYh0apr
	 yfrW5rmP3Rze0NBaamykw5BAZHNXIsdYbv8kXaPBrXX355aSFQlL5P8GRbB89dF6TNQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="w67Z/YZY";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DCC606A321
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 19:52:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7DCC606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w67Z/YZY
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3ad787b79ffso1641055a91.1
        for <git@vger.kernel.org>; Thu, 29 Oct 2026 12:52:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793303539; cv=none;
        d=google.com; s=arc-20260327;
        b=ftcxqAGKYadG2TA8wnA2/7jH0h4iGR/jMmQ74rLST6nVrfXg5Wfj0Hk9BbTctiKVYp
         5SPJBwTWe7nv4+K286Em7i8YaBu+g6QlGGA/l1e2f6QRWKN6pO6O48TMojqA4mIJTdUO
         XqaqKaht6fsJnj+UVv70lDMJ7mZnZenp8VCJMK5wUqCipUgaxGjeaKCNbxN1wWMyy6Ka
         S04q9ZcGE7yRQGmcHmVmjzqifKnSNEPCJZjyhvZ/WhwkuEUCj0dY56UDeqp9Vc0JKRGt
         ufA2vTv1wD1KToY/2PzU9QLE9X9/fnbdGqgWvONBhFRC/F8T84wDL4/Tz/4PPo6LZ4RU
         udFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=w8KRbL/5fDLf5ihJmuixp6rX3EvCCXYdR349ODGPuH8=;
        fh=hANhMzA4CSwTO8G+BmCYAcha4kczQCsL0YABiQGUDu0=;
        b=mWNtXmjmVFsut01GdIw9fle2SzHl1hzSUKfaeFCCrRqwu0uOTV6RGvbcXBn78bymxS
         W3eoLiU/AwVyLVPa31PW+Ndd6rYOMIbBDaZZwKkq+rSLi4aObkJMgi3/dt+hDf4a4qCw
         23L48s0rPXKVqJqU4ct/KIIMwYcRI6gebkQQLDruSk0Yi1uzVDM/nBU+pza2N5XBtHSA
         GrOs2bV77uLIpCryI156dAfO9xgS4BPCo8lnDL/JGcCy3JgKsQ+G3BEdusm2wNcG4TF5
         FQWlPGLIPJ5ptEpQ2jvvWW/StGLJVFj8GHueXefNhBWamyLqZDXlrWsZJIWxpshGwbrK
         YT4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793303539; x=1793908339; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=w8KRbL/5fDLf5ihJmuixp6rX3EvCCXYdR349ODGPuH8=;
        b=w67Z/YZYV0hW81C0vz4Ixy8kLHxUIcPowf1Xwo88S1LQISlZRmdnMvzrWt74j6OhJD
         OUJZtpBw9vCTK9wRCYbuonzAlz4u25Td3asJNmqckxWnIYnmU86O8OSujx0FEibyVQ84
         jM/hrgaTmDkcfTkc/WAOj6q61tA+ovvNtvxn9AmxF4vu4+ZAcNl0/w6GMtwYOf77GxMx
         gGiNr6oNit45rLeiKFxWS3GPU7rpMmeCm16o5WQcCpsIFThy4L9TqPgkWV81DyvkXDOJ
         bdx5/7D0K6waMfjxecpXuUG3v7W67XlbTZiiw6JSvVIwKymn0y6YYi6N2Go9F4AlMFo8
         n5FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793303539; x=1793908339;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=w8KRbL/5fDLf5ihJmuixp6rX3EvCCXYdR349ODGPuH8=;
        b=XkgCzV+udqMQ2oc23907CoZ+U2yZraFz44fjk8T4+elg1GWozoW3Qm3DNu/OQkuRIS
         MPl5zAGTGxiQj98sRWyWVxQlhRTk3sxSDnrQDnJGKBMLWOSrNUDYZaCkEqAmD9qCmApo
         HYc0REauOnPhX2WSCtAjILngaysj6TtKyLy84hAP2jBsl04Vg3Ts4O2IB/VK0tjViC/Y
         6X80BZLxcJ1VVZCyi1sNnlyFo2Pr4GvGunGlG9McpFcR8U/YhIHkyGhuaNz/yrYzVDR4
         PBEhUW1x5nXT1VL8KAwmXi3xsV9lpJAcXPHv2Fx1Qcm48LzPr8wO4XWSOPjlmpod1JWi
         GxhQ==
X-Gm-Message-State: AFq9FYKU7tfS8sDZH4DzE4FWaNjPbPSokpzAS1oikcoFc/Rm7GgqBenZ
	ERmaS5VdYCkDVUS04UcrufSykwccVqpcuKcoYD1bSpVBjhYtXRn/ZjlbqI5jmD47oQiqbSU5pAR
	knttfoHFfrzsx0SrLgKSvWouMG4A+hIWPgCJo
X-Gm-Gg: AYBFou0EKmOT+rZwA5+rPoEK+0b5zqozqe08mLtIKWLUl4c7vItSQxHUdgEd/NcfsEq
	JmP/4wDae0XEDe2oO2yV4Z2Vug/jcPXPB09cYT/YikvlmnTqFyqVdhP0Ecr5JsGBvAeRekph7kz
	RCjLI0jXZPz9Y8UT0Wjz6RSrOWwk34rtmeRVZIQSitcw82CC61WA6W6PQZMiMLuuA1TqTwMILck
	We6AD9V+oEVE7MtaTZy7YAfAJ+sHfwZA/XE3Z1YOO0w4sxFaxhdXIQEZtUt3fRMaZotKrP6GeC3
	hkVsurz7vqTp5SgHuw7uKDwa0SU0VvPaPcd0Q2IEd6w1UoSsFmDuY7x5aGePwh2ts+Wr1Lf8GQP
	NdDWvn+FIGx5pe2xf1NjCuAdWc3yVWQBGMg==
X-Received: by 2002:a17:90b:33c2:b0:3a7:a6bc:9d58 with SMTP id
 98e67ed59e1d1-3ae897e076cmr7826a91.54.1793303538978; Thu, 29 Oct 2026
 12:52:18 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Root <rootminus0x1@gmail.com>
Date: Thu, 29 Oct 2026 19:52:07 +0000
X-Gm-Features: AclHuK_Ok2A--fr5BSZCXgSkc6np6RzT7bVg9HLfxEgHfK0OeOQAKZlMMI0VEn4
Message-ID: <CAMtVYEjWd2XwJpXdk3PV2jbNdoOaqS3x+08EMu5byy55RxfRmA@mail.gmail.com>
Subject: [BUG] grep --recurse-submodules <tree> dies on a directory inside a submodule
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"

Hi,

Since Git 2.56.0, "git grep --recurse-submodules <pattern> <tree>"
dies when it reaches a directory inside a submodule:
    fatal: unable to read tree (<id of that directory's tree>)

The working-tree form ("git grep --recurse-submodules <pattern>") is
not affected, and neither is a submodule with no directories. Our CI
passed the same case on 2.55.0.

What did you do before the bug happened? (Steps to reproduce your issue)

    #!/bin/sh
    set -e
    work=$(mktemp -d)
    cd "$work"

    git init -q sub
    mkdir sub/dir
    echo hello >sub/top
    echo hello >sub/dir/nested
    git -C sub add top dir/nested
    git -C sub -c user.name=t -c user.email=t@t commit -qm sub

    git init -q super
    git -C super -c protocol.file.allow=always \
        submodule --quiet add "$work/sub" sub
    git -C super -c user.name=t -c user.email=t@t commit -qm super

    git -C super grep --recurse-submodules -e hello HEAD

What did you expect to happen? (Expected behavior)

    HEAD:sub/dir/nested:hello
    HEAD:sub/top:hello

What happened instead? (Actual behavior)

    fatal: unable to read tree (935cff11a11f8734cf4e0d40955d1e0e5c12038e)

with exit status 128. The id is that of the tree of sub/dir.

What's different between what you expected and what actually happened?

The search dies instead of listing the matches. It dies at the first
directory inside the submodule, so nothing in that submodule is
searched from there on.

Anything else you want to add:

It starts with 93cd344e34 (builtin/grep: stop registering submodule
ODB as source, 2026-09-11). Built from source (with NO_RUST=1), its
parent a532feba89 prints the expected output above, and 93cd344e34
dies with the same message and the same tree id.

In grep_tree(), each subdirectory is read from the superproject's
object database (builtin/grep.c line 656 in v2.56.0):
    data = odb_read_object(the_repository->objects,
                           &entry.oid, &type, &size);

The function's repository is opt->repo, and grep_submodule() sets that
to the submodule. grep_submodule() reads the submodule's root tree
from subrepo->objects, which is why a submodule with no directories is
searched correctly. Before 93cd344e34 the submodule's object database
was registered as a source of the main one, so the lookup above found
the tree there.

On v2.56.0, reading from repo->objects on that line instead makes the
reproduction print the expected output. I have not run the test suite
with that change.

grep_cache() reads sparse-directory index entries the same way, on
line 563:
    data = odb_read_object(the_repository->objects, &ce->oid, &type, &size);
I have not checked whether a submodule with a sparse index fails.

Both lines are unchanged on master, next and seen as of 2026-10-29.

We met this in CI: GitHub's ubuntu-22.04 runner image moved from git
2.55.0 to 2.56.0 between its 2026-10-12 and 2026-10-25 releases.

[System Info]
git version: git version 2.56.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
rust: enabled
feature: fsmonitor--daemon
gettext: enabled
libcurl: 7.81.0
zlib: 1.2.11
SHA-1: SHA1_DC
SHA-256: SHA256_BLK
default-ref-format: files
default-hash: sha1
uname: Linux 7.0.0-38-generic #38~24.04.4-Ubuntu SMP PREEMPT_DYNAMIC
Mon Sep 14 16:37:11 UTC 2 x86_64
compiler info: gnuc: 11.4
libc info: glibc: 2.35
$SHELL (typically, interactive shell): <unset>

(Ubuntu 22.04 in a container, git 2.56.0 from the git-core PPA; the
kernel line is the host's.)


[Enabled Hooks]
not run from a git repository - no hooks to show

I hope this helps fix the bug (if it is indeed a bug). Let me know if
you need any more

Regards
