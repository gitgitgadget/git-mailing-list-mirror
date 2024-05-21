Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052C21494CC
	for <git@vger.kernel.org>; Tue, 21 May 2024 19:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716321434; cv=none; b=Bo9gKxHI7RiRPI9itAzlTdi5jTr1QfNUSvKq1P0rXtWEd6e8F4LAShYqioxs+n2sM2nYQNcdyk95oHohFlIXjQRsXyG1h698dGpwKwnCTWaGUaNGS7I8Qb+90/3y408KEOskgqjUKq069qCK2lN1DyjQ44XCdSjLJa7Kt5CDZNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716321434; c=relaxed/simple;
	bh=rZY3pMl4hK9nUeE62D6/4fN+l7AxSxUvjTp2jSDMnQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Aj4vTCF42W+lQ8u4CdrtiWaPPICWpquyg0rbEO3WH3OK1BLf3UCqR2TnXGbwK+VM6S1YPdMT+R1ctl+zSMdrWmxJeWuZwsrx/U9ygRTCmuFS/JWltM18HR3yLZZey3FHOhKS8n+C/bZWS9mbBNJ22GJrD9ZKnATQqkv+RGoYZ8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=cNz6F8U3; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cNz6F8U3"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id ABF7E2228A;
	Tue, 21 May 2024 15:57:11 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=rZY3pMl4hK9nUeE62D6/4fN+l
	7AxSxUvjTp2jSDMnQI=; b=cNz6F8U3sPaDc0vA7Wg58bY4AvYxRqiUp7vufQ7wc
	X6luUHhTOSuz/6Yyd0NVDYwkzeuBQTDgonfnPpyIo7mIOatrIVJO3Au3N7ulK5Xh
	lZZ/MLZGEGnks7SLRZF0q0LbnhYLMcCE4aAq7cApZAQdGSyQWJ4GB66g8WAtqRyy
	T0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A2ED822287;
	Tue, 21 May 2024 15:57:11 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DCD3722286;
	Tue, 21 May 2024 15:57:09 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>
Subject: [PATCH 03/12] ci: drop mention of BREW_INSTALL_PACKAGES variable
Date: Tue, 21 May 2024 12:56:49 -0700
Message-ID: <20240521195659.870714-4-gitster@pobox.com>
X-Mailer: git-send-email 2.45.1-216-g4365c6fcf9
In-Reply-To: <20240521195659.870714-1-gitster@pobox.com>
References: <20240521195659.870714-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 4F03AF08-17AC-11EF-8E02-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

From: Jeff King <peff@peff.net>

The last user of this variable went away in 4a6e4b9602 (CI: remove
Travis CI support, 2021-11-23), so it's doing nothing except making it
more confusing to find out which packages _are_ installed.

[jc: cherry-picked from v2.45.0-1-g9d4453e8d6]

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 ci/install-dependencies.sh | 2 --
 1 file changed, 2 deletions(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 4f407530d3..33039d516b 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -34,8 +34,6 @@ macos-*)
 	export HOMEBREW_NO_AUTO_UPDATE=3D1 HOMEBREW_NO_INSTALL_CLEANUP=3D1
 	# Uncomment this if you want to run perf tests:
 	# brew install gnu-time
-	test -z "$BREW_INSTALL_PACKAGES" ||
-	brew install $BREW_INSTALL_PACKAGES
 	brew link --force gettext
 	mkdir -p $HOME/bin
 	(
--=20
2.45.1-216-g4365c6fcf9

