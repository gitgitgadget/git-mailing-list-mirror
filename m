Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0242389107
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 09:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773393783; cv=none; b=fXYGJ3PMVEMcAWfFZFO7pZ1yk3xeNZS0qpPIIsy0PSBH8uzgxFqhfVhogMQNBggeZ8NVeRALfTY1/QmrOSdGDqXUiMQ0kDBLHqXzR6zHESjhKJEBpIQ8+ksVFWZv661uHWDXmXhgfLQgvpl5WzLAnbrSNTvwdv+Xe5B8Ptpqxog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773393783; c=relaxed/simple;
	bh=I2eeqTsWxUu2ZdMl7guL+OVMzgAiD2+mAALHPDsyiqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Amche5PpIl0jpcjItY0QHb1VchAX0Sz/WaqTwXjI9KxCfgkNhoVBbEI68tlx9fJAfFLZN8XmRlvejp1wzCznFLstxfdT9eSoGB/+FqooijYG7kYfY731Tj5tDubvdE9DgCTHN4zfLa/OBkn3E3o4rJox0/EBivctLDLmzsZZs9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bmfzz1hI; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bmfzz1hI"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5a142464316so2611689e87.1
        for <git@vger.kernel.org>; Fri, 13 Mar 2026 02:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773393780; x=1773998580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I2eeqTsWxUu2ZdMl7guL+OVMzgAiD2+mAALHPDsyiqE=;
        b=bmfzz1hI1+vs472RPdqMiumTufJOyPbCtvIf/KtKQC+sdF3Bdm4jkhxaItv46OXcTX
         KRhYT+eIT7+LWSlOTn+3DrA+Y4cm3CcaunIOfXt+rtjqHKm7Mct9jiUIbwk/9f99Yb+p
         2KeNm0Hw7XWHz7YyD6ujVth1Uhhl3+/8O57fTRj/LmVyegHlPLEleV47MgS2dzO3IfSl
         QWLitQMSBvzL7XZfHkwGAue5Kupe9EFtFQuE+uNwV+eXJ06I21Zb8UWmSMnqMiOjhff2
         nP85uDVqO0WI1T9AJxcc6E4Z/BhmmtqFlzovPlykkIoalLnnGgOBci/NSms8Lo3fQyZq
         cNTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773393780; x=1773998580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I2eeqTsWxUu2ZdMl7guL+OVMzgAiD2+mAALHPDsyiqE=;
        b=rZucgwOddCxZ21KugetKQ6iu2hwwuycT4aLSwus7dSsSGsZ2W788p4D2nIdztClPQl
         kpaVXUO9Vo4ZnNfrQAVixT4w8VING+fEj9ZkE0IdiJG+/8N3/Svd4RUWdgBtvSv+ZHfO
         SRMoaMq20GZSVwJadTbpK5HgRYOXwOnV9k4LgaNI7CsTzzFNUlMP7hNltZ3kXD2oFbKl
         z02rU/AiABGyfA5xeVvTh2wtwp1h5mo9cLmQkKyDtdv0gq6afsJuJt/a6cVOTFvQNZpb
         TGBTv89bpgA7XxR3AjzBe8gRBS6xUf+KnlODydxIUpRAjTbquje3GkzIxwXb3fpJTEnX
         faVA==
X-Gm-Message-State: AOJu0Yy7l67nJxjhk1gWrlReEkdfYg4w464y0pUf2yominzzn3BC66HK
	4XDJQAOGRX2Ith8MVSdD67bFuhMrqQX+b/mwfLKv53lidbbyaFR7y5+Ka23DEA==
X-Gm-Gg: ATEYQzwOlDOCAuZJ3fAF2QNgkZpaXyZu3WNrRGMyppQqM2iel59J6v0yr+LsXEvMJ2Q
	EfuWx21cQBunkn99ipQ7+oz//SjP+CM8HHozFEgAabKFg92tyxXkUvo4GEFgvRRi6xgxrCxegDr
	EjtjoW+x28rKAwx/ouTsiXHcS443u7qRPcPnmISC9dPWE8Ltq4JHtGJ4qMrPTMhAC2kSphhOoBz
	uTtPOD2nPaXB2xyA3l4u6GMuStuJtaeii5trwij0UTFKFKEQXJtzx9cE0recVH4Vqnh7eGn1qLI
	YPmBhnbpIxRBdScSUUG7n6Az5o3eYAqHjHJb2bW6M+IcRiRWAOxY5i7xvChHXqlEkQ9VuH9iM2h
	WCnsp841PcMQoikQfmsoDkV/61WnzicadcCgNL8kDbHAl40roZ2OJ6GCCn9qhZne5AUEo/zSxRV
	d5igw4mCF4S6P/rkw4DBQKp96BLd5oQtzFI3IkwIgXo4YJyrzQj6DMbIbIQjM8NhgbpIQPIbUko
	KhkeZwCUG3et4BH
X-Received: by 2002:a05:6512:3f0b:b0:5a1:2a4e:99fa with SMTP id 2adb3069b0e04-5a16270b441mr901065e87.17.1773393779668;
        Fri, 13 Mar 2026 02:22:59 -0700 (PDT)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a15636675csm1455210e87.74.2026.03.13.02.22.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 13 Mar 2026 02:22:59 -0700 (PDT)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com
Subject: Re: [PATCH] checkout: add --autostash option for branch switching
Date: Fri, 13 Mar 2026 10:22:58 +0100
Message-ID: <20260313092258.30682-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <xmqqjyvgesjx.fsf@gitster.g>
References: <xmqqjyvgesjx.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> With this, shouldn't "-m" become a synonym for "--autostash"?
> For users of "checkout -m", this is a strictly improved version of
> the same feature, it seems.
>
> Also, "stash" is merely an implementation detail of how we make the
> merge safer, so from end-user's point of view, this feature is more
> like "switch to the other branch, while merging the local changes
> there", so calling it "--merge" or something may be much better than
> calling it "--autostash".

That's an interesting idea and I gave it a shot! I do worry about breaking
the existing '-m' flow because I don't understand its fundamentals.

But tests old seem to be passing (well, they did break and then I fixed the
code to make them pass again), so that's promising. Although hard for me to
say if the old test coverage protects against all possible regressions.

> Other than that, I like the implementation in general.

Thanks for all your support, Junio!


Harald
