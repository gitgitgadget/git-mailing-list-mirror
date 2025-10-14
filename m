Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96460313E01
	for <git@vger.kernel.org>; Tue, 14 Oct 2025 12:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760444922; cv=pass; b=O8lZby7Iq7F6Xo5PRCIUfaJ2t1/DqlCxqfGOY8zRAruLbsyUwIdbjkQ0Rj8zmhnXRzPlUlmlzYmIUPDUebrQiTQKqn0+12B/FPn4FzCS91irurWSKhOQa8/XhbwY4eBRxx14XhHIN8pfLbESTooGn4bYKeDOR20RlZBt2LhwSGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760444922; c=relaxed/simple;
	bh=CY7zKJECMLBgYImPNBKbfE7H8CGVdzSc8mnGRGKzpQA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rTEubNokvOWOj8CBMA+2g5hg/+ntoVkk4pvOFO00Nd7vxXQVb6M95BBdWdxCXtwpXJLz4urA4FQaAWHEaR8P1nP5yf1XPJFap7xMbmmjJSTqkeFjARukuUJDRib1RqzIHQ+O9RMyXGbgD7MScRRjbSOGjsty4ttqQs+LG2Bch0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=c4xxH17Q; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="c4xxH17Q"
ARC-Seal: i=1; a=rsa-sha256; t=1760444778; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=i/ieFZ67DS+hs0VryHTw+8SNfSPf9aBsXFQcrv+Syn37EQowiga6Gv1h9B9vS2rn+vys8Z27btk0h4NhlWMBDS5uxWgAMm4+TOAOjkzjULMCDPRF8hJJ8SxvaW7hPDAoXIzCaOYD97XrNfhFs+TTQONcGlYKY4nzXHSuDNR0864=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760444778; h=Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=PWDhnZq58CDDJAXxw2utmBQsoeaeMzxkR+8xHTw23R8=; 
	b=KnNXfbgwRN3WEVvTc6PX6rbWAMKehpXckciBIvmrhW7Dki5IiUkq/MMj3rQZKVMY6O98jQ8CY4gg9vw6d0Eo3/hh1y/h0iR0Z4VLcknNMx6n5F2GzXa5MXS+b0Urgk8u2WBdoRr3AzVLKAKkwWIFXti23+g+wUh1JR5WcKihaJk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760444778;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=PWDhnZq58CDDJAXxw2utmBQsoeaeMzxkR+8xHTw23R8=;
	b=c4xxH17Qd+2ZZwYm9ciZRdJwzYUhnen1lsRkms6AQA/qYSysvxf6lh1NEn7pgHYW
	eh8JgdleMa7Vaiv+m2BpRmpfd4ik5NRK1CBSU1X9Nn99YGoyPRs7BqQmoZu++fQdTQU
	GksW8y14CTxzLFyNrWlY4EtdCLFxw4d/OkJ0DHz0=
Received: by mx.zohomail.com with SMTPS id 1760444769849591.0790855998941;
	Tue, 14 Oct 2025 05:26:09 -0700 (PDT)
From: Li Chen <me@linux.beauty>
To: "phillipwood" <phillip.wood@dunelm.org.uk>,
	"git" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
Subject: [PATCH v4 23/29] tests: t3440: remove redundant --keep-empty
Date: Tue, 14 Oct 2025 20:24:36 +0800
Message-ID: <20251014122452.1851103-24-me@linux.beauty>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014122452.1851103-1-me@linux.beauty>
References: <20251014122452.1851103-1-me@linux.beauty>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

From: Li Chen <chenl311@chinatelecom.cn>

--keep-empty is the default these days so
we can drop that.

Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
---
 t/t3440-rebase-trailer.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3440-rebase-trailer.sh b/t/t3440-rebase-trailer.sh
index e1a3d2e3eb..2315a0c86c 100755
--- a/t/t3440-rebase-trailer.sh
+++ b/t/t3440-rebase-trailer.sh
@@ -87,7 +87,7 @@ test_expect_success 'rebase --root --trailer updates every commit' '
 	create_expect initial-signed "Initial empty commit" &&
 	create_expect first-signed "first" &&
 	git checkout first &&
-	git rebase --root --keep-empty \
+	git rebase --root \
 		--trailer "Reviewed-by: Dev <dev@example.com>" &&
 	test_commit_message HEAD   first-signed &&
 	test_commit_message HEAD^  initial-signed
-- 
2.51.0

