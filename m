Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9267D30B508
	for <git@vger.kernel.org>; Sat, 14 Mar 2026 07:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773475178; cv=pass; b=CGt3ExQnVvPAwBU8mJcdgGewLajsYn/Hy4t7B/nAD8WwvffXtZX3eB3keFvnzalZKJmaZmO+WgA6pmxROK26oIdNzFyB6A8ICjxgkC+VaqYT5edKOgYNv6svkH7Kaj4iqcNE6upR4h998ZhDPP53WvQLCUfKhQOyFmyqwJw/i/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773475178; c=relaxed/simple;
	bh=MKH2U7q/Br9QgkQN7//8YQA5RWbN1Ef/RQ0JznR4mVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WWTjyFhy/uqvrYMnNdZZ5VjoEasyB9Kgckuk35AcBfOuuAF3Ka7ysG0ed+R4W2pKmZEwpjcHR5425UWW2dWL6e9v8aFuYCwJy58SLI0BRJqz7rPTB0FEsfQ7Bqgh3bORA3OixQg7Cm8tvqNL+IFqOGXZ6zySxwn9YZl7nSkGbkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ritovision.com; spf=pass smtp.mailfrom=ritovision.com; dkim=pass (1024-bit key) header.d=ritovision.com header.i=rito@ritovision.com header.b=fY/Wo6HK; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ritovision.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ritovision.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ritovision.com header.i=rito@ritovision.com header.b="fY/Wo6HK"
ARC-Seal: i=1; a=rsa-sha256; t=1773475170; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=L95CClnZsBoqZU5pC3CZEsCQdB9dfDk4qaOiGEW34EL4fmyWexlM+o0fwoo5ANwiXLKjgqGWiKVlxtzKKwabB+4RhOUTL8eJlsSnXtWrcWcBkfxr6ZAT68piAqWzh2j0s7ZdlBHCp8zr3dcIYEcCt6dBuI1wsByCsa4YgBESR3k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773475170; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=hyST+YXJOe/l3622G0SdMCa8DKVK8OleQGvp06NPMlo=; 
	b=Y54syRDUxx0NKSylSeZ1eb81a6a8WP84hud1f/mm+qIftEjBjPDL5tHo4rd6X/dRVshmVXF2+renUVhMNbPVVuwr9clfbdpXUe70KGYOZARCAONl3NJQSP+Vhyj633kQH21rinKQ0NtElZyNEbYoUtyR4LoN5WhyTtXZdx1Yqro=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=ritovision.com;
	spf=pass  smtp.mailfrom=rito@ritovision.com;
	dmarc=pass header.from=<rito@ritovision.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773475170;
	s=zmail; d=ritovision.com; i=rito@ritovision.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=hyST+YXJOe/l3622G0SdMCa8DKVK8OleQGvp06NPMlo=;
	b=fY/Wo6HKskMdworBsr9vivKbLGk4130aedMKjjSmEVuQ24aNb0sMHgXxXX3Y9tYa
	b85c10nNaxS2upwWiTOMQQ5Zbw9aRbF5mL7H0H7wv5/ll7+8X1InUC4Gd/YCk/kSAav
	3oPSoEatscifcVSKNA2ipQ48b30C6r1jNwWFYX8Y=
Received: by mx.zohomail.com with SMTPS id 1773475166756509.16678469590545;
	Sat, 14 Mar 2026 00:59:26 -0700 (PDT)
From: Rito Rhymes <rito@ritovision.com>
To: konstantin@linuxfoundation.org
Cc: git@vger.kernel.org,
	rito@ritovision.com
Subject: [PATCH v1 3/6] add 848px mobile banner adjustments to prevent overflow
Date: Sat, 14 Mar 2026 03:59:19 -0400
Message-ID: <20260314075922.67391-4-rito@ritovision.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260314075922.67391-1-rito@ritovision.com>
References: <20260313-loose-whale-of-speed-ccdbe2@lemur>
 <20260314075922.67391-1-rito@ritovision.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

At widths below 848px, the desktop banner structure is too wide and
creates page-wide horizontal scroll overflow, breaking the layout.

Introduce a mobile breakpoint at 848px (equivalent to 53em at a 16px
base font size), matching the site's existing fixed-width layout scale.

Adjust banner sizing and spacing at this breakpoint while preserving
the existing desktop layout for viewport widths above it.

This patch is intentionally banner-only. The overall mobile layout
will still not render correctly until corresponding main-content and
footer overflow fixes are applied in follow-up commits.

Signed-off-by: Rito Rhymes <rito@ritovision.com>
---
 korgi/static/css/main.css | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/korgi/static/css/main.css b/korgi/static/css/main.css
index 3b09d24..19ee328 100644
--- a/korgi/static/css/main.css
+++ b/korgi/static/css/main.css
@@ -339,3 +339,25 @@ dt {
 #logo-akamai {
     padding-bottom: 22px;
 }
+
+@media screen and (max-width: 848px) {
+    #banner {
+        width: auto;
+        margin: 0;
+        border-radius: 0;
+        border-left: none;
+        border-right: none;
+        border-top: none;
+    }
+    #banner h1 {
+        font-size: 2em;
+        margin: 0.5em 0;
+    }
+    #tux-gear {
+        width: 4em;
+        height: 5em;
+    }
+    #banner li {
+        padding: 0 0.5em;
+    }
+}
-- 
2.51.0

