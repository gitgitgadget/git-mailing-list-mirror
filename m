Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DBC1C5F13
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 20:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744661180; cv=none; b=SuUD7jl56IZujw80O8GRBbsCwK9Skk9GUQXRyVskP7GfdBW7WcANf6RWzxvYjjkiIKA/o5qOqOuoBjZNCSriyXPxGt6djGkCc+gfgrnQgSowMD+LGgaCxhC4LmC051pYFPvPoNRRBXheVjUpxh+4wMAx51X+FXC/U6HwUbqVBsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744661180; c=relaxed/simple;
	bh=EsbfW6bF8bKVJyNqtMWenIQWvbO/IgUQmHErF7rYQm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mrh+Dhlzuck4m1VZJpUK9+xjPenClo1u0GJeGeKNVOz+3/jXlPiXz4UEw427kk/A6sdyp3jBBPXsKI/Yud6I/taCUaN+OqPWsvNReLea7PocDa+upBSUxrKf65xpYzsD0FhBADsHSXk0undEkBtNA2fD7X89u7YT4VUtbUgLauc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=fbGzSYi2; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="fbGzSYi2"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6ecf99dd567so60938456d6.0
        for <git@vger.kernel.org>; Mon, 14 Apr 2025 13:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1744661176; x=1745265976; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4mJvIYz45yrrxpMxyq7/GyS3Oz2jGCrOHmdpQBA7TQE=;
        b=fbGzSYi2pbcx7fELpPakYd7TyUEvF7d26MAyPaHG3bJ4mfVynkii0Ze2+HmBABQq3D
         FNX3VdSVAkgul7Njy0cnTyDLOO1K49glcH3nPEOq6uJiMDtVPKyed3QirHdolBxFMgtL
         iiOmGJf/jfKq94KN61D5d/HFj57tCpcat4E/iHMm5hqIfOlvCg+zxVFs9rtl0g+nhoUI
         yBbnPvFC/IHztKfDJeSKlKXBEG1T3Lf9enHRNdty8WNsQca80tt6YwQcOSysWVBVdoQ+
         noKnrY1psmUjo67qjzQ4l7MYGWTpP9fxb4p53JKRsq1toJo5sxh+F4QWosLZxjBkCXYu
         eshw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744661176; x=1745265976;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4mJvIYz45yrrxpMxyq7/GyS3Oz2jGCrOHmdpQBA7TQE=;
        b=AYQJkTr6Ra/3HGBanr4pkT/hpffKQKQKSZUN3oLLfU+UefVksct2qQHfhV/t334xVK
         uksq0+OIMD2/aGrjy5o95iXLWrqjenGpPpZ6rdaJeHSdMQvwx6sQV4PQqKv14i1lCYED
         w4xy/tF9mnZnnW4F90asOjLut1fvphhf4dy33AbeY0SB9xO/wTo8M7y+Gag6BRVJNpau
         pagSvS0SXEy62uoOy2CtYJdQOTCmVfMQdxftj0GIFddpd6ILPWGwr+tCAQxm3eoY+Ojg
         2fYCwl6A6DSBHEfSXrkqrA2Q0hcFJxfwWRVmQHJbzJ1BKu2zVCZAxcZguyww9wEiDZyH
         +2FA==
X-Gm-Message-State: AOJu0YwG3eY0gr//rHtJEBiI1kcM7SK46tNSnDmtEsYQoNMP2zJ2ADs1
	4qLHvSryxRviFH1ngypvwkNXrCoDlAGA8pcp7cbHxyjx+9HFXSpsTZoQfit2pgOklS6xicToVrj
	e/qU=
X-Gm-Gg: ASbGncu8bn4VkAO5RLvwuxnLAUwaNbLalVv8lr7fpoIs3W3kPmbBXLY5Np9CjTXm1gm
	8NloM38kBcQjGzaiKofVgjs2RzFiqBICDgONHAtXJ9kYWU4LuTEl1srreRfkwEYJqXvMRU83yAo
	FeXsZl/M8TKHl56XMBrcGHr47CgC4mhGBVbgUabjbJqR0vKwW++ARA7bd0AVw6s5RdC4cAwyXCT
	qvcy2MZhtYfSIWpZchHSCpUGDumI7wOFkw27la6LWAdIEPZq+SY9MvoS1auu/wBzRfIdz3lR5AG
	K2m1rScCs0T876p45xOhBmDzvtS5JMz2Ky9AVCgfwN7Oao8tZRgR6duTDcKcBVAeQzJjvrmyRfO
	46kBVI9LAaK7K
X-Google-Smtp-Source: AGHT+IHDad40pBZKIF1WihWqD/SSdp40aa+pUbT23CFU62kWK/bMJ8kdYuoir2IFa97QDLCTto71bw==
X-Received: by 2002:a05:6214:486:b0:6e6:698f:cb00 with SMTP id 6a1803df08f44-6f23f1772d2mr224882026d6.42.1744661176167;
        Mon, 14 Apr 2025 13:06:16 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f0de9730d5sm87513986d6.38.2025.04.14.13.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 13:06:15 -0700 (PDT)
Date: Mon, 14 Apr 2025 16:06:14 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/8] object-store-ll.h: add note about designated
 initializers
Message-ID: <920c91eb1e5a1b6d5faa54240dd9c85f72968edc.1744661167.git.me@ttaylorr.com>
References: <cover.1744413969.git.me@ttaylorr.com>
 <cover.1744661167.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1744661167.git.me@ttaylorr.com>

The following commit will use a designated initializer to initialize a
'struct object_info'. This obviously depends on having the rest of the
fields having a default value of zero, since unspecified fields in a
designated initializer are zero'd out.

Before writing that designated initializer, I wondered if there were
other spots that also use designated initializers to set up object_info
structs, and there are a handful.

To prevent potential breakage against future object_info changes that
would introduce/change a field to have a non-zero default value, note
this dependency in a comment near the OBJECT_INFO_INIT macro.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 object-store-ll.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/object-store-ll.h b/object-store-ll.h
index cd3bd5bd99..7ff180d7f2 100644
--- a/object-store-ll.h
+++ b/object-store-ll.h
@@ -337,6 +337,14 @@ struct object_info {
 /*
  * Initializer for a "struct object_info" that wants no items. You may
  * also memset() the memory to all-zeroes.
+ *
+ * NOTE: callers expect the initial value of an object_info struct to
+ * be zero'd out. Designated initializers like
+ *
+ *     struct object_info oi = { .sizep = &sz };
+ *
+ * depend on this behavior, so consider strongly before adding new
+ * fields that have a non-zero default value.
  */
 #define OBJECT_INFO_INIT { 0 }
 
-- 
2.49.0.229.gc267761125.dirty

