Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2541535A92C
	for <git@vger.kernel.org>; Wed, 17 Dec 2025 14:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765982855; cv=none; b=m6g5bA57jd9k/t7QvxH/SIIb51yoDvETSBlgbAxND70HbUetQcmR/IhwhXAf6nA3bwCZLlcicuH+putXvISCXdofNqjcyIs9U2bwK65ajS7t5vyzSXI58VZxDHa8xYIvOyXHgiUVzICEjLsoswYK7L+IRoyoi0R6Wlhtdnz0QVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765982855; c=relaxed/simple;
	bh=vOl+A+eBjj9VHwIP96x3MhBZ2iwkcua6g7ezdfzB1o0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=T8hXY6D0mpV6Ch1DacktQDT3fzCXBWpdF+ZW1PN/QsrOcXux36GqnAZ2TOUiyLoqCs3AZt0h2528L+PIBRg7mF/DlDiuKvQKKz4gWIWNJk+cviUXyT9BB/TpSJ+g4Qz/24SafaKz6FWRkJ2EnpN5LjScGZN68WcV++O3HON94pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nc8Kz+3B; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nc8Kz+3B"
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-42fbc305914so3823362f8f.0
        for <git@vger.kernel.org>; Wed, 17 Dec 2025 06:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765982852; x=1766587652; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N1SuxeISphEZv7hErQ8b0Bng64hHupseYnd8MsJR2Zs=;
        b=Nc8Kz+3BX+3uha5HjeUUQTEechvFmhZq2sEHV8rA/dgjR61ghaJqPSE6Ya8BDSA8Al
         nDSEotdNRlHIu/0jQnlqMtDjqtkacMcioDzXXOlOHPwdOnE9rdQ+z4bkurtv1Ddm3eL0
         KOVu/KKoMkVYM+djr241MgqWe9BTGS2dfpA2CyQJav8nvkaowawBFIMH/ExMa0jxYMld
         iZ2sBVM+gtDhSuHu8uNIpo1PjvVCt0PQ7pd3NsGmQmZdda36i8tXdQP1nS0HbMs+lhPA
         opOxIXdYXdghRlBGHOhh55Dpit8HpFKnDF5cqH6w6libk4+rXdmRlr9toTFmPUIb/h6v
         +sBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765982852; x=1766587652;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N1SuxeISphEZv7hErQ8b0Bng64hHupseYnd8MsJR2Zs=;
        b=HvEJZln1nv+s5yv1YbB5+iO1jFjImvFKIcZvz/4TJ4rnKwFsCmIDdfemJHlkLDOuw8
         Ef5p28lh1Per8IiqTx1vsKfHuIllETys6t/Uzpf+Lx5VGW80XGAaMzAXSl5IGNNAzzqh
         5a67Xv9F0/yd9F6n+VIW2AeRzyaygluB82Py47CD4/58X1hh4D/JY/Nl6mJP6jYLEwzI
         Ndt8gkdAD9XIRxE8xoZH492TSY+TIFr8QcT6OPpwqFGSfrY0ppjZZ4pkk2nshn7g+iNK
         iIAwV3/qk/21cpnTONdjsUvfHXe1CnXA1+bZYZ/N05ceUxetWGpvt9gA/VqMj0bFgAtz
         wXjw==
X-Gm-Message-State: AOJu0YyQf6HRp+9A5JuEXkqdYy2/qRMMG9nYqtgU+6BFpvVddcs+yTUd
	4nrcQd0juDmvBO0mZNXCFnXbXPE6JqIgNQ3/1qH5DeFayAVtQV9qY+wzzdeAPnl8
X-Gm-Gg: AY/fxX4poH4WjH16aPJwV5kzFbhCHRQb5swVadI72YPnYsmegsQuzdK8JrvcwxFx9iz
	r9Gb1fQYrA8Ftj0lg9+txlOqN6ux56AEVLyDLAblLPG8/RK5WtRlOJIgD1p6gyMgokVj15VI3JG
	vOzc/5j2M59Hl/iFPwT9y2UH9jR8sLabgzIsGa7kQ4iLhCMOHM7Zo1VH+YlVB3G5mcdvMhYViLe
	WWe1mCEFfb/jfLshSR5RmNNqoTVMHMEvVxNhGmsBagUWJsHowMmhmq22/qmP9HRXVvOoTxphDGM
	m0CQwW5xM/6uJNQMXPSgW08ddFzv33LFKWMGf3nKgBDY9Hdt1X3XPQI/wMA0QdiQ9I1jLV+B0cW
	J+pf5G9ehuS2uKSbK4ouaNbKeO1m+hSGdTeIicViBj4VdAlz7lEqXkM/9a81EznGxD+MUkpY7mh
	5wHgTtFGugyxGQ8TILgSJb935SzJX5SKmLoLTAB+YABEnWfIggoSU0UqiTgfkyirrxGw==
X-Google-Smtp-Source: AGHT+IFKhTRVolbfV9yM/z6hepAAyO7RigvOmeocd5bHlDoZ4KFQUqHlMgJmoYNScSNJZ5IM4C4uUQ==
X-Received: by 2002:a5d:584e:0:b0:431:327:5dcc with SMTP id ffacd0b85a97d-43103276018mr7926332f8f.43.1765982852303;
        Wed, 17 Dec 2025 06:47:32 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5? ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4310adf6fc1sm4681101f8f.40.2025.12.17.06.47.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Dec 2025 06:47:31 -0800 (PST)
Message-ID: <fe18c90c-ec6a-42e4-a6e6-30623482d7f7@gmail.com>
Date: Wed, 17 Dec 2025 14:47:31 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3] replay: drop commits that become empty
To: Elijah Newren <newren@gmail.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: git@vger.kernel.org
References: <8a2a1215306452147cc7b803530ab2429bf57f15.1764260150.git.phillip.wood@dunelm.org.uk>
 <73ba74b8a2e7aaa625e6f0689a9f900ceebaaa03.1765894781.git.phillip.wood@dunelm.org.uk>
 <CABPp-BHH2NaLc9tFmO1hKcY4O6jZJU05+65viR1T_yBaarCwrA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CABPp-BHH2NaLc9tFmO1hKcY4O6jZJU05+65viR1T_yBaarCwrA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/12/2025 16:36, Elijah Newren wrote:
> 
> I'm also curious if you are keeping the "--only" in the testcase
> intentionally, or overlooked that part of Junio's feedback.

Oh, well spotted I'd forgotten to reply to that, thanks for pointing it out

Thanks

Phillip

