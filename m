Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907EC158A28
	for <git@vger.kernel.org>; Tue,  9 Apr 2024 23:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712705902; cv=none; b=FjSXeWbFmYucMojXja17cJMo0xNHXn/CTZdBrRZA6lgvMh10szrwRBMBv0deoCpde8JTopj5KX1ercuj18dFCJCY+AxHgzLuGEBU05QdO8wXPtuJClUCnjCFHeRNHftNioBIkAkBrczPnd4ixW/6/ykOc4cknuHQk2KZik6P9co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712705902; c=relaxed/simple;
	bh=ud5LxYheJFSQeiKYipA9F8jZTJjdaRp1gH7LWMo6BdM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cjua1Oz5REsI53InTelQ+E4YVXY0oy0XAypxuVdD1mjCQ5exAGuYUhQhsLD7JJ9Q+BN1gBC8FWtqSqkuWSBLOS+ywcgoebYvC58ZUKCUw/Hg2jwgUcOE0N/B5N5o/cpGy2Hq5VusYE6hVu/yX8GerfQHKwYVDnLVzGr4WtzwhuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QmTf5LYb; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QmTf5LYb"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-416a8ec0239so6852145e9.0
        for <git@vger.kernel.org>; Tue, 09 Apr 2024 16:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712705898; x=1713310698; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KLUq+6IU0ohuoWuSbprVEvfyb+ZTBAo9vWhquVrIq10=;
        b=QmTf5LYbtxDC7yBwfWM3och9lDCPmiJx1Vc1hLZUy8SYd42Ps5tB3ou7oEJ1gDkJDb
         BBLDLf7MRHFOOSIf3SN+gOqMM8qECaz6CmziPRzMbH8Vsm2OE0r9YXxWjzf2FBfvpXoV
         W/OQC99fcV9EFH30hjy//NhutvP7umx57/XTmB769zNFSc5EhH59Z+U7Mfewm9i633wi
         Hf8S8Hu7c1OP9Qa3feF1h1HE0zhudgzjXj6NO+asGKmp0bOEvAUQHAs8BS9LeG4n5RR2
         zSDcvHo/oXMStMU8XtnSHpeRcZqehEJ24k3vfEGGUhJcVfzrMh1uMHRswurCEP1srY9t
         CXCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712705898; x=1713310698;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KLUq+6IU0ohuoWuSbprVEvfyb+ZTBAo9vWhquVrIq10=;
        b=aFoIv5Cq7Ww8kNquopSO/6rsZVoqfxsqOHrv9lABL6iqGdozcAz4lnAoT+HGWXOoXK
         17aZUpFEXHc8Bv3v88pKFjus4sh8cuCJQ98VMHQb5eW6+XpnvjduAj75cioxatmVJYp2
         /T0l5g+3n5OxWHkkcgi9ypqlqCbTAjPVXre6BneZMCEFxxaW393UgYwkSQ4z76MbLXwS
         8c4yxwZ8pqzyB3OLqvWW+uyvemTTzuI6I2YDmhBpvdDLfFJetMAaM1E708uu3I4y5VCz
         WbwVmVbzTheJGJg2OscX09DUPQjZzE5LclhhnlOsP+bHsS1Jj+maelwzTz1zolIQwsPr
         sUlQ==
X-Gm-Message-State: AOJu0Yxb/NI8IHZ6UpKhDUIp3l/Q+v12YZkI0PPoiQ8/lm5W7byymp+L
	ybrgPfN0LJsHAqrT2LNojvPcaMl1pAfT9/zyygUX7lfIXSw7jss1v1ySDx3z
X-Google-Smtp-Source: AGHT+IGHmLtXi2FuW28i8GAKM/HlMK1X00Ps9gdfhUsKu5xvot8VVjxIfDvaU4QIp+v4JSPljqx6Yg==
X-Received: by 2002:a05:600c:4f08:b0:416:259d:b250 with SMTP id l8-20020a05600c4f0800b00416259db250mr927260wmq.18.1712705898084;
        Tue, 09 Apr 2024 16:38:18 -0700 (PDT)
Received: from gmail.com (158.red-88-14-41.dynamicip.rima-tde.net. [88.14.41.158])
        by smtp.gmail.com with ESMTPSA id hg6-20020a05600c538600b0041690a1c9desm443367wmb.30.2024.04.09.16.38.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 16:38:17 -0700 (PDT)
Message-ID: <54dcd4f1-5a79-47ba-9650-7115b7170a84@gmail.com>
Date: Wed, 10 Apr 2024 01:38:10 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] launch_editor: waiting message on error
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>
References: <e60c1217-aeb6-48ce-9aa5-7c0b13396e33@gmail.com>
 <96bef5f9-1286-4938-99ec-6beed13ee68d@gmail.com>
 <0258a583-a90a-4434-bb4e-a1672d574b9c@gmail.com> <xmqq4jcb495u.fsf@gitster.g>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <xmqq4jcb495u.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Mon, Apr 08, 2024 at 06:27:57PM -0700, Junio C Hamano wrote:

> I wonder if we can just call term_clear_line()
> regardless of the value of ret.  Either case, the waiting is already
> over and in the error case, we show another message after it.

My concern is that perhaps term_clear_line() might clear some useful
information for the user.  Although I am not sure that this concern is
sensible.

Stepping back a bit, how painful it would be to drop the
term_clear_line() and start using advice_if_enabled() here?

This is what I'm thinking about now.

	$ GIT_EDITOR=false git commit -a
	hint: A-good-explanation-to-say-we-run-'editor'
	hint: Disable this message with "git config advice.waitingForEditor false"
	error: There was a problem with the editor 'false'.
	Please supply the message using either -m or -F option.

> There is another error message when we fail to start the editor.
> Doesn't that codepath have the same problem?

Of course.

My itch is:

	$ GIT_EDITOR=false git commit -a
	hint: Waiting for your editor to close the file... error: There was a problem with the editor 'false'.
	Please supply the message using either -m or -F option.

But, yes, while we're here we can also fix:

	$ GIT_EDITOR=falso git commit -a
	hint: Waiting for your editor to close the file... error: cannot run falso: No such file or directory
	error: unable to start editor 'falso'
	Please supply the message using either -m or -F option.
