Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1956E21C9F6
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 22:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742423037; cv=none; b=Jxu4vG2q5V1IXqEw9J97p50ol2CWExzM9ktK/2oiIcuhhjvjH8euOaU6U0E+VmXs6ZAErEybeSBYqhwYQXHgWzwzvfZYSx9dCuMIhr3E2rfsT7fTc+EiSmrogTBUAZesw7K8Y3oMmg5ifxo6GdEauGfPBAEwtL2JHOnrvPcK9dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742423037; c=relaxed/simple;
	bh=9cMaNAi9xNqz3W5/h+etLsnvKiPXstReyenUu96jyFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=if5EMPfGams6Yzf8KE2qigYa2UJGxJyCA/IrN0NFL8DxheJPIjjl7Rygr9OhGBFTgmd7wv0x7wyyhDRCv2ss6Ri7jFptIKZMtaY7wv5ARviDCnuYXeNYxdSFuvJFbbeJhQOsYcqSw+sd0M25wqHMKFhjb17zPPuTkeLg755VVzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=XzUn6Dta; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="XzUn6Dta"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c592764e54so22448385a.3
        for <git@vger.kernel.org>; Wed, 19 Mar 2025 15:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1742423035; x=1743027835; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oMChefzvT+dAiKVUTKVLKNX5EwwIbKWACIw5xIVHqgw=;
        b=XzUn6Dtave6TWgQNv4NrL2lC17i3T1s3RtBqgQuLwleRbeOwNhkQcOyhYPCYQGhAE0
         2uMhLTm9KU6RKAZGidmEPi8ILBIXuXTLt4uKscgTfkiXRWk3bm0GV/Gc7RCMc+ylDaS4
         dg5r46CogG8cGz3VebiMel0BpPbFvsm2vxkgf+bqqBaUdyEH5r8/XLmroiSGrMikjrBz
         mBqwonKGDfqL/8OBwJB05BRlXNIO1bbHPjEhgwNze1gJQkwJmLprZxwPYc2VXIxEjOpu
         npyBj06Pi9UkxLAOEUR3ozqtV5q61w46LGuSaQ0g56/DTmxHm6b5lUzacy+dAcMEzSjJ
         5HIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742423035; x=1743027835;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oMChefzvT+dAiKVUTKVLKNX5EwwIbKWACIw5xIVHqgw=;
        b=wJiFwt3MXeonC+AzH3QZ7FpQHQug9cBBRmPKzakGNklfsSpEjbFuNKY+yElS8n4mgj
         i9YXLWGztsCU7e+Q9U9bdujEI2sHTtoUrTInV7p3PmQU/+ASfBZd/MHFKVc/0IvxQfgr
         /qbCaMe1wDpVF9DakN/iiQ6A4XGsgeLznIS+wPpdbJefkayjknmMBc35JwiDk7ATPIxm
         9xW+xIErZ0l+sn75aXwpyvD1VI/L7RrOvpbFLDtq4po+fqsMUZjYBa48Zcfzx2Kew6K0
         VnnRGZG9m/VVbWKVHHaLb71bgjFU3+TMN5MT9mC+GQKyr/rxjPgC+ovsy02VF1/yXofW
         K9Jg==
X-Gm-Message-State: AOJu0YwlqDxHrauU/URK4uijSISAckxtXBKgea7ND7efZhLIvPxL3rJo
	ndHHK1ROER+wpEuwIry4UushEt7l2NVtqEkVvSc7T6XvjKsd5aLkvN0WUgXqeDVREQuhtYJlGum
	KEGk=
X-Gm-Gg: ASbGncvUqgDusw2c+teBOQDI3ad3Myh1QestD6yrKvCZdxNzoqpuUSGxM5zp47g9ta3
	A/j6luyzenW/Fr2eti7aqu+gvdTxed3BKH5iwpc8yrOyImckz7as33Qbk7VO/lBayiBBKPCU93i
	6R1ti3AhoxGco2HsAkPQI0gl1Zm1l9p3ePeswhwBm96OatwrGinnnWuZBK9cwlqIFSrx2sg8sF9
	SD1vQN+vzYQlytRs4XSl9oo7KlA9mrp5fD2nMj7zE2WaB8XJcV+mIBsA5syZ7cLV+S7CB9pYs8G
	H0Orq7XkZ0O/vuscVhmS3ANG7zAZq/fi6Rykn+4GnX+XbrRG9gx49JZI1AzZlFeeNq1JLOQZLsT
	xIqmpAKTMoNbhEAuA
X-Google-Smtp-Source: AGHT+IHETo0YRi1o5bmRUoSM543DfnhJ1+Tbmwz8XNEXpxoRGxItmk3oN0xERONeOajF9efGseRdAg==
X-Received: by 2002:a05:620a:4404:b0:7c5:6678:ab27 with SMTP id af79cd13be357-7c5b0c86132mr138003785a.18.1742423034861;
        Wed, 19 Mar 2025 15:23:54 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c573c6fafcsm910456485a.25.2025.03.19.15.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 15:23:54 -0700 (PDT)
Date: Wed, 19 Mar 2025 18:23:53 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 3/4] http.c: inline `set_curl_keepalive()`
Message-ID: <cdfc9baa8da95505aa4ad61bab07be0b063d916b.1742423021.git.me@ttaylorr.com>
References: <cover.1742336481.git.me@ttaylorr.com>
 <cover.1742423021.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1742423021.git.me@ttaylorr.com>

At the end of `get_curl_handle()` we call `set_curl_keepalive()` to
enable TCP keepalive probes on our CURL handle. `set_curl_keepalive()`
dates back to 47ce115370 (http: use curl's tcp keepalive if available,
2013-10-14), which conditionally compiled different variants of
`set_curl_keepalive()` depending on what version of curl we were
compiled with[^1].

As of f7c094060c (git-curl-compat: remove check for curl 7.25.0,
2024-10-23), we no longer conditionally compile `set_curl_keepalive()`
since we no longer support pre-7.25.0 versions of curl. But the version
of that function that we kept is really just a thin wrapper around
setting the TCP_KEEPALIVE option, so there's no reason to keep it in its
own function.

Inline the definition of `set_curl_keepalive()` to within
`get_curl_handle()` so that the setup of our CURL handle is
self-contained.

[1]: The details are spelled out in 47ce115370, but the gist is curl
  7.25.0 and newer use CURLOPT_TCP_KEEPALIVE, older versions use
  CURLOPT_SOCKOPTFUNCTION with a custom callback, and older versions
  that predate even that option do nothing.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 http.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/http.c b/http.c
index 17b676a1d5..b4267bfdb0 100644
--- a/http.c
+++ b/http.c
@@ -704,10 +704,6 @@ static int has_proxy_cert_password(void)
 	return 1;
 }
 
-static void set_curl_keepalive(CURL *c)
-{
-	curl_easy_setopt(c, CURLOPT_TCP_KEEPALIVE, 1);
-}
 
 /* Return 1 if redactions have been made, 0 otherwise. */
 static int redact_sensitive_header(struct strbuf *header, size_t offset)
@@ -1242,7 +1238,7 @@ static CURL *get_curl_handle(void)
 	}
 	init_curl_proxy_auth(result);
 
-	set_curl_keepalive(result);
+	curl_easy_setopt(result, CURLOPT_TCP_KEEPALIVE, 1);
 
 	return result;
 }
-- 
2.49.0.4.ge59cf92f8d

