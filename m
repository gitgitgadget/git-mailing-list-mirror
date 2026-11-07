Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794040971;
	b=wBwfcU5+j5Q7Pq/Wmt3eOJAfCi9rJOGQapgt77p9BFTimbyV7+eDRaLtmZE1sAXJhsQ4
	 wwZub+io13tXstyfbla8L+agi46nWr+nLf5SPiAD/FQN7CFPBOXg30UaUb7CY025yD8PQ
	 VWSXIFLRBke4PxMbTf/b3uf9rp+Ood36e6LljstN+ZINbLk67WQnZpigrTcPXBybRzD5P
	 4XF+83y9AUXI3BNRuD9i9Gvc/BYB0eyWBlx/9yrXIGKw2i8Apisw5bGcg3Ds9LU/3w4WU
	 reVqIn0+DPIinqoWLzbDuP2xM1BlT1Iw7VQjNhgMc2AvSQejwl6rHadaen7R2kcjY8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794040971;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:From:Date:
	 Subject:Fcc:Content-Type:Content-Transfer-Encoding:MIME-Version:To:
	 Cc;
	bh=Lni+1JfhtUeoEItKnb2vPNig8UW0J0EwfBYzHie0Cfw=;
	b=0mNSZ0QE+dqrD8tPffMLxUdiXwxZvlpqdtDx1cVKvW+c7QMKPMzdAjCE737MEZ9LK3Oo
	 KCPoo21XjBVv/nMEAfyR5UOCdykBKQKtKZEfgKhgY5kTkmp+RLDWbk40e5usXoaQdolRS
	 Uz9ikNgpMYZIZ2MrfVILGaxDnjXG77ORrz2/56P5y0PvPfTwEZ+/r0jhRqsN92h9dhn5u
	 SS9RQUabu8gDfAKWzIR68dsFwDKJ/fStkpCC1JaogacgPymT+r+mhBAXoZFbdAo6ty9e+
	 Ad+o6cK2g1GREKbhzTqzYKKPZXnISV/TCBRTQ2ZecREgpMWpxQQlH6YuUkiwT7SyDZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wM1kiU+R;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255DB606A326
	for <git@vger.kernel.org>; Sat,  7 Nov 2026 08:42:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 255DB606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wM1kiU+R
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ea7190aea1so5606005ad.1
        for <git@vger.kernel.org>; Sat, 07 Nov 2026 00:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794040970; x=1794645770; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Lni+1JfhtUeoEItKnb2vPNig8UW0J0EwfBYzHie0Cfw=;
        b=wM1kiU+R7sZ8f+l5qXM+ocmFdLvUf4xz32FEUq8D51hcvd88dziktzE+esMG2f/ks7
         e7/uSzvyQEhqh0DtyFEJyRxQuCESeLOJvZ39CbJ3dtlxLsjrrwlKpjWxIIeDUM87jJby
         TjgWhQUQJ5qAK0j6gW7GDa5bqpfyoX2fCenDWj+pR5PqvKES7GdjVhBdQ94wf31k7MBO
         yYGQ4Ma3e3C8MVweGnovmyAGaOKKxHSudeyQ8piDYIWmXm7T4cBtEQH+A/xk3p42s6AI
         tn5l/3Sf3LI9GS57VyxLLl88RYzYZOanZ40eDhYrWCQtTaSyibp6pOkdLpTNppr2MYi8
         qBdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794040970; x=1794645770;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Lni+1JfhtUeoEItKnb2vPNig8UW0J0EwfBYzHie0Cfw=;
        b=s7wTEgIos6mXUriwfUnww1GW1lfmPf5bMhZ8F1Rs4CebCq7fTf82658NgUiD8Y3mqH
         TLsA7jUZt6zRW+OVHoL7RB4DY4i4mUOJHHJcvdhjno3YKTUgk2ePvsIKahw02HTgkrjm
         jQXPZ0LShsJ6eO4AEYP0g58KX6zsplYPHK3WD7Ezc4SN5x3apCZWfCF1C1VO28VbYmJp
         Rxslquyp8S1jVcme4eW/JnNPGFxOrfACXcYHNxHu9eQTPK8VinOZuaKU7TkRNmqGnyMn
         mzxSXXxL2xLOp2pXd3k2aVTsWD7l/FmJmlPtKuQ3yBaEFjgpiDLRV8c3lW4s4FCELXlH
         0L6g==
X-Gm-Message-State: APuU4Z+4Cpkj3GM8C9PPgRI0z4hXMLNwFmoK56KEAvhTGXCjpHpzQZ99
	rOQsC8hzWNEVJmqE+OOg2ilqPGy/vJXVcfTtgDX9XhVt14D+KTplKaxF0cOOjQ==
X-Gm-Gg: AYBFou3EI1yzEnBveZTqkdC7shiHeIudiaEk/1Wt/1tV+K6CkN/rJSLaYOBDKTDuO/I
	GPnmnPR1PW2rQ94sGiqO7eSKCT2LNzYCMSBk0k6Ly9lkQMnfzbQnYcV2LgT4B5w7cO6rokyNsyT
	VOLIxyhHEIgDd0tiEJpFQu8vaxMTyCOck55+6t8P8jnDdmzx5eg8vv5eq0RS+Z7+Yi9/f37ufyb
	Xr+lFWZt9ZR0+MDfgQmyhLM2aqtEBBl+FUyzZCcbyXn0A1dyBOLZqetj1Pm7cJwkn/J+DCt3Fi/
	f+orZ5sdbcHJZdfFKQOcnFhbMMOcytk59OXh0fdrWQB/+2muW1Edg9g38FuEwo2WIUCXsLE3sW7
	BBrEv0KLv7f0jUW3jCSuSwKl8MrwhwAMYbSSHi4nMynNir7+So5VdlSxHbimez3ZkkQi+4Hsk1/
	r/Vvu3DFiCNXRpavFEUNv98J9AcH+u0gMEAb2aAEBNXxu7gGS8i6UbVUUdQ653QQJQ/dA9gdd9w
	LMS4lxapp/49yZi/EZTtdYnMMNd1FJv6Gi7rIqRvaaskDi32A6ZDsTfDQ7xHwiJI4nerHCz21Md
	28IqoxGzlIuC8eS4JvD/mLVbBYrtlsgnsA==
X-Received: by 2002:a17:902:e74c:b0:2e9:821a:5527 with SMTP id d9443c01a7336-2ed40989cf4mr57438665ad.12.1794040970443;
        Sat, 07 Nov 2026 00:42:50 -0800 (PST)
Received: from [127.0.0.1] ([52.156.141.210])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed47d9d353sm11878415ad.70.2026.11.07.00.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 00:42:48 -0800 (PST)
Message-Id: <pull.2297.git.1794040967.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 07 Nov 2026 08:42:32 +0000
Subject: [PATCH 00/15] Fix segfaults on settings given without a value
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
    Jeff King <peff@peff.net>,
    Taylor Blau <me@ttaylorr.com>,
    Derrick Stolee <stolee@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Colin Hinton <colinlewishinton@gmail.com>,
    Matt Hunter <m@lfurio.us>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Usman Akinyemi <usmanakinyemi202@gmail.com>,
    Miklos Vajna <vmiklos@collabora.com>,
    Junio C Hamano <gitster@pobox.com>,
    Thomas Bachem <mail@thomasbachem.com>

A setting given without a value, as in "git -c foo.bar" or a bare "bar"
under "[foo]", is passed as NULL to the code that reads it. In these places
git does not check for that and segfaults:

 * rebase.missingCommitsCheck in "git rebase -i"
 * core.alternateRefsCommand and core.alternateRefsPrefixes in "git fetch",
   "git receive-pack" and "git rev-list --alternate-refs", in a repository
   with an alternate
 * the color slots of "git add -p", "git add -i" and the other interactive
   patch modes
 * fetch.bundleCreationToken in "git fetch" and "git clone --bundle-uri",
   with a creationToken bundle list
 * grep.patternType in "git grep", "git log" and "git show"
 * remote.*.tagOpt in "git fetch", "git remote" and "git status"
 * color.blame.repeatedLines and color.blame.highlightRecent in "git blame"
 * branch.*.mergeOptions in "git merge" on that branch
 * remotes.* in "git fetch" and "git push" of that remote group
 * safe.bareRepository in any bare repository that git discovers
 * bitmapPseudoMerge.*.pattern when writing a bitmap, as in "git repack
   -adb"
 * scalar.repo in "scalar reconfigure --all"
 * remote.*.url in nearly every command, when an includeIf
   "hasconfig:remote.*.url:..." section exists
 * mode, heuristic, uri and creationToken in a bundle list, in "git clone
   --bundle-uri" and "git fetch"
 * any key at all in "git config list --type=color" and "--type=expiry-date"

These turned up in a check of every config callback and every caller of
repo_config_get_value(), and in runs of two dozen common commands with each
key that "git help --config" lists set without a value. There may be more in
code that neither method reached.

Most patches reject the missing value with config_error_nonbool(), as
ba176db511 (config: handle NULL value when parsing non-bools, 2023-12-07)
did for other settings. Three accept it without an error: a missing
fetch.bundleCreationToken counts as 0 (patch 4), a remote URL without a
value matches no includeIf condition (patch 13), and "git config list"
leaves the key out (patch 15). The crash fixed in patch 14 can also come
from a server, through a bundle list it advertises to clients that use
bundle URIs. It is still a plain NULL dereference. Only patch 15 fixes a
regression, which came in with 2.54.0.

remote.*.followRemoteHEAD without a value crashes the same commands. This
series leaves it alone, as ch/remote-defer-follow-remote-head-validation in
'seen' already makes it safe, checking the value only where fetch uses it.

The series is based on master and merges cleanly there. In 'next' and
'seen', t5618 conflicts with iw/connected-deepen-fetch-no-alternate-refs,
and in 'seen' also with kk/quarantine-alternate-refs, as each adds tests at
the end of the file. Keeping both sides resolves it.

Thomas Bachem (15):
  rebase -i: handle NULL value for rebase.missingCommitsCheck
  odb: handle NULL values for core.alternateRefs* config
  add-patch: handle NULL value for color slots
  bundle-uri: handle NULL value for fetch.bundleCreationToken
  grep: handle NULL value for grep.patternType
  remote: handle NULL value for remote.<name>.tagOpt
  blame: handle NULL values for color.blame.* config
  merge: handle NULL value for branch.<name>.mergeOptions
  remote: handle NULL value for remotes.<group>
  setup: handle NULL value for safe.bareRepository
  pseudo-merge: handle NULL value for bitmapPseudoMerge.<name>.pattern
  scalar: handle NULL value for scalar.repo
  config: handle NULL value for remote URLs in hasconfig includes
  bundle-uri: handle NULL values in bundle lists
  config: handle NULL values when listing colors and expiry dates

 add-patch.c                     |  2 +-
 builtin/blame.c                 |  4 ++++
 builtin/config.c                |  4 ++--
 builtin/merge.c                 |  2 ++
 bundle-uri.c                    | 12 +++++++++++-
 config.c                        |  3 ++-
 grep.c                          |  2 ++
 odb.c                           |  4 ++--
 pseudo-merge.c                  |  4 ++++
 rebase-interactive.c            |  2 +-
 remote.c                        |  7 ++++++-
 scalar.c                        |  5 ++++-
 setup.c                         |  2 ++
 t/t0035-safe-bare-repository.sh |  6 ++++++
 t/t1300-config.sh               | 32 ++++++++++++++++++++++++++++++++
 t/t3404-rebase-interactive.sh   |  7 +++++++
 t/t3701-add-interactive.sh      | 12 ++++++++++++
 t/t5333-pseudo-merge-bitmaps.sh |  5 +++++
 t/t5505-remote.sh               |  5 +++++
 t/t5506-remote-groups.sh        |  5 +++++
 t/t5558-clone-bundle-uri.sh     | 20 ++++++++++++++++++++
 t/t5618-alternate-refs.sh       |  9 +++++++++
 t/t5750-bundle-uri-parse.sh     | 16 ++++++++++++++++
 t/t7600-merge.sh                |  6 ++++++
 t/t7810-grep.sh                 |  5 +++++
 t/t8012-blame-colors.sh         |  7 +++++++
 t/t9210-scalar.sh               |  5 +++++
 27 files changed, 183 insertions(+), 10 deletions(-)


base-commit: 6de20f6092dcf9bdb1c8efe03db4b70c82b423dd
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2297%2Fthomasbachem%2Fconfig-null-value-segfaults-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2297/thomasbachem/config-null-value-segfaults-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2297
-- 
gitgitgadget
