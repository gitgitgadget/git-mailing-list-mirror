Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2967424CEF1
	for <git@vger.kernel.org>; Thu,  3 Apr 2025 14:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743691752; cv=none; b=oTTM1hO47YmU+s3gV1dtc8r3ISmq16Bi0N8Zp3ZDrI0huXuYaVIebYDlvrv7TQpTOBxf/6bfUG8tDYZbNn+HmFQ5rzwTyka2gTUI3oLn6vWJ+FsnY0a52uh1woq41Ija7sfzY/KWiQgkTkZ2biDFFNZwR+B2dKFWI+HBv7Jggn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743691752; c=relaxed/simple;
	bh=a70tQIwZWK96tWzo1wirn0fi6Ye4cIOTwo8HcKL7MJw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tXjymRUQUqO/7nWlDJQrq1yjNnqcQuqCS/6J/y5CRq2Ejwiir+gac0+w2jpgBmN/iptYixHPI7vFWdHRH0K84co2KD/DqG25s1YU4dAAu1iwpOnyDYY7LrZBK+5rvkulW6C/12naIMZQAG+WT9WAo8tcArUEqj/v7YsvKJsKTE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RLP+WqbD; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RLP+WqbD"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22435603572so10254865ad.1
        for <git@vger.kernel.org>; Thu, 03 Apr 2025 07:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743691750; x=1744296550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kit7q7fTtkQsAtYpgvkO2AF36F+UZJqAMpVcRF74Wnk=;
        b=RLP+WqbDwttmg6Y/h/QAdXmcMiRYltT7qK0Ryk3Gk5w+I8wWgvomZLQdUg/G8eEume
         T0aLb0aX19FCeT/WJWzwgeIigFa+gPTZauHpxLdjDwvGLCgP3+fJOy7t8j4AzeBfnmkM
         3axi7BzhkVMo+jKkTgMsewr/bAESJYvpS68R66PJdHOWB9LuZatZyCVxYAx0VDuP9FjL
         xBtu4rtJhk4lGLONPNAz24a4TPbFZ3Rb0NXM0HHCLwt2ItlFKoXKCcjC4pVWqDbxT9pB
         GdxGO5uA8nKAC8PYiwoZxxQwov5LgDWcxCd/R3GkbEBTRBpE2hQF+lTpPksdXMtYxJDM
         Mymw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743691750; x=1744296550;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kit7q7fTtkQsAtYpgvkO2AF36F+UZJqAMpVcRF74Wnk=;
        b=VYK2LTfXmOWSvuzKO4jRD2Qh5+NJLdT3rn1bCnLJC+Txwv+AgrDFcmqzkLGDDvkRZ9
         cGxTE+uHzi/0gwY5gl9kvIwz76sc5xvUxcJKbxSQ8iTpQ2KIum2EdT44qf6tMpCIEy/J
         FsAXZDzJcjRjCghPO32LOB0nRiaKk4xYlTFEZ48M7/jDPUUdNptrRd+Dsn9yWob3nPJM
         /HF1W3yuBm2Pw7AgrEwNdVIWrrO+El01Kf6sbKgxRTvLav4+JNCt3DVVrDEP5rKV1j2q
         jGTZrA/1E0NHiGlJvKh+B0MFL0qlRHiIGKJJeg6Gw9povOePhbtdT/PQczaE+ZdREXPl
         RwpA==
X-Gm-Message-State: AOJu0YxcEO5B+rPDZP4IUBjhNq5B6GnTOhc8Bp1oLI/5/icVgbcWgMLb
	np9XdfIZfK6nxwdvZkmTFWT5fKV/BpruWnDmXavtGNntk+LnsW19GZbHjgkQ
X-Gm-Gg: ASbGnctlgAoYQTr90qxCzuxuZ9Pc1OCm8IH1RZLPpOmDxQJp0snn9R1i0fnQ/1zWH1B
	2qxW21T0geUtkSiaFvSIx1yC5nCiGdZLPYDucSj3U5hzUNlMKd8FS6xwhY7N+NTZzEq7mTchccb
	5dT5EonM4xP8fjM/nn2+cLIHZQAuG1cL8ZMp5pdBN9ImQgwuPokVTqXeWQGXcjd1Eq9bjeGTaBW
	CQ8tgvBicn3bRAbMY2wTuGVoAT+ZK0YHi3juiHUsqH5i5EhxV2QPRoH80LibN6a+EK/SIpvf+B0
	uo2EiIfVK+ATo+BBa8Qpmw2JnXWsJmDSl0a9AKW+WVOEqlRKRiu/RxWBLmJHiVLW
X-Google-Smtp-Source: AGHT+IH9igXkc5UUtHmH7RH1/cfDQQ3wEdC+oiNgERR2gZfLkfGdq3zo1UKs2FJmcxEZ0H5ASYWzaw==
X-Received: by 2002:a17:902:d489:b0:224:256e:5e4e with SMTP id d9443c01a7336-2292f961168mr286107395ad.16.1743691749749;
        Thu, 03 Apr 2025 07:49:09 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c3b:a6b8:a69d:a970:fb6c:b0b6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2297866e902sm15305865ad.203.2025.04.03.07.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 07:49:09 -0700 (PDT)
From: Subhaditya Nath <sn03.general@gmail.com>
To: git@vger.kernel.org
Cc: Subhaditya Nath <sn03.general@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH] t7422: remove extraneous argument to printf
Date: Thu,  3 Apr 2025 20:18:52 +0530
Message-ID: <20250403144852.19153-1-sn03.general@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The POSIX man page of printf(1) mentions -
> If the format operand contains no conversion specifications and
> argument operands are present, the results are unspecified.

In practice, this means some printf implementations throw an error
when provided with extra operands, thereby causing the test to fail
erroneously. This commit fixes that issue.

Signed-off-by: Subhaditya Nath <sn03.general@gmail.com>
---
 t/t7422-submodule-output.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7422-submodule-output.sh b/t/t7422-submodule-output.sh
index 023a5cbdc4..1f291a1d49 100755
--- a/t/t7422-submodule-output.sh
+++ b/t/t7422-submodule-output.sh
@@ -180,7 +180,7 @@ test_expect_success !MINGW 'git submodule status --recursive propagates SIGPIPE'
 		COMMIT=$(git rev-parse HEAD) &&
 		for i in $(test_seq 2000)
 		do
-			printf "[submodule \"sm-$i\"]\npath = recursive-submodule-path-$i\n" "$i" ||
+			printf "[submodule \"sm-$i\"]\npath = recursive-submodule-path-$i\n" ||
 			return 1
 		done >gitmodules &&
 		BLOB=$(git hash-object -w --stdin <gitmodules) &&
-- 
2.48.1

