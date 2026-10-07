Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF544DEC14
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 19:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791400238; cv=pass; b=cnOfqWpVOxsP/2F80YjTMzUsaSNp/ZZwrrSmCmuRMmwwE4gbXRqAeOoMykuXjgbrhqJkQ7vgyBaXhSIv5mM1Xw90TxTjDEkL8tBPt8CaxDsoQih7shrN2VuUSQkw6tFLPmxSJ1q8H0aozrTXRPrQ8XgNMYqcrMHbGRw3nl2HVaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791400238; c=relaxed/simple;
	bh=zTic5X9J06YRWatWbY5AxBM81r2DfMwmsQP1Cr+zOXk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V2tml6GCv+h7R0DjuaHkaYtyHQgof3x8GnKu5Uf75GEatSwiXkrH1XJUasMTo3R6mLy5rRPe22nDOXB7CcdBWQTVfvhIPUknxc1iCANiHNDVBPNvFPFNQJJKZWL1YW4EHSrMbYqxHnCgeOUbLw/KEvZk/kwwm+c4aZVxOhXCu/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jiRk/ygw; arc=pass smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jiRk/ygw"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-ccce6d9abfeso1523610a12.1
        for <git@vger.kernel.org>; Wed, 07 Oct 2026 12:10:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791400236; cv=none;
        d=google.com; s=arc-20260327;
        b=seNJoB2DGkiwdGbnhI148rWGIBBmt1F7TdDYr7G6/VunKtnXW6X15/sE4NIdYlx/Ec
         725DBQArbY+JoozgBKUSBd1H0xh42rve4RsnFF1LsXtK5HtM/JC77E5c7tcilivuizYh
         g5pGkObTQOCZYQjZUeUFWekBV5sLQ9+/DqkZiKHVPuAqJod8bR09GpODrXe3Av3VyzgR
         8ONTLRzChWjdwlDvIe5JmvrUhLwlyUWQ/4gbCYsifw6uYbgboJ7oXF1DnY+Ja7ZZ7q1T
         zV5X5uBlkvPd4durlueRcaiQNTjpUfTW4UFe3maoPnlUJFxZtf+mNby0nUXfQsHqLMTZ
         8g5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nkKTm6grm6J/H9QzFMzEJtWwmg5VuxdMl+XIuQvd/kY=;
        fh=KbndeiWJYoVjvD6HEdLyPEPLhgfD9tU9i/2CRzekWMU=;
        b=EJrpzoG/jZjRfPMzuHBjTpgPr7Zf8w5NltgBjs+gj05OqO25WYS/vBa+pE0D+1y2+O
         /J54tZE154gPtuvvxkKVBs9u82T6AN+kVW+YwAnWGlremramEZ46E+AC3ir9+EzBltAV
         zD5oU4z+qr6De7oDcnzBuFfGMIhn/f7HKacl0jO0zOz24I+wmRD9BqTzRY8HK0Ul5exp
         ltdnN5P7fmDp8KsCMSd8u2H3i15RTc21E+2ottKPfNx+dqkYugB+aaSBdRmA8BkqF6A7
         6PLk24tv80idgDzQXmlWs6B2bmscRnDWi7BG6IGi/9DMte/bm0AZLfUf22e/CPnTQC8n
         IVeA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791400236; x=1792005036; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nkKTm6grm6J/H9QzFMzEJtWwmg5VuxdMl+XIuQvd/kY=;
        b=jiRk/ygwjlevuOKQbKRBgjD3MbJPlP5H1S56/Cpm1chulIWB2QGHEPNGl8EWP3ibUt
         CogUtSDDLSLEfkqG/HQncTxan15BVnehrfDk50ObYZbd97El9XbtPt/NHKqJ+Qkwgt4i
         Ky2Gf4aSlGWf1SxcbEaufD+VZRHUHatkdaWUPLRorl4Q/fv+MUEnzvOR+qCogHZMaexE
         XDgS96dWc2tfCxD8tUW4d4uHHRq4okvtA8Q6yWSY95v9r7O1Jo6nqKNkud2HB/0ORQU8
         GV+Hz/B9JICkfJl/ltUEHNsaBay5mnbpff2xK+Yuf9bpFoAdnv00vUnMg/gKB5yb9b1c
         RJ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791400236; x=1792005036;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nkKTm6grm6J/H9QzFMzEJtWwmg5VuxdMl+XIuQvd/kY=;
        b=aKpuIJlnQZmPpxbHwqb81QJx1Dq8jpn8Yf91crGTNwfbbcoyMgmZx08m8j4H0yYz0G
         Nxa/J5FtEH9LSTEOBX8DIlXwbXfPovc81zTiUetiO0BVaWraL5f0p2Z13YRYGas1Xm/3
         SgHPMl5/ao1ybk1Ay9enwFGfoBCIpYa0f3iw3KQooyQb0F/UpgGfx9Aj0VFNloWMA+zh
         Un/6jrSUeg+8F8/QOK6Lxbri0il5PGQhbG+TOahj/D+HFWwbRZQ4hGa15dxHdfiGiD3v
         QrdtohmIK10LlGf8yY0OFoDb4Y6tRp3FbvPHZuQlWtSUk426VHkLzV4YNb4WacyNu1MR
         fJtw==
X-Gm-Message-State: AFuF++n0j399hotJUkFE2EocvJiJwtTbHiMdwes95Y9avWQDj3BP61MN
	mYHm5golyMHKKzJS3MKRuQh2HqALJdtDAjSOGkstVlPz/JsOkcvPNbJr+3JSJjSn3yd1YzeOix7
	SKwJumygCOvCP5Z1dpIdBaEIglCXlwsI=
X-Gm-Gg: AYBFou1/UiS6Dbc3ymBKGf+atjUy6hQHRk7i7MVZ5ptQw3c5j0JEw4rRI+18+F+Ym7q
	wI9DjFlVgXLgRKd55ujrTs0KJ++os2/vwlWAC7rhnkqgZ5oKOuvBbllbF85ay2t4w4Mtveu7oT8
	hdaNg1IhpzKOkJoln+vW/HcBGrynTNAImfZG8+VBhC+LS5vVaZ0jSPmQ1Dr7gRMC/ul+ntCrLui
	0o3WdZjGbY+KUaywPksJdojqw0wh4QAjhNjo3ULXOTYhWyC4oFPrt47DGROLEaCfKrH2Me43amQ
	TNBQ8QDl9n6aImtqwoyrJhcQS9Bjsbz4vF5eisNQ5treyR8wgP2gWrTbo9RgMZC0wRyT+Vb0sl1
	c9BZqR4dOy3oFmDQ5v4D39VrFuFKsmUSsjcNufyk93RFQHyQmcty1XSNXo7D5YiRmE6X0qYyHsH
	AfdVHaPlFXd48KZtcm+Ixl+cx+9GvbIw==
X-Received: by 2002:a05:6a21:110:b0:3de:61f6:4207 with SMTP id
 adf61e73a8af0-3e13412d7a7mr2385878637.51.1791400236189; Wed, 07 Oct 2026
 12:10:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACgTecOm+=vbf50tZNXhcYvRi1ZTsQwbjVoJAbQqs2CmXdJCxg@mail.gmail.com>
In-Reply-To: <CACgTecOm+=vbf50tZNXhcYvRi1ZTsQwbjVoJAbQqs2CmXdJCxg@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Wed, 7 Oct 2026 15:10:24 -0400
X-Gm-Features: AclHuK9k6eXvgnagToggcCf-6tacTTopNhYCqgfJEEVy4OqnyaRUIVq0D8UyWvY
Message-ID: <CALnO6CCmv7PmxW2HTfvD8i6-PCVqMWgasyU9PYhPLXGj1sz=Hg@mail.gmail.com>
Subject: Re: [BUG] repack --drop-filtered --dry-run writes packs and honors -d
 in Git 2.56.0
To: Coy Geek <coygeek@gmail.com>
Cc: git@vger.kernel.org, Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Cc: Siddharth Shrimali <r.siddharth.shrimali@gmail.com> who authored
the --drop-filtered code.

On Sun, Oct 4, 2026 at 7:47=E2=80=AFPM Coy Geek <coygeek@gmail.com> wrote:
>
> fix(repack): --drop-filtered --dry-run writes packs and deletes old
> packs with -d
>
> ## Summary
>
> On Git 2.56.0, `git repack -a --filter=3Dblob:limit=3D1m --drop-filtered
> --dry-run` prints the candidate blob but also writes a new promisor
> pack and its sidecar files. Adding explicit `-d` also removes the old
> redundant packs and their sidecar files. Both commands exit
> successfully despite the documented promise to list candidates without
> rebuilding packs or deleting anything.
>
> This makes the advertised preview mutate repository storage. The
> tested blob remains available after both commands; this report does
> not demonstrate loss of object content.
>
> ## Steps to reproduce
>
> The following Python 3 script was executed with Git 2.56.0 on macOS.
> It requires `git` on `PATH`, creates only disposable local
> repositories, disables ambient Git configuration and hooks, and uses a
> synthetic commit identity. It creates a 2,200,000-byte historical blob
> absent from the current index, makes a filtered clone through a local
> promisor remote, fetches that blob into a promisor pack, and snapshots
> the pack directory before each preview. Each variant uses its own
> fresh partial clone. The script removes its fixture after a successful
> run.
>
> ```python
> import hashlib
> import os
> from pathlib import Path
> import subprocess
> import shutil
> import tempfile
>
> work =3D Path(tempfile.mkdtemp(prefix=3D'agent-work.', dir=3D'/tmp'))
> env =3D {k: v for k, v in os.environ.items() if not k.startswith('GIT_')}
> env.update(GIT_CONFIG_NOSYSTEM=3D'1', GIT_CONFIG_GLOBAL=3Dos.devnull,
>            LC_ALL=3D'C', GIT_TERMINAL_PROMPT=3D'0')
>
> def git(repo, *args):
>     command =3D ['git', '-c', 'gc.auto=3D0', '-c', 'core.hooksPath=3D' + =
os.devnull,
>                '-c', 'user.name=3DFixture', '-c',
> 'user.email=3Dfixture@example.invalid',
>                '-C', str(repo), *args]
>     return subprocess.run(command, env=3Denv, check=3DTrue, text=3DTrue,
>                           stdout=3Dsubprocess.PIPE,
> stderr=3Dsubprocess.PIPE).stdout.strip()
>
> def inventory(repo):
>     packdir =3D repo / '.git' / 'objects' / 'pack'
>     return {p.name: hashlib.sha256(p.read_bytes()).hexdigest()
>             for p in packdir.iterdir() if p.is_file()}
>
> print(git(work, '--version'))
> source =3D work / 'source'
> source.mkdir()
> git(source, 'init', '--template=3D', '-b', 'main')
> (source / 'large.bin').write_bytes(b'LARGE BLOB\n' * 200000)
> git(source, 'add', 'large.bin')
> git(source, 'commit', '-m', 'Add historical blob')
> blob =3D git(source, 'rev-parse', 'HEAD:large.bin')
> git(source, 'rm', 'large.bin')
> (source / 'tip.txt').write_text('tip\n')
> git(source, 'add', 'tip.txt')
> git(source, 'commit', '-m', 'Remove historical blob')
> remote =3D work / 'remote.git'
> git(work, 'clone', '--bare', str(source), str(remote))
> git(remote, 'config', 'uploadpack.allowFilter', 'true')
>
> for label, extra in [('dry-run', []), ('dry-run -d', ['-d'])]:
>     repo =3D work / ('clone-delete' if extra else 'clone-preview')
>     git(work, '-c', 'protocol.file.allow=3Dalways', 'clone', '--filter=3D=
blob:none',
>         remote.as_uri(), str(repo))
>     assert git(repo, 'cat-file', '-s', blob) =3D=3D '2200000'
>     before =3D inventory(repo)
>     output =3D git(repo, 'repack', '-a', *extra, '--filter=3Dblob:limit=
=3D1m',
>                  '--drop-filtered', '--dry-run')
>     after =3D inventory(repo)
>     added =3D sorted(after.keys() - before.keys())
>     removed =3D sorted(before.keys() - after.keys())
>     changed =3D sorted(k for k in before.keys() & after.keys() if
> before[k] !=3D after[k])
>     print(label + ': exit 0')
>     print('candidate=3D' + output)
>     print('pack directory: before=3D%d after=3D%d added=3D%d removed=3D%d=
 changed=3D%d' %
>           (len(before), len(after), len(added), len(removed), len(changed=
)))
>     print('added extensions=3D' + ','.join(sorted(Path(k).suffix for k in=
 added)))
>     print('removed extensions=3D' + ','.join(sorted(Path(k).suffix for k
> in removed)))
>     print('candidate size after=3D' + git(repo, 'cat-file', '-s', blob))
> shutil.rmtree(work)
> ```
>
> ## Expected behavior
>
> The Git 2.56.0 `git-repack` manual says `--dry-run` should "List the
> objects that would be dropped, one object ID per line, without
> rebuilding any pack or deleting anything."
>
> For both commands, Git should print the candidate blob and leave the
> existing pack files and their contents unchanged. Explicit `-d` should
> not cause deletion during this dry run. The fixture satisfies the
> documented prerequisites: `-a`, a supported `blob:limit` filter, a
> configured promisor remote, no operation in progress, and a candidate
> absent from the current index.
>
> ## Actual behavior
>
> The executed script produced this output. The counts include regular
> files in `objects/pack`, and `changed` compares SHA-256 content hashes
> for names present before and after.
>
> ```text
> git version 2.56.0
> dry-run: exit 0
> candidate=3Dfaed553c77de798540bd1edc898e174bf4436b28
> pack directory: before=3D12 after=3D16 added=3D4 removed=3D0 changed=3D0
> added extensions=3D.idx,.pack,.promisor,.rev
> removed extensions=3D
> candidate size after=3D2200000
> dry-run -d: exit 0
> candidate=3Dfaed553c77de798540bd1edc898e174bf4436b28
> pack directory: before=3D12 after=3D4 added=3D4 removed=3D12 changed=3D0
> added extensions=3D.idx,.pack,.promisor,.rev
> removed extensions=3D.idx,.idx,.idx,.pack,.pack,.pack,.promisor,.promisor=
,.promisor,.rev,.rev,.rev
> candidate size after=3D2200000
> ```
>
> The ordinary preview added four files, one each with `.pack`, `.idx`,
> `.promisor`, and `.rev` extensions. The preview with explicit `-d`
> added the same four types and deleted the 12 previous pack and sidecar
> files. Both invocations printed the expected candidate object ID and
> exited 0. A subsequent `cat-file -s` still reported the blob's
> original size in both clones.
>
> This report records one successful invocation of each variant in the
> final script execution. A preceding fixture execution reproduced the
> same counts. These observations establish the Git 2.56.0 behavior;
> current development Git was not built or executed for this report.
>
> ## Evidence
>
> - Expected source: Git 2.56.0 [Documentation/git-repack.adoc, the
> `--dry-run` option](https://github.com/git/git/blob/v2.56.0/Documentation=
/git-repack.adoc#L217-L220),
> which promises no pack rebuilding or deletion.
> - Failure source: The inline script and its captured output in Actual
> behavior. The before/after pack inventories show four added files for
> both variants and 12 deleted files when explicit `-d` is present.
> - Evidence provenance: observed
> - Local verification: reproduced
> - Reproduction completeness: complete
>
> The primary violation evidence is execution of the inline fixture with
> Git 2.56.0. Both commands exited 0 with the pack-directory changes
> shown above. The manual and source links provide the contract and
> supporting static evidence.
>
> The release source at [builtin/repack.c, lines
> 356-394](https://github.com/git/git/blob/v2.56.0/builtin/repack.c#L356-L3=
94)
> guards the implicit `delete_redundant` setting with `!dry_run`, then
> prints candidates when `dry_run` is set. Execution continues beyond
> that block. This is a source breadcrumb consistent with the observed
> results, rather than a required implementation change.
>
> The original implementation discussion also describes dry run as
> leaving the repository unchanged: [v5
> 1/6](https://lore.kernel.org/git/20260813200830.84348-2-r.siddharth.shrim=
ali@gmail.com/)
> and [v5 5/6](https://lore.kernel.org/git/20260813200830.84348-6-r.siddhar=
th.shrimali@gmail.com/).
>
> ## Restoration check
>
> Run the same fixture after a fix. Both preview variants should still
> print the candidate object ID and exit successfully, with `added=3D0
> removed=3D0 changed=3D0` and equal before/after pack-directory counts.
> Retaining the candidate output distinguishes a working preview from
> simply skipping the operation. The cached blob should remain
> available. Use the ordinary command and the explicit `-d` variant as
> separate checks of the same no-write contract.
>


--=20
D. Ben Knoble
