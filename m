Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51A22ED855
	for <git@vger.kernel.org>; Thu, 11 Sep 2025 22:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757631252; cv=none; b=uxCq/0mot5iv63S5VexbMJSi3Z7fC4n0reXSpotkQjf+AioYCKwV66FogoGjwLBGSa4gDPGAT8z/bKt61byfB2nyApcR474VF1E4xCQSESgyluvlxiB6YzG2r8zzu/Jf4FnhxT1wupq5DiQg5KxoRl5fQr+TpHYF6aZ2HVYl18A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757631252; c=relaxed/simple;
	bh=0lIaLDLTL2B9Vszfj2z+CECaoedE0BYJCpij4/bTVRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZNsMgYYyQ49DF3/Unnn24Ktb+nmCxJS/sA+9BWUJ9cq6rgVyzgs25Yv0Sz+8VhdRIAiVR0qkSsH6q1Q3FB9Vcbc4aoKQC2+fNqUms7ozwaj6HfoLsiwBO6e5I+syhdUEuMw2s116KoZFyiIZcJW46U7Ka45X/mapqNo6UdxXze4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=SHQFEn8X; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="SHQFEn8X"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-60f476e97f1so445092d50.2
        for <git@vger.kernel.org>; Thu, 11 Sep 2025 15:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1757631250; x=1758236050; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9SXSyrnZJ9rXyI1dA1wGk2FXhok6DCxLI/mJbLbctJ4=;
        b=SHQFEn8XxWhEvpyKu+XkhR6e2g45ibUydfG9ogn7MSjgWvCBN3gDLMvOLkc5wsWmqo
         WKSr7tPhj71FzRkRZiI7fhvcLzb9M0Y3r986nkqSAoXMAPVJkzWL+WcizkqAbwrs0Sp5
         Arsy/pyc9q3kLOwrVY9t2st/wodSTKDJT/Nx3lmgj8NXLSlry4U4nSEb0Hn9KeBjQLhI
         hfXhTZ00n1YUd6URHfNYv/vQJVFBKLMI6r7rJ9lOB41V+7nSGHQXyRC1WgdrEA69WuMu
         ozFqxcCrRGA4T0SsO1Qm/e6AiN3CgtCmguasPJFGhDuUSelwr3/Z6MoX3pGsU9LkmTUL
         OXZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757631250; x=1758236050;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9SXSyrnZJ9rXyI1dA1wGk2FXhok6DCxLI/mJbLbctJ4=;
        b=Qzkh7G2wPqEDvC6Fr3iZ2rxPeQoQHNTLv+0pGpaWbF5ku+nZD4ZIJRPgcqwbvS1r8o
         JpFVOoOaNekjSjRLorH1KAGFcEXmX4Wt0m3UwUB6Vp04rPVVdgOLUzqdqh3kFBEAV8Wz
         4aF8dPSibnLWL6ux9+BaGMYtwKdtg8WBsl+/0vB54OHLvpsxCZ5if+WmvYiEE+rMTYw6
         dS6Ga0CJX2ZgjimyT9qq0RmCXyBG7wk1S3OGxxV4b46obvGnynwq0KFxzgtZCP9zxjxp
         xCMxPIKuzecsLbzGWS9Y40XN9yVguvqmpbc3hcbbZbsQg9b0od+MORuhqdo5S8E1qMZ+
         daqw==
X-Gm-Message-State: AOJu0YxiHSOUMpjowzrVFHGwXApnbFf5L+KzI3lPMwYaQtlcImvdPaQF
	AEYBDOX+0ogIXuASL2vFcNLk9366iWajl4ss9623tLRroq3E00bpeZyWsBuAlbCcyxZDGBqdOnE
	b+zzi
X-Gm-Gg: ASbGncvUfAfcIxy6QW+U9WDIaGipqW+q5qExV+AmHs0sOPHZZZkBvR8M71ckTDX5o0+
	T6Dpvf2V96Ra3CL6DlNNt4c61wEpYJz98OyrWfySFjcWMH+l3cXSup/XdMtZEIePt1OBwZBeH52
	IFJZ44FOg9a80+cx3RWuLGoqEyHJ39FQ2tIYN65CoRTTIOW1DUAKmUCzHi+JPcynO2IaBJYk/xm
	1DL7ibyCjrOuhj2A7Cdy5/eo+FByE8JHQS2HynWnS4REGYYx1kinzNgpLLvoTh7eh4u0zgn4AdC
	0cCh20+bj8L2J2SWRhHopeU1aCeQ1u3C6CVOiEnslRusIKUlNYlybXwJ9q7hu/+jIg6Tfl0KGjN
	rF11NYJlnui/gUBCEDNHKC+NomYTBMFCh/z8oii/DdvPCCAq7+QmejgAf3WFrCTDYM1ayU4rgtK
	Y+RTdXeg+EckBvFBhYvSypHvGkNTY9eCDcCS6C
X-Google-Smtp-Source: AGHT+IG5ZkD886dNU/HUva4i/mg//ABdvNCHqZcDSyn5xpjajI8/GgCphjTcqKDH5tzMV0QFirkYBw==
X-Received: by 2002:a53:dc82:0:b0:600:f59f:7829 with SMTP id 956f58d0204a3-6272453e747mr849898d50.38.1757631249768;
        Thu, 11 Sep 2025 15:54:09 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-72f791a35bcsm6658927b3.39.2025.09.11.15.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 15:54:09 -0700 (PDT)
Date: Thu, 11 Sep 2025 18:54:08 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/6] commit-graph: return commit graph from
 `repo_find_commit_pos_in_graph()`
Message-ID: <aMNTELw0Wk8jWoPc@nand.local>
References: <20250904-b4-pks-commit-graph-via-source-v1-0-d932c2481e1a@pks.im>
 <20250904-b4-pks-commit-graph-via-source-v1-4-d932c2481e1a@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250904-b4-pks-commit-graph-via-source-v1-4-d932c2481e1a@pks.im>

On Thu, Sep 04, 2025 at 02:49:58PM +0200, Patrick Steinhardt wrote:
> ---
>  bloom.c        |  8 +++++---
>  commit-graph.c | 18 ++++++++++++------
>  commit-graph.h | 12 ++++++------
>  3 files changed, 23 insertions(+), 15 deletions(-)

All makes sense and looks good to me.

Thanks,
Taylor
