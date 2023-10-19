Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55992FE3D
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 15:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nsZTOQos"
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25BEA130
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 08:27:50 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-4084de32db5so2450515e9.0
        for <git@vger.kernel.org>; Thu, 19 Oct 2023 08:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697729268; x=1698334068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=q0g6XUu7BBsvfvI+Q5EGVnH3kq7sIQyrk8mZhz7t3HI=;
        b=nsZTOQosLqxGBpBbhjXb7ijYolS+5WDxa5uLN+8rvSguRQF/Jgvgij89Fcp5l5sUBk
         EU7QFhQnPN2V8JCiMIYW4zki1d1ZG7ZYCH8qzshAov0KZ28O1zfEPmZ2uM1HqCOR+twf
         YflYj6pjNr7l6A8E2E/gdVb1Yq2f5USJ2ss3b8LUGp8lsNF/AXx3GTiBIXdysL3ljf+c
         T2bpdpsmC9bmPT/fmzOa4OzLrb2Dmvgub3eLRHE7ZsmzdL/Ott6lAYw9ZGzM9pv/kKwG
         yz7HDHZs4qwHOxkl0NngOLWb2yN5GgE+vMNEeeyhwj1KB9VyG9vw9xe+Ojxq7xQjxkTc
         Fg2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697729268; x=1698334068;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q0g6XUu7BBsvfvI+Q5EGVnH3kq7sIQyrk8mZhz7t3HI=;
        b=Mw4HV9Sy1Cfu5RpjCzRoJwS5OSkanbigAqwXFnuSJniduB4K6ng30K4+iGls+AUf5U
         rkq6CZJK2NjoY9Rh0cdi7kK9f9RAS5gXA5owDTyUOGakj88o5PPdPHZcv+w7BCc75jE7
         9clK5jb/kcIOQ9erONQAtmH2BWhbNmSh2hGltV4QiFaanMKs/0Mip1OceKeIEr749GbE
         I9NnsFB3/HEYkgRIx+TT85JibLnWWJ0KC8Irv1rUCAhBQq5nmLqXW+6HixWuHHVED2aT
         3zC/TeP8txhq+Q5iAE7PoHnpPFH6q5yHb1eiTfqfSdsPNhB1sGJxjhG/0K3ojt93073U
         SK1w==
X-Gm-Message-State: AOJu0YyE4vnmH24OILyPfK3DaJnogLE007FAfLpLOuonuWOFvfNgWgkc
	kwcNKCYzvHnDCfJ4ErTXPgU=
X-Google-Smtp-Source: AGHT+IGaDGqEuO6ct9I+qiWkw9jcn+uaKe41rsynySO2icCCZ7YsFhpNpEfXJ0Te8VMcpQL+kVnfxg==
X-Received: by 2002:a05:600c:154b:b0:407:5b54:bb15 with SMTP id f11-20020a05600c154b00b004075b54bb15mr2076134wmg.36.1697729268223;
        Thu, 19 Oct 2023 08:27:48 -0700 (PDT)
Received: from localhost.localdomain (host-2-102-115-95.as13285.net. [2.102.115.95])
        by smtp.gmail.com with ESMTPSA id j7-20020a05600c190700b0040641a9d49bsm1022117wmq.17.2023.10.19.08.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 08:27:48 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: gitster@pobox.com
Cc: calvinwan@google.com,
	git@vger.kernel.org,
	johannes.schindelin@gmx.de,
	linusa@google.com,
	phillip.wood123@gmail.com,
	rsbecker@nexbridge.com,
	steadmon@google.com
Subject: [PATCH 3/3] fixup! cmake: handle also unit tests
Date: Thu, 19 Oct 2023 16:21:51 +0100
Message-ID: <20231019152726.14624-4-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.42.0.506.g0dd4464cfd3
In-Reply-To: <20231019152726.14624-1-phillip.wood123@gmail.com>
References: <xmqqh6mzwe24.fsf@gitster.g>
 <20231019152726.14624-1-phillip.wood123@gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

---
 contrib/buildsystems/CMakeLists.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 20f38e94c9..671c7ead75 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -990,7 +990,7 @@ foreach(unit_test ${unit_test_PROGRAMS})
 	if(NOT ${unit_test} STREQUAL "t-basic")
 		add_test(NAME "t.unit-tests.${unit_test}"
 			COMMAND "./${unit_test}"
-			WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/t/unit-tests)
+			WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/t/unit-tests/bin)
 	endif()
 endforeach()
 
-- 
2.42.0.506.g0dd4464cfd3

