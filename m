Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A47E14B082
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 08:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721722878; cv=none; b=NuSlV+w7dUcKFhTAapRfvmeLOz1OzqeHeBPBVaZFMQeOfrt0nm7hTNtaClvUg899z0AJHSCeCG5tSnXrOam6TJVoDS5/FISxDcbAy/vPqZlhChwdn2v4oLtwhuw1Yt2uU9XsKsbU+fL5ld6Ut8DMlaN4cBckT4vJdusBCbmy3Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721722878; c=relaxed/simple;
	bh=fXYkwyyNJCLwx/1+LXMILAXgVK2bnFuuMMrPjySB8G8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z3ks3FWLmf61KGpzvVFh8pGhSRc/bwuX+BeqTtn9YSXgD/8F09f6zEZW/v6SDdbo52pbCjBO7G3arrhpEJAquAlNoctovUiesmTslTkR9grrEpUTEWa5f32u5IRRsK3fntelqzJZ8BfzM/AsRcqNM/wv0Z3w3ZL9lFoQyZ1To/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YH3VOp5P; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YH3VOp5P"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52f025bc147so2988945e87.3
        for <git@vger.kernel.org>; Tue, 23 Jul 2024 01:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721722875; x=1722327675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IXE3MYu8CxgvrX1p6ggHUE0kt8dF7SAUpXUFx2O4fgw=;
        b=YH3VOp5P0170chaMqmx/WbAZ6Et7IN3e1m5R6XoIKojMvHbr7ln1bNoz3rF/iJMMKO
         J7Ov16uHe+boq4Ad0FntquO/g20XdpVFkCbOIUAqc8WlZ3U3tNYicNv6/gcquVfbeCAI
         RoiShCVe6vHcXJvEJVNFRXXEH5uwbSxjnfxOhLtEM6bHZvkTSNRJ6ODQN7WWYYvna97V
         hzrkunNx8n1pst24GLFFfnnjOKUzA4ZRWiUwFTlOS/XzQWAvgM/olMebDkd95Nx44wuy
         piYzMBF3C6T6zVDIR2aQBVAmwrlaxTpdIbsOYzGdDIZ0QWzvBuKCipTROEx4kBysM/PV
         gBSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721722875; x=1722327675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IXE3MYu8CxgvrX1p6ggHUE0kt8dF7SAUpXUFx2O4fgw=;
        b=OfMhRSiIFyQriA4rFfuac4bf1UjVSgJz2KgDgsrWunCJtEB98zaLz0e5E2qCQVf2cZ
         0Jg8gS8RjkuXpN638dYjfA9hz1qjPsLjvMCAt+BRW/tJ4kZcOBcB5XrlSjMoTD51Hljk
         IWhmsLf5fTd/oD0PlVCExfYRO893OZVcIpdeAAKf5gxe+uwrS1D6ZJ1g1s97xLfN5uYy
         kvWl6mrtRuDhQ29N7vRL1WenRZS8IHEOBrC8VjA2QxEtuWptsR0r6/yYk50ErIlG4Pve
         KCiiZq1WG//f9G0RBKTD0oUzaT996dIxxNj7fMTS83d1SMxj6BfBHZcbR77yOHIp4bc+
         FpEg==
X-Forwarded-Encrypted: i=1; AJvYcCWLLZlNIPAdDg8k8J319unuqJR8Syvb156SSiia8o2915Weh4kqpznorWi4SaOSNSPKK5mpmWzWMplzIOLuW6LqlpIN
X-Gm-Message-State: AOJu0YysCYQiZbAzsRc2R2TkUcSpqGRCnHidN6Bu8uae0QIqzZoo0HRX
	ag4iFc5pW2OUqKfhp/7hXsDs/6KmZLS83fjtfVRxPBR5RHZb7RDN
X-Google-Smtp-Source: AGHT+IFElAXfTYjUilei9DqkXyQZEX8L9asUSvF2RKzShLXmWTRaVWX//rz5Xzns2HkTAiXYF/qnzg==
X-Received: by 2002:a05:6512:3402:b0:52e:9d6b:2691 with SMTP id 2adb3069b0e04-52efb63433bmr5729532e87.20.1721722874826;
        Tue, 23 Jul 2024 01:21:14 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:45ae:72d0:1982:e034])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a9f463194sm24026266b.112.2024.07.23.01.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 01:21:14 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: chriscool@tuxfamily.org,
	git@vger.kernel.org,
	gitster@pobox.com,
	jltobler@gmail.com,
	phillip.wood123@gmail.com
Subject: [PATCH v6 1/6] clang-format: indent preprocessor directives after hash
Date: Tue, 23 Jul 2024 10:21:06 +0200
Message-ID: <20240723082111.874382-2-karthik.188@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240723082111.874382-1-karthik.188@gmail.com>
References: <20240718081605.452366-1-karthik.188@gmail.com>
 <20240723082111.874382-1-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We do not have a rule around the indentation of preprocessor directives.
This was also discussed on the list [1], noting how there is often
inconsistency in the styling. While there was discussion, there was no
conclusion around what is the preferred style here. One style being
indenting after the hash:

    #if FOO
    #  if BAR
    #    include <foo>
    #  endif
    #endif

The other being before the hash:

    #if FOO
      #if BAR
        #include <foo>
      #endif
    #endif

Let's pick the former and add 'IndentPPDirectives: AfterHash' value to
our '.clang-format'. There is no clear reason to pick one over the
other, but it would definitely be nicer to be consistent.

[1]: https://lore.kernel.org/r/xmqqwmmm1bw6.fsf@gitster.g

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 .clang-format | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/.clang-format b/.clang-format
index 3ed4fac753..5e128519bf 100644
--- a/.clang-format
+++ b/.clang-format
@@ -96,6 +96,12 @@ BreakStringLiterals: false
 # Switch statement body is always indented one level more than case labels.
 IndentCaseLabels: false
 
+# Indents directives before the hash.
+# #if FOO
+# #  include <foo>
+# #endif
+IndentPPDirectives: AfterHash
+
 # Don't indent a function definition or declaration if it is wrapped after the
 # type
 IndentWrappedFunctionNames: false
-- 
2.45.2

