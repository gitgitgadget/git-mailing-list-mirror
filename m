Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8724E23AB8D
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 19:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771875741; cv=none; b=K70azfLRjHq8uhX20H2oX7zF4aFAfzDJLQI8lQ4w2XihWrNfCy3Hj/pJ+yCJtAQXGz3Nv9wrBxOpWfP9eX0AOQW+NvpBrt6ep3Y0rHD68SdtzRrt0VMPkv/AhxPXgnsKV525/sqXIjgZGOGhhL1RyB3X9Xek/lJ6vQ/XxAAMDOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771875741; c=relaxed/simple;
	bh=Isc5B4uifJbYgasJ+YvKghm8vomBZqYlB5DBhz2+llU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K7nFK4n1vUQpqgatd2V6EyvRMKgIdRanR96jlsI4G8H3Gw8ZOSG7BSndNaPq6D8v0zDzpRJJj9yN2NfeSXrjfuVDi8f7kbM50fpx1lNRn2HecCCOBmwXb16j4EJui+HMi2AdxTvCS3cNpTN0ALUkxkYZXiyxXonbNyCo14OLf9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WnPFHdfE; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WnPFHdfE"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-409470ad5bbso1608197fac.0
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 11:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771875739; x=1772480539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ACX8HdoIFzWWKh6LWqL/zxgqab+sjDfpULQ5s2W16Xc=;
        b=WnPFHdfEvw6IJI2+rvADbUFQDYrNclUI1ln4qVcviylCubWmvhyUm8s1R38zis3yzV
         4QjjY4lKouU8pX3owkk7tORusZmBKcrTy6+QtwxHCA25vYxgaEzvbLtm1lyRSv/cCJKF
         PHQYoEr7X81H1kwAlQ+CUFimmQeDmGVUlD4PuQCIsvrmQ72rGfEMqxkiN1TiRsNCMGs7
         GaFWVnM+QdaHR/NAPc90SGeIvkVdBCU6bMjrMJj+a0XOPqHuL5WGjo0yWMNb/MtNciP/
         KwXiDjIdSfaE81OaEHLEHho8SkhyveQCcxcLK0ihKeSo20YBrhJ4+sj1HqmWC0i5Nyqk
         8rtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771875739; x=1772480539;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ACX8HdoIFzWWKh6LWqL/zxgqab+sjDfpULQ5s2W16Xc=;
        b=IsYw3TZv8KcwG3htgvyzZczwUCO5DSnX62Y+SfRw/nPR0qSdDbJpCOCoDiDv0szDWf
         QCbPD7Yv5Cq0xfSycww/g2a7FGHw2bM8SorEk0xl2u3NotiqvTz6NEFpmIyJhCSUf2Oh
         Zzqb2DHlNwxTC66JNIb3+bYJGohhYQ0+0yCABEUj9zj7DipjeqmwtGkPdfzvFh1bxCdB
         MOwXQadWkPOzBMaCtRjsiPjIh9bNeR5OxxNeeufTA/uR6U35RKjWN3qQ5APYnD0xMsze
         6MRVflw453jvyPAAi23YMljqG2JafdEpYmD+5TBPZg7DLIXlkK3oJmtU2VWpDFKF2t6P
         YHzQ==
X-Gm-Message-State: AOJu0YxJp4JVumU8+pLe7xlI3u5Es6i1A65mHlPMGiKITLmeGcBPtOBu
	0ZoqCLDHcuxjOdMzmHo2EoLSQIXGRdKARihiClOA9dVz2tjGioo3Xm4+bRLarQ==
X-Gm-Gg: AZuq6aKHW8Va9K1TBb6WPIpUqdo9oJ5UX43bWaRH9DXEGn/4RsZ5kyT1EBAnfl1KGoy
	6MNtV4dfu3DlBtDggMxpk5feZzPk6SNuSrwpx4WKk3EoPdOWEkzomMbdSoV2hjqGgdYpHadkjPY
	TE3jLlbR9lLuAPrlVG9Vdc0NKtFnpCfnibX89s89AFI8r/AjI4p3ad34QPHDTJmNOauhVydqAU9
	Erboyycz3HQMkEsbI58Y5g5ZWX02MxF1AEaTIJq1ZQoTBjWBJNgpGeNzh+p++KjplOwEsMDCtkT
	IW2Mm+ShRC4/XB7xWFhh6TNIH+/AqAAh+8Afn0Mg+GXjit/EImv7lfGPWY6KtBZoKGCHRdsjybt
	wVnjZgTTFs1yp1cc4cscwuJb0/JOH55VsmiuB4ebl6W9DyW8mVJXnrkGRCwbnQZ+nHzaMCYtl+d
	QCScIUMceRrVkZLLxHPA4CJm8/N7p/HQM=
X-Received: by 2002:a05:6871:5212:b0:40a:5d4b:896a with SMTP id 586e51a60fabf-4157b0ad3a8mr4796953fac.28.1771875738721;
        Mon, 23 Feb 2026 11:42:18 -0800 (PST)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4157d3a9121sm8051179fac.19.2026.02.23.11.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 11:42:18 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: sandals@crustytoothpaste.net,
	christian.couder@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 0/2] fast-import: add mode to re-sign invalid commit signatures
Date: Mon, 23 Feb 2026 13:41:44 -0600
Message-ID: <20260223194146.3476768-1-jltobler@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings,

With c20f112e51 (fast-import: add 'strip-if-invalid' mode to
--signed-commits=<mode>, 2025-11-17), it became possible to remove
invalid signatures from commits via git-fast-import(1) while maintaining
valid commits. Building upon this functionality, a user may want to
re-sign these invalid commit signatures. This series introduces the
`re-sign-if-invalid` mode to do so accordingly.

The newly added mode in this series currently ignores
`extensions.compatObjectFormat` when generating the new signatures. From
my understanding, to generate the compatability structure would also
require us to reconstruct the compatability object for the object being
signed. I think this would be possible to do, but would require getting
the mapped OIDs for the commit parents and tree. I'm not competely sure
of a good way to go about this yet though. I'm also not completely
certain if this is something that should be adressed as part of this
series, or could be done later down the road. So for now I've opted to
delay its implementation. I'm open going down the other route if that is
preferred though.

The first commit is a simple cleanup for something I noticed while
reading though commit signing code. The second commit actually
introduces the new `--signed-commits` mode.

Thanks,
-Justin

Justin Tobler (2):
  commit: remove unused forward declaration
  fast-import: add mode to re-sign invalid commit signatures

 Documentation/git-fast-import.adoc |   3 +
 builtin/fast-export.c              |   6 ++
 builtin/fast-import.c              |  43 +++++++--
 commit.h                           |   2 -
 gpg-interface.c                    |   2 +
 gpg-interface.h                    |   1 +
 t/t9305-fast-import-signatures.sh  | 142 +++++++++++++++--------------
 7 files changed, 125 insertions(+), 74 deletions(-)


base-commit: 7c02d39fc2ed2702223c7674f73150d9a7e61ba4
-- 
2.53.0

