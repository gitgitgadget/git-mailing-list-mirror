Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794335972;
	b=Qn7qoZfiKCN59gAWtmyXvrHZjd93h3HbgEyZJfuICurmL/VrR0laG+4XYaY5lzJWYh0z
	 boQIcq133wVLQrKbmuvdyPEx1W5FSt0TCF+hDqHmo7AwohfuNQdAznxkNkv7ndzVonv34
	 enKwU7bp0yTblua+/sn+bPl+EJ88//VaCo29RQvohMXcvQhzL+rW07fq0sVPAmVpVBpS6
	 6pJdVXdAaf/6meUq/vzkcEHqu4nIqY+gzN6LGuPjLVGs1yrETvb2MZiF//uJKAhbQaTbo
	 +hw/OgwrWSQz14x2gAJ8t+QSdcWPaVOf5SSopPz9Fy4s9cfqbALnSN8uwrSJf1DlCKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794335972;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=h9oVC7y+9NBCRI7qMq7IWmoNl9ei1skDcNnrKc3FEww=;
	b=OJLTwuwwBGreG/IkyDe1WflKcDK0saQC6TBJv4VCVNa9rUGeglVgC1VA9TlAVEsfs5ow
	 N8+KVQEn7AbTP1H1MKaieVL+ppie6uBLX7fbw6lyCXL/MQsNkjbrlcvi1hdzPY5mE2LvA
	 qprl056BLuZpMzUHSy5pISkEz36llUEh9/9IfoIOFmBV0HAHR/93G7rC7wQ6BkeV0Ku74
	 pumjVma+LzWLiTGBCzEw7ZFyAMcMXd7TBpe8hMNYElw6EmTOBNME+DVf2AMFWP2lBrrMk
	 8mM1eSZ9AegQmxT0NyesFwQZLRFQCYZRNb3xvm8lShSDpDJ3OoImju1J+F2j9lWBl6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lSzKRuc0;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706D0606A32D
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 18:39:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 706D0606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lSzKRuc0
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-37000e7234bso4392455eec.1
        for <git@vger.kernel.org>; Tue, 10 Nov 2026 10:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794335972; x=1794940772; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=h9oVC7y+9NBCRI7qMq7IWmoNl9ei1skDcNnrKc3FEww=;
        b=lSzKRuc0fjQG51ASrkWTlWiBCDHQUS9UwDOV2ZqTTan7Amav6UAphJuCbbrOWRG5kp
         cpyiCiBZu1UL5K2LFE5ULmSi5vr8rfgEF8wGKGZ4fs6h28KyxcdV1LAQjy+3OBaX0dH8
         iv24QFZbwK33b/RpDKlgJv4Uzgq3bCkJgB1USgei2hRImj6sI/bjxopc3G4xRvRcrm4O
         zUneWDNccVYDtqaCVTvufYRUHpxb3xRKrjDLyLvfnIc1rZv9siCuejhHDN2dQPgw1WOU
         KX7ipN6JrenToPTaqLK3Q69KK9aWbN0TZhD6EJmvahTsEz4IWiNvxAIYJiB/MBsoZPzv
         mOyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794335972; x=1794940772;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h9oVC7y+9NBCRI7qMq7IWmoNl9ei1skDcNnrKc3FEww=;
        b=nXq0e+r2o6PH5ZRFxF5vUr18whEdpQFK+NBF2aGu3lYd6c2RTlhJOnOtoD2U4BMNCk
         zhr7g9dkK36vtb3s5MDnl8G8vhzPWKkBMMphO3RdiLnoZVVzJpy5+LwkfCLRSWBmIhbg
         iptBujCz28TPLF2uZ4SgpdAC+A7jn6kaOB2EYM+6+aoc/IodAwAdEFAYDQ2hNVZZRFoM
         sONbbiMEUfEZdfoDI3hKYTuXmkG2GV2ixL84qi61c6fndixGCoLbfPjMZPIOW+hNHCr0
         /oUwuFhdgR78mrS8PKueM9cyrIvLuW7inxahq3rrHo3/ifTiqpxYvX6xQGZ7E3mp+oTL
         uJew==
X-Gm-Message-State: APuU4Z9gMQS0Twuqk4zNf1bTMIh9TaUZ5FYWM7Sgnjy/OZx8K8H8sHzD
	2/v4XxPKE+w1JzQJg/fZPQ+MoEI8VQJXyh0EumsdQJG2e4cIEPPCcKE62WS/oTcO
X-Gm-Gg: AYBFou3ryFVK7FWVKYzQcEUQ8PgILPlHzELQ8Mf+Q8+Xi+ZL83PFlzbdwhGjt48B51L
	/szgyUXCQMCWGs5pgaqSwe+p2xl9Y6dHMYKp7pPbLesnH9awvJ98Xe55D2WhWK+mgQpf9gVG+IM
	maOV0td8snOH81OO+ayz3+PgCO2idIan2n53MEIZeC8khJSbkIXjbhYA29XaOmoFsBNH0l6YfHt
	YqP+hpSCHOwgRaayPQlAWESnxiK6T5tPRRktw4v4iKYaq1vhhKoYbLPtbOZT4y7TdEksbZG9EC6
	s6lyPrx2N59Yyu0C46dE39j2h7Up/Rfr7LxlESrwg/EkLUTkh3sZLNjV6+PSslQJPKAQ2fHKITu
	9yA+o3Y+UXaAhEYi5dHEQAyAaW6PVAGT6zSyvlK1b/GfsThKbeWADTYXrjhByl789E+wlzH73Pp
	/KrUW0leJlkvdJP5X8mlN7uoHPgW3W0N6yOfsQuy3my722RpG0FwKsyk45YCbZNdTQdUwbyuCq5
	QtzypJyVX23tYKzw3cq3CD19HmnJ++8wC0GT3AS0rzg27/hDDR+MU8I00e9e1KlZubJlGSCfewc
	n78R6HPnEO8wzFc7mWgopzit4hAl1ZmPP89gNQqhdIGkUpetTLqu
X-Received: by 2002:a05:7300:dd09:b0:36e:20ee:b288 with SMTP id 5a478bee46e88-37685d717b8mr165005eec.12.1794335971127;
        Tue, 10 Nov 2026 10:39:31 -0800 (PST)
Received: from [127.0.0.1] ([20.171.32.194])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3766146551asm793151eec.1.2026.11.10.10.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 10:39:30 -0800 (PST)
Message-Id: <pull.2305.v3.git.1794335969.gitgitgadget@gmail.com>
In-Reply-To: <pull.2305.git.1794251100.gitgitgadget@gmail.com>
References: <pull.2305.git.1794251100.gitgitgadget@gmail.com>
From: "Srujith A Poojary via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 10 Nov 2026 18:39:27 +0000
Subject: [PATCH v3 0/2] [Outreachy PATCH] archive: remove USE_THE_REPOSITORY_VARIABLE from archival
 modules
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Srujith A Poojary <poojarysrujith@gmail.com>

Refactored archive-tar.c, archive-zip.c, archive.c, and supporting files to
use explicit struct repository *repo pointers instead of global repository
variables.

Srujith A Poojary (2):
  submodule: use the submodule repository to abbreviate commits
  archive: remove USE_THE_REPOSITORY_VARIABLE from archival modules

 archive-tar.c                    |  5 ++---
 builtin/archive.c                |  1 +
 submodule.c                      |  5 +++--
 t/t4041-diff-submodule-option.sh | 23 +++++++++++++++++++++++
 4 files changed, 29 insertions(+), 5 deletions(-)


base-commit: 50fe5cc63f9cd6e89b87a2c9ccf96a444f4cfdb7
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2305%2Fpoojarysrujith%2Farchive-libification-refactor-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2305/poojarysrujith/archive-libification-refactor-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/2305

Range-diff vs v2:

 1:  01c3cc2573 = 1:  01c3cc2573 submodule: use the submodule repository to abbreviate commits
 2:  3d8d9a9261 ! 2:  398b54f00a archive: remove USE_THE_REPOSITORY_VARIABLE from archival modules
     @@ Metadata
       ## Commit message ##
          archive: remove USE_THE_REPOSITORY_VARIABLE from archival modules
      
     -    Refactor archival modules (archive-tar.c, archive-zip.c, archive.c,
     -    builtin/archive.c, builtin/upload-archive.c, and diagnose.c) to accept
     -    and pass explicit struct repository * pointers instead of relying on
     -    global repository state.
     +    Refactor archive-tar.c, archive-zip.c, archive.c, and supporting files
     +    to clean up archiver initialization functions and header dependencies.
      
          Signed-off-by: Srujith A Poojary <poojarysrujith@gmail.com>
      

-- 
gitgitgadget
