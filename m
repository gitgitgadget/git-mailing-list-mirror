Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794897147;
	b=pEZMEEOM9nHFFLxq+mc4K22in2odXNpFcKyOpDvlMkNO84xDTYHfPaQREATfcXGCowWJ
	 8I4R1xN025o2u8Npq/lMc+3JNVvjRnoAxeFp4sxon3N7YBv8r3om/xQFOsXMMI1rtUnZu
	 hyl1yF4puxRaHHK1Oq7ad1jiKKAFjMg0gdc+rIM67lCyp/D9RdFooBH+OQsD3tX1lSPr+
	 SiEM1QAPqVTs+xBzt2vxE+uh9C9D/MLljy7gBlSd2Ha8YWep8bJsBD24XQAIvt1hFOa78
	 ImVTvxMd6BQHrPnd7OyUhFjQnTSk84MAvCfzGhwOnesg933sZfPrtz6SVpFdPekUTtA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794897147;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Content-Type;
	bh=ywxWPI3YQtERvK7Wmui6QGwak19xmvZHtCibhwqvX3k=;
	b=aCMgD/UOa3sphz31OzIoKIwCWruUaZT6nBUf7ElkYcclUhuQovRkq4SLufWqOLqvP9EP
	 4n9c9vNCQrCXl69+Qh3opDbmZe+SwPKR7XaqbDBI3zktaKdag6HtpzxvCOy1cvqmajtEJ
	 TNyEagW1keAv2EY4aWMUoM2q/JpNsYgbJf9ec8cBRgoNSj2lgkQ/1VOGJWkZUT/G5nwao
	 krLVx1wjmhorkJTMjn7m4OIIRrdIlI5E5oVgbVxoeScNt8NHZQ2++cKBYkw3mKRrwIGqb
	 8bD+ifyqCh6AoHWzPYSM/HNmbYsJFQAGBYgM0TuAs8blmt6k8qnRcyEDGLJjqchUURg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=theorem.dev;
	spf=pass smtp.mailfrom=theorem.dev;
	dkim=pass header.d=theorem-dev.20260707.gappssmtp.com header.i=@theorem-dev.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=mxZAiT3p;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.43
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF341606A31C
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 06:32:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF341606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=theorem.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=theorem.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=theorem-dev.20260707.gappssmtp.com header.i=@theorem-dev.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=mxZAiT3p
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6b570ff3dfdso4290192a12.3
        for <git@vger.kernel.org>; Mon, 16 Nov 2026 22:32:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794897145; cv=none;
        d=google.com; s=arc-20260327;
        b=Lsav9KkpznknTs2DkNOJ80rf/WV/B5Zq5k0WHNFyA6thn1rzBbOFyDfsm1xdTaA0am
         mtd8StRbH8Gvx5Nwd0WxP1JWJ+LpF9VN29UABgRLtZKZ81Jq9gEyv2JsWMMJoG5sDaX4
         VdF2j9in54dKROnjabQUlbJ6p0Zks73a7dLZ2DiBBoGGoRc0Fbd6RiUoumWZiB320VyV
         o9kDMzVRpmibkHXZ0vptM3i/aiH2Ym2Fre7emjdIlJKev3i4cDl/WcVTAFg8iP9J5pcy
         pjWCJjbEmqYhuU0Ro90pvjyF3DUNUf/gmftMdOzX11RQNdD11jajInV+MP6besw/O9G1
         LnFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=ywxWPI3YQtERvK7Wmui6QGwak19xmvZHtCibhwqvX3k=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=lWCy+MnEBhfi545MyImUCv4/ELw+OBXRutmjvn1v+WoTCMpZhygkf9trlUY7pPUhHM
         M6IeE07uPB+qUggd0CVHPniJzXN0DzqPXCYlBA6QHnflN12O3JumePq6b6cMewachXDA
         Gxg9muuzKxgV5Y3oUXqSSiJfSN/iSrAV0ht+WlXdQMwqg8XhUQoRdgM/zSbGgqQmQvsw
         JEjWx/LNZV4fYPuOpl4XlxGuFQpS3eGwoD7qt9scGGYvZLgqHoPOs7Q11aVazOgEx8cX
         Ih7GDa5fY+jLNTO3kcqpy07hVyAgs4HCk1Au4jzvL/rozvzF+uW096m1eVvn/eQku11r
         JM9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=theorem-dev.20260707.gappssmtp.com; s=20260707; t=1794897145; x=1795501945; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ywxWPI3YQtERvK7Wmui6QGwak19xmvZHtCibhwqvX3k=;
        b=mxZAiT3pDLfe8mnt3O+dZsg5UJBl3c8F9lgLh7Mvk8bhdpBFdk0PIkS1fmlys/LRiR
         bNg7+RSv7tT51UX98HVxFTXHf8c1xzu8ygbsDYgncRlfilYJ6xj6j6yld5kXWvy44Lqo
         dVHIUoMFYdYV9GorinCH0kurXrQPgW3tJlFF93qJ79h1UUoK119w8aZH7C/Bni4B/A1p
         4zz1/s5LrhzZWQkFKdUEq2UBFFNwgTUlndSl+d605RSMaS3i9893uQY/KC8N5mJNcwJi
         mJ/18I94z56539YnJzTTKMyoWqDAJpezWRNBeaQz4wJTG4OZqwQgLX1i4YE41NodQK4H
         pUOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794897145; x=1795501945;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ywxWPI3YQtERvK7Wmui6QGwak19xmvZHtCibhwqvX3k=;
        b=PJVSdG1YZorBWIVFhUIJQsDS9r/jzWPkluPoyJUEpQ8jv9ySWSVb9dvpKWhkIn/jxn
         zjmma6OkSH5rOPDbaAc3XgJX0//fHutVe/t+qRri22oj9AU+LaecAWEtNr391ZzkZ4bD
         kmXLC7HKib5wQI3CFiAYCiQODudpPtpC16fNXCF4KK+hEEtBarASHlstKLFkpYPzQRry
         l5tQaa1PdjahPsR+8zc60RpWWJ6cToSAjshEwnxD397Wi1tqAgAUDZ4lcvgdbvoVqnKc
         8B27RT0Cny4j8dDsLt2jqZJH2rVFcBZW2WhylzQIimoZAxGMeUYXCCUg1CXiqeu6i+jw
         6feA==
X-Gm-Message-State: APuU4Z+urY+ErkJriFifiW7qSK3pGd8O9avPkymC1wWNNDnUAK1fXPiq
	8C1G1mOTrwBEwa4c+OnyVyjQnmnQ01ikthRjGz4thBYfHNIGebdR7bHuvOF8gwCYPoahaNSoxxC
	WNcXHIx61NJEuEnkN0syL9h/4N4drw9e5YrGlYu0bcDzdWByECyjb
X-Gm-Gg: AYBFou25Squ5alytHDMeDBBLkLgBnbfgVU46RAUfPpK+7dmQMDouDgFLS92ag06O2E8
	i50gorMNO6JOIRQ2xOvrzNXfSLsCxNOPS2ruyQaaXrGjlNJFoxmJIbWb7QwTgShvdWB/PME0iOk
	YhHihK68X6bRoMC6t70NrqPdlosRDwBYG1C51dw76yRcN8G3pT/WArJEiUWgxKg074R5UJrucVU
	/3kPOlYIYxTxpvAXCfRjwD7iFBRLYWrdFSEUfckx4RoG/DCHattxVwjygtGVN90zycqoeK3Ee1j
	+qes2rDAthxfSaDyFAo8ua+Z3QKtaSKT2eqaHT/0tussVrysooDgNEk21jRketdxia3AvKDs9qF
	CDuo6Mg4+zWsTdFALkGVdO2+pybRrq1qF3bH3Bo41Si8kpHpHusdPQ+yQlQ==
X-Received: by 2002:a05:6402:2811:b0:6b7:a357:375b with SMTP id
 4fb4d7f45d1cf-6b7c0d226ebmr8933916a12.40.1794897144938; Mon, 16 Nov 2026
 22:32:24 -0800 (PST)
Received: from 410317164191 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 17 Nov 2026 01:32:23 -0500
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Sami Jawhar <sami@theorem.dev>
Date: Tue, 17 Nov 2026 01:32:23 -0500
X-Gm-Features: AclHuK-iPlp8w3BesHWNYCnfpfRZiprsAUCjWMZgh0PjhyPsgJI4pNE8MFAF_VA
Message-ID: <CAOJ8FdczW9KxFknceHodV0jmhyEB24OMtqQUmhkP3E2vfsmgag@mail.gmail.com>
Subject: [BUG] combine-diff: wrong deletion columns at 33 parents, no hunks at 64
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

What did you do before the bug happened? (Steps to reproduce your issue)

I ran git diff-tree --cc -U0 on octopus merges with 32, 33, 63 and 64
parents. Save this script as repro.sh:

    #!/bin/sh
    # usage: repro.sh N
    set -eu
    n=$1
    lines=$((10 * n + 20))
    dir=octopus-$n
    rm -rf "$dir"
    git init -q "$dir"
    cd "$dir"
    export GIT_AUTHOR_NAME=t GIT_AUTHOR_EMAIL=t@example.com
    export GIT_COMMITTER_NAME=t GIT_COMMITTER_EMAIL=t@example.com
    file() { # FIRST_LINE SIDE...: "side <i>" goes after line 10*i+10
        first=$1; shift
        echo "$first"
        k=2
        while [ "$k" -le "$lines" ]; do
            echo "line $k"
            for side in "$@"; do
                [ "$k" -eq $((10 * side + 10)) ] && echo "side $side"
            done
            k=$((k + 1))
        done
    }
    commit() { # MESSAGE PARENT... < content
        blob=$(git hash-object -w --stdin)
        tree=$(printf '100644 blob %s\tf.txt\n' "$blob" | git mktree)
        message=$1; shift
        for parent in "$@"; do set -- "$@" -p "$parent"; shift; done
        git commit-tree "$tree" "$@" -m "$message"
    }
    base=$(file "line 1" | commit base)
    parents= all=
    i=0
    while [ "$i" -lt "$n" ]; do
        first="line 1"
        { [ "$i" -eq 1 ] || [ "$i" -eq $((n - 1)) ]; } && first="removed line"
        parents="$parents $(file "$first" "$i" | commit "side $i" "$base")"
        all="$all $i"
        i=$((i + 1))
    done
    merge=$({ file "line 1" $all; echo "merge-only line"; } | commit
octopus $parents)
    echo "merge of $n parents"
    echo "lines showing \"merge-only line\":" \
        "$(git diff-tree --cc -U0 "$merge" | grep -c 'merge-only line')"
    git diff-tree --cc -U0 "$merge" | awk -v n="$n" '
        function check() {
            if (!open) return
            for (p = 1; p <= n; p++) if (got[p] != want[p]) {
                printf "hunk %s: parent %d: header says %d line(s),
body shows %d\n",
                    header, p, want[p], got[p]; bad++ }
        }
        /^@@@/ { check(); open = 1; header = $(n + 2); split($0, f, " ")
                 for (p = 1; p <= n; p++) {
                     split(substr(f[p + 1], 2), r, ",")
                     want[p] = (r[2] == "" ? 1 : r[2]); got[p] = 0 }
                 next }
        open { m = substr($0, 1, n); lost = index(m, "-") > 0
               for (p = 1; p <= n; p++) {
                   c = substr(m, p, 1)
                   if (c == "-" || (!lost && c == " ")) got[p]++ } }
        END { check(); if (!bad) print "every hunk agrees with its header" }'

From an empty directory, run:

    for n in 32 33 63 64; do
        sh repro.sh "$n"
    done

What did you expect to happen? (Expected behavior)

Each hunk body should agree with its header, and "merge-only line"
should appear in the diff.

What happened instead? (Actual behavior)

Git 2.43.0 and master at e1ec09b23c8e print identical output:

    merge of 32 parents
    lines showing "merge-only line": 1
    every hunk agrees with its header
    merge of 33 parents
    lines showing "merge-only line": 1
    hunk +1,1: parent 1: header says 1 line(s), body shows 2
    merge of 63 parents
    lines showing "merge-only line": 1
    hunk +1,1: parent 31: header says 1 line(s), body shows 2
    merge of 64 parents
    lines showing "merge-only line": 0
    every hunk agrees with its header

At 64 parents the diff has no hunks, so the script's final "every hunk"
message does not indicate success.

What's different between what you expected and what actually happened?

At 33 parents, "removed line" is present in parents 2 and 33, but the
diff marks its deletion in columns 1 and 2. At 63 parents, the line is
present in parents 2 and 63, but the diff marks columns 2 and 31.

In e1ec09b23c8e, coalesce_lines() at combine-diff.c:249 has:

    baseend->parent_map |= 1<<parent;

parent_map is unsigned long, but 1<<parent shifts an int.

give_context():544-545, make_hunks():610-611 and dump_sline():756 also
use 1UL<<num_parent. At 64 parents, this shifts by 64, the width of
unsigned long in both builds.

[System Info]
Ubuntu 24.04.5 LTS, Linux x86_64, sizeof-long: 8
git version 2.43.0
git version 2.56.GIT
built from commit: e1ec09b23c8e0deb21a0b95ac5996422277395d4
