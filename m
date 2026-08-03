Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986D5412BF0
	for <git@vger.kernel.org>; Mon,  3 Aug 2026 14:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785768013; cv=none; b=e28vd2C+EyjNpKm5XnqqKeS89O9zzpzTJtSoK/TeDBwGHnufo1g+qAZLDPboZ5hTVcLBCnTa5PYU3ChYakmZy9YqRNIreFTJvvVZS/IRgDo8V+FdKxMQVZBletmsR+TyArqurHfCrUjW9VSezTFnOlCYaIe/QAqUrcgjtrDz9Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785768013; c=relaxed/simple;
	bh=mofLCEEEEhIwfuSmkj1otdbEWmxoWP9qrRTjEsC3dqA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B3nVsRrX1ru4bNdN0wn6Pzt2LOG9OpaYad6QyNgmI2rbucCayVK1xtp+4Ix19SpsaRlqe0HZEA2iiNLx4yBIuvdNSvl0FLP24K9eaM/mC0/BO/MyTV9zNJjSf4KBzTVSex9veX6DfdNuBW9EOaRLSGL6+oW0IWMgHn6QwJn6PfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dl6yDpdR; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dl6yDpdR"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49555a0e68bso10499445e9.2
        for <git@vger.kernel.org>; Mon, 03 Aug 2026 07:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785768010; x=1786372810; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dBAWtMDtv6TMKwUKh2+8zdYA8H5Hud5lijt+6iY5AgU=;
        b=Dl6yDpdR6y28H8M9VvPotiPEtfmMihI/m3L8ECy2zuH10uSw/8t5KxgqPcvBjrwvzb
         YJ+34J0CUBvQCK9Jtm21rIFezyKYJArAgj1Jv8XvwLM7k5sFEPvHVRcbq9MFHNqHTSwr
         Ndhf8DoxAir8SUHRAADBEmTCtZT/nOJxb6bJJ7HHv1ZU6iViRTMjp2H7NRefQGe3KVOO
         ANgfbviYhZNxCs63B/H7KY3ULmNfpCFTTjr/j/YgmEcPHxTVvwV7CnDT2jXmNWrGdAuf
         7zos5rZdYfB/DTo7RPkMgmInn692eH2qw/ro8+mp+qNTUWs0fWmyNdvSfxNK6lGWHOLg
         0LFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785768010; x=1786372810;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dBAWtMDtv6TMKwUKh2+8zdYA8H5Hud5lijt+6iY5AgU=;
        b=ZOJVI9sDDCcUPBRd8BM2pIC1N/VcjSYsxVksU0HJlWvNQc4TkhvLsx8W17TD7BnZr3
         LGWzsvvfyK5WmTvmUw9F744jMZfgJwFLKoAcbqfjdt2Ba/OaXZgg4HGMM0BjWluxOi4b
         X+/YOqydgRA3W/18YNcxjWtyNJ1VncqpjcmbyewuswomyRuqfRmByy/ZsnAB0oXL9jDs
         whS0VplBHrd6oSyFn185cHca1Uj9f5S1dzVtEedWizCJk6xPy9QKVcIaTr77KSRNj1Uc
         62VjrkpVxH/o78J3GDJF7bWSkeAKKvIoNTQ7UHKCafD3JSfnAVnPndAiDEyCxA3D121R
         OZpQ==
X-Gm-Message-State: AOJu0YyqRhD45BiYLcr8XWkHJ+05aSq//EqK1UZ1+aOUYaf146X8zQvC
	l9m1frEPwB/hCm1vFKxzPfRrGm+t8J36O6Auxk1k9ZRFF+nmq3/zjK89
X-Gm-Gg: AR+sD12PRa9ECjH6PhKanRPmeAlz108XzdAIUZur3bvThZQuWNC1qYmX0oRwmEHtG6x
	MgYvif9OMEuy1jnq/QKy4vqzlDf2hv6fAjEdxJzcImLMRPAUwhGMFT+2ztU968xebK45lEmLOfR
	JwKe4mOF0IbMoR0txPm0d9sEso2zooYcYyhRzXkq+MgmXm5jy2PVsBWJEjKXwvXt8mIO1lNb/5K
	10HgzYnt7kP/C4CCd44PqPxJYzGeiu/n17Q5SGl+UlxYpu4T6YhrfWE0bI9OYKP6VCkSw9ffFGl
	Q/EYf86trCFM7ITGHJTsWlq7gW1dPcxnVgU5fzhCRKMrN2S9cboE/6IT4cfwpH+T6nu7uYCwBqp
	CJiJKLTixTpyV8Nn78q0CjBwrSG5azhi/ZAQZcX6PJhAmH5mZUicfXrL7Ui5M/j02aFDyUnsQA3
	Ruv5kAYmzcBGhHeB4CmWUSxpywhbhrZKYN1wvqkfi2lyiT4aIsGbX0PvCzhYpK63L0xZeC9Ybx8
	WiG9aVxhDfEifDCIvG/Ud5DgDLTpbnb+4y18Jp+0KXLk0aIuTYiaeFfONrPPjaZLT6cO3zkSQ/z
	L78njSoihWhoX9I4Xg9KzryAu26QZ5JxylgKHo+2X9InucczdFjt6F8VK48SS9t4UpcANHgro+Y
	TAvaxNBni1xtwoc6o
X-Received: by 2002:a7b:cc82:0:b0:495:6e68:5df2 with SMTP id 5b1f17b1804b1-4980c673d61mr173209495e9.12.1785768009637;
        Mon, 03 Aug 2026 07:40:09 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([47.58.8.78])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b86d66sm106482575e9.1.2026.08.03.07.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 07:40:09 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Mon, 03 Aug 2026 16:39:29 +0200
Subject: [PATCH GSoC v3 2/8] fetch-object-info: detect truncated server
 responses
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-objecttype-support-v3-2-7176fecf7950@gmail.com>
References: <20260803-objecttype-support-v3-0-7176fecf7950@gmail.com>
In-Reply-To: <20260803-objecttype-support-v3-0-7176fecf7950@gmail.com>
To: git@vger.kernel.org
Cc: chandrapratap3519@gmail.com, karthik.188@gmail.com, gitster@pobox.com, 
 peff@peff.net, Pablo Sabater <pabloosabaterr@gmail.com>
X-Mailer: b4 0.15.2

The loop reading the object-info response stops as soon as the reader
returns something other than PACKET_READ_NORMAL. A server that somehow
answers with fewer objects leaves the end of the result arrays empty.

The caller trusts that every requested object will be filled in.

die() if the loop doesn't reach the number of oids expected.

Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Mentored-by: Chandra Pratap <chandrapratap3519@gmail.com>
Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 fetch-object-info.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fetch-object-info.c b/fetch-object-info.c
index ba7e179c44..cdb7f936f9 100644
--- a/fetch-object-info.c
+++ b/fetch-object-info.c
@@ -49,6 +49,7 @@ int fetch_object_info(const enum protocol_version version, struct object_info_ar
 		      struct packet_reader *reader, struct object_info *object_info_data,
 		      const int stateless_rpc, const int fd_out)
 {
+	size_t i;
 	int size_index = -1;
 
 	switch (version) {
@@ -82,7 +83,7 @@ int fetch_object_info(const enum protocol_version version, struct object_info_ar
 		BUG("unknown protocol version");
 	}
 
-	for (size_t i = 0; i < args->object_info_options->nr; i++) {
+	for (i = 0; i < args->object_info_options->nr; i++) {
 		if (packet_reader_read(reader) != PACKET_READ_NORMAL) {
 			check_stateless_delimiter(stateless_rpc, reader,
 						  "stateless delimiter expected");
@@ -106,7 +107,7 @@ int fetch_object_info(const enum protocol_version version, struct object_info_ar
 		}
 	}
 
-	for (size_t i = 0;
+	for (i = 0;
 	     packet_reader_read(reader) == PACKET_READ_NORMAL &&
 	     i < args->oids->nr;
 	     i++) {
@@ -150,6 +151,11 @@ int fetch_object_info(const enum protocol_version version, struct object_info_ar
 
 		string_list_clear(&object_info_values, 0);
 	}
+
+	if (i != args->oids->nr)
+		die(_("object-info: expected %" PRIuMAX " objects, got %" PRIuMAX),
+		    (uintmax_t)args->oids->nr, (uintmax_t)i);
+
 	check_stateless_delimiter(stateless_rpc, reader, "stateless delimiter expected");
 
 	return 0;

-- 
2.54.0

