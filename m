Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794167741;
	b=GGrw7YcJuQfkU34ers+R4fqzCy94SqsqvmvIUVp58LXhokvLTelBalSMSuWJ4xgU3cfI
	 c7JWB1Tmc98BT0jHLFyiihX7lC/TKaKPzTX07dUqUOYz9O7XOxpIbhSZI3rULghbrmOCv
	 Ax4TA3IUtYMjwRPs856SWBWtkMOppwNOYBh8KRUVL9M5coYH983aFxnHFFajh2kayDUoL
	 d3HnYrc/o576tdRfDy/qBUg6Yp4Jq7oKK8Kpc1K8KVdLQjm+/W76W2kg/kKrLZZfenEso
	 4wmHP+4fZBKc2vbpFTe2DAe+1QymAZ/UpPUTfTcL0EOM5tqO/A1cXG23+2BLU0cbkHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794167741;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jURHrihd4OS5yrJgZyJdtVFg/JmZ5eFEqOUYyQSySzE=;
	b=NggKePz99oK8Padmu0otoECfUHIu9aaGj5P0tp0IeFblDZaYhYja0Sn3ncBv3BvBU0LK
	 Se7hveCKl+HiMeqeEG23qk1EvYO2RVhPfTNNtXvYRl48APVmPDE+q24hmQ7EuDbICIJUb
	 AhzIH0hBRPgKvP3p+TlCuUqVD9J6e+i9CjufSL2bYkMrKiVC15mFOJAc32KuRJEh+5uCs
	 ybYCDKH5tL/KfKmQmh1aHLn+41Z2B4q4dWRGFHYG1fsYQp1fq9X0NEFxsr1x4ZfaLEV4a
	 dqiXiMsElemTT3EfgEDn73cBizqW3imDuGHGrIYl32tMTkCLLwdA1C9RfDY8tcNND5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x+nhUmK7;
	arc=none smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B1F606A31C
	for <git@vger.kernel.org>; Sun,  8 Nov 2026 19:55:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7B1F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x+nhUmK7
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-15ea896ddc8so486867c88.0
        for <git@vger.kernel.org>; Sun, 08 Nov 2026 11:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794167739; x=1794772539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jURHrihd4OS5yrJgZyJdtVFg/JmZ5eFEqOUYyQSySzE=;
        b=x+nhUmK7YG9R0xyQdLfKHcpiOXLVXNDjmjfbXDAcn1o6acHQhBBDhYncdL5Z93aXPu
         1zgzdbZgH4/5veCa3TFTqLIMH8sBpJXvvlPMyRG6G4WkEUtJr5eMyTQyIHGgoP1pUlsQ
         wpOely63Tw9dOXlVv3rT7Ga/h1WH0fTqDDXM4pyzqIVogk0t7pduxU2XuDQUOvBoI2tK
         HeI2bU1S5xvjV+kSEok/SOZK53QmZ6GFXMXzu8j9RT5sTBHWbJyV7zfc4UncE6JYK290
         wzA0bn8mbNVebgSfo3yoig2TjgiyaAVDdM4S4T+o9J+6ajYAuo2MkFT+RY0WgROplhr3
         SYFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794167739; x=1794772539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jURHrihd4OS5yrJgZyJdtVFg/JmZ5eFEqOUYyQSySzE=;
        b=h0YWC1aHurXPM2eR9ZA0RKXi1BSTgJgyD9CYCOroF4gG69qr9aSxdNw8yxhyG/WkR2
         HDnR8TC7LBkXRlJPFbtYEzgLBoLdXS4TUYZTl05Z5/NiZYyezvra+bcEgrbpOz8E1zDV
         xFLQ1HF9ySzqPrFYNOUOmQtBvj48574CMjw0uR9GFeFeT4SrI/bCuE20CK0WoAeAkcDx
         JST5LuOCMawwAZPgcCQdqA4tpko+hvsHyuDp3G7b+7rtMNYB2AxYSN10KTBFku842cV/
         BCcFu/bvgjVbl2IODWdjLw8uLaIxHwAdaALA4Wx429YplSoLiMZmLbix3m7HVDcke6LA
         HHlA==
X-Gm-Message-State: APuU4Z9qsUtkCiJMTEtyUdUucbmyEge7Jc/0iBW5vr++aJ8nQRvQK+D2
	PWOrkfD7aNIJEr7yrRZMiA+5UufT+GClNSOGPlZOajs8vnLCVRWfCBZB1fFm9Q==
X-Gm-Gg: AYBFou3eBZc+afitt88vf9MolRYkGGYxZ1qo9ZmPDA5cTi2ulESYht2lpEJsQN3erLo
	oOM+4tgDJhXusEDnZEs8oLVYYXZ97txa4q4HIOyp56SvOUGRy1gWqn/J+h30UFwS50lpjEhQtWm
	3vv6ngxYI4yJ3ZhIq0fK6BK+wpaKi0rvV8x8TzzeES2Z26FkuvZjUdE6/nIfhy2mrIm9K1TqPoi
	98yFIrU2J7qHqmTd0ROJK47mJb6irudK7akYFjaI7CLXzRYILAukaqwfwNpfOmLWMLGPfWqv1AB
	xNfjFM5Hl1McO9O2floIV7Vkw+IeeKjAzzbNMYdnCVrH7yj77Z5c8lJ1FVmLmrHksNHNmZoFFs3
	Gcl523gNotUBZgORrdhY3XIwL47n1MCdb4lfW9VDoey8IfL/XQcfohEOGAJ2teU9puU7mIzT7xE
	V5TWWxazVvu3OqNxhySRu2robJB8yliAwzuvRoa7/0j20iS/au399sjk+1gJUpgPPvjZNoFvArw
	vrdMkTJU1ZlGEf6ykDE6OTznMjx1Xpcwa7G0hPaoavHbo8P+23k4y8abh7hJqUeDslX3UN2bdfY
	MNzyGJwMn1Jy/3HG1NdT2ljypT1/8P+8zbqG0Hy/6HfNjf24ds/Jr6El00YOYtPaG4nS3G/G
X-Received: by 2002:a05:7301:fac:b0:36e:370d:2127 with SMTP id 5a478bee46e88-37255f40aeemr3943843eec.32.1794167739371;
        Sun, 08 Nov 2026 11:55:39 -0800 (PST)
Received: from Anonymous.localdomain ([223.181.58.0])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-372660f444csm10890799eec.19.2026.11.08.11.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 11:55:38 -0800 (PST)
From: Hussain Sitamouwala <husainsitamuwala21@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	christian.couder@gmail.com,
	Hussain Sitamouwala <husainsitamuwala21@gmail.com>
Subject: [PATCH v3] doc: describe promisor remote fetch order
Date: Sun,  8 Nov 2026 19:55:18 +0000
Message-ID: <20261108195518.943-1-husainsitamuwala21@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261108071933.6586-1-husainsitamuwala21@gmail.com>
References: <20261108071933.6586-1-husainsitamuwala21@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Explain that promisor remotes accepted from a server are tried
before other promisor remotes. The ordering was introduced by
8808e61fd3 (promisor-remote: try accepted remotes before others in
get_direct(), 2026-04-07).

Signed-off-by: Hussain Sitamouwala <husainsitamuwala21@gmail.com>
---
Changes since v2:
- removed the redundant fetch-fallback sentence, as suggested by Junio
- dropped the matching clause from the commit message
 Documentation/technical/partial-clone.adoc | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/technical/partial-clone.adoc b/Documentation/technical/partial-clone.adoc
index 18718a3840..52fce44384 100644
--- a/Documentation/technical/partial-clone.adoc
+++ b/Documentation/technical/partial-clone.adoc
@@ -195,7 +195,9 @@ cache servers for fetching missing blobs while continuing to do
 filtered `git-fetch` commands from the central server.
 
 When fetching objects, promisor remotes are tried one after the other
-until all the objects have been fetched.
+until all the objects have been fetched. Promisor remotes that the
+client accepted from a server's advertisement are tried before the
+other promisor remotes.
 
 Remotes that are considered "promisor" remotes are those specified by
 the following configuration variables:
-- 
2.53.0

