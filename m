Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513A01CDA27
	for <git@vger.kernel.org>; Fri, 15 Nov 2024 13:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731678157; cv=none; b=lMh9RLVoqx/SqdOwZSvim0uTqJtCtNEx27cLkY7/OdXkL6Q0sEoKFl9bIPo4lhRQxLjQFpAqvFDGyBhPwZgfdwSgi6EK+NRuj9xhedYb2qh1zNLbubAhXiKw6QiyqV2dECShWgDL7sfyWBB7enxQn0fUIhSvU/2tTDkbrx7W72M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731678157; c=relaxed/simple;
	bh=bTyqkq2s9qrFOib2+N3hR2UT7FBnngb1hTT3MRDfjKw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hs+pzPISyQ1YsO9BwAaUDJ3MwiV8qIFu0U04vXtKchKYQir51Gdr1poXuLaj22ZpFJj0TjyjZacGEFe0O0+y5x3E9eK1kRc1/BLdSgBfE3+GbkLreCH7VsBqB7JJ78NZiphKvZHP+5VvWqqWJ1KXAY9bl+9Bt0wB3ds0vZkpwBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mgdgKlb7; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mgdgKlb7"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a99f646ff1bso254415666b.2
        for <git@vger.kernel.org>; Fri, 15 Nov 2024 05:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731678154; x=1732282954; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pqHRD0gRX9A4dAj8F6W5iSCGnH5IpygXPp0VAj4zCmo=;
        b=mgdgKlb7RORtTxZSkB8nC9VX86V55PEqANLuddFS1ieNbO6onffcsXtBkXr77thYFV
         WT9F70hew9jbn7Tsm5bIt2bfMG8hk2/oaVttTpwJ14k9J1452Ir9wGQsZBy1IZYQQc+7
         eYlLinSoWzAfv/1gfVEFfkiPTeDLb8XOYjSAtCakaThQk+frtGEUH4hpCwcOtuIAV1/4
         qVlFasQqqkZJl23SjHjtp63yO1a2id9fDnDUXz4NvB0KBie7n1r5XoWTIcTWWiqPyjK0
         yZJM+WqSvhJLCoumKx+sjadVVdS9YrANiNfiypxncMGt6hJZQE65ejRlMI6ngM5Kbt6K
         DQ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731678154; x=1732282954;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pqHRD0gRX9A4dAj8F6W5iSCGnH5IpygXPp0VAj4zCmo=;
        b=E723TW27jq5UC/cDI27pY5YnNqVBm9CA7kKl5u/lehc4NvA+tkj5d5rShIToleXynq
         kuNhXikBJ0dPShVuu9ptmYzW1L3mkm/NqtreezWOJd1bK59qWguGqwo6A69hOBGI3f0+
         ki2C9oynn3bWEFGvIBxUF0W8LHBbxmy6pdgcsRS1oVoHVnOey77Ra/WKpa8bykA+4sgJ
         GqquqDLMCmREXP2tfWw3Uv1eR0XeyeyrCiSad/POAXNJWjFDEWcPnMpQElnWniuoDTR5
         OsFzQBkAw0xZ81ID2l08qq4ilfhPzqBoFRLW/LZRxp+B9Fd3VL3vhKDcnhrq0BbW4mgt
         55hQ==
X-Gm-Message-State: AOJu0YzioFvHQkpAPpg/bUSYuowix0OHIiMoFZ29TknKNAT1k91Hfjur
	WINvKAtbJ75as+gjaMZc5AU3IgvYBxLi5g2qmLSInz9lsfqvnKRu
X-Google-Smtp-Source: AGHT+IFQCK0/Epel3n7Heak7I7F+dO4eawnPpoRRH0SXAn3uoPSmYxQ/nEhag+lWj07m11g/wRD3zA==
X-Received: by 2002:a17:907:7b9d:b0:a99:36ab:d843 with SMTP id a640c23a62f3a-aa48350b024mr248077066b.38.1731678153342;
        Fri, 15 Nov 2024 05:42:33 -0800 (PST)
Received: from [10.82.5.93] ([217.110.80.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df26a69sm180753966b.34.2024.11.15.05.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 05:42:32 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 0/8] Change midx.c and midx-write.c to not use global
 variables
Date: Fri, 15 Nov 2024 14:42:13 +0100
Message-Id: <20241115-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v1-0-761f8a2c7775@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALVPN2cC/yWO3W7CMAyFX6XK9RwlTRmlQtPeY+LCTd1i0SQsy
 RgS4t3nUV+dH+n4e6hCmamooXmoTDcunKIY+9Yof8a4EPAkXrWm7awcuH0HmWb0NWUIPN3BA8Z
 pk7+ZK0lQE8RUYaIrSZUiLGsacYVSUXrs++7Q+3Z3MLOSR1fZ4/sL4uu0+UzfP8JSt1AFKgVfL
 ENz9OlGWdu9s651bmf0wlVfMNczX7Tt+88lIK/ap/Dxvz5iEaQUAtehGZ2dx3dnvFGn5/MPPi8
 gof4AAAA=
X-Change-ID: 20241111-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-a88498c2590f
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, me@ttaylorr.com, peff@peff.net
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3659; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=bTyqkq2s9qrFOib2+N3hR2UT7FBnngb1hTT3MRDfjKw=;
 b=owEB7QES/pANAwAIAT7VnySORox/AcsmYgBnN0/HsNmtdXjTcalCfudfIqtEqrfSvXHHgLq9P
 yh9RUdpomyJAbMEAAEIAB0WIQRXzkx/Y3VxD8tlxgY+1Z8kjkaMfwUCZzdPxwAKCRA+1Z8kjkaM
 f0dMC/wKOgjS7ikvDsuqvP3a2KMk/hGYjFaVX/WFmmI4ZhR4Ce6pS0Lph1ir6n6pywNXqZKXvOi
 8onl4AcRFM9nV82ERZAsxpuAPeLI94YPUzkoLFqJGnKDsbfeBL9bcC7aWR9g5QkeoXyOOGtdvyQ
 vlxvUraLQcxpi/wuFl3c6vxLVdEl9l8gdQm36tXw4efwxVSYv47WqttsjBE+7LlQfEfzC1yis68
 Gw6XrYmBh2dL4f5BSBcAAzYcUCV95tqNrd3yeC1BdsoI3uCGqsTC7OQYGW+YfZd+YyY3dLzCwGb
 778T6ANs6IX8i35SHLILNnzGzHzcsA+VISSI7h5uvDmVMyd8G3HPgYoOCXrw8lf9JjQYiw+66kz
 V/7mKKuzApNL03ZNXeH3MGk2XOdtpXqmj4NxrZ9zWdk640YWJpLPwfQPP2PeqNvlCxNrY/gnXaA
 slbQ14r0l0yaogEb2aYlPLmpTSeS16/sxna/ipgoGEXYEehjS1Sva6g3s0gjejySNSoLc=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Similar to the earlier patch series on cleaning up packfile.c and
removing usage of global variables [1], we change the midx.c and
midx-write.c files to no longer use global variables.

This is done by the following:
  - Usage of repository variable already available in existing structs.
  - Passing down repository variable from other subsystems.
  - Modifying all subcommands to obtain repository variable from the
  command in `builtins/` and passing down the variable from there.

The biggest change is in the first commit, wherein we modify all
subcommands to add the repository variable. Since the subcommand
definition are not often changed, it shouldn't cause too many conflicts
with in flight topics.

Since the `packfile.c` cleanup is still in flight, this series is based
on top of master: b31fb630c0 (Merge https://github.com/j6t/git-gui,
2024-11-11) with those patches merged in.

[1]: https://lore.kernel.org/git/cover.1729504640.git.karthik.188@gmail.com/

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
Karthik Nayak (8):
      builtin: pass repository to sub commands
      midx-write: add repository field to `write_midx_context`
      midx-write: pass down repository to `write_midx_file[_only]`
      midx: cleanup internal usage of `the_repository` and `the_hash_algo`
      midx: pass `repository` to `load_multi_pack_index`
      midx: pass down `hash_algo` to `get_midx_filename[_ext]`
      midx: pass down `hash_algo` to `get_split_midx_filename_ext`
      midx: inline the `MIDX_MIN_SIZE` definition

 builtin/bisect.c              |  32 +++++++----
 builtin/bundle.c              |  16 ++++--
 builtin/commit-graph.c        |  10 ++--
 builtin/config.c              |  25 +++++---
 builtin/gc.c                  |  21 ++++---
 builtin/hook.c                |   7 ++-
 builtin/multi-pack-index.c    |  20 ++++---
 builtin/notes.c               |  36 +++++++-----
 builtin/reflog.c              |  17 ++++--
 builtin/refs.c                |  10 ++--
 builtin/remote.c              |  34 +++++++----
 builtin/repack.c              |   2 +-
 builtin/sparse-checkout.c     |  25 +++++---
 builtin/stash.c               |  39 ++++++++-----
 builtin/submodule--helper.c   |  46 +++++++++------
 builtin/worktree.c            |  28 +++++----
 midx-write.c                  | 129 +++++++++++++++++++++---------------------
 midx.c                        |  88 ++++++++++++++--------------
 midx.h                        |  24 ++++----
 pack-bitmap.c                 |   6 +-
 pack-revindex.c               |   2 +-
 parse-options.h               |   4 +-
 t/helper/test-parse-options.c |  11 +++-
 t/helper/test-read-midx.c     |   8 +--
 24 files changed, 380 insertions(+), 260 deletions(-)
---
base-commit: b31fb630c0fc6869a33ed717163e8a1210460d94
change-id: 20241111-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-a88498c2590f
prerequisite-message-id: <cover.1731323350.git.karthik.188@gmail.com>
prerequisite-patch-id: 0c0b2f7ab45aa1c6a14b43577b527e388fbdbc38
prerequisite-patch-id: e3c455e9206c11da6df31b4fed1bb5a50f4b05a2
prerequisite-patch-id: d85a7bba34e100fe2fdcd69f9710d3791e5ea1bf
prerequisite-patch-id: d3ad99374f4cca79ab58862ba31f61970e18eec2
prerequisite-patch-id: bc4ede2ad40588cc2a65598e875da121251012f9
prerequisite-patch-id: 74b62a5d62b178284a60d376aa0425758f15f514
prerequisite-patch-id: 4a70e65446538fff399de3b019a5c187e6ee9895
prerequisite-patch-id: bf5a723ee69217d389fc735b19b1cd04fd7a389a
prerequisite-patch-id: 9d796bcf18fea156bd225787dbb4b8b0e2a7d23b

Best regards,
-- 
Karthik Nayak <karthik.188@gmail.com>

