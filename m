Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09590322A2E
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 16:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774024271; cv=none; b=bPAuo+vm3/PUutlnzJ5mwHyO7RDMB5yh/QveQO0cbD8QeqKwUhu6KZExfvZY7VP4Cgeh+YKdRkuU7BTvskW6T4MzeSc8I5BrKBTiqdNOrNJor7bulw/8nqSSNK0kz2ypaFfROJfEBskGFRift8Rya5lKiO6GQs+2ddOr05SoWUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774024271; c=relaxed/simple;
	bh=27/3uZUz/b8kJgsjAQo8crfoXRWjWqT75YXmLNkt9dk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Kev+tCrFV37fR+CGNSBxqbnj2xVN8D1vvU/YFAXsMVEkUdJ2xEhvv/NQRDSsH2mgmN3jyIXXLH9WZZ+JLtU7v6sUl7A1vZKCA3yx1shLzxScFDjcSklVYQ6nlEAhhj7D7d+0W+jYqn319IgxLUE2F4LoFDxmdAV3C7qH0nebkvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZEYTk3Y; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZEYTk3Y"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-506aa68065eso19806221cf.1
        for <git@vger.kernel.org>; Fri, 20 Mar 2026 09:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774024269; x=1774629069; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B4UrtihwmcW9g4lSedw5M+Phxr05jPiCYkAdBNZAJu8=;
        b=fZEYTk3YGhfmy1nPzC7dL0o2dxkYU4sCYhl7W8DbnHQjI3XQE9cByWUcVMbCP6Q5wt
         03329AqzNU17yyEhZQWk7UJ0WFMQewG67W0wvldmwCI02nWbQlHdTqaFJ0Q/pJpZmZyz
         OXuYjpAPWIMSJ+DINL5FLLvIEyRK7xrCz9Tq4tfNaDDjr3xuzmmW6Er4OtQLSy1UFMbR
         SRzhKSf4rQWKi1uJidFGFSbmkKn88dFoD6ZZKE5p+6PLAuXlKNLtOIyxqgM/9tE6egHw
         nJN8xucKw3M0mI4IK9olXI4/Rl8dq4f/yc0gQefUKyGU83Fewj5LgUnOQx41v9hMQoQB
         lwkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774024269; x=1774629069;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B4UrtihwmcW9g4lSedw5M+Phxr05jPiCYkAdBNZAJu8=;
        b=juwAyCHoJCnM3Xwij+PGXrGIubr0R5dWOOYlQGG/PSw6i/9PcABOrRu8vQBx5Klklz
         3mfC+KqSmJXlN1FnxNYh/w2E3RomRn2igNZiotdxYzxbGx+R/wlKgiNUkMLOZTP3gBbo
         RMi4RkKJg2Nx26+YHajs1SxYpmrtyHEe0viga4d12HH2upckTMVCCS1+6JEYJ4kIwpd9
         Av5QuVSvc9YtLNYMblsPyYGGEv3SsS7G7NEeuRpNqvHzw/At8k/nputtQO4WcmwrYzRV
         sHWHblpDrTq4Wvqd/Mb8IAE9yJxGAdTtpDJPM7eAdVwFPE/GL7UclKXd7uhBawwQeZs3
         64Jw==
X-Forwarded-Encrypted: i=1; AJvYcCWObj+1tUaBx0jtZGCPqPyhi4KhCIZVUYrNFu2G96m3arSn/FM33s00fScc0Ga9bm3HmSc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWbENzDv5WAvcGtet8GYrB4Rqp4qrAObdocupGeMyX7ERC0f7J
	8nks+dDYTfpdqWotdWmaHLPq0cQYN8Mv/beeRc68oA1m6Wl+7HAVJcKw0LmSzg==
X-Gm-Gg: ATEYQzz+6noJd+mavSOv2r6dmg2e9W9aEsBclsge7ST/+M6+DFHWWByZMjFu/btBYjo
	avOKdKGq7x6Rou+sX1uLx5fk9O6eZ42wWv83i14oVhGXr+5nf6TiVkPacD+NJM96Af5HKBZXPAz
	RMzZYqUXkYQ/RAIB/Gj9wZ01oBlEw/98LhNzMg8HhNmh6xE7PlQwPN1AlZcQGZzdOdJ9X/dByD+
	p4iBn1AzmlmaR/ZX2uBJ9A/0RdWd6cp/nXvBStV8E8TMyGAyWWEWA2nem3LJk3xyYWq44cvWFTx
	J9JwIWYcxv8tJge7QwYw6C+RCa9yUUoP3/byTUWw7cTX5js+d6v+X2XKenfu/5xzqlbd5QP9S/Q
	YgrcG8xJcrvfVsEJ5ebY6xiwCcIuCcYQADpvkBTT8cRz8cJOs6yDXqHTun/pNXMe1IbEMheex/p
	w5xYMlpdd7IdDOJWJW/elFv+Wb7+vTBvVewMZCYdwXBRXcAfUvlGztz6bKPM76tDDYE0PU23HDi
	uEvBvvX
X-Received: by 2002:a05:622a:7b0a:b0:508:faa5:451a with SMTP id d75a77b69052e-50b373a05e8mr42349901cf.13.1774024268743;
        Fri, 20 Mar 2026 09:31:08 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50b36e3d85bsm21143761cf.17.2026.03.20.09.31.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2026 09:31:07 -0700 (PDT)
Message-ID: <228bfbe3-af2d-49b7-984e-cae7b1b8af28@gmail.com>
Date: Fri, 20 Mar 2026 12:31:07 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cocci: strbuf.buf is never NULL
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqq4imbigvt.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqq4imbigvt.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/19/2026 6:39 PM, Junio C Hamano wrote:
> We recently noticed one old code from 19 years ago protecting
> against an ancient strbuf convention that the .buf member can be
> NULL for an empty strbuf.  As that is no longer the case in the
> modern codebase, let's catch such a construct.

> +// In modern codebase, .buf member of an empty strbuf is not NULL.
> +@@
> +struct strbuf SB;
> +@@
> +- SB.buf ? SB.buf : ""
> ++ SB.buf

LGTM. I like to see these structural patterns encoded as rules.

Thanks,
-Stolee
