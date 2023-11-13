Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAF21CAAD
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 10:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bwi7jvI3"
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08AC10CC
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 02:24:24 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-33139ecdca7so1754315f8f.0
        for <git@vger.kernel.org>; Mon, 13 Nov 2023 02:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699871063; x=1700475863; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cPqd1t2iqwP/PGL/YZtl1KKlvVh1MN2oaFwBpr+oq44=;
        b=Bwi7jvI3Q0yiE5eGa/MLlnNfY+9KIDtBLgLuZP6J6vP6g2Y/EJYRWRl3mvV4XXUuuV
         huM92GjAjL+DQaeE4ir2EmjGfAnkSZUA4sOaTOLKMMtD4JdK25tdCn3mXdYNXp7iYVSg
         bPZqzEgtzHdNXb6ZznRi6cVdNrn1JOYH9onf+O7gXfgpC/sq48OL+OnHbvqRBSW3kONj
         w3DgmBV0dXSzR2/HmcrTFu6A+Ofye5TFCdOm0Qt16Yc9G3JugwjA2iaN5OaR6fBe/Y+z
         hCUszECXu8sURWmrfZGYI4Upq1CMrty6eB6micp24yGKbRF7eg/MireyhVndEgPlHEIC
         Sozw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699871063; x=1700475863;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cPqd1t2iqwP/PGL/YZtl1KKlvVh1MN2oaFwBpr+oq44=;
        b=iefQ4cZuQa8eJsVxJLFk1kpB2l1btJZnVpsCuCj6jX+34Crf/ViKXPlX/gLLduQxfi
         XDC+fogLAzQNA2ZAReVi5HLRB/axqg2pc8doUxmMZY/+O8rTyN5MPwc47JznzbBQcYGr
         mddLKKSuTYOTAD3kIX5hzVpKOwVjlMiVjTzAeYKaSmydUQDvbrmr4H3WuWIVArQbxOrg
         Trr/NK+6ikUmtfXZ14DSW9xEPAOFOeaZBOiyoJq/ly+grCEkHoioUPQlyeZNyrUA8uxi
         uobBvU3rFHHZQEG+f/z+5APaBDqHjXZl2z44mp2eR3gMM7Kn7H8nAzmvj2/OpvTZR966
         05pA==
X-Gm-Message-State: AOJu0YwzfBIqoUG3Dj+D8IPfsNAhisUNXjbhTC2u8L25ZKshnt8r7E/5
	GjMOT0C+AA234AvwOpJ/IFE2yH+rUTM=
X-Google-Smtp-Source: AGHT+IE3DEg7YhoEyyyKo10jcQNX1UiG4e0UdygPOpReE11kLAzKg47OC/Q3TyB0ICZKJN6es2od5Q==
X-Received: by 2002:adf:9c8a:0:b0:32d:a41b:bd47 with SMTP id d10-20020adf9c8a000000b0032da41bbd47mr5538583wre.59.1699871062928;
        Mon, 13 Nov 2023 02:24:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q2-20020a056000136200b003313a1e0ba1sm5075128wrz.89.2023.11.13.02.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 02:24:21 -0800 (PST)
Message-ID: <3c9b02e18d232fbccf27c4e95d8b3193ba9348a2.1699871056.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1537.git.git.1699871056.gitgitgadget@gmail.com>
References: <pull.1537.git.git.1699871056.gitgitgadget@gmail.com>
From: "Haritha D via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 13 Nov 2023 10:24:08 +0000
Subject: [PATCH 06/13] spaces and errors fix Handled git pipeline errors
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Haritha  <harithamma.d@ibm.com>,
    Haritha D <harithamma.d@ibm.com>

From: Haritha D <harithamma.d@ibm.com>

This PR has fixes to enable build on z/OS

Signed-off-by: Harithamma D <harithamma.d@ibm.com>
---
 convert.c    | 2 +-
 fetch-pack.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/convert.c b/convert.c
index d3f204b4c29..7fe107710ec 100644
--- a/convert.c
+++ b/convert.c
@@ -1314,7 +1314,7 @@ static int git_path_check_ident(struct attr_check_item *check)
 static struct attr_check *check;
 
 static const char* get_platform(void) {
-	struct utsname uname_info;
+	struct utsname uname_info = {0};
 	char *result = NULL;
 	if(!uname_info.sysname[0])
 	{
diff --git a/fetch-pack.c b/fetch-pack.c
index f40b90dfa65..c1f2e714f8e 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1853,7 +1853,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 		die("fsck failed");
 
 	if (negotiator)
-		negotiator->release(negotiator);
+		negotiator->release_negotiator(negotiator);
 
 	oidset_clear(&common);
 	return ref;
-- 
gitgitgadget

