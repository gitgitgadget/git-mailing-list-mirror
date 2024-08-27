Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B831F943
	for <git@vger.kernel.org>; Tue, 27 Aug 2024 21:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724794054; cv=none; b=HMPDexDlaLA1OKkUTo2WUVY/7K/LpCMyfZHlOv6jvMRv7KxbfHdy1+cmmouz8BgaZ5ogxb6n0KhvqfCeAQ85AJgjPKdZd85PGqQHnONz5XJ40MyKBYkKW0wMLZVMpAGV/8cKbpLXAdtjX4kRSvL6risWTrq8jnK0uZiykcCOW9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724794054; c=relaxed/simple;
	bh=g4Hv93sK2D4Bd2Z6PGFwmaHDe4UZLXSH8AiuWxttPIw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To; b=efUADtygok57YJ1g6kidoQK7sL7g4CdngYtCyUhN8xg6FfzPx7p9E/iJHn78aOuOQotiIMdRTQkKAtvn9LoTn1Rx7gI3E/VH5Cg29VbiaYKydpxQdrEmuf7D4QwAtrNcG+qAOS/npihB2/+xqymqBBiD/5rylQLns7/bz6fV0Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nbJC7WNw; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nbJC7WNw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724794053; x=1756330053;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to;
  bh=g4Hv93sK2D4Bd2Z6PGFwmaHDe4UZLXSH8AiuWxttPIw=;
  b=nbJC7WNwpeaYUwZv7cDxpN/HApQdzjkSQz5IG/+TPMV1EoNEi86qsFyB
   BNLFOuNqS8GkQvyYq8elMULgVEQi+sDPBH+e10cNNtFjTpFrrXiNl4I9U
   SMlyFbig/XeWZJWLQ6F8A8n4ylXxOs0it2p9q3qhhoNGQUmT2f6jev0vJ
   tJoOR5bjK7mJfGBhHYEIur2ksaj2vvaqLFfiuem6XLM0xeNRSgcYx1QBk
   TYHfzncLbH45ClRp28szYXkKHUhUipHvAtt1caQoE9Ks1OyHKYNwtkJ7U
   WCu2ytyNl+/LSa6MvsX9wx1ZdRLd2H3XmUNPNAUXx0FZgqkKO31YpPP5N
   A==;
X-CSE-ConnectionGUID: SMkqwQdZTwumxw2Egv9cSg==
X-CSE-MsgGUID: dEE2hbz+SgCnaF8kkbTUtw==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="33959501"
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="33959501"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 14:27:32 -0700
X-CSE-ConnectionGUID: jLGaghJnSvGR6p90l78Ldw==
X-CSE-MsgGUID: oY0ESeSsQPSagcrjzcQu0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="63517534"
Received: from jekeller-desk.jf.intel.com ([10.166.241.20])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 14:27:32 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v3 0/3] send-email: add --mailmap support
Date: Tue, 27 Aug 2024 14:27:15 -0700
Message-Id: <20240827-jk-send-email-mailmap-support-v3-0-bec5ba9be391@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALNEzmYC/43NwQ6CMAyA4VchO1uzDRjDk+9hPMxRYCqwbLhoC
 O/uxombXpr8TfN1IR6dQU9O2UIcBuPNNMbIDxnRvRo7BNPEJpzygkom4P4Aj2MDOCjzhDQGZcG
 /rJ3cDEzVKIUUla44iYZ12Jr35l+usXvj58l9tneBpe2/cmBAQUityluhBK3kuUsnRz0NJMmB7
 7X6l8aj1nDGdd7WWNJyr63r+gWoFDxXGAEAAA==
To: Eric Sunshine <sunshine@sunshineco.com>, 
 Josh Steadmon <steadmon@google.com>, git@vger.kernel.org, 
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

Since v2, we now have a configuration option (sendemail.mailmap) to enable
this behavior. In addition, I enabled support for email-specific mailmap
files.

The intention of these is to allow a maintainer to map the known-dead
addresses of former colleagues onto a current email for an owner within the
team. This would be used to update the send addresses to avoid including
no-longer-valid addresses when sending patches. This is intended for cases
where the original author is no longer valid such as when they are no
longer employed to work on the project. While sometimes pointing to a
canonical public address of that person may make sense, in other contexts,
removing them from the email makes sense.

I believe this version solves the use case we have of ensuring that we stop
sending emails with invalid addresses, and may be useful for others as
well.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
Changes in v3:
- Edit description of patch 1 to clarify lack of validation of email
  addresses.
- Update tests for check-mailmap, removing the bogus contact tests entirely.
- Link to v2: https://lore.kernel.org/r/20240819-jk-send-email-mailmap-support-v2-0-d212c3f9e505@gmail.com

Changes in v2:
- Loosen restriction on git check-mailmap by default, rather than
  introducing a specific --no-brackets option.
- Re-write commit message for the send-email changes.
- Add --mailmap-file and --mailmap-blob options to git check-mailmap.
- Add configuration options to git send-email for enabling mailmap support
  by default, as well as providing send-email specific mailmap files.
- Link to v1: https://lore.kernel.org/r/20240816-jk-send-email-mailmap-support-v1-0-68ca5b4a6078@gmail.com
- Link to previous "v0": https://lore.kernel.org/r/20240813-jk-support-mailmap-git-format-patch-v1-1-1aea690ea5dd@gmail.com

---
Jacob Keller (3):
      check-mailmap: accept "user@host" contacts
      check-mailmap: add options for additional mailmap sources
      send-email: add mailmap support via sendemail.mailmap and --mailmap

 mailmap.h                           |   7 +++
 builtin/check-mailmap.c             |  25 +++++---
 mailmap.c                           |   9 +--
 Documentation/git-check-mailmap.txt |  18 ++++--
 git-send-email.perl                 |  20 ++++++
 t/t4203-mailmap.sh                  |  42 +++++++++++--
 t/t9001-send-email.sh               | 122 ++++++++++++++++++++++++++++++++++++
 7 files changed, 222 insertions(+), 21 deletions(-)
---
base-commit: 87a1768b93a67d0420255a43d9e07387b2e805ad
change-id: 20240816-jk-send-email-mailmap-support-1a9e86867c72

Best regards,
-- 
Jacob Keller <jacob.keller@gmail.com>

