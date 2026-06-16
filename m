Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D232D3C062A
	for <git@vger.kernel.org>; Tue, 16 Jun 2026 14:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781621415; cv=none; b=deKy4+/XztOdMJGKZBiV+JuemTKLAN5iPffnidCUS3ERT1/9FMw2B1PlpVMahDR4xHWZti3WXQMMcIemoTICFYEapBdUxTTD2WbcrmSOAxBzyHgPWV+WY4XaXaTV5xbLkjh0DsbiWw+XWrlVpM+LxoHiBon57S9dRQ+tjZ9LEa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781621415; c=relaxed/simple;
	bh=SAhQR/wJQxVDP/ziKT+VkL+7qXXW2pm8u7Rl3+RTdcg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=qX1hJZG2u0IvdPpmNAwhbNLEEuyQrbvTDvXvuuxT/J9JhrT1E+DJ8RK/kayZEhP37KdyShg6dezlx3wkt0aiUFzG976kSUI42iuaQOZnBZlAbcXvUNjpGToQVTTg+5VEPi4pDCEf3deMKM7E3w3qf6yALVE5Duyw7zoVgiYw8yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K8AhBlGx; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8AhBlGx"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-9157f7c1c0eso489252685a.1
        for <git@vger.kernel.org>; Tue, 16 Jun 2026 07:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781621413; x=1782226213; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A2AE3KoIOq0la3p3A4ZyybJMRj89lbCmkY9X+rQxjvE=;
        b=K8AhBlGx3FuDyqvQgBtA43g4ncecsc0YSQgiG776uf3pH749Qp6gfGE95xt/SPRpvw
         c07GfVWCAcMc13ipeAmh8JCtfVoSNqwnRKMDBq1ND88vtrPV2TU3Ie/q6kaF4aJp3rEH
         eodxoJ1t4LLIfemnuiBqiNo7mou82hUw39Tpe1b0lLNoH2vtex/3zTfUghVoxJLZl4Sq
         2nTh3c5aQeQXUVEUQONlACwRH1UxdY1Ne0fgXq1yJ50Kp1qfjArYqZUmydITAqdtwIg1
         lCrBTIEe2RVpYAOHOY9cMt/omlcrXrtYiHj7dpa0QUhdUqF7l5Wp83/CQE0Ss1ZIDh7C
         ZRHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781621413; x=1782226213;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A2AE3KoIOq0la3p3A4ZyybJMRj89lbCmkY9X+rQxjvE=;
        b=BFzzgW6TkBcN5u+CQxEY3ysfWNNGElkF/fQ+DJ3aHKa4V+sTPKULGTu9OFsiFa73Ty
         C5Oa2G67b0XPTBc52eu11cYyRdWcdxHrFUHqY6jNAUBOrarAOAndzgJONgJQqxlOf3sQ
         sMGJiBIpZi0SvuwqZFw54d59KeTFMbnUdSIwBOMC0lzEUa1dWE6rcEkxdTFL9OH+W1oh
         jpREzYMRkPV1+VHQt8Uj6To4TCq71AQu4y7a4wSrmW56L4XcQuFLz2RyVza6I6xiDFqb
         nw2411t+XphiV/NDhJCzIecni0AenzG4wm1R3DtjzbCrhzwtiaB7JvyJI5CtrZo+onLy
         htpQ==
X-Gm-Message-State: AOJu0YxwIbJ7/4+pgLrs/vrTfZ9CKIg3yG03HMol8ijmat//8NFwcMZe
	ZHyT8rizJGtVkwmg33FmyxqSdvXq8FMPKq+z83+9pvHnStQgmfBJnFTKwik5/Q==
X-Gm-Gg: Acq92OEAF6Gh4PDedvg6onH1asiGTFS4eGWLF7paCTiEZh3HAvCPp+2bmrrWDmaNw+y
	bUeJoUNYZolVRD8CNar3rWz+11Ba5R9GFWAvieDNBcLQ/MjUeI1w73amksRaQgiJTU+1XxjDvq7
	MpY6jctiZp5JmjGnZVdM7OmcBiQveoGKDdhoROpKXkAcCk+liKEad+bzDznGNbbscwGPzTpbAY0
	hakNsNWRDIPqGH5gOuFEy+ZEWBi3AOh0BMzr7r24p7av9pjJ3c+CYSZZxaY3ZnfDKIsrHW+8Kpd
	EBDpiPEzhnX7BEmu6/lbLxLDKE4oy3tXyEw42b4gDU/Z5ffiGU1fe+qh4eyLra7926otN7Bt/fW
	gIACfTBGbVQ8Ty/MvHHvl01JgCzj0uvCWV/wKE7Jvp6XNOrscP+jm1O7aCLUVjvnVqxkTMp64nL
	+gUEid1o3W2DW+3A0Q3tQXPmP+qQ==
X-Received: by 2002:a05:620a:2552:b0:915:c858:7d3f with SMTP id af79cd13be357-91c468c8c2cmr611871885a.19.1781621412644;
        Tue, 16 Jun 2026 07:50:12 -0700 (PDT)
Received: from [127.0.0.1] ([20.161.77.160])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91619f3c324sm1477401485a.21.2026.06.16.07.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 07:50:10 -0700 (PDT)
Message-Id: <568807ac349c8b9c6b01b7564ac12aeef2ef387b.1781621398.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.v2.git.1781621398.gitgitgadget@gmail.com>
References: <pull.2138.git.1780593313.gitgitgadget@gmail.com>
	<pull.2138.v2.git.1781621398.gitgitgadget@gmail.com>
From: "Philip Oakley via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 16 Jun 2026 14:49:57 +0000
Subject: [PATCH v2 6/6] hash-object: add a >4GB/LLP64 test case using filtered
 input
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
Cc: Philip Oakley <philipoakley@iee.email>,
    Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Philip Oakley <philipoakley@iee.email>

From: Philip Oakley <philipoakley@iee.email>

To verify that the `clean` side of the `clean`/`smudge` filter code is
correct with regards to LLP64 (read: to ensure that `size_t` is used
instead of `unsigned long`), here is a test case using a trivial filter,
specifically _not_ writing anything to the object store to limit the
scope of the test case.

As in previous commits, the `big` file from previous test cases is
reused if available, to save setup time, otherwise re-generated.

Signed-off-by: Philip Oakley <philipoakley@iee.email>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t1007-hash-object.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/t/t1007-hash-object.sh b/t/t1007-hash-object.sh
index f96c29ce68..4bc82dd968 100755
--- a/t/t1007-hash-object.sh
+++ b/t/t1007-hash-object.sh
@@ -285,4 +285,16 @@ test_expect_success EXPENSIVE,SIZE_T_IS_64BIT \
 	test_cmp expect actual
 '
 
+# This clean filter does nothing, other than excercising the interface.
+# We ensure that cleaning doesn't mangle large files on 64-bit Windows.
+test_expect_success EXPENSIVE,SIZE_T_IS_64BIT \
+		'hash filtered files over 4GB correctly' '
+	{ test -f big || test-tool genzeros $((5*1024*1024*1024)) >big; } &&
+	test_oid large5GB >expect &&
+	test_config filter.null-filter.clean "cat" &&
+	echo "big filter=null-filter" >.gitattributes &&
+	git hash-object -- big >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget
