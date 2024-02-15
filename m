Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C6410E4
	for <git@vger.kernel.org>; Thu, 15 Feb 2024 01:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707959042; cv=none; b=VUH7UTAvxq7hcrzETV/l1zmyl3abRoZHihI1dnWAB2hx9C0+Os5mOEjzKGtA76rouxjf6FpywZ1mkAUYkxoedAv8RovEymD92TsPGUO9kPcau23jZ2eXuixcJL5pRZZNwZ9QBZCsNK4bUTz2HSr0vdETYo+Hgupm1EaPWr9c92I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707959042; c=relaxed/simple;
	bh=7wB0JMI7w823GAiEJaWK/RJYkzW92aB3AWT2Lukq5LI=;
	h=Message-ID:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=CR3Shc49xjWVhipbYfWhIaS+lFAmZY5oXuN/m8DQVytOEt2zjpAGexYidCzduMqSGNxPDKdQaJ0dX9RIKgQX8VhuvxiPV32ZMTVeN4Eq7/r7vYugLMM2zQgVC2sE3aSt5B0tmMlVL2Hy0whxPiq7T6U9UUHaFr+nlV5Bei/0XaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eRzPsMX2; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRzPsMX2"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3394b892691so223131f8f.1
        for <git@vger.kernel.org>; Wed, 14 Feb 2024 17:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707959038; x=1708563838; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6F3vWueYD8GRQngHkKEVSXvppFDRSZCd4XjIHyuOZPg=;
        b=eRzPsMX2Md2qvm0Vb8KyF+2/5zBuSRwT41tJbLjheGZNWdHRF92N7Pgu6DHO43/aGL
         GX6B5oK0WiDx5lybxAXMx78po3nOnS7nMLetj+toDfEy5R1nklw5Ox+IA3XTz5IvhnQU
         lFsGiGbyPIsQ4pHLwXg4Oy8tPRR3DRjvF/Vfgk3gYnPD44JHFcTGTGrLIFukErkS85md
         AsXW+K6D0cjTz9HPDUzMM58z3GnFCUuQ06CnWTNr3lfCoUA8s363NInXzt0yfGSyUwnQ
         EfZLYMILxLHEB/6wFpb/TzHfnpkiKxYYIBZ/mUqBC80aaUlTNCvV9RCeXfLAMPmU7tIj
         x/jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707959038; x=1708563838;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6F3vWueYD8GRQngHkKEVSXvppFDRSZCd4XjIHyuOZPg=;
        b=OCakBYrIbQ2AFDVF6ZexapxjAxuwVj8vKFTk7SYKSy4zoZFNli3jh6NPibc/tYVDni
         bkTIJWx4f8RID8wDnw7So/2BEO1pEe+CyUevCXVmENZycttYxdXqFgCkrhYZ8ozubn6c
         ErdlMn0pIAvva9GnZt356zubkGVkVSpF1xdswkkLbdWVT+smNtMrkMUZsYEWi5LYbRUH
         dqI2jzNW/VMkI08lTBYj/nX+Eyr7SFkk1CQJVmeaVZkAaVKuTuV2kF6zUFOYuRYiahhI
         Ec3dbPgVTBQWtLjOTnf8QSuZmDi+QRt1nyivdXL6dV3Vi9zn07Zr74vXx8NyyeejCvbO
         z9qQ==
X-Gm-Message-State: AOJu0Yz2NP7weOWhy9fBSTVNFcreR9Y1yi1nuktiD9W9NpdhK74J/bF4
	dnA3JrKe1QB4PXOS/6qQMKl5hffG1arskaIMXkK94/e8QhNi0DE6de5/rIWn
X-Google-Smtp-Source: AGHT+IE+RmiJAJUl94+ac49oGIgzrJDgTECgKPm0jkrgEADQiy9nXFf6hr+/YVxKcBc56UNb2GuAYg==
X-Received: by 2002:a05:6000:107:b0:33b:68d2:c5c9 with SMTP id o7-20020a056000010700b0033b68d2c5c9mr188491wrx.8.1707959037769;
        Wed, 14 Feb 2024 17:03:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id eo6-20020a056000428600b0033cda3d3916sm112494wrb.88.2024.02.14.17.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 17:03:57 -0800 (PST)
Message-ID: <pull.1664.git.1707959036807.gitgitgadget@gmail.com>
From: "Bo Anderson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 15 Feb 2024 01:03:56 +0000
Subject: [PATCH] t/lib-credential: clean additional credential
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
Cc: Bo Anderson <mail@boanderson.me>,
    Bo Anderson <mail@boanderson.me>

From: Bo Anderson <mail@boanderson.me>

71201ab0e5 (t/lib-credential.sh: ensure credential helpers handle long
headers, 2023-05-01) added a test which stores credentials with the host
victim.example.com but this was never cleaned up, leaving residual data
in the credential store after running the tests.

Add a cleanup call for this credential to resolve this issue.

Signed-off-by: Bo Anderson <mail@boanderson.me>
---
    t/lib-credential: clean additional credential

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1664%2FBo98%2Ft-credential-missing-clean-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1664/Bo98/t-credential-missing-clean-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1664

 t/lib-credential.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/lib-credential.sh b/t/lib-credential.sh
index 15fc9a31e2c..44799c0d38f 100644
--- a/t/lib-credential.sh
+++ b/t/lib-credential.sh
@@ -50,6 +50,7 @@ helper_test_clean() {
 	reject $1 https example.com user-overwrite
 	reject $1 https example.com user-erase1
 	reject $1 https example.com user-erase2
+	reject $1 https victim.example.com user
 	reject $1 http path.tld user
 	reject $1 https timeout.tld user
 	reject $1 https sso.tld

base-commit: efb050becb6bc703f76382e1f1b6273100e6ace3
-- 
gitgitgadget
