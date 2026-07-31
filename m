Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4264E36E466
	for <git@vger.kernel.org>; Fri, 31 Jul 2026 19:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785527403; cv=none; b=eqqXUMDNwh/dz4799FZkX+0mipYHRsgj5232kUhcv2dqWaor/6ftH3hj4e3QLEzRFO2Om5E+Ieinz/4+vBIx64onJgnRLpVMCJT6jp/4OkJRdf6KPa37PrNeG1BN0Opwq/IR3ImqPo7ex0HCULp8PeRZiMqgpmIcbUVEdL1c1Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785527403; c=relaxed/simple;
	bh=Ih3wMIAdP2qMVjRxyAEKTFKzaPxEk1/NUBh9TAiVKQI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K+VH090ODTYrj3BhmfS4cKC+YqcbKtXnJE3KsrTRN3gWJusdoAmEdqdPZ7fIE5mVX73HWW4t0mWxWRNKHtJmARglNanwoq6eAqm0hYtXvr0Y6V0mvHyZ1LNgGE8Z3LZHUWO0jkAeHf06uzaHp9x/P6ijH4Shvh0c6eNRFp24TYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UFcweEFF; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UFcweEFF"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47f81a3ccf9so1328830f8f.0
        for <git@vger.kernel.org>; Fri, 31 Jul 2026 12:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785527400; x=1786132200; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nYLLT135IU4BX0l17KZYGHK9IvX1tnHPBKH/oJz0D5E=;
        b=UFcweEFFjY8nNnlRNeJL7t5CMgTcn1xQZZJueyW0XutlZ4JYjmbFNe135QWVJ0h6iS
         +3XowYhKeqaNCrS8cncN5WvH43lfs43sYM9IlrB2U5hUOXomQwP1dRDwrnjzYhYXuZ4d
         MkWWXx17LRku6q+glSLQE7lwClvAup13D+BqafFpOAgIebLTDBI5EyurznX7ERT9jpD0
         +WuqLA8ji3v7R2xZvrmUe5IjOUnjcmAqSHj632efZprkpoyoIPSdDbk/W608gIM+VzfL
         H+c5msRp2YNEAsJNh+KeFnEZ0asxcgv6HtLLYgtSf2qscHk9i8Z5DijbZgMU+4AXx2z+
         M6mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785527400; x=1786132200;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nYLLT135IU4BX0l17KZYGHK9IvX1tnHPBKH/oJz0D5E=;
        b=NqCKTsYCc/HW6UooZfr6gTseI5tjZ5gx9hSs4YlpSoYCnwnC4zTdz36KaDnV7YXJ1N
         85hD3zhYpOGUwsNhCaRk6uaoSiXYcgX6zj+EWbUql/o3k/YrGO+RdGF7cG2TGTZimixs
         JlezVUZWzOk17JfBVZZVZF42gcR89/SDT6EZR81I9wee1kwEYfTdzgvVdYqZGpA+eiVf
         xllkGgdovq0JeicZT6Gl7XqGDn/L+yaslA4v+nSElQiZt6/PytasXdE5j6hwXZs37i0y
         yEdL6Q/78tb6Qy/xVCrjWJ3dRWy/TZg3b+xN26ZcNN52muy3PTwaCBllsXA7Zee0vVIK
         j7Ug==
X-Gm-Message-State: AOJu0YymsRgqUfNezxErTczuy5ODUPbidHBWVK2U6EnAjnjkDtEZizcQ
	bTSBFx0kRIC1F5Zk52szYrWqENOePmzwYASriXpNQSq0PfamAfSH1LyOykw/gfNp
X-Gm-Gg: AR+sD10/G8Bb58b3iFltUVPPavhA1KVKrH0BHbBoMop8Kga4o4jve/1Ud6loZ3CVPBJ
	oRLgL/eLvpuO/wuEI3I0R+5QplXZPxtzGvxKg/rbgmxxmbJ97Cy+oWTZda1WJtosQKrUGLHcUdT
	uTsVDjD9WjPe8lCVSD0A90iCrEE6DV02cUfBLgNaxqkak54KbZRck+DdB1+9IB8k+WryFeL7eJ2
	TmH5snO+oUh/TYG6gD5tV4ergySf5Z+dkoXMUxCg9xuGF3bSZpy09nHs24wMvxe0/1T+K8Fpxde
	dv136pLOMcJZ2mimzPVPxtQgP6FSa3QoU3VU3N/AewM4R1drDZdPRZxm4f28Qb41I+qZ898wj60
	r8NIhmyKM9l9yxYSqUdhujPEY5fE71PnjAH3XS21S9E481X4Za/H6Oc5tvWbPZBiQI4SZh2ar9M
	pajgIkj2nTyaVjIit9adzLCZ1Sd+kE3nBu15jitamHHTqx/8mL4ra03TkOs4dl1K5dAwUDUYSbe
	tUMnvQpexzMa/XLxfWf5EUAHhfgoZK28ZoBML/9UurbRO0UcA9Bia4Uk5kdvusa6tcYL0OtbuGq
	J05LmBu2T/8SGfJQ1tNsgM4nRI7KQ5SsB1vlYtG52q3Z7T3IAaQQNxsqg7ZmzzrMqeSxLb33Hrb
	pY4EelmwQqfECWlLH3K3FYYvVxcUj8mh4Zamxzi26j4ogLLi8p9y16jEFHX/G4T7CPsjNJKhE1+
	GkyN8coXU=
X-Received: by 2002:a05:6000:1cc4:b0:47d:ee9d:90c8 with SMTP id ffacd0b85a97d-47fd72bbc55mr1583314f8f.3.1785527400436;
        Fri, 31 Jul 2026 12:50:00 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([47.58.8.78])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd41e2cf1sm8248568f8f.10.2026.07.31.12.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 12:49:59 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Fri, 31 Jul 2026 21:49:37 +0200
Subject: [PATCH GSoC v2 4/6] fetch-object-info: parse type from server
 response
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-objecttype-support-v2-4-af577461ed57@gmail.com>
References: <20260731-objecttype-support-v2-0-af577461ed57@gmail.com>
In-Reply-To: <20260731-objecttype-support-v2-0-af577461ed57@gmail.com>
To: git@vger.kernel.org
Cc: chandrapratap3519@gmail.com, karthik.188@gmail.com, gitster@pobox.com, 
 Pablo Sabater <pabloosabaterr@gmail.com>
X-Mailer: b4 0.15.2

The server can handle type requests but does not advertise the
capability yet. Prepare the client to know how to parse the server
response once the server advertises the capability.

Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Mentored-by: Chandra Pratap <chandrapratap3519@gmail.com>
Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 fetch-object-info.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fetch-object-info.c b/fetch-object-info.c
index ec8a80b3be..0f6d063164 100644
--- a/fetch-object-info.c
+++ b/fetch-object-info.c
@@ -53,6 +53,7 @@ int fetch_object_info(const enum protocol_version version, struct object_info_ar
 		      const int stateless_rpc, const int fd_out)
 {
 	int size_index = -1;
+	int type_index = -1;
 
 	switch (version) {
 	case protocol_v2:
@@ -104,8 +105,13 @@ int fetch_object_info(const enum protocol_version version, struct object_info_ar
 			for (size_t j = 0; j < args->oids->nr; j++)
 				object_info_data[j].sizep =
 					xcalloc(1, sizeof(*object_info_data[j].sizep));
+		} else if (!strcmp(reader->line, "type")) {
+			type_index = (int)i;
+			for (size_t j = 0; j < args->oids->nr; j++)
+				object_info_data[j].typep =
+					xcalloc(1, sizeof(*object_info_data[j].typep));
 		} else {
-			BUG("only size is supported");
+			BUG("unexpected object-info option: %s", reader->line);
 		}
 	}
 
@@ -151,6 +157,10 @@ int fetch_object_info(const enum protocol_version version, struct object_info_ar
 			    object_info_values.items[0].string,
 			    object_info_values.items[size_index + 1].string);
 
+		if (type_index >= 0)
+			*object_info_data[i].typep =
+				type_from_string(object_info_values.items[type_index + 1].string);
+
 		string_list_clear(&object_info_values, 0);
 	}
 	check_stateless_delimiter(stateless_rpc, reader, "stateless delimiter expected");

-- 
2.54.0

