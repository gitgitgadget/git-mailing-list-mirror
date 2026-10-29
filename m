Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793275346;
	b=X+WV7STpah3hbjlg7QCGD3Hz4VuqkDmHSWwh02eJ7ztc+nIbyjdo7V8X6e6JwTJ6cQsH
	 aJmdYGweiRsk6fBbb40cZBDtseEwZjOxKUB8AhChwZOig1uxgI298QZHXKgEBnKxbz8Kr
	 yl1ri9DZDVsvL/lhHDWpWT4Fah2YGJVAapstOpk0azNElm4dwBggAEez/rrn1Jotygl7r
	 MJVC/D/IbZm5CZlUYn31sNF1F6CZ3BgoI8kxk7Nk8VCk6oQqYJO8V7qn9OoUjPmn+7fGA
	 Opl0XacjWvaow/epNTAZiGhQTZBA2WQzvAKCIbt2TFlEJUQEZ5X4exHw8f78Gx02I1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793275346;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0pU/S7dv+kEglJBlDwJyeGQdjUadb/G3jiCLoKjoPTg=;
	b=vjjA5ouO0JsG0E/2EWAs1xm8dHlSUnwtpINAwjqcpRCCuZtgJj41/BgmcbKkv3+xcP4V
	 rKCLSMXlxM7gaT2mnlKqeMgyIMYUZFiAaIrx2USJ2yntUd9RCAWnhbFH35W9nm8A+F6i0
	 YY0MQGfV0V7v6H2U3fgjPPMxShbMGf+rxPjYatbd/7Y5p/pHK5+O+CQT8AmhGzELkdenN
	 /AnOMFGwx8QftIcPINNqI9LeyRn0oLkx04JWsphFgj1GiezDT2UppatRe1lv2s8xKTa7P
	 PDdskEXv8E3yxZK5VZYq8C9+sgnng/RY8FIDPzudEuHPH8d8zJYg8PipStIR0+uvZPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NHXiWy+x;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDF5606A31C
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 12:02:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5EDF5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NHXiWy+x
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48b042c0759so1054040f8f.2
        for <git@vger.kernel.org>; Thu, 29 Oct 2026 05:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793275345; x=1793880145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0pU/S7dv+kEglJBlDwJyeGQdjUadb/G3jiCLoKjoPTg=;
        b=NHXiWy+xN4WGCl+B697StVBf1WXUYThuH1c8avAB8e7nKGSIG2dE+9nMC8j9HPgJ10
         uWWgGHq2cjNmzHN3ObUbt6NqDHqgvQUySjwjtVqY+Ns+HOXM2I3AIYI4H5lvkqPJdcdD
         HMAuj9zTx6qIQw4R4GBvClwx8jucQvlpO01OtXe5TDQC65whMQewrw4siN1d6hrFyYiN
         jP58eVU9vNi44eAPykehT/z/Z2E6vFY/+YBKuV/DlkZKsswfWk2TKwEYKSnCkqlALAoV
         FuDbRbUUkHgq8b2AY5DOKQuOxYb/HBa0GEz5CYkWfqzJ3aUT9FGRNXzD52mkxTKPN1+t
         dE3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793275345; x=1793880145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0pU/S7dv+kEglJBlDwJyeGQdjUadb/G3jiCLoKjoPTg=;
        b=INNgosybKPRXm46MrBXzTNP0z89q+STYIgzHJpDQ8r94NIjWvn/zConcRM07cncJ9i
         Jb0X8SAbKDClaMqORKj60YWlZWrDl05lsjDdz80rf23o41MsuhfUtkCZFz9ipY5L95Uw
         Ix28Xavg6MRNDe99l42NgSti9y3T7f5Wso5jNDW6bT27qfHiE2odaHyJXs6oN4G8yyg5
         i8nDe+A9mcAqwGSdG6RdCIcQq3VpAJ2xGqmb8bJqZJbkxw8NK7PgfAlX3lKn8owdB6g3
         5kNjPappYY6fSuotLdlGxW/RDAgb5FtpKnZr0gKnTUXGQKTmvsKFGBHC28yfiGvzBYhn
         QjWQ==
X-Gm-Message-State: AFq9FYJqhMcR+y4sMAvfcmwic7sMw6XfhZAILM9NbQ7itX33gGU7+qpZ
	jamT0oahFWR2hOrEVhGnjfgf7RRQ+XVdYur3S/hz8fAURHXp7y1OQli4g6CAO7Fj
X-Gm-Gg: AYBFou3YJ1e8ARoari0YyDtGGobAVcSHstGygu+CALoLMjYaB1y+0OvfoN8JnVgi9bY
	4yoraS3/fnLwiOVWFNLC10I5srMtUAfchht86bIEAKop3CwVGQUOWleglmU1H2WtdwXdSQzAC3d
	otrm6thRsUHofftpQQZsJteULrLSJ2jvu1DdyzER/AmT21AlYR5rPTYOqYtcPbWHp22DFuySNRA
	GgJBe04oh8JHh5LPD5nDQzeQ21qflxBK4m384hdD2YSPfyLQBSoWgc8tpSy+l/Ezotmt15fL3oM
	uxzGEsr4qhjIIQFshBW1JreFHh3tJPYEibvtTFBNiCtpp5tkodoY08Y3Zm/Js/qf4ajjwdRsZ9c
	vPAadRtZ8JYOUOHjkDMFBEEz2+3jUUazDbsNa9fBvlo1tf848I4HcCmIW4F+LSLY3i4qjAdc61S
	oW7+OiYoRcRZ8AhNiKs3aOfpkpdVLnRlit2RZXQieHces0rbaurtoLPdmogDc7EuzPgwg40yfEy
	+16Wka1BrRDdcYlV/MndAJp//6inCd8jg2rGyWgChoNVPTehIt2oDYENonHOh01pSSI8cOHbAI3
	5TbOhSpxXKpqxoB1N3v1BG8Ho5Jk5Sf9BQ==
X-Received: by 2002:a05:6000:26ce:b0:48e:412:3829 with SMTP id ffacd0b85a97d-48e5d2e6cddmr11477145f8f.15.1793275344652;
        Thu, 29 Oct 2026 05:02:24 -0700 (PDT)
Received: from debian ([102.88.113.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebd49afsm34522764f8f.35.2026.10.29.05.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 05:02:24 -0700 (PDT)
From: Ogundipe Sola Taiwo <ogundipesolataiwo12@gmail.com>
To: git@vger.kernel.org
Cc: Ogundipe Sola Taiwo <ogundipesolataiwo12@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>,
	Siddharth Asthana <siddharthasthana31@gmail.com>,
	Usman Akinyemi <usmanakinyemi202@gmail.com>
Subject: [PATCH v3] t5300: modernize test path checks in t5300
Date: Thu, 29 Oct 2026 08:02:06 -0400
Message-ID: <20261029120210.3722-1-ogundipesolataiwo12@gmail.com>
X-Mailer: git-send-email 2.56.0.116.g6de20f6092.dirty
In-Reply-To: <20261023154851.7876-1-ogundipesolataiwo12@gmail.com>
References: <20261023154851.7876-1-ogundipesolataiwo12@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace `test -f` commands with `test_path_is_file`, because
it makes debugging a failing test easier by reporting what
expectation was not met.

Signed-off-by: Ogundipe Sola Taiwo <ogundipesolataiwo12@gmail.com>
---
Changes in v3:
- Rephrase patch summary to state how the use of `test_path_is_file`
	improves the debugging of failing tests.

 t/t5300-pack-object.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index aac139e6a0..e5ce478484 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -283,11 +283,11 @@ test_expect_success 'survive missing objects/pack directory' '
 		GOP=.git/objects/pack &&
 		rm -fr $GOP &&
 		git index-pack --stdin --keep=test <../test-3-${packname_3}.pack &&
-		test -f $GOP/pack-${packname_3}.pack &&
+		test_path_is_file $GOP/pack-${packname_3}.pack &&
 		cmp $GOP/pack-${packname_3}.pack ../test-3-${packname_3}.pack &&
-		test -f $GOP/pack-${packname_3}.idx &&
+		test_path_is_file $GOP/pack-${packname_3}.idx &&
 		cmp $GOP/pack-${packname_3}.idx ../test-3-${packname_3}.idx &&
-		test -f $GOP/pack-${packname_3}.keep
+		test_path_is_file $GOP/pack-${packname_3}.keep
 	)
 '

@@ -376,7 +376,7 @@ test_expect_success 'build pack index for an existing pack' '
 	rm -f test-4.keep &&
 	git index-pack --keep=why test-4.pack &&
 	cmp test-1-${packname_1}.idx test-4.idx &&
-	test -f test-4.keep &&
+	test_path_is_file test-4.keep &&

 	:
 '
@@ -616,7 +616,7 @@ test_expect_success 'setup: fake a SHA1 hash collision' '
 		cd corrupt &&
 		long_a=$(git hash-object -w ../a | sed -e "s!^..!&/!") &&
 		long_b=$(git hash-object -w ../b | sed -e "s!^..!&/!") &&
-		test -f	.git/objects/$long_b &&
+		test_path_is_file .git/objects/$long_b &&
 		cp -f	.git/objects/$long_a \
 			.git/objects/$long_b
 	)

Range-diff against v2:
1:  ca6cd5870e ! 1:  bbce4f6440 t5300: modernize test path checks in t5300
    @@ Metadata
      ## Commit message ##
         t5300: modernize test path checks in t5300

    -    Improves test t5300-pack-object by converting old-style
    -    path checks to use the `test_path_is_file` helper function.
    +    Replace `test -f` commands with `test_path_is_file`, because
    +    it makes debugging a failing test easier by reporting what
    +    expectation was not met.

         Signed-off-by: Ogundipe Sola Taiwo <ogundipesolataiwo12@gmail.com>

--
2.56.0.116.g6de20f6092.dirty

