Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D05D13C918
	for <git@vger.kernel.org>; Fri, 20 Sep 2024 00:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726790432; cv=none; b=chvQXE7i3myBA1f9Vu1Q651YHKdhJarxPjq7OFNxw2EVMMC2TFGNs5NSr0mk8HGVJv/aYXthhHPLGFeb2AKQbQNn3b5F886kIYd3GQCk2aPO04d5O7/fMRwJfM7nrhY173hiJkI56Yx4v28u/T2uSVUaOpqUo0vJofeHqZAhczk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726790432; c=relaxed/simple;
	bh=zmAeWEbtyBU1ObjsA18J2rnbBR18NI6+nSIPAJc9tco=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=DVaJpbQhYHy+n6mo65f9ClFoiqm2Lc+XIYqElXnIosezUdCRDyEpXnhpPAVeK8EBoKrC6FtjoId0TWWwuVeF0mUYTMei3nLrWd3qCv1I/zPViilobiHjhp2/+Ply9ScFTL7hAzT4Htl0a9PEkmMb+KyHkvpm6hNtYhxAesoBTjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j6LSBDne; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j6LSBDne"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a8d0d0aea3cso172866666b.3
        for <git@vger.kernel.org>; Thu, 19 Sep 2024 17:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726790429; x=1727395229; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M7G7St/r/lyqHyt3Rm6IJTQC3KyQ+9iSx+ceZ37iBqg=;
        b=j6LSBDneyYFxNStirbvIScG2/Hp9q6f+NiGE+tKndC9Lih7zumV1xRPRIB5yAbgugo
         zTXim7CIPLcjPHBpCqLPjqDEO8bz2UCZ2kBRWFcUmaO0W3V8+woHOWGQaUHDPrrzFtsu
         +cXCW9X4NF4nIjKG0CIEyzpwdQQgVzbnUheBOssesC87Gj5J/9Fs9unotszZGP59UPdJ
         pz5Tb+FVbEX9ERV9UN19vEuGWzogJ69zsPG9FJrC1rlkG+amBGIOnDD38xyYJtBx5JGF
         XV/fIzOVJ0B2w9nQzcb9yC9n4IIYnUXosgPGlLLdnpWs392pAJ5e5NLXaEI9RDcps7nH
         RJKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726790429; x=1727395229;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M7G7St/r/lyqHyt3Rm6IJTQC3KyQ+9iSx+ceZ37iBqg=;
        b=t0LbiEpSs2GyDZLk0XN0R7YQOdaOqpq+U70ZTvQSqGRqiAO0Ty8wf3HarVTQ2Dd09G
         QAJcALnDXMZXuOqEpRq4gBH4f/oa9OglqZ7/UJc3UUhypBNDlF+jLnx+kBNnjwVhWSaF
         E8aHPYeBFoY0pdo1AemuaM/k+zLiRG2zjXEwyNPoLeIlwFIy4uajtBQTznxOsb6fDljB
         k17R1KWoNVFW9BimL/7X83eOkttCZW+ImqhDA9fwCLDbZYzqqOrRWvHTHHzxhkb3vFdS
         4rDFE23a2jyxluPTgfLCPdt0+bR6Pkom69ENlyaM/BvuKBgXzf4jOzzvL4TL7ppAxBdD
         jVSg==
X-Gm-Message-State: AOJu0YwvA/hCcxjaEgQQ2xavbq5P34mBC629knAYQ6Af/QknS4hc5gM4
	PG31pg2RK0cUIQ0rqxs31Ix4zJxDsdo+tw7aW+Xvqv0A8ebVc+59c9vf6Q==
X-Google-Smtp-Source: AGHT+IFJAmMqxP6GLmznaiTL7qaT+e7RrMELrEIfyT59rvoDSLP4nYTEFqDLMJ+icw2NPz8noBZTQA==
X-Received: by 2002:a17:907:c7d4:b0:a8d:75ab:17aa with SMTP id a640c23a62f3a-a90d5033ffcmr62764066b.37.1726790428491;
        Thu, 19 Sep 2024 17:00:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610f3a92sm767168566b.81.2024.09.19.17.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 17:00:28 -0700 (PDT)
Message-Id: <965a08a5d526ae75428727d0f9aa22ea22a25ed9.1726790424.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1798.git.1726790423.gitgitgadget@gmail.com>
References: <pull.1798.git.1726790423.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 20 Sep 2024 00:00:23 +0000
Subject: [PATCH 3/3] scalar: configure maintenance during 'reconfigure'
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
    liuzhongbo.gg@gmail.com,
    Johannes.Schindelin@gmx.de,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <derrickstolee@github.com>

From: Derrick Stolee <derrickstolee@github.com>

The 'scalar reconfigure' command is intended to update registered repos
with the latest settings available. However, up to now we were not
reregistering the repos with background maintenance.

In particular, this meant that the background maintenance schedule would
not be updated if there are improvements between versions.

Be sure to register repos for maintenance during the reconfigure step.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 scalar.c          | 3 +++
 t/t9210-scalar.sh | 7 +++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/scalar.c b/scalar.c
index 09560aeab54..73b79a5d4c9 100644
--- a/scalar.c
+++ b/scalar.c
@@ -733,6 +733,9 @@ static int cmd_reconfigure(int argc, const char **argv)
 
 		the_repository = old_repo;
 
+		if (toggle_maintenance(1) >= 0)
+			succeeded = 1;
+
 loop_end:
 		if (!succeeded) {
 			res = -1;
diff --git a/t/t9210-scalar.sh b/t/t9210-scalar.sh
index e8613990e13..027235d61aa 100755
--- a/t/t9210-scalar.sh
+++ b/t/t9210-scalar.sh
@@ -194,8 +194,11 @@ test_expect_success 'scalar reconfigure' '
 	scalar reconfigure one &&
 	test true = "$(git -C one/src config core.preloadIndex)" &&
 	git -C one/src config core.preloadIndex false &&
-	scalar reconfigure -a &&
-	test true = "$(git -C one/src config core.preloadIndex)"
+	rm one/src/cron.txt &&
+	GIT_TRACE2_EVENT="$(pwd)/reconfigure" scalar reconfigure -a &&
+	test_path_is_file one/src/cron.txt &&
+	test true = "$(git -C one/src config core.preloadIndex)" &&
+	test_subcommand git maintenance start <reconfigure
 '
 
 test_expect_success 'scalar reconfigure --all with includeIf.onbranch' '
-- 
gitgitgadget
