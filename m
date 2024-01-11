Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBEA1802D
	for <git@vger.kernel.org>; Thu, 11 Jan 2024 13:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TDiwGdDw"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40e54f233abso22429455e9.0
        for <git@vger.kernel.org>; Thu, 11 Jan 2024 05:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704980393; x=1705585193; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7eXvKUT6l2XjPeDNX1VcUFqr9WnV1Sjmn5JcuqV8P7o=;
        b=TDiwGdDwc1xYo6J9OCah7qIvQkQN380W7mxF8wGckUbMXisYVE2UtJk2fKtAlc5u16
         Rs0UBgaIyHPZ0432+fTty9k1h9biNZtNS9bcShHT25bgV6qh417duZ8qV5+qIxksb02D
         89n8tTRt8RzdgTt/dOBzXGR13QToMwOpltiFdxT++0Rr6sUHkC+Rvr3LxT0Lod1czsIl
         xjQi6RpV8z4xlC1WwdTrBnxuTDVizxMRffO3nvoD7z6gFn7JAJUwEmxLTM0Gj4Wkxi+m
         uHgqOWKh+AaXfATetYUCchf5kp181MPCXAKxIYVOHL0RI2xeniVPPdaAgcaeBa2UChi6
         GdBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704980393; x=1705585193;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7eXvKUT6l2XjPeDNX1VcUFqr9WnV1Sjmn5JcuqV8P7o=;
        b=MEghaT4vIEvuvwDX1SMikZM4fIu8Movb2sKZgf9LrltydkKK9r/+eh5RvtfOQrssUN
         tSSRzCQ+72nEftzRKQdjW+bru1/anYuyGI7h2mBfLpM7Cd5+lvilq6qcerEfL0XAgwUQ
         oBeVspEkdCBpS7OMP/VZMe2i33GUVbfcCcT3icL6lYhm/miEQTeueXkQZMRTeT2TevsF
         I0BOzJm7KJL88c8WaJDukwtZ1YIj7A/qJLECn4VRhOkFYaGW/h6cy6hvaYOv/4cLR7sD
         pdET3hRJd987g0i9rmSxXiG3drE1LhsKuha7u7hGhwGSQe8MfDkvmZAi26l7thmW6mHS
         Efng==
X-Gm-Message-State: AOJu0YyuCCshSJiB3Nlj89o9RG6eP+DKu3RZRtQ4uPQBaEOUgG/YmDrZ
	kvyb6wHmHox1fXF1Flen32g=
X-Google-Smtp-Source: AGHT+IGgxP7OJkAD6nc1MC59qdUdzFK9xYUDTOZJeC1t+JRgspHC4qc76Oodw0uH/jStdWfo73pRyw==
X-Received: by 2002:a05:600c:a083:b0:40d:887e:fc88 with SMTP id jh3-20020a05600ca08300b0040d887efc88mr423779wmb.187.1704980393166;
        Thu, 11 Jan 2024 05:39:53 -0800 (PST)
Received: from gmail.com (166.red-88-14-44.dynamicip.rima-tde.net. [88.14.44.166])
        by smtp.gmail.com with ESMTPSA id m22-20020a05600c4f5600b0040d5b849f38sm5978877wmq.0.2024.01.11.05.39.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jan 2024 05:39:52 -0800 (PST)
Message-ID: <764ff26e-0dd2-4372-9323-a21164e16944@gmail.com>
Date: Thu, 11 Jan 2024 14:39:48 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] branch: error description when deleting a not fully
 merged branch
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>
References: <04c3556f-0242-4ac3-b94a-be824cd2004a@gmail.com>
 <xmqqbk9tcc57.fsf@gitster.g>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <xmqqbk9tcc57.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10-ene-2024 09:48:52, Junio C Hamano wrote:
> Rubén Justo <rjusto@gmail.com> writes:
> 
> > The error message we show when the user tries to delete a not fully
> > merged branch describes the error and gives a hint to the user:
> >
> > 	error: the branch 'foo' is not fully merged.
> > 	If you are sure you want to delete it, run 'git branch -D foo'.
> >
> > Let's move the hint part so that it takes advantage of the advice
> > machinery:
> >
> > 	error: the branch 'foo' is not fully merged
> > 	hint: If you are sure you want to delete it, run 'git branch -D foo'
> > 	hint: Disable this message with "git config advice.forceDeleteBranch false"
> 
> This is probably one sensible step forward, so let's queue it as-is.

Thanks.

> But with reservations for longer-term future direction.  Stepping
> back a bit, when 'foo' is not fully merged and the user used "branch
> -d" on it, is it sensible for us to suggest use of "branch -D"

Maybe the user hits here because he's doing "branch -d" and so I would
find a more clear suggestion: "branch -d foo -f".

Or to be more generic, not suggesting a command line but a description
that explains how to use "the force" ... :) sorry for the joke

Anyway, I think you mean to suggest a less destructive approach.  Which
is fine by me.

> Especially now this is a "hint" to help less experienced folks, it
> may be helpful to suggest how the user can answer "If you are sure
> you want to delete" part.  As this knows what unique commits on the
> branch being deleted are about to be lost, one way to do so may be
> to tell the user about them ("you are about to lose 'branch: error
> description when deleting a not fully merged branch' and other 47
> commits that are not merged the target branch 'main'", for example).

That's an interesting idea.  Maybe the hint becomes more informative
than a simple advice ...  maybe a more-verbose error is needed ...  just
thinking out loud ...

> 
> Another possibility is to suggest merging the branch into the
> target, instead of suggesting a destructive "deletion", but I
> suspect that it goes too far second-guessing the end-user intention.
> 
> Thanks.

Thank you.
