Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630F316DEA3
	for <git@vger.kernel.org>; Wed, 12 Jun 2024 09:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718186282; cv=none; b=b4WJO748+ue6ijvALE6B4WrPtdh3gqWIBr9/UPKZ1l7+dRd9qPJj9qWWbnusaeWwJ3Tv19JhnEjm8qeiSgsZMiiaLPXiYOXU1fNQrg0+4LZpg2O7Fmuec7WX3XCI+RhPJ2pC0zoxs2NB/HP50GD8Sk7TERb3vNPxBw5yswMjK4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718186282; c=relaxed/simple;
	bh=U6diZwxMqbE/jx6mrXvjEdMcFOBT6f3rGhyuRGylgOA=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Aei8WUjRIm+yrZRSnUCkLN3UkWDfNAzuRe1ltYwgA3/d3/MxAas8p3KxNUm9HkZx2FcHWVUqUjhkqEMMwyONBepbMJvuIBiA94CdeQyNIiQiEPl5pP26JuWO7TWpkTPCV5mnZ7Gfg8sYiCCk6rCR/kXBaOFhakLC95loBTnH2uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NyVaUd7Y; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NyVaUd7Y"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52c8ddc2b29so2564518e87.3
        for <git@vger.kernel.org>; Wed, 12 Jun 2024 02:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718186279; x=1718791079; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U6diZwxMqbE/jx6mrXvjEdMcFOBT6f3rGhyuRGylgOA=;
        b=NyVaUd7YM6ALvThBdSa9MQbsn53pKeqJ52PfFTsr+KbjoPlrOvpXfqdHGHgsGOvC0e
         iwlK33k1gtpNa3rWkru3xa9U9zuAE35694S1s+Wqth3ldBimZS1vbdJMGX9ZNWwBRYMC
         8XxNR8Oz/QoXL4wjypwG2EPOT/UcNMKH0RXhmS6D6W+EcgKKI5UXM//NAQSx5eH0dfKJ
         5+Jl7Y+JKyEPT8+1Ln2YxpditxQ/5uV1NDTw7gD/qhdC0f540hhB7uPekjvQlK4MPdVf
         DGn4YtmqzczpjLPJpJ6WJGVdHEMnl+jL8pER8FEgAnsnHc7SmBqvrCMgnzhkwb3iqWTa
         59PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718186279; x=1718791079;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U6diZwxMqbE/jx6mrXvjEdMcFOBT6f3rGhyuRGylgOA=;
        b=KjHnDgAGV96xOgFaRgrDgsgz/t2FUb0bz5Vl9NWZqjomxIAZp9WV9NvI2YlABPXu9h
         Le/a1AueykcKMrK57I9wLtxll0YDtkkqdrCQ/WXA9APKPqxI+QjDC1I3b35FOKHMfWr6
         6UiUbI+jbFJpAU555AEZWND/AYVRUIlOoyZdGfTjZQjNzCQ8xbkjcajJYv3KBU+xY1LL
         QNzTcCHrzg658va9kuBYADyI1VBq/6oerhzrCJHJ7DTkqKS83LOql/Mo4PYVw1SD7N8f
         ROD121GSCCftYEi+nvdj3kRJXbraCVjKV4ZK6JfgXDY2Ic+AZVHrube2eYI9agazq9FL
         pbvQ==
X-Gm-Message-State: AOJu0YxiMtn+aPBd/HykSwqHFaHzh9CrongfvcoOKf9AYIy7nu0jyj7V
	4O/+JV6Xjuf9VWI7jJnxpf5nu4lRqlD42bE2GK/sTPdUeQkpfxrCFjea
X-Google-Smtp-Source: AGHT+IF+qAfu+RaGvpn0ehiLRMMnUf/s+wg2s6ED1bD28KQqRte1+PpLUs+dv84eQ6M8qppUBIeKzw==
X-Received: by 2002:a19:381d:0:b0:52c:84a2:d848 with SMTP id 2adb3069b0e04-52c9a40548amr949943e87.65.1718186279169;
        Wed, 12 Jun 2024 02:57:59 -0700 (PDT)
Received: from sync2 ([54.38.42.223])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422874de68asm19965885e9.29.2024.06.12.02.57.58
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 02:57:58 -0700 (PDT)
Date: Wed, 12 Jun 2024 09:57:58 +0000
From: Arnaud Morin <arnaud.morin@gmail.com>
To: git@vger.kernel.org
Subject: rebase with record-origin
Message-ID: <20240612095758.ivfw5b2koo63g2ak@sync2>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hello folks,

I rely a lot on git cherry-pick -x option (the one which record the
original commit ; a.k.a cherry picked from commit ...).

Is there any way to also have this line added when we do a rebase (-i)?

I did check in code and found options.record-origin but it seems not
documented / unusable.

Is there any way to enable this?

Cheers,
Arnaud
