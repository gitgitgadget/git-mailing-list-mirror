Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A8127467B
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 05:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761111887; cv=pass; b=X+fBEh4iUwvVq3yH4LbnQCWtoCAJ8EFA2bfvqB/K+vjwL10IprceCQuob0XrX9Xq2/qi3ibPL85j77ABYAJWmLJhNTeOjbhLiBZ+r04Orgm8BdiR/yr7yhyw1mliHiKaen1K3fgHkg0B9djeD95DOL0rA4OOzX0S/rRGp/obP8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761111887; c=relaxed/simple;
	bh=u8TJDii4YKvLzz0mD1ekW3n199ykIjyjWoQGAhW/ExQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZfOx280xjl2kycfSQLYkhZeFA6Vh+SC0T18Wcgw/OlbXNM9Zsd57MyHNeTIv3Me41NvVYjIOzMTLrh1e+8Sk1dpojAQ6zu/NQCvrRmk+CmZg6TyDyYLqPvdoV7Sur3fZ9WIvBjuiOhlhbImPVQvHa88yq+Ax6cBtj6EqlqJJ9Vk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=rURlA43k; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="rURlA43k"
ARC-Seal: i=1; a=rsa-sha256; t=1761111651; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ZzDqp4g3u6JuDtyT4SnF0hxGtsT3qKy1kRzNyNx1RUuS3P48kwP0pHiV7wOCZiDKKmw5V2+uYybdYdkYKoGSzE+EQ80PEq6gX346HYgZD1QtU7z7FHpSciMLTAmjuPj/Dw8Gqhev0cFZT8WElJu9w5b7h8RGcbjiFeQWCEY/iK0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761111651; h=Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=+P26bNveLutow2XICBaGxz/76Rshu35MjZWsWgJmXFM=; 
	b=LC63LjwcFySM7Qo/7DZrMDhVDaYHJblrXo1XXAKRkBEv14vFHUULx45+XxE00iYRbCxZaFkpH5ovLCQL5plspbv6Gih0eyan478lcdgBjrx2y9LoADwN4B6kNYXlxTcq1ZVQoG9F/Y0jbUpPEp3DVPepnrL0FiPexdvrZ73TOI0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761111651;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=+P26bNveLutow2XICBaGxz/76Rshu35MjZWsWgJmXFM=;
	b=rURlA43kvbwADGP92rjRwed5gJE9v+0c8f4ZT4AUFxxKIvCdivXoUXC/9LDPltTJ
	qlvkN/dm8i46BN5A4orvkdOtf7+5rdT27ygoee/hE5JYV47VVeGwfK0wG1YZwOsdM6i
	bfmUxdR04iwXtAxlQtuBopq6ot/GFo0s/l/rM/7I=
Received: by mx.zohomail.com with SMTPS id 1761111648987790.255237792709;
	Tue, 21 Oct 2025 22:40:48 -0700 (PDT)
From: Li Chen <me@linux.beauty>
To: "phillipwood" <phillip.wood@dunelm.org.uk>,
	"git" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v5 26/29] t3440: convert ex.com to example.com
Date: Wed, 22 Oct 2025 13:39:46 +0800
Message-ID: <20251022053951.602605-27-me@linux.beauty>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022053951.602605-1-me@linux.beauty>
References: <20251022053951.602605-1-me@linux.beauty>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

From: Li Chen <chenl311@chinatelecom.cn>

Lets use example.com here rather than some
random domain that might actually exist.

Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
---
 t/t3440-rebase-trailer.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t3440-rebase-trailer.sh b/t/t3440-rebase-trailer.sh
index bed6955001..bea98d08c6 100755
--- a/t/t3440-rebase-trailer.sh
+++ b/t/t3440-rebase-trailer.sh
@@ -73,13 +73,13 @@ test_expect_success 'CLI trailer duplicates allowed; replace policy keeps last'
 
 test_expect_success 'multiple Signed-off-by trailers all preserved' '
 	git rebase -m \
-			--trailer "Signed-off-by: Dev A <a@ex.com>" \
-			--trailer "Signed-off-by: Dev B <b@ex.com>" HEAD~1 third &&
+			--trailer "Signed-off-by: Dev A <a@example.com>" \
+			--trailer "Signed-off-by: Dev B <b@example.com>" HEAD~1 third &&
 	cat >expect <<-\EOF &&
 	third
 
-	Signed-off-by: Dev A <a@ex.com>
-	Signed-off-by: Dev B <b@ex.com>
+	Signed-off-by: Dev A <a@example.com>
+	Signed-off-by: Dev B <b@example.com>
 	EOF
 	test_commit_message HEAD expect
 '
-- 
2.51.0

