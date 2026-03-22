Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F140735957
	for <git@vger.kernel.org>; Sun, 22 Mar 2026 14:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774188955; cv=none; b=pqLSKGFXvyLABH+cAcLXLvRa2ZUrosuYxIhM+eUA5zbvrBBHDAZqMT0axc0B9oNd4Cm/y5xFCR/UvIbfRGf7r97eOqpauIo4iYS8rpPsLYX8LfTY7V2waetS7j3dbeIt0Qba93eejqxHap5MwIFvt+Hp12dr92616AJm2KLb+BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774188955; c=relaxed/simple;
	bh=+xaEnDk2kNOtwFtweJz8Nojd6sycfD1bG1EPBvWdvfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b0E+l1R955d8BJEY05kj5Jymxq7b97p4qfzrv7QDlUJVO+L4AyYTZrqlVrCW/a+TmPs+ODIGgw5UHyHAtSJAhPVxJen1wOgnZIwCI7qlB0EuV7jGnwmZnzoQrGyUjXjDb7wl/aXPs89LxWveanPe+qDd73KlphsVb4xOnxPbxv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q/o6HpXq; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/o6HpXq"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-35b9fb3f57eso1528833a91.2
        for <git@vger.kernel.org>; Sun, 22 Mar 2026 07:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774188953; x=1774793753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z/BoaDbpt38WZtii0m4+oyNzk6ZqrGtaEyJEA7ofuvw=;
        b=Q/o6HpXq0yU59MgQ52GNR1bHy7MSX3EGNxJgMWq8K/vPxY5mj3NI9Z6QFiA4/Yqjqu
         162rmNzss75KASNFGw/t9d2pgdxb99qgchAY5gtWTgN1m1fDSGwkBnijNEDT1egOEeZK
         2TVT6/gjwS4wJa2qkENkK1rMgOpUx/PV2C3GwU2hazNfhpWuK//y9z3k2CQVEmCttVL+
         1GJPvxJ5BWvWR3/baPe9LSG6XuJ50EB0jcXC0pzRWMTglj9ktbooJXj6yAV2p6+oK7Zn
         A+MlVxFM+N/WKK/OlD6UhQBWB9TyTorlu4ZegbCjHh6LZmAopMlJMfhoD4O9BQ0my6a0
         HEFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774188953; x=1774793753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z/BoaDbpt38WZtii0m4+oyNzk6ZqrGtaEyJEA7ofuvw=;
        b=jkQ8LwyXCfFcBOlXL5eYV+X7DPn2NXb3VL4FQJSmFItVyU/FBYpT5D/VCKOvH0CRMr
         o/+VgiXi2lF4MK4S1NT4TdBerApWAi/3/VSWSze4iFO8NjQ7xWVd951hV9BpIFWylN4b
         FzI1zGpYsNY7t/vp21sIg2E7FzKyMbjA2nzCAqdO8iZqjok0dCcDTle4PEqjsihvcZIL
         j6Barxh23yNhjiT4jZJKLlwkH0KRrbvr3Kzh60poaZyH5GJvvkQNSNO/OlPAZPfEsyr7
         H7ka2cbXamEUtlobh54pbhH1R/kdC4N2ABUPJ4sHZfdEb7U3tQ2eZWnQmNsVohwJC6Kk
         YIBQ==
X-Gm-Message-State: AOJu0YwfOl0LFej5iisJiBJJke7voY7tU98U5P3Gc304PKvPf9jh4epw
	kXz2p0xsEjR5V1bR+7Qmr/cz/eSSoMDxbPqdYkK/bxiS9OmqSlJA6CCEstTc4Q==
X-Gm-Gg: ATEYQzwn8Rz73NHYVCmF10RWZss9hgfmGowY2lgQGLj/zDTxdT1AxlF08vgvS8tFfsr
	3NANBhuHj/2Sg26LVpOv0pn02Z/91CoMFt4RxV4C5jqdsQ23/ifdSNVfNzvyjcnGUOdRm/ecg8H
	L9derdw8vFr0znwVt93ADprbAhVRD+CnShVYvR49ShGuKcALHkPd4+hy+3LlUMi1OQH15n8xUCk
	JgVjBLbWIHyqo808IBWHqcCEjmyfQSzGIF4GUCR3lWfYaxSuhmjfTnWyLt411m8Q8643sJEjh96
	/1a/gMrmAJh5KRWR7usTtyX8Ez3i0POtzLWNu54xBM62H2z3jMthzYTOmWWnkMAXnrVXz0MtyZy
	4VkalTAu2W69Pzq5BpZI24HTn9Ejtmk5mkfBtzM/ukoRtkpUQajj2KZlCMuit79BFPCx270N2hw
	8gFwK+vLiG1N5NXd12IpOehVevs2JCaY/7D8vTekZw7Bs=
X-Received: by 2002:a17:90a:15d7:b0:35b:e51a:85af with SMTP id 98e67ed59e1d1-35be51a85edmr1739387a91.10.1774188953068;
        Sun, 22 Mar 2026 07:15:53 -0700 (PDT)
Received: from Shreyansh-PC ([2401:4900:88eb:4aec:fd1d:456e:3c01:2798])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bc610c1efsm10306861a91.14.2026.03.22.07.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 07:15:52 -0700 (PDT)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com
Subject: Re: What's cooking in git.git (Mar 2026, #08)
Date: Sun, 22 Mar 2026 19:44:38 +0530
Message-ID: <20260322141517.54890-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <xmqq1phc9x98.fsf@gitster.g>
References: <xmqq1phc9x98.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> - sp/add-patch-with-fewer-the-repository (2026-03-17) 1 commit
>
> * add-patch: use repository instance from add_i_state instead of
>   the_repository
>
> Reduce dependency on `the_repository` in add-patch.c file.
>
> Needs review. source:
> <20260317155230.619378-1-shreyanshpaliwalcmsmn@gmail.com>

Hi,

This still references the earlier version, I have sent a reroll after that.
Though you fixed the conflicts while merging the old version, commit is not
yet replaced <20260318090546.1213077-1-shreyanshpaliwalcmsmn@gmail.com>.

Best,
Shreyansh
