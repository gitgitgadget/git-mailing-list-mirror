Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1502747A
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 15:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eMhuSlWo"
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC35112A
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 08:27:47 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-408382da7f0so20726225e9.0
        for <git@vger.kernel.org>; Thu, 19 Oct 2023 08:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697729266; x=1698334066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cjS4/nGAmL2G/gKG1b32WLJLHkJWP2NWgcUFxqWGuLA=;
        b=eMhuSlWoGzZzvcOPBCf7pc/YGzMvKOz0dRYHJLfy4R4fLPT0RVmqkKu0oyDE+ek3BC
         7r3NaphqeKyitpLBDWsCtty7n1y75kHR/WpibNMHteCntdnRX0hAPwbeXzKJaBDlZMZH
         8pujqHEOHqzOXbTuEUNQZXdqDlPNmd36AOD1SSzsT6PWTxzzpfXgOCrXOzZG6fr26IrU
         q2KTQJMac56hEz4JBY3RsfdvBAmAutlQM8WwbQlWS0MxV2PT2pgslD5OfMZwnNJ3Tzmu
         y3yLMaPL9ZHhtdnFQedg9qCHVkTCBeyHR9nJi7ECWfdYR8IkwJDRhkyaVLbUk6Dj/YTG
         FGCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697729266; x=1698334066;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cjS4/nGAmL2G/gKG1b32WLJLHkJWP2NWgcUFxqWGuLA=;
        b=AfljL9xGwawtM5afJKEST361j7Wy5KjFCZB2w80gGEmrlfvnbDyFNJe9arwcglCe6k
         dUfcdwgVMAD8dnvriiO+hsUBrmrUAbrfmgaln/2bGHktWjuF9bMgZKTAiXVEOX1hLAkm
         /lgAOVsTU6xTNtyTBMKj57r8FQLaf4qF5sXl02X0EUnPenaJrq5POB0Ovxk4CSFXImps
         eFRsA1E0htK7HXKhGJWgpbediFMHfcPLk/QbdBxZGXySh5IcyUMn1USQ07udhhPbKJvf
         RPubIl/d+uBueZsvB35N1C+AQcSSpolKJ01lddLKmVx17WYh1GmafrqQ8b7RuFDUC73V
         yJdQ==
X-Gm-Message-State: AOJu0YxKIIlT88655w+5ffEwu9BV3St9JTm4aMKoZs1MH1DlAIoUvqvs
	QIDx2T2rNLRsmSJuyaBXEdA=
X-Google-Smtp-Source: AGHT+IHLsCOyQmLFG+0g96hK/b+uJ/EuPV+TYKYMXhvo6ybPhfeBuJ7nTFDlx3h932y8W7CH5KHUAQ==
X-Received: by 2002:a05:600c:19c9:b0:401:b53e:6c40 with SMTP id u9-20020a05600c19c900b00401b53e6c40mr1971370wmq.10.1697729266055;
        Thu, 19 Oct 2023 08:27:46 -0700 (PDT)
Received: from localhost.localdomain (host-2-102-115-95.as13285.net. [2.102.115.95])
        by smtp.gmail.com with ESMTPSA id j7-20020a05600c190700b0040641a9d49bsm1022117wmq.17.2023.10.19.08.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 08:27:45 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: gitster@pobox.com
Cc: calvinwan@google.com,
	git@vger.kernel.org,
	johannes.schindelin@gmx.de,
	linusa@google.com,
	phillip.wood123@gmail.com,
	rsbecker@nexbridge.com,
	steadmon@google.com
Subject: [PATCH 0/3] CMake unit test fixups
Date: Thu, 19 Oct 2023 16:21:48 +0100
Message-ID: <20231019152726.14624-1-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.42.0.506.g0dd4464cfd3
In-Reply-To: <xmqqh6mzwe24.fsf@gitster.g>
References: <xmqqh6mzwe24.fsf@gitster.g>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Hi Junio

> The other topic to adjust for cmake by Dscho builds on this topic,
> and it needs to be rebased on this updated round.  I think I did so
> correctly, but because I use neither cmake or Windows, the result is
> not even compile tested.  Sanity checking the result is very much
> appreciated when I push out the result of today's integration cycle.

I need these fixups to get our CI to successfully build an run the
unit tests using CMake & MSVC. They are all adjusting paths now that
the unit test programs are built in t/unit-tests/bin

You can see the unit tests passing at
https://github.com/phillipwood/git/actions/runs/6575606322/job/17863460719
Note that I have split up the patches since that run but the changes
are the same.

Best Wishes

Phillip


Phillip Wood (3):
  fixup! cmake: also build unit tests
  fixup! artifacts-tar: when including `.dll` files, don't forget the
    unit-tests
  fixup! cmake: handle also unit tests

 Makefile                            | 2 +-
 contrib/buildsystems/CMakeLists.txt | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.42.0.506.g0dd4464cfd3

