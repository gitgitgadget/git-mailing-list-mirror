Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EEC3FB074
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 22:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786140437; cv=none; b=luXfz04b/WlKDO2wgc2oNvRKtV8rUtpumoW9MKDMnecqF4OJFdUOXmyhMmQQ6k+RxcdDORn3DjWPYcxZhC7GJrDM8KXcznPuN2OzyuDwMEf0Jn1PmQGtANepRI5AOTrOL1AjEowoP9DVR294mA+x2RfQKAxvnm/Az4mr+fXqk+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786140437; c=relaxed/simple;
	bh=2d8Jb62RcZ1BqXZcJhkmVmshWJx/7tKWOf6ZY9gr/zY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jBnmBrRyChqmFiNJLX3zgLMwurJW8W9O+951yXKDfDuDZpWzFViAOIMZFZ4tvYtaVuhlmSJB5AzEOwmH9gXqbJum2bamZjpGniEIuyNIKg617Au1VqoDZYUUZSs01Po5FlSLfVtWJzWKWLdYL+PO4sZ7qwBIRqSaaf3PcUtC7Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j2sqQVLv; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2sqQVLv"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so326455e9.0
        for <git@vger.kernel.org>; Fri, 07 Aug 2026 15:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786140434; x=1786745234; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t/LL+SqQadcXFe2hWDc+/Clc2YxKLaEDdEPU07qVSso=;
        b=j2sqQVLvQKXpW+dVlavX8XrlQywhOVYMT20uHjnJtUyKP24FhsSQWykvOLcV/V2keY
         n/dGJtuELZl+Xd9MB7p4DRXW3W9d4rgE3mcBxv3LkNWUcIuqtrBwXpf2I6uWIx6O19jH
         eHJWhxmqa5N03J7mQCDAPjAK8KJwwb6XRyLGfMQkT57a7+nKyxgCDZkELgCwrFoQw5bm
         wpllHt3Mc117BDntp6JVdCycwAnkGI/+/a2gUQTG9/rEZRdH2JW+xloes2VimEgIKUtT
         BNRPiqTXio4K2HnegM/15sgBXwYKeMA/yg1D2airB8qDG34xGUIgtZ1B3XYOv6VsunKs
         sxdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786140434; x=1786745234;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t/LL+SqQadcXFe2hWDc+/Clc2YxKLaEDdEPU07qVSso=;
        b=gVuKfiOYAJ5krGv8Zs4Tpv1ZQwWe+bBn94aBkpSE8i3sB8Vbf9wmbhucav0naE4Vaf
         M154NeARwteOzJOkDKjlEj7HeiCBfRa9zhcNgy2b2l7Q+P8PF9ernzdV1XTEnOxnS2dO
         dppYzhgB81vEIUA5LiIGLcI5zl/flPTcG2qQ8f8mf4SqK24w9BIInf1HaKCR+606Et4h
         +oOe0//XI6uY1yeDf/fnrJCFz0/2dFZq4zIFvaxCEakzQye60oCTbdw7yAodo+orPAiB
         ELwwEN94ZfIGIIgaAxaHa80jGZYNvkJcknkIbARiei+ri8/lqWqsUAUUHQyzwzcE6aEE
         QAUA==
X-Gm-Message-State: AOJu0Ywi2i3sjxaT7NEw8ooq3n00+PzfY23qQAgdJAB6WdBMoIhyPvyA
	k57WhIHeeUDneySrOgjmq8ghw6FJbyG5gJhu2rj8QONbvQbSgifQ8/H7
X-Gm-Gg: AR+sD116Qf/57OUNmdy6dcdsB92OySnYk2c+DKNDVFgw0Gp209dEiSwgID+LKNj2abh
	MphZ+OMOfM7/1V9sDO+uF6xG56LQCAkqlz636Om/UlgoFG1dyCNlfoNIEPvkViyh5erQOlPRDld
	LIBhChWAVsKU/8YZpmRpQsQ8mjQSFjHRhobARMSrgHnEjqNvwcWEbyLh2hJ0ZvTBI8JYkm8BFew
	+K5ER1zelFEBrnT63bcsjQBXyu8ptLW/z2Wj1qrGBRfQLWLb+dC6hclnaQL+dbeVvwf6BoT3/cO
	sCoMXf0fUewpDoYBC/Gi0V3FdFapbp9i+lSWlDA5Q1DTSF/YYHCwN1YAxEOLuPLszf4dVUALRMc
	F1WEbAp1C6GZpjrbO8KhKyxcHxBSWxdJMtmJNk3G7E/XtAyHBNTu5CJhuxvZMyxsxljitLZLpmC
	6vbJ9E/ByLf9bs4SY8BF1FTmfitbUv68w8jPGFAckVMlP4v54JN3SiHWz/FTRosL0z+vLuB0GQm
	4//5Df2hw8iiGSB+knw/algdGsjpWxFhH5izt3vUEg6OXxBT+iS4KdaY6mvg/NOLgaVtecgB1SK
	0aXMzT6xr8FHTYY6ZoU6ji4aCqfHhPCdxWYO8ijjXGfi+gCLFe/oehyFspi9BIzsQqE4XrFP4HF
	iN7PtjpSRMpvCZFGCakoQKUiQqWnk5TZtUtRxRo4/Bb8FaT71YLSDZIwYTcJHqJ9lHatyBg==
X-Received: by 2002:a05:600c:4e87:b0:493:e365:ace9 with SMTP id 5b1f17b1804b1-4994e7c0356mr341297595e9.11.1786140434288;
        Fri, 07 Aug 2026 15:07:14 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa (183.red-79-149-223.dynamicip.rima-tde.net. [79.149.223.183])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995c7b4499sm69478545e9.3.2026.08.07.15.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 15:07:13 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Sat, 08 Aug 2026 00:06:57 +0200
Subject: [PATCH GSoC v5 02/10] fetch-object-info: detect malformed server
 responses
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260808-objecttype-support-v5-2-86f22bec04b2@gmail.com>
References: <20260808-objecttype-support-v5-0-86f22bec04b2@gmail.com>
In-Reply-To: <20260808-objecttype-support-v5-0-86f22bec04b2@gmail.com>
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

