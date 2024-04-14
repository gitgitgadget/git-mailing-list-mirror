Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DF917BB7
	for <git@vger.kernel.org>; Sun, 14 Apr 2024 07:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713079438; cv=none; b=spwoBytQMxzJ/Ajeym/b/soLn/rbNLV8+iSqkU7BTSTjAbRP0SY97Wi7/d3GCIzuyo5df94VCrilVfvYVLL8J4KNU94WSXO6qX5Xpo5yKGU5D94KCbSNyI8oYAd5Di3CayLfvkEaYNmYhW62xVY66g4llWvM87s0+jm38r3fsqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713079438; c=relaxed/simple;
	bh=9XuQWeUm0/mpEihyYo+ucfTogkZ0HtvJfm+KQL0xD2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=QdYmSgKwVC0JJ7HKBdL5s2AIdxti19slFSlOLc62mmAz/e8ep6DhZKC8l3jJ/UTD7FBNyXXRWsu24j9dntQXX7cCYd/m0LxhK/8JJnV8a6qDG/rjk97yuImCTSpzIe+MoCWHh/khwOsYSY3YYgDOYM8gRex6a7FdD4Fjj5HG39w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IaPTba9U; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IaPTba9U"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-34641b7c49aso1679009f8f.2
        for <git@vger.kernel.org>; Sun, 14 Apr 2024 00:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713079435; x=1713684235; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jFU7ysITyg1/ZdHVZYnUa2XlLWFxBG8J9+Xu95DB29Q=;
        b=IaPTba9UJnrxT1oPJiwZUp5lrSbM10MyWpiLggOdPz/u2IML1oTySmAxcNUcwBF93v
         Hu7UBTUGDdr9PpZ2erQE7n6V+xN6PGxGW800vvbo187cKlfDoCdxo4h9eh9B11Oo4zj0
         qHJa50gb3hIRz7ibXgucQG6ROWA9o9us6BrUQwHY4u2Bwbx5uHGYRkSpsLCB6z9/VjBg
         puYfwb4sDyrpTKh6J7Q43VdMwqpciZ0Uy7a53hWInNIsJwN/mYsmZiADOTwZ8246VfUz
         qHaijbpHsYbW39PUWvUk207DNqx+HWvdPKA00byTlPkVgoAkERpCWLyRV+yxZ5byjfic
         evUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713079435; x=1713684235;
        h=content-transfer-encoding:in-reply-to:cc:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jFU7ysITyg1/ZdHVZYnUa2XlLWFxBG8J9+Xu95DB29Q=;
        b=nwhmYs50L96NkJifBcsECVf2TKA2YjdCAiJVTGsC7laNZ4e268AdlNumBAQfTp4zDI
         Krist4HF/L/dZkE8qSiTlUPCuC0zOtfG4UG2rdjyK4hVRNoCEomnL2U4Na578cJht2Nd
         9CqGOb12sVd5jMAPBJuYJoAQ2mgQGbYAarhO8g+jeAIWCIGsCNvzXQJXQjHathzKkN74
         rfj9h6d+fHlkX8NUuO0vh2eZh4Iq8G/TuwqeHShmWJDCnPcR5SlOCkT1hxVNMFmrQes3
         79xxcL4eUsxSwn6zQ5dweYKacKAtFfgrGM2psTt/SoZvxzCnCGEQXVK3qOO+62nVPktU
         osBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxqO6Una8ypByznn1h3I92PGm8Zdfqfha2eleSlF4u6aqQPR7WS2SzmoCve9v0WyUGUhhl66SIDsMVuc7umTC1qL5t
X-Gm-Message-State: AOJu0Yzcx3Yes/gIT1T2Jq6UahKX3xBFpB/UXNUYGFkCx/c6D7Ck0ywX
	z9RH7dYAWXVMQIfUAkDOGCNw/LNSMuYfpwAP8AN4zmgMtU70LP7OfQ1oow==
X-Google-Smtp-Source: AGHT+IGDEt0IRy5BHWF54pK4mIXwCv8ARWHAlT8vhg+cTXJ7vCnKUbKzhuHIhY4NRdlA8ASjMuWq8w==
X-Received: by 2002:adf:e343:0:b0:343:772d:9349 with SMTP id n3-20020adfe343000000b00343772d9349mr4400625wrj.50.1713079434847;
        Sun, 14 Apr 2024 00:23:54 -0700 (PDT)
Received: from gmail.com (91.red-88-14-45.dynamicip.rima-tde.net. [88.14.45.91])
        by smtp.gmail.com with ESMTPSA id e3-20020a5d5943000000b00346c169362esm7968537wri.23.2024.04.14.00.23.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Apr 2024 00:23:54 -0700 (PDT)
Message-ID: <66b3192a-e0db-4df9-bcec-066adaa3e083@gmail.com>
Date: Sun, 14 Apr 2024 09:23:49 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] launch_editor: waiting message on error
To: phillip.wood@dunelm.org.uk, Git List <git@vger.kernel.org>,
 Junio C Hamano <gitster@pobox.com>
References: <e60c1217-aeb6-48ce-9aa5-7c0b13396e33@gmail.com>
 <96bef5f9-1286-4938-99ec-6beed13ee68d@gmail.com>
 <0258a583-a90a-4434-bb4e-a1672d574b9c@gmail.com>
 <ccbd77a1-d334-4d8f-8de0-b542c79330fd@gmail.com>
 <c430a194-32ac-403c-a381-801556275f66@gmail.com>
 <782c7127-45d7-4bd6-930f-941a6f43088d@gmail.com>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
Cc: rsbecker@nexbridge.com
In-Reply-To: <782c7127-45d7-4bd6-930f-941a6f43088d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Sat, Apr 13, 2024 at 04:09:27PM +0100, Phillip Wood wrote:

> I think it is very likely that the editor has printed an error message if it
> exits with a non-zero exit code and if that message does not end with a
> newline that is a bug in the editor. Do you have a real-world example of the
> problem you are seeking to fix?

Perhaps I am being too cautious.  I'll follow Junio's suggestion and use 
term_clear_line() in all cases.

Thanks.
