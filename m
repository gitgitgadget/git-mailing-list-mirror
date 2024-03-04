Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A7747A48
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 15:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709566815; cv=none; b=EwSsuSS4N4wecfgmdcAZPKRP6OwyrdJFN02vEgQWNG5WOOS4uMuGCmyigGvM0cEIVPfqWoLO2pVZI67dwEtgz5NX6uf1N5u9Vm0ndwKOyiqrR7+QdX3Okn+qic/fD+GC5ulEGYJ+2R8jNm9U80N8+Z32K28Iw9dp5r4+a71UtXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709566815; c=relaxed/simple;
	bh=kApzRBFcJHKzlQubnt/sublO9sRQSCVTa2dl/iPmfTA=;
	h=Message-ID:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=enOzdR5AzSoh3ps7QlbPnCHuaNBoy/W9qegvWV0v8Pl4z1fRXOV6gzKZ0YX73SjYIawunXLXEinlrW+ZVQOba9S4GkAgQKcBCMqltbMaOmYqgk/kWoU52+0t5IbwDuZ5jEw10luRzpuF9gM5m1XK8W7lJqw3GCJ7EnBV4wODmpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KOS90nUL; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOS90nUL"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-412e2dfa502so8840025e9.2
        for <git@vger.kernel.org>; Mon, 04 Mar 2024 07:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709566811; x=1710171611; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LQqpM0Ak1/IsYRLlvHCk49NACDVPmgokRIUb0FkIFzk=;
        b=KOS90nUL9HnoJoFxVAk6rNi9jXYXpZSOH3nl89YXP34FX3/gk+cx1PBl55/OMv54Jr
         iVFop82JAW7/jnlr23RLRDxoqwoCvX+Gc76ksijukKQZigw8EEp0s1XUcZkAiu9I8gW7
         9K2wYkzyjREHIEJn5BSWGqELVdMV6DL2+A90p72x3JjwvDtV1csz07VXNrOMuaEEHQkA
         qEBRX1jPooKcwytoc6x+sxz6kvLgSnlXWICahh/6zTl8ijEPHdkSxYxOn4BJcjZ1IWSb
         5KZXyZmc41mdwwkbDSUuPAhLt2BYFXhzpQMSMyko4HQFs1CeSGLA9BOVQiwlk1mh5Qwx
         5WWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709566811; x=1710171611;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LQqpM0Ak1/IsYRLlvHCk49NACDVPmgokRIUb0FkIFzk=;
        b=hOXHjxDJSsUM1DHXglMTC75Ouzn4Pg6P95tf7NSdbNqCOi02KVnjKi21v2zaRduNGY
         MJNjC0QrKZjKRznpRMjZCcb8ea+ZYnkI/vAF2760DhEE3PLUdSzeL7cn6w0xltRiucpX
         VCouMlou88xa/ct9gWRUwPkMwckbcXwwn1Qb0xIOYIo2MsunnDreeFhPBU/ovmVHmqQy
         j37Jmc7Ux7vaW6OndbG2UEGVeXGRZJQ0KcjBJkzv5/kU2H9Dej9UZ4BjPZuXqEbTGVE8
         5JRZdi3xV3s8paASHLDiL5hyFkmDhwz+PSpyvUXCZRYVzCE4X5YQo1S4ZuX/lR4tteWB
         LpUA==
X-Gm-Message-State: AOJu0YxRHp3vqy9XXCe/zF0i5EReqfGDsYIOXwEppoJ3i7dJTQv9ocbU
	QcBI/7St1Kh0KIxq6GzWNTK/M/UbMA4EETv3iLIwCwJ4w58yVPcHBPNxIzp8
X-Google-Smtp-Source: AGHT+IEX6dzOsS/aFY7PGsEpbs2E41x/gCqyWaq59+966BAr+Fz5cyqmEIsUyskR4i9l1ak+6zDVZA==
X-Received: by 2002:a05:600c:474c:b0:412:c9e5:b2d7 with SMTP id w12-20020a05600c474c00b00412c9e5b2d7mr5920090wmo.19.1709566810794;
        Mon, 04 Mar 2024 07:40:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j42-20020a05600c1c2a00b00412db03f182sm7112892wms.11.2024.03.04.07.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 07:40:09 -0800 (PST)
Message-ID: <pull.1679.git.1709566808.gitgitgadget@gmail.com>
From: "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 04 Mar 2024 15:40:04 +0000
Subject: [PATCH 0/4] trace2: move 'def_param' events into 'cmd_name' and 'cmd_alias'
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
Cc: Jeff Hostetler <jeffhostetler@github.com>

Some Git commands do not emit def_param events for interesting config and
environment variable settings. Let's fix that.

Builtin commands compiled into git.c have the normal control flow and emit a
cmd_name event and then def_param events for each interesting config and
environment variable. However, some special "query" commands, like
--exec-path, or some forms of alias expansion, emitted a cmd_name but did
not emit def_param events.

Also, special commands git-remote-https is built from remote-curl.c and
git-http-fetch is built from http-fetch.c and do not use the normal set up
in git.c. These emitted a cmd_name but not def_param events.

To minimize the footprint of this commit, move the calls to
trace2_cmd_list_config() and trace2_cmd_list_env_vars() into
trace2_cmd_name() and trace2_cmd_alias() so that we always get a set
def_param events when a cmd_name or cmd_alias event is generated.

Users can define local config settings on a repo to classify/name a repo
(e.g. "project-foo" vs "personal") and use the def_param feature to label
Trace2 data so that (a third-party) telemetry service does not collect data
on personal repos or so that telemetry from one work repo is distinguishable
from another work repo.

Jeff Hostetler (4):
  t0211: demonstrate missing 'def_param' events for certain commands
  trace2: avoid emitting 'def_param' set more than once
  trace2: emit 'def_param' set with 'cmd_name' event
  trace2: remove unneeded calls to generate 'def_param' set

 git.c                  |   6 --
 t/t0211-trace2-perf.sh | 231 +++++++++++++++++++++++++++++++++++++++++
 trace2.c               |  15 +++
 3 files changed, 246 insertions(+), 6 deletions(-)


base-commit: 0f9d4d28b7e6021b7e6db192b7bf47bd3a0d0d1d
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1679%2Fjeffhostetler%2Falways-emit-def-param-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1679/jeffhostetler/always-emit-def-param-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1679
-- 
gitgitgadget
