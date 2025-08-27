Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED2D2248B0
	for <git@vger.kernel.org>; Wed, 27 Aug 2025 15:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756308313; cv=none; b=iOAQSewI3qOWeU4NRc2iHpfAUmd0V0PLo72gwh94mfQCrjCiHEfnouWfEN5+dx4M7nJzFM9pnrc8BKdqZcJv+FhTF21J3XgkWy+iA37ZBEe8i1zuA95InbCdjZFpykZsYcy/rTLMDgHCWkebRhlEdgEaz1FxaZAedwHGb6FABCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756308313; c=relaxed/simple;
	bh=06pXYsxKzowWRi9NBweK0sVgrEoqdV4cBmBR1Y5/YkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VXFS0LGU+78PXLqqAecJY1MjMlWcTc88otuff8k0hblIOY5RggDuwqNzVJg+tZPfFAjVhWfuzmt/gvusYXs2hhfP72gjHe+7sfvML7reJhplj7Zgdc0W9FO9/0qEaY1Na0XsO73bj9opuDWU3AxN+3jOcPV5pqsCtXgV8QRo/AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MYEJWrDH; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYEJWrDH"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3c73d3ebff0so492188f8f.1
        for <git@vger.kernel.org>; Wed, 27 Aug 2025 08:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756308310; x=1756913110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+WNTGmX79oFqnJsiOdMdbD4igS4z58DbFK/0CvG30h8=;
        b=MYEJWrDH46r7orxyeGyflwut6r1KVmJ0ybrulZcZNe/M9WgdOyMmZuLAXQic5bx0aT
         vh5iATEQ3usHBOLvNPO0WctbBINYPgL+5hGRZySeqlXYhatEsLPETYgtTsnCzwBnr9wn
         X/VXxn+gNddeyRHuOIXUt6Doq7e19MRS6ia4trhUMP2W+yEKgQ8zKENC3D0fdTc8TxFq
         GVQAKnwIqtVj/6d3OWyrX7RXlSL2p7MbsNwsrXVkklL3F2BQkZKWukYEY0qjkvfzXTOK
         xb4hiKpdR6zVycrzN5l0/URTSB8t7YH2HIHOF3goYzHfKGto3BGim9tobDEo4X7Fe3Yh
         eYgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756308310; x=1756913110;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+WNTGmX79oFqnJsiOdMdbD4igS4z58DbFK/0CvG30h8=;
        b=pjO9t17AzMwhWgDKMb8wfO6t24faj4ZaS/90OyOpqomGFDlojUSzVtr767bPBTGND9
         7KofS4ZwdRvjh7CRcrprc0n0LnjumW8Ca6br15+YW35HqCrTf9XJHw9CXCsM8qdnjbfq
         TfzttfVklEv2NCrmwH0PZmeuw2PGoGIy932+C/qOsgisAN/vRpjFU087fbqSv3nMzW96
         9UDY6UmG/fb3AYTL9SfcLdiI6nKYmVbKTN5CnMtCTfPyrQL2RRIyVE60xIibyk7hmAA6
         WIwEN/T91XUPk7pv2oqEZcyWjyGmXDSBVX+EXVxxYqNJXBsxzmGF394PGBB09Z20jrB7
         tetQ==
X-Gm-Message-State: AOJu0YwFIDWkj9fQyOa4v1OEAsIQdN4oAIcdxDPdeUnJQY29MhPXrZLb
	DWBNGV1N1522kwo9JIxa7RlDQTkzrsgDBYr5uNhv5EBhe00R+pb3RE43flR91A==
X-Gm-Gg: ASbGncu5AW+/A4JnRMD7oBmgyeZd3byT8/9arupjUvOI8myChzAd1W1F4kMvjV/kmy/
	whQokF6aWFAPC3RR9CmPF+D3pcpAQjuvK/k8XteSWkk0AxzpyJqImoJ5s/325EGpRTgSiFusLg2
	XL9OAYyMRfs7dAtngjYm7V30d4uqp3XR7wBMmEGr6CF8lHamsLqeT7b+h3nYxNdYlqreAzYCkoh
	Ht3r94HcMCMK3YzozqMsbtVV/2J9r++Odbn716D5XFq8jUa7l+kgmy+5anRHwl810tI5AS7zQlZ
	ivDcMzek8RMpNZb6nBZQv9pPwCRYXT1sYu4Ce4uegan2dcYJ8/oRSz4hG27HiCxsgozrUtiTg1d
	8wpz8A6XrBEgN1iuZF8Vev5A53YQpKuk+WiBcM1xytlRcHg==
X-Google-Smtp-Source: AGHT+IE+8evUBI+CIITkrCauoaO/l5hFVCXheNreCGU67zsrDZoGegK4vi5qzraxNEmeowC8AM56mA==
X-Received: by 2002:a05:6000:25c2:b0:3c9:c344:1652 with SMTP id ffacd0b85a97d-3cbb15ca08amr4281941f8f.6.1756308310053;
        Wed, 27 Aug 2025 08:25:10 -0700 (PDT)
Received: from localhost.localdomain ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b73627bc4sm17894305e9.9.2025.08.27.08.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 08:25:09 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Wing Huang <huangsen365@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH 3/6] t9902: switch default branch name to main
Date: Wed, 27 Aug 2025 16:24:47 +0100
Message-ID: <d8a382a79eb4441ab3f8837a50ca072a38fee7c2.1756308283.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.49.0.897.gfad3eb7d210
In-Reply-To: <cover.1756308283.git.phillip.wood@dunelm.org.uk>
References: <cover.1756308283.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

In preparation for removing GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME in
Git 3.0 update the bash completion tests that rely on the default
branch name being master.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t9902-completion.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 6650d33fba6..964e1f15693 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -11,9 +11,9 @@ test_description='test bash completion'
 # untraceable with such ancient Bash versions.
 test_untraceable=UnfortunatelyYes
 
-# Override environment and always use master for the default initial branch
+# Override environment and always use main for the default initial branch
 # name for these tests, so that rev completion candidates are as expected.
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./lib-bash.sh
@@ -1453,7 +1453,7 @@ test_expect_success 'git bisect - start subcommand arguments before double-dash
 		HEAD Z
 		final Z
 		initial Z
-		master Z
+		main Z
 		EOF
 	)
 '
-- 
2.49.0.897.gfad3eb7d210

