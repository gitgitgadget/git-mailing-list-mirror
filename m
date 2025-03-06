Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAD7200BB2
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 10:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741256789; cv=none; b=RSDVN4Z9IrnZTMhB05d4CeffZ9+UviV3/bAXQma9quMZqk5XTKcaqZKrY8NWGm3ZgpiDk2XIihPxN3JUbEEA3NrshzJg4feaQ2O9rvUlog7MrnRqIf+NGvi1QwhKX5i5p2f88e8h4TK1tMqmki6oUZUHnQv9gSZe36OorgnYq48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741256789; c=relaxed/simple;
	bh=MS04Wd+wCruY9ILuKpUoJZsIKYwaCv8R3zRVksflk0g=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=hdB9/HzM9fKiQzIvfoyEXGP+YUvPpcQZJw2lAkm9ia5MA/9zgqODy7ryeGG+t5JFbbOb3WeoMhXGJRxPIneAtgRos1FtWVi0l09jAYJAeah2HpTM9iTBF3UcM8pGPRKUnP7931xjSbPQOgwDuxBxAgO54xfWUO5lRwQJ7zh37+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TMyU+If0; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TMyU+If0"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ac21c5d0ea0so62531566b.2
        for <git@vger.kernel.org>; Thu, 06 Mar 2025 02:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741256785; x=1741861585; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3KaNfvj71wrgb2f2vMO/kY2tf0Sw+soCYRf35rIjfRY=;
        b=TMyU+If0rXCRwzDnSs5IKm/NUqh665XE5n0MqnFjQbwdqcgzo/Me89epxWfHAuDlV1
         kSZfqysnGt8ReE+TGzNW4n7kqgj1gbVEX8+xAKiF3UCNbQCIUfnu9SSf8z1n0LnUhK5D
         lJm+vJmtP/FCv//0FQYntTDIt+hlF/EXEGB3aUq2U/TTmifp5VTYM76cTBwLBdBnZD+A
         yC94b3HxHzNdnsBeEzdaZm39L8y0M7ST0L9yFDxyi+Xl/2mhPYc+35k/zUgWAmIgAaL9
         Ld/DIs1yemOT2aA5vaoLSUCSOSvN8v/B/ieBIHFMQ0lh68Df00dNyQl09tsMgZnQnli1
         PfSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741256785; x=1741861585;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3KaNfvj71wrgb2f2vMO/kY2tf0Sw+soCYRf35rIjfRY=;
        b=QFFEx5id+1XNetBSHhc8FInBGpl6l7tNCdQVi0IsdUJvZNLlCcWdMEu1ph6+GRMARQ
         5OyhOifpQuNCebKf9BpblVcjy4DsfBO4WWV2I4vyCf6MESLMt8/R/ooSBsCzgom8Zbi5
         vp97LYw+WN/S9IRXdJdThrZQOz+GLapPTex+econSI5npO8PEJXpGZPspPkN0+LitmES
         fhI643uvVjFW5qBGOzKAtfAkAJBC9gGAxtbCYRB38peAbawzl2W837J/wQTfZrv0hqK8
         K74OgYxztCTINp0JiJIkm4TpscgutuhwFbRrS2+KVMmf0Bodqb6Lgjnxc7DvZjFDNM7P
         PeSQ==
X-Gm-Message-State: AOJu0YzpvLXxdLFF+vJw9C88vURcExXTUYAhrZXn64H4imAwloRvhjVX
	zEKH1zBIYyungyUtZUENRXTDpl+GDqdGdLlus1PrxNFjHvI67WJmrdd48A==
X-Gm-Gg: ASbGncs+gTRZxYsL9bTBdmc6XbajBjsOinIocQETLmdM0Rix5GHFD50IdHgql1zC8YO
	6kSrVdE9S9aWNNgjCBeJMdCqO7muLWdF1+u1PF2C5Yeasy9o4KGAQecRZmeXkKeulkWA5IvCNCg
	0sbIeFEaOJYi0Z4n8Nxum5VzAUy/quXMHYSfltDT3ODOJHYdqY7+M54ugMF1k6ZCLI5DO/b/v3q
	uBKBd+yLQXfw7aNFsQU7lB+irdYwjTmQ/iq4sUtcE+yDhrmcgOzeOg1S1kSWqXa9D3/FScDB+lL
	TnFKifI+fmqAANQzLdjXUNWn36GFTIFdS1QWTVJ9HipbBw==
X-Google-Smtp-Source: AGHT+IFBDaQRdeLua/v9Ny6cAuWlBCL9aSg/yRc2uqis/5++akeiMJ83TpmiqSYKy2u6zEhKLTG0mQ==
X-Received: by 2002:a05:6402:274a:b0:5e4:92ca:34d0 with SMTP id 4fb4d7f45d1cf-5e59f47f014mr15092291a12.20.1741256785082;
        Thu, 06 Mar 2025 02:26:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c7472151sm729296a12.26.2025.03.06.02.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 02:26:24 -0800 (PST)
Message-Id: <59a2e586e1ae705471c7003efc007df5447692f9.1741256780.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1867.v2.git.1741256780.gitgitgadget@gmail.com>
References: <pull.1867.git.1740671049.gitgitgadget@gmail.com>
	<pull.1867.v2.git.1741256780.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 06 Mar 2025 10:26:20 +0000
Subject: [PATCH v2 3/3] cmake: generalize the handling of the `CLAR_TEST_OBJS`
 list
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

A late-comer to the v2.49.0 party, `sk/unit-test-oid`, added yet another
array item to `CLAR_TEST_OBJS`, causing the `win+VS build` job to fail
with symptoms like this one:

  unit-tests-lib.lib(u-oid-array.obj) : error LNK2019: unresolved
  external symbol cl_parse_any_oid referenced in function fill_array

This is a similar scenario to the one that forced me to write
8afda42fce60 (cmake: generalize the handling of the `UNIT_TEST_OBJS`
list, 2024-09-18): The hard-coded echo of `CLAR_TEST_OBJS` in
`CMakeLists.txt` that recapitulates faithfully what was already
hard-coded in `Makefile` would either have to be updated whack-a-mole
style, or generalized.

Just like I chose the latter option for `UNIT_TEST_OBJS`, I now do the
same for `CLAR_TEST_OBJS`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/buildsystems/CMakeLists.txt | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index c6fbd57e158..25b495fa737 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -1001,10 +1001,14 @@ parse_makefile_for_sources(unit-test_SOURCES ${CMAKE_SOURCE_DIR}/Makefile "UNIT_
 list(TRANSFORM unit-test_SOURCES REPLACE "\\$\\(UNIT_TEST_DIR\\)/" "${CMAKE_SOURCE_DIR}/t/unit-tests/")
 add_library(unit-test-lib STATIC ${unit-test_SOURCES})
 
+parse_makefile_for_sources(clar-test_SOURCES ${CMAKE_SOURCE_DIR}/Makefile "CLAR_TEST_OBJS")
+list(TRANSFORM clar-test_SOURCES REPLACE "\\$\\(UNIT_TEST_DIR\\)/" "${CMAKE_SOURCE_DIR}/t/unit-tests/")
+add_library(clar-test-lib STATIC ${clar-test_SOURCES})
+
 parse_makefile_for_scripts(unit_test_PROGRAMS "UNIT_TEST_PROGRAMS" "")
 foreach(unit_test ${unit_test_PROGRAMS})
 	add_executable("${unit_test}" "${CMAKE_SOURCE_DIR}/t/unit-tests/${unit_test}.c")
-	target_link_libraries("${unit_test}" unit-test-lib common-main)
+	target_link_libraries("${unit_test}" unit-test-lib clar-test-lib common-main)
 	set_target_properties("${unit_test}"
 		PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/t/unit-tests/bin)
 	if(MSVC)
@@ -1046,13 +1050,13 @@ add_custom_command(OUTPUT "${CMAKE_BINARY_DIR}/t/unit-tests/clar.suite"
 	VERBATIM)
 
 add_library(unit-tests-lib ${clar_test_SUITES}
-	"${CMAKE_SOURCE_DIR}/t/unit-tests/clar/clar.c"
 	"${CMAKE_BINARY_DIR}/t/unit-tests/clar-decls.h"
 	"${CMAKE_BINARY_DIR}/t/unit-tests/clar.suite"
 )
+target_include_directories(clar-test-lib PUBLIC "${CMAKE_BINARY_DIR}/t/unit-tests")
 target_include_directories(unit-tests-lib PUBLIC "${CMAKE_BINARY_DIR}/t/unit-tests")
-add_executable(unit-tests "${CMAKE_SOURCE_DIR}/t/unit-tests/unit-test.c")
-target_link_libraries(unit-tests unit-tests-lib common-main)
+add_executable(unit-tests)
+target_link_libraries(unit-tests unit-tests-lib clar-test-lib common-main)
 set_target_properties(unit-tests
 	PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/t/unit-tests/bin)
 if(MSVC)
-- 
gitgitgadget
