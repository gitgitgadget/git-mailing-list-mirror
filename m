Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8A41A3179
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 03:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771903955; cv=none; b=DIIbpvTQhsyfusfl/6RsuHMNh3eCEbatSEw9RmptffJMPLzA//pPlTUoyCEFPi3Jw+fGBXTFKEgVxjEiZC2pcaTqg2ui3rlB17aRZYN4zk+UEEBJk8p3xiPlwn6kBs6ADBtD0B6SEV9/22kogIcXz78Izl+ZqU7G89QUXbr0Xcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771903955; c=relaxed/simple;
	bh=2Dq4bYLEj3tiaYtxEWxFDgi3wP+1SuEyZc8UYlzXsRI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=thJeQ8XDGmNeYYXMcJz8wpcZfK6j+CeyUO8Jd784PWJdPH77Ky01Sc6bB/t7unCTrgz53oLtrZK7eUQo0Ragdcwns8fLkSYGB+TCDKcapdMAiawr5ap6Amvx3zujQoEjzb0f0KV6lNEuuVsz4q1YxG/zjgWXd3TSNpr0c1Ssjvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H+wWFOTF; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+wWFOTF"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8cb7edbcde6so488733185a.3
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 19:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771903953; x=1772508753; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/wRyaDiixP1ByrkS8TEe3J+Js42RW1xr0e2kaQg/PQE=;
        b=H+wWFOTFTdBkVdoDxjKEpZOuYeZrB+S2ynsIyI3HexYnsr4eh6Mt7tGAd4Ticje79H
         2hUG0Me6/ZU7r4xhbtmkC4hyC1CdNca7PCAbp5e27p+qSHkLJGAGpAGvn+jLZepRO4IV
         R4wZaQxm+DazWehXvbrQWUCvGb7Xm8FPZWiSuKvCADRNsof0lCb1pwJpnFm8MamguO8S
         mROCir+GVKSNEKqcckgVQApBay7yDqwFV0FxIzJgK9imkM8Hg+bhkf1NxdEgkvSO2VH8
         6cqObl+4n+wvP0/Eqs5zVYzbGNUUHRZ7S3zIIHZTYYPI4xhCCu7f+x+cTR8F+HzAH5Jq
         FKaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771903953; x=1772508753;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/wRyaDiixP1ByrkS8TEe3J+Js42RW1xr0e2kaQg/PQE=;
        b=GDTnwA1km0Vw8c4o8cMPws/cFSakLjImuwpUwaBeXWS3XNN5c5F2gV1fWzBMGN8PSp
         61bJZ0Fark9cPauYlSR1C7wer/9BC6HGf5XwrVTcUHuEYsLTS3/qV/S7+M+VbotrJVho
         9ekL5PkxTWjEJBjFr3jVIEkGMorAgZREY6R7cptTeUu6YA02fs2Uh0oGbR3AgxHW1dHk
         NWkc/eaSHGCBgXC155ZpPf+RWFODyDRSe4pxecKK5P9u4VMctL5Z4/tbOLUrDgkur2Iv
         LcT9G5SpnQ5MswybMBo52yJfNt0fU+9Iqmw6i0whf3f7YQIJv5tqKUhWnNVw1ESHo6h2
         371g==
X-Gm-Message-State: AOJu0YxWCijRNXbrEMbfCV87g2SUC9AcAtJFw6bd9FbF4VhWBLTcsv4m
	cSqf++rp2KCCz/dwNpYNh7qM4/EVLO9Nqx0nJ85CUEJSKRHGwEN6PGe5ZdbJHQ==
X-Gm-Gg: AZuq6aIdnQJ4MWOAsROGk2myjYA6flsdnHRHnJqvISYC7jcc6ZWrSGu81hr9wTqpU25
	PEti900vjHlxR5qO+HtO2Uxkp7ZIY79k9f9sZPajnJulDCcwQh5nUFo34gLqTR3HCCcup4XLBXA
	Uw6rcCSIsTctgddC+a335HRBTrTjYAia7hwup5uAmFheIfjBWm/EVBugKtWBucLrFHmNxaNXT9R
	iPVxDObuUnbRiRLUSwNCgb1A1nkF6vMfY5ygHSN3rhsxIEpkZk0I+hNSpZ6fhfuaMw1/BO505L2
	bCQlzfVORbeW8/NOUdx/CZUSpN9RQvCiuGilngh5W1ux2a09BS9brd+DYDydodwhqIhshtowrv7
	vaKk6zvXM1k8N1t9N4vs33iYTzQRe3NP3T4emJOWu+FTRk2fJRZWKeF/em/QR01MSxQhpEHgFDP
	zDoLg1nFEAfxlRM/EwIqbQY/crgnYU9appMc0=
X-Received: by 2002:a05:620a:708b:b0:8c6:a72f:fd56 with SMTP id af79cd13be357-8cb8ca035e1mr1288611685a.29.1771903952881;
        Mon, 23 Feb 2026 19:32:32 -0800 (PST)
Received: from [127.0.0.1] ([20.97.198.241])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8997e7383e9sm84560166d6.45.2026.02.23.19.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 19:32:32 -0800 (PST)
Message-Id: <86cd83f65b30aab3233e27b3e5c4f03041e68766.1771903950.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2056.git.1771903950.gitgitgadget@gmail.com>
References: <pull.2056.git.1771903950.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 24 Feb 2026 03:32:29 +0000
Subject: [PATCH 1/2] for-each-repo: stop using the_repository
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
Cc: gitster@pobox.com,
    fastcat@gmail.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

This is a simple refactor before digging into a bug fix.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 builtin/for-each-repo.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/builtin/for-each-repo.c b/builtin/for-each-repo.c
index 325a7925f1..478ccf1287 100644
--- a/builtin/for-each-repo.c
+++ b/builtin/for-each-repo.c
@@ -1,5 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
-
 #include "builtin.h"
 #include "config.h"
 #include "gettext.h"
@@ -33,7 +31,7 @@ static int run_command_on_repo(const char *path, int argc, const char ** argv)
 int cmd_for_each_repo(int argc,
 		      const char **argv,
 		      const char *prefix,
-		      struct repository *repo UNUSED)
+		      struct repository *repo)
 {
 	static const char *config_key = NULL;
 	int keep_going = 0;
@@ -55,7 +53,7 @@ int cmd_for_each_repo(int argc,
 	if (!config_key)
 		die(_("missing --config=<config>"));
 
-	err = repo_config_get_string_multi(the_repository, config_key, &values);
+	err = repo_config_get_string_multi(repo, config_key, &values);
 	if (err < 0)
 		usage_msg_optf(_("got bad config --config=%s"),
 			       for_each_repo_usage, options, config_key);
-- 
gitgitgadget

