Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F5736AEB
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 19:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kD/Z1w+5"
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518D5D79
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 11:23:55 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2c514cbbe7eso85863021fa.1
        for <git@vger.kernel.org>; Tue, 07 Nov 2023 11:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699385033; x=1699989833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n5iRRctJGVh8R3GL32WF7IQ3PvEiW31kteeAQPDLX/Q=;
        b=kD/Z1w+50iIx2gdX14qPv1E/V//PZWlx4y5T0MNT8MZ2sUJsTRN03m3dKvhXz2nuA8
         j4FPStQHg/KtqViVO9hvUKog5RyzDQNO3uk0+oex0EU4VyYaJMirFP0ceV0r44qzBVbH
         0LCFrPm/rVkGilFSqiW99yaHMQPC2Xvpc2K4mfOEslK2HVeSTBd9k3ssnDek0mx0iMKQ
         fWlksa95xs8S2aEtg1rXTk614jX/0kqNB2OF3KgVcwdNUD5c0XIv2CHjHXtP761y6GTN
         iCKxMu5tC/8ZgjkO4AS6Das0UyuQJwUldAbSV031vgY7puKOrbsmKUM6jSG0tA1BGjCi
         QZow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699385033; x=1699989833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n5iRRctJGVh8R3GL32WF7IQ3PvEiW31kteeAQPDLX/Q=;
        b=eqX37uhkAaKpehZ29kPtODYBsSuwE6klprMrIfLrsgcy3orWhDhd4dTn2IcYimWtQx
         hzxTW2nWJEG38Yd9W+iPlmjckgZDHFG4TMCiOMj8K89dOOVOSsxTgGAI0IQdy1fCoHdy
         9kwVBlcb/JW52iOm/RbeSSrXk1DnXvTiazAH9MALTkZ2eH3I8w8PJyBV+LWvhMkZj9Wt
         3NuSJDtdfJrPIdRP8P07Wr4lRp6ejXKirX4bDe1cS1FRMZLNjKxoO2U9Glp4J/M/NWpZ
         lyxVln73996J+GekbLqFq0O+z5mrDOVkdu0nFk+fNDkchP5YjuaTn28HiiiO9Xg93xTw
         QIaQ==
X-Gm-Message-State: AOJu0Yx09nqmncNlLegCtkX6dHsfcAItjKsj+9q8v3zsryKUpQ8RNENg
	TEcxnZ5VnE4klOUOUOCalc4wt7Is5k5v0Q==
X-Google-Smtp-Source: AGHT+IEMxFaxnrrbro/13XEba8it0nKOw4fSOoBmIoFS0mDFLeFIzbh3gRxOeA+TuRWKC15TSAxeqQ==
X-Received: by 2002:a2e:8014:0:b0:2c6:ecf7:16b2 with SMTP id j20-20020a2e8014000000b002c6ecf716b2mr13691141ljg.17.1699385033199;
        Tue, 07 Nov 2023 11:23:53 -0800 (PST)
Received: from localhost.localdomain ([2001:4641:9d1:0:d5c4:1f4:33d2:f6ce])
        by smtp.gmail.com with ESMTPSA id t27-20020a2e8e7b000000b002c6eadfb8b8sm1592317ljk.27.2023.11.07.11.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 11:23:52 -0800 (PST)
From: =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
To: gitgitgadget@gmail.com
Cc: git@vger.kernel.org,
	vdye@github.com,
	=?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
Subject: Re: [PATCH 2/9] for-each-ref: clarify interaction of --omit-empty & --count
Date: Tue,  7 Nov 2023 20:23:26 +0100
Message-Id: <20231107192326.48296-1-oystwa@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <88eba4146cd250fcabfb9ffa9b410ce912a82ce7.1699320362.git.gitgitgadget@gmail.com>
References: <88eba4146cd250fcabfb9ffa9b410ce912a82ce7.1699320362.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Victoria,

Victoria Dye <vdye@github.com> writes:

> Update the 'for-each-ref' builtin documentation to clarify that refs
> "omitted" by --omit-empty are still counted toward the limit specified
> by --count. The use of the term "omit" would otherwise be somewhat
> ambiguous and could incorrectly be construed as excluding empty refs
> entirely (i.e. not counting them towards the total ref count).

I implemented --omit-empty and I completely overlooked --count!

(If I were to do it all over again I probably would have implemented it
so that so-called omitted refs did not count towards the total. It makes
sense to me since e.g.  `git log -3 -- git.c` prints the three most
recent commits that touch git.c regardless of how many commits were
walked in the process.)

This is a good and welcome clarification. 

Acked-by: Øystein Walle <oystwa@gmail.com>
