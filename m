Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3245CA64
	for <git@vger.kernel.org>; Sun, 24 Mar 2024 17:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711299878; cv=none; b=F9EOXChYK1Tn0iVgURC8qUSWLLRBSu9lQVaKssMDz9H1vLuLJZXE57PeyF6sHEpnBOcIJIhlAgtqqXDrciAp8/g2gsNV9Bj+hC5kx8bhsjK5mFKDE8fafZVICb6bJ6LznBrwOdx9OWgD09JIbi74tzNQtFGG6yWooTkip+jfINs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711299878; c=relaxed/simple;
	bh=ulVNjaPvXOp2tK8S3csDqDzHECQebj6YkQkE4P/NeSk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=pkY78nSmfSWTflSVcayH1kVCvaRo1Sj9gQT4W6s+IW3pLtkiywjC+wOmEgl3XefJzkWG9duMoOJDhqJZPbkVXzZ2I5e9+mn4SdtXx4OwxMUtvXwJrlW0REhOa2q5et2S6IOCbanCHatC8bAKLiGOsRaK4D/Onu5NMxko2VpISYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h+z1LqmF; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+z1LqmF"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-690c1747c3cso28380866d6.0
        for <git@vger.kernel.org>; Sun, 24 Mar 2024 10:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711299875; x=1711904675; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aGDNrqNXTsLhPenttcKCykdt4SOJqo8ie+9JjE6LfW8=;
        b=h+z1LqmFp3gqRTTOgAEnQlyu9NYqbRMoQ2y24rLWwDFN+MgwEelFG9KiG8OsZsK1kP
         rk+TjmY02DnMNtCPgxHIXB58CJnTY84pMuhLs58FRnEgBRaOQJsqH25f54ylmS3eAcj0
         xiMIzZ+6A+Ev7GE3Zc7okPlENVRhRofvXwq19oKyyrKqqru4y1pPF5g4yHND3A6iS6H6
         BsN0SbXy4ubsqH+zIh0Ix6JEEl43x8wDjL9D7jZGLK70vnYaJuRBpaC5ANK2i0+KCQa/
         3vf31OjF4nEFqC0/et4VzUjYWRoeBCto9orDc+hAwzJBWAQw7HjSUaoOKQQX6AxT5MLa
         GJlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711299875; x=1711904675;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aGDNrqNXTsLhPenttcKCykdt4SOJqo8ie+9JjE6LfW8=;
        b=PGIJbX4We2kRbhKmaBnnRHc7VhRYPB8A0NxVNiJh3coAH9HEb9zkq+eX/i1oujxlTr
         5RHU1OgQ7FkBWZFxYjJiJDmCwQ/eJeJzcRODch8GsqMd9m4FOdf7+OJWiU+Mlf1ttC25
         u67xVhFvkG/sYZ+A7mP8HuyZ3GfkP4wlXvDHEWHnlTkCrmBp5UXfYRSxS8M/I0oSMYj1
         g0B+jnAhH81faRdE21iyBp+Ew/SYUxNWcnIPcpwH7w6I3M1UCAuv30kpAkCwDxt9qkw7
         tHb5/2ObFmxGi5ejgtM5OUC8Yynm4UjcMSajcmXTBFchgIBMvV/1cuxsGLJd2l4CCeIj
         evRg==
X-Gm-Message-State: AOJu0YxxQjBkd1ayPSTBPbZp6oCDAngG+mBeMYmVJt4ddVz5cXhcFvdI
	zT54hCx3WsagwA0v5abCNADAjRhcDraFt67MPo/F5sBf8AfHB0kOxoTd93Zl
X-Google-Smtp-Source: AGHT+IGehgTspp5d05uaZFDANch8W0TpQ06LNbyUbBK4wyN4rujjZL1kGLDF+XEaweDoBPu+EAiNkA==
X-Received: by 2002:a05:6214:ca9:b0:690:84d5:cfc3 with SMTP id s9-20020a0562140ca900b0069084d5cfc3mr8195613qvs.1.1711299875488;
        Sun, 24 Mar 2024 10:04:35 -0700 (PDT)
Received: from ?IPv6:2606:6d00:15:103b:7d73:db39:fcae:4412? ([2606:6d00:15:103b:7d73:db39:fcae:4412])
        by smtp.gmail.com with ESMTPSA id hu4-20020a056214234400b0068ff8d75a90sm3220462qvb.19.2024.03.24.10.04.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Mar 2024 10:04:35 -0700 (PDT)
Subject: Re: [PATCH] t/README: mention test files are make targets
To: Junio C Hamano <gitster@pobox.com>,
 Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
References: <pull.1701.git.1711293246094.gitgitgadget@gmail.com>
 <xmqq4jcvtxtz.fsf@gitster.g>
From: Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <97212b72-70d6-e55f-8b2a-04ede4321288@gmail.com>
Date: Sun, 24 Mar 2024 13:04:34 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <xmqq4jcvtxtz.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit

Hi Junio,

Le 2024-03-24 à 12:10, Junio C Hamano a écrit :
> "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Philippe Blain <levraiphilippeblain@gmail.com>
>>
>> Since 23fc63bf8f (make tests ignorable with "make -i", 2005-11-08), each
>> test file defines a target in the test Makefile, such that one can
>> invoke:
>>
>> 	make *checkout*
>>
>> to run all tests with 'checkout' in their filename. This is useful to
>> run a subset of tests when you have a good idea of what part of the code
>> is touched by the changes your are testing.
> 
> While I agree with the patch that this is a useful "feature" of
> t/Makefile, I've always felt it was ugly to use a file itself that
> we do not consider a build product, rather a source, as the target
> to trigger some action.  Are we comfortable casting this behaviour
> in stone by documenting it here?

Since '$(T)' is listed at the bottom of the Makefile as .PHONY,
I think it is OK and not that ugly since this uses a documented feature
of make.

Cheers,
Philippe.
