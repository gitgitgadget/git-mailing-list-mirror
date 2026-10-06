Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7F34A012F
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 17:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791308887; cv=pass; b=Yk2dQ0EVhUk4WdklgKPZnEHeBpCxH0yQSxB+uIl8G3x9nC+BuX4b2KCzh95VgHEid/mOrpMQhljjqN4A2C4vrBaE3mJK5+T9Y0jb0kqWRexziLqfV1sOBbP8vsYkDbOp+dSoBeexfAUQft6GVZKq9Y85dZXBWuQSZ1MEghOkbLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791308887; c=relaxed/simple;
	bh=0YT54M/OnT4O1LHCB0axwPvPGFo9iOaxHk6x1POufrc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=AX5TWIc5djcGXlAFI8px5+kKRTllnD9bpbV4iC68Z+U8IlwbpZMoYM/ecYm3AICyLcbDJ/KI1XxHjkl7JTXI/PZEOKIwX5jg7zE+j/2gJCxH2X6UpfNVWw1qdrk0d52d+AamTMwLPCwfTOCWSPMs6xUQHBDN5gBV8of+UohvAic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DgTbyx1v; arc=pass smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DgTbyx1v"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3a4a82aa383so25815231fa.3
        for <git@vger.kernel.org>; Tue, 06 Oct 2026 10:48:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791308880; cv=none;
        d=google.com; s=arc-20260327;
        b=GjGcQHTQL9XTixZFbBKIC8DVezW4nnPnRBTFA/5OdALW26VqrDajKbOHGbMhwf1jYN
         z1y/dz2QFTq4IS4M2Yaxg/TMiq0h2qCHU2IvjswUwD0Dib3+OTW1ZZuE51xE1GC0cq8L
         CyWdfq6qRByCjiMS1KfhF9FYOJLoUt64LtB6dMPZvNKKKTUrLaNzac1uZEFSuNFwCcXK
         E5vuKLu/4WtRzI5Jxt1VsO18JdTVvqlFwTPLNCQpoddwCLpYoricY3jr6YzF47NAfs31
         O4hUmD1jfaWv/+sHQ73N50Nu+Eip69YRMe0bU32ca/katSXsw+GxlW8V8Y5fGu0O9e9d
         aY6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=mvIT+iLT2tZRNRMoVRENdGZlH8QaUm1U1VZe19A8NUE=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=p0WEppI08e2l1D6/z6xW3XCMIBk3etIsd+EttrlHN/yhRCgDhsZ0SIsn8Cqu9tfMIl
         /xuRQTHhtu+timAfZ4grfwL5QF/Pvajv/bfUrQv7yjd1gWIVhGO3z7T0Eb0eE1UCjk0h
         dAzIKaqEc5bqf5g3c2upJrehuHKBbWDkYGJ+I4CKfNwBgXmy3g4uBkYSb2KmDYwIsLHH
         Ywjts/c1UTsrUfjnr0OBfpbU6udDoqDFGpDEzrN4jD7JWxzAjE7r4GUlNGo3/J96lK0t
         Q7CKomnTvXveQ/EP3gtvNvmU5bAopGYEdJquhwPPhvMmJqQCcn8KY9Mjb8y4fwQmBSOa
         e3Gg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791308880; x=1791913680; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mvIT+iLT2tZRNRMoVRENdGZlH8QaUm1U1VZe19A8NUE=;
        b=DgTbyx1vA8rnrG0y7CGteCD7wHGFI4CphfNU2IB00owMH4n9ki+2XTOG1PXZFjf0bq
         2uwCwJi2qgNLc+cJblDLYy1DrJoQzmXXugQ+WZJXXZjnwOh8Js9jgkLl622F4AaPwTzH
         ca6dbEcI30JN+0ycYvitbmrJGOSnscgTBSnw6u+7Nn4If6DO4tV3TRN3nO8fd0blkGZf
         j9UTitb8P+1jI2TmNRM5P0SZPwJf+OMWCGs05K4aQYyHiZfZz1bfyNEO1G9WmBKIK0mS
         fHdr3DKB8B4ZcLMu/zOovW4SPPMgZh/B9c0EN7eHsE6nDI/QsTApKUTUA5JN5CdGBJbU
         cPjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791308880; x=1791913680;
        h=content-type:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mvIT+iLT2tZRNRMoVRENdGZlH8QaUm1U1VZe19A8NUE=;
        b=1lbwXqQ9QDINS9i6UuDBQ9m0tFVXXK08TWhIHZHcCjS/auoP6eqX4vQhkc1rqp+6Y+
         28esE99sOZevIOU9oyKIIWwCIJRm5v2lgG06AoJ56r4MIb+jw6PLjaOdcVrrnfC5QmTa
         yNsXdAo14LAzyn48qkJCim2PvY24+f9kBOAqqWN1zFxUPIP3/o8BX2AHHo70mNQ+/zDA
         NpiK2lr6X19cf8nLvQYoa5EL5ZSCOJZDqkjoRyS6MFysc2HbD/tGhIgpbdVxdz71wOSc
         jsporXAU02UCEM4mYks97to22uzxFVHrbLqnx8otY1uLaqLQGypbINxzoncNXEzQjBhh
         BihQ==
X-Gm-Message-State: AFq9FYLvM/5+4L6R8ZxFzsmjhWdhm68xJlMA6ZHEZmqRk75x7BnEHfZd
	zpFWrUdRoXDhO56VNBywKwZtBmWE/vt92TF8jyQAnIAoye276Oz+yk37l9T7/bgHoTOKuzvBeQK
	lzL+ZPiwRl3ua20yC/3FpGSYQEaraYqESUmQo0CY=
X-Gm-Gg: AYBFou1EVC7VhdnuS3XUbLMxih/zbWBXtiCYETRwe1aebRQz/tupsBf7WUAu3y5OgNE
	8392dBzJ5COq1lYiGcN95vawUwlv9veEIs7aDUfiF4SUkYVx56sd5m2NvyOFxglGjpMfPrFIEwC
	qUwIi5/496paxowQdAKMfZERIxZuwlw6vnLaOzihwAT5BibLOx75/KSop0S167ko3fhU0Qg4zdo
	U9QU2PxUHSJS/HIhVSTeDrt6QgqYUFzpyOJf1RuyvsO0AsWYFp0rfUBRaLQS3IBi9PTHx1jIe43
	AVMK4p5Bpy466vJruZ4bC56b/7q2oWcL8+azJdrpWS0iXa7WylDfI5tvmn446uUJz0/PS104UJy
	B+igPZWSlksfudyiIpdO2PuYDzBVvYlCRxn7nYJJu1VRIzsQXogJ8px2ZngJXY/YqoLv1hWCv2f
	OEtp1ADDrUbt91ZS4lW2uC5mi+2jhNoC1lxkFTZY2WszwblhopjuDMgE2gX+3a41MSuNVYrHB7q
	8ggue+BCFMSRDrjUAkpPNIqPZwQkjMNTzNT9mfFXWrHhnM1G9l2HmvZVpuaqUqRdTWFYrw49dJk
	0LhxDSkFkgo=
X-Received: by 2002:a05:651c:2123:b0:3a9:7160:e83a with SMTP id
 38308e7fff4ca-3a99af4b2f2mr4937541fa.17.1791308880016; Tue, 06 Oct 2026
 10:48:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+tGzvYYKm=Yo88knZb4oavG9dH5smUCXnoqa-RR9-7YEBycVA@mail.gmail.com>
In-Reply-To: <CA+tGzvYYKm=Yo88knZb4oavG9dH5smUCXnoqa-RR9-7YEBycVA@mail.gmail.com>
From: =?UTF-8?B?SmVucyBSw7Zja2Vy?= <jens.roecker@gmail.com>
Date: Tue, 6 Oct 2026 19:47:48 +0200
X-Gm-Features: AclHuK8pRvIrdXrtnO9cnIzE8EkKq60Hv-I0PK2CtBzCOiB5IhAi7z3bo-NEmsI
Message-ID: <CA+tGzva9Pzn=+zcVr9hkKa7HJEfHDQaB8wkYV7WBwjMchC_4xg@mail.gmail.com>
Subject: Re: [BUG] push resends common history after repack during pre-push
 (2.54.0, 2.56.0)
To: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000007a1e26065d2f9997"

--0000000000007a1e26065d2f9997
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Git developers,

Gmail hard-wrapped several long lines in the inline Python script in my
previous report. Please use the attached reproduce.txt instead. It is
the same tested script, supplied as a text/plain attachment to preserve
its exact contents.

Run it with:

  python3 reproduce.txt --git /path/to/git

For an uninstalled Git build, also pass:

  --exec-path /path/to/git/build/directory

All reported measurements remain unchanged: 300 bytes without repacking,
and 4,196,026 bytes with repacking, with or without push.negotiate=3Dtrue,
for both Apple Git 2.54.0 and upstream Git 2.56.0.

Sorry for the formatting issue.

Attachment SHA-256:
932b10a426aca11eb5831cd338ad5f61d83db1301e334764a2d9df17ab4e6b76

Am Di., 6. Okt. 2026 um 19:37 Uhr schrieb Jens R=C3=B6cker <jens.roecker@gm=
ail.com>:
>
> Hello Git developers,
>
> A push can resend common history if its pre-push hook repacks the local
> object database and removes previously loose common objects. I reproduced
> this with Apple Git 2.54.0 (Apple Git-157) and an unmodified build of the
> current upstream Git 2.56.0 release on macOS 27.0 / arm64.
>
> The attached inline Python script creates fresh local repositories, seeds
> a bare receiver with a deterministic, incompressible 4-MiB historical blo=
b,
> and pushes one tiny text-file commit. The common base is initially loose.
> The receiver uses receive.unpackLimit=3D1 so the added pack is measurable=
.
> Each case starts from a separate fresh repository pair. All pushes succee=
d
> and the receiver ends at the expected tip.
>
> Observed added receiver pack sizes, in bytes:
>
>                         Apple Git 2.54.0    upstream Git 2.56.0
>   no hook                      300                  300
>   repack in pre-push      4,196,026            4,196,026
>   repack + negotiate     4,196,026            4,196,026
>
> The repacking hook is simply:
>
>   #!/bin/sh
>   set -eu
>   cat >/dev/null
>   git repack -adq
>   git prune-packed
>
> Expected: the already-advertised common history should still be excluded
> when its storage moves from loose objects to a newly created pack.
> Actual: the historical blob is transmitted again. The receiver stores a
> new pack roughly the size of the historical blob. Enabling
> push.negotiate=3Dtrue does not prevent the redundant transfer in this tes=
t.
>
> Possible mechanism, based on source inspection:
>
> In 2.54.0, send-pack.c:feed_object() drops negative OIDs when
> odb_has_object(..., 0) returns false. In 2.56.0, the same quick check is =
in
> append_negative_object(). In both versions, odb_has_object() uses
> OBJECT_INFO_QUICK unless ODB_HAS_OBJECT_RECHECK_PACKED is set. A parent
> process with a stale pack catalogue may therefore miss the base after the
> hook removes the loose copy; the fresh pack generator then sees the new
> pack and walks history without that excluded base. This is a proposed
> explanation of the measured effect, not an instrumented proof of the
> parent process's in-memory state.
>
> Relevant release source:
> https://github.com/git/git/blob/v2.54.0/send-pack.c
> https://github.com/git/git/blob/v2.56.0/send-pack.c
> https://github.com/git/git/blob/v2.56.0/odb.c
>
> The upstream 2.56.0 binary was built from the kernel.org release tarball
> with optional gettext, curl, Tcl/Tk, Perl, Python and Rust components
> disabled. Neither global Git configuration nor the installed system Git
> was changed. The script isolates system/global Git configuration and uses
> only local transport. Measurements are receiver pack-file sizes, rather
> than network-byte counters. A separate large-repository incident motivate=
d
> this test, but this report includes only synthetic fixtures.
>
> To reproduce, save the inline script as reproduce.py and run:
>
>   python3 reproduce.py --git /path/to/git
>
> For a Git binary built in-place, add:
>
>   --exec-path /path/to/git/build/directory
>
> The script requires Python 3 and Git; its default mode removes only its
> own temporary test repositories when the run completes. To retain all
> fixture repositories and push logs, pass --output with a new directory.
>
> Minimal reproducer follows:
>
> #!/usr/bin/env python3
> """Reproduce redundant push history after loose objects move into a new p=
ack.
>
> Uses fresh local test repositories only. Requires Python 3 and Git.
> Example: python3 reproduce.py --git /path/to/git --output /new/results/pa=
th
> For an uninstalled Git build, add --exec-path /path/to/build/directory.
> """
>
> import argparse
> import hashlib
> import json
> import os
> from pathlib import Path
> import platform
> import shutil
> import subprocess
> import tempfile
> import time
>
>
> def main():
>     parser =3D argparse.ArgumentParser(description=3D__doc__)
>     parser.add_argument("--git", default=3Dshutil.which("git"))
>     parser.add_argument("--exec-path")
>     parser.add_argument("--output", type=3DPath)
>     args =3D parser.parse_args()
>     binary =3D str(Path(args.git).resolve())
>     temporary =3D None
>     if args.output:
>         root =3D args.output.resolve()
>         root.mkdir(parents=3DTrue, exist_ok=3DFalse)
>     else:
>         temporary =3D tempfile.TemporaryDirectory(prefix=3D"git-push-repa=
ck-repro-")
>         root =3D Path(temporary.name)
>
>     env =3D {key: value for key, value in os.environ.items()
>            if not key.startswith("GIT_")}
>     env.update(GIT_CONFIG_NOSYSTEM=3D"1", GIT_CONFIG_GLOBAL=3Dos.devnull,
>                GIT_AUTHOR_DATE=3D"2001-01-01T00:00:00+0000",
>                GIT_COMMITTER_DATE=3D"2001-01-01T00:00:00+0000")
>     env["PATH"] =3D str(Path(binary).parent) + os.pathsep + env.get("PATH=
", "")
>     if args.exec_path:
>         env["GIT_EXEC_PATH"] =3D str(Path(args.exec_path).resolve())
>
>     def git(cwd, *words):
>         return subprocess.run([binary, *words], cwd=3Dcwd, env=3Denv,
>                               text=3DTrue, capture_output=3DTrue, check=
=3DTrue,
>                               timeout=3D60)
>
>     results =3D []
>     for mode in ("no-hook", "repack", "repack-negotiate"):
>         case =3D root / mode
>         case.mkdir()
>         repo, remote =3D case / "repo", case / "remote.git"
>         git(case, "init", "-q", "-b", "main", str(repo))
>         git(case, "init", "-q", "--bare", "-b", "main", str(remote))
>         for key, value in (("user.name", "Git bug reproduction"),
>                            ("user.email", "test@example.invalid"),
>                            ("commit.gpgsign", "false"), ("gc.auto", "0"),
>                            ("core.hooksPath", str(repo / ".git/hooks"))):
>             git(repo, "config", key, value)
>         git(remote, "config", "gc.auto", "0")
>         git(remote, "config", "receive.unpackLimit", "1")
>         (repo / "history.bin").write_bytes(
>             hashlib.shake_256(b"historical fixture").digest(4 * 1024 * 10=
24))
>         git(repo, "add", "--", "history.bin")
>         git(repo, "commit", "-q", "-m", "historical seed", "--", "history=
.bin")
>         base =3D git(repo, "rev-parse", "HEAD").stdout.strip()
>         git(repo, "push", "-q", str(remote), "HEAD:refs/heads/main")
>         (repo / "change.txt").write_text("tiny change\n")
>         git(repo, "add", "--", "change.txt")
>         git(repo, "commit", "-q", "-m", "tiny change", "--", "change.txt"=
)
>         tip =3D git(repo, "rev-parse", "HEAD").stdout.strip()
>         assert (repo / ".git/objects" / base[:2] / base[2:]).is_file()
>         if mode !=3D "no-hook":
>             hook =3D repo / ".git/hooks/pre-push"
>             hook.parent.mkdir(parents=3DTrue, exist_ok=3DTrue)
>             hook.write_text("#!/bin/sh\nset -eu\ncat >/dev/null\n"
>                             "git repack -adq\ngit prune-packed\n")
>             hook.chmod(0o700)
>         before =3D set((remote / "objects/pack").glob("*.pack"))
>         config =3D ["-c", "push.negotiate=3Dtrue"] if mode =3D=3D
> "repack-negotiate" else []
>         start =3D time.monotonic()
>         result =3D git(repo, *config, "push", "--progress", str(remote),
>                      "HEAD:refs/heads/main")
>         elapsed =3D time.monotonic() - start
>         (case / "push.log").write_text(result.stdout + result.stderr)
>         packs =3D set((remote / "objects/pack").glob("*.pack")) - before
>         remote_tip =3D git(remote, "rev-parse", "refs/heads/main").stdout=
.strip()
>         assert remote_tip =3D=3D tip
>         results.append({"case": mode, "push_rc": result.returncode,
>                         "new_remote_pack_bytes": sum(p.stat().st_size
> for p in packs),
>                         "elapsed_seconds": round(elapsed, 6),
>                         "remote_tip_matches": True})
>     report =3D {"git_version": git(root, "version",
> "--build-options").stdout.strip(),
>               "platform": {"system": platform.system(), "machine":
> platform.machine(),
>                            "macos": platform.mac_ver()[0]},
>               "fixture_bytes": 4 * 1024 * 1024,
>               "transport": "local bare repository", "results": results}
>     encoded =3D json.dumps(report, indent=3D2) + "\n"
>     (root / "results.json").write_text(encoded)
>     print(encoded, end=3D"")
>     if temporary:
>         temporary.cleanup()
>
>
> if __name__ =3D=3D "__main__":
>     main()
>
> Thank you.



--=20
Mit freundlichen Gr=C3=BC=C3=9Fen
Jens R=C3=B6cker

--0000000000007a1e26065d2f9997
Content-Type: text/plain; charset="US-ASCII"; name="reproduce.txt"
Content-Disposition: attachment; filename="reproduce.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_muwz053a0>
X-Attachment-Id: f_muwz053a0

IyEvdXNyL2Jpbi9lbnYgcHl0aG9uMwoiIiJSZXByb2R1Y2UgcmVkdW5kYW50IHB1c2ggaGlzdG9y
eSBhZnRlciBsb29zZSBvYmplY3RzIG1vdmUgaW50byBhIG5ldyBwYWNrLgoKVXNlcyBmcmVzaCBs
b2NhbCB0ZXN0IHJlcG9zaXRvcmllcyBvbmx5LiBSZXF1aXJlcyBQeXRob24gMyBhbmQgR2l0LgpF
eGFtcGxlOiBweXRob24zIHJlcHJvZHVjZS5weSAtLWdpdCAvcGF0aC90by9naXQgLS1vdXRwdXQg
L25ldy9yZXN1bHRzL3BhdGgKRm9yIGFuIHVuaW5zdGFsbGVkIEdpdCBidWlsZCwgYWRkIC0tZXhl
Yy1wYXRoIC9wYXRoL3RvL2J1aWxkL2RpcmVjdG9yeS4KIiIiCgppbXBvcnQgYXJncGFyc2UKaW1w
b3J0IGhhc2hsaWIKaW1wb3J0IGpzb24KaW1wb3J0IG9zCmZyb20gcGF0aGxpYiBpbXBvcnQgUGF0
aAppbXBvcnQgcGxhdGZvcm0KaW1wb3J0IHNodXRpbAppbXBvcnQgc3VicHJvY2VzcwppbXBvcnQg
dGVtcGZpbGUKaW1wb3J0IHRpbWUKCgpkZWYgbWFpbigpOgogICAgcGFyc2VyID0gYXJncGFyc2Uu
QXJndW1lbnRQYXJzZXIoZGVzY3JpcHRpb249X19kb2NfXykKICAgIHBhcnNlci5hZGRfYXJndW1l
bnQoIi0tZ2l0IiwgZGVmYXVsdD1zaHV0aWwud2hpY2goImdpdCIpKQogICAgcGFyc2VyLmFkZF9h
cmd1bWVudCgiLS1leGVjLXBhdGgiKQogICAgcGFyc2VyLmFkZF9hcmd1bWVudCgiLS1vdXRwdXQi
LCB0eXBlPVBhdGgpCiAgICBhcmdzID0gcGFyc2VyLnBhcnNlX2FyZ3MoKQogICAgYmluYXJ5ID0g
c3RyKFBhdGgoYXJncy5naXQpLnJlc29sdmUoKSkKICAgIHRlbXBvcmFyeSA9IE5vbmUKICAgIGlm
IGFyZ3Mub3V0cHV0OgogICAgICAgIHJvb3QgPSBhcmdzLm91dHB1dC5yZXNvbHZlKCkKICAgICAg
ICByb290Lm1rZGlyKHBhcmVudHM9VHJ1ZSwgZXhpc3Rfb2s9RmFsc2UpCiAgICBlbHNlOgogICAg
ICAgIHRlbXBvcmFyeSA9IHRlbXBmaWxlLlRlbXBvcmFyeURpcmVjdG9yeShwcmVmaXg9ImdpdC1w
dXNoLXJlcGFjay1yZXByby0iKQogICAgICAgIHJvb3QgPSBQYXRoKHRlbXBvcmFyeS5uYW1lKQoK
ICAgIGVudiA9IHtrZXk6IHZhbHVlIGZvciBrZXksIHZhbHVlIGluIG9zLmVudmlyb24uaXRlbXMo
KQogICAgICAgICAgIGlmIG5vdCBrZXkuc3RhcnRzd2l0aCgiR0lUXyIpfQogICAgZW52LnVwZGF0
ZShHSVRfQ09ORklHX05PU1lTVEVNPSIxIiwgR0lUX0NPTkZJR19HTE9CQUw9b3MuZGV2bnVsbCwK
ICAgICAgICAgICAgICAgR0lUX0FVVEhPUl9EQVRFPSIyMDAxLTAxLTAxVDAwOjAwOjAwKzAwMDAi
LAogICAgICAgICAgICAgICBHSVRfQ09NTUlUVEVSX0RBVEU9IjIwMDEtMDEtMDFUMDA6MDA6MDAr
MDAwMCIpCiAgICBlbnZbIlBBVEgiXSA9IHN0cihQYXRoKGJpbmFyeSkucGFyZW50KSArIG9zLnBh
dGhzZXAgKyBlbnYuZ2V0KCJQQVRIIiwgIiIpCiAgICBpZiBhcmdzLmV4ZWNfcGF0aDoKICAgICAg
ICBlbnZbIkdJVF9FWEVDX1BBVEgiXSA9IHN0cihQYXRoKGFyZ3MuZXhlY19wYXRoKS5yZXNvbHZl
KCkpCgogICAgZGVmIGdpdChjd2QsICp3b3Jkcyk6CiAgICAgICAgcmV0dXJuIHN1YnByb2Nlc3Mu
cnVuKFtiaW5hcnksICp3b3Jkc10sIGN3ZD1jd2QsIGVudj1lbnYsCiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHRleHQ9VHJ1ZSwgY2FwdHVyZV9vdXRwdXQ9VHJ1ZSwgY2hlY2s9VHJ1ZSwK
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdGltZW91dD02MCkKCiAgICByZXN1bHRzID0g
W10KICAgIGZvciBtb2RlIGluICgibm8taG9vayIsICJyZXBhY2siLCAicmVwYWNrLW5lZ290aWF0
ZSIpOgogICAgICAgIGNhc2UgPSByb290IC8gbW9kZQogICAgICAgIGNhc2UubWtkaXIoKQogICAg
ICAgIHJlcG8sIHJlbW90ZSA9IGNhc2UgLyAicmVwbyIsIGNhc2UgLyAicmVtb3RlLmdpdCIKICAg
ICAgICBnaXQoY2FzZSwgImluaXQiLCAiLXEiLCAiLWIiLCAibWFpbiIsIHN0cihyZXBvKSkKICAg
ICAgICBnaXQoY2FzZSwgImluaXQiLCAiLXEiLCAiLS1iYXJlIiwgIi1iIiwgIm1haW4iLCBzdHIo
cmVtb3RlKSkKICAgICAgICBmb3Iga2V5LCB2YWx1ZSBpbiAoKCJ1c2VyLm5hbWUiLCAiR2l0IGJ1
ZyByZXByb2R1Y3Rpb24iKSwKICAgICAgICAgICAgICAgICAgICAgICAgICAgKCJ1c2VyLmVtYWls
IiwgInRlc3RAZXhhbXBsZS5pbnZhbGlkIiksCiAgICAgICAgICAgICAgICAgICAgICAgICAgICgi
Y29tbWl0LmdwZ3NpZ24iLCAiZmFsc2UiKSwgKCJnYy5hdXRvIiwgIjAiKSwKICAgICAgICAgICAg
ICAgICAgICAgICAgICAgKCJjb3JlLmhvb2tzUGF0aCIsIHN0cihyZXBvIC8gIi5naXQvaG9va3Mi
KSkpOgogICAgICAgICAgICBnaXQocmVwbywgImNvbmZpZyIsIGtleSwgdmFsdWUpCiAgICAgICAg
Z2l0KHJlbW90ZSwgImNvbmZpZyIsICJnYy5hdXRvIiwgIjAiKQogICAgICAgIGdpdChyZW1vdGUs
ICJjb25maWciLCAicmVjZWl2ZS51bnBhY2tMaW1pdCIsICIxIikKICAgICAgICAocmVwbyAvICJo
aXN0b3J5LmJpbiIpLndyaXRlX2J5dGVzKAogICAgICAgICAgICBoYXNobGliLnNoYWtlXzI1Nihi
Imhpc3RvcmljYWwgZml4dHVyZSIpLmRpZ2VzdCg0ICogMTAyNCAqIDEwMjQpKQogICAgICAgIGdp
dChyZXBvLCAiYWRkIiwgIi0tIiwgImhpc3RvcnkuYmluIikKICAgICAgICBnaXQocmVwbywgImNv
bW1pdCIsICItcSIsICItbSIsICJoaXN0b3JpY2FsIHNlZWQiLCAiLS0iLCAiaGlzdG9yeS5iaW4i
KQogICAgICAgIGJhc2UgPSBnaXQocmVwbywgInJldi1wYXJzZSIsICJIRUFEIikuc3Rkb3V0LnN0
cmlwKCkKICAgICAgICBnaXQocmVwbywgInB1c2giLCAiLXEiLCBzdHIocmVtb3RlKSwgIkhFQUQ6
cmVmcy9oZWFkcy9tYWluIikKICAgICAgICAocmVwbyAvICJjaGFuZ2UudHh0Iikud3JpdGVfdGV4
dCgidGlueSBjaGFuZ2VcbiIpCiAgICAgICAgZ2l0KHJlcG8sICJhZGQiLCAiLS0iLCAiY2hhbmdl
LnR4dCIpCiAgICAgICAgZ2l0KHJlcG8sICJjb21taXQiLCAiLXEiLCAiLW0iLCAidGlueSBjaGFu
Z2UiLCAiLS0iLCAiY2hhbmdlLnR4dCIpCiAgICAgICAgdGlwID0gZ2l0KHJlcG8sICJyZXYtcGFy
c2UiLCAiSEVBRCIpLnN0ZG91dC5zdHJpcCgpCiAgICAgICAgYXNzZXJ0IChyZXBvIC8gIi5naXQv
b2JqZWN0cyIgLyBiYXNlWzoyXSAvIGJhc2VbMjpdKS5pc19maWxlKCkKICAgICAgICBpZiBtb2Rl
ICE9ICJuby1ob29rIjoKICAgICAgICAgICAgaG9vayA9IHJlcG8gLyAiLmdpdC9ob29rcy9wcmUt
cHVzaCIKICAgICAgICAgICAgaG9vay5wYXJlbnQubWtkaXIocGFyZW50cz1UcnVlLCBleGlzdF9v
az1UcnVlKQogICAgICAgICAgICBob29rLndyaXRlX3RleHQoIiMhL2Jpbi9zaFxuc2V0IC1ldVxu
Y2F0ID4vZGV2L251bGxcbiIKICAgICAgICAgICAgICAgICAgICAgICAgICAgICJnaXQgcmVwYWNr
IC1hZHFcbmdpdCBwcnVuZS1wYWNrZWRcbiIpCiAgICAgICAgICAgIGhvb2suY2htb2QoMG83MDAp
CiAgICAgICAgYmVmb3JlID0gc2V0KChyZW1vdGUgLyAib2JqZWN0cy9wYWNrIikuZ2xvYigiKi5w
YWNrIikpCiAgICAgICAgY29uZmlnID0gWyItYyIsICJwdXNoLm5lZ290aWF0ZT10cnVlIl0gaWYg
bW9kZSA9PSAicmVwYWNrLW5lZ290aWF0ZSIgZWxzZSBbXQogICAgICAgIHN0YXJ0ID0gdGltZS5t
b25vdG9uaWMoKQogICAgICAgIHJlc3VsdCA9IGdpdChyZXBvLCAqY29uZmlnLCAicHVzaCIsICIt
LXByb2dyZXNzIiwgc3RyKHJlbW90ZSksCiAgICAgICAgICAgICAgICAgICAgICJIRUFEOnJlZnMv
aGVhZHMvbWFpbiIpCiAgICAgICAgZWxhcHNlZCA9IHRpbWUubW9ub3RvbmljKCkgLSBzdGFydAog
ICAgICAgIChjYXNlIC8gInB1c2gubG9nIikud3JpdGVfdGV4dChyZXN1bHQuc3Rkb3V0ICsgcmVz
dWx0LnN0ZGVycikKICAgICAgICBwYWNrcyA9IHNldCgocmVtb3RlIC8gIm9iamVjdHMvcGFjayIp
Lmdsb2IoIioucGFjayIpKSAtIGJlZm9yZQogICAgICAgIHJlbW90ZV90aXAgPSBnaXQocmVtb3Rl
LCAicmV2LXBhcnNlIiwgInJlZnMvaGVhZHMvbWFpbiIpLnN0ZG91dC5zdHJpcCgpCiAgICAgICAg
YXNzZXJ0IHJlbW90ZV90aXAgPT0gdGlwCiAgICAgICAgcmVzdWx0cy5hcHBlbmQoeyJjYXNlIjog
bW9kZSwgInB1c2hfcmMiOiByZXN1bHQucmV0dXJuY29kZSwKICAgICAgICAgICAgICAgICAgICAg
ICAgIm5ld19yZW1vdGVfcGFja19ieXRlcyI6IHN1bShwLnN0YXQoKS5zdF9zaXplIGZvciBwIGlu
IHBhY2tzKSwKICAgICAgICAgICAgICAgICAgICAgICAgImVsYXBzZWRfc2Vjb25kcyI6IHJvdW5k
KGVsYXBzZWQsIDYpLAogICAgICAgICAgICAgICAgICAgICAgICAicmVtb3RlX3RpcF9tYXRjaGVz
IjogVHJ1ZX0pCiAgICByZXBvcnQgPSB7ImdpdF92ZXJzaW9uIjogZ2l0KHJvb3QsICJ2ZXJzaW9u
IiwgIi0tYnVpbGQtb3B0aW9ucyIpLnN0ZG91dC5zdHJpcCgpLAogICAgICAgICAgICAgICJwbGF0
Zm9ybSI6IHsic3lzdGVtIjogcGxhdGZvcm0uc3lzdGVtKCksICJtYWNoaW5lIjogcGxhdGZvcm0u
bWFjaGluZSgpLAogICAgICAgICAgICAgICAgICAgICAgICAgICAibWFjb3MiOiBwbGF0Zm9ybS5t
YWNfdmVyKClbMF19LAogICAgICAgICAgICAgICJmaXh0dXJlX2J5dGVzIjogNCAqIDEwMjQgKiAx
MDI0LAogICAgICAgICAgICAgICJ0cmFuc3BvcnQiOiAibG9jYWwgYmFyZSByZXBvc2l0b3J5Iiwg
InJlc3VsdHMiOiByZXN1bHRzfQogICAgZW5jb2RlZCA9IGpzb24uZHVtcHMocmVwb3J0LCBpbmRl
bnQ9MikgKyAiXG4iCiAgICAocm9vdCAvICJyZXN1bHRzLmpzb24iKS53cml0ZV90ZXh0KGVuY29k
ZWQpCiAgICBwcmludChlbmNvZGVkLCBlbmQ9IiIpCiAgICBpZiB0ZW1wb3Jhcnk6CiAgICAgICAg
dGVtcG9yYXJ5LmNsZWFudXAoKQoKCmlmIF9fbmFtZV9fID09ICJfX21haW5fXyI6CiAgICBtYWlu
KCkK
--0000000000007a1e26065d2f9997--
