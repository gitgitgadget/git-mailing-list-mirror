Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4FC23E32B
	for <git@vger.kernel.org>; Sat, 14 Mar 2026 07:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773475170; cv=pass; b=gIJ474mAQgu3usGaD+sMRnss7Rn9kFOCKaXP5vICU9aEd1uTNDweBTQtdQp/iKndylAuF+K3fKkzOIEpolmFO8Kxe6gfSLyMBlh4hIGr3sDkrE3zA4gpSxrEgv6iZuvvQH8lOSLlZg3xj/E3qBkpqiJoIY6LnhgOaQ3raIedCYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773475170; c=relaxed/simple;
	bh=ylKSjTbsGpGQF4l9xFxRiXB53R2fshMduYs2BG5jZ0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QgaF+7JXFkN1admdK4Jf7nozhZp22b3jgDhT1vnYIy2Do/C1dIlkHkIBto0JX1D/KYUrYtSN4AgivmLhzjvxL8NU4GC/vCzxNN4vt1esd8zj9Av5pE6bbFOM8xnefesgT5zyjMjs95aK3/6zBAKmMZigI1ZPOuRjCrVzjyOrY7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ritovision.com; spf=pass smtp.mailfrom=ritovision.com; dkim=pass (1024-bit key) header.d=ritovision.com header.i=rito@ritovision.com header.b=XH572Wa/; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ritovision.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ritovision.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ritovision.com header.i=rito@ritovision.com header.b="XH572Wa/"
ARC-Seal: i=1; a=rsa-sha256; t=1773475165; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=UyWpYxNeeDhCWGsmKrp2Q+srzafhHTmlvv9VW16rjWRkkRApAzRbcbUO+Fthx5FXohitwM2yD/GXTImETj22VVBoqoxGQ/zE6CcBk12jqbSz4eVHtiRobulaoJW7Ywg/AhD5CX0/aGfeh3ZzqnSZLAGWOGLAD9q+zaZGiB97OYA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773475165; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=4OI0S5zab8QDUiTrgB/K0MbM7nTaSjTb8aj05JcXl/U=; 
	b=RMkPPciKQQgZKKclScDyn1Ylx0ONDQrdY1/Ajuql3c/xlnlYAWlEmAJmZYFBoiaKMHlCZEgxtBQaTH8m1RH5IPQZSMkafLOnTA7BfVS44/UQNDcUmRS2l1IalX4gUJre90VwyRQxS6u3P0sQzBcHILSwY4GFutrNcrbA3oW6HQM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=ritovision.com;
	spf=pass  smtp.mailfrom=rito@ritovision.com;
	dmarc=pass header.from=<rito@ritovision.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773475165;
	s=zmail; d=ritovision.com; i=rito@ritovision.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=4OI0S5zab8QDUiTrgB/K0MbM7nTaSjTb8aj05JcXl/U=;
	b=XH572Wa/e9nlV9qkUncY5yFjlEULXv+Sza7xRBnGW6R+spvELjGrZzga+3P6q52A
	z35n/q1yaCuKCp+FZpHnBfc34nf55WrRiD/3h0CFoKURwKxlbqnECwrFxCx8DWhhAHu
	vWJN8WowOzoVOeAQ553NX3A3oNQ0vpJ4MDeubeAo=
Received: by mx.zohomail.com with SMTPS id 1773475164442403.64908824346935;
	Sat, 14 Mar 2026 00:59:24 -0700 (PDT)
From: Rito Rhymes <rito@ritovision.com>
To: konstantin@linuxfoundation.org
Cc: git@vger.kernel.org,
	rito@ritovision.com
Subject: [PATCH v1 0/6] Allow site layouts to render properly on mobile devices
Date: Sat, 14 Mar 2026 03:59:16 -0400
Message-ID: <20260314075922.67391-1-rito@ritovision.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260313-loose-whale-of-speed-ccdbe2@lemur>
References: <20260313-loose-whale-of-speed-ccdbe2@lemur>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Currently, pages on mobile devices render against a desktop-width
viewport, which makes the content appear tiny and forces users into
a pan-zoom dance of pinch-zooming and horizontal panning to read
content rather than simple vertical scrolling. The first patch
establishes the correct baseline by setting the viewport width to
the device width. Once the site is allowed to render at actual
mobile widths, however, numerous latent layout issues emerge.
The remaining patches address those issues with targeted responsive
adjustments.

It is not a transformative redesign and is not intended to affect the
desktop layout.

Rito Rhymes (6):
  add viewport meta tag for proper mobile rendering
  prevent wrapped headings from overlapping with text above it
  add 848px mobile banner adjustments to prevent overflow
  add responsive extras and footer layout adjustments to contain
    overflow
  contain horizontal overflow in core content and homepage releases
    layout
  improve mobile rendering of docutils tables

 korgi/static/css/main.css | 154 +++++++++++++++++++++++++++++++++++++-
 korgi/templates/base.html |   1 +
 2 files changed, 153 insertions(+), 2 deletions(-)

-- 
2.51.0

