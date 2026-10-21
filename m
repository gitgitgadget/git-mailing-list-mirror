Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792566979;
	b=TVTzwkcfi4PNh0qnt3Zn3b1Y09v8V4acfgZ75Ww592j7iKXkm7XhxVGSMFL6ChxGxwrA
	 KQNfFRb4B/4gffdh+i1ePWr2CVg9d+ouQjg0qPKZOh9UywMwnnuziMlujZkCNnZCja5dn
	 FPwhY/XjppomLcwtYlsdZ0pVnZm4N5fyBm+O18Sl0jOpw3WQaHiSsnmbn4B2xoflg2VF8
	 PW1xGsle1FAeKb+H2mDcZm3OowD0jNymxff5rqsDI1o30OaRHFIT+06jGuD9fNlc/GM+Q
	 UG+IstPgzFaBVSXpipHM2UAuPcgrFzaxjYk87mV/ji9vYRWQuBuZn+P2uvbTpVdV56A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792566979;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Content-Type:Content-Transfer-Encoding;
	bh=fDZzr7pksZDlAhWYEgR23BqQA1MfW/XW5FBBbi9I/vw=;
	b=W7+L6maUKl5R4jB9lFQDb+x2zdf39yFhaei/IkN9gpVNBwMjfDM4NFe5xRs32dvjDe4m
	 YgintGEWspGTd58z6Y3KCccz84I5DrawOE+Cs95AGRB1XsWZJZZ1Kbhm7izD85FPIsBuZ
	 Yc4F8BjnsRwWPpmD00YTCRFnESGqdMS3FFoW+kAc60FOlEjGrzTvpXz8dTb4ZIr7DgyMi
	 V9yRGf+11UIJQrLZ/3icqvo+5ivMQ87LMYyeNG8xxSiY6bFBnRuv3fl7fI7nhbuCvl0XE
	 Vv3H7BxSiWwZK3khIK0hImMMJMME7p3TtdflTrB37oPH9WPHs+Hu7ztIYSL1YBv4Ukg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fuXbBufx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.45
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B158F606A319
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 07:16:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B158F606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fuXbBufx
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-91b9e758c50so5574936d6.1
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 00:16:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792566977; cv=none;
        d=google.com; s=arc-20260327;
        b=UkySvp0A1Djf/iG0xeJ4RA4AMqbznHmT5ECf6OWS/eiUyvISRAjuoKlkN37w9/+AGp
         PQdG8zqMNyjOLaaRh/bVO97X/LyTikqmgHenxV09TcUexH9zIOW/VulPkFX6S0iMxJWn
         r4AQVlMieAmdYr609lFevU0LFVXSxeX5ST2VVOxeI6oU6FirtgR+uDPekT6PLLEKLsSi
         BA4r4+fJNj6NoAWxicWaFnI6MjRIP2bMAQYm0lQCwtCynRzBlsiPusd/+YIHwpIHvhyZ
         V0Z6ImB+LBcR0aq+/fiifZFaZngRq7JiQxwtcOZ/nW9TxrXE9dZrZyofEE3dwqTCrYVF
         ZFXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fDZzr7pksZDlAhWYEgR23BqQA1MfW/XW5FBBbi9I/vw=;
        fh=yFg+p8Dz2kfC0z9vrfeBe5BOed3vQ8qFKoyrckDZ8KI=;
        b=TO0pcDj6VgOjlj4LH5Kin6U+4YbuPtj4jylFI8vgNYaJ4lYEhj+WVqJ9bTCSwhms2V
         +cWKvSGtP+9gSPHAf+5mE5Jxu3Ti2TSmTgtV1ye2JsL1NkKHJg2iqQ/+ZsJ301V2Zipk
         pVlXd/yuG1Av703Lied4MKnLVJfMBixC/ytxgvpZDA9TK7FlL9OIwkEUZcx5qvbuXyMK
         gM7lO9Cn+7SywP+u5o3UHe+tukJ7GVgCQtMV1a6z22qYL+YB3HU6KhNU8fgCbwivBOa6
         a+TPnzf/TezqTqhOIYYYby1rL9ffDAJ6wdH2xPZCA91RTB8CBRm/m/33Yr44jOzj1Lnb
         UBng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792566977; x=1793171777; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fDZzr7pksZDlAhWYEgR23BqQA1MfW/XW5FBBbi9I/vw=;
        b=fuXbBufxh3/hllRSb25seT+W8T0K6FSbFAZ7sVuiMRN9zvmvcMRypBlinA4P+PM5zQ
         Ez5H4zTzWYFUCpj/wLJq5M5sKyPRjEl74nSGJ2wwqjiJnpsfgoiaw+E+UYRAUjzcFpMX
         XWiklsjtv2l/vlnJGb/XrV50A2xL2ANwQAS7OqNj2B8+Pj/RsWfhLDMMzgrjaZikIMZm
         6G9He3Ixi8owMVyg6/+3CXOyyl29MdyH2pVBtYfQ+ktMaeHR/W/rrljc32mywC2SRSCE
         kh+kewV6l55UIucXkE6Wypmp9G6u4ZJDhuGAJE37PuFy+h9KGV0NTlGugKaB1VT7ORjA
         RHAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792566977; x=1793171777;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fDZzr7pksZDlAhWYEgR23BqQA1MfW/XW5FBBbi9I/vw=;
        b=VVB/zpdJhkoMjgQdnQQsrTarETmHZmHWwl6c1G86Tuqso9SeskGuZXWJUssXWpzLyd
         TOJXhYOjHYlUWF30vJD2uLv+wX4wN05eQSF/FBEMcqGSctsDg0Fqq/xQRfOiIZe45rPU
         QBStWaMCEXyyu3mKvGpENOkERGGRRbsDuPknGFVJht73JF+Cu9YhS/FR1GR5c2llOi5z
         KIzKEGLmhGgKqkqZfJ1o7zSqror/BhAQaLQimoa5WNOTA1paXofGqab7zar5xuO8O0UO
         wokcT704lFzArf2/tI9AtTEItZC/r31IOCi7vsoBSwsL9NHWp4GNcHr97wn01GFac/Tp
         cHQA==
X-Forwarded-Encrypted: i=1; AKwUvBxa8mSZKhek/yflu4abnaDXXuFVAE1IXA9pSMq/PfWAefYiYuJbn2+0oC4QakuN9RZdmfY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJMnPHfvffdKBo70K4EBnf+ywYNgxq5a0VW6OOP9tlzw/Lkungt
	590SX94qxkc2WcQLZ/btNJEds3SeyXGWdYgoGj8O+Vmg+l+CFRGtDvONWlyC6ZGvT6ngaN6Qqlz
	W0CWIWrCT4Sf55r4QDGSvDcrBF/3BwA7ExF9nFUE=
X-Gm-Gg: AYBFou3MutcCol2mtxx/23Qw2ERpbAqLos6wBhnZBXU9NUjIlF9SHVWq3lyNwYBxJb4
	sSi0rh70x2H2tt/WZ3dE3Eq87HW7DeRkQa20U/gm8+vKoIUOS0yhIFo6Qfe3jDG85FYoI7tE+0o
	w+4qxP0akJhU+XWKcQg2TVrOtlGpdj8/FoBUc4GMjiOn4tdKKAisfaH503gDoeQsxMrztfg54qL
	w3I5fs2kyf4UsqJrW+cBACewvuXQ7wLHC9szJ8q6gRqC1NW1S4z7R8n6ijVv8HCId7ZQMUoUF7g
	13llONTBgx1SbjdnU1HMQLO4BtEsxHkdByc7UxwhBWhInKUuaF8eC4zKnFMJN16mP8Q965cjgB7
	yPmgo/KSa7fM0I8cBsmsFDb4WgY0L+8JsYgndJmaw85ePOonteXiunbwDYGTuVs7fWZ4=
X-Received: by 2002:ad4:5aa7:0:b0:91b:82a6:d30a with SMTP id
 6a1803df08f44-91c12f57cc2mr16721866d6.26.1792566977417; Wed, 21 Oct 2026
 00:16:17 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2317.git.git.1780685368.gitgitgadget@gmail.com>
 <pull.2317.v2.git.git.1792512249.gitgitgadget@gmail.com> <83841020f43f9f8989371117075ebf089888d619.1792512249.git.gitgitgadget@gmail.com>
 <atfbDXhTUmPtv5pE@fruit.crustytoothpaste.net>
In-Reply-To: <atfbDXhTUmPtv5pE@fruit.crustytoothpaste.net>
From: Jason Newton <nevion@gmail.com>
Date: Wed, 21 Oct 2026 00:15:50 -0700
X-Gm-Features: AclHuK-HtwjrYSTC4DhUlb3jb1wJk4tywJoJj6E_e8vl7-KJBfuKs3Oe9VIuPT0
Message-ID: <CAGou9MhkmSZs3ViSj6qqkZY6LLLQQ+5RzjLG5EhM-AXx+d7h=A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] worktree: add --reflink for copy-on-write worktree creation
To: "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Jason Newton via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Jason Newton <nevion@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Brian,

macOS cp has no --reflink=3Dalways. The clone option is -c, which is
clonefile(2). t/t2400-worktree-add.sh already probes that way. The
REFLINK prerequisite runs "cp -c" when the MACOS prerequisite is set,
and "cp --reflink=3Dalways" otherwise. The test that depends on REFLINK
is "--reflink carries untracked files and reconciles changes".

That is in 042485f0e9cd8cf1765b811ea7334247aec44971. The pull request
CI for that commit is the APFS run:

https://github.com/git/git/pull/2317
https://github.com/git/git/actions/runs/39502233266

All four macos-14 jobs succeeded. The runners were macOS 14.8.9
(23J631), image macos-14-arm64 20260831.0302.1. "print test failures"
was skipped on each job, which is the step that runs only when a test
script fails.

osx-clang:
https://github.com/git/git/actions/runs/39502233266/job/118902393415
t2400-worktree-add.sh ok, 55208 ms

osx-gcc:
https://github.com/git/git/actions/runs/39502233266/job/118902393588
t2400-worktree-add.sh ok, 45173 ms

osx-meson:
https://github.com/git/git/actions/runs/39502233266/job/118902393644

osx-reftable:
https://github.com/git/git/actions/runs/39502233266/job/118902393664

The macOS evidence is those jobs.

Reflink is disabled on Windows in "worktree: disable reflink on
Windows" (91806975a6909265b1325206ef2f33a169393920). The pull request
head is 876fb541a8e1d43731bb72ddbbf1c49da8760775, which keeps that
disable and leaves the filesystem probe compiled so the mingw build
does not fail with -Werror=3Dunused-function. The CI run linked above
is the previous tip, 042485f. The warning names the build from the
git-lfs report,
Windows 11 build 26200. A later note on that report reproduced the
zero-fill on build 26200.9448 with git-lfs 3.6.1. No fixed build is
identified, so every Windows version refuses the ioctl and falls back
to a regular checkout. "git worktree add --reflink" and
worktree.reflink=3Dtrue warn with "Windows build 26200".
worktree.reflink=3Dauto stays silent. t2400 checks that warning under
MINGW.

On the git-lfs report, the failure mode is real and documented here:

https://github.com/git-lfs/git-lfs/issues/6312
https://github.com/git-lfs/git-lfs/pull/6323

FSCTL_DUPLICATE_EXTENTS_TO_FILE can publish zeros when the source
data is still cached. FlushFileBuffers on the read-only handle a
checkout uses fails with ERROR_ACCESS_DENIED (win32 5). The change in
6323 reopens the source writable, flushes, and skips that flush when
the volume does not advertise FILE_SUPPORTS_BLOCK_REFCOUNTING.

The numbers below are from the ioctl path before that disable, on
this machine, Windows build 26300.9457. The read-only flush failed
with win32 5, the same error the git-lfs report describes. The clones
kept the original bytes.

NTFS rejects the ioctl: win32 1 on a USB NTFS partition, win32 50 on
C:. The fallback there is a normal write. The USB disk would not
format as ReFS. The ReFS volume was a 32 GiB Dev Drive, stored as a
VHD on that disk, with block refcounting set. The clone path did not
flush.

Content check, every clone, unbuffered SHA-256:

4000 files, 8,388,608 bytes each
(33,554,432,000 bytes, 31.25 GiB of clone names).
Created with FSCTL_DUPLICATE_EXTENTS_TO_FILE only.

Source before rewrite:
106640827aa82610080b1e4c676e2028230b841fa4642faaa292046833950714
Pass 1: old=3D4000 new=3D0 other=3D0 errors=3D0

Source rewritten to a different pattern, still no flush:
e58408ac406d407257cd3a2474b8bba7b615e76bd4ce03e8ec3df9b42a02bc89
Pass 2: old=3D4000 new=3D0 other=3D0 errors=3D0

FlushFileBuffers on the read-only handle: FAIL win32=3D5
Reopen writable and flush: OK
Source hash stayed on the rewritten pattern.
Pass 3, after that flush: old=3D4000 new=3D0 other=3D0 errors=3D0

All 4000 clones still hashed to the original source. After they
settled, free space was 30,462,386,176 bytes and the backing VHD was
still 4,164,943,872 bytes. The volume stayed Healthy. Deleting the
clones freed nothing further.

This is one Windows build, alongside the version described in
git-lfs #6312.


On Tue, Oct 20, 2026 at 2:20=E2=80=AFPM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2026-10-20 at 16:04:08, Jason Newton via GitGitGadget wrote:
> > Creating many worktrees from the same base -- for example to run a
> > fleet of automated agents in parallel -- is expensive today: every
> > "git worktree add" materializes the entire working tree by writing
> > each tracked file out from the object store. The objects are shared
> > via the common directory, but the working tree is not: N worktrees
> > mean N full checkouts on disk and N times the file I/O.
> >
> > Add a "--reflink" option that, on a copy-on-write filesystem, populates
> > the new worktree by reflinking the current worktree's files and index
> > instead. The subsequent "git reset --hard" then only rewrites the
> > paths that actually differ between the current worktree and
> > <commit-ish>; everything else (including untracked files such as build
> > outputs) keeps sharing storage with the source until modified.
> >
> > A new reflink_file() helper in copy.c clones every regular file. There
> > is no size cutoff.
> >
> > On Linux it uses the FICLONE ioctl. That is the primitive btrfs, XFS
> > and bcachefs implement, and the one overlayfs forwards when the lower
> > filesystem can clone. This path has been tested on btrfs.
> >
> > On macOS it uses clonefile(), the APFS primitive. That path is
> > implemented and has not been run here.
> >
> > On Windows it uses ReFS block cloning,
> > FSCTL_DUPLICATE_EXTENTS_TO_FILE, as Git LFS does. The destination is
> > sized to the source, extents are cloned in chunks of at most 1GiB, and
> > the tail is rounded up to a cluster (64K, then 4K) and cloned; Windows
> > ignores the range past EOF. The tail is not byte-copied, and small
> > files are not skipped. That path is implemented and has not been run
> > on ReFS. A volume that rejects the control code, including NTFS, fails
> > the probe.
>
> That functionality is defective; see
> https://github.com/git-lfs/git-lfs/issues/6312.  We should not implement
> this on Windows because there's no reasonable way to avoid corruption.
> It's quite shocking that that bug exists, but it does.  Unless we can
> guarantee a fixed version of Windows (which does not exist yet), we
> should skip reflinking there.
>
> I'd also like to see us limit this to platforms where it _has_ been
> manually tested or is guaranteed to be automatically tested in CI.  That
> means we should make sure this runs in CI on APFS for macOS (see below).
>
> > +# Reflinks are only available on copy-on-write filesystems (btrfs, XFS=
,
> > +# bcachefs, APFS, ...). Where they are unavailable, --reflink transpar=
ently
> > +# falls back to a regular checkout, which the test above already cover=
s.
> > +test_lazy_prereq REFLINK '
> > +     echo probe >reflink-src &&
> > +     cp --reflink=3Dalways reflink-src reflink-dst 2>/dev/null
> > +'
>
> Does this work properly on macOS?  That is, does the macOS `cp` binary
> contain support for `--reflink=3Dalways`?  If not, we won't be testing
> this case properly on macOS.
> --
> brian m. carlson (they/them)
> Toronto, Ontario, CA
