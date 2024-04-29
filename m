Received: from mail-gateway-shared13.cyon.net (mail-gateway-shared13.cyon.net [194.126.200.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414C78612C
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 16:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.126.200.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714409559; cv=none; b=AWU/3zqjymWb6+P0f8UN5divQsWuRE23u+Ezp2u5sttPIW+7WDBTncvHZJVkWFySOzR25HqmXe2QoBRr/eQeGUh8CtA4Gwojv1twNwkRURzTu+VTLsNVAnFi+Lf99LW3/zWwL7T/Z86+IrqhUfumsgDUWlJgLzf1hlXz11WzCxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714409559; c=relaxed/simple;
	bh=23TlK4kP7M3FIuic0uZW25oufnKeAvIbIjPXeQ0gVtg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lvE4Nzs3qL9aWIpAn9lwXtOLSkF3r3BQeIuU4UiW+vF7yuixOD9tafEJwZWnlb9mCGwVCIn+PzZJksNLfJp3zvjVypGesuFZpCv21jaB1wP38bxZcH6bKWdmNvuAaJxQT23ZYc3N46UK849KiPKQUa8qcDt300La+S2Mg8p802k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li; spf=pass smtp.mailfrom=drbeat.li; arc=none smtp.client-ip=194.126.200.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drbeat.li
Received: from s019.cyon.net ([149.126.4.28])
	by mail-gateway-shared13.cyon.net with esmtpsa (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(Exim)
	(envelope-from <bb@drbeat.li>)
	id 1s1UEt-000000007sg-0kug
	for git@vger.kernel.org;
	Mon, 29 Apr 2024 18:52:27 +0200
Received: from [10.20.10.232] (port=32438 helo=mail.cyon.ch)
	by s019.cyon.net with esmtpa (Exim 4.96.2)
	(envelope-from <bb@drbeat.li>)
	id 1s1UEs-0069WS-0D;
	Mon, 29 Apr 2024 18:52:26 +0200
Received: from minibeat.bolli (minibeat.bolli [192.168.11.3])
	by drbeat.li (Postfix) with SMTP id BCCAE180197;
	Mon, 29 Apr 2024 18:52:24 +0200 (CEST)
Received: by minibeat.bolli (sSMTP sendmail emulation); Mon, 29 Apr 2024 18:52:24 +0200
From: "Beat Bolli" <bb@drbeat.li>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH 0/3] color: add support for 12-bit RGB colors
Date: Mon, 29 Apr 2024 18:48:46 +0200
Message-ID: <20240429164849.78509-1-dev+git@drbeat.li>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li

 * The color parsing code learned to handle 12-bit RGB colors.

The first commit fixes a typo, the second one adds some test coverage
for invalid RGB colors, and the final one extends the RGB color parser
to recognize 12-bit colors, as in #f0f.

Beat Bolli (3):
  t/t4026-color: remove an extra double quote character
  t/t4026-color: add test coverage for invalid RGB colors
  color: add support for 12-bit RGB colors

 Documentation/config.txt |  3 ++-
 color.c                  | 21 ++++++++++++++-------
 color.h                  |  3 ++-
 t/t4026-color.sh         | 18 +++++++++++++++---
 4 files changed, 33 insertions(+), 12 deletions(-)

-- 
2.44.0

