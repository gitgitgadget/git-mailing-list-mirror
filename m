Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD7626AD3
	for <git@vger.kernel.org>; Sun, 14 Jul 2024 16:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720972834; cv=none; b=Eazsiu5bzV1/ZLTsx3n0gY/HXbdAfeG/zd91H6AE0DlkMfUoV+o0A2MZLqgPN7p7xgWzr7jDWXVfjjyAJ/wBEKBffrQ0q9P3+5W5FyyaFhQg9rihytqxdT2lklCxxRr+9aT+npavBEhO5OOf1HdkJ9PqOkIsQuu29kHDx0xNKAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720972834; c=relaxed/simple;
	bh=FRvx6stW8EGU+L/9rQGVtL+bn0tbf0Ic6b96OOR4g4g=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=fAxLZasHgGxYmtw0zORdda1URbF8GykcL8jRimPYsQ81kzYvIB0nPCsvPXU6GTdVc6WqlYqiNs44+984DSRoFyzwNxn5RV1PlkHahLhGFmU6PA1K0+PpWCex4O5VyrVGqL0HrSQ475Vgvm2OmxQMsZlN+m7qP3uA4CtsgbXXG2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aCTYkthM; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aCTYkthM"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2c9a8313984so2867498a91.2
        for <git@vger.kernel.org>; Sun, 14 Jul 2024 09:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720972832; x=1721577632; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+0KFQRKWkBhqbPZLIm1Ih4Z8F4ARqLpmXjc6QasBghU=;
        b=aCTYkthM3ms+2SsAfr8tu53Yo2wgnWMrknGuqMpW6CLPCHimIMWrmjtePD8FvBAi62
         8f97JGvLvUe0+qmAVZ0ij3H2MPvpoOZ2cx6Hc7xSvzEnF4M3RYrBjBIf+pt63lXBj36o
         jGGcOoSO5La8j/2ys1GaCDPOrbYyUDUmQWmzJxW0aj/Z3qTNXPjRTBtmwnxWk7urA8xn
         y9xaVfdGbg1t7KvpkBhwalEiuvXttml42rbVDRTfH9y4J6IhXRTvv2/uxQZOHWFptTp8
         UWKXNU1xC8PUGUL+YT1LSjHVM5eEIUQK25vO1wozN+DVMN2aIQNx1YtpnAT2CkdaIkqJ
         yCSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720972832; x=1721577632;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+0KFQRKWkBhqbPZLIm1Ih4Z8F4ARqLpmXjc6QasBghU=;
        b=NERIXr0W/Gv10y8IPIVNBs++VgDvjIknff7jM2DFVsNnCfAchr2u1gUFzhR4629kIB
         W4PRuwu0KbBM/4JzVIg2p4Rh4srEItttCYQwyXOk0QLSTU7C6kg2/Y5+IYl8GLTF2MAJ
         +rB82k7GRD7WTaLP3uzilTrbY7PcEHpM5aiL7Auqjw/eAUKimiw40rTrCM4MslgL+4lj
         0uni1U+/K1z8a9+WVLHO2aRy0bHPDk1zz9VE+8aOhLsnOsTPKSjmVGSyi6jgUo00EDPS
         xVqg6hV08IJPk6f5jquGPOD38+KAuoRDUdTyjm8HnCWrQtopELIZb5MSNS0sQsaYleMH
         iDFQ==
X-Gm-Message-State: AOJu0YyBa6KU0ZWMt539jivPysoY6dWikyzjXUE1mZRkyJJR3u4ohr1m
	07sAK3B8IBR0vi6vftKWmzgavvPTOT68Gf00xo57Q6a8vrTl1aFMyOOe4Q==
X-Google-Smtp-Source: AGHT+IFj/8yVzskG77rruj/bZsoA8qOVL9ycdXYaXUabg/xROlb6nfYWEia38XDrULjNs97D14hYGw==
X-Received: by 2002:a17:902:e54d:b0:1fb:44e1:b5d6 with SMTP id d9443c01a7336-1fbb6d43a23mr153690895ad.23.1720972832503;
        Sun, 14 Jul 2024 09:00:32 -0700 (PDT)
Received: from gmail.com (p4357013-ipoe.ipoe.ocn.ne.jp. [123.222.98.12])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc27237sm25142585ad.135.2024.07.14.09.00.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jul 2024 09:00:32 -0700 (PDT)
Message-ID: <efa98aec-f117-4cfe-a7c2-e8c0adbdb399@gmail.com>
Date: Mon, 15 Jul 2024 01:00:28 +0900
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 0/4] use the pager in 'add -p'
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>,
 Jeff King <peff@peff.net>, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <2653fb37-c8a8-49b1-a804-4be6654a2cad@gmail.com>
 <ebcba08f-3fbb-4130-93eb-d0e62bfe0a8a@gmail.com>
Content-Language: en-US
In-Reply-To: <ebcba08f-3fbb-4130-93eb-d0e62bfe0a8a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This iterations fixes this error:

t3701-add-interactive.sh:619: error: head -c is not portable (use test_copy_bytes BYTES <file >out): test_write_lines P q | GIT_PAGER="head -c 1" test_terminal git add -p >actual                  
gmake[1]: *** [Makefile:132: test-lint-shell-syntax] Error 1 

Rubén Justo (4):
  add-patch: test for 'p' command
  pager: do not close fd 2 unnecessarily
  pager: introduce wait_for_pager
  add-patch: render hunks through the pager

 add-patch.c                | 18 ++++++++++++---
 pager.c                    | 45 +++++++++++++++++++++++++++++++++-----
 pager.h                    |  1 +
 t/t3701-add-interactive.sh | 44 +++++++++++++++++++++++++++++++++++++
 4 files changed, 100 insertions(+), 8 deletions(-)

Range-diff against v3:
-:  ---------- > 1:  6b37507ddd add-patch: test for 'p' command
-:  ---------- > 2:  5497fa020b pager: do not close fd 2 unnecessarily
-:  ---------- > 3:  30e772cf7c pager: introduce wait_for_pager
1:  f7cb00b654 ! 4:  913e7f3d09 add-patch: render hunks through the pager
    @@ t/t3701-add-interactive.sh: test_expect_success 'print again the hunk' '
     +
     +test_expect_success TTY 'P does not break if pager ends unexpectedly' '
     +	test_when_finished "rm -f huge_file; git reset" &&
    -+	printf "%2500000s" Y >huge_file &&
    ++	printf "\n%2500000s" Y >huge_file &&
     +	git add -N huge_file &&
    -+	test_write_lines P q | GIT_PAGER="head -c 1" test_terminal git add -p >actual
    ++	test_write_lines P q | GIT_PAGER="head -n 1" test_terminal git add -p >actual
     +'
     +
      test_expect_success 'split hunk "add -p (edit)"' '
-- 
2.46.0.rc0.4.g913e7f3d09
