Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BE930DD22
	for <git@vger.kernel.org>; Sun,  1 Mar 2026 18:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772390784; cv=pass; b=fPt0zvAcKWd1MprPPoN8BXA/Th5DUmxpva0Un8euFuVWS6lZ9+ycEN+GKk3F3ty1Quk7Scmboo/TVWQ4YOa3s8BlKi+uNCSW+XKS+sPwQMwBJUPFN41vWdzMSNcmKgFLKgxLCxbkO3dygzlXZF9ckF/uf2U+djNo4tY1kBLpvZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772390784; c=relaxed/simple;
	bh=GEJ06qP/11qI6F+JqqLQCfhvrtPhDNgrOM6jmdQEYr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aBpwKs2twf2Sw79qPpWyaRcU63YHTp90fGAUZcM/cYxEuGMlmUJ10p1QfZ+A11OBRl89YI7vXvStySGH2FamLPclk6jHzL31zRPIbghU//8UgYLFrFSxrUoCfr72jD5YP0WRQ2M0rfW3cQBaML4tKlhCkG4VpLM+ESoksFsNo94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=DH59W/Nq; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="DH59W/Nq"
ARC-Seal: i=1; a=rsa-sha256; t=1772390767; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=G3M3o8WRjLBFrkBjALwHnNEAF5n8J+4LoHu75tOiNa569eXGZPPHjNXQssh+oBtx+vZZErlwunoKcYeDzdwM5l3BlyLp6YTHG42Gx6JI8PMiouGQAlGGmq3KEf0cPNz105c4p9rB5t3KLLF/+biKOu2LaM/AwYa3DqZrsZMpous=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772390767; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=iOsNLW2dtI995sM+Abkql/1QzLj1c0SgthBXXLXiqYU=; 
	b=oA/7lV5BKMfvKvYaHYoHnkPqFTkP/L5inabFXxGfWG8VJhq7gy3bWBlFftAZa8Z/G2o3MEQbgqn7bHNbHGm7vUnd23wN2cCYb3b8pbPFBtIbxtXbyFeF/dLvP46tRZ7ViR9Wb20IH2DCS2Du7ApPJyroXPo90jJei+NTw3La51k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772390767;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=iOsNLW2dtI995sM+Abkql/1QzLj1c0SgthBXXLXiqYU=;
	b=DH59W/Nqc0w5u2ayY0IYc44h3s+4iwdemzoGD0DwclPp0TRTeMU0hVesjRNP5Sy0
	BLFI9DCtJm6pH52k+7qTqeLjQ0+oUKB3MfAeKrDeuXuuEFBB3gFQahsAeh3N43CmSle
	E/uHzfh3BckadwDewc0tNq2U+eXlUvp3B0I0gV1k=
Received: by mx.zohomail.com with SMTPS id 1772390766080472.42251454432096;
	Sun, 1 Mar 2026 10:46:06 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v3 04/12] string-list: add unsorted_string_list_remove()
Date: Sun,  1 Mar 2026 20:44:52 +0200
Message-ID: <20260301184500.1488433-5-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0.732.gb351b5166d.dirty
In-Reply-To: <20260301184500.1488433-1-adrian.ratiu@collabora.com>
References: <20260204165126.1548805-1-adrian.ratiu@collabora.com>
 <20260301184500.1488433-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Add a convenience wrapper that combines unsorted_string_list_lookup()
with unsorted_string_list_delete_item(), removing the first item
matching a given string.

This is a companion to the existing unsorted string_list helpers and
will be used in the next commits.

Suggested-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 string-list.c | 9 +++++++++
 string-list.h | 8 ++++++++
 2 files changed, 17 insertions(+)

diff --git a/string-list.c b/string-list.c
index fffa2ad4b6..d260b873c8 100644
--- a/string-list.c
+++ b/string-list.c
@@ -281,6 +281,15 @@ void unsorted_string_list_delete_item(struct string_list *list, int i, int free_
 	list->nr--;
 }
 
+void unsorted_string_list_remove(struct string_list *list, const char *str,
+				 int free_util)
+{
+	struct string_list_item *item = unsorted_string_list_lookup(list, str);
+	if (item)
+		unsorted_string_list_delete_item(list, item - list->items,
+						 free_util);
+}
+
 /*
  * append a substring [p..end] to list; return number of things it
  * appended to the list.
diff --git a/string-list.h b/string-list.h
index 3ad862a187..b86ee7c099 100644
--- a/string-list.h
+++ b/string-list.h
@@ -265,6 +265,14 @@ struct string_list_item *unsorted_string_list_lookup(struct string_list *list,
  */
 void unsorted_string_list_delete_item(struct string_list *list, int i, int free_util);
 
+/**
+ * Remove the first item matching `str` from an unsorted string_list.
+ * No-op if `str` is not found. If `free_util` is non-zero, the `util`
+ * pointer of the removed item is freed before deletion.
+ */
+void unsorted_string_list_remove(struct string_list *list, const char *str,
+				 int free_util);
+
 /**
  * Split string into substrings on characters in `delim` and append the
  * substrings to `list`.  The input string is not modified.
-- 
2.52.0.732.gb351b5166d.dirty

