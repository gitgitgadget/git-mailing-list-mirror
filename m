Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB5641B35B
	for <git@vger.kernel.org>; Wed,  4 Feb 2026 14:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770214822; cv=none; b=Vrg22TmyghOeBXhq1vbkDLATGf9eeLLireMpgzLfqLmk3rIfAMn66964Ky5rRDdtgTGJ6w5/BeawnNNoUAfbbWKhj7u36OiAiMEuZC2yBfF7W8eSk1VIJECcy9t0vSc3t+snL6VVlrFPA05p/LdoikLfGjLtc4tudnrLBm+ojPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770214822; c=relaxed/simple;
	bh=Hima8f3BlqQBYWHWfiCUiePOoZIaZMdOjSbJTxa1fuI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=RxCnKrkWAHvXyk8Bow8jnO5QUXCZpapuLfJyxx9ZJbHCKc7QwMdmz1EZIj4y++sIyoQvzJe7Wkdq9F7zAASuJ0dGbA/Gu0plfCtyt7yTy7o7+f5IeKmEbTGNF5ryGmpJZQgqbiUkXdJKvqSe+fbe6MFjeF9TQEcgb0EGJYzImF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hddlWlkM; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hddlWlkM"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-45c87d82bd2so4557728b6e.1
        for <git@vger.kernel.org>; Wed, 04 Feb 2026 06:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770214821; x=1770819621; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=theDrawoAnJAxlBeE5lT0JvtyS7Im48gsYMZVa7ym3k=;
        b=hddlWlkMevBH6wQ98mMeo+lUjp4SPPAIoKk1D/dIlfWeoD/aUsyPJweUCKZld3YCw9
         mXPCTqvHU8RNqQQ0pFHxyxYdMAsLS36SBAs7H7KjQerySOD4AGJV5q+PVCEh6HI36d1S
         yADqjiqu8jnEshGInpwPUcENUd4gHeiQMk5l3xvYS/QsmZPmRm8LevcZmaBcvgW+P7e4
         IbtvUqCNLHpctu28MF2IUKEwmo3NGBdrbSJ/fNwsHflfgiwRboMoCgBMVX6i6xptH7Ka
         ANAfxdVjwTFntcvbYpZqV1BnxmeJpPBdvvZEniCmnZ2EECDr62mlu5CLSB0BarbSn0eI
         bCrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770214821; x=1770819621;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=theDrawoAnJAxlBeE5lT0JvtyS7Im48gsYMZVa7ym3k=;
        b=YH700VtQr2clT4dO14IA4XsI47TC2VTd58ucGAHM7rzU1kI5djrt47goKIQ8gu8hjQ
         WHa6fMzFj3LGIcm/854iLr2NpSnbCxcrRxr5yGC/KRelAwWNPerfThApNEWfsm71asX3
         ioNZJX4ohCxV/UpxIo/1uGxwEs+CYJrADQtKyfhfjzPFotduVsjFZ4nlYRdhAIxg5xNk
         WqYeMGEv64phnsb5iqToKRbLOGS84iXVl8kCpaGA8K6WxyLTt41prCGcwZyhw2AevZCU
         YibYP0NLX6u+NnAAiw8JykR3001YCaZx9ZqRiIpD3ud2QxHPP6KEfQDqS9KFw0GT8ABa
         aVMg==
X-Gm-Message-State: AOJu0YzdxCLgUib+cHsuDdPqaEHRaf9XOTE664kv7oyrWIjveZU8cy9V
	fGBapFBO1jc6uei/Y2AtXYfj+Li2Noe72Rr7mVHFN5lFsXU5gDbAIkoZNwvHww==
X-Gm-Gg: AZuq6aLs9AYr7khKI+8E2Y7sLzF5RivD9b/wbBYtyreszTVtlkXBfmMD5gLXdgC0tpM
	76nwlCTuuF7PIBbFYzuuUQ2hmp3MCTFWd3COgdMGsQYuOpF25WbSX+gcddMA7fqA5kRtCv/TuuY
	6cG9UDtIHaTjxTgSs+rKbv1Q6d9jsRoe8+rpJXOyNb/fWzCNzHZ0E32SOtSgSd+9y8cGqkzhyxh
	ZrBHpCvrglvc7nAxwVLZs93Qe9RHASn6IBtaJr0PPLOGGIflSXzVNJCFWvxyO90pqudLlgo2udV
	GUm5xKledZv6rwnXKkkutJ3AVdsKsQzoADyp8Bfw4SVNzdnXXxW1zbikf9dQ8CVApfRfcsCH1Cu
	utzfvsB1TW5dee8KeoePUZrztJvRCZJMJ2dpahTBHoCq6IpemVuukFT6lDpHS9kgODUMIaSGvlU
	o4NH9l+SzzU1Mgag==
X-Received: by 2002:a05:6808:2393:b0:45e:84e7:c20b with SMTP id 5614622812f47-462d58dc548mr1676034b6e.25.1770214821024;
        Wed, 04 Feb 2026 06:20:21 -0800 (PST)
Received: from [127.0.0.1] ([52.173.182.164])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-462d6608c82sm1440592b6e.4.2026.02.04.06.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 06:20:20 -0800 (PST)
Message-Id: <cf4f054fb6d382875402511b49ee901486380476.1770214803.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2033.git.1770214803.gitgitgadget@gmail.com>
References: <pull.2033.git.1770214803.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 04 Feb 2026 14:20:02 +0000
Subject: [PATCH 10/11] t1312: create read/write test
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
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

This new test will be extended in the future to ensure that multiple
commands that execute in order update the configuration state enough to
reflect new written values as we read them in later commands.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 t/t1312-config-batch.sh | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/t/t1312-config-batch.sh b/t/t1312-config-batch.sh
index 40f6f90ef2..11380f4247 100755
--- a/t/t1312-config-batch.sh
+++ b/t/t1312-config-batch.sh
@@ -295,4 +295,31 @@ test_expect_success 'set config by scope with -z' '
 	test_cmp expect-values values
 '
 
+test_expect_success 'read/write interactions in sequence' '
+	test_when_finished git config remove-section test.rw &&
+
+	cat >in <<-\EOF &&
+	get 1 local test.rw.missing
+	set 1 local test.rw.found found
+	get 1 local test.rw.found
+	set 1 local test.rw.found updated
+	get 1 local test.rw.found
+	EOF
+
+	cat >expect <<-\EOF &&
+	get 1 missing test.rw.missing
+	set 1 success local test.rw.found found
+	get 1 found test.rw.found local found
+	set 1 success local test.rw.found updated
+	get 1 found test.rw.found local updated
+	EOF
+
+	git config-batch <in >out 2>err &&
+
+	test_must_be_empty err &&
+	test_cmp expect out &&
+
+	test_cmp_config updated test.rw.found
+'
+
 test_done
-- 
gitgitgadget

