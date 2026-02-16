Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371803321BE
	for <git@vger.kernel.org>; Mon, 16 Feb 2026 15:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771257219; cv=none; b=Le59TsKONcMsbFwP4InsbElqE0t3XzSwi+VeFFFv9i6+a2Yu33DYvZXgmvvOS46+s3Jzi2nh4q+VOJ9/FI/GGjSYfFSKQ+/5Di1G3gdGARAzmwCXLravez9Axpiuob3EEtJsFftlhscm8kX6332cMHYlx3MLZQQqR/KSCS9aPdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771257219; c=relaxed/simple;
	bh=rRy6znmIEuOEZ/5k1JgkWl/OeVsYRu1qB86AhqSeWP0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=tlcaDAp4e3jl3vRN7GfjUUniPR/pnSuodn5ekIPy18VQu97tIqL36cXtEMgZgN49kuZAivWxdGa5J4hZoGwiXt7ZgTBWIDYpQZCszd+1BK+n5fboNoAaVnUxUfw54SPKHqaR3C6pRFYk+UA2lSDlFAzMm2KL2652IMVwNaR3O04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xr6rvauH; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xr6rvauH"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8cb3e22435fso279282285a.1
        for <git@vger.kernel.org>; Mon, 16 Feb 2026 07:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771257217; x=1771862017; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+tjO8TctGwxO91hh9SW+Plpbdyb7V7ww4T8pxpjPVXU=;
        b=Xr6rvauH54plcoXrNiisbVJ28tHTmsNVJKV5BIedEACv7TRctXlLwIimmnQu4FbnQ1
         sL8DpRJwJBI88eC/rGODMlGQg+E79kKUoE9rLiK0OZ15hMUDuGR4Xh6W2Vle/LTrG9kW
         PnAyoBDB8Zm4zA4Hu3kvv41bghVpzxUkQeA9UsmocwKUTGXbNq4HJgyTXbASzzjgALKz
         5lK5nRkodUOrN5K2iehSWXiYB/uOJHn7ZDp7gJuDKhgJBPnGRvHTIpT+pRcxCIu4nkUn
         OheLJvo7iC4UQMz8X6feKGh9HNuuFrQMwKwAyRJJwmNn4MHPf0bqvhM/hvrXrAI3Imih
         PkKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771257217; x=1771862017;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+tjO8TctGwxO91hh9SW+Plpbdyb7V7ww4T8pxpjPVXU=;
        b=OHY625nEWGi1p1zsmsWsOKhYWvASN57q9x9OSas435w9dQcYwHzSDrLLJ/qkzRn9w3
         59WOCmSAj4Exhs5nTroz2HjwriWr/iWMzYcbQhrStlvkhqplKOwwBHQyhFTRwuPsMAr3
         YTt/EEDYQw9QQG6W9+wR/FledmJIRuDBVU/Uri5VyQgbk+Tdd/r36daK01M1rfX1M41s
         0LcGwjPC/o6lQtKLBzkppeIpVOD/y/GtxxD4V276I3emrGEfqFbXYlYPbs3xw48QFdiW
         kldl29k8IHez2jD/G1J3iZEvVn9h6Rpy9xVV/80E4h6cT84YhGiIQzi2IgyxVP76NZuP
         ubwA==
X-Gm-Message-State: AOJu0Yz1rT6qvcztL+Szeo+QmDY8PTfWMg2Se+JfAKI4BrsFoLp6RmMu
	nIf7r98PACGKv1Fx1Lz9JLUuSQVjCiQssJ6XUuynVNQE3HRxodSE4XOaeaQNoA==
X-Gm-Gg: AZuq6aK/9iBfo+11N0I/qchtbteONGJJNg0by2+wsh/zVgk97+Yelclt7VnMx/7sift
	TFRhgTUPM4E9d0D+OWZNV639HwbAVzBCBL1Sb6iQQ4/Hv0VfJPsA/+UbbJk+sr2uA8fEOPxHWaf
	uo4WAqH894lDtSF1wl0zU07mwjIfiI3bQI0tg58bVP5mMdpUDmppPJxbYv+8nqiijAb51R+x1F8
	RtpwiklhiWdvERm1IkhLix1XrCSS0COhVIYY+6D1J8RMX8nKJBXMW/OhOt0H3CLKMzk7Tr2b8ph
	hgvzqrIJliV4kjc/AlVmurYI12amAasf6YeeR3zf19F/Un+naj5tBQP1Vh3jhHe4+6+6NLo1v0l
	5EKkoLk1ujkTuhcBoYXoFCBHO+hDVpFojSrfRVsB8mICurBkwHpJUvCI6uujJ+4rtMQdH0O82ZH
	VJv2kjWXqCJQjjawTtkzU4IHNm/fZtWxsshL2WIQ==
X-Received: by 2002:a05:620a:3187:b0:8b2:e8c8:671e with SMTP id af79cd13be357-8cb4ac829b7mr1105094185a.29.1771257216543;
        Mon, 16 Feb 2026 07:53:36 -0800 (PST)
Received: from [127.0.0.1] ([135.119.238.192])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb3fb9a748sm1074206285a.3.2026.02.16.07.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 07:53:35 -0800 (PST)
Message-Id: <0ebad7bbc39e68a712c25372e51141b302b9e7b0.1771257211.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2043.v2.git.1771257211.gitgitgadget@gmail.com>
References: <pull.2043.git.1770679038.gitgitgadget@gmail.com>
	<pull.2043.v2.git.1771257211.gitgitgadget@gmail.com>
From: "Rito Rhymes via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 16 Feb 2026 15:53:29 +0000
Subject: [PATCH v2 3/5] gitweb: fix mobile page overflow across
 log/commit/blob/diff views
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
Cc: Eric Sunshine <sunshine@sunshineco.com>,
    Rito <rito@ritovision.com>,
    Rito Rhymes <rito@ritovision.com>

From: Rito Rhymes <rito@ritovision.com>

On mobile-sized viewports, gitweb pages in log/commit/blob/diff views can
overflow horizontally due to desktop-oriented paddings and fixed-width
preformatted content.

Extend the existing mobile media query to rebalance those layouts: reduce
or clear paddings in log/commit sections, and allow horizontal scrolling
for preformatted blob/diff content instead of forcing page-wide overflow.

All layout adjustments in this patch are mobile-scoped, except one global
safeguard: set overflow-wrap:anywhere on div.log_body. Log content can
contain escaped or non-breaking text that behaves like a single long token
and can overflow at any viewport width, including desktop.

Signed-off-by: Rito Rhymes <rito@ritovision.com>
---
 gitweb/static/gitweb.css | 52 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/gitweb/static/gitweb.css b/gitweb/static/gitweb.css
index 0b63acc0e2..135590b64c 100644
--- a/gitweb/static/gitweb.css
+++ b/gitweb/static/gitweb.css
@@ -123,6 +123,7 @@ div.title_text {
 
 div.log_body {
 	padding: 8px 8px 8px 150px;
+	overflow-wrap: anywhere;
 }
 
 span.age {
@@ -686,6 +687,15 @@ div.remote {
 .kwd    { color:#010181; }
 
 @media (max-width: 768px) {
+	div.page_body {
+		overflow-x: auto;
+		-webkit-overflow-scrolling: touch;
+	}
+
+	div.page_body div.pre {
+		min-width: max-content;
+	}
+
 	div.projsearch {
 		padding: 0 8px;
 		box-sizing: border-box;
@@ -695,4 +705,46 @@ div.remote {
 		max-width: 100%;
 		box-sizing: border-box;
 	}
+
+	div.title_text {
+		overflow-x: auto;
+		-webkit-overflow-scrolling: touch;
+		padding-left: 4px;
+		padding-right: 4px;
+		box-sizing: border-box;
+	}
+
+	div.title_text table.object_header {
+		width: max-content;
+	}
+
+	div.log_body {
+		padding: 8px;
+		clear: left;
+	}
+
+	div.patchset div.patch {
+		width: max-content;
+		min-width: 100%;
+	}
+
+	div.diff.header {
+		padding: 4px 8px 2px 8px;
+		white-space: nowrap;
+		overflow-wrap: normal;
+	}
+
+	div.diff.extended_header {
+		padding: 2px 8px;
+		white-space: nowrap;
+		overflow-wrap: normal;
+	}
+
+	div.diff.ctx,
+	div.diff.add,
+	div.diff.rem,
+	div.diff.chunk_header {
+		padding: 0 8px;
+		white-space: pre;
+	}
 }
-- 
gitgitgadget

