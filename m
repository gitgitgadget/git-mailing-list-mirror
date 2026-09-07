Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CE82264A9
	for <git@vger.kernel.org>; Mon,  7 Sep 2026 16:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788798961; cv=pass; b=Yq7gl4tiQPAQuqH1WLIytOwwD/ZVEgheJRZCjcXkl9KFcj1rRTJi7iIF6u3xKXs+GzVF+cqLYN/OW8Mv+AynTyg1KvKsRS7VrkLJYjzEgm+uemEN56sepTS7IVBrRiJztEDXA8i34eQkE7nbeRrTfy577PByPH4q66HNA5D9Nik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788798961; c=relaxed/simple;
	bh=u6JD0N5WaOcGtaUmtbBbPDZGBv+6+uvaDRwfjn3JLW4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NyFG7hxsFzjI8GA5Aebf5CZFUo6TtrhGtp7pQ1ZzkIYsQCtigKTYPjdrkSRflto/MHr6oW1Eln0/Qt5k6DMowyy+VEhzOmRbgk7xKsxmVfMT4hH4WCjQTXivGjiVpGxRTT5jwUH3duig0/XTaASbPkl/RViU7dbAhp/7gUZ5Pns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=thomasbachem.com; spf=pass smtp.mailfrom=thomasbachem.com; dkim=pass (2048-bit key) header.d=thomasbachem.com header.i=@thomasbachem.com header.b=SzBT4yC0; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=thomasbachem.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thomasbachem.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thomasbachem.com header.i=@thomasbachem.com header.b="SzBT4yC0"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-81ecf499af9so49094447b3.1
        for <git@vger.kernel.org>; Mon, 07 Sep 2026 09:35:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788798958; cv=none;
        d=google.com; s=arc-20260327;
        b=ZDOJSrMjxhmawMPvWkBP/4XVFhGCrha+XhxsoNDqF8EY1wCqwav2WAWvI9YuHpjOcj
         /5M9fyphT911VpKS3Dpm1ayHBUnzqSFhCqS2ymqYYpLUh01eQvbINtsk89vx303TX49i
         gsDRn8T06OwNhdu6bSIukl0u5tkGhHZVIAygKrsLmVH+Ua0eiRI/y1SOZQJq99r+eLzg
         ujsXmdnYMeS7euLH4QH9bnmOObRM6C060lUfYnMp/lN9oqpBMcGRegtmT+Shd2XH67T0
         bcP+CRDAeRWNLyiXOkxcIjAlVAzAHJ6zVETZnj2F2sWb2Ua2NOe9nvZXpIbF6S50LR4f
         j1YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=u6JD0N5WaOcGtaUmtbBbPDZGBv+6+uvaDRwfjn3JLW4=;
        fh=DODnQCqkWDdUbsQb+QVlPbHuCSEyESHAv6/EsgoeJ7A=;
        b=W+/rjD1nBMKGT5r2DTh69bBV/qIZdGjxQ+CMCPurRE8UhUM9CqlWmkPyNPN52kI2tv
         5Qy4K2GLAXasMNN+1SuO1zcQ8O80I6E2AhJPLTQ8hwvD0lfVOdt94gGfVHBXVZko+44C
         oJ2sPlbf870fej3FmmNLaCnUYh8IyB4/zUGsxL3Mmfg+mJR5FrOm9dMByQf80xKdJeyO
         7h3K8Kkc2xzaSC4O8/nnjr17Jj18wtHXlQ5rgbobNkqOXDERVfsdKuUMH1tefzkX8zrC
         cI0SZbtNUVNy/OOed7ZNOLmqlq5CSgO1hkberE+HJ/QZNQpdfWYw4+vSeFgJIOuW0zdx
         61bw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thomasbachem.com; s=google; t=1788798958; x=1789403758; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u6JD0N5WaOcGtaUmtbBbPDZGBv+6+uvaDRwfjn3JLW4=;
        b=SzBT4yC0gVAFpz5QAc+pc7YWDgniU1r8kgRdzD15LzNQxLR76daPt/UbTNDCdd9CQP
         WchjY/EVK6LJFqcofnCITZUrQLcToy7msK/ms/PaGtV6eTB3VazRaTw9dmq3VPb6ZDNY
         Zvaa0yOpGQfdqpOV6RQY20XRIL+c+Of2l08B3n1eLfFHeFokOIg8cJyJ1tpWV1nEY6Jl
         SMbcWDYwoelvrX/O52SLPRt3/8YYIDmcLpphjW+rawKicgUFwmXC5UgmA57M9xv1vJTb
         gOfE3sQrgtHWH78/wpl+zF0kZAy6Pz9guU9QdjLdmIJNomBKfVQzwP4SQ798jW2q2Rrf
         pHZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788798958; x=1789403758;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=u6JD0N5WaOcGtaUmtbBbPDZGBv+6+uvaDRwfjn3JLW4=;
        b=PmMar912+pIYVFDq8hwFis48PBoLJtXmFqFdkXrhR04mIJyJl51cRGi3qOc0OJNREi
         WfM38Wwngy0Ng/7ZnbRzP+Kol+SRrEb2UdsX2CZBmQkombaODkTZGAGJBmquQMWlIED/
         sRTYqOWtr1XijS8koWeZzMUKe3NbHic2mI8hmxMzqCYBaHGsVRoHrCa2KJi8BQuq5YKU
         z+eUS+pSzOiwtJwqWtmf7OicHhq9bdlnihk0FGP002kXuqLe4X6XeOXFPEVIO9gSM86b
         tzca5/+fcu/G/VMI+IdcBWYuuhdXIlhDJAxhFCSHq9OxcDo4376YcmFwktKU57qxlM4v
         YL+Q==
X-Gm-Message-State: AFuF++l4yLgapJWV1NxjsPJzNetHLkX3AMXZULwqDI4f4rMCwldqbU6A
	V6tiDTZedH/eS7XESc3LxqgNhtoY28qtl4tRohCBhuONI0ZjKesovTwMPrtgiy3cPxFVp8tcJ1e
	lnyqGInDnPYZJfX726x/Hu9W14mo2RLbN7lEuc44BxnfL7dK9wU4fiVAf64Gb9yU=
X-Gm-Gg: AYBFou2w2t3tf+fq5Ugepd9MPnU/eUEyHTZZ7Ung9vO08CEHZgu3al57D5qndIweIWT
	i8/ILC0RrVlNgsFGohB1ObdX/RzJInLXxAPt973k/FJ/CM4KNUXmMM0SmnOjsGA6ENvW4dKcWr+
	GRjc1JXZrXYz6b1mkrXkKp085yOCHAKNCSi+9PDnwMPzBOHo7kT7H3BKnaip8Eh1o2a6bqLXcBk
	x+KELVOgDg/T1jGcQTcAr21K9Ktj7URMZRwu253YvfLJmmJTqSiCjCyyhMWrJaoSc0NGxUduLX+
	M9PcGy0G5PY9X/t36FGnhsHaX816jCKRUfbA3BYulH4B9ONPJDaFw1KRLKD8di9yM56rDXQypIH
	9KyM=
X-Received: by 2002:a05:690c:d8a:b0:873:5c7b:c0ef with SMTP id
 00721157ae682-8735c7bc178mr59601187b3.39.1788798958396; Mon, 07 Sep 2026
 09:35:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2217.git.1788508426.gitgitgadget@gmail.com>
 <pull.2217.v2.git.1788537086.gitgitgadget@gmail.com> <9a6fc0427a8bc7e7abcc0518214b1dafc2efaa6a.1788537086.git.gitgitgadget@gmail.com>
 <ap5yWS5tKLej7BjT@pks.im>
In-Reply-To: <ap5yWS5tKLej7BjT@pks.im>
From: Thomas Bachem <mail@thomasbachem.com>
Date: Mon, 7 Sep 2026 18:35:47 +0200
X-Gm-Features: AcwNN1XWEpHnwRF81WOiOkwCqrj_gMQLA9Ecxe2-fFpFreg7voENZ1DXLM9zGTk
Message-ID: <CAA0xjtrherFZZBSeqE8zd6Kbwy_=f9mwiqJK832DzZRakkiwBw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] sequencer: keep auto maintenance out of the
 commands a sequence spawns
To: ps@pks.im
Cc: git@vger.kernel.org, phillip.wood@dunelm.org.uk, gitster@pobox.com, 
	johannes.schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"

Hi Patrick,

On 07/09/2026 10:14, Patrick Steinhardt wrote:
> Why do you set both "maintenance.auto" and "gc.auto"? Setting only the
> former should be sufficient, as maintenance uses git-maintenance(1)
> exclusively nowadays. Sure, it may trigger git-gc(1) internally. But it
> won't ever do so if auto-maintenance is completely disabled.

You're right. prepare_auto_maintenance() looks at gc.auto only when
maintenance.auto is unset, so maintenance.auto alone is enough.
gc.auto=0 would still stop an exec that runs "git gc --auto" itself,
but I don't think we need to guard against that. I'll drop it in v3.

Thanks,
Thomas
