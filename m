Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7275272617
	for <git@vger.kernel.org>; Mon, 24 Nov 2025 07:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763969966; cv=none; b=rbPSQw/ipM7kw61qTedNvrKCcaWS7Dlvqve6jpUwCfqzRhA4JQ/GbLQexiRsPtbsl2Gug0ASerluB1XKhVkQD+K0JLIIvcd3Z5/sMExJwLRZeOqyadDJ+TiMbFpLCNNPOoC7yP8PF1dQfwk12yi8wCcYyF9+YwckoHmYb4/6beo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763969966; c=relaxed/simple;
	bh=XY3S5flhsgcabf6FM13XJvpPN5kwcfmC3xQAyBy9p8g=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Mime-Version; b=jtqovLQxUlYuZtg34RvbCmFYDlTbiu8g2e7j7EPNHauRCpZfS725gCx1MsHJNE57DlCDTysHEnAeTncb/mhKBuDahzvwChIDWKMxaXVysWHoi2EkwHHx/7hYlihtXZ29TRbFYd2uSj+X619/vzcrj00ELy4SM9/FyRIUI3rmnoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AViy71fw; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AViy71fw"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b6ce6d1d3dcso3499765a12.3
        for <git@vger.kernel.org>; Sun, 23 Nov 2025 23:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763969964; x=1764574764; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:to:from:subject:message-id
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TGTGTAriEa9KZp5IYWA5NEs3xDYpA69l8dBTstvf55c=;
        b=AViy71fwu5JCsUbjo6Tw1OdMlUwYslR4lhabn7cdoJkAkqC7Wg5OryGNAreO0YF2TN
         ooTQu+YpyEJ8cJIkSHliNNVEmn/GgHml/XBdgYu7SzjDf3r6oeOZOWgshwYnp71ezflU
         SIq2fvbrHMMkkf+FLJC1Mx8NbMUoNUNgJ4oNWTniRHHWcTAhjjJL+y3MASQSiEwsFRLH
         FCfQ1hm3O+TKqVSHcVy4HuOOqfh0I0f4UIls+QTrKDrmIiO3ZUpGPMjwzzR+1rPUcOpm
         1WpBcNRzzULMjchv+utVlSZbTz7cNjpaxFTWXwuc8WyGugLJ1HHz8hFTFgPliubr4s0l
         Hg3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763969964; x=1764574764;
        h=mime-version:content-transfer-encoding:to:from:subject:message-id
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TGTGTAriEa9KZp5IYWA5NEs3xDYpA69l8dBTstvf55c=;
        b=eSqgqyt14PmQ+dchTHwixrfW0Wmp7Ilk2KPARzGy+MUBKSDfHBx00In7wSAHpRdKkS
         hD0+Rx3qlKBL1+W2v0H1urJmC5szWM2oiQeDYMHn2ccxqnN4l3BCUZyqtUtAogJEF76F
         wY9S5DJpK7GhRv2C7HyUB1bIgidvn8fS2OIpzf9dmPxQki6Z5H4MEhDdKixZvWZX9jLv
         1rVXWMQ+LYUX+1117x6NDIQylh7j9Qgkaldhe6xpdX4h//d4zjW/pBrl0QzewS72aHb/
         o8VZVOk5i3GdjjcQY6Nty9UwrITvY17KD76k5+3Y7XKzzUQeHvqIusNubCxrrzOXGQhN
         Yu7Q==
X-Gm-Message-State: AOJu0Ywz/VMdmCODbbNlrzeS3sHz69z5g9MHC+go1+NfoquFdCyUzGZ6
	uA0IzrKQ6ukfzsBbMNHiMXCJbFJzD9Xy1gLOFV3IiVRE7GM2oI5MBGOkQYlhBDM6
X-Gm-Gg: ASbGnct5nPS/lW9F/0Vn8sa65wBvaEQwbnOXL54ukbrYiVRpOlKuT4mVp9marZLsi1+
	0HzaMF/5xFegdLg3w/2vF50K8DVO2cvqZVdE6IuFiWRQ6/yKiJlz4EQkYOleA/Sjx9q8YRkH151
	JylJFXYC2GrsFb78zlWryiXztPtiu9KoCRv7ow2X4yrroqXc/BRHy767+LOIHNaQVeXuTxbbqE1
	b0q6SPYfdQK7OE204xoEobQ236SJ9kjuI4LRpemN6mQClvFbhZCLXAiMd6rXFj2uCwBWlD7t4EL
	qVhmpLFFOcBUuuoJcpQ2ExA7ODqkqslW9E1h7N9jAfDQuePYP/EyIzl+Zj/iVseYBuBl6R2SxaA
	dr5JKBHfhFeeoGau/l5Pk4HduKDxmqi6mhrPM7H3O619d4AWjov+6avlfq+Mcj37JP24X0juaw4
	72P2282pgib98fDdmjq/3gMn2/i0wELfxjXF/n9YdY2pBx
X-Google-Smtp-Source: AGHT+IEI/Fun1BaP9XwWRau38cxFtUuZxb2spiU97JG1RFOA6Q1k4Q8t1HhNckxZJtqdkwoajRLSZg==
X-Received: by 2002:a05:7300:6818:b0:2a7:1863:b155 with SMTP id 5a478bee46e88-2a7192da182mr5011936eec.31.1763969963607;
        Sun, 23 Nov 2025 23:39:23 -0800 (PST)
Received: from localhost (c-73-71-230-225.hsd1.ca.comcast.net. [73.71.230.225])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a6fc4f6671sm63104586eec.3.2025.11.23.23.39.23
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Nov 2025 23:39:23 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Sun, 23 Nov 2025 23:39:22 -0800
Message-Id: <DEGR5XSM0EVG.27IMOKOK1O98Y@gmail.com>
Subject: Filter smudge for secret restoration: no disk access?
From: "Kache Hit" <kache.hit@gmail.com>
To: <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: aerc 0.21.0

I was working on a git redaction script that restores working copy
secrets when applied via `.gitattributes` clean/smudge filters, but
encountered `smudge` not having access to the "working file" on disk.

I see it's documented as intended in
https://git-scm.com/docs/gitattributes:

> Note that "%f" is the name of the path that is being worked on.
> Depending on the version that is being filtered, the corresponding
> file on disk may not exist, or may have different contents. So, smudge
> and clean commands should not try to access the file on disk, but only
> act as filters on the content provided to them on standard input.

Any chance there's a way around this or some alternative? Python
implementation below for reference.

And also for my understanding, why _shouldn't_ smudge access disk?

```py
#!/usr/bin/env python3
"""
Git clean/smudge filter for redactions that retains working secrets

If the following is in the repo as `bar/foo_secrets.yml`:
```
    foo_token: ##REDACTED##
    other: "not secret"
```

The local token won't be overwritten on checkout/restore:
```
    foo_token: secret_value
    other: "not secret"
```

Setup & example usage:

Save this file in repo root as `git_redact_filter.py`

`.gitattributes`:
```
bar/foo_secrets.yml filter=3Dfoo_token
```

`.gitconfig`:
```
[filter "foo_token"]
  clean =3D ./git_redact_filter.py --prefix foo_token:
  smudge =3D ./git_redact_filter.py --prefix foo_token: --smudge %f
```
"""
import inspect
import re
import sys
from argparse import ArgumentParser
from pathlib import Path
from typing import TextIO

REDACTED =3D '##REDACTED##'


def clean(workfile: TextIO, prefixes: list[str], out=3DNone):
    pat =3D prefix_secret_rgx(prefixes)

    for line in workfile.readlines():
        if match :=3D pat.match(line):
            print(match['prefix'] + REDACTED, file=3Dout)
        else:
            print(line, end=3D'', file=3Dout)


def smudge(repofile: TextIO, prefixes: list[str], path: Path, out=3DNone):
    pat =3D prefix_secret_rgx(prefixes)

    with path.open() as workfile:  # fails: FileNotFoundError
        secrets =3D {
            str(match['prefix']): match
            for match in map(pat.match, workfile.readlines())
            if match
        }

    for line in repofile.readlines():
        match =3D pat.match(line)
        secret =3D match and secrets.get(match['prefix'])

        if match and secret and match['secret'] =3D=3D REDACTED:
            print(match['prefix'] + secret['secret'], file=3Dout)
        else:
            print(line, end=3D'', file=3Dout)


def prefix_secret_rgx(prefixes_unsafe: list[str]):
    keys =3D '|'.join(map(re.escape, prefixes_unsafe))
    pat =3D rf"(?P<prefix>\s*({keys})\s*)(?P<secret>.*)"
    return re.compile(pat if keys else r'$^')


def heredoc(s: str):
    return inspect.cleandoc(s) + '\n'


def main():
    desc =3D "Git clean/smudge filter for redactions"
    list_arg =3D {'action': 'append', 'default': []}
    parser =3D ArgumentParser(description=3Ddesc)
    parser.add_argument('-p', '--prefix', **list_arg, metavar=3D'PREFIX')
    parser.add_argument('--smudge', type=3DPath, metavar=3D'PATH')
    args =3D parser.parse_args()

    if args.smudge:
        return smudge(sys.stdin, args.prefix, args.smudge)
    else:
        return clean(sys.stdin, args.prefix)


if __name__ =3D=3D '__main__':
    sys.exit(main())


import io
from unittest.mock import Mock

import pytest
from pytest import CaptureFixture


work_file =3D io.StringIO(heredoc("""
    foo_token: secret_value
    other: "not secret"
"""))
clean_file =3D io.StringIO(heredoc("""
    foo_token: ##REDACTED##
    other: "not secret"
"""))

empty_file =3D io.StringIO()
work_file_secret_removed =3D io.StringIO(heredoc("""
    other: "not secret"
"""))
work_file_lines_added =3D io.StringIO(heredoc("""
    new_other: 123
    foo_token: secret_value
    other: "not secret"
"""))


def test_clean(capsys: CaptureFixture):
    clean(work_file, ['foo_token:'])
    captured =3D capsys.readouterr()
    assert captured.out =3D=3D clean_file.getvalue(), "should be redacted"


def test_clean_idempotent():
    out, out2 =3D io.StringIO(), io.StringIO()
    clean(work_file, ['foo_token:'], out)
    clean(io.StringIO(out.getvalue()), ['foo_token:'], out2)
    assert out2.getvalue() =3D=3D clean_file.getvalue()


@pytest.mark.parametrize(['workfile', 'expected', 'msg'], [
    (work_file,                work_file,  "secrets should be kept"),
    (work_file_lines_added,    work_file,  "should retain secret"),
    (work_file_secret_removed, clean_file, "should restore redacted"),
])
def test_smudge_goal(capsys: CaptureFixture, workfile, expected, msg):
    path =3D Mock()
    path.open.side_effect =3D lambda: io.StringIO(workfile.getvalue())

    smudge(clean_file, ['foo_token:'], path)
    captured =3D capsys.readouterr()
    assert captured.out =3D=3D expected.getvalue(), msg


def test_smudge_idempotent():
    path =3D Mock()
    path.open.side_effect =3D lambda: io.StringIO(work_file.getvalue())
    cleaned, cleaned2 =3D io.StringIO(), io.StringIO()

    smudge(clean_file, ['foo_token:'], path, cleaned)
    cleaned.seek(0)
    smudge(cleaned, ['foo_token:'], path, cleaned2)
    assert cleaned.getvalue() =3D=3D cleaned2.getvalue()


git_doc_url =3D "https://git-scm.com/docs/gitattributes"
@pytest.mark.xfail(reason=3Df"should access file on disk: {git_doc_url}")
@pytest.mark.parametrize(['workfile', 'expected', 'msg'], [
    (work_file,                work_file,  "secrets should be kept"),
    (work_file_lines_added,    work_file,  "should retain secret"),
    (work_file_secret_removed, clean_file, "should restore redacted"),
])
def test_smudge_actual(capsys: CaptureFixture, workfile, expected, msg):
    msg =3D "[Errno 2] No such file or directory: 'bar/foo_secrets.yml'"
    err =3D FileNotFoundError(msg)
    mock_workfile_path =3D Mock()
    mock_workfile_path.open.side_effect =3D err

    smudge(clean_file, ['foo_token:'], mock_workfile_path)
    captured =3D capsys.readouterr()
    assert captured.out =3D=3D expected.getvalue(), msg


@pytest.fixture(autouse=3DTrue)
def reset_files():
    for file in [work_file, clean_file]:
        file.seek(0)
```

Thanks,

Kache
