Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E39C2A8FE
	for <git@vger.kernel.org>; Thu, 18 Jul 2024 15:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721314857; cv=none; b=HGgN/wd/u7WZGhCJwFdYtqjAgc6dgRHNCNqkeOWfvYJgSC/9BI+Kbea78JD8uhlFbHjPHOxooNcfYzIyTt6D6fEihzml44LRQPQKqtDzlyQ5W6/MAyn3dcVF2y3oYMGgMm/dAqEBOAQux8Jt8+7eEIQ5rwlX6Xr+tlg+/20DAD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721314857; c=relaxed/simple;
	bh=2ZdxFAclreoaIDpiUXNTMJoUW9kw/hqLtWybjDuzCr8=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DGwd76OanWvDoXeVrryvH21NsEOgp9yyqzy+wlLZ/GY1NplYKSiKEYAV9sEgLoV4GH5hflzNUvPbZRalVQFADnyMrfcBsBolWBYV+p2pf/Clq3BaPQUvG7IIwtllQnPgdJiqcT7VxCCYSd+fzfkek8Y1B9nk+lz1AC3yTzMlYyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R0tO6/of; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0tO6/of"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-44931f038f9so3134841cf.0
        for <git@vger.kernel.org>; Thu, 18 Jul 2024 08:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721314855; x=1721919655; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q60xaYnmefnh49stVGdkylQh64wriSUDoKixeJJiafM=;
        b=R0tO6/ofZuo8ONCAznD718acGZ8Q+LvMO15bR7dDG54reU34w6DU3wV0G9lkpxCW+W
         ngEP4ZZH7GKUUhHtTKpoZiZ1gn6D1fDAsvdt5nNfOu2ydg2aX1Ah3E7kbOTeD3upSbky
         8bHvE/TdDW2DES3AHrNDhC7iNQzQRAhV21sb/Gt9P3SynQLDTxo7XnZvv77Me6NNOJsl
         HWWSW5iFu8iNgFCupYtSlM6abkVMOmlqnyhRQD+nbVcs7C7HUETqHfMrlGw/APatdip1
         hM9rGA05RJ4Tk2CPrUpiI46Uz4WF4W9BSFQ/4C56XSp8nztMfD4WJWjP94apUdlnOGLC
         i+uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721314855; x=1721919655;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q60xaYnmefnh49stVGdkylQh64wriSUDoKixeJJiafM=;
        b=Tx7RaOdBGKjp+q1R2wvmf0J1AL63RLy2vuKuDewjZSvjaXNwHmxSHt2v6Jn3icIjeA
         2Jc4bEhvIu4sX6kq0+ghp+qd1uqzMHZXNwzGM5TPvGBpSwtG/4k9bV51cE1M3rPQxfeq
         dYpmRq/Ij6VI4NHqGsUQ9t5dq39yFds6MGT0ndxag6EwTf0D+mWpTrHHAqPDR43YzDu2
         pEg1ojvBtXS1aKRwIwJXHFchYhy85WZlxGa0vp5XLMCkTFerQUVw9ES6kkzhzMjZX2mk
         U7QKYuU3ONTqARix2fgO4CNTqy3uIu+h9FkRiGyB3BUxJDdFx35gifOCfso8u+MwyOrC
         R80Q==
X-Forwarded-Encrypted: i=1; AJvYcCXFQYluXs1dumq3tjYNpyrrRNPUNNjKqlzkIZBt98pXa8glu1o8mh9lQT5M1KtUVnGNn8tcgbmUODDpKbSv+vS85IbQ
X-Gm-Message-State: AOJu0YxyYbGBb6FaERaboG2606zBWtYyceVpHOYM7+Slo3mmXdEwRALF
	RfILeTGJT3m+f1s/LRtPIoTMciDm2u0KlrJdtwhMrFQlpm3IDSh12PUzUQ==
X-Google-Smtp-Source: AGHT+IHD6Emiemr21e0WHSNdBFZeOuaTcW2TFVDsU9NcFSN/q9TyJANNs45VpLlxj2/fTHcr2gVf5g==
X-Received: by 2002:a05:6214:e83:b0:6b5:80de:987f with SMTP id 6a1803df08f44-6b79cfcb10fmr57541036d6.3.1721314854760;
        Thu, 18 Jul 2024 08:00:54 -0700 (PDT)
Received: from sundial ([2607:fea8:8440:1ce9:d250:99ff:fede:8e08])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b79c51bc9csm8731146d6.65.2024.07.18.08.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 08:00:54 -0700 (PDT)
From: Ben Zanin <bzanin@gmail.com>
To: Mike Lodispoto <mike@lodispoto.com>, git@vger.kernel.org
Subject: Re: Shared bare repository dubious ownership error after 2.40.1-r0
In-Reply-To: <dd703bdc-f485-4162-92a5-fd2828b69604@lodispoto.com> (Mike
	Lodispoto's message of "Wed, 10 Jul 2024 18:16:50 -0500")
References: <dd703bdc-f485-4162-92a5-fd2828b69604@lodispoto.com>
Date: Thu, 18 Jul 2024 11:00:53 -0400
Message-ID: <87wmliycbe.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Mike,

It's a long thread that began with the proposal for a new feature, but
there is some valuable discussion midway down about mitigations that are
already in place for the symptom you're describing, and some good
analysis about the tradeoffs of exercising each one:

https://lore.kernel.org/git/20240626123358.420292-1-flo@geekplace.eu/t/

-- 
	Ben
