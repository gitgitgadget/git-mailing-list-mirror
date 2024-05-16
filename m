Received: from tortuga.telka.sk (tortuga.telka.sk [185.14.234.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25152031D
	for <git@vger.kernel.org>; Thu, 16 May 2024 07:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.14.234.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715845523; cv=none; b=oM19nrLEuxDxVh0Iov2Hcc8RTcECMaWtaLdom0LR+SSoSXbM4RyqtailJDAH6JF8HPz1zPYeBQVnDu95DGbxWPpVJA7xjGGHrUSZYayLyKPfnizl7KLzjtJ9Rii74Nlms3gFDOGpSBdFncjJR4MjPi5o7UTvvkMx4ERpN21PAnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715845523; c=relaxed/simple;
	bh=bXQA2mEkryQzZBaLIafsdabaGE1hm31BOYeTdKhELjY=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Sdx8lD0HE/ASeJLjrjkJuqmGXXWSo6UUj8aOYJu8DH0iSnW9IpcG/kKQcB8mlS+syiXtrc3ndvGP8sZJhe6KX5UtBzoxoJWfufcLTEe+ziF/LDypg+kC0WKGsHWcgwHWLqKK7zvFiQZl7xMsvswT3ko9xcrLFVlaRyaQooBRKMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=telka.sk; spf=pass smtp.mailfrom=telka.sk; arc=none smtp.client-ip=185.14.234.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=telka.sk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telka.sk
Received: (qmail 15009 invoked from network); 16 May 2024 07:45:07 -0000
Received: from telcontar.in.telka.sk (HELO telcontar) (marcel@10.0.0.10)
  by tortuga.telka.sk with ESMTPSA (DHE-RSA-AES256-GCM-SHA384 encrypted); 16 May 2024 07:45:07 -0000
Date: Thu, 16 May 2024 09:45:06 +0200
From: Marcel Telka <marcel@telka.sk>
To: git@vger.kernel.org
Subject: [PATCH v2] t/t0211-trace2-perf.sh: fix typo patern -> pattern
Message-ID: <ZkW5ggOVlglfi64u@telcontar>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received: (qmail 14783 invoked from network); 16 May 2024 07:43:13 -0000
Received: from il-bld.in.telka.sk (HELO il-bld.localdomain)
 (il-bld@10.0.0.17) by tortuga.telka.sk with ESMTPSA
 (DHE-RSA-AES256-GCM-SHA384 encrypted); 16 May 2024 07:43:13 -0000
Received: by il-bld.localdomain (Postfix, from userid 5001) id E85B3240C5F;
 Thu, 16 May 2024 09:43:12 +0200 (CEST)
X-Mailer: git-send-email 2.45.1

The bug went unnoticed because grep with null RE matches everything.

Signed-off-by: Marcel Telka <marcel@telka.sk>
---
 t/t0211-trace2-perf.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t0211-trace2-perf.sh b/t/t0211-trace2-perf.sh
index 13ef69b92f..070fe7a5da 100755
--- a/t/t0211-trace2-perf.sh
+++ b/t/t0211-trace2-perf.sh
@@ -233,7 +233,7 @@ have_counter_event () {
 
 	pattern="d0|${thread}|${event}||||${category}|name:${name} value:${value}" &&
 
-	grep "${patern}" ${file}
+	grep "${pattern}" ${file}
 }
 
 test_expect_success 'global counter test/test1' '
