Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B2D13A244
	for <git@vger.kernel.org>; Wed,  7 Feb 2024 21:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707342293; cv=none; b=Yq1bbR7XckkPRNjwl2zOPBl0LSahuUoGVmuA6YKX9HR5jEhxHDa8AQs9jsFxBTMdVXJi2kkT07ggYD5xGy25IiZ0Idwls6uUqWHAbEC/IwV+emsDVKp2fe9k011Fxx6AwYATf93H1D0z2/K8Z4Z8EWay/tWke+hwrBR/b5h4WYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707342293; c=relaxed/simple;
	bh=VkVU8bZIupGREFb6UOOGQIhb5u+sScx6bTcHAUtHGpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qlCh0e/Lxk7VY+w/bmbJ8jIAoJSwQej+Q4cqJkIypEw3UT7pDKujaXl1ewTNG1KDYGsAk2nn0k/LF1rWIKvyspclN0D8DN9avysfCpQEvwHtcsnHGnt+6Cfw8LeTMxzloC/F7A+0Fy/VBkJ2YEClVmCMUntQqxiM7ik8O+OEcMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=gSKF+Au4; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gSKF+Au4"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 0F5AF2BD3C;
	Wed,  7 Feb 2024 16:44:51 -0500 (EST)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=VkVU8bZIupGREFb6UOOGQIhb5
	u+sScx6bTcHAUtHGpg=; b=gSKF+Au4vKtA0s/dudVT8ShtxB8mm7becG6MDoocV
	Yo0SvFlJv2qntlrco9jfiDBmZTH7rLj3DHye6WLl99yg3iNm6ofcBtAfVXaEcZLd
	cnERi0nc099idXliOxPqp4kBAQ2amFxS8PECKZE9cF+xHIZ/oRNy3PeN3CXBYKzP
	lE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 0735A2BD3B;
	Wed,  7 Feb 2024 16:44:51 -0500 (EST)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 967D02BD39;
	Wed,  7 Feb 2024 16:44:46 -0500 (EST)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Matthieu Moy <git@matthieu-moy.fr>
Subject: [PATCH 2/2] bisect: document command line arguments for "bisect start"
Date: Wed,  7 Feb 2024 13:44:36 -0800
Message-ID: <20240207214436.538586-3-gitster@pobox.com>
X-Mailer: git-send-email 2.43.0-561-g235986be82
In-Reply-To: <20240207214436.538586-1-gitster@pobox.com>
References: <24a42fa6-7bc4-4a3b-8bf4-a0ef85dc457a@matthieu-moy.fr>
 <20240207214436.538586-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 1C8D2CE4-C602-11EE-8219-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

The syntax commonly used for alternatives is --opt-(a|b), not
--opt-{a,b}.

List bad/new and good/old consistently in this order, to be
consistent with the description for "git bisect terms".  Clarify
<term> to either <term-old> or <term-new> to make them consistent
with the description of "git bisect (good|bad)" subcommands.

Suggested-by: Matthieu Moy <git@matthieu-moy.fr>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-bisect.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index 3d813f9c77..73f889b97b 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -16,7 +16,7 @@ DESCRIPTION
 The command takes various subcommands, and different options depending
 on the subcommand:
=20
- git bisect start [--term-{new,bad}=3D<term> --term-{old,good}=3D<term>]
+ git bisect start [--term-(bad|new)=3D<term-new> --term-(good|old)=3D<te=
rm-old>]
 		  [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [<paths>..=
.]
  git bisect (bad|new|<term-new>) [<rev>]
  git bisect (good|old|<term-old>) [<rev>...]
--=20
2.43.0-561-g235986be82

