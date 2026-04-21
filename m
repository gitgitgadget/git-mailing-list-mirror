Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABABE399345
	for <git@vger.kernel.org>; Tue, 21 Apr 2026 11:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776770905; cv=none; b=Ifm124ePWAEUWuQq2TwB5R4G0bcDIaiefeJA1feT+Pyc8UZty8vpBnEgN7j+hb0HuJG3E3JxDBlMb03hEUuqXLAs3wcifHnJ895r46rt6LpzCvksT784KnJgVp4+3b15hPy5PzadqyRFw/gtNqMxkdro5cEJQ2IJ6EDLurf04DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776770905; c=relaxed/simple;
	bh=RGnkJPK7czg6m36ot9mU22KYXj1T+65Enbjp8ki3R3w=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=P6MFzVpup8uOFDfQwfVYe7o0lWRMYaBVx1XMKK5OsQGstnJWf4x4E3jehvXSwixxMu+BEUWU/FQ1Ezh4aLpqhCFmSHRm/LuRgwnkxJk5Z1/6euF+9uLqvGL1FSYtnrmbppvd1ID1OROfI9pl6lBQXKE+S8egKiqvUNgJVtQrSpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wateringcan.de; spf=pass smtp.mailfrom=wateringcan.de; dkim=pass (2048-bit key) header.d=wateringcan.de header.i=lcq@wateringcan.de header.b=EVsRgrkU; arc=none smtp.client-ip=212.227.17.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wateringcan.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wateringcan.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wateringcan.de header.i=lcq@wateringcan.de header.b="EVsRgrkU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wateringcan.de;
	s=s1-ionos; t=1776770900; x=1777375700; i=lcq@wateringcan.de;
	bh=RGnkJPK7czg6m36ot9mU22KYXj1T+65Enbjp8ki3R3w=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=EVsRgrkULXXnUV36VBStvbADr/khrZqOSA5e3jTQMvrr3iu7w3a1FL1WshsiLbZg
	 M3IotoFj/EXsnp/rmHPxDkZ1zgjVcrdWWhuqBnBZZT77Cip5MBf/hoGJ4EVS2Ulch
	 sQxtEgB3Lk4ZHhG/V8qc94KWJ3Ay3y3D1+C6POfTrp2AsHaXI5ScEYZoqBj8M1MYU
	 081o/Bj+RTUX4p9OOfwiZ1oWYsLYcZ9pBipq4cxkuVQ1Au2Yy0833i/EQjXWekr2Z
	 4v9mcuOQ4okCqcR/pKXPFYykkGHmlquvWY4GJUxgdB/A6umPww+2SGqGjbWVG9Dkj
	 XDOy7Y3bUcLSPGE9fQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue109
 [212.227.15.152]) with ESMTPSA (Nemesis) id 1N3Kc8-1vF6MB1xCM-014x1z; Tue, 21
 Apr 2026 13:03:41 +0200
Message-ID: <b7b6b94c-7e42-42a5-95e5-d44a54d6da0f@wateringcan.de>
Date: Tue, 21 Apr 2026 13:03:40 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: git@vger.kernel.org
Cc: grawity@gmail.com
From: Lutz-Christian Quander <lcq@wateringcan.de>
Subject: [BUG] git-credential-libsecret writes secret to stdout on store
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iKeQYi6kebVkCZ+RaaG8Ht7wvbczMbo5NuOoItIP8kGNgWOcokH
 tXSEoQDLr9vJ3DhY7nr0X/YhRZSNVj1SaTiMkhHyOO4uT8xJ0ViHgIE7z499YKIcXBwLYuC
 MTM27kR9ivCLxBfZCzCALg/2mpTGfRFiTgnrGBrESRoSOaM5N2a0Q37LRNirdzgJV+LBXjc
 UW/Y2UynQ7v9a0c3WJPvw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xKGh1OwD8FE=;8XjnaAEqqf6hZMlSDnsr7fRchzn
 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
 =

Hello,

I believe I've hit a bug in contrib/credential/libsecret that leaks
the secret to stdout on `store` (and, by inspection of the same code
path, `erase`). It reproduces on the current 2.53.0 Arch package and
the relevant code path is unchanged on master as of today.

Summary
=2D------

`git-credential-libsecret store` unconditionally echoes the
`username` and `password` from its parsed input back to stdout after
the store operation completes. This exposes the secret to whatever
consumes the helper's stdout -- terminal scrollback, shell
pipelines, CI logs, or any parent-process capture -- whenever a
caller feeds credentials in via pipe (the documented non-interactive
seeding pattern).

`get` should write credentials to stdout. `store` and `erase` should
not.

Affected version
=2D---------------

- Reproduced on git 2.53.0-1.1 (Arch Linux community/git).
- Source inspected from the installed package
 =C2=A0 (/usr/share/git/credential/libsecret/git-credential-libsecret.c)
 =C2=A0 and confirmed against
 =C2=A0 contrib/credential/libsecret/git-credential-libsecret.c on
 =C2=A0 origin/master.

Reproduction
=2D-----------

 =C2=A0 =C2=A0 $ printf=20
"protocol=3Dhttps\nhost=3Dexample.invalid\nusername=3Dalice\npassword=3DSE=
CRET123\n\n"=20
| /usr/lib/git-core/git-credential-libsecret store
 =C2=A0 =C2=A0 username=3Dalice
 =C2=A0 =C2=A0 password=3DSECRET123
 =C2=A0 =C2=A0 $ echo $?
 =C2=A0 =C2=A0 0

Only `username=3D` and `password=3D` are echoed (not `protocol=3D` /
`host=3D`), matching the four fields `credential_write()` emits.

Expected behaviour
=2D-----------------

`store` produces no stdout on success. Exit code unchanged.

Root cause
=2D---------

In main(), the write is unconditional after the op dispatch:

 =C2=A0 =C2=A0 ret =3D credential_read(&cred);
 =C2=A0 =C2=A0 if (ret)
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;

 =C2=A0 =C2=A0 /* perform credential operation */
 =C2=A0 =C2=A0 ret =3D (*try_op->op)(&cred);

 =C2=A0 =C2=A0 credential_write(&cred);=C2=A0 =C2=A0/* unconditional for g=
et/store/erase */

`credential_write()` emits `username`, `password`,
`password_expiry_utc`, and `oauth_refresh_token` to stdout. That is
correct for `get` (returning the looked-up credential) and incorrect
for `store` / `erase`, where the struct still holds the just-read
stdin input.

Comparable helpers in the same tree should probably be audited for
the same pattern; at least `credential-store` historically only
writes on `get`.

Proposed fix
=2D-----------

Minimal change -- guard the write:

 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D credential_read(&cred);
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret)
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;

 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* perform credential operation */
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D (*try_op->op)(&cred);

 =C2=A0 =C2=A0 -=C2=A0 =C2=A0 credential_write(&cred);
 =C2=A0 =C2=A0 +=C2=A0 =C2=A0 if (!strcmp(argv[1], "get"))
 =C2=A0 =C2=A0 +=C2=A0 =C2=A0 =C2=A0 =C2=A0 credential_write(&cred);

A cleaner refactor would add a `writes_output` flag or a
`write_result` callback to `struct credential_operation` so each op
declares its own output contract, but the guard above is the
smallest safe change. Happy to turn it into a proper patch with
sign-off if that's preferred.

Security impact
=2D--------------

The documented pattern for seeding credentials non-interactively is:

 =C2=A0 =C2=A0 printf "protocol=3D...\nhost=3D...\nusername=3D...\npasswor=
d=3D...\n\n" |=20
git-credential-<helper> store

Running this at a terminal prints the secret into scrollback.
Running it in a shell script whose stdout goes to a log file
persists the secret in that log. Running it in CI captures the
secret in the pipeline artefact. Every real-world use of the
documented pattern is affected.

Severity is moderate: the leak requires the user to run a legitimate
command -- no attacker-controlled input path -- but the leak happens
on the "correct" documented workflow, silently, with exit code 0.

Workaround
=2D---------

Redirect stdout explicitly:

 =C2=A0 =C2=A0 printf "...\n" | /usr/lib/git-core/git-credential-libsecret=
 store=20
 >/dev/null

Environment
=2D----------

- Distribution: CachyOS (Arch Linux derivative)
- Kernel: Linux 7.0.0-1-cachyos
- git: 2.53.0-1.1
- Shell: bash (invoked from a fish login shell)

Happy to coordinate disclosure if preferred, but the workaround is
trivial, the patch is one line, and the bug affects any scripted
credential seeding -- so there's little to gain from embargo.

Thanks,

Lutz-Christian Quander

