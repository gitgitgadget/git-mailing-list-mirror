Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E6115C9
	for <git@vger.kernel.org>; Fri, 21 Jun 2024 06:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718949728; cv=none; b=cmvFEKuw4GxKTq/FQSR68RGW6e5mAVbUYWGYzt79Cwr2GYtAgiePljE2dZSZhGZ611gHRGxEmVi2j3rZPRHhiZGr7B/lGtm4LtufrLtXaoTP0zloENxkyYvpHiSSEkS8JF7Ezjl06rRd61DZQUXOn4bqSRSVSx1ocggpdm2ynkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718949728; c=relaxed/simple;
	bh=FlVAF9wt6M2pcZ9JcK7QQIvYNS9bJva230ndr0eUrm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fAf10BzHH3KzTuo0xUnRvNmizEsK+cVqZWfpPkKg0eH1kgR8OY6C5L17AbG129tdebpFU+po5uD79F3/4UxK2rrYS5GNoGgUyBvqSJN05Nrydy+L0ylrKpy8deb5o46QpNqaJneaP4SiMifketvPjzJ4CiSt6MEfdWE5PXOd/fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P4nmrFnR; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4nmrFnR"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7178ba1c24bso48200a12.3
        for <git@vger.kernel.org>; Thu, 20 Jun 2024 23:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718949726; x=1719554526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yuHVr3Ex8G49YCTFbAxnZfbis7iTgVCdTmCA1jys/DI=;
        b=P4nmrFnRuriGFIjWWzUMo8HwEj3PvAdeaiGU1RoquvTGjEinFbGqrP8tuYcj3uveXZ
         GhSFy2a4xhsnKa+SvLNaJKY605q3XBDy8tz5GxeR6FBrF6/+Q7FpmOxWnwMljzLsvZoh
         pk+O0SXbNqPZnCNII7sfE5+sPccr2zK1NslSyZ8Fif6SUxCwlQashgo/3ZJ7ll+RZiAL
         9T4i0bguVa00szvpCdu5oN01iZVMZ7A3a8/dN0y/lfqRISHDqZFGZb3Adqfz3/+B8sMo
         SNQzqYnAL2Ywf9QkA+Ns0UqObpmwWFxFuqBYQhYNHWWE7vB8AUV9wsRFUlNB+WHkd3l1
         D/uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718949726; x=1719554526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yuHVr3Ex8G49YCTFbAxnZfbis7iTgVCdTmCA1jys/DI=;
        b=ilbzoPRDWl9AvOttTyQRqTCadj+XTNaMkm/F9xBsxBBMoQqRr7/SZIJ1YX0KHbjDJx
         8nFnqqg9OdDzE6EBr15FAPWTK1W8QwGWye2Gf3wQATkUrP2YjpeQ32D+DAC81rawBah5
         j0Y19reHvS9BG5Dmo4s99fTMq0BDAotEjhaaxfybwC4nJWOYyV+yaWjilPlOOtp9iMzs
         7KQj4BiW4g25jL5MuL7r/HoP7jru/JqxQepMHiQonA0ehwbgN5R5enncT8r0VKdthQOS
         O29JC7aXBPxytBOIO52Leo003z9AYRv2mybR0mlPiF1grRnKPVMfX2EE7YBkvSBGQmUz
         sOxg==
X-Gm-Message-State: AOJu0YwnhiRkrrcX9ZRHHHK4pzqiOSssAFjgbGt6SdGwrLRuU3en+zAO
	DrxlQMk9ZQpqbNqnkxxW4fFqeYuVp6zaDqf5tAQMGtckXy/QWPckodQiOQ==
X-Google-Smtp-Source: AGHT+IEKodGXO2T9mLhZQOtjEKMqGfzsP5WYarVVUJyw0CJV7rbgD3DU1OJEl6A4aqbflwDAx0/BwQ==
X-Received: by 2002:a17:90a:bd8e:b0:2c8:3f5:37d2 with SMTP id 98e67ed59e1d1-2c803f53898mr3209514a91.20.1718949726464;
        Thu, 20 Jun 2024 23:02:06 -0700 (PDT)
Received: from Ubuntu.. ([106.206.192.103])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2c81fe88e0fsm498661a91.3.2024.06.20.23.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 23:02:06 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: karthik188@gmail.com,
	Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 09/11] t-reftable-record: add reftable_record_is_deletion() test for index records
Date: Fri, 21 Jun 2024 11:17:08 +0530
Message-ID: <20240621060018.12795-10-chandrapratap3519@gmail.com>
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

reftable_record_is_deletion() is a function defined in
reftable/record.{c, h} which determines whether a record is of
type deletion or not. Since index records can never be of type deletion,
this function must always return 0 when called on an index record.
In the current testing setup for index records, this functionality is
left untested. Add a test for the same.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-record.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/unit-tests/t-reftable-record.c b/t/unit-tests/t-reftable-record.c
index 204a673260..bb2986eef6 100644
--- a/t/unit-tests/t-reftable-record.c
+++ b/t/unit-tests/t-reftable-record.c
@@ -471,6 +471,7 @@ static void test_reftable_index_record_roundtrip(void)
 	reftable_record_key(&in, &key);
 	test_copy(&in);
 
+	check(!reftable_record_is_deletion(&in));
 	check(!strbuf_cmp(&key, &in.u.idx.last_key));
 	n = reftable_record_encode(&in, dest, GIT_SHA1_RAWSZ);
 	check_int(n, >, 0);
-- 
2.45.2.404.g9eaef5822c

