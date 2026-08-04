Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D078B417BE2
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 18:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785868984; cv=none; b=Wf+/G0U+GaApf1GSCQzY9sXeNB6/L9UrTbP3K/0X5V+nCEaGL/Qp9Xqj4EHrIUdlfDXIa8dChiW3EFKWlyPcOq/vrbtlxPPBz1YXs4uUw5um63izkV28N6QOlloJ6GJt8JJ3zW9780gzom5HYQpM3dSKBNT4ke5rJdo4v0pO85U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785868984; c=relaxed/simple;
	bh=2d8Jb62RcZ1BqXZcJhkmVmshWJx/7tKWOf6ZY9gr/zY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hma0d3EbR/R6TIlYnq5XCX/Fb5IU2Xk7Mbn0iSLY8JRi2peBEvo1wJsgpv+FEFRkQwOSsvNq2IaFh8Wuz7BUsrfNS3snOXpbNR+pgdp46zSiODk71s4NRW2FaBSfv2JlV2roMtLaQJn+8cjlX/R8aDzhjTDzZ/5rOiTm7XXAXS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UotRxqSm; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UotRxqSm"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4957eefd361so943705e9.1
        for <git@vger.kernel.org>; Tue, 04 Aug 2026 11:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785868981; x=1786473781; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t/LL+SqQadcXFe2hWDc+/Clc2YxKLaEDdEPU07qVSso=;
        b=UotRxqSmTRuSCmIkfbNZf4IQQkwbeYXnOwNfo4zrOIYy0/frKl6f2o1qTv7mQKM9Dn
         uJPet+e1hTnnFPZI1AgPiOvTJcxskHXm++bnpiM68i7LinLbBzmj7kKKTgzoaaldjo/u
         7zXjrEodU8n4gCe0uNJF2N5ayQ11D0qtaW8fQrIr+FV3ayQSAtD0gtfmyvOSV3KUkTfm
         zTcc6iV0BZ/VOtF4IjWqKwXBsKmtRdigw7/mYrMWqmflx75AixKOkmxiWWiz9ZcsMmCU
         yPF2Wf9k0xnhl98FNCYxZGsKwz7uTeEcjbFOUpbKdycrm0MUpgGEOhIYerFntl4LsUKj
         qtBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785868981; x=1786473781;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t/LL+SqQadcXFe2hWDc+/Clc2YxKLaEDdEPU07qVSso=;
        b=i3MTIbFcLpmnImvG2eRuPg2tlLQHtHi5lao04I7DeO65YRLOYOacuZ8I+HYEpihnAP
         5uUp/mqpLk8NJCwQJRytAeolLmxb251PqSox58w2nKrVukvKPHDGiBGHYtOuLatLc5q+
         SJWmn0FNUUR5wQViQgVcbFkVYjLEK2z7nKaSjAJD/aX53CCZl3m/oDewvCDRsZZcOzE3
         RDbVrfKc4ju1hjohmuIj2rxoDd97MffQlrLGNP15NKBkIEJOvC4akcHI1rPO5cmCyUS4
         5hbX4l9CNrYoZ/pjyr+ehohz9gS6LcctAGwCBLK+0VOCIdrmMBKHUkUwxsK8h2usKEea
         NWfQ==
X-Gm-Message-State: AOJu0Ywy0vmlaTRJ0nMoP03FLzcH38EekJWmjqv8I81l9lWQcZJ7PClm
	c45mvnoN7yja0pJm5s03loe9bk6aHNpJZiQHxZgzBlyf0a3OHlOexkUn
X-Gm-Gg: AR+sD13gPOy4yZGpbtxoSvz7pveM9JOxWz49L/7acSWkOdRtw35nEnmAZiTPn4jQSBR
	Go/XdTAP36mLY6xaA+U+KcRn3V87FDaNSJDtwCKtEFJcsgBvlfUnxcx8c7+az+PHo2fbF8eePdX
	3cHMZTdNDajaNrUdmv3aUd9jkCfmT7b0fRGifxov44yUxKOA9v7XkM+2WPbs3tIKj22Ydbqcn6V
	JYg5yaU9+XhmM+nsjIdgO6f/HfkJpiEi6LtjOoDw6MZs7PzEgFdBemXRguMpAblbVD7BpsT4bJM
	CnHAwm6w1sSKoZ7vFEpc06heB8qMOb1fSGZXU2oiEzIkfl1vwI5TJeXDCmfgbqQEE+zmY3MDuKX
	028jADWEYtdr5mPJCUyMAvHZmfS29pdcGIUDCIrs9ptRWnmuQSca5+wot6po8IbT2207XNXV8OF
	us52J3lVKIG0vaBXAGeNH4n8ocStPBH5svlvn0MhuppNr6wxc7yzUH4PhDm/L5BN12PfClh7tIT
	HUhT6UztD/moo5KJmI+eJQ1xJH3n/79l0Vo/WWxMg/DcKM7RBQstZseGT+RJ5Bp5gADKz4hLk0G
	4jyviHEYw10XiKmjyK4SYbdPOEtzV0PufMRUPHajPYw8Ye7PUBAEIvKP+3++cHDVvRvoHUpFu9Y
	TtrVSLBx+80OjhsSy
X-Received: by 2002:a05:600c:8116:b0:495:3da3:beb with SMTP id 5b1f17b1804b1-4994e7b74a2mr4343975e9.10.1785868980954;
        Tue, 04 Aug 2026 11:43:00 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([47.58.8.78])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994a0f7b73sm138877835e9.9.2026.08.04.11.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 11:43:00 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Tue, 04 Aug 2026 20:42:56 +0200
Subject: [PATCH GSoC v4 2/9] fetch-object-info: detect malformed server
 responses
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-objecttype-support-v4-2-31511b0231be@gmail.com>
References: <20260804-objecttype-support-v4-0-31511b0231be@gmail.com>
In-Reply-To: <20260804-objecttype-support-v4-0-31511b0231be@gmail.com>
To: git@vger.kernel.org
Cc: chandrapratap3519@gmail.com, karthik.188@gmail.com, gitster@pobox.com, 
 peff@peff.net, Pablo Sabater <pabloosabaterr@gmail.com>
X-Mailer: b4 0.15.2

The loop reading the object-info response stops as soon as the reader
returns something other than PACKET_READ_NORMAL, or once it has read as
many lines as we requested. Neither end is checked.

A server that answers with fewer objects leaves the end of the result
arrays empty, and the caller trusts that every requested object was
filled in. A server that answers with more leaves the extra packets
unread. On stateless transports check_stateless_delimiter() notices, but
on the others it passes unnoticed.

Check both limits by extracting the packet_reader_read() from the loop
condition, so the loop no longer consumes the last packet (flush). If
while looping the read is different from a PACKET_READ_NORMAL, die()
meaning there are fewer objects than expected. After iterating, we only
expect a flush, so if the last packet is not a flush, die().

Helped-by: Junio C Hamano <gitster@pobox.com>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Mentored-by: Chandra Pratap <chandrapratap3519@gmail.com>
Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 fetch-object-info.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/fetch-object-info.c b/fetch-object-info.c
index ba7e179c44..c2d4bf9403 100644
--- a/fetch-object-info.c
+++ b/fetch-object-info.c
@@ -106,12 +106,13 @@ int fetch_object_info(const enum protocol_version version, struct object_info_ar
 		}
 	}
 
-	for (size_t i = 0;
-	     packet_reader_read(reader) == PACKET_READ_NORMAL &&
-	     i < args->oids->nr;
-	     i++) {
+	for (size_t i = 0; i < args->oids->nr; i++) {
 		struct string_list object_info_values = STRING_LIST_INIT_DUP;
 
+		if (packet_reader_read(reader) != PACKET_READ_NORMAL)
+			die(_("object-info: expected %" PRIuMAX " objects, got %" PRIuMAX),
+			    (uintmax_t)args->oids->nr, (uintmax_t)i);
+
 		string_list_split(&object_info_values, reader->line, " ", -1);
 
 		if (strcmp(object_info_values.items[0].string,
@@ -150,6 +151,11 @@ int fetch_object_info(const enum protocol_version version, struct object_info_ar
 
 		string_list_clear(&object_info_values, 0);
 	}
+
+	if (packet_reader_read(reader) != PACKET_READ_FLUSH)
+		die(_("object-info: expected flush after %"PRIuMAX" objects"),
+		    (uintmax_t)args->oids->nr);
+
 	check_stateless_delimiter(stateless_rpc, reader, "stateless delimiter expected");
 
 	return 0;

-- 
2.54.0

