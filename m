Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8ED428D837
	for <git@vger.kernel.org>; Mon, 12 May 2025 12:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747054152; cv=none; b=ZNcfapcOsncVA4k7tfSi+ANeuT8IdqFu6Yw0rlzxH5AGSOAFzIorS0IVkVmkVmwsrdg5eDsAWOxTo7/bjQ7bFBI+cQktvDgNIbkw7pclgI9WBdCmXVxOWh7hSN+87GE0iqTJawbULO/FnJtrcv9m5374A8lb81n2eyio3fzqQw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747054152; c=relaxed/simple;
	bh=MO6T3NlAs0N2ZPxfNvCrcVk9c7IBq8BMaoHlrBplI5c=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=gCnaetPln41vXf+QpGG2O4rnsSc7Af630RO2dXkQTuKaOMM65UIyv8+NyjihrQ1qE9tmspiwkka7IjZDcBRQ0YbRPYc5ciXDz/F3dmicnhlAnRNVTax4YjJTMR39o7XZW4xvdAapZ0uabmgGjK6HVQ3PhNoZnFrrS3fXkyx7mCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eyh8qJoE; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eyh8qJoE"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a1fb18420aso2561454f8f.1
        for <git@vger.kernel.org>; Mon, 12 May 2025 05:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747054149; x=1747658949; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3/R1cOcr+dx+NK2G4U5FjHwbQJxm6XZgzU469XQntqY=;
        b=Eyh8qJoE9aFR/iUWaDxe2jJGITa5o2FZAIJv8tqnmKpdNwmCvXjIYKtoq/mvT2PrI+
         jeDij93Gc7nidRZs8zK7ygulJJ0ugrWMLhmhTcxcz8MJRBkcIwZ3WMGXQu0RoZz4OkUX
         pVac+USfGy1RbrmoOqjcUb6IK7Hf7HRTLkM2l7XbvdSaOKynS2I0C9i7FZcYy/qCfKo/
         cc+JFmwMmTNT8GoKrjn2ynyQpQIueyIxdgEWL+hbKrREpTdbXJyi7JUfVwCpmX3Gklag
         3MZJQTKEhC1zoUtjK/811lDTW8RfTZipix8vOLAH1jDI0ldh0Ge6K3XjzkpYAxxU6YSb
         zpHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747054149; x=1747658949;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3/R1cOcr+dx+NK2G4U5FjHwbQJxm6XZgzU469XQntqY=;
        b=d2kaqEGLWgIF5cTLPYvzYYOALgJkOfKNNZPeUlVrFwn+Dq3n6ne2O/Bh5nMq3ulcU9
         P7bwuwSPPpWv39kwkVv7vsE+a8VsIrde+1flRrTACgPSV9MvBQ3leQbKZGeu+bEvDdrO
         E0tlIGuLXuXELB8Q/tCCp+hIpSbR6XrP1xnc3ZqlxzYAyQ8Jfu1u0W7cu5F8MZ9tcEHR
         U5Y2nYiVGLGN3leiQfAX+H2czGYTYjt07tV4zzY5rs1vQJHkf33a+EPoFv8zXrssTOjK
         GihzlpUQgQyfoAg1zRzrIW92CjU4CX6PucNUFKDblGAZwKF+S1HeExcDVmIZ8h8MkaZS
         iX7Q==
X-Gm-Message-State: AOJu0YxtmdqKlD19fmJK0gDDzIFM/EVJ3ptP++Jc759W+qbVoARdkPWx
	87WW59xqBiCIgreul3RfneJbvY5c8Pi+15qVBbLA5VR5kvPckJD7uBUqNw==
X-Gm-Gg: ASbGncsWuoTaErkYyFSPqh003/o3kL/PmXTlcIf7N5US2BHaMbJ6j4NH5fCFdNB/WEi
	gyz1VSx7Bl2y/8bFFSIKP7XRTKHgDzswica5yu4nUCEIpwROASfqdJfSRW8k01STzDoC1xCtm8R
	jAN6pNUF3/5hPK0H0qRIYsBEy+SfXWsxcLdbNMFShuDZLUIytISUM6b4n3z8wlSc6pTTAIhGDn/
	DOd5RY7WBFrLXr7P4c3YXUPXQtOA07gJSLB/G2q+acxhTceehA9Vrh3nEbAPF61ybwvuxMhTZX4
	d1/HsmvqXT6fnuqaDYEPrixSIv93ftIb+V+Yo/GBZYfU+j9hF7N0
X-Google-Smtp-Source: AGHT+IFhNun/0T8xaUwKCwOjq94pLXzWoP3X8Uh1trlPDKv7gCxY7NRUughav67Y05D48hOYGvCt7w==
X-Received: by 2002:a05:6000:401e:b0:3a0:85ad:5ed9 with SMTP id ffacd0b85a97d-3a1f64240femr9580871f8f.4.1747054148502;
        Mon, 12 May 2025 05:49:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f5a4c7b2sm12472829f8f.93.2025.05.12.05.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 05:49:07 -0700 (PDT)
Message-Id: <64f778ce2ba6a3010d284daeb09ed2d591b54565.1747054145.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1958.v3.git.git.1747054145.gitgitgadget@gmail.com>
References: <pull.1958.v2.git.git.1746980165245.gitgitgadget@gmail.com>
	<pull.1958.v3.git.git.1747054145.gitgitgadget@gmail.com>
From: "Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 12 May 2025 12:49:04 +0000
Subject: [PATCH v3 2/2] reftable/writer: fix memory leak when
 `writer_index_hash()` fails
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Lidong Yan <502024330056@smail.nju.edu.cn>,
    Lidong Yan <502024330056@smail.nju.edu.cn>

From: Lidong Yan <502024330056@smail.nju.edu.cn>

In reftable/writer.c:writer_index_hash(), if `reftable_buf_add` failed,
key allocated by `reftable_malloc` will not be insert into `obj_index_tree`
thus leaks. Simple add reftable_free(key) will solve this problem.

Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
---
 reftable/writer.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/reftable/writer.c b/reftable/writer.c
index 3ceb37428887..3b4ebdd6dced 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -258,8 +258,10 @@ static int writer_index_hash(struct reftable_writer *w, struct reftable_buf *has
 
 		reftable_buf_reset(&key->hash);
 		err = reftable_buf_add(&key->hash, hash->buf, hash->len);
-		if (err < 0)
+		if (err < 0) {
+			reftable_free(key);
 			return err;
+		}
 		tree_insert(&w->obj_index_tree, key,
 			    &obj_index_tree_node_compare);
 	} else {
-- 
gitgitgadget
