Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25EDDDC5
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 01:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760058853; cv=none; b=HH3abpDCdnhHoHLZCOpsUgIz6JqWfYBJxMVnI6TGZQBmDkKNylfs3zVYimGLixsEgLx2/jwrOJ/Ss4zW9kKlAGPSsQJZum1u98Wz8d1ymLvL9cJ8nrGpwRzBD0HjtsNoivD4z5MwhrlpbSZ+Y/XVHtNnKjEOxcNyyZKsPwDLh5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760058853; c=relaxed/simple;
	bh=RoOwfP+UaOqNl8CzTPhIXmCuCrslfl+Loidd47ClR/w=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=Uf1cg68cNbN7NcTrVe54No/TL+FgHUSP/JXcGemclhx8WzCB38xHMZ98Ig5QuLZFi1sVV1QJHYfRN7MtUF2Flm7G9hqYdQQwlp+PzqbnsU0Gnl3bfvZ54188jQcfzvkmcTkzzWR1ICMOAtsxj9NOYZdgVz2SukZXH9QSvDbaSLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jqQf+6K/; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqQf+6K/"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4df0467b510so17374001cf.3
        for <git@vger.kernel.org>; Thu, 09 Oct 2025 18:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760058850; x=1760663650; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3pt+65BmYcw32SE+HH73hd7v8JrHFHvl/E3fLzfThsw=;
        b=jqQf+6K/J4v9wfm7TPrKTrb6kkfnftT1DtHSw9J5OHvYV2c82tz2QxFbz/OB82gqWI
         +60SjIwe1V2b4CSkaT5euo2RLZQxEd+JIls19lYT85DoMA1CbaTkZEkQf2v/S7SGxAeu
         GEQnhKVtYwncWMdPCkhY9JqmzMWQijiIcVRsNRfkPwXPFAU1FZ/NcnwaVog2SEOrEzDP
         /cTjqiupwaA8hTz5rfdJtiQ3iHJKMgiN7G2lmAuC2ygZaz8crmM0iVj92Ep5rM/jDlUs
         C15PtxNQXxmbRSx4zqoGy3L4nD44agFOoyFXWCVsvgRdM1+VTR2Vzevpg8XhBciOms6k
         WEAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760058850; x=1760663650;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3pt+65BmYcw32SE+HH73hd7v8JrHFHvl/E3fLzfThsw=;
        b=scApJMrlMI/R3KoMbHzp7ebTq2WhEzIZzTh3zKE72bD2mNH7A4U+e3k23WG3IyCgsm
         eJ9UCg4v07HGlCTBxHSrSA+ltNhojvc1XhNT2sK+gEcj5YfyvJimi3NrYhMfxDJSUZ5d
         h/Fw8XrJzIXca0M9kPgD+DYCyUKblFj/pHKbKjnAZfggcS7g42uSd5phQkdlVnXgOUon
         fvD1aGzVNpGvnkU+MS5qR63fc6zgWrAmMDNfNS31CWTrr/ls70i6Eu4MOnCoA2KBnM6w
         E7E0e0EXvJAJ8DxEYDR7iJqdI64uYcdSrF1lrOYm8LdsZgx+alc8qdN/odJEp78D+FX+
         w2Bg==
X-Gm-Message-State: AOJu0Yz2swbe4BdkdVF6oJLJAxHYqZohHc8guVoE+59pEY/QAlCxiS8w
	ctq6X39RGAvHIEvePhb34IEgFIpu9tT62KfjmfXg5d/F8rkEHCmPy7hbwN/Ncw==
X-Gm-Gg: ASbGncsn2HBaXXrTAZNIAbjxpxTzjwumvXvfA7XBxtHaksvxifuABHMpkES3AlnWfGP
	Cnacve6alKbcYiX13bHnwBVb3uZdwo/UsHJynddwqCk75G3U3rrLplaLbAMG6xG3dfM3BWWEHx/
	vE3hIoRtODksn8BQKGQUpzssrwAfHARxiV07AoxKOQ5fApHr+iwdTpMnYlGURDDT5AygIHkLp1F
	sc8AuCU7481NYt59Krd8byqPRDaQK4tn+iAQI2LVF7XNg6K2pB0U1uSQOo6dfbL+Cg2F6OayMVT
	/Nv6q/mOOt+I/4UUApwrmzYETVsusdtbKlaRp7U3oHWjTmC75Kaf0Kq65BkgW3GccKYdrXpgP2H
	JB9Kb9S+myFUnAAIRAhNEJG2Cpyu8LCcBAHgbKITR0Q==
X-Google-Smtp-Source: AGHT+IFfkNOSreJ9xOlRVw5CrgGwbnLuE9EwG9MQxJHiio4FvrhS/iOkinl42CvX9ygCfGFtkK2keA==
X-Received: by 2002:a05:622a:164d:b0:4d8:afdb:126d with SMTP id d75a77b69052e-4e6ead4a1cbmr125007741cf.43.1760058850325;
        Thu, 09 Oct 2025 18:14:10 -0700 (PDT)
Received: from [127.0.0.1] ([20.161.60.18])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e706da71fasm8025631cf.32.2025.10.09.18.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 18:14:09 -0700 (PDT)
Message-Id: <pull.1938.git.1760058849.gitgitgadget@gmail.com>
From: "Delilah Ashley Wu via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 10 Oct 2025 01:14:05 +0000
Subject: [PATCH/RFC 0/4] config: read both home and xdg files for --global
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Delilah Ashley Wu <delilahwu@microsoft.com>,
    Derrick Stolee <stolee@gmail.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Patrick Steinhardt <ps@pks.im>,
    Delilah Ashley Wu <delilahwu@linux.microsoft.com>

Hi!

As reported in [1]: `$HOME/.gitconfig` and `$XDG_CONFIG_HOME/git/config` are
both valid global config locations, but `git config list --global` only
includes the former in its output.

Suppose we have this config in `$HOME/.gitconfig`:

[home]
    config = true


And this config in `$XDG_CONFIG_HOME/git/config`:

[xdg]
    config = true


Then, to reproduce the issue that `--global` only shows the home config:

$ git config list --global --show-scope --show-origin
global  file:/Users/delilah/.gitconfig    home.config=true


Git correctly applies the XDG config in its effective configuration, but it
doesn't show up when `--global` is specified. We can confirm this by
checking the output without the `--global` flag:

$ git config list --show-scope --show-origin
global  file:/Users/delilah/.config/git/config    xdg.config=true
global  file:/Users/delilah/.gitconfig            home.config=true


The expected behaviour is both configs should be shown when `--global` is
specified, so we'd expect its output to look the same as above. This was
confirmed in [2], which quoted the `git config` documentation:

> OPTIONS
>     --global::
>         For writing options: write to global `~/.gitconfig` file
>         rather than the repository `.git/config`, write to
>         `$XDG_CONFIG_HOME/git/config` file if this file exists and the
>         `~/.gitconfig` file doesn't.
>
>         For reading options: read only from global `~/.gitconfig` and from
>         `$XDG_CONFIG_HOME/git/config` rather than from all available files.


The first patch fixes forward slash normalisation on Windows paths. The
second patch introduces tests and regression checks. The third and fourth
patches implement the fix to include both config files when `--global` is
specified. Johannes has kindly pre-reviewed this patch series via GitHub on
GitGitGadget #1938 [3]. You'll notice some force-pushes after the review,
but I only changed commit messages.

[1]:
https://lore.kernel.org/git/CAFA9we-QLQRzJdGMMCPatmfrk1oHeiUu9msMRXXk1MLE5HRxBQ@mail.gmail.com/
[2]: https://lore.kernel.org/git/xmqqmt5lezi3.fsf@gitster.g/
[3]: https://github.com/gitgitgadget/git/pull/1938/

Thank you all for your time!
Delilah

Delilah Ashley Wu (4):
  cleanup_path: force forward slashes on Windows
  config: test home and xdg files in `list --global`
  config: read global scope via config_sequence
  config: keep bailing on unreadable global files

 builtin/config.c     | 12 ++++++++
 config.c             | 54 ++++++++++++++++++++++++++----------
 config.h             |  2 ++
 path.c               | 10 +++++--
 t/t1300-config.sh    | 65 ++++++++++++++++++++++++++++++++++++++++++++
 t/t1306-xdg-files.sh |  3 +-
 6 files changed, 128 insertions(+), 18 deletions(-)


base-commit: ca2559c1d630eb4f04cdee2328aaf1c768907a9e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1938%2Fdelilahw%2Flilah%2Ffix-config-list-global-home-and-xdg%2Fpatchset-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1938/delilahw/lilah/fix-config-list-global-home-and-xdg/patchset-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1938
-- 
gitgitgadget
