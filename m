Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A47E1C3F0C
	for <git@vger.kernel.org>; Sun,  7 Jun 2026 17:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780851913; cv=pass; b=AZHUxkcn64H264SmJDjntP0irLqyJ3RDtC/43dMh59sTrqRCHKnNnnue+Um1gNOVjbTX7kFZfF6vHqlmjxt+V7D3k0IdTifA76NPpCZourhw/fVeBBmi/r63opNE9+8krEqNRBAHIJBrtCt11NfgfPA+MOGnlGKocbgJA9oT5jk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780851913; c=relaxed/simple;
	bh=s6Kd1yU6ubxzpaE6VT/bYBSHtbVZhUK+uZmxJsgiCJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A03IU6RVd4/AXXiMrKTwk5TKqR50qCrY9EeHk0yeOcgPltW1YbRy/rnUj8KsOVmxbl/ok34OKVSNWYf5YRByIejJbPTPeNcFrW5HjKyuwtIorFLS8NcWqJRzSBm7w1e9Qmh9x/clJg0z6q+4FLgEu0CN0E4lPjQvOGZmdKfp5xg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bg72/RD1; arc=pass smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bg72/RD1"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-69e7dfcea4dso663286eaf.1
        for <git@vger.kernel.org>; Sun, 07 Jun 2026 10:05:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780851910; cv=none;
        d=google.com; s=arc-20240605;
        b=TyJbgl+/+QGx2gzrQwQbw4Mb0qzfsZvpl6pAYV1ntJiS+JLDar5svKtgCU98+fdf42
         ekeE9oV2ZX7iz9ubM6xCBIDp89zBgYzaHE1sVz7E5UZOl2PzUX/ZwnEDh4DYof8AUlYB
         2OQIJ6QnVUQE7ooMvjBMUuKPKM9hP0NdYuM1+odk9sYvzN2MYjL/Tx4gZp1See8gdsR1
         lL2+pXdBIKqgEr723sXkBduy7EwO+V1BiTzYFE12cJ8lznODs++TLrNokb+F7cNjss9l
         fWJg8zKsoz6ziwRLlHB0Omp2NqMefrNXPM8THEOryaa3NXPGOZAyrPveeHwhzpypCSCQ
         lPng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KEYosORslbMStrQ1qKXXMPjabhlwQzCfpeJhF0QfMP0=;
        fh=2wPsKzpPXAFw4AJUvaOTHy72StGAZH3i2TyLyfYw+vs=;
        b=kMYDDtCdU5EEmN+yLJo/fQVO4kW1z1s264OpYJauQ10E9RVa7wAcL9fXvJbJ94qzgI
         Nys1X8eecqsMrk14v9z/rkDmCrAG9FpXqM9BgMhXFcvvZjujmC1EeoK4a3IWjcHQkQJs
         4E+lTfj+MnowYJa1CjyHVZfcPGOIYbbJbTS5tt8BFhM9ha3ntWeeWMvmuxrE7K1y3+D8
         5uTf+sxrx9dI0w54G7MYqPjJAlK99xXOW42CbIBTs6HLdTQQ+UJMI+JqXUaUhjhAYGgY
         c0GUOLhMybZT++pQwsE9WyltUsKdZ2+ovrAwhqK5Z97uqP0lOqPqSfwYKRhld2g+EauW
         LYRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780851910; x=1781456710; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KEYosORslbMStrQ1qKXXMPjabhlwQzCfpeJhF0QfMP0=;
        b=Bg72/RD16TlVCCOoDQLfmU0NVwJD6OPGDP5kUKpXQt33+E/WSzZcbuoRNYh8um51zM
         Q7WiTff9Wkh+uk85d/iASALdBoHi1ufraW3qyjG6QwB2TMYGyC4t+1U5n1B0Wli7LQTR
         2PlOq8tpGiDEn1MdETrZD8jhEhOf0qQNSbFKuB5Zp5QCcRKgR4X9+Rqzj2fyh0K3lLEi
         nNcrtxJp96GykC0o2PN6UDdE8SF76lbg6sAJ66kk/BaaAiSerS5kLp8mAOkxBXSkqFfu
         Brf5jeaBu/j5v2JQG0ZVCa/uahYLLJDSRGeA+VyDAuoZrJj8cOp+mRM4N+pYIsY84ugU
         rKLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780851910; x=1781456710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KEYosORslbMStrQ1qKXXMPjabhlwQzCfpeJhF0QfMP0=;
        b=MqkXV7fORX6XRi8biiDOgoQ7KFFRMp6fNYHAY8TQykT4g71KC8QpX0Wsjiu1GoGY4i
         Aw59a0f2tGHSw+tYJYtZp9b6xd6P7eH7DfX5xCSWE2oceDl3g9fDjITch7EzpqyvTnZE
         MOEaE6ekoopBMt0SS3GjfWE+W0QOVZnl4zAIG3fKaBpAlu6yY1B6RJDG8vvYTzDOOxcI
         A2YvATNcF5zMbXR/FDviVDgNAkmhkNkE0gjy3njMnNjTV8LX3NkRauEA9tanvg4sOZ9a
         ZkxRCpR11VslFzRvxv1JzqFsHgW0CJ9RWWK1pB8najDA7RF7IJOhMiDQ+xLHS6V8kPsW
         1u/A==
X-Forwarded-Encrypted: i=1; AFNElJ+nJh8arEGB78xp7uIlB4hYTkb8N+xvEOqS7CVIsx/poJbxIBVha6MZgXhNUEXuDLasjUA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN6JJw4putXuKT/hK0t9LACVzxFuPCIEmtxa1j9t/bGJARU6+3
	31JkWZ3CcTkH5h7pCo3sItY07SNh0yrBaec7QKzQ0El1mxGvHU+DyfuYEv3LVTXzC1aCyApvYsv
	Hcj2KrLndqlG8zC+pSXDZ1PNHKVH+Cmo=
X-Gm-Gg: Acq92OFHPgvc5woQOmA+JkB9f2RqJf3S48/tl3fk/hUIu395ILzc1b+ybDRoPamTBw3
	c84AwAV1HUOfPUaFpus5CdTj8mUdOdaa7t+VA7tgerDiB7nZt9eKw+gFvhQr2UGkhOCGXySzldS
	EgwX1TcuorWb9HhMWrjsNNtF0RSsSJYHLXSR86pb16yYf5to7Q8uBcI6tx7fKVTPZ+PEzhywHjM
	uWj12UyNme6MCSez1PFXYniXvstUuICSmAabXSjSqnvrLGLyQuQuOoe6ZSLzMZjOmZSZKCFnvBG
	vn3qogP1HqfHGNKiMe7jgr7ccBkcgccQcZc0OxFF2mEUHn2areE=
X-Received: by 2002:a05:6820:4283:b0:69e:87de:1fbe with SMTP id
 006d021491bc7-69e87de2d85mr1323128eaf.25.1780851909453; Sun, 07 Jun 2026
 10:05:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2120.v2.git.1779733799.gitgitgadget@gmail.com>
 <pull.2120.v3.git.1780087700.gitgitgadget@gmail.com> <d044fa0ee5c9cda7dfe4f663f34443103521ef43.1780087700.git.gitgitgadget@gmail.com>
 <c7987f11-9181-3975-552c-14e74abb2c97@gmx.de>
In-Reply-To: <c7987f11-9181-3975-552c-14e74abb2c97@gmx.de>
From: Michael Montalbo <mmontalbo@gmail.com>
Date: Sun, 7 Jun 2026 10:04:58 -0700
X-Gm-Features: AVVi8CcEGCUs9clXDSEVy7gWwjtoj-o8VKq1s9ZqLA31GkamJSwrUXELGNpFBmE
Message-ID: <CAC2QwmJwxpnrPNW6YLm2uXKaYjkUwjVsPN_U+c52m0rNe95_Nw@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] diff: add long-running diff process via diff.<driver>.process
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Michael Montalbo via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 7, 2026 at 7:36=E2=80=AFAM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Michael,
>
> I stumbled about this patch when it broke CI in Git for Windows, where we
> do _not_ use `NO_PYTHON`, even though Python is unavailable in the
> build/test CI jobs. The existing tests handle this situation gracefully,
> this here patch does not:
>
> On Sun, 7 Jun 2026, Michael Montalbo via GitGitGadget wrote:
>
> > diff --git a/t/t4080-diff-process.sh b/t/t4080-diff-process.sh
> > new file mode 100755
> > index 0000000000..f159cd86d8
> > --- /dev/null
> > +++ b/t/t4080-diff-process.sh
> > @@ -0,0 +1,538 @@
> > +#!/bin/sh
> > +
> > +test_description=3D'diff process via long-running process'
> > +
> > +. ./test-lib.sh
> > +
> > +if test_have_prereq PYTHON
> > +then
> > +     PYTHON_PATH=3D$(command -v python3) || PYTHON_PATH=3D$(command -v=
 python)
>
> When neither `python3` nor `python` are available (which is the case in
> the minimal Git for Windows SDK used in Git's CI runs), this fails under
> `set -e`. Before even running the first test case. Resulting in an
> unexpected TAP format error.
>
> Now, we could "fix" this by imitating what `lib-p4` does (see
> https://github.com/dscho/git/commit/bd0b5570c744f678911a67a62da63f30655f2=
0d8
> which demonstrates that it is indeed a work-around on Windows):
>
> -- snip --
> diff --git a/t/t4080-diff-process.sh b/t/t4080-diff-process.sh
> index fdf6da1c341e67..bd22c247ff3856 100755
> --- a/t/t4080-diff-process.sh
> +++ b/t/t4080-diff-process.sh
> @@ -4,9 +4,10 @@ test_description=3D'diff process via long-running proces=
s'
>
>  . ./test-lib.sh
>
> -if test_have_prereq PYTHON
> +if ! test_have_prereq PYTHON || ! test -x "$PYTHON_PATH"
>  then
> -       PYTHON_PATH=3D$(command -v python3) || PYTHON_PATH=3D$(command -v=
 python)
> +       skip_all=3D'python interpreter not available'
> +       test_done
>  fi
>
>  #
> -- snap --
>
> Of course, this uncovers _another_ problem with the Python script: It use=
s
> Python3-only `f"..."` format strings, which cannot be handled by the
> Python2 to which the `PYTHON_PATH` variable in `linux-TEST-vars` points.
> So this requires _another follow-up (see also
> https://github.com/dscho/git/commit/c12a9f4c80e5ce8db0fe370fac46fb45be2b7=
75f):
>
> -- snip --
> diff --git a/t/t4080-diff-process.sh b/t/t4080-diff-process.sh
> index bd22c247ff3856..ba14682a9086e4 100755
> --- a/t/t4080-diff-process.sh
> +++ b/t/t4080-diff-process.sh
> @@ -39,7 +39,8 @@ setup_backend () {
>
>         def write_pkt(line):
>             data =3D (line + "\n").encode()
> -           sys.stdout.buffer.write(f"{len(data)+4:04x}".encode() + data)
> +           hdr =3D "{:04x}".format(len(data) + 4).encode()
> +           sys.stdout.buffer.write(hdr + data)
>             sys.stdout.buffer.flush()
>
>         def write_flush():
> @@ -98,7 +99,8 @@ setup_backend () {
>             new =3D read_content()
>             old_first =3D old.split(b"\n")[0].decode(errors=3D"replace") =
if old else ""
>             new_first =3D new.split(b"\n")[0].decode(errors=3D"replace") =
if new else ""
> -           log(f"command=3D{cmd} pathname=3D{pathname} old=3D{old_first}=
 new=3D{new_first}")
> +           log("command=3D{} pathname=3D{} old=3D{} new=3D{}".format(
> +               cmd, pathname, old_first, new_first))
>
>             if mode =3D=3D "error":
>                 write_flush()
> @@ -130,7 +132,7 @@ setup_backend () {
>                 else:
>                     ol =3D old.count(b"\n")
>                     nl =3D new.count(b"\n")
> -                   write_pkt(f"hunk 1 {ol} 1 {nl}")
> +                   write_pkt("hunk 1 {} 1 {}".format(ol, nl))
>                 write_flush()
>                 write_pkt("status=3Dsuccess")
>                 write_flush()
> -- snap --
>
> And this is still not enough to make it work with Python2, see
> https://github.com/dscho/git/actions/runs/27091523842/job/79955895737:
>
> -- snip --
> [...]
> + git -c diff.cdiff.process=3D./diff-process-backend --mode=3Dfixed-hunk =
diff boundary.c
>   Traceback (most recent call last):
>     File "/__w/git/git/t/trash directory.t4080-diff-process/diff-process-=
backend.py", line 45, in <module>
>       assert read_pkt() =3D=3D "git-diff-client"
>     File "/__w/git/git/t/trash directory.t4080-diff-process/diff-process-=
backend.py", line 4, in read_pkt
>       hdr =3D sys.stdin.buffer.read(4)
>   AttributeError: 'file' object has no attribute 'buffer'
> -- snap --
>
> I have experienced similar patterns in my career, where a single decision
> required multiple follow-up fixes _just_ to avoid having to revert that
> decision. This kind of doubling down has never ended well.
>
> Therefore I would like to take a step back, and ask: Is it _really_ a goo=
d
> idea to use Python here? Are we certain that we want to _require_ Python
> to run this test and skip it if Python isn't available (as is the case in
> the Windows-related parts of Git's very own CI) even if Python has nothin=
g
> at all to do with the feature that is being tested?
>
> I don't want to be doomed to repeat history, and we can very well learn
> e.g. from prior art in this very project, where the tests for the
> clean/smudge filters (which _also_ want to speak pkt-line over stdio)
> needlessly incurred Perl as a requirement to run the tests. It was
> Matheus's heroic work in 52917a998ef3a (t0021: implementation the
> rot13-filter.pl script in C, 2022-08-14) and 4d1d843be7a15 (tests: use th=
e
> new C rot13-filter helper to avoid PERL prereq, 2022-08-14) that avoided
> that unnecessary prerequisite.
>
> Likewise, there is `test-tool pkt-line` intended for driving the pkt-line
> protocol via simple shell scripts.
>
> So the conscious project direction has been: fold pkt-line test backends
> into `test-tool` and drop the scripting-language prereq. Reintroducing th=
e
> same shape in Python would walk this back.
>
> Patrick's careful effort in 27bd8ee311719 (Merge branch 'ps/fewer-perl',
> 2025-04-29) has been another clear sign that the Git project is actively
> _removing_ scripting-language dependencies from the build and test
> infrastructure, not adding new ones.
>
> The clear prior art in Git's own tests for what t4080 wants to do, as of
> today, is `t/helper/test-rot13-filter.c`, which could be imitated here
> instead of (re-)introducing a dependency on a scripting language other
> than Unix shell in Git's test suite.
>
> The `PYTHON` prereq exists in exactly five files today, all `git p4`
> related (where Python is an intrinsic prerequisite given that `git-p4.py`
> _is_ written in Python): `t/lib-git-p4.sh`, `t/t9802-git-p4-filetype.sh`,
> `t/t9810-git-p4-rcs.sh`, `t/t9835-git-p4-metadata-encoding-python2.sh`,
> and `t/t9836-git-p4-metadata-encoding-python3.sh`.
>
> After 7cdbff14d482 (remove merge-recursive-old, 2006-11-20), this here
> patch would be the first one, after almost 20 years, to re-introduce
> Python as a dependency outside `git p4`.
>
> And it would also be the first ever to embed a Python script as a heredoc=
:
>
> > +fi
> > +
> > +#
> > +# A single parametric diff process.
> > +# Usage: diff-process-backend --mode=3D<mode> [--log=3D<path>]
> > +#
> > +# Modes:
> > +#   whole-file  - report all lines as changed (default)
> > +#   fixed-hunk  - always report hunk 5 2 5 2
> > +#   bad-hunk    - report out-of-bounds hunk 999 1 999 1
> > +#   bad-sync    - report hunk with mismatched unchanged totals
> > +#   overlap     - report two overlapping hunks
> > +#   no-hunks   - return no hunks (files considered equivalent)
> > +#   error       - return status=3Derror for every request
> > +#   abort       - return status=3Dabort for every request
> > +#   crash       - read one request then exit without responding
> > +#
> > +setup_backend () {
> > +     cat >"$TRASH_DIRECTORY/diff-process-backend.py" <<-\PYEOF
> > +     import sys, os
> > +
> > +     def read_pkt():
> > +         hdr =3D sys.stdin.buffer.read(4)
> > +         if len(hdr) < 4: return None
> > +         length =3D int(hdr, 16)
> > +         if length =3D=3D 0: return ""
> > +         data =3D sys.stdin.buffer.read(length - 4)
> > +         return data.decode().rstrip("\n")
> > +
> > +     def write_pkt(line):
> > +         data =3D (line + "\n").encode()
> > +         sys.stdout.buffer.write(f"{len(data)+4:04x}".encode() + data)
> > +         sys.stdout.buffer.flush()
> > +
> > +     def write_flush():
> > +         sys.stdout.buffer.write(b"0000")
> > +         sys.stdout.buffer.flush()
> > +
> > +     def read_content():
> > +         chunks =3D []
> > +         while True:
> > +             hdr =3D sys.stdin.buffer.read(4)
> > +             if len(hdr) < 4: break
> > +             length =3D int(hdr, 16)
> > +             if length =3D=3D 0: break
> > +             chunks.append(sys.stdin.buffer.read(length - 4))
> > +         return b"".join(chunks)
> > +
> > +     mode =3D "whole-file"
> > +     logfile =3D None
> > +     for arg in sys.argv[1:]:
> > +         if arg.startswith("--mode=3D"):
> > +             mode =3D arg[7:]
> > +         elif arg.startswith("--log=3D"):
> > +             logfile =3D open(arg[6:], "a")
> > +
> > +     def log(msg):
> > +         if logfile:
> > +             logfile.write(msg + "\n")
> > +             logfile.flush()
> > +
> > +     # Handshake
> > +     assert read_pkt() =3D=3D "git-diff-client"
> > +     assert read_pkt() =3D=3D "version=3D1"
> > +     read_pkt()
> > +     write_pkt("git-diff-server")
> > +     write_pkt("version=3D1")
> > +     write_flush()
> > +     while True:
> > +         p =3D read_pkt()
> > +         if p =3D=3D "": break
> > +     write_pkt("capability=3Dhunks")
> > +     write_flush()
> > +
> > +     log("ready")
> > +
> > +     while True:
> > +         cmd =3D None
> > +         pathname =3D None
> > +         while True:
> > +             p =3D read_pkt()
> > +             if p is None: sys.exit(0)
> > +             if p =3D=3D "": break
> > +             if p.startswith("command=3D"): cmd =3D p.split("=3D",1)[1=
]
> > +             if p.startswith("pathname=3D"): pathname =3D p.split("=3D=
",1)[1]
> > +         if cmd is None: sys.exit(0)
> > +         old =3D read_content()
> > +         new =3D read_content()
> > +         old_first =3D old.split(b"\n")[0].decode(errors=3D"replace") =
if old else ""
> > +         new_first =3D new.split(b"\n")[0].decode(errors=3D"replace") =
if new else ""
> > +         log(f"command=3D{cmd} pathname=3D{pathname} old=3D{old_first}=
 new=3D{new_first}")
> > +
> > +         if mode =3D=3D "error":
> > +             write_flush()
> > +             write_pkt("status=3Derror")
> > +             write_flush()
> > +             continue
> > +
> > +         if mode =3D=3D "abort":
> > +             write_flush()
> > +             write_pkt("status=3Dabort")
> > +             write_flush()
> > +             continue
> > +
> > +         if mode =3D=3D "crash":
> > +             sys.exit(1)
> > +
> > +         if cmd =3D=3D "hunks":
> > +             if mode =3D=3D "fixed-hunk":
> > +                 write_pkt("hunk 5 2 5 2")
> > +             elif mode =3D=3D "bad-hunk":
> > +                 write_pkt("hunk 999 1 999 1")
> > +             elif mode =3D=3D "bad-sync":
> > +                 write_pkt("hunk 1 2 1 1")
> > +             elif mode =3D=3D "overlap":
> > +                 write_pkt("hunk 1 5 1 5")
> > +                 write_pkt("hunk 3 2 3 2")
> > +             elif mode =3D=3D "no-hunks":
> > +                 pass
> > +             else:
> > +                 ol =3D old.count(b"\n")
> > +                 nl =3D new.count(b"\n")
> > +                 write_pkt(f"hunk 1 {ol} 1 {nl}")
> > +             write_flush()
> > +             write_pkt("status=3Dsuccess")
> > +             write_flush()
> > +         else:
> > +             write_flush()
> > +             write_pkt("status=3Derror")
> > +             write_flush()
> > +     PYEOF
>
> The existing pattern is to provide larger scripts as fixtures in
> associated `t/tNNNN/` directories, not as heredoc, see e.g.
> `t/t1509/prepare-chroot.sh`. Writing scripts, especially lengthy ones, in
> heredoc strings makes it virtually impossible to use static code analysis
> or syntax highlighting to fend off banal errors.
>
> Given the complexity of what t4080 tries to test (error, abort, crash,
> bad-sync, no-hunks, multiple files in one session, capability
> negotiation), it would unfortunately be infeasible to use `test-tool
> pkt-line` from a shell script implementing that `diff.*.process` protocol=
.
>
> So I've spiked a demo how the `test-tool diff-process-backend` could look
> like (letting Opus do the menial typing, so that I can enjoy at least par=
t
> of a sunny Sunday outside), which also passes the CI build and test:
> https://github.com/dscho/git/commit/b6e3c93381b00929476c3a00155f7cf7334a2=
2e6
>
> That commit is of course not intended to be used as-is; Feel free to pick
> code parts of it and integrate them into your topic branch. Or write your
> own test-tool helper from scratch if that's more your jam.
>

Johannes, thank you for the great feedback. The historical context is
really helpful and
the concerns you raise make a lot of sense. I will take a look at your
spike and also work
on removing Python from the test.

> Ciao,
> Johannes
>
> > +     write_script diff-process-backend <<-SHEOF
> > +     exec "$PYTHON_PATH" "$TRASH_DIRECTORY/diff-process-backend.py" "\=
$@"
> > +     SHEOF
> > +}
> > +
> > +BACKEND=3D"./diff-process-backend"
> > +
> > +test_expect_success PYTHON 'setup' '
> > +     setup_backend &&
> > +     echo "*.c diff=3Dcdiff" >.gitattributes &&
> > +     git add .gitattributes &&
> > +
> > +     # boundary.c: 10 lines, changes at 5-6 and 9-10.
> > +     # Used by: hunk boundaries, error fallback, crash, bad hunks, ove=
rlap.
> > +     cat >boundary.c <<-\EOF &&
> > +     line1
> > +     line2
> > +     line3
> > +     line4
> > +     OLD5
> > +     OLD6
> > +     line7
> > +     line8
> > +     OLD9
> > +     OLD10
> > +     EOF
> > +     git add boundary.c &&
> > +
> > +     # worddiff.c: single-line function, value changes 1 -> 999.
> > +     # Used by: word-diff, --diff-algorithm, --no-ext-diff, --stat.
> > +     cat >worddiff.c <<-\EOF &&
> > +     int value(void) { return 1; }
> > +     EOF
> > +     git add worddiff.c &&
> > +
> > +     # newfile.c: single-line function, value changes 42 -> 99.
> > +     # Used by: new file, --exit-code, multiple drivers.
> > +     cat >newfile.c <<-\EOF &&
> > +     int new_func(void) { return 42; }
> > +     EOF
> > +     git add newfile.c &&
> > +
> > +     # logtest.c: single-line function for log/format-patch tests.
> > +     # Needs two commits so log -1 has a diff.
> > +     cat >logtest.c <<-\EOF &&
> > +     int logfunc(void) { return 1; }
> > +     EOF
> > +     git add logtest.c &&
> > +
> > +     # two.c/one.c: two-file pair for error/abort/startup-failure test=
s.
> > +     cat >one.c <<-\EOF &&
> > +     int first(void) { return 1; }
> > +     EOF
> > +     cat >two.c <<-\EOF &&
> > +     int second(void) { return 2; }
> > +     EOF
> > +     git add one.c two.c &&
> > +
> > +     git commit -m "initial" &&
> > +
> > +     # Second commit for logtest.c (so log -1 has something to show).
> > +     cat >logtest.c <<-\EOF &&
> > +     int logfunc(void) { return 2; }
> > +     EOF
> > +     git add logtest.c &&
> > +     git commit -m "change logtest.c" &&
> > +
> > +     # Working tree modifications (not committed).
> > +     cat >boundary.c <<-\EOF &&
> > +     line1
> > +     line2
> > +     line3
> > +     line4
> > +     NEW5
> > +     NEW6
> > +     line7
> > +     line8
> > +     NEW9
> > +     NEW10
> > +     EOF
> > +
> > +     cat >worddiff.c <<-\EOF &&
> > +     int value(void) { return 999; }
> > +     EOF
> > +
> > +     cat >newfile.c <<-\EOF &&
> > +     int new_func(void) { return 99; }
> > +     EOF
> > +
> > +     cat >one.c <<-\EOF &&
> > +     int first(void) { return 10; }
> > +     EOF
> > +
> > +     cat >two.c <<-\EOF
> > +     int second(void) { return 20; }
> > +     EOF
> > +'
> > +
> > +#
> > +# Core behavior: the tool controls which lines are marked as changed.
> > +#
> > +
> > +test_expect_success PYTHON 'diff process hunk boundaries affect output=
' '
> > +     # The file has changes at lines 5-6 and 9-10, but fixed-hunk
> > +     # only reports lines 5-6 as changed.  Lines 9-10 should not
> > +     # appear as changed in the output.
> > +     git -c diff.cdiff.process=3D"$BACKEND --mode=3Dfixed-hunk" \
> > +             diff boundary.c >actual &&
> > +     test_grep "^-OLD5" actual &&
> > +     test_grep "^-OLD6" actual &&
> > +     test_grep "^+NEW5" actual &&
> > +     test_grep "^+NEW6" actual &&
> > +     test_grep ! "^-OLD9" actual &&
> > +     test_grep ! "^-OLD10" actual &&
> > +     test_grep ! "^+NEW9" actual &&
> > +     test_grep ! "^+NEW10" actual
> > +'
> > +
> > +test_expect_success PYTHON 'diff process works with new file' '
> > +     rm -f backend.log &&
> > +     git -c diff.cdiff.process=3D"$BACKEND --log=3Dbackend.log" \
> > +             diff -- newfile.c >actual 2>stderr &&
> > +     test_grep "return 99" actual &&
> > +     test_grep "pathname=3Dnewfile.c" backend.log &&
> > +     test_must_be_empty stderr
> > +'
> > +
> > +test_expect_success PYTHON 'diff process works with added file (empty =
old side)' '
> > +     cat >added.c <<-\EOF &&
> > +     int added(void) { return 1; }
> > +     EOF
> > +     git add added.c &&
> > +
> > +     rm -f backend.log &&
> > +     git -c diff.cdiff.process=3D"$BACKEND --log=3Dbackend.log" \
> > +             diff --cached -- added.c >actual 2>stderr &&
> > +     test_grep "added" actual &&
> > +     test_grep "pathname=3Dadded.c" backend.log &&
> > +     test_must_be_empty stderr
> > +'
> > +
> > +test_expect_success PYTHON 'diff process skipped for binary files' '
> > +     printf "\\0binary" >binary.c &&
> > +     git add binary.c &&
> > +     git commit -m "add binary" &&
> > +     printf "\\0changed" >binary.c &&
> > +
> > +     rm -f backend.log &&
> > +     git -c diff.cdiff.process=3D"$BACKEND --log=3Dbackend.log" \
> > +             diff -- binary.c >actual &&
> > +     test_grep "Binary files" actual &&
> > +     test_path_is_missing backend.log
> > +'
> > +
> > +test_expect_success PYTHON 'diff process not consulted for unmatched d=
river' '
> > +     echo "not tracked by cdiff" >unmatched.txt &&
> > +     git add unmatched.txt &&
> > +     git commit -m "add unmatched.txt" &&
> > +
> > +     echo "modified" >unmatched.txt &&
> > +
> > +     rm -f backend.log &&
> > +     git -c diff.cdiff.process=3D"$BACKEND --log=3Dbackend.log" \
> > +             diff -- unmatched.txt >actual &&
> > +     test_grep "modified" actual &&
> > +     test_path_is_missing backend.log
> > +'
> > +
> > +test_expect_success PYTHON 'multiple drivers use separate processes' '
> > +     echo "*.h diff=3Dhdiff" >>.gitattributes &&
> > +     git add .gitattributes &&
> > +
> > +     cat >multi.h <<-\EOF &&
> > +     int header(void) { return 1; }
> > +     EOF
> > +     git add multi.h &&
> > +     git commit -m "add multi.h" &&
> > +
> > +     cat >multi.h <<-\EOF &&
> > +     int header(void) { return 2; }
> > +     EOF
> > +
> > +     rm -f backend-c.log backend-h.log &&
> > +     git -c diff.cdiff.process=3D"$BACKEND --log=3Dbackend-c.log" \
> > +         -c diff.hdiff.process=3D"$BACKEND --log=3Dbackend-h.log" \
> > +             diff -- newfile.c multi.h >actual 2>stderr &&
> > +     test_grep "pathname=3Dnewfile.c" backend-c.log &&
> > +     test_grep "pathname=3Dmulti.h" backend-h.log &&
> > +     test_must_be_empty stderr
> > +'
> > +
> > +test_expect_success PYTHON 'diff process works alongside textconv' '
> > +     write_script uppercase-filter <<-\EOF &&
> > +     tr "a-z" "A-Z" <"$1"
> > +     EOF
> > +
> > +     cat >textconv.c <<-\EOF &&
> > +     hello world
> > +     EOF
> > +     git add textconv.c &&
> > +     git commit -m "add textconv.c" &&
> > +
> > +     cat >textconv.c <<-\EOF &&
> > +     goodbye world
> > +     EOF
> > +
> > +     rm -f backend.log &&
> > +     git -c diff.cdiff.textconv=3D"./uppercase-filter" \
> > +         -c diff.cdiff.process=3D"$BACKEND --log=3Dbackend.log" \
> > +             diff -- textconv.c >actual 2>stderr &&
> > +     # The diff process receives textconv-transformed (uppercase) cont=
ent.
> > +     test_grep "pathname=3Dtextconv.c" backend.log &&
> > +     test_grep "old=3DHELLO WORLD" backend.log &&
> > +     test_grep "new=3DGOODBYE WORLD" backend.log &&
> > +     test_must_be_empty stderr
> > +'
> > +
> > +#
> > +# Downstream features: word diff, log, equivalent files, exit code.
> > +#
> > +
> > +test_expect_success PYTHON 'diff process with --word-diff' '
> > +     rm -f backend.log &&
> > +     git -c diff.cdiff.process=3D"$BACKEND --log=3Dbackend.log" \
> > +             diff --word-diff worddiff.c >actual 2>stderr &&
> > +     test_grep "\[-1;-\]" actual &&
> > +     test_grep "{+999;+}" actual &&
> > +     test_grep "pathname=3Dworddiff.c" backend.log &&
> > +     test_must_be_empty stderr
> > +'
> > +
> > +test_expect_success PYTHON 'diff process works with git log -p' '
> > +     # With no-hunks mode, the tool says the files are equivalent,
> > +     # so log -p should show the commit but no diff content.
> > +     rm -f backend.log &&
> > +     git -c diff.cdiff.process=3D"$BACKEND --mode=3Dno-hunks --log=3Db=
ackend.log" \
> > +             log -1 -p -- logtest.c >actual 2>stderr &&
> > +     test_grep "change logtest.c" actual &&
> > +     test_grep ! "return 2" actual &&
> > +     test_grep "command=3Dhunks pathname=3Dlogtest.c" backend.log &&
> > +     test_must_be_empty stderr
> > +'
> > +
> > +test_expect_success PYTHON 'diff process no hunks suppresses diff outp=
ut' '
> > +     cat >nohunks.c <<-\EOF &&
> > +     int zero(void) { return 0; }
> > +     EOF
> > +     git add nohunks.c &&
> > +     git commit -m "add nohunks.c" &&
> > +
> > +     cat >nohunks.c <<-\EOF &&
> > +     int zero(void) { return 999; }
> > +     EOF
> > +
> > +     git -c diff.cdiff.process=3D"$BACKEND --mode=3Dno-hunks" \
> > +             diff nohunks.c >actual &&
> > +     test_must_be_empty actual
> > +'
> > +
> > +test_expect_success PYTHON 'diff process no hunks with --exit-code ret=
urns success' '
> > +     git -c diff.cdiff.process=3D"$BACKEND --mode=3Dno-hunks" \
> > +             diff --exit-code nohunks.c
> > +'
> > +
> > +test_expect_success PYTHON 'diff process with --exit-code and hunks re=
turns failure' '
> > +     test_expect_code 1 git -c diff.cdiff.process=3D"$BACKEND" \
> > +             diff --exit-code newfile.c
> > +'
> > +
> > +#
> > +# Bypass mechanisms: flags and commands that skip the diff process.
> > +#
> > +
> > +test_expect_success PYTHON 'diff process bypassed by --diff-algorithm'=
 '
> > +     rm -f backend.log &&
> > +     git -c diff.cdiff.process=3D"$BACKEND --log=3Dbackend.log" \
> > +             diff --diff-algorithm=3Dpatience worddiff.c >actual &&
> > +     test_grep "return 999" actual &&
> > +     test_path_is_missing backend.log
> > +'
> > +
> > +test_expect_success PYTHON 'diff process not used by --stat' '
> > +     rm -f backend.log &&
> > +     git -c diff.cdiff.process=3D"$BACKEND --log=3Dbackend.log" \
> > +             diff --stat worddiff.c >actual &&
> > +     test_grep "worddiff.c" actual &&
> > +     test_path_is_missing backend.log
> > +'
> > +
> > +#
> > +# Error handling and fallback.
> > +#
> > +
> > +test_expect_success PYTHON 'diff process fallback on tool error status=
' '
> > +     rm -f backend.log &&
> > +     git -c diff.cdiff.process=3D"$BACKEND --mode=3Derror --log=3Dback=
end.log" \
> > +             diff boundary.c >actual 2>stderr &&
> > +     # Fallback produces the full builtin diff (both change regions).
> > +     test_grep "^-OLD5" actual &&
> > +     test_grep "^+NEW5" actual &&
> > +     test_grep "^-OLD9" actual &&
> > +     test_grep "^+NEW9" actual &&
> > +     # Tool was contacted (it replied with error, not crash).
> > +     test_grep "command=3Dhunks pathname=3Dboundary.c" backend.log &&
> > +     test_grep "diff process.*failed" stderr
> > +'
> > +
> > +test_expect_success PYTHON 'diff process error keeps tool available fo=
r next file' '
> > +     rm -f backend.log &&
> > +     git -c diff.cdiff.process=3D"$BACKEND --mode=3Derror --log=3Dback=
end.log" \
> > +             diff -- one.c two.c >actual 2>stderr &&
> > +     # Unlike abort, error keeps the tool available: both files
> > +     # are sent to the tool (and both fall back).
> > +     test_grep "pathname=3Done.c" backend.log &&
> > +     test_grep "pathname=3Dtwo.c" backend.log &&
> > +     test_grep "return 10" actual &&
> > +     test_grep "return 20" actual
> > +'
> > +
> > +test_expect_success PYTHON 'diff process abort disables for session' '
> > +     rm -f backend.log &&
> > +     git -c diff.cdiff.process=3D"$BACKEND --mode=3Dabort --log=3Dback=
end.log" \
> > +             diff -- one.c two.c >actual &&
> > +     # Both files should still produce diff output via fallback.
> > +     test_grep "return 10" actual &&
> > +     test_grep "return 20" actual &&
> > +     # The tool aborts on the first file and git clears its
> > +     # capability.  The second file never contacts the tool.
> > +     test_grep "pathname=3Done.c" backend.log &&
> > +     test_grep ! "pathname=3Dtwo.c" backend.log
> > +'
> > +
> > +test_expect_success PYTHON 'diff process fallback on tool crash' '
> > +     git -c diff.cdiff.process=3D"$BACKEND --mode=3Dcrash" \
> > +             diff boundary.c >actual 2>stderr &&
> > +     test_grep "^-OLD5" actual &&
> > +     test_grep "^+NEW5" actual &&
> > +     test_grep "^-OLD9" actual &&
> > +     test_grep "^+NEW9" actual &&
> > +     # Crash is a communication failure, so a warning is emitted.
> > +     test_grep "diff process.*failed" stderr
> > +'
> > +
> > +test_expect_success PYTHON 'diff process startup failure only warns on=
ce' '
> > +     git -c diff.cdiff.process=3D"/nonexistent/tool" \
> > +             diff -- one.c two.c >actual 2>stderr &&
> > +     # Both files produce diff output via fallback.
> > +     test_grep "return 10" actual &&
> > +     test_grep "return 20" actual &&
> > +     # Sentinel prevents repeated warnings: only one, not one per file=
.
> > +     test_grep "diff process.*failed" stderr >warnings &&
> > +     test_line_count =3D 1 warnings
> > +'
> > +
> > +test_expect_success PYTHON 'diff process fallback on bad hunks' '
> > +     git -c diff.cdiff.process=3D"$BACKEND --mode=3Dbad-hunk" \
> > +             diff boundary.c >actual 2>stderr &&
> > +     test_grep "^-OLD5" actual &&
> > +     test_grep "^+NEW5" actual &&
> > +     test_grep "^-OLD9" actual &&
> > +     test_grep "^+NEW9" actual &&
> > +     # Invalid hunks are caught by xdiff validation, not the
> > +     # protocol layer, so no warning is emitted.
> > +     test_must_be_empty stderr
> > +'
> > +
> > +test_expect_success PYTHON 'diff process fallback on mismatched unchan=
ged totals' '
> > +     cat >synctest.c <<-\EOF &&
> > +     line1
> > +     line2
> > +     line3
> > +     EOF
> > +     git add synctest.c &&
> > +     git commit -m "add synctest.c" &&
> > +
> > +     cat >synctest.c <<-\EOF &&
> > +     line1
> > +     changed
> > +     line3
> > +     EOF
> > +
> > +     # bad-sync reports hunk 1 2 1 1: marks 2 old lines and 1 new
> > +     # line as changed, leaving 1 unchanged old vs 2 unchanged new.
> > +     # The synchronization invariant fails and git falls back.
> > +     git -c diff.cdiff.process=3D"$BACKEND --mode=3Dbad-sync" \
> > +             diff synctest.c >actual 2>stderr &&
> > +     test_grep "changed" actual
> > +'
> > +
> > +test_expect_success PYTHON 'diff process fallback on overlapping hunks=
' '
> > +     # boundary.c has 10 lines, so both hunks are in bounds
> > +     # but they overlap at lines 3-5, triggering the ordering check.
> > +     git -c diff.cdiff.process=3D"$BACKEND --mode=3Doverlap" \
> > +             diff boundary.c >actual 2>stderr &&
> > +     test_grep "NEW5" actual
> > +'
> > +
> > +test_done
> > diff --git a/userdiff.h b/userdiff.h
> > index 51c26e0d41..a98eabe377 100644
> > --- a/userdiff.h
> > +++ b/userdiff.h
> > @@ -3,6 +3,7 @@
> >
> >  #include "notes-cache.h"
> >
> > +struct diff_subprocess;
> >  struct index_state;
> >  struct repository;
> >
> > @@ -33,6 +34,8 @@ struct userdiff_driver {
> >       int textconv_want_cache;
> >       const char *process;
> >       char *process_owned;
> > +     struct diff_subprocess *diff_subprocess;
> > +     unsigned diff_process_failed : 1;
> >  };
> >  enum userdiff_driver_type {
> >       USERDIFF_DRIVER_TYPE_BUILTIN =3D 1<<0,
> > --
> > gitgitgadget
> >
> >
> >
