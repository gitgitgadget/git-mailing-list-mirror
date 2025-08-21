Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8102FC006
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 20:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755809841; cv=none; b=W0CNPOiK+7m4VN6vkUeyYewQisqk6Xd97l9qMBQ6QN27PxlTB1G5bc/1/z3X9fVKCRPUwhwwmGrs4qpwNXPmziU6ZUsoLVhqxWVXSDotDIvj9wlo0BrXPwozdBEgc1iTnGdFn74KMD4WBy321KZ4k3NK6P6OOWGAtEk07e9LyEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755809841; c=relaxed/simple;
	bh=zieCYKD33rOUkabCAS9BAKHYZWxxeLMfOL8Vw7R1lTQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=I4QhFq2K/IJIOMQYTcZeLm10xvSzcF+jzOQ0TfRhCl6/2fzCbwfG8/cXjbrhIkBBNZn6RAlT781wajy6sMUmUkCZkPk0GwKPcVWJbdwQA7m5rc8mcbH20mzU1eU5xGga9BZ+wqmD/r1fnfF1JLRlE6e6acjRZPZP+KvIJlFIC8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DtiJ81RN; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DtiJ81RN"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2445811e19dso12341705ad.1
        for <git@vger.kernel.org>; Thu, 21 Aug 2025 13:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755809838; x=1756414638; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BsYbre3c+DFRANcbQFGZxqjhOXI8rAmBgdVEaMOb3F0=;
        b=DtiJ81RNN3VyZ5/JEZRo7Ydutg9oYYggEGUzgH4BCH2f7eXvtBBMnQliqxjwmFiout
         cJCkqMmgW5GSe76PHfje9TUuzjgGtY8maH33q/x/EyCNEQwlp6UDXf1j23Pg1vhMiP4o
         NlORwlMqiiy16UQ+3xZMY9+/hZ9aJ/bXxcPAo8iH6mmRkk6JIqIFX9KFT8MpNTWse4j2
         mYVFsXRxZ6fUvQV29mXJZTBPyQ5XUED7oZHnjVcqwI2aBnahSX/lKGaNCaXMDPl6BXZ6
         Sv1GbGKfSo4lGI1xCcCX/BdlmNmDMsX1qGYX4OcTz97VChsk3JydexeyGWR5pW8RDMqR
         MSpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755809838; x=1756414638;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BsYbre3c+DFRANcbQFGZxqjhOXI8rAmBgdVEaMOb3F0=;
        b=goH9n7kPOfYKRfl8PF7zZleBx7yS+hYaAj66TDG5UIWLcI/n0z1+X7oQJ8o6+Z3QLT
         zHh+yyNbCLMYgizm0ar7c8AkEsYk3NoGkSQNa0PInhQMhnW+Aw81P5C6viEx8MSRBOIx
         QXxCoUlKWVR0kD8YGUzIxVBeWAA2jUMEMr8vTn9Xzv+XVsKY04kej22XlDqHwfjsD+OO
         fPF7FXxUCG44A/eLdjsK/30Bgngork3Iln7w4IAB47CDa/r+jFA3G+eoMGD1kD5g38pI
         xQEu/4QGGYYWW81I/Cg9+IO32WaJuzBmja+MaAl2pZ2wv7Z27Ho4WkqZ/yy5BKdzMnni
         kFEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVweTpYq2nuIFHxsZ2pT7LwVkWXIhTJrAuTuy64SxeIgfLoV3rwSPqAfmHVtMA9P/TYwuE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwmYdeW424lbfIEfcu6LXNOnfj1KR6a795SE02u11wewYJLPD0
	4KwNBYUSDOo90hpX3yM5r5jghVMGY/H48QpSLhnbg90wL58hAYcu3Naw
X-Gm-Gg: ASbGncvIfIDx/6S5XuxGryQfdPc7YyvxunzByZd/8lLKfJEcTHOuTailvA6hwjAi2uo
	YStKRaPR0+RomloLuDM7D8TUDcT3SH2AADDluL9tWKA5jpwWt2Ha9PF1C7eD7HunRBOiKbx1Aie
	UvgRqUFqx4AZ5nw7ZTaaehqZZEkQfQIkB5xncNA4BpXPfAhRcmq6VsfywehaAZKufCtqdzxRbC5
	P33E01J4xiTRvHXEHGiqoQ5hWAn1iaPgA7FLD+MJrUo7Ja0UtSRwh+8gTg2bOOSyNgVfb1v5Xsu
	H3PJhyAqvSVFPS70dcj5RA9tOtxRu8U1zqQcXAAG77dxg+rBxra+/RAuIm2+bu2YNdsOCygdfje
	cHA8mXD0bS07ODykLcsedcK9+VOigeXAKoCaXhPXQSdhybrqqAL9fFcB8
X-Google-Smtp-Source: AGHT+IG6Um2OuMKEVj443L5KSf3UvW8MYPtshg+xj11nYpxUrE/EYHoyxofQTlnK//94ZScW4TtXVQ==
X-Received: by 2002:a17:902:d4d0:b0:246:3267:70da with SMTP id d9443c01a7336-2463267750dmr6709735ad.52.1755809837559;
        Thu, 21 Aug 2025 13:57:17 -0700 (PDT)
Received: from smtpclient.apple (nat.ime.usp.br. [143.107.45.1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed33a7fesm64076785ad.7.2025.08.21.13.57.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:57:17 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [GSoC PATCH 1/2] repo: add the flag -z as an alias for
 --format=nul
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <xmqq4iu037p1.fsf@gitster.g>
Date: Thu, 21 Aug 2025 17:57:04 -0300
Cc: Patrick Steinhardt <ps@pks.im>,
 git@vger.kernel.org,
 karthik.188@gmail.com
Content-Transfer-Encoding: 7bit
Message-Id: <7E449BB1-224F-4B15-BB0B-357E4FB79429@gmail.com>
References: <20250820144247.79197-1-lucasseikioshiro@gmail.com>
 <20250820144247.79197-2-lucasseikioshiro@gmail.com> <aKb1BjPfmjBvHrm0@pks.im>
 <65E661E9-B926-4EC1-B0EC-CDE2CD1557E5@gmail.com> <xmqq4iu037p1.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3826.700.81)


>> But I don't have any strong opinion about that. I'm open to suggestions.
> 
> Don't ask for suggestions before consulting CodingGuidelines,
> perhaps?

I think that Patrick was unsure about adding the external parentheses
to make it look like [(--format=(keyvalue|nul) | -z)]. CodingGuideLines
is not explicit about that specific case of having alternate flags
with nested alternate arguments, but I don't see a reason for using
parentheses as it isn't ambiguous...
