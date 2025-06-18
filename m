Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8125D3085B5
	for <git@vger.kernel.org>; Wed, 18 Jun 2025 18:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750271510; cv=none; b=q9U1BruX7S+j++tk42h+MmXlvjF5rhf0oRUWoUapnN2Ie76lPfnEFyk0lIiNYh2m6lNCAD9ygxXdSCGN2jOBhKF3EIU8FkIX49twzGrCwon6Ar/zH9zLiPOvsx+0EdagbDyRo0Fp8HHj4gCJ7nYaFLKz/qfQlH7jKiPTHMUjlM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750271510; c=relaxed/simple;
	bh=JW4G/lNnzS394rqf6TIYnyCrt1aAJgIymmxRGGCxdxo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EtG5Cdew3ElwOJoUTTM1EF6FNQ7fE7jaLqflo67928V/qmzrLqOkG89GKt5skLEIIL+vIjcGEbrCPgiEsog/Z8LLugBgiH8e89Wg2ewkAIdvn8LC2q2kMYDfRf9vJ4CAN4CNPJWdT5MARf8Mk81bFZc3F8lXCAae8LCyBpP6NN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G6+C04Nv; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6+C04Nv"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-311d5fdf1f0so6899710a91.1
        for <git@vger.kernel.org>; Wed, 18 Jun 2025 11:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750271509; x=1750876309; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hJJk+JkGEEzdubz6O83rcbNUmhZH/wYQjpVPxC26qQs=;
        b=G6+C04NvxUijYpZs5zZQvYRnNP2HkUXzZ8SZazVbiQMnBi7CkqutJg74XLdB94//UH
         AbKzJ2Y0BBzrucuEOOoSniM3ccEfJnfh8gwYSuCIOV7jwA+UYqgz/LXrO5WOGYx+aUE0
         KoMaGuTHEvRneyZC6cGYc2pq8aq44m8c0x69Otyw6XYDqE9aof3rRHnONvO7mx4Mq2e7
         IwYoN5l7Zt5PJrqw5LMMmD5/By7+1ej+JJL49Q+eUFvVtBHsYgNNGZuKsK5W0Wn1NL35
         rbUPDs532OKrCVbXyVHT3pfZKZWpp6RG92ClVRpV6ib9CQdAD8ulJTxvoxLkOMrzZ0ME
         8HCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750271509; x=1750876309;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hJJk+JkGEEzdubz6O83rcbNUmhZH/wYQjpVPxC26qQs=;
        b=SIr840rvG/QXBAegF5Z0KEMBd5/XTtyMhCNfeEqVfbgWyaXqGJowtspgn+XMQKlgpc
         QlVwZXhq5m07pMZW/pwMegmF2xMMEKFop1JwEKhlfGcfwmU8Z339ZZMasyMbMvbOzEd0
         2bCvdVP9l1SvAgWkk1tJqQPzL3cgHD7QOavb5uGHvhPO39qUl9kP8NQr5zFEsXF1prZl
         nCpEsmhiWuxI7mVa7jvox8g7p6zmAstZ3OXK2Qq/8mDbODs8OWGg0F/P9sKGEebD1PWJ
         DfAE+1u6dmK3Ct3CtJ27m1IDyOopibkHAoiYl5s4OzNatRVlh31O/JirB6fL0AUME5AB
         Q4Kg==
X-Gm-Message-State: AOJu0Yz2X5QO5Fs3BZH2gAJbyIRiQA3Y6PPdOKt//gavMYA4hZc8dYbp
	Pmb12rdqZ8oOQ4FmlwYEqqWDCoHU7GK2ADU/oIVaPRwK9pzFueX7bFee
X-Gm-Gg: ASbGncsM1bGxa4oYx8FZ7Z9IfM518UdwPJM7tbnxX2oP2Sf8nrjpBdBPNuKYKySB1y3
	Nk0InW5uUV3b0/0k5BU50CMtDbz8LaGUjX4S+RUjldt0wImf5p6gQU+CJ1gb6pluo1PNO0T95gx
	jmMJSNp/A9b5IUUwjFVFcSoxmRg/TLGQGXXDHv4uvp2WSh5ffYjr3dc2iwyRs0kgdP0b/6fHWM5
	pUROzxtpHIdNUGWqYHVGgEnNSU9CQBC+qVTJSYcfjyYssagYmyjjDQ3+qemeC8ImlQzXG5N2s6r
	UplIhcAangBl/BbZqzP7jxnPkVSptG3UIKY5BmLhdthvZPUd7P0atA==
X-Google-Smtp-Source: AGHT+IEyK+b7TlxZmpXoYjXVN0eeIjLNc8qHYXfcXuftpAZP/nArmIexzSPh7Pu+Nts7ST3eUcxuOg==
X-Received: by 2002:a17:90b:2d48:b0:311:abba:53c9 with SMTP id 98e67ed59e1d1-313f1ca126fmr30130170a91.7.1750271508737;
        Wed, 18 Jun 2025 11:31:48 -0700 (PDT)
Received: from fedora ([2601:646:8081:3770::de7b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365dea8ccbsm103725515ad.167.2025.06.18.11.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 11:31:48 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org,  Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?=
 <carenas@gmail.com>,
  Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] cocci: do not directly access the .d_type member in
 struct dirent
In-Reply-To: <xmqq4iwcgbzb.fsf@gitster.g>
References: <xmqqbjqlexzd.fsf@gitster.g> <xmqq4iwcgbzb.fsf@gitster.g>
Date: Wed, 18 Jun 2025 11:31:47 -0700
Message-ID: <87ldposxyk.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> In "struct dirent", the presence of the .d_type member should not be
> assumed and the code should instead use DTYPE() macro, with possibly
> a fallback check to determine the type of the file.
>
> Add a rule to catch direct access to the .d_type member and use
> DTYPE() macro instead, except in the emulation code paths that work
> on platforms that do have the member.  This is probably not sufficient
> to notice the lack of necessary fallback code.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

This change looks good to me. Atleast it will catch code that fails to
build on niche platforms, even if it cannot validate existing backup
code.

Reviewed-by: Collin Funk <collin.funk1@gmail.com>

Your fix for the 'git diff --no-index' looks correct [1]. I'll build libcurl
on an AIX machine I have access to in order to test (not an
administrator on it).

Collin

[1] https://lore.kernel.org/git/xmqqwm98ewsd.fsf@gitster.g/T/#m4fc1f0ddf1730ffb025e37d523035bd9f6cddfae
