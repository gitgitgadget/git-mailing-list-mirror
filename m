Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6311A5B92
	for <git@vger.kernel.org>; Mon, 23 Jun 2025 02:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750646394; cv=none; b=E7Pg0f02C0iUWcbWynIb4mjM0CJJ8E7G4lywAn3lTst68rFXiFQK6VXgmDn+buxnKbfzWVQGJwhrt4vT42EcRpUfAiGdHIBX8S5AXWtH3RlwQDmHs2QgSgxO3C/TBdF6HJBicpWjlr6Z/JLHA2kr7+NjDO/xywTzT69iSPGixtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750646394; c=relaxed/simple;
	bh=84/NtklIApqkS6s1fnUr0y8M2pW12aOSSWfF9GOx5uk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=XZ+N6ddPml8nZ4cFUSH+O/eyBorT2wCimGPtSDr+7813sFYkDyj+5sBJOcUjOt9Da7FcTrCaBnJmqn0xYhYl5NzLhXMgYZ10rwXhZvR2bvTZp0fk1BjBcUMkhlMTAP7aMkLyC8uTzN5DhS0CdknWAZ/cOKGpMI88HjvVAwrTqyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X0H94u3A; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0H94u3A"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-234bfe37cccso46636615ad.0
        for <git@vger.kernel.org>; Sun, 22 Jun 2025 19:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750646392; x=1751251192; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=84/NtklIApqkS6s1fnUr0y8M2pW12aOSSWfF9GOx5uk=;
        b=X0H94u3Ay+hI3U2jcnt9SFbtc9ZA72Y/vZC68Cpp7DLr6jWELn8EAwbPrsyN7n+bBc
         e5FEiR9c9uXJ5PYib2SrtPSk+Ym7EEjIwsepUswdguYZ/ocklgH6vAtMKkWj0JXrnr5L
         1LaToI7+6UfRBSvp3YpGzi3/D6zdIf0I8V+hXT2uvawfuASFFm1BeLZPehidsdog2x3U
         G8bcYce6eDE5UI4kvuzCbo+k+GvihsMVpyTrVZMTeBmMmp9tIVq8hUs3rwm7AuH6rx1p
         iv/ZMSEOnFc2hKPH8qBU7P+sPUTIv8SkUkflIqHCZF5QCcM7o+k1QY3BR719idOWGLCH
         xPsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750646392; x=1751251192;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=84/NtklIApqkS6s1fnUr0y8M2pW12aOSSWfF9GOx5uk=;
        b=jGT61d4Kesi3Vu+l1PJRZ8TSGEPS13j6qBJKhaUqutDmejj+9HqX95e7H5vUw9KKy5
         BMXCubQso/LuXMiWv5ALYxNs2v7hjDT8dB0fD71fx2j5qM4PsljTgVR3lCkR9GPfP97q
         PMcahjbi3dIrdUnOj7CcyPXgipipOTsc4iRAV4bQaGBMvRnKa8716fAt/dOWXdni9AUe
         SlD/mu5MRUx53zS2Ki17mgcOvOn4IyG1PcDGWSI5qWItAOPA6FcbfQzaxyp8+6zd0HPB
         cferaKgSZi/4sAhQOhx1gZHqkSzeVdNpclyNEQWS2TWE4bOv2mdSsWBofgIpukBi48ty
         hzEA==
X-Gm-Message-State: AOJu0YwrCNbpCAoZNFk5kJaoFEhTOc8RwXDaErrOknyi9ulgWGJkgiUA
	Li5MIf/RVH4T6pkOcMmR1VoMnoxEqe+lk6QH6OIRP2pyg6iEv6bce7Gf
X-Gm-Gg: ASbGncs4Dvbrsnx+yCFCuWYSWqSg7WFnCJOUc9mfXP3N7exAcoUHMYB0K21zv5+YWkB
	weOsXl6j3sJ5328Dj10CRLunF/FWtCSntKJK9EN91wjoH+IWDndDzecD8RXBlleR9e1Npy43Mdn
	1pvH8fkWbKFSGcJI5oC3KR6siEYLjnq+WB80Tmm9Zt5FLM3cix+Ta/HTmZp/8zRqG2f/p2Nz++y
	33D3/DiifSne+vBO+ook81WzgCf6u29jedD7rTHNlj67ltN2rJMFwp6m9L0nTN1AN+zexVaxd7Z
	PoClbKVcSUGGaAYN0fgx/NBjn+SrWHTfnlmVp6alGe+pm8XWb69Z9jCywZXO6tsk70e42Zw6jyC
	luRpVWx000Mcc/bHWOGaNUEY=
X-Google-Smtp-Source: AGHT+IFeyHQGReuZSThRm4yAWWrvzl0ANeRdRxUgWMoqfxrmaTOE8YSNoV1suEWmsCzcD1ygQ3W6yA==
X-Received: by 2002:a17:902:ce85:b0:234:bc4e:4eb8 with SMTP id d9443c01a7336-237d9aaaacbmr161255955ad.46.1750646392164;
        Sun, 22 Jun 2025 19:39:52 -0700 (PDT)
Received: from smtpclient.apple ([191.181.56.196])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d86e2898sm69855565ad.215.2025.06.22.19.39.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Jun 2025 19:39:51 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [GSoC RFC PATCH v2 4/7] repo-info: add the --allow-empty flag
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <CAOLa=ZQXeQX-v2JmKTpaJDLwWWKQSXoMUGbpmD6xx8KpbY91yw@mail.gmail.com>
Date: Sun, 22 Jun 2025 23:39:36 -0300
Cc: git@vger.kernel.org,
 ps@pks.im,
 ben.knoble@gmail.com,
 gitster@pobox.com
Content-Transfer-Encoding: 7bit
Message-Id: <BA2F0A3E-231B-4F0D-9485-912B90DC917F@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250619225751.99699-1-lucasseikioshiro@gmail.com>
 <20250619225751.99699-5-lucasseikioshiro@gmail.com>
 <CAOLa=ZQXeQX-v2JmKTpaJDLwWWKQSXoMUGbpmD6xx8KpbY91yw@mail.gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)


> I still think this is early for this, and we should add this flag later
> if the need arises.

Ok! I'll remove it in the next version.
