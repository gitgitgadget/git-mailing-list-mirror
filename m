Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C5D2FE39
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 15:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TqL5SYrj"
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED25D121
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 08:27:48 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b9338e4695so110792911fa.2
        for <git@vger.kernel.org>; Thu, 19 Oct 2023 08:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697729267; x=1698334067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cRAAkzVjtemOySe9QFyPyi5ja34gIGDYBP3y6JanAeY=;
        b=TqL5SYrj5c6eDFDS1KpX6VoaMvQ0lveXT26kWUfyreQReKpQReGAvlulhUteDvPt9/
         kAxI36L0ZA8Rz9UmsXpJHrl9q/wgetqc5bL5fbn0rluTnlQwVjjxzo/wAGUNU9B/uycA
         pQI6fIrGwa+zzN5PwsSelfLD+kqdMAH03qb6XFLRJnQtvALUKyQzAtM8f+EKSpjFe64l
         nAXp1IDY9ug4i+3xrOu00b1/DR5BtO/OWEcy89foMeNomx00xNTfztqiSZ5ybLDwuUsN
         yBmsjOKJuBgkh7C8L2C3aThUDjTiI2uaiGrKgneShW/DZe8fC8Q230Fn1U8h2H2Jmd/+
         hPqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697729267; x=1698334067;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cRAAkzVjtemOySe9QFyPyi5ja34gIGDYBP3y6JanAeY=;
        b=Mr0WRDAJfKCxpIFabCtyGGaRI/r1M7m9K5oPsb02hm81Osh7F5Irm2EPz49E18NenT
         tuEsajWH4HVFxfKPBJTpQLYhQS1+MjaNgUAAeYZKslBMx8sFSLDtFzSOlUYMlWq/GaAL
         QyVa4RxH+1F4rXJni1B9I3On9p+ezOa6kC/StlTL8FJ2kxoQb04wpBuJpSb0hLLjJpxx
         9+w4OtJcYW/hCAUaGj5qnZu5J/QfJuCMJb4Z4+btu+7pMuy++JZ2cuFekntLkNGIBUd7
         tZD/wMCXU5zVna9dP4AxdrKsNoUdrYzyf6jEKFqnmHS+fFZa8m3+tDKLDrv/wViqE//0
         VQdg==
X-Gm-Message-State: AOJu0YxNeMU4qeS4WUXtV8QS/o8+dEDjNjRW2PbzoRg5Hv0JX1t+ns2l
	VrIM8ieNz8gu8wTdkWZ31dk=
X-Google-Smtp-Source: AGHT+IG7Rg/6Jw1oRW/A5J74SE68t2gCXaNABBVOVYTjr6e+pRIKDGM8rVNqkF8EYeUV5vf+anwALA==
X-Received: by 2002:a2e:3213:0:b0:2c5:380:2a10 with SMTP id y19-20020a2e3213000000b002c503802a10mr1596349ljy.25.1697729266707;
        Thu, 19 Oct 2023 08:27:46 -0700 (PDT)
Received: from localhost.localdomain (host-2-102-115-95.as13285.net. [2.102.115.95])
        by smtp.gmail.com with ESMTPSA id j7-20020a05600c190700b0040641a9d49bsm1022117wmq.17.2023.10.19.08.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 08:27:46 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: gitster@pobox.com
Cc: calvinwan@google.com,
	git@vger.kernel.org,
	johannes.schindelin@gmx.de,
	linusa@google.com,
	phillip.wood123@gmail.com,
	rsbecker@nexbridge.com,
	steadmon@google.com
Subject: [PATCH 1/3] fixup! cmake: also build unit tests
Date: Thu, 19 Oct 2023 16:21:49 +0100
Message-ID: <20231019152726.14624-2-phillip.wood123@gmail.com>
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
 contrib/buildsystems/CMakeLists.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index d21835ca65..20f38e94c9 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -973,12 +973,12 @@ foreach(unit_test ${unit_test_PROGRAMS})
 	add_executable("${unit_test}" "${CMAKE_SOURCE_DIR}/t/unit-tests/${unit_test}.c")
 	target_link_libraries("${unit_test}" unit-test-lib common-main)
 	set_target_properties("${unit_test}"
-		PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/t/unit-tests)
+		PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/t/unit-tests/bin)
 	if(MSVC)
 		set_target_properties("${unit_test}"
-			PROPERTIES RUNTIME_OUTPUT_DIRECTORY_DEBUG ${CMAKE_BINARY_DIR}/t/unit-tests)
+			PROPERTIES RUNTIME_OUTPUT_DIRECTORY_DEBUG ${CMAKE_BINARY_DIR}/t/unit-tests/bin)
 		set_target_properties("${unit_test}"
-			PROPERTIES RUNTIME_OUTPUT_DIRECTORY_RELEASE ${CMAKE_BINARY_DIR}/t/unit-tests)
+			PROPERTIES RUNTIME_OUTPUT_DIRECTORY_RELEASE ${CMAKE_BINARY_DIR}/t/unit-tests/bin)
 	endif()
 	list(APPEND PROGRAMS_BUILT "${unit_test}")
 
-- 
2.42.0.506.g0dd4464cfd3

