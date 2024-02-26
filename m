Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87F512F388
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 18:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708971252; cv=none; b=EQf4M9r9eJMXPPmIBzpN6Mc8odf+hp2k4JGu6wQBSAN3v0JJPkaKGcuGLSQ6nmoTFJlx/vbkg9qMOsjbwziEZUNqlKgMFFvIaIWeYdSnYvmMUijv0Pckt8Su7nC4iB21iIkdozBx3DhAvXzTQmE0ZJSQH0uuAhjS/HVuCKNSOQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708971252; c=relaxed/simple;
	bh=rF0OO2hjvkW6bAJIPNmwQ8x+C66NyDk5HvrubyJetIc=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=cG9y9aWYj0vbj7A2mTCfncNlrQpZDmzMmDeL0FXTZ50jWY7EIVi5WsuJ6XHknHDHv2ppw3OXEaCksRYVdRnjG5lKfeJ70REbTKFyFi1AoX0zO9hrw9Q5PFKexg6vNq+8tn6yVY69CvQXfQioM3tLVt18Tk7Cm+ktAxVQpJmtyH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fKPQf3j+; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fKPQf3j+"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-21fd5eb7161so1299881fac.0
        for <git@vger.kernel.org>; Mon, 26 Feb 2024 10:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708971250; x=1709576050; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EYHbqXRbY+9N3XLStRPMvt6DFtxyfdQ+r684BQYSIaM=;
        b=fKPQf3j+CJ8qPWAjoFj0GlwE4W2Ax0/DwvuyWTXuRtnHsKGgmiuFqYMofumOPwaHz3
         JffEMQ2fpeTS82btImcba5ONt/FQ1tBa6cMJLFWZs1uRU7Niru3xrHfLmiXi4eCOwQxo
         zo2iQm2g1sP2Ajg6dKkrpZV4e7FK+swngB0NNQFKqBAn+elkRYBfi19gr89EgsbZZjvc
         JJNL+IEfNJRi6owlkAopCX3W/4tI7REiWrfpm2PjHRU0i0jWxTt6XAjkV8/Clk4Wpd0y
         wE8N5uon/CLo3+0PNvpBiwrOwmWu+NQlA/cJL1fSkkJjWi9CV6d6LiCxFylbAS6tRIUF
         2g4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708971250; x=1709576050;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EYHbqXRbY+9N3XLStRPMvt6DFtxyfdQ+r684BQYSIaM=;
        b=OcFIbp/7KpKiazyxuS88k8va4sp4SlyGOarC7TpDvZEfOYqA+J3cJP+ZbMu9xwYCnz
         YlQPYIEQvJh5zr17KNRBhR+b4cnyHXklVU1caGe496TJ0dC2P7aRvPBQ7LKZhsGFM519
         s1iK7uK6/lXOeRe8Yq8/yjj2QImH0in4mIc9ALeLG5HKBPQLbPcTqn1h0EqvKGGMd7cI
         LOg25k/jnI9fvE3J9f8M9ZHPEQxqXKK3PC2EvIYZ4ddbNvEBP4vFH1/TpFTJxzraRf8y
         KuAY7IjmE/kfqxXB4iY7szg2UzHF+LH9L0+HBcEIDC1fbS/vGF8FDYanNhbSNCW1KU5k
         mukg==
X-Gm-Message-State: AOJu0Yzl1jUaCr0WuO/46Am/9IdZvzFNKbTTyrFkK0w5ktS17fxy5KcZ
	iJ/qqDCy48i68AULWnZDLACOCJSPszqO4W0yvKBSdySP4GpTzi3F
X-Google-Smtp-Source: AGHT+IEXY4G9dFR2/sbwltYJQtvGwZHTIFhFgjfuPyTzCAjC/wGhN6jhFn5w9cHXdY10m9UShnOxpg==
X-Received: by 2002:a05:6870:93ca:b0:218:9e23:6826 with SMTP id c10-20020a05687093ca00b002189e236826mr8860344oal.3.1708971249762;
        Mon, 26 Feb 2024 10:14:09 -0800 (PST)
Received: from ?IPv6:2606:6d00:11:ff90:6db2:683e:23c:87ed? ([2606:6d00:11:ff90:6db2:683e:23c:87ed])
        by smtp.gmail.com with ESMTPSA id p10-20020a05620a112a00b00787549c6ff3sm2712945qkk.68.2024.02.26.10.14.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 10:14:09 -0800 (PST)
Subject: Re: [PATCH v2] merge-ort: turn submodule conflict suggestions into an
 advice
To: Junio C Hamano <gitster@pobox.com>,
 Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Calvin Wan <calvinwan@google.com>,
 Glen Choo <glencbz@gmail.com>, Elijah Newren <newren@gmail.com>,
 =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <pull.1661.git.git.1706534968589.gitgitgadget@gmail.com>
 <pull.1661.v2.git.git.1708954048301.gitgitgadget@gmail.com>
 <xmqqh6hvfb6c.fsf@gitster.g>
From: Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <c00617b0-b673-b52c-db15-278a67370e75@gmail.com>
Date: Mon, 26 Feb 2024 13:14:08 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <xmqqh6hvfb6c.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit

Hi Junio,

Le 2024-02-26 à 11:22, Junio C Hamano a écrit :
> "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Philippe Blain <levraiphilippeblain@gmail.com>
>>
>> Add a new advice type 'submoduleMergeConflict' for the error message
>> shown when a non-trivial submodule conflict is encountered, which was
>> added in 4057523a40 (submodule merge: update conflict error message,
>> 2022-08-04). That commit mentions making this message an advice as
>> possible future work. Only show the advice if it is enabled.
> 
> When specifically called out like this, it makes it sound as if this
> one is disabled by default, while everybody else is enabled unless it
> is disabled.

Yes, re-reading myself, this did not come out as I wanted. I'll update
the message to read more like "Adjust merge-ort.c::print_submodule_conflict_suggestion 
to use the advice API" or something like this.

Thanks,
Philippe.

