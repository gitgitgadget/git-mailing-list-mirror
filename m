Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326F115C9
	for <git@vger.kernel.org>; Fri, 21 Jun 2024 06:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718949722; cv=none; b=ISOJ1jK1Li17akRGaO1mnR9qexV87hgCUw480NsJoICkeRXcPOfHOGhv8jgqU9PZhOYAMyeFPY40Q+IMdi/3NjvunFnXcbkS7B96jcMhyT1hoiNv3OagQQeh5DBE1oVHxQh929S2ZqsIooQBdv0XPvNcHLBAupDZ2WSiIwJrO8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718949722; c=relaxed/simple;
	bh=FRRFj+biU0FDOK+auhVxu+qM+L6LLHanlMuLypicIzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lvErt2LdhTEoXkFkozKHh/kl1MVSDYY0nyUfW1dVbAQSqOhTA/5lNG0pqPXuaWfahQfujUvsaYL/IGBAfGBY3vqhcSmg2d0Ai0wivuXWwV0+907ZBnCzapsUMJezbUxMFEzdDhqBKSX54pqoZsmXjVa8uL96nl9zS7j6xq42C98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=djBxKZOr; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="djBxKZOr"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2c19e6dc3dcso1383124a91.3
        for <git@vger.kernel.org>; Thu, 20 Jun 2024 23:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718949720; x=1719554520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/AxcpOZ1IWgBzmtpyTfGuJbUrRf2xTtgEm5r8QrHWPc=;
        b=djBxKZOrvV0NOLyum6+W5NMPbkymoTUNaNcyPOceKKdF93oMTGGVd1QTGEDdUEbY49
         9ew3eXN48wxDWoFFhqZ0JMgByYUJoN7xbfYe8X7d6EAiA+ajV3jUcbMUN1Z2ZMKWcs6x
         hJUpVj3ihqYimV4dQ0um7Cys/sGOzTF9DWzOPj3iZ14wTkHJXPFotv6Qi1UCWTY8Ge3d
         +deho9DIYIh2SqdAPNBbK3kur+JuLnbAUV12hTj7Leh/kiURGgU1b2Pv2Fa07x9PgxC9
         Tpq7oi7THIVnTrZ47CkRgD27pRojVlBLGLxjqSN5zuz+c17q4M0Ivjf2gsUQ3qvRfWzh
         1IWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718949720; x=1719554520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/AxcpOZ1IWgBzmtpyTfGuJbUrRf2xTtgEm5r8QrHWPc=;
        b=Ih1TFAjqxrRI7zhS2BChKOA5mmXRYihSuStWUvvK2NyifhUD1f9id6eYaHYh6YKtVI
         btvEzOsLkU0Buddx7Fh4OhoCvk07Ro+2ekgHGmHXFpcnx0psRwJSxGnFdYt4+G8qihfD
         Cxx+jVmQ/GvqEOrRJwq8vPfPf5kPiQIu6kT8n2eO+iotM5Flx3ZJgl+tzCwcLW+ZvXsX
         ZlbSO1e6diGeQ9mYw9yhX9RU/uUOB2hhKBNsbSN7102ETb9j9UpiK91blBz6Dq4eY4kC
         PwFXcLQHKQ40XtdCcspM+ssK27DaTe2Py+ZkmEhBYA8h+WtSEZRhXf79NFzodqekGDjY
         h/UQ==
X-Gm-Message-State: AOJu0YwcRDZiDYpU98JgXBjKY8O3NJSUvrrShz0TFp0jLXhMtDd13XvJ
	jJfkcOUCRZevgxUjDj9g4RNFByvRWT+x4loD7cSc82GKcQorlbO7EoOsUw==
X-Google-Smtp-Source: AGHT+IFnwSA5y1AqclWyYbvN7+UWbcAyjUPON7W8UYp0a6CBkjsVhx+S3xlC3DfXA4/NHx5TdBUYDw==
X-Received: by 2002:a17:90a:f2c2:b0:2c7:cc35:2819 with SMTP id 98e67ed59e1d1-2c7cc354740mr5368517a91.3.1718949719874;
        Thu, 20 Jun 2024 23:01:59 -0700 (PDT)
Received: from Ubuntu.. ([106.206.192.103])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2c81fe88e0fsm498661a91.3.2024.06.20.23.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 23:01:58 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: karthik188@gmail.com,
	Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 07/11] t-reftable-record: add reftable_record_is_deletion() test for log records
Date: Fri, 21 Jun 2024 11:17:06 +0530
Message-ID: <20240621060018.12795-8-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.2.404.g9eaef5822c
In-Reply-To: <20240621060018.12795-1-chandrapratap3519@gmail.com>
References: <20240621060018.12795-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

reftable_log_record_is_deletion() is a function defined in
reftable/record.{c, h} which determines whether a log record is of
type deletion or not. In the current testing setup for log records,
this function is left untested. Add tests for the same.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-record.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/t/unit-tests/t-reftable-record.c b/t/unit-tests/t-reftable-record.c
index fe12fd2201..70c1db6756 100644
--- a/t/unit-tests/t-reftable-record.c
+++ b/t/unit-tests/t-reftable-record.c
@@ -225,6 +225,10 @@ static void test_reftable_log_record_roundtrip(void)
 	set_hash(in[2].value.update.new_hash, 3);
 	set_hash(in[2].value.update.old_hash, 4);
 
+	check(!reftable_log_record_is_deletion(&in[0]));
+	check(reftable_log_record_is_deletion(&in[1]));
+	check(!reftable_log_record_is_deletion(&in[2]));
+
 	for (size_t i = 0; i < ARRAY_SIZE(in); i++) {
 		struct reftable_record rec = { .type = BLOCK_TYPE_LOG };
 		struct strbuf key = STRBUF_INIT;
-- 
2.45.2.404.g9eaef5822c

