Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E109339378
	for <git@vger.kernel.org>; Sun, 30 Aug 2026 21:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788126984; cv=none; b=DgU9E92arDfRgRz5TjiITz/vAbKJ5pFsPITLKDfM2AyTBvE4XVt1xgayK8sMBLlpkywW9gVm+DfTiCrk4fM66IhtRgZRlbRnf8i1QzqppcSFYdplDfkjN/uRFThySp6TFkq1kLQUJuW0aBvJZnrvzHV58XLrvTKMfkDoFg2VaLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788126984; c=relaxed/simple;
	bh=9Jx5mpGDTubTbjUyzQb3Xr0oh+CWA4bxXy5p1LtwI5A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lUHkLjrioB1OxKW3GW5I5625zKMUMAGWqZKKHDL031y6FXVMExrXRfJ77OSqoAvxYZVwETriWjTpbBgqZL2hY3tjUiM0YgI7HzpFEfU0/zujz3YofRn8emKGHrA3zIViquCI5j4JpFeYF4TNRb21DKs93OkTpEv7ucTlCniaZL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CsoE5stj; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CsoE5stj"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49b392ccaacso38421815e9.2
        for <git@vger.kernel.org>; Sun, 30 Aug 2026 14:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788126981; x=1788731781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=r7DwYQgKSlIDSnGRg0dKeMH488aMay9QFgTirB9F+OI=;
        b=CsoE5stjhsCYDNJlWR3JkcjlQzDlYUvR3rpN7FMNA2K4xubh8dDdhDM7or14wFqCX1
         Pu/zI1CYk/ZJzt9YeP83v/9cyaki3ONwMOQFtsQfonAzdKV2q++Sxqspy++KJYaZDj7Z
         u9gSRNYCPELW0hqd0og3i/o1JQIhr5TeI2sM1IynDca4uix45b3HBf6aJ22z4ASNp7BM
         MkM6K3fa9PN5bpJrnwrb3++oOHOk2qjAv4tz9uQldfu+RRPYgooWOhI8yjAypjMo4wNy
         ukbPPPopjtGAeZQnncTcIqjKtHxjIxUOcPLMIEOWfsB3SS64RNqHN6pqpxFpp8uwjIvW
         0fPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788126981; x=1788731781;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r7DwYQgKSlIDSnGRg0dKeMH488aMay9QFgTirB9F+OI=;
        b=Tm1xHzcTsFU2m0Srk08akyI1baOmdK+Ufu+JV9dRZAQyGwV3g/9DgFRpmMk1zbKIKe
         fTgaM871xSqxv4px+DeqlJk+SQb4SmIJnNgXU9b5fgVnMHJoR0OJNwUSx8s0Iq2U1Iqv
         8pa420t7gSosDN3G+GyqczpefMacVYLsCQl6qVlKubWeuo2/8uL7sjoFW6fuwpf0HFeQ
         yOhgETYK6dZMH7QcfNfWJUk+2YPMsxyGlnLcKdsdhLH4WIYK7ZHu5o1zjK8s7Rx4MSQY
         /t8AThX463ZCQFyIQnTz7cvTnNlfO1WwQ84GCuldkj6jAmL0PlzDyRw+GNG2nruH1P2v
         n+7g==
X-Gm-Message-State: AFuF++n3VS5Kf4tObsrTslyRwqBlI2k+8cVSPVXm1q4mpZvbWhke0kJM
	bz76Zj6pax99leN2KiXn1yVH2ZAZFo1NiZ1UWFy5sZq16Qw0f53mbNn/wfLg6A==
X-Gm-Gg: AR+sD12BzmCunszkSMkRqg80O4Oyr9t4mHMvmu7iCqZaRS7c5Z3tDGQnuDrtLQ8b6iN
	EmuUet3ykG4elUITC8HWLfnuMqLIBl9zChf7asooVMQUGJuVUdZgroBLrMclg7+J8/XgUREQifV
	L1+8G6kHTFmyhuk0oxUqnfZ6bGjHk91Lgy2BdWpPXv6+8z5x/LMWjQvir7YCbhNjc2a0iEpD3JC
	RNJ0irZqa2OOmoROupabs6WxEHNAlaSfH2/e/+ES6RzcjOJLagHUr1te6TRz3QeID+ZTYGpBpJE
	K6j14+M5nc2MMgYVr0c7jxy8czY82ZFc4wJ8o3Ziaefo4CmbCFfJT62HhvwCqexRjGv8a8Shpip
	C4VifyHEaaQ50cl9WLgPdpbrXVGwqJqz28kB+2ZYf7YJtio5Rp5mAEsb+Dj2fDNNqkUPD77HAnO
	X7+a/2jDM8CerNOl9Gc8AOQ65tWv6oPa8KxGiqUHQaXurf1dhKpo3/chnwLbD+qt0rC+tnGN8KD
	dk=
X-Received: by 2002:a05:600c:1549:b0:49c:d618:e341 with SMTP id 5b1f17b1804b1-49cd618e6d9mr47086045e9.14.1788126980456;
        Sun, 30 Aug 2026 14:56:20 -0700 (PDT)
Received: from mirko (164.68.84.79.rev.sfr.net. [79.84.68.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b94dc1076sm229240335e9.3.2026.08.30.14.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 14:56:20 -0700 (PDT)
From: Nicolas Le Cam <niko.lecam@gmail.com>
To: git@vger.kernel.org
Cc: Nicolas Le Cam <niko.lecam@gmail.com>,
	Jeff King <peff@peff.net>
Subject: [BUG] git stash show --src-prefix prints freed memory since 2.52.0
Date: Sun, 30 Aug 2026 23:55:55 +0200
Message-ID: <20260830215555.2660035-1-niko.lecam@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

What did you do before the bug happened? (Steps to reproduce your issue)

    git init repo && cd repo
    printf 'one\ntwo\nthree\n' >f.txt
    git add f.txt && git commit -m init
    printf 'one\nTWO\nthree\n' >f.txt
    git stash
    git stash show --src-prefix=a/ --dst-prefix=b/

What did you expect to happen? (Expected behavior)

The first line of the patch should use the prefixes I asked for:

    diff --git a/f.txt b/f.txt

What happened instead? (Actual behavior)

The prefixes are replaced by fragments of unrelated heap data, and the
value changes between runs of the same command:

    $ git stash show --src-prefix=a/ --dst-prefix=b/ | head -1
    diff --git Uf.txt Uf.txt
    $ git stash show --src-prefix=a/ --dst-prefix=b/ | head -1
    diff --git Vf.txt Vf.txt

On other versions the garbage is recognisable as pieces of other
strings live in the process -- "ributes" (from "attributes"),
"bjectmode" (from "objectmode"), "4c/" -- which is what suggests a
use-after-free rather than an off-by-one.

What's different between what you expected and what actually happened?

Scope, from testing across released versions.

"git diff --src-prefix=a/ --dst-prefix=b/" is correct on every version
I tried. Only "stash show" is affected. First line of the patch from
"git stash show --src-prefix=a/ --dst-prefix=b/":

    2.49.1   diff --git a/f.txt b/f.txt          (correct)
    2.52.0   diff --git ributesf.txt 4c/f.txt
    2.53.0   diff --git Uf.txt Uf.txt
    2.54.0   diff --git 4c/f.txt bjectmodef.txt

The 2.53.0 output varies between invocations; the others were stable
within a single container but differ from each other.

Also unaffected: "git stash show -p" with no prefix flags, and
"git stash show -p --no-ext-diff --no-textconv".

Anything else you want to add:

Suspected cause. 3ea35c64b ("stash: tell setup_revisions() to free our
allocated strings", merged in jk/setup-revisions-freefix) added

    struct setup_revision_opt opt = { .free_removed_argv_elements = 1 };

to show_stash(). v2.51.0 does not contain that commit; v2.52.0 does,
which matches the bisect above.

--src-prefix and --dst-prefix are parsed by OPT_STRING_F in diff.c:

    OPT_STRING_F(0, "src-prefix", &options->a_prefix, N_("<prefix>"),
                 N_("show the given source prefix instead of \"a/\""),
                 PARSE_OPT_NONEG),

parse-options stores the pointer into the argv element rather than
copying it, so options->a_prefix points into the "--src-prefix=a/"
string itself. Once setup_revisions() is told it may free the argv
elements it consumes, that string is freed while a_prefix still
references it, and the dangling pointer is read later when the diff
header is emitted.

If that reading is right, the same hazard would apply to any diff
option parsed with OPT_STRING* into a struct diff_options field, not
only these two -- "stash show" is simply the caller that now opts in
to the freeing.

How I ran into it: a tool that passes --src-prefix=a/ --dst-prefix=b/
explicitly so it can parse the resulting patch without being affected
by a user's diff.noprefix or diff.mnemonicPrefix configuration. That
is a fairly common pattern for programs consuming git's diff output
(lint-staged does the same), so the corrupted paths surface as
unparseable filenames rather than as an obvious crash.

I could not find an existing report for this.

[System Info]
git version 2.53.0 (Debian). Reproduced identically on the
alpine/git 2.52.0 and 2.54.0 images; not reproducible on 2.49.1.

Thanks,
Nicolas Le Cam
