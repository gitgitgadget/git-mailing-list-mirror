Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A202B313E26
	for <git@vger.kernel.org>; Fri, 29 Aug 2025 11:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756467944; cv=none; b=P8DRrZ9fcSeGSvx/Zw6pu7hOrFu2O8HjlzUStfcEI5c3CSZ4ZkJIX/BHlcxsUye/5Qcl0qfpRhygFz+M84ACHwF+GW2/SRp5ZmbaR7ifCKtIpWwgJVGD/3QnPMhKSPZC0T53fNOZCYZURLL9zKro4tijGRSsujohv5oex2K9G1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756467944; c=relaxed/simple;
	bh=ft+BRA8ipou78x8yBRK45iacqS4Wfc6xjCVVDu9YiUA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=fxFtXhnzqhwOG4DXHurjuoUW/dnefaslOqxgG7+9bQa6/jyBgbwe0o0EiQnj3bRbU46wXoNmxiJ4ePX5l5We5/D5kLx6hNK/UAPc3QEKfFuBzDePVm+5fT0jD5LD9aoMinMI3VeRycMpWBtqzIY4Sp8DmvBvdkirC/6IsrCSI20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GkC92J5s; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GkC92J5s"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7e9f7c46edbso247250285a.0
        for <git@vger.kernel.org>; Fri, 29 Aug 2025 04:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756467941; x=1757072741; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2/viP0NK7pT/0UKWN+QHjWFRm6geNhZB1Q0UNrxP+/w=;
        b=GkC92J5sfOPWmA+aKAerJAWgtJSgYCVCO9dpSTYnWcXbpE2UjIEP1NKvUZF6LsmEUs
         WdlA7JDTPQX/lN8eQw2K/lpmJaycVg4eYIfecNpLfWDgbSS7T44u5R+t4k2R4xuzceJ/
         RV/8D4n+XHEvAQ1ebcf/BgRlshXzfTSWVzdZpm3t7bxP1vkM4scJuHTzaJTdERNNZ3fV
         CczEGrIHtQ3Q2cJtDaKzRgMFwaBP5OMH5WAQdq4I0cY5F9tLoSI286syyyiQzb2+zQQE
         JDG2EHArx3BvDNsQ1TGo7An+imQ28Si8Y4JwIgLcLty0iO8ULTNia/qhU8WXXB6jT+eR
         +GwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756467941; x=1757072741;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2/viP0NK7pT/0UKWN+QHjWFRm6geNhZB1Q0UNrxP+/w=;
        b=SQHm9TK17eY8i7GAQOt+M0DlvE3Fy7uuh/IL0Z3zcYa6U7X3/YpT2qea2L7eufr8bX
         ppNY3u0JHEScaykKpe5L28cktMbY8cS8rudXRCWiWby7mou2OntI9XcP9fbUcDhGfEbH
         ahiZpZlU3B9M/WICW6kGyXnxPhKM5wX+9l09DTCNH30YUAc5UydPTlCy9Wr8KgTqm8pW
         IoJFtYa1CQCqwptdsVxmTdWkQ2YyxKLqtDm+l3gJPO2S/RsVSxGsexvj78wRAk7Amnzm
         8PYv4oUN7Ly+uu0Kwl6WXSabPJaxVxqdfdxRUcbuTc5j2I7jk/MupajAY6M0LHOs7LK+
         1ScQ==
X-Gm-Message-State: AOJu0YzKuo5I20QnDuwtlu9Hj8Ici0eYStjFTeBdL07rE1MW1oRP3w1A
	FbVcdLEyuXXRQt03FjN+xzWDyzagbZq/CgH6xjZB95rk3F/hJ9u7lzADS9qSJRsTP4k=
X-Gm-Gg: ASbGncvbY0LMN4I/wb/Mwh3BeInBAYLlcnqy95ySudxqfukBDDsEgl21paReYA7IL0C
	n70KJc6LCDfiSgqr2NV+GKnc1/Wt/6+quHK33Dock1jopzlVksSUK3Vlzdagrs458sfw/47VCWi
	LjQ13huVt8TP9slqqBI305z+QPyS8/3O/9+8ZMsKF/Jv0eznUPsGllKMNYNmVlEZgy3k8HXT01o
	qkv+eVkiy16uSNwpAdIBVl+3AaBa7VAW/NixepUuYR9GGP/Armh6GCoUCMsa6DfQ+63RUdq1TFu
	oJyezV9j9HyJTqtf9m6ydi9Qdl0MnAgGWGbFbofOLdT+SiebE8EW+2aeEmD0Kt6lKNEHKvkKwRF
	dQ94xvQEyRjnHqsJuXJ2i1l4=
X-Google-Smtp-Source: AGHT+IGv7CsqSsdiWFvNknJNheLpzk3bvLFZF5RFkb24gXG9kCMHx6sDSNmKATS4k9qifbWskeQBhw==
X-Received: by 2002:a05:620a:1786:b0:7fa:3b1f:302b with SMTP id af79cd13be357-7fa3b1f3130mr654484685a.23.1756467941121;
        Fri, 29 Aug 2025 04:45:41 -0700 (PDT)
Received: from [127.0.0.1] ([20.57.47.232])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7fc0f75423bsm155186385a.31.2025.08.29.04.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 04:45:40 -0700 (PDT)
Message-Id: <6f3e485c3379fba4668fbdf4dde4eec959f6836c.1756467934.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1962.v2.git.1756467934.gitgitgadget@gmail.com>
References: <pull.1962.git.1756148933.gitgitgadget@gmail.com>
	<pull.1962.v2.git.1756467934.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 29 Aug 2025 11:45:33 +0000
Subject: [PATCH v2 4/5] doc: git-checkout: deduplicate --detach explanation
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
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
    Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

Right now the explanation of `--detach` repeats a lot of the content in
the description of `git checkout <branch>`: we can communicate the same
thing by saying "This is the same as `git checkout <branch>`, except..."

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-checkout.adoc | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-checkout.adoc b/Documentation/git-checkout.adoc
index e4614674f0..4d522a5f75 100644
--- a/Documentation/git-checkout.adoc
+++ b/Documentation/git-checkout.adoc
@@ -69,16 +69,9 @@ that is, the branch will not be created or modified unless
 `git checkout --detach [<branch>]`::
 `git checkout [--detach] <commit>`::
 
-	Prepare to work on top of _<commit>_, by detaching `HEAD` at it
-	(see "DETACHED HEAD" section), and updating the index and the
-	files in the working tree.  Local modifications to the files
-	in the working tree are kept, so that the resulting working
-	tree will be the state recorded in the commit plus the local
-	modifications.
-+
-When the _<commit>_ argument is a branch name, the `--detach` option can
-be used to detach `HEAD` at the tip of the branch (`git checkout
-<branch>` would check out that branch without detaching `HEAD`).
+	The same as `git checkout <branch>`, except that instead of pointing
+	`HEAD` at the branch, it points `HEAD` at the commit ID.
+	See the "DETACHED HEAD" section below for more.
 +
 Omitting _<branch>_ detaches `HEAD` at the tip of the current branch.
 
-- 
gitgitgadget

