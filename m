Received: from pio-pvt-msa3.bahnhof.se (pio-pvt-msa3.bahnhof.se [79.136.2.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115A019F137
	for <git@vger.kernel.org>; Tue, 10 Feb 2026 18:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.136.2.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770748393; cv=none; b=XtbVnHWBuNleZ+WjtKIlut1fWiIKWbTlMtgIaq57mr6BH+fPm8F2qGQZMtsHcpM3E+dwvmmwen8FdOvdVK30YmdTbFzyts0pSUG5TfrSgeEahI2WhxsVEXeBlfWE/GPY2xNw9peLwpWvSj3FcqIgaM1p/Rvc0SM5VuVQDeobtV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770748393; c=relaxed/simple;
	bh=Yj128/TrE3HvNOW8zuU3EuOQRoyWtIG5spnpYODOckE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dGZD2dRgKZCrKhKQWECi1dssnD5353j31nm09Jl/y/crPxw336yCehyMM3kKa0U5MdFydCTEbdkfZfa8NFvmCjqdZlStmWP+8TMBeiduDdtoOToKUsGWd9tivuiIPiPzAvihxn4m49XcIRM/0OtZy1mMcVuSxaSH/MHuSKDKquA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jontes.page; spf=pass smtp.mailfrom=jontes.page; dkim=pass (2048-bit key) header.d=jontes.page header.i=@jontes.page header.b=r1GMR2S9; arc=none smtp.client-ip=79.136.2.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jontes.page
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jontes.page
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jontes.page header.i=@jontes.page header.b="r1GMR2S9"
Received: from localhost (localhost [127.0.0.1])
	by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id A9D913F8F0;
	Tue, 10 Feb 2026 19:33:03 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Authentication-Results: pio-pvt-msa3.bahnhof.se (amavisd-new);
	dkim=pass (2048-bit key) header.d=jontes.page
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
	by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PXeJLZ4Qrdsf; Tue, 10 Feb 2026 19:33:02 +0100 (CET)
Received: 
	by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id 6C2ED3F841;
	Tue, 10 Feb 2026 19:33:02 +0100 (CET)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4BD5DB1E34;
	Tue, 10 Feb 2026 19:32:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jontes.page; s=dkim;
	t=1770748325; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=eLBoDI67zGnn6+ML92SadUu+jI47QaWREuw1HfhwH4c=;
	b=r1GMR2S9kZEAk0vkWknLbGjdDCxz0z/4goMcTVNZBYUwKy2ulwNxgV7N6e3T8mkyyt27vc
	qnJ0FIPC11V8PJKAXcIa+gMUD67585Cq9U/XAk+Oqa27DnZ2iBBeSbcnKzor1cawCp+9Ni
	OSIP0VuqP1J+Z8cdiFDAr/8gHUfH3OYwwx4IPG22OR5hDcdg7QS2C7rSYVOJAY4BjyL1yN
	cITFCVfJG7F/XMbOIp6kFqOQ6+6HaF51hNsNtJS+ZSXjaZ6Dby4X+vHO6dmYdco2B2rsDB
	BBATCrahYIwKP5YtzXMPmbMQVcjl0ZxV4lZZmBTtSeKy0LOUCrxnyEjXkOWObg==
From: Jonatan Holmgren <jonatan@jontes.page>
To: git@vger.kernel.org
Cc: peff@peff.net,
	gitster@pobox.com,
	"D . Ben Knoble" <benknoble@gmail.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jonatan Holmgren <jonatan@jontes.page>
Subject: [PATCH v2 0/2] support UTF-8 in alias names
Date: Tue, 10 Feb 2026 19:31:08 +0100
Message-ID: <20260210183110.1151072-1-jonatan@jontes.page>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <3124b359-2929-4f3f-9ac6-793277fe422b@jontes.page>
References: <3124b359-2929-4f3f-9ac6-793277fe422b@jontes.page>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi all,

Thanks for the feedback on my first patch! This iteration (to my understanding) 
addresses all the points raised by Jeff, Junio, and Brian.

Relevant since RFC/v1:
- Split into two commits: a preparatory refactoring and the main feature
- Removed release notes from commits 
  (suggested blurb below, first time doing this, bear with me :))
- Fixed documentation to use "without subsection" terminology instead of
  "flat syntax"
- Consolidated help.c to use list_aliases() from alias.c, eliminating
  duplicate parsing logic
- Added utf8_strwidth() for proper column alignment in help output
- Improved test coverage with case-sensitivity tests, subsection validation,
  and help listing verification
- Tests now use test_config helper and simpler output verification

The implementation follows Peff's suggestion to use config subsections
rather than modifying the config key syntax. This allows arbitrary bytes
in alias names while maintaining backward compatibility.

Suggested release note blurb:

 * Git aliases now support UTF-8 characters and special characters
   in alias names through subsection syntax: `[alias "name"] command = value`.
   This enables aliases in non-English languages. The traditional syntax
   (without subsection, e.g., `[alias] co = checkout`) continues to work.


Jonatan Holmgren (2):
  help: use list_aliases() for alias listing and lookup
  alias: support non-alphanumeric names via subsection syntax

 Documentation/config/alias.adoc | 44 +++++++++++++++++++++-----
 alias.c                         | 43 ++++++++++++++++++++++----
 help.c                          | 36 ++++++++++-----------
 t/t0014-alias.sh                | 55 +++++++++++++++++++++++++++++++++
 4 files changed, 144 insertions(+), 34 deletions(-)

-- 
2.53.0

