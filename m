Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F896F2E0
	for <git@vger.kernel.org>; Mon, 26 Aug 2024 17:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724693824; cv=none; b=qdd3ptCdAbGrg0SxH8C9X1wbHDj5XvDWAvH5tHG4l5U2vHK6qnEpbjQEQTcsfQzZotcG/AuN4jwyHCimpmDVoHZcL99LvO6aL8kNcO9+Zm1JpeNdmFD7+AFCUHuGLyLsM8CM14MLleL1AcV/3rsrBzVVsfn+uqYPaH7zJJXDK5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724693824; c=relaxed/simple;
	bh=8h9MWISrPv1xLx2d21iR/uoiIaBZ8gibYFp+lHpkhwE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ar7rVFpNP5uJHflT746u+kp8kaNEzMXW5ohJ/FPSqKX8hHNYitL21RsjQ71L1QbsRv4jOo61IjMbSLLjClW8BYFPsPqcAp4ZOenal04hq+KTRd3ygS7V3V4Il+M+2xiZxg8pL4eUNNk6ubv2ypfXlau13G9uXvE1l1WiUKtLbfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eT1WQ1es; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eT1WQ1es"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71446fefddfso2373345b3a.0
        for <git@vger.kernel.org>; Mon, 26 Aug 2024 10:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724693822; x=1725298622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yaaIo6wtKA3K7y6G2XafX08ftqx+tIp9vrmT70o43Mk=;
        b=eT1WQ1esBxeH5yxkYy4ElDadazJ8DlPFEPXXDbQuInpvrnli56VVqLc7/d/8pfKI6M
         FnTar0sA1EsJTBldCSJCIDfQqijUWwcLwBZvdjyz2YtA6sQPuceK7lwAkgmkLvLAKI9m
         x7rFu9x/ArKIaa/Tn/qtF0FhxT4rV6vWpdmdMhL0eQsCMQpnI+Adsyu29Nil/IxlwLlN
         79G9HCDM2z+w92PV3Sq9mm9WshDn61Er5lcbfDRLJv29dhS3Hgl1eKBlLNfl89B5YBN0
         /EhQ26kDg1lYTNplBzedNNn3kgUALq7HwfwK3ZfqYKyuo1nYWzWl8NjaAtqQyGFxS8FW
         d+1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724693822; x=1725298622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yaaIo6wtKA3K7y6G2XafX08ftqx+tIp9vrmT70o43Mk=;
        b=DfL2RmM/WuWK1VQ9InhAGnil2hld4B0VRd3k7gKzYVkf47N8fTnR8A549hoLQqll5q
         EjNbOWzZIQ9spqRpqY85FAdMeNShlA1pwdilpqBYtpvDkWhCmbqp1rDtEWspm9AzoZUX
         TIsGC5sjQ87WWJh30bYdf+4Y235UGYAvN5gStkzsKdjXAx2IcUe7HIuTVULx+IqcqXcx
         vndl2MMLYkot1CxqgaHol0+jaHvoCjR1xUHg8+0L/XuPlEmedb+QnJ8Bmp75b6AdoPeD
         hdnW/AQmWfScA/+jh+unyaMCL7l9Hod5GePV5sgLPxh3LrxRIA3TK0g7bbACtlPMI3OT
         g0Vg==
X-Gm-Message-State: AOJu0YzSEa/gsx0D62lkWPTuiRKKVbfYP4VxEUKDQq2WVxW2JhOElU0r
	pOn0bWqtYQD0hly6NRoMaPVGix8umTxQ3MNeUo6Ay+u5kidmybGB4Rov1RQG
X-Google-Smtp-Source: AGHT+IGYR/piLFRDnSIxGPxKX5/NHSOUDjvfGOL4WjBhfSCtHeG/Fg6niER83iLHdjvMG0xjkQaw3Q==
X-Received: by 2002:a05:6a20:9e49:b0:1c4:818c:2986 with SMTP id adf61e73a8af0-1cc89d6b580mr12690712637.13.1724693821640;
        Mon, 26 Aug 2024 10:37:01 -0700 (PDT)
Received: from Ubuntu.. ([106.216.108.198])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-7cd9acdd9casm7997999a12.53.2024.08.26.10.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 10:37:00 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>,
	Chandra Pratap <chandrapratap3519@gmail.com>
Subject: [GSoC][PATCH v3 0/6] t: port reftable/stack_test.c to the unit testing framework
Date: Mon, 26 Aug 2024 22:59:40 +0530
Message-ID: <20240826173627.4525-1-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240823120514.11070-1-chandrapratap3519@gmail.com>
References: <20240823120514.11070-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The reftable library comes with self tests, which are exercised
as part of the usual end-to-end tests and are designed to
observe the end-user visible effects of Git commands. What it
exercises, however, is a better match for the unit-testing
framework, merged at 8bf6fbd0 (Merge branch 'js/doc-unit-tests',
2023-12-09), which is designed to observe how low level
implementation details, at the level of sequences of individual
function calls, behave.

Hence, port reftable/stack_test.c to the unit testing framework and
improve upon the ported test. The first patch in the series moves
the test to the unit testing framework, and the rest of the patches
improve upon the ported test.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>

---
Changes in v2:
- Use 'size_t' as array index instead of 'int' in a test that is
  modified in patch 2.
- Fix a coding style violation in the newly introduced test in
  patch 6.

CI/PR: https://github.com/gitgitgadget/git/pull/1762

Chandra Pratap(6):
t: move reftable/stack_test.c to the unit testing framework
t: harmonize t-reftable-stack.c with coding guidelines
t-reftable-stack: use Git's tempfile API instead of mkstemp()
t-reftable-stack: use reftable_ref_record_equal() to compare ref records
t-reftable-stack: add test for non-default compaction factor
t-reftable-stack: add test for stack iterators

Makefile                                                 |   2 +-
reftable/reftable-tests.h                                |   1 -
t/helper/test-reftable.c                                 |   1 -
reftable/stack_test.c => t/unit-tests/t-reftable-stack.c | 611 +++++++++++++++++++--------------
4 files changed, 360 insertions(+), 255 deletions(-)

Range-diff against v2:
1:  e172ceefd7 ! 1:  838ccc63a7 t: harmonize t-reftable-stack.c with coding guidelines
    @@ t/unit-tests/t-reftable-stack.c: static void t_reftable_stack_compaction_concurr
      	/* break abstraction boundary to simulate unclean shutdown. */
     -	int i = 0;
     -	for (; i < st->readers_len; i++) {
    -+	for (int i = 0; i < st->readers_len; i++)
    ++	for (size_t i = 0; i < st->readers_len; i++)
      		reftable_reader_free(st->readers[i]);
     -	}
      	st->readers_len = 0;
2:  73b94aaa6a = 2:  2a151c299c t-reftable-stack: use Git's tempfile API instead of mkstemp()
3:  b6f0363656 = 3:  fb5073da2c t-reftable-stack: use reftable_ref_record_equal() to compare ref records
4:  35c09e6054 = 4:  028fa6f70b t-reftable-stack: add test for non-default compaction factor
5:  3163c2af7d ! 5:  fa0d358e65 t-reftable-stack: add test for stack iterators
    @@ t/unit-tests/t-reftable-stack.c: static void t_reftable_stack_add(void)
     +	}
     +
     +	for (i = 0; i < N; i++) {
    -+		err = reftable_stack_add(st, &write_test_ref, &refs[i]);
    ++		err = reftable_stack_add(st, write_test_ref, &refs[i]);
     +		check(!err);
     +	}
     +
    @@ t/unit-tests/t-reftable-stack.c: static void t_reftable_stack_add(void)
     +			.log = &logs[i],
     +			.update_index = reftable_stack_next_update_index(st),
     +		};
    -+		err = reftable_stack_add(st, &write_test_log, &arg);
    ++		err = reftable_stack_add(st, write_test_log, &arg);
     +		check(!err);
     +	}
     +
