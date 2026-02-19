Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A351B2D6E55
	for <git@vger.kernel.org>; Thu, 19 Feb 2026 18:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771525071; cv=none; b=Vd2SVcgGu751ONJhNTcXkOBTE0leIuklKJuQlQzIOZSzbIepdhG0+5hAW8VpumphMoMsBKr9TIWVGvg4Bswk0glnv414EUzqZ0zzRp5J+1qXql2pFyK/00HXMlzBVxXgeiLUp0UwovtKi/c200cWFjJoViskH/CXWhWJDUxKUfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771525071; c=relaxed/simple;
	bh=NzbWl+Jld3j7o8RnrAKDn6SJ7nJEcDYkrO/iO3Z6W/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hblobrOMKlIRVl/N0t2FhPBeF3LnAclMs//jSxAwvlryCJhK+YZCiLHrLTumwtPcaDDAudmufLn8phRIejms2S6/Uf/7+ROUXVSZ7A8DpSUPH6PNsZzGNzhe/hfZC4AQkO9rhwFJxz7uUfBsVBpkiTYMr3It/fip1geE2F1gmfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lt4TVOfu; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lt4TVOfu"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2aaecf9c325so8323225ad.1
        for <git@vger.kernel.org>; Thu, 19 Feb 2026 10:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771525070; x=1772129870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NzbWl+Jld3j7o8RnrAKDn6SJ7nJEcDYkrO/iO3Z6W/Y=;
        b=lt4TVOfuSpPjc+fPAu/WVH5l6Hh6b18ZxZR8EGCbS4G1/5r4rgYWyb9t5cCKPENy12
         p/YUfZsIjLxlrtMWHGOJyQbbSYThdDfglOQXcQpu6IMxBphv19Sb700k1pY4a5uAxYoU
         GuvNF/9coNjb5GP3a/if4jLxiLQu//I7ynmdBHvSAza/5V6ofhsSxWBFb1JXLBUhaX5e
         ggTKlwB6k1yZIAWr50SpHDnmB2hqdmNIqFoK6+SxLw7bcNqoEwkynTjr5JnMEL0FglM1
         r05NdZHE+yNbonHOQ66ev6VPPKu9wa27aRqKa1eviiKQUM4jdOZ0cdZAmxRo7Bym4Zhn
         7kxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771525070; x=1772129870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NzbWl+Jld3j7o8RnrAKDn6SJ7nJEcDYkrO/iO3Z6W/Y=;
        b=rdEN3k7IAOIoT6kRcN9oH0z2ZxpWmYewueMezDiEqT/EWgUWDFU+BaMUgFd/j+TEds
         WFmsISjAkvzcJJLoAS0cTDX0Ty7ibsUyZfqPwW7YuqPUupmUO35Ki3uGEnnDU6vu4wNP
         9UdlmC5UU78ymb07pAbeP0zVO90ypG6mn4oq8nbkrBJnY+9io44qVvRVtRQ58qu7GrkU
         zldSmF8AP06AV13SYLdun31vZsxKBmhFdi+UDzoSyptFVubGj5R848d/igFGPqLcAVMr
         nyr/Ee0Ox1KQPIzLZ6VXbgw9OJ36xi6zUYBo97nUd3rWiilLGpHl/C4Fouu/gAbSZuvB
         9vug==
X-Gm-Message-State: AOJu0YzK+D6W3UcdVLUg4hce6KuOhOhO6LQb9DDSaLeSPHSNjKlMb2eA
	3DoUEmuxOssjdloBaeddWHPoH/Q/K2yezEI5iLg7ScKdxooRBmUXCOImCTAauw==
X-Gm-Gg: AZuq6aKYf3FDtZtdjzewihRspLutyLBg4/dMSMCRTROM3j1ITNaIaJCRMWNtyvKqVJp
	x6MCTlD2iESEmjxByj6DLkqTFmUZhYvISdfQE+UvyntQbs1o5zI4gCBWZtLobmY+PWLQHBykph4
	eFGCQMXuwiKUw4JmRDNYoZBMXEFFWeAouomrXj+0aA9vB7o2ZKDOdwQ5kGwitGx385ZJCUMi15o
	Pe2sM6Gr9uKhcLVutJrScf6GuPSheD+brdJ2XwjIh623w6nRzYZ8dvcsFx4Gjf9xj/XXUYEJz1B
	mWIE16NRofIUom3vX4v45zr6WBOZHAvuHXsrDRQe+pvpKcTVQVQ0qmpQT/3p1pKpOutcpUY11dc
	tIe7Orn5u8ne0YZg5ridbpspduTXzd1OUZZpIoAJHHxEaPNFYesS8nLJbqDuRH5ZYsaNKEloSLq
	cupU0gceiztf7ghUzfsyDsOU+FNh2PyH4tLiID7sNnMuoWAElC8zz646nTd9k=
X-Received: by 2002:a17:903:2f45:b0:2aa:dad4:dfa2 with SMTP id d9443c01a7336-2ad5f78e87emr26859035ad.18.1771525069737;
        Thu, 19 Feb 2026 10:17:49 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:1cd6:375b:d059:98ee:c623:cf0b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e53328f3asm15886342a12.30.2026.02.19.10.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 10:17:49 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	christian.couder@gmail.com,
	karthik.188@gmail.com,
	jltobler@gmail.com,
	ayu.chandekar@gmail.com,
	siddharthasthana31@gmail.com,
	lucasseikioshiro@gmail.com
Subject: Re: [GSOC] Discuss: Refactoring in order to reduce global state
Date: Thu, 19 Feb 2026 23:47:05 +0530
Message-ID: <20260219181736.71467-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260219181154.66814-1-shreyanshpaliwalcmsmn@gmail.com>
References: <20260219181154.66814-1-shreyanshpaliwalcmsmn@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I think there was an issue with git send-email that is why the subject
line seems malformed. Please ignore that.


