Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D1813C80F
	for <git@vger.kernel.org>; Fri, 16 Aug 2024 23:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723849596; cv=none; b=poHG7uvALONjasYe7BrXvgJJlEs1o988bOxHEcr+lPZpcT5iWen4JYhC1Vj7vMhqQ7oo/L6lLFlLVvCGPaHmxrf7BuYbmqi/TPkYDDCAA9zbi3iQB98VSiTOhRsLF9hoxhEFy8slSYgP994fT1SUefFcJBIHef4WTJ8v3LfMbZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723849596; c=relaxed/simple;
	bh=cma9xy+DQTMmeXaelGQkEHRySDHjqu+ZluyemtDSAn8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To; b=rPSeoeTQoMdpt+8NH00/6Ivek7g4ZeSHJvwrxN4cXiapk1wW//h12+H0xdb2RgSEJuYHQi+8LZkqXjSeKgD7u5A4RbTmCztd+SCO5ybX1NW/UwPURScrHmSXJCkFsF6HPPbfjTAre8d6wsouJgj6YZeW34U9OQgC1l9U1BfSmgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b/OKOUBD; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b/OKOUBD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723849594; x=1755385594;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to;
  bh=cma9xy+DQTMmeXaelGQkEHRySDHjqu+ZluyemtDSAn8=;
  b=b/OKOUBD09xhwxNiFY2TvNYFU6+T6gBLbajzO85C6ZMtIPjf0hDDSvmn
   9pMt8k3Ilbnr3HXBhY/yS0R3EbiJwHgvqC2YB6rrFPQhAj2AgxOfYmnO/
   nn+fFt/+ZjhVmCKm+MEt487BeR5bqYnLxl0Qr2qpXGF/i7uc9wEQDkJMg
   AW9R07MRbvmS6mAUL/sPYU0bMUPLXQXZNCaO/N8gos/53oRdEzU1NLzw7
   k5JjUEXwy9ZbDiYxmz9msa+CWlR4IdB6G0rjeHB/h40h/u6ELfDwBKC4e
   +5m3Tj5jvhLWlCAF0XrZr5XGKbTrYMHVk1uNUkVEuIRyDlk4jnOe3zTOl
   A==;
X-CSE-ConnectionGUID: 6e4I695JSF69XX3R8+MEEw==
X-CSE-MsgGUID: tZjgfIhtSa+T6Rv4eDMKsw==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="33571616"
X-IronPort-AV: E=Sophos;i="6.10,153,1719903600"; 
   d="scan'208";a="33571616"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 16:06:33 -0700
X-CSE-ConnectionGUID: kmWxZbGJSAunl+6Yb9MjNQ==
X-CSE-MsgGUID: bY3OWcmiQfqgiSDts7PKlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,153,1719903600"; 
   d="scan'208";a="64704680"
Received: from jekeller-desk.amr.corp.intel.com (HELO localhost.localdomain) ([10.166.241.1])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 16:06:33 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH 0/2] send-email: add --mailmap support
Date: Fri, 16 Aug 2024 16:06:22 -0700
Message-Id: <20240816-jk-send-email-mailmap-support-v1-0-68ca5b4a6078@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG7bv2YC/x3MQQqDMBBA0avIrDuQhJKkXkW6CDrWsRpDRqUg3
 t3YzYe3+QcIZSaBujog087CSyzQjwraIcQPIXfFYJR5Kq8tjl8Uih3SHHjCO3NIKFtKS15Rhxd
 5661rnYHySJl6/v3/zfs8L/pni7lvAAAA
To: Josh Steadmon <steadmon@google.com>, git@vger.kernel.org, 
 Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.14.0

I recently sent a series to enable mailmap support in format patch. The
discussion led me to realize that the true problem we wanted solved is to
map addresses at send time, so that we do not accidentally include a dead
mail address when sending an old change.

Instead of worrying about what the formatted patch has, this series
implements support for mailmap at the send-email, which will translate all
addresses, and not just the author/commit addresses for a patch, but also
the email for any trailers.o

I considered also that it may be useful to make send-email read a mailmap
file from the identity config blocks, but have not figured out how to
implement this yet.

I ended up needing to extend git check-mailmap to handle addresses without
the angle brackets as well.

I think this is closer to solving the actual problem we have, which is
wanting to avoid adding dead email addresses for coworkers who have moved
on, but without completely removing their name from the works.

Link to previous: https://lore.kernel.org/r/20240813-jk-support-mailmap-git-format-patch-v1-1-1aea690ea5dd@gmail.com

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
Jacob Keller (2):
      check-mailmap: add --no-brackets mode
      send-email: add support for --mailmap

 builtin/check-mailmap.c             | 27 ++++++++++++-----
 Documentation/git-check-mailmap.txt |  8 ++++-
 git-send-email.perl                 | 14 +++++++++
 t/t4203-mailmap.sh                  | 60 +++++++++++++++++++++++++++++++++++++
 t/t9001-send-email.sh               | 49 ++++++++++++++++++++++++++++++
 5 files changed, 149 insertions(+), 9 deletions(-)
---
base-commit: 87a1768b93a67d0420255a43d9e07387b2e805ad
change-id: 20240816-jk-send-email-mailmap-support-1a9e86867c72

Best regards,
-- 
Jacob Keller <jacob.keller@gmail.com>

