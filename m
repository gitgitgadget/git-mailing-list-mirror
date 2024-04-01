Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DC443AC8
	for <git@vger.kernel.org>; Mon,  1 Apr 2024 14:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711982756; cv=none; b=kTuizBvqSL4ivsvsI+nuEhOUeBr7Q4viZy7mS2p8PXgmokFYt+UN4k+VMXOm9uHcLNQuq/UDxS0M6/C3gv/hjTxgrhu0zuJ20jl9AcIHFGyp/c7K9lYyzICBVg+vnRmof2cz7xuPBhAop4t21ThPw9YNoSoNsqQog9cGFafXs84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711982756; c=relaxed/simple;
	bh=53vEoIpGL//F3Kpsdo4YaRhmKY17vMioQPw66ojePrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mOXuyDTBPEfjrChzTXc/E22KDQoXfK4CyCiUQbHKOebcC0YWuriAIs9gnnOWRLuvBZfW/L+HMKePifcOYXAT3LkgOlP70ukLFlKko01GLpSWC/0b1C3za34xLB8pciti1BVNAZSxrC+xhDSgJYp6izVRsqfLfdxtyHIFbsTd9Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZdTpB/JI; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZdTpB/JI"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-56dd16630d8so761667a12.0
        for <git@vger.kernel.org>; Mon, 01 Apr 2024 07:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711982753; x=1712587553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dShN5lbVlcmIi5FTCG5ExaQwq40xl/azZIHKDfczko4=;
        b=ZdTpB/JIJRZTXPevaOWS7IhIlniQZEyIZVrjdsD7l8a2QbRt1Fa5FalKBCK4siVI05
         H3xCIrkECk4yDWSTJmPXwDx3oLt30UguuqyC1dtWMMPvq84CmqzXap2LCrRYpZiniI8T
         6dbsEZ/33HdYXOQjOkNzSjJEt8mDuyl6jO62lAtFWMETd8F+5sLno/C1qykv6woYtegj
         PWw42BN7SHpdxAP51c0HMwe29J+An0ISyHXLaB2eecqhE5ZDciMk2UmliCXB60kqINa8
         2crSZey8BiI1BWQHVSUT7zpHOVuOkRhISq2BP0HOn6IRKxNKl/yzaNA12LWSvAqcviT+
         +N8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711982753; x=1712587553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dShN5lbVlcmIi5FTCG5ExaQwq40xl/azZIHKDfczko4=;
        b=Noe/qW/NkZxkmkbIJCaW6+hifiViZEZJVvp17q0+rmXzeh6r21P31HelDPEY4+l2bN
         aHBJppQy0atqqZncbN99hb95caBbA4ELKwuHqJmMxD1hjBYRqGrPtWtS/Q+6rvs7DwF4
         9okCnzuAgLjpdUkRuvHYfR53uqx4NotKZ9UwmNRBM8vfLubYcCcXpM0/6LKzIHS1HfQ7
         758VXn6qcv6BALiSy9NVYfT6X8dy+z/lfEyERvVxuRCZDNy5itplIvrXBWY+Y5A5QUUY
         V4v29mWVhRfgoQy4uQHVYCZEnCmL156KLMV6ZVvfmqn93Fel2gPEtxm7aVt9C7Hd9JDk
         gJ7g==
X-Gm-Message-State: AOJu0YwBTzgFh8DBm2J+z+xq2Ong9nlV9RWqSNUDeb/y/w1u9lgtn94E
	OlBaYWAGMAl4qoGi5FeNJVP2j7qu8+UajeT/H3AbrM2YGXzRYbAO0nI8D/pWU4w=
X-Google-Smtp-Source: AGHT+IHKYQjMLPISEVP34AB3rqcZUyVUnpvj2QsdvyG0nUI8ydUt8cF4E/3mWfrnlqkMhtp06ULE1Q==
X-Received: by 2002:a50:d74d:0:b0:56b:7f43:5a57 with SMTP id i13-20020a50d74d000000b0056b7f435a57mr4866474edj.15.1711982753058;
        Mon, 01 Apr 2024 07:45:53 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:c9f:8d5a:d89b:4ac])
        by smtp.gmail.com with ESMTPSA id n7-20020a509347000000b0056c24df7a78sm5751170eda.5.2024.04.01.07.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 07:45:52 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	chris.torek@gmail.com,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 2/2] githooks: use {old,new}-oid instead of {old,new}-value
Date: Mon,  1 Apr 2024 16:45:42 +0200
Message-ID: <20240401144542.88027-3-knayak@gitlab.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401144542.88027-1-knayak@gitlab.com>
References: <20240401144542.88027-1-knayak@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karthik Nayak <karthik.188@gmail.com>

Similar to the previous commit, rename {old,new}-value in the 'githooks'
documentation to {old,new}-oid. This improves clarity and also ensures
consistency within the document.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/githooks.txt | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 37f91d5b50..ee9b92c90d 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -275,12 +275,12 @@ This hook executes once for the receive operation. It takes no
 arguments, but for each ref to be updated it receives on standard
 input a line of the format:
 
-  <old-value> SP <new-value> SP <ref-name> LF
+  <old-oid> SP <new-oid> SP <ref-name> LF
 
-where `<old-value>` is the old object name stored in the ref,
-`<new-value>` is the new object name to be stored in the ref and
+where `<old-oid>` is the old object name stored in the ref,
+`<new-oid>` is the new object name to be stored in the ref and
 `<ref-name>` is the full name of the ref.
-When creating a new ref, `<old-value>` is the all-zeroes object name.
+When creating a new ref, `<old-oid>` is the all-zeroes object name.
 
 If the hook exits with non-zero status, none of the refs will be
 updated. If the hook exits with zero, updating of individual refs can
@@ -503,13 +503,13 @@ given reference transaction is in:
 For each reference update that was added to the transaction, the hook
 receives on standard input a line of the format:
 
-  <old-value> SP <new-value> SP <ref-name> LF
+  <old-oid> SP <new-oid> SP <ref-name> LF
 
-where `<old-value>` is the old object name passed into the reference
-transaction, `<new-value>` is the new object name to be stored in the
+where `<old-oid>` is the old object name passed into the reference
+transaction, `<new-oid>` is the new object name to be stored in the
 ref and `<ref-name>` is the full name of the ref. When force updating
 the reference regardless of its current value or when the reference is
-to be created anew, `<old-value>` is the all-zeroes object name. To
+to be created anew, `<old-oid>` is the all-zeroes object name. To
 distinguish these cases, you can inspect the current value of
 `<ref-name>` via `git rev-parse`.
 
-- 
2.43.GIT

