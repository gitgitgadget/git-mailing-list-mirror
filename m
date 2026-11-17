Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794877658;
	b=DDYoETo89hY902pG/LnbCVb5bLk4eTAp0/NP7eAnFyrrdiqocPBrWdfAx8AJCBMo7qSO
	 m+V0YtYBuOqyVRX3J9NoWjGktUYYqk9Vko+er2H/xyvN1hynB99f8jetWy7kb/yvqmWC8
	 sp/7dFEtuOkA988CgJ4MdmDoMVwt1BSmD0ndxPyTAXe0iLpS+Jh/CMWZFX4aska3VNSna
	 vGS1eY36k8Ry9iPxksDp9xnXzxIrfYXkth+mQfQI+qwefU0WldBfyqrjyvvFct+SW4eq8
	 y2qrOO71MzHDyPqCT4VXFBYXmyZOLtcTWI0aJOGkGRPVuO77bfGKLhBdZ3sORyYbkJg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794877658;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Content-Type;
	bh=vL/8+kX6Z6hSF3fZFGloUmchhj1ZGP/B1vuR0u9ACko=;
	b=WcQZ2TPHzSEsW/mxG1OW7MHeI9CmNDXqSMTVMmGsvmsbnu278z9OsLObo+9nVrkSRq+n
	 EvaBlX9hG9Px7xGtpdBiW0FBe3UMSszJHRIw5W/WS9OwY9F+IRIN9JRKVNq0PIkN06HQq
	 ezAW/PR/9HoJ0FZINFLG8g7UkkIiQM94+NcCHo0Ko8porhuAzScc5SJrkByREjzNpWrLz
	 j3+d2SWAgGleRvLNJGeosbWeJbmoULp1V7Kw7dzRiFxu1OEAEgGu6iw1ZOAYIePYoZpBV
	 HxOqffML0Likf+zni2ZklrwZ1mYZkktdTzHM9qyXm9zzxB3ytzv6CUX37s1TkzMDfZg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="KvI9/gbA";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.179
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E226606A31C
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 01:07:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E226606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KvI9/gbA
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-8b4cc793704so17475357b3.2
        for <git@vger.kernel.org>; Mon, 16 Nov 2026 17:07:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794877657; cv=none;
        d=google.com; s=arc-20260327;
        b=Q4WE2vmr7e65yfPPyDTQz5J5nDorjqOJbiI1pYbOpHFV9pLdRuDrtbrBdtpHSiowfg
         tFCQENdlr2GPAGM4A+MKB4WuHV9ErubpMc7FDBSzLhKWgIW5n7ncnZr9R4CUMixqdMet
         8hTuQkrundNrvfqMqPpurKAEKWpkwGCGd4DjtP/m3QhxDUWil8sRYH/Uv1Vd7mZA8yaw
         f46TYJNNsKBLxUJelvUOkHbYklD8KdnCP3afmHNDPduKzIJIszKoZNIVsQ9jpurhl5EM
         wisjCueWZuXIuuwHQc3QhBzdh+api+GeFvE7Neu/rjI632Npz43klWndbo4BNN+FlsUl
         MmRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=vL/8+kX6Z6hSF3fZFGloUmchhj1ZGP/B1vuR0u9ACko=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=LkG5sOPN+fg9Dp5HavhWX8uXq44Fv2qJ4DeniQMhk9nk7AyIzSc1sUcGzQtbC8GU/g
         +PeyZBmIrD/P65pg+4o0IkWDz1gBhpNSn6ebAphlTayIzfhh9nPLFn4QEh8pT5tG5Lp3
         XcONKBUz9c9WNX/1GgXX9FywW6tZWX2Y+9CqYW57DtoaMsr73iXNlhRPDxAFgmbMrKn6
         w3Rg84P5tJ0Vx+mjCOfznUSOjPi7estqQoGExPSXZEZ62i2Zr9Ut35dnv6I3UDZ2/MKS
         V6lRvihCLvBUALJiFZ23hHN2NmzafANgAI05Fxq6YlXg8PoW62yheAI+FsZ+S6M7X0mN
         fNwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794877657; x=1795482457; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=vL/8+kX6Z6hSF3fZFGloUmchhj1ZGP/B1vuR0u9ACko=;
        b=KvI9/gbAsFQStUAg+/LhxVcZMabiqUVKVvomm6KxunCsrPxSJxewyhMjA0DUGDJVN1
         1cS16ugjXt72ACClEYOEbz4EMsw/OnRanaCZ/czmU+7woZrWZe+Dj5F5ZzSrpgbGJim5
         bgzgmVxGTTSN4D//gWAYMxahBiq/x+/4ZrTQ2XsanenWgxMWJdD+WlSqIUF68DYofyNz
         NzuTRzW1f83WG/qNa0Bm2jarD2/OsDbZVSxVy1kxISNGKeJ7HHrIEhMWXLI1jcxS41DQ
         Y9HPsDg1yTVOs3AlNSge/Zs+Hlo4S8JYWQ2ATomKrsprqgzC+rjv5Ae6wTnQ6WZALRmz
         sdAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794877657; x=1795482457;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vL/8+kX6Z6hSF3fZFGloUmchhj1ZGP/B1vuR0u9ACko=;
        b=OZZvkPtQBY8A8dg5Z8pLGhzm6mSaaKXpUecf1fXIUvOdk4Vesi8kfS5sjJbISWZl2f
         5EM6Kr0O1j23ekrHn8FEWq+/c0iSgpWVkK9L6fFgn0huVbaKy8X2utb3FlvEgT2qet9o
         ijwmhCngtWe0Vu6uGU7mwYaWnqEZyf/tpqrvqESeSHLNScA4VfAzeTqVvWtqQ8E/Rr62
         Ztq0Urj+lseiWESerc+dGZVbRc58cNn5UNbHWrNxD4gFyWBZyDeTCu8uhhwi8+wdK0Bd
         hwr0WK63hZdnToUwPX67/U8UZIHYyB5OdrOvMLeVgb09vsU/qvomWE95Ez9fiLUeMYHg
         t8rg==
X-Gm-Message-State: APuU4Z9saSGWsP1PuRRRLDNH03gUfqnr+b0ajcmRKQiaKkxDuDXlOEw9
	dx4OAUv+XzTPgNza8iyjZFN7jzlker5gCVVt2ul6j60w7FPA3nv32/ThtWVVw4ZXOXVJh3NK0Eu
	fJ00qvQnbKHLh1udkLQji2FX7zCmGciFlzKsq
X-Gm-Gg: AZFdTZfcD0gulYq6lomqtQmTNkshAn1PjZ+8ov8swICo0H3jZYgOddIZM9qNfrS/i6z
	8oUPTP06q12KHOAtValI7lw8sROdKA/+7T3bcAvenNi8wXEljb9/SzJrWPh+CN0JjvYJ6y+FyzH
	GNia6PVdTQ4StMeoOgT0oBaPGkECNE5JYMjW2j4y8cmU/cWgkk3TCCqDo6oIhTagbIvStm++x1L
	V0heAvxdVNUG2QlZgH1Wx41XJ3LAskio26bYBaC9gm59CxU8UdhQDSNsBzXEwXs3k7wvLhB4X4W
	d4Ag8RzHgp2f5B5/8SB6Exym5kRZRlH7YP1A7nMg0wQYLPqya7uFnW0Cy+Uemj+aRiNbYDZNtnZ
	CEmdb3dzGgYZMmxb6AshuW/NsF6r16g/Rs+1b0AodX3++T5EvCkq7N1LEYrQFBO55QOXrOxsxIJ
	F8qVZOM8f4jsL29W5bnIelnV0hqdUGYAwwXhBpSe4FIfh6agQvdg==
X-Received: by 2002:a53:de4e:0:b0:67b:ff8e:33c7 with SMTP id
 956f58d0204a3-67d897663b9mr4101781d50.143.1794877657222; Mon, 16 Nov 2026
 17:07:37 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: wheakerd <wheakerd@gmail.com>
Date: Mon, 16 Nov 2026 17:07:25 -0800
X-Gm-Features: AclHuK99o8Ro87Nxlj6-QpAjT3VJD-n5S1EBJKzF4SKQhz9qENLRNT818hhkfEI
Message-ID: <CAFJdCSutexXts8ZUkwdzgyTn61qM97v=eD_ivm+zjt4=L8FkxQ@mail.gmail.com>
Subject: [BUG] push: a remote group that lists a remote of its own name makes
 "git push <name>" recurse
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

What did you do before the bug happened? (Steps to reproduce your issue)

  git init -q -b main client
  git init -q --bare -b main a.git
  git init -q --bare -b main b.git
  git -C client commit -q --allow-empty -m base
  git -C client remote add origin ../a.git
  git -C client remote add member ../b.git
  git -C client config remotes.origin "origin member"
  timeout -s KILL 12 git -C client push origin refs/heads/main:refs/heads/main

  Caution: the last command starts several thousand nested "git push"
  processes. Please keep the time limit.

What did you expect to happen? (Expected behavior)

  Either one push to the remote "origin" and one to "member", or an error
  that says a group must not contain its own name.

What happened instead? (Actual behavior)

  The command prints "Pushing to origin" again and again and starts one
  nested "git push origin" per line. In a 12-second run it printed that
  line 5,945 times, and I sampled up to 5,898 "git" processes alive at the
  same time. Once the nesting stops growing, each level reports "error:
  could not push to origin", then prints "Pushing to member" and pushes to
  member. When the 12 seconds were over, b.git had received main, and
  a.git, the repository that the remote "origin" names, had no ref.

  An earlier run without a time limit ended by itself with exit status 1.
  I did not measure how long it took. There, too, the other member had
  received the push and the repository of the remote "origin" had not.

What's different between what you expected and what actually happened?

  The remote that has the same name as the group is never pushed to, the
  other member is pushed to once per nesting level, and the number of
  processes is limited only by whatever makes the deepest child fail.

Anything else you want to add:

  Reading v2.56.0: push_multiple() in builtin/push.c runs
  "git push <member>" as a child process for every member of the group,
  and add_remote_or_group() in remote.c resolves a name as a group first
  when remotes.<name> exists. The child for the member "origin" therefore
  expands the same group again. On 2026-11-15 the two functions read
  the same way on master, and push_multiple() on next and seen still
  runs one child per member without a guard. I did not run the
  reproduction on anything newer than 2.56.0.

  "git push <group>" is new in 2.55.0. t/t5566-push-group.sh has no case
  for a group that contains its own name, and git-push(1) does not
  mention one.

  The fetch side has an older report of the same cycle:

    Fwd: Runaway "git remote" if group definition contains a remote by
    the same name
    https://mail-archive.com/git@vger.kernel.org/msg41422.html

  Alex Riesen first sent it on 2010-11-17 and re-posted it on
  2013-12-28, with

    git -c remotes.origin='origin other' remote update origin

  as the reproduction. Jeff King's reply names the reference cycle and
  sketches a fix: expand groups in one process, tell the child
  processes not to expand again, and detect cycles. I found no patch in
  that thread, and fetch_multiple() in builtin/fetch.c on master passes
  no such option to its children.

  A group named like one of its members is easy to write by accident, for
  example remotes.origin = "origin backup" to mean "origin and its
  backup".

[System Info]
git version:
git version 2.56.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
rust: disabled
feature: fsmonitor--daemon
uname: Linux 7.2.11-200.fc44.x86_64 x86_64

[Enabled Hooks]
none in the reproduction repository
