Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDD5313532
	for <git@vger.kernel.org>; Tue, 14 Oct 2025 12:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760444947; cv=pass; b=e2F9w0iosBXBbU5ooO2THH2+bg9eWAAqaEP4Y73HVE7Na5HcGH2yvMUa7jqAYaZuZ17rj2niNtAp115AYTnkZDU6Bdv6Z5QHdBlWgrousirE7NBvwUD9aDdiabS6HEJ8eIWaaO+AgpBrCOOC0iR2jabXUnhtZ1Qgci6WUVUpYVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760444947; c=relaxed/simple;
	bh=aOuwdQfaG06SAkIsZWWmPGKTtnJDQV631PYuDARnNAI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HGQkLHU2XFTt2DAGlV9yVBh/g1+zJXum//sPguQ9mu++VBRMMM2cE9YEbTH3GPrx3IM1KCDLNJOR0+eizE4gZX2N4vDtoeUrs0i4WG6FcPbAvyPAJn9Sf3U6gDbUZcBVvu89IyEc+nsND1GOR076CeQTP8YcbnS8f4l8pxdiimI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=CgaSCA9z; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="CgaSCA9z"
ARC-Seal: i=1; a=rsa-sha256; t=1760444782; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=FhLVdV2meBvpKgz5Dbe/Xr/rnRRUkTufFO6jujyF5qZ2eMjavmrHNujReLjOVi10p7WV5TV9EOJLZDokyiFPxiCKKxOkI8uuSoqCBk9ccypH0hrc2DL4AU29QzF44yaxTwM61wexsrcJCUymcWSQdpfJIztjdWO1svmXYYDGBcw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760444782; h=Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=ZbnEeJkYZzpZ8aWXrHwT/jW6b9I0Ibs4ewbB7F1ezKo=; 
	b=ZzSLTZ+uo88abfrb7fdcI/0tygFxUv7kyozI7oHwLZoW2WZwwONa+qMtC5+HetSasqMrAoJahGaLCsZ9q0+zI5NI3O/8rw98XEELEcGOrcf79W4oXQXLrNuLWhy0rFqa8KqWi9hgqopgNvROYVHONFnwQK64GWusb1bbbPInSI4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760444782;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=ZbnEeJkYZzpZ8aWXrHwT/jW6b9I0Ibs4ewbB7F1ezKo=;
	b=CgaSCA9zMJYrt8Ey4i0XbUZVdMl2Z7D9ZyfWnBcN0n0rcrimVYx1AMLcS4pTB2B0
	X5jfT1S+Sc/1do3zHUZ6Bj6/+0XIjFa9fzTwWLOnwbN57MjB31TTzXcG4STCu4GZY7H
	dJE7aNBhOD6pANKB1GbcCMDL/z5TVNKXW9ZofMDs=
Received: by mx.zohomail.com with SMTPS id 1760444779525541.6733776820329;
	Tue, 14 Oct 2025 05:26:19 -0700 (PDT)
From: Li Chen <me@linux.beauty>
To: "phillipwood" <phillip.wood@dunelm.org.uk>,
	"git" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
Subject: [PATCH v4 26/29] tests: t3440: convert ex.com to example.com
Date: Tue, 14 Oct 2025 20:24:39 +0800
Message-ID: <20251014122452.1851103-27-me@linux.beauty>
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

Lets use example.com here rather than some
random domain that might actually exist.

Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
---
 t/t3440-rebase-trailer.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t3440-rebase-trailer.sh b/t/t3440-rebase-trailer.sh
index df121efd0e..dd703b0eb7 100755
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

