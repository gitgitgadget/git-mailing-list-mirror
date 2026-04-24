Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204771AA7A6
	for <git@vger.kernel.org>; Fri, 24 Apr 2026 15:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777042948; cv=none; b=al/4g4gxPbAElRmm+3fGiyccsO8GUqUnzY2VOI2wC6DGZ/DlPjUivY7fuGiuLRaqv94nhxNXvPS8WmECOCILx0E08UFqgqpN7aK8JbDWj0YE33vd4tJZy4wUEB7ReioAVqXSnUzCyYnW+vpJrw80FOdtyq/twV5KMiftL/Ota2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777042948; c=relaxed/simple;
	bh=BGxmQVA4lJOHGxeTk6nkqTAjQ59/43TGROABe6fQFHU=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=RXyIrZaWr4WdOeC3Ap7UdXpoRlnJA4laWjTCLb066kbzVHbXyWmCRpzikZ4Ccy2MGLsE3/tk85tWfO5SrjKk7XwctHJc4e9SveNh1y4d/c2CoHjuJwI12j0HyPF1knW40mQSzCN93Py8wMwN2D+booZKGCQYiUE197+tn4XVO6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=meFyLlii; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="meFyLlii"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6949831a7bcso2403438eaf.1
        for <git@vger.kernel.org>; Fri, 24 Apr 2026 08:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777042945; x=1777647745; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JVfF0FsgTeeOjyo11cKc2/xqL2yQCXgKeZzcYgiTaMU=;
        b=meFyLlii886pphf0QDD4LrFWxV7//lvIHVRhHL7MVVYURtNu7i1wBXHmMshMObsrtH
         WxG+tcpYTwkeB0NFh2piWUa5VS6ogd+ZuntXvmaS560LQBEy/BIX7CZ0d920F7GkESoO
         uoVhX+VLlBKXSMunzW1rjPu+P/VyNcZBC9RJ01lh+JfEgfEzYBpOanhnmrBET6bzAu49
         nVPSSWpLZZhMobthF4Ip1Knm8bzJyrjqlorbITMqklD4D+kpMEu/IJ1zlnt06NMTidDg
         2+nR8Ee8hs6O26L8Uu0+UAAY0ssTEQLCUMPgey23czG3UiyiySuM5joai7EN88SeUgk3
         p3Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777042945; x=1777647745;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JVfF0FsgTeeOjyo11cKc2/xqL2yQCXgKeZzcYgiTaMU=;
        b=KVuWNLMouyWixcoCdj5/MgLra4WtaOvxDUJT8UIojTSVMQMuWite2F6LL3N9/SI6pH
         iRfDmys3jwANRPJYJPl2kSQxsJFxqAIIyRIwv1QYhOi6zY/3tsx9omYrB8cLzjUoc7QW
         pO038X7hZwKbfIvZ6FgRCg5KBgsgt8rvXiS+W4H+hVcEXTcw9nk2/0tXn7gwKKwwvaVm
         GFMxdXioL7NIGVl7SU44em67oBh+AZnJOCNfPlkwt9vrKKfmKvm5Ew8V2bwt21Gs6aX1
         LdOCe6YLLxrdExJ9Sjcky5fLj+KvtYIInudEk8OuWsSqdrq+3WxV+YQF8Q6X86GKQtZ8
         8F4g==
X-Gm-Message-State: AOJu0YyHAvx1Kb6E/eESj7DvchtfRCxIfGbZPbcWx6BxETOv9Yj17VoB
	1CSv7CgWWsZJHRwbXA66ocRyxwWNIg+fIUmcy1TSOtCGUSHINzWv81TUpvMZDA==
X-Gm-Gg: AeBDieuno/T9CDNRLb2JRDm+98r4oeKr41EB+V2QNQi98e8MJHYPkgqXQeRztx76gdN
	vubU66nttPeAYDtIvkTFXoMg2Al2wmWLasMExKcLlASBbe+pnLA7rtAXxG7DCW8CLZmipabVscU
	2IhG4zp2kIsV1E2BaBa1gGkZeGof1yG4a/wF/dayJL9lAHUGEeDGklZuItO3gspV9fNCuo+qz1u
	k0pAj/qmAv3V4XrJfrIB5X5bm1Aqob5AmAhdkw1UayzTQfY1xd3W9pUlWo9sgwsygVFI3x3LAVL
	BMR96IAhMSEmHI/n6pci1P7kfJvkeBAyTZpAps33aKPiiqQBXb5/F8cPrUHsyZog3wJwxUcZIJT
	EQYnpCAPaL2x46xaQo4D4JxRzO9mWF7Y0BntmDy0XUQMtXNSyDsgHsoOUg6k9nZWZ0V8VZiRsjg
	Pcwm8hhKYlmHmBq7V/b496i9M7CMkU29lewRN11Q==
X-Received: by 2002:a05:622a:698f:b0:50e:5de8:6458 with SMTP id d75a77b69052e-50e5de873a3mr219464941cf.57.1777042878599;
        Fri, 24 Apr 2026 08:01:18 -0700 (PDT)
Received: from [127.0.0.1] ([48.217.251.133])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e392c7994sm200589611cf.4.2026.04.24.08.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 08:01:18 -0700 (PDT)
Message-Id: <pull.2098.git.1777042877.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 24 Apr 2026 15:01:09 +0000
Subject: [PATCH 0/8] safe.bareRepository: default to "explicit" with WITH_BREAKING_CHANGES
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>

This supersedes my earlier series [*1*] which took the approach of adjusting
individual tests to access bare repositories explicitly.

As Junio suggested [*2*], this series instead takes the approach of setting
safe.bareRepository=all in the test environment's global config whenever
WITH_BREAKING_CHANGES is in effect, so that existing tests continue to work
without individual modifications.

Implementing this turned out to require a number of follow-up adjustments,
because writing to $HOME/.gitconfig has side effects beyond the intended
setting: $HOME is the trash directory, which doubles as the test
repository's working tree, so the file shows up in ls-files and status
output, and tests that manipulate $HOME/.gitconfig for their own purposes
can clobber or remove the setting. Patches 2 through 7 address these
interactions in the affected test scripts.

The final patch flips the safe.bareRepository default to "explicit" under
WITH_BREAKING_CHANGES.

Footnote [*1*]:
https://lore.kernel.org/git/pull.2076.git.1775140403.gitgitgadget@gmail.com/

Footnote [*2*]: https://lore.kernel.org/git/xmqqse98cc51.fsf@gitster.g/

Johannes Schindelin (8):
  test-lib: allow bare repository access when breaking changes are
    enabled
  t7900: do not let `$HOME/.gitconfig` interfere with XDG tests
  t1300: remove global config settings injected by test-lib.sh
  t1305: use `--git-dir=.` for bare repo in include cycle test
  t5601: restore `.gitconfig` after includeIf test
  ls-files tests: filter `.gitconfig` from `--others` output
  status tests: filter `.gitconfig` from status output
  safe.bareRepository: default to "explicit" with WITH_BREAKING_CHANGES

 Documentation/BreakingChanges.adoc            | 24 +++++++++++++++++
 Documentation/config/safe.adoc                | 10 +++++--
 setup.c                                       |  4 +++
 t/t0035-safe-bare-repository.sh               | 10 +++++--
 t/t1300-config.sh                             |  7 +++++
 t/t1305-config-include.sh                     |  4 +--
 t/t3000-ls-files-others.sh                    |  4 +++
 t/t3001-ls-files-others-exclude.sh            |  3 +++
 t/t3002-ls-files-dashpath.sh                  |  2 ++
 t/t3009-ls-files-others-nonsubmodule.sh       |  1 +
 ...common-prefixes-and-directory-traversal.sh |  3 ++-
 t/t5601-clone.sh                              |  4 ++-
 t/t7060-wtstatus.sh                           |  3 +--
 t/t7061-wtstatus-ignore.sh                    | 27 +++++++++++++++++++
 t/t7064-wtstatus-pv2.sh                       |  1 +
 t/t7104-reset-hard.sh                         |  2 +-
 t/t7508-status.sh                             |  4 +++
 t/t7521-ignored-mode.sh                       |  1 +
 t/t7900-maintenance.sh                        | 12 +++++++--
 t/test-lib-functions.sh                       |  8 ++++++
 t/test-lib.sh                                 |  6 +++++
 21 files changed, 127 insertions(+), 13 deletions(-)


base-commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2098%2Fdscho%2Fsafe-bare-repo-default-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2098/dscho/safe-bare-repo-default-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2098
-- 
gitgitgadget
