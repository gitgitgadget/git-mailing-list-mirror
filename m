Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B40409621
	for <git@vger.kernel.org>; Tue, 19 May 2026 16:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779207902; cv=none; b=SevRSaxxTJHwHyu8n3cyw/aGSa8G1tS0BzEP3MJD6zZ3C1Rc99fDrH5SzVHcEYK1FhC5tOrr19ubYhGjuwGoI46gf+KF2dmUDp3f7Tv7149BwT/rnPL9EMXrnaRLnS1H5CWW3T82GNXEUJSgG8FS8yBuPq7vGqPV8BbKidyOfDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779207902; c=relaxed/simple;
	bh=7dOXOCf76MCF9ZYR2uWY7aYNMlAlNKJlbMA5deWpH1E=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Xos9dKAIM6hw/Rkm6qAFi6j6WpkwcOcd6v6x416N6mrLCa/Q+bvvnw/6CwSNOGfUr4D8T5+tC0KVv//b1s8pKkL8dKJ9iqrHzNDF65SKYWbLKRpdVbtALM4lom0ggAuMlNwKTc9vYO/0cwBmdBgX2Pogs8wR7ZXwnc0RQHQETFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rqrsxEpL; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rqrsxEpL"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2f30a4601bbso3518510eec.1
        for <git@vger.kernel.org>; Tue, 19 May 2026 09:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779207900; x=1779812700; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x+17WIAGus99W1KAjRurcdNskb78GVifqz75ZFRAeqk=;
        b=rqrsxEpLtb1A2buJbl6DKeTzlTHTlmjpHRR3TsisXZrG8JKGKEg3fvBa63FfZuF1K2
         jCPRgE9OoFxG1vk8ObDGIqR2V/eOI6sJYVIpp7Aidw3s26JWftXNmH0ZKIMVgtpcJlNY
         73s9bSf2l055yMp5Q0cR89HNDNaS9TMpkbWHA6OZEPQawbXfVZUwsoUMueMnzjcR313v
         Qv3ucTrZqIaPTPRc6QNMh87IJ/IYiKthz51BytwD6KUAKH67BWHy+25pufJGNWKzZEAg
         HJ5/qh2NuYxIEGzB7zyzoW1zD0AaLoJvkX9yzKcYnMeJBx9Fe5dN7y973YvzKuBNIzdX
         HFZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779207900; x=1779812700;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x+17WIAGus99W1KAjRurcdNskb78GVifqz75ZFRAeqk=;
        b=nXS8ZQ55xRqfsqXuRVVbJd/8Mbx9eIm1KXr+R/6Ue3Q2vjInzaCyKGdajwTes6wGs8
         epIkzXRbzLUyOYNbIKyUcIDHrYWduymA+5dOsuau8ElvegEkqRkXJuTOajwsIPB2SMKK
         CBBEP+GFIq1hQepBESRAVJUTV5WeWB6z6G5lRQEKJkhwX4XXwooObwRYWoqb8UFf6c3L
         tcXi7cxTZbqFI54HgjeLbzu32BCucyFmqND0Kll7q9LrCeweOFEqSpwHGVFGOr8mkUKO
         mbvPle91FSBoE1lFRZzV1QVizFH9x5v4wPGlB5CDz92I5tO5ffUpC6pdBS9yHNdERJZH
         atog==
X-Gm-Message-State: AOJu0Yx/6SQf+f2+a9iObJvFID/tiJO67W5XSSIqFYkU1zQEV9sr+7Ps
	N9uGBzbMVI32mOPDsqkuv6SiACEperH9zlNArT+vtuYSrbj5HVqarOyxQey27g==
X-Gm-Gg: Acq92OEImTEYLwsh+/gLWzyLgROaBCKWvYYgsCUyF/oITt0+4J5l7rD/EKNkUz1hWCi
	EY/OOyqCLXEDgT1Ql3pOhzBHw0CXOV0/qMF47BwNKz263LExx/aP5HolNbZ4d0QWta/1yNaN4ly
	cScdG8X3Nb5Gmfvr9KHPqESfXUjeFduHcklbwmBfDbQhHSSBzTU7WLk6FHW3V2V23uZkp3CoFLy
	fjqIOmAbdQCX5YWSxsioA6uWSK4+IQujNLLPUYdrP/9563Yl0dURPnDA2yOUMLiQDUwg7aacPdf
	Oh+4+fk43ZW9kmugkR/VvjsEuA8NktFOdeoMws4qmJO3DLVx7fnv7fQfoufjTCbgKryyFfDFmvN
	HubSDQSJy4H48ljl87CcDMJfvIbozESQUxU9h0RgDHQC1e8zHlnntLiNpOxQNiP/Z1NRKNVUB4x
	49PXGJAjwKaUm8+yOi9py3QeQlH5TaDIIL791nNjE=
X-Received: by 2002:a05:693c:20c4:10b0:303:f26f:df30 with SMTP id 5a478bee46e88-303f26ffa15mr1898835eec.23.1779207898982;
        Tue, 19 May 2026 09:24:58 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.195.179])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30293e2e686sm19671949eec.5.2026.05.19.09.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 09:24:58 -0700 (PDT)
Message-Id: <c8c422f64614b176d95cf9cf2f9b78f3da96dd09.1779207896.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2085.v6.git.1779207896.gitgitgadget@gmail.com>
References: <pull.2085.v5.git.1779135575.gitgitgadget@gmail.com>
	<pull.2085.v6.git.1779207896.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 19 May 2026 16:24:48 +0000
Subject: [PATCH v6 1/8] t5516: fix test order flakiness
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
    ps@pks.im,
    Matthew John Cheetham <mjcheetham@outlook.com>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The 'fetch follows tags by default' test sorts using 'sort -k 4', but
for-each-ref output only has 3 columns. This relies on sort treating records
with fewer fields as having an empty fourth field, which may produce
unstable results depending on locale. This appears to be an accident added
in 3f763ddf28 (fetch: set remote/HEAD if it does not exist, 2024-11-22).

Use 'sort -k 3' to match the actual number of columns in the output.

Reviewed-by: Matthew John Cheetham <mjcheetham@outlook.com>
Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 t/t5516-fetch-push.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 29e2f17608..ac8447f21e 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1349,7 +1349,7 @@ test_expect_success 'fetch follows tags by default' '
 		git for-each-ref >tmp1 &&
 		sed -n "p; s|refs/heads/main$|refs/remotes/origin/main|p" tmp1 |
 		sed -n "p; s|refs/heads/main$|refs/remotes/origin/HEAD|p"  |
-		sort -k 4 >../expect
+		sort -k 3 >../expect
 	) &&
 	test_when_finished "rm -rf dst" &&
 	git init dst &&
-- 
gitgitgadget

