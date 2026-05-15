Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE74305664
	for <git@vger.kernel.org>; Fri, 15 May 2026 15:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778860099; cv=none; b=I1NqY/SCz7wL6ENUgLbTRqiOOJqjT8lQEJPqbuvr+RUcEEBwhvstwQdOiZFmtCglw0hWDnV7ULhu0bqe5IZAnSdXCE5dEz2UNAk04R1l0P1cAMHe6qjbh3imSqlTj9cefTpb0Mg8pggVoo4WPmz4EZlocWAg3zswbhDK9qwaXpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778860099; c=relaxed/simple;
	bh=Fwc9dLbSSVO+Udh39eeEd15D3f59RPuUu9pWxTM6Snw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=p5YDIgmCGs830+HzPpVCgAJ4B09GKGrB78tLl5f5wLHj0ZYGndbRzYkb7BdjtORNfEg8BGudKekFZ5N4NU7rkB8FaLAe6wMhHdx4xkNR1RlPfPd8xUwHu3giozOVyjxkvAmPbDAs4+cLO2i/Fw//IetZPsD1MYjv/l7JkPJ0qN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bFgMPhmz; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bFgMPhmz"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-651c5d525f6so13209977d50.3
        for <git@vger.kernel.org>; Fri, 15 May 2026 08:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778860097; x=1779464897; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3vRBYyIAGw2UWkUZw5NU9hZi/kco1/qeTO8N20CciUA=;
        b=bFgMPhmzKEYfRe9jZkeypdCGTcBuESbAoFp93zToCJ11uIp15gsgyt5EAeIWiFpcUV
         XSTQey49obfIksWefz6czlbzIblYirFAWc0cC0Ly6WPnFXujuE6IuyocxCyKYw5GPs31
         dVoPHK7f1aTTYggmGnBUNmPuhz3al9KbR2+uy0MXT3vNqSH3YkRreArd84icAPMGGMez
         XYJoRcoEcWKfuBWHZ8/NhQ1PqYyFbUU5oCVtmA5CKgUz4EBKXizv3JlnPX+JfYH9JSxs
         zlSh3Hf1Mj5ddv/9l7jD4fvFcArnGF4bpgzIfOmRp1gmaO+TJIu3c/Q7wWyi61/Ac+mB
         tZFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778860097; x=1779464897;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3vRBYyIAGw2UWkUZw5NU9hZi/kco1/qeTO8N20CciUA=;
        b=PrIpwIncVS4GciAhKsKnnzRL2DYRIJrp8lHAi2VIliBEIE/n0+NS0g+p9yJd0iQLpB
         XG6rAJMP8umkcevAQDFqAnSVENglu9Rx5gThhP0068D68W4kYOPGxnTE7KfaVysY7bl5
         AzB66KI+BqrUqHSwkdvs1nDajuodydXZQjiEX4IOoMSq6t9PPcXBMXblX8X4oX62CgkY
         8gkFcg0BLPzeWKvZOHRZTAsgOKx5tCzc7kvaqkJOlIDXuLXH6DYsQa8BfYa4g/TAgWtO
         9KZbDowrlBxnOo7VxL2RWYbPI6rMhVMmVo6iTDwwp1C2YkDS3N8b5WinhjOAo9nts1Yh
         h67Q==
X-Gm-Message-State: AOJu0YyKqlgIMbir7RSDgk/tJl9oi76xpdufvHR8njgdaosX4XaYs0fE
	RV/a/1Ozen4PoGXXUzJPkZtGhOVRMFRP6NDFjFDn1rxBjpZOKH1V0+oqfKUaAw==
X-Gm-Gg: Acq92OFX07ApGDG16QGRMZWalXaTngwgnvZIanDzoXdqAlX7NifJdu2RwExzaDG+bVR
	2896YQhzPnOGtETC/OkhWSZMsM7l8Esu4mHhPfvGXkppPTSB6hvGlgt/xRt7w/LyT5KjXCWM3mi
	lZaUaqxAiqgZAG6UBElFz791Lo5SC+bcl5SzQbskmQNPMJS5Kcfh56Ll0xjIEmUbd7zEXPnya1M
	b02dMPEKFbn5T4dU5f9IaSkdGg6u7v56BTaavXHAURM4fpUotAkS4XABvzyeKPIRGEBzXhrWaVy
	jZLP0298F0XuNBZtMIuHZ2OLKtdNNO4p5fyV6nc1QPyYgp7y10dZcPuXCht/cdZKJrEvf1VH0PO
	EwSosBWyKCvx+xi2/n6Qy0QyUXSY6M4WhHaApKzwRilfeGIbtiDvDkpVSJbyic6RfRbPtHQ+td7
	Jdcrb9TAHiU8lcs5acf56rK8TmctS7g5ETLw==
X-Received: by 2002:a53:acce:0:20b0:658:9bfb:602d with SMTP id 956f58d0204a3-65e22807a30mr3862341d50.38.1778860096936;
        Fri, 15 May 2026 08:48:16 -0700 (PDT)
Received: from [127.0.0.1] ([20.59.242.4])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65e0dbcda4bsm2704053d50.18.2026.05.15.08.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 08:48:16 -0700 (PDT)
Message-Id: <bf103e169b7c7c8a68ae4191514cfe517c577f6d.1778860091.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2304.git.git.1778860091.gitgitgadget@gmail.com>
References: <pull.2304.git.git.1778860091.gitgitgadget@gmail.com>
From: "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 15 May 2026 15:48:11 +0000
Subject: [PATCH 3/3] diff-format.adoc: mode and hash are 0* for unmerged paths
 from index only
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
Cc: Philippe Blain <levraiphilippeblain@gmail.com>,
    Philippe Blain <levraiphilippeblain@gmail.com>

From: Philippe Blain <levraiphilippeblain@gmail.com>

In the "Raw output format" section, we mention that the 'mode' and
'sha1' for "src" and "dst" are 0* if "(creation|deletion) or unmerged".
For unmerged entries, 'mode' and 'sha1' are in fact 0* only when we are
looking at the index, i.e. on the left side for 'git diff-files' and on
the right side for 'git diff-index --cached'. Be more precise by
mentioning this, and while at it uniformize the wording of the "work
tree out of sync with the index" case.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 Documentation/diff-format.adoc | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/diff-format.adoc b/Documentation/diff-format.adoc
index 43d91ef868..ef5df140fe 100644
--- a/Documentation/diff-format.adoc
+++ b/Documentation/diff-format.adoc
@@ -37,13 +37,13 @@ unmerged       :000000 000000 0000000 0000000 U file6
 That is, from the left to the right:
 
 . a colon.
-. mode for "src"; 000000 if creation or unmerged.
+. mode for "src"; 000000 if creation, or if "src" is from the index and is unmerged.
 . a space.
-. mode for "dst"; 000000 if deletion or unmerged.
+. mode for "dst"; 000000 if deletion, or if "dst" is from the index and is unmerged.
 . a space.
-. sha1 for "src"; 0\{40\} if creation or unmerged.
+. sha1 for "src"; 0\{40\} if creation, or if "src" is from the index and is unmerged.
 . a space.
-. sha1 for "dst"; 0\{40\} if deletion, unmerged or "work tree out of sync with the index".
+. sha1 for "dst"; 0\{40\} if deletion, if "dst" is from the index and is unmerged, or if "dst" is from the work tree and is out of sync with the index.
 . a space.
 . status, followed by optional "score" number.
 . a tab or a NUL when `-z` option is used.
-- 
gitgitgadget
