Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0011581F2
	for <git@vger.kernel.org>; Fri,  3 May 2024 17:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714756998; cv=none; b=TI22uiGMaIgAAtWY8nfgjF1+kSBqn+ToeKtjNdXkipzOI7ot8RU7Cs8wFCrWSxBgZxoQ7gLpIzcoZbERoBIkVOj9hKM8JgB5Oi6pW6UJnQfKJEB0JF/PvkRdGNIswc4Jt9NkJE9arzD6Tpk4ihsvcFlKxNLTegTkvujh7oX+BRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714756998; c=relaxed/simple;
	bh=kPWZWHrWJeIfy/w4RFmod9jplc/tZ+Emui/avpXenSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H4JxnJ7bdAoTM3hTOc7N1ayA79HbTyhRm1RGpF9cFll2xp2lBaulVTbgjt1S+LINrxJahSd6qU6HgrOox3GdHB7T7wLUb1Y8ZOaFIIFYnOlCahQ1FUBfD62QDaj0pM6pwDsLoBvpM8Sz5dfXgOPOmgd+7MDb2WSexeHeXz9VXLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lvzwqnkZ; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lvzwqnkZ"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6ee4dcc4567so3136402a34.3
        for <git@vger.kernel.org>; Fri, 03 May 2024 10:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714756995; x=1715361795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gDQ9+UkM02IRkgzYyXz6zpT1AsYfEg3PAFp5x/fCFqQ=;
        b=lvzwqnkZ83MSC4XQzUtq0Rxcj3kUlB2yMgrJ0wt01BK1gEtgg179Q5OKuNYB3D+iEX
         7wPJtAWefUcnmPW8vmXqEd/C/c/QFJviI9oXtvUL+VPkG5HyoDBXZ0aDYodQ6Nzb0K69
         PULILwoy/OHh5LBvpfwbEzB/OCOUpCNdzrhmjz24/58YJErAHjm9fC/TImxNwPzmGjAG
         2KiENDYkm1LXyqoQ00c6u/BAu7k7NRXXomg21JtauZMwzlTp7hHoQgiGxDoz80yH3PUM
         RDLdr8MNmwzYCdtF7+tqOQlVBVKuf17YOkgbdItS+shGh+SZnn2OlZt8S2kQ5P240Cg2
         drVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714756995; x=1715361795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gDQ9+UkM02IRkgzYyXz6zpT1AsYfEg3PAFp5x/fCFqQ=;
        b=aTMhSKpOL9DLicKVj9cKT/BxyiNJXSuUE6HlZ/wk5zwrLopnUssKuZykttYjdsjxdt
         povIABf4sO/E5QePi+46E8QShoBy4tSxDrSKDfzDx0z09sL7FGs6l7JKRvYn24BxJ+y6
         K/6RQQYaX/tj/9M0uqJB9wZOt0LHG9QRDJBpRxn58B34m/HjpKbQLSh0XU13LEKH9jht
         Vq0uTLCglvYvODJR2Zoww5D2tzJTzpu2gd9RjkQJiLruHzevbPgRGJqDHUE18UiI97E7
         wNQ99xweqw+ELsedA9JGSmN0ih34jvVPRet4k9wr9FkhthqFRvzUgi6exz0S46pBz6wX
         f31g==
X-Gm-Message-State: AOJu0YyrgmLIzSUcPh2jY3rYBHAYkty5AOso98DbTBiQuYkhJoh25j0f
	che+WHRVaLhs1eWY8XCl7rpdjrocfpfCTQvAocH+fZ+GTgpw3TZyUn/f2w==
X-Google-Smtp-Source: AGHT+IFh9um2/JAeslDVzacatGHyf4TLgUsVC/2aLB46YIqhRi8ichsVizKjzAlnahqcMP1ujHFxLg==
X-Received: by 2002:a05:6830:16c3:b0:6ee:3e22:83cb with SMTP id l3-20020a05683016c300b006ee3e2283cbmr3868132otr.16.1714756995179;
        Fri, 03 May 2024 10:23:15 -0700 (PDT)
Received: from denethor.localdomain ([136.50.225.32])
        by smtp.gmail.com with ESMTPSA id cy14-20020a056830698e00b006eb7b0ee326sm705212otb.65.2024.05.03.10.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 10:23:14 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 1/5] ci: pre-collapse GitLab CI sections
Date: Fri,  3 May 2024 12:21:03 -0500
Message-ID: <20240503172110.181326-2-jltobler@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240503172110.181326-1-jltobler@gmail.com>
References: <20240502193840.105355-1-jltobler@gmail.com>
 <20240503172110.181326-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sections of CI output defined by `begin_group()` and `end_group()` are
expanded in GitLab pipelines by default. This can make CI job output
rather noisy and harder to navigate. Update the behavior for GitLab
pipelines to now collapse sections by default.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 ci/lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index 0a73fc7bd1..02e5e058dd 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -18,7 +18,7 @@ elif test true = "$GITLAB_CI"
 then
 	begin_group () {
 		need_to_end_group=t
-		printf "\e[0Ksection_start:$(date +%s):$(echo "$1" | tr ' ' _)\r\e[0K$1\n"
+		printf "\e[0Ksection_start:$(date +%s):$(echo "$1" | tr ' ' _)[collapsed=true]\r\e[0K$1\n"
 		trap "end_group '$1'" EXIT
 		set -x
 	}
-- 
2.45.0

