Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DC12773F7
	for <git@vger.kernel.org>; Sun,  4 Oct 2026 23:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791157672; cv=pass; b=dKYzhodLj1wLjXulVrb1Fb5jOZhbJlmTI9ZriMJX1jdQZeSUCcZX9opeCwZo20V/mw+pnkqqUFYmZfJxLfxKqxPoMQSXKRLwqcw9g8PWPM54G2cY5ouCpgNRSvKWEfqC8W28fn5449mkC6LnconMF0T4BKsyeY4Ff+tFDC+hUCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791157672; c=relaxed/simple;
	bh=RXimqwbcGRfn2fbs8HU1NYpMAXBr2j8qhVrpwW2fBy8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=j+JP/ean4QgLhX3KobmbYNCugD4OG/avVjreEnEB8Y2Tp8eCJ8I3txUBIE8eMEeBNz6P7Z5GAwWWMM4EhmXyP+HsaAHvHHgZYGvAMQwap6vjzNzjSFeUgEPoMNo56RsU73Zw6LYNdkAv+HNZoslEF9DuUWgHzqz7PazCPywZedM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hHFtlDJd; arc=pass smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hHFtlDJd"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-35127b8ed25so35624eec.2
        for <git@vger.kernel.org>; Sun, 04 Oct 2026 16:47:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791157670; cv=none;
        d=google.com; s=arc-20260327;
        b=VSSk8RDheS+WzGiyRGWGw5fpp8FfObPSy8nc4l03I+2Orsd7/FBapJeoVW6BZxX/cE
         3VVu5nczzTG4GT6gV8fzT67O3XlNvOeja4Tnu/L5HlmDeta4bF+FLzVz/n04jW/n2SpG
         Dp8L8COLSkOA81y1Ie0Hu9NdGgAfhCPmQPBwN77+qXp/g+2VNvk5/9p164ni2xtDSAXD
         sbqX9DpWBIpjn5EZ7kg8isMky6ibQAZH23VhubNhO6q5Qp1HvC4m7WNf1BI2IQ0SJW0F
         66B35OcIQwxjH1e/eukx0V0x2X+0JrYY8fEQOXa/NUCigcLNDQTwKeE6C+GpH+C7SfZC
         WHpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=rUUNYVoKeUdkJpGhlVo/Sy3AFJcT99IyPLB7mpTIBHA=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=WCh3vwlkvGluCDj+/Btw95fuMZF3/x0ngqAIbnpozOmwjEqNbsZAngPidAxULijebK
         Ctv7D66sR2y7OsmzMUL970BSs+3wekoFN7A6bR+apInKxTKKtnZwyWU/QpQkbmX5kAe9
         dt71wEk+SktRCYwMC+db+XxgdrO3ozg8A3Rt5S4VNbQaXi0RQsda3wTymuScUdOoLToa
         mWopUZi7OuN26w3A1zavrF8/TGmJGH1wLHca36GdbXbrvv/BuEID5hNR2cVttZflzVX5
         eukdvFlqAUbxq5f4s9NnJf9JGA+ea/iwZndqXINDTmngZtpx+X8bLl5y9RrW5EG7PhlE
         k3gg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791157670; x=1791762470; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=rUUNYVoKeUdkJpGhlVo/Sy3AFJcT99IyPLB7mpTIBHA=;
        b=hHFtlDJdJdR0bdfCNEM/Y/gj9ueeFBO7HtncG7gkQv+/J4qEUXargBV/K10xirMuxF
         aoF5ke2GFD5ltClfZA54V/CkzQvhNHyF1isWQiwV9sHZLYQiej2NW1VUXYp9HM4+/H/r
         8kxbrFJOdWXzrxKTnljNdd0cYELBuRtBGtW77GJ/ON+S5PdRPUR0YnQ/rdnzOaUmsQ08
         ll3Vg9WXHDfPx8ViPQLrFF95ee7O4U+oyLt4wWrLB+F0T3brsliXs+Cis5UiIztev/yN
         S/6kU273w7U+URx2XzIW/NHf+djszbHJDw9WlM6/AASRUaE99N+qCp84cFqx5wDYle2n
         glGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791157670; x=1791762470;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rUUNYVoKeUdkJpGhlVo/Sy3AFJcT99IyPLB7mpTIBHA=;
        b=0zfwFRY3hbPaacHlrG8yVdsCJ6l/UEIyA19TJeUH8c/Ij4ueOtDRaU6WTaUo757slx
         36SMSPci3krAv4A6a+WtjJAQ1Fbnl1eN+HMcsFTOxeSXkkVr0Po9C+2rqhnLdTLNkLCU
         l7twgGpnGFIC1y9Jgd9VlI6xO27v61Zojsa0zj8MIVND1ULNLrVOiINNq9CMlSWzU0qR
         8lZNSxUkjvYq0FVsspkoH6o6t7sUbR107/44Ii06WFOeAX1+98YSF7DPCTgzYIWgi8Ax
         tIPJcTjWxNN6Nm+Bn1nhymw49kGxwUXYhYfHRnxeqBFSv0+SVbaHD68K03B1zqi3V/YI
         WbAQ==
X-Gm-Message-State: AFq9FYJTpSt9ZjqDIh9bDWtseJG5nZ4p7zSVZYk2Oes4Xxxsi2AZXiqm
	uzNm2U+2yyBxVYSEcqTrFowsQykO0oT5eFVMJDA9J8aF04fYC8/GRKxcCeG4RQD3uqsw47cMZVw
	tGkxAypOF8GaSbIkhfWyjs3D/oPMKKjNlq2/q
X-Gm-Gg: AYBFou1pjkvReXDdKMse7Fs0uW4/1saUkEDe2SZ63X4foYVWvv8lbHQdPuZo1LjNxBj
	C95PJ/AsrRjmN84JbFwcT3Pu2ntgy3zKwAYdX92A7LSHfPVZdQNP+bG9G17ISlV0hKj/IGXDeF/
	IQ/5VYieMFy5abxg73aBdzO0yZZj0HNetuOsa8TkU6RbMLUl2r7H+D5zYkO411LV9v0ZpscJ/FI
	OCEv+MQEj1h/o/329zFxfqh3lvjQE1gYgSwlcRwqM1PO8h8JhuWG5hgA8B++H/swXvlgPdwtzMZ
	d1uS2SiAXRohrgXlAIaSnB4D3y3Oqz5Cs54CXDwQ4AKyaqg/5Evg0tkAaGRzCsH8frSHl4NwlFw
	3Eux/H9qHIWSc9aMZ5RKdXgv+fjmyFrdfiF4NuPx7jTsVio+z
X-Received: by 2002:a05:7301:e101:b0:33e:6714:3945 with SMTP id
 5a478bee46e88-34f150658f9mr16253303eec.2.1791157669551; Sun, 04 Oct 2026
 16:47:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Coy Geek <coygeek@gmail.com>
Date: Sun, 4 Oct 2026 16:47:37 -0700
X-Gm-Features: AclHuK-y3HiT4i5O0U9fISG9vX3Ifnv8PH0A3UilKpl3Ak0IytO1p0gkNgTpubk
Message-ID: <CACgTecOm+=vbf50tZNXhcYvRi1ZTsQwbjVoJAbQqs2CmXdJCxg@mail.gmail.com>
Subject: [BUG] repack --drop-filtered --dry-run writes packs and honors -d in
 Git 2.56.0
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

fix(repack): --drop-filtered --dry-run writes packs and deletes old
packs with -d

## Summary

On Git 2.56.0, `git repack -a --filter=blob:limit=1m --drop-filtered
--dry-run` prints the candidate blob but also writes a new promisor
pack and its sidecar files. Adding explicit `-d` also removes the old
redundant packs and their sidecar files. Both commands exit
successfully despite the documented promise to list candidates without
rebuilding packs or deleting anything.

This makes the advertised preview mutate repository storage. The
tested blob remains available after both commands; this report does
not demonstrate loss of object content.

## Steps to reproduce

The following Python 3 script was executed with Git 2.56.0 on macOS.
It requires `git` on `PATH`, creates only disposable local
repositories, disables ambient Git configuration and hooks, and uses a
synthetic commit identity. It creates a 2,200,000-byte historical blob
absent from the current index, makes a filtered clone through a local
promisor remote, fetches that blob into a promisor pack, and snapshots
the pack directory before each preview. Each variant uses its own
fresh partial clone. The script removes its fixture after a successful
run.

```python
import hashlib
import os
from pathlib import Path
import subprocess
import shutil
import tempfile

work = Path(tempfile.mkdtemp(prefix='agent-work.', dir='/tmp'))
env = {k: v for k, v in os.environ.items() if not k.startswith('GIT_')}
env.update(GIT_CONFIG_NOSYSTEM='1', GIT_CONFIG_GLOBAL=os.devnull,
           LC_ALL='C', GIT_TERMINAL_PROMPT='0')

def git(repo, *args):
    command = ['git', '-c', 'gc.auto=0', '-c', 'core.hooksPath=' + os.devnull,
               '-c', 'user.name=Fixture', '-c',
'user.email=fixture@example.invalid',
               '-C', str(repo), *args]
    return subprocess.run(command, env=env, check=True, text=True,
                          stdout=subprocess.PIPE,
stderr=subprocess.PIPE).stdout.strip()

def inventory(repo):
    packdir = repo / '.git' / 'objects' / 'pack'
    return {p.name: hashlib.sha256(p.read_bytes()).hexdigest()
            for p in packdir.iterdir() if p.is_file()}

print(git(work, '--version'))
source = work / 'source'
source.mkdir()
git(source, 'init', '--template=', '-b', 'main')
(source / 'large.bin').write_bytes(b'LARGE BLOB\n' * 200000)
git(source, 'add', 'large.bin')
git(source, 'commit', '-m', 'Add historical blob')
blob = git(source, 'rev-parse', 'HEAD:large.bin')
git(source, 'rm', 'large.bin')
(source / 'tip.txt').write_text('tip\n')
git(source, 'add', 'tip.txt')
git(source, 'commit', '-m', 'Remove historical blob')
remote = work / 'remote.git'
git(work, 'clone', '--bare', str(source), str(remote))
git(remote, 'config', 'uploadpack.allowFilter', 'true')

for label, extra in [('dry-run', []), ('dry-run -d', ['-d'])]:
    repo = work / ('clone-delete' if extra else 'clone-preview')
    git(work, '-c', 'protocol.file.allow=always', 'clone', '--filter=blob:none',
        remote.as_uri(), str(repo))
    assert git(repo, 'cat-file', '-s', blob) == '2200000'
    before = inventory(repo)
    output = git(repo, 'repack', '-a', *extra, '--filter=blob:limit=1m',
                 '--drop-filtered', '--dry-run')
    after = inventory(repo)
    added = sorted(after.keys() - before.keys())
    removed = sorted(before.keys() - after.keys())
    changed = sorted(k for k in before.keys() & after.keys() if
before[k] != after[k])
    print(label + ': exit 0')
    print('candidate=' + output)
    print('pack directory: before=%d after=%d added=%d removed=%d changed=%d' %
          (len(before), len(after), len(added), len(removed), len(changed)))
    print('added extensions=' + ','.join(sorted(Path(k).suffix for k in added)))
    print('removed extensions=' + ','.join(sorted(Path(k).suffix for k
in removed)))
    print('candidate size after=' + git(repo, 'cat-file', '-s', blob))
shutil.rmtree(work)
```

## Expected behavior

The Git 2.56.0 `git-repack` manual says `--dry-run` should "List the
objects that would be dropped, one object ID per line, without
rebuilding any pack or deleting anything."

For both commands, Git should print the candidate blob and leave the
existing pack files and their contents unchanged. Explicit `-d` should
not cause deletion during this dry run. The fixture satisfies the
documented prerequisites: `-a`, a supported `blob:limit` filter, a
configured promisor remote, no operation in progress, and a candidate
absent from the current index.

## Actual behavior

The executed script produced this output. The counts include regular
files in `objects/pack`, and `changed` compares SHA-256 content hashes
for names present before and after.

```text
git version 2.56.0
dry-run: exit 0
candidate=faed553c77de798540bd1edc898e174bf4436b28
pack directory: before=12 after=16 added=4 removed=0 changed=0
added extensions=.idx,.pack,.promisor,.rev
removed extensions=
candidate size after=2200000
dry-run -d: exit 0
candidate=faed553c77de798540bd1edc898e174bf4436b28
pack directory: before=12 after=4 added=4 removed=12 changed=0
added extensions=.idx,.pack,.promisor,.rev
removed extensions=.idx,.idx,.idx,.pack,.pack,.pack,.promisor,.promisor,.promisor,.rev,.rev,.rev
candidate size after=2200000
```

The ordinary preview added four files, one each with `.pack`, `.idx`,
`.promisor`, and `.rev` extensions. The preview with explicit `-d`
added the same four types and deleted the 12 previous pack and sidecar
files. Both invocations printed the expected candidate object ID and
exited 0. A subsequent `cat-file -s` still reported the blob's
original size in both clones.

This report records one successful invocation of each variant in the
final script execution. A preceding fixture execution reproduced the
same counts. These observations establish the Git 2.56.0 behavior;
current development Git was not built or executed for this report.

## Evidence

- Expected source: Git 2.56.0 [Documentation/git-repack.adoc, the
`--dry-run` option](https://github.com/git/git/blob/v2.56.0/Documentation/git-repack.adoc#L217-L220),
which promises no pack rebuilding or deletion.
- Failure source: The inline script and its captured output in Actual
behavior. The before/after pack inventories show four added files for
both variants and 12 deleted files when explicit `-d` is present.
- Evidence provenance: observed
- Local verification: reproduced
- Reproduction completeness: complete

The primary violation evidence is execution of the inline fixture with
Git 2.56.0. Both commands exited 0 with the pack-directory changes
shown above. The manual and source links provide the contract and
supporting static evidence.

The release source at [builtin/repack.c, lines
356-394](https://github.com/git/git/blob/v2.56.0/builtin/repack.c#L356-L394)
guards the implicit `delete_redundant` setting with `!dry_run`, then
prints candidates when `dry_run` is set. Execution continues beyond
that block. This is a source breadcrumb consistent with the observed
results, rather than a required implementation change.

The original implementation discussion also describes dry run as
leaving the repository unchanged: [v5
1/6](https://lore.kernel.org/git/20260813200830.84348-2-r.siddharth.shrimali@gmail.com/)
and [v5 5/6](https://lore.kernel.org/git/20260813200830.84348-6-r.siddharth.shrimali@gmail.com/).

## Restoration check

Run the same fixture after a fix. Both preview variants should still
print the candidate object ID and exit successfully, with `added=0
removed=0 changed=0` and equal before/after pack-directory counts.
Retaining the candidate output distinguishes a working preview from
simply skipping the operation. The cached blob should remain
available. Use the ordinary command and the explicit `-d` variant as
separate checks of the same no-write contract.
