Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792577822;
	b=pWxT9KdEM8nH1rupqqUN7/xpsOhufcMRfZayv7E2esJhGwF/YcLjkIobYvXBIJiXtXVi
	 5rD3vhdTQBydkTRCJyahnAJd/thDZ3fxaVFiUuGTqQNPVSJw8uZEvAfUdGE4svbSJRjsQ
	 rzrwpM/Q7CLoES+T/eizax7vTiHnXDDt1/Q7HkKr+DnNhKopCrQhDmteB1OLRnjJwaulO
	 oUjXonfKuD+MKx87hjzMiUrvkt+mjliPJlwbXrlp+fantfXseL5+GRlEigCLVjcspiwoH
	 JQk35LWYtyJ3VWPbu6t4cA1o+HBfZnqdZZ0oBz1vJlxN5Wjn4TeFFagwfjasq+OBnlw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792577822;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=s3Fj8YjPSTupXjt++Rpzf/NllSuxV3tkJe41ws9RWGQ=;
	b=efalYuIMnha7gRzUnrpRh+ZdydjlCZr+vIYu0p0BgQQ+HCHx16oqa0XKfmpJShYZsnPH
	 KUj7NPmNr8ABrEuiZOk1uOLfuxeNGU/vDRDz6rgeCgzxjYZSoqV/FGHQTItuZwKUqW/Fe
	 EcwrEsY82H3AYeBcRz31Vhjx5avm9KYHxegpbo4ewdUfztIhTl1G0++ehzF/XsUCmZuZQ
	 aoh6Pi79SSMsDn05zrOp/kfSoHyXHxq4UU0vvO3IwBBIp3KoBQIXRlv3GtdOScBBvZ28n
	 4/7AeWX3ZiojlBWjSzKgtNi6lKU28qDxJSM91ayDufdcXfemJYLHsa9TeJgi8qQyQAg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AFLHt23S;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.44
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA8E606A31B
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 10:17:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BA8E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AFLHt23S
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-499f20c7054so324789fac.0
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 03:17:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792577821; cv=none;
        d=google.com; s=arc-20260327;
        b=FC6BlEHcvEpDcPG40qpNrkW7D62JNQ5jjh0voQwRAh7XuglHgqZbOLGKB5x1YzUylU
         B+efb+mALg+plp2X7jWcS0xpX6E69oR3l7/zIk+J6mjkMzJCQYYL3uDsL9vCrpYExIIb
         TjhZe7cCVmuYdSmHQigJnacSyb99A0rb9PvG/0s1Z/WLcE9we7y1rmUI276K+Vbb/E7T
         YZasC7WofTmFWbCTlVWWCyJtel7/A7xTDuJzwI3JkmEuZT3gUnHNJGNkuSBHO3YVdvfe
         NDmoNLj9kl2Cx6o0BtuG1o3kqiAmPgbuxsZbcDflfJkGwVHadpmp7mfxZPp6p8zvmfQU
         yMYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=s3Fj8YjPSTupXjt++Rpzf/NllSuxV3tkJe41ws9RWGQ=;
        fh=vZuVgrM2LTXIgjvGDmtDKG97BDUBBwkhOkEbhTFC0+A=;
        b=TGq4BzaVkluTUnrpBWR5Ch57AX79vQoIS+B0EAYHE3y7NEkyB6JqTI40HDGe9LW/yK
         aXmizJ7swN30MQwQd1ubxJSyVjsXbuFbGiQCY8oo3VdvefCDX60D3/ojgbk7K+1cOxxo
         0BDCYCuKrvM+dEJ6DjpAGj1Apq9njUtHLEv46VQcInjyhe+cCO6I4p7g4gF5s7yHrLRE
         dmlM4e+Ul3PJId4mYes/bvXpYyZO81/+IBvsBrkzo345mvh3pT2xOZ03DAXKLNJk3q4V
         +mf2h0DQVNc8A8BXn308M5mBRytm+FAQq/EeieBJ261kuIGuxj52AuLse8prLI+QzXvt
         zOlQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792577821; x=1793182621; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=s3Fj8YjPSTupXjt++Rpzf/NllSuxV3tkJe41ws9RWGQ=;
        b=AFLHt23SaoD8GZPhUl+oXa6dKBY6Tx2gjP4aMDiM1MyRlg3RXQw7wAB3xEXvoGQzDl
         VFUTH7B0q2DqxpQhqCwbnbzWlAFMHD9Rezzwzactv4p6/w/+j8lhln5sWdoFCIIj/a55
         XNpYi+f9smer++fQ535ulU1UhMuelubO+DYEaGvdR9rH7ckQqf3WZsiWwa0Ejat1Tld1
         tOrScj6eSVwCR+oE1SeY+tJQNRVj5Uz8FaHFA4kf4QyhvKmNDQZzTt4o1paF5fpV2V7A
         Umt6F3JY/o5rABruAO3cbywlXr1ki53e0uP1Oo0NhQ8AW1VjdAHRyHiR6fUmYVYDJaiR
         wyLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792577821; x=1793182621;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=s3Fj8YjPSTupXjt++Rpzf/NllSuxV3tkJe41ws9RWGQ=;
        b=etx6lR7z2/FitK90AT+6a/7mWqIk+DVLWqp5ThWJ6o1UPuoE2kCctHAa2yK1ydbF/v
         LiA+auL1n76LjMbig+c8Kli8PKw9fOSbFtyngwEA8DGCQXmk5FyMyhuu9KOiWrFNLX/m
         n9MDKgo7Bc5Gt7PJ1ntYpoQrOPQ3KXRA+FRYJxzHOxez+Tiwebfk0/bZEz/6Wpi2F1Wd
         LZVTYhFHkLBIfLxyEcUKJNyTDyQGneURUUSYcVpkMMo9wTUDAq4VedUP+M56JKYxz/VV
         aDlF25IF26QiXJRsfLimOaYfPxT73UEpn2tU9+UP8+ab3NgGRIgw1+xg2A+W9FD3cbbU
         8S1g==
X-Gm-Message-State: AFq9FYJsHftjCe+yw2pnRX1RoeKeRAwl8Y+F+hundnH1orgvjxyoNZjQ
	DIU2P6vSOlSPRhPNNH4awezdxeJNZGn9vkbFdOpDrMqzTd1CKjBufn3/TpHtx/mr+LUoUqsBOBi
	bjwZh/D7VFZbHzw3xmkskrZseDI/whVKPY0O2
X-Gm-Gg: AYBFou0C8AIvWRG+9bg5nbFjxFH0q0QLFDVa+T/lESygux6FW0mTUB+iTgMDoW39cyl
	HPomwdIjd51H9jwTFiLlc25cn3Jf44R9pEK2FKIOueVALUcFcOBwYPyzni9AO01KTMHaDV5Cl6E
	bAFIOwnFYp4+burBd3N9qOJRrf3rcX3YeiJkbXgtN4BS/t4t+hOpOxMCL3+nrPa7KEal/8xTpiG
	cgfuVt5WV/9vps13otPZXhFZfrK20rk7Jn5xV97rrXjYQhuWrFZ+wIdcZDygPXb6B1PfLbNdD9Q
	RnhBSbrvxqVLzBZckQZW2mFWcT7vUacNlBAp5+z4vsdCumlpueTfivJr4ahtqnHJjmwkqtIzg8I
	57b5QassXYxnXLF6xJOjAw8xcK9eSmKxNkM0OUA1aEHdHiXwbpGqs5A98TGwBs+0=
X-Received: by 2002:a05:6870:334d:b0:48f:e107:3179 with SMTP id
 586e51a60fabf-4a7dc27e1a4mr878756fac.44.1792577821133; Wed, 21 Oct 2026
 03:17:01 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Masaya Kazama <miyaokamiyao@gmail.com>
Date: Wed, 21 Oct 2026 19:16:48 +0900
X-Gm-Features: AclHuK9_B4m4fDrrbhzYFe1msweJnkcG_9_o-vdiCwx9eT7EpD0BG3H7QOCGmvE
Message-ID: <CAEdWB0ChxOZUszwDVqWY3jdvGpNtV9NRTG8_X1-f2PX9QnJQTw@mail.gmail.com>
Subject: maintenance: stale maintenance.lock after the detached child is
 killed silently disables auto-maintenance (more likely since 2.55)
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>, 
	Derrick Stolee <stolee@gmail.com>, =?UTF-8?B?5YiY6ZKf5Y2a?= <liuzhongbo.gg@gmail.com>
Content-Type: text/plain; charset="UTF-8"

[Resending as plain text; the first attempt was rejected by vger for
containing an HTML part. Sorry for the duplicate to those on Cc.]

Hi,

Since 6e95b07e5f (builtin/maintenance: fix locking with "--detach",
2026-05-13), the detached "git maintenance" child owns
objects/maintenance.lock until its background tasks finish. If that
child is killed in a way that skips the tempfile cleanup (SIGKILL,
power loss), the lock stays forever. Every later
"git maintenance run --auto" then finds the lock and returns without
running anything and without any message, so auto-maintenance stops
for good and nobody notices.

The stale lock itself was reported in 2024 [1], where Stolee called it
"unfortunately a common occurrence". What is new is that 6e95b07e5f
extends the window in which the lock is held from the foreground phase
to the whole background run, so a kill during the (possibly long)
background tasks now leaves the lock behind. Before 6e95b07e5f the
parent removed the lock when it exited right after daemonizing.

Reproduction (git 2.56.0 on macOS; same FIFO trick as Taylor's test in
the "fix locking with --detach" discussion [2]):

    git init -q repro && cd repro
    git commit -q --allow-empty -m base
    git config maintenance.auto false
    git remote add origin /does/not/exist
    git config remote.origin.uploadpack \
        "echo \$PPID >\"$PWD/fetch.pid\" && cat \"$PWD/fifo\""
    mkfifo fifo

    git maintenance run --task=prefetch --detach
    while ! test -s fetch.pid; do sleep 0.1; done
    daemon=$(ps -o ppid= -p "$(cat fetch.pid)" | tr -d ' ')

    kill -9 "$daemon"
    : >fifo
    ls .git/objects/maintenance.lock      # still there

    GIT_TRACE2_EVENT="$PWD/trace" \
        git -c maintenance.loose-objects.auto=1 \
        maintenance run --auto --task=loose-objects
    grep -c '"region_enter".*"category":"maintenance"' trace   # 0

    git maintenance run --no-quiet --task=pack-refs
    # warning: lock file '.git/objects/maintenance' exists,
    #          skipping maintenance

After "rm .git/objects/maintenance.lock" the same --auto run enters one
maintenance region. With Apple Git 2.50.1 (before 6e95b07e5f) the lock
is already gone while the detached child runs, so killing it leaves
nothing behind.

How I hit it: in one large partial clone (blob:none, ~425 branches)
the lock was created on 2026-06-30, a few minutes after I upgraded to
2.55.0, and stayed until I found it on 2026-10-21. I do not know what
killed the detached child; no git crash reports exist for that day.
During those four months a GUI tool fetched the repository every
minute; the pack count grew to 3,550 and the packs to 13.9 GB. Almost
all of it was duplication: "count-objects -v" reported 94 million
in-pack entries, but only 1.46 million remained after a manual
"git maintenance run", which brought the packs down to 0.68 GB (GitHub
reports about 0.4 GB for the repository). The commit-graph stayed at
its April state, which made "git log --topo-order" over all refs take
seconds. Two other repositories on the same machine had the same stale
lock, created on 2026-09-29 and 2026-10-04; both are regular
(non-partial) clones, so partial clone is not a condition; it likely
made the packs pile up faster, since every promisor fetch is kept as a
pack. Other projects report the same symptom, e.g. [3] (auto gc
"silently disabled for a week") and [4].

A note on core.lockfilePid: it cannot simply be used to detect a stale
maintenance.lock. With 2.56.0 and core.lockfilePid=true, while the
detached child is alive, maintenance~pid.lock contains the pid of the
parent, which has already exited. A liveness check based on that file
would treat a live lock as stale.

Some options, roughly from least to most work (I have not tried to
implement any of them):

 - When "maintenance run --auto" skips because of the lock, leave a
   trace that a user can find later (for example like the gc.log that
   a daemonized "git gc --auto" leaves), instead of returning silently.

 - Record the pid and hostname of the actual holder (the detached
   child) and ignore the lock when that process is gone on the same
   host, like lock_repo_for_gc() does for gc.pid.

 - Use an OS-level lock that is released when the process dies, as
   suggested in [1].

Thanks,
miyaoka

[1]
https://lore.kernel.org/git/CAN477tHJnVnOKfUsG5G9QAVdzYvmUuC8A8Vxt8mtHB23fd=hAQ@mail.gmail.com/
[2]
https://lore.kernel.org/git/20260511201049.GB22912@coredump.intra.peff.net/
[3] https://github.com/craigoley/remudero/pull/9555
[4] https://github.com/solidDoWant/vault-sync/pull/115
