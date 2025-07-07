Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8CF19D880
	for <git@vger.kernel.org>; Mon,  7 Jul 2025 13:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751896744; cv=none; b=ZamLP0Vo9IxXhc90GTjo2E6wwv1YEHdZ/GEQSYccDTKIjtfjSJi4yVRA9obWgzE/4wiJ1hqfq4rTFcvQGy+t/V+ieMdluhbBRd90A19JnsyZWTmGPg08h/w95rP1JGdl+uTq8Fxu+lqwqNAu0uRG51kSAIUWSVNZVmNf2Z45Kt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751896744; c=relaxed/simple;
	bh=vv1TvnqWdYdw5TlQo5ANfg/qI0PnQa9vMXVO7LwdVFo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M/UMXayPEdnD/unyrKmTxaggXG2v6Yuux/stMDk8C1U9mQaYB39fRweCEDKkFvJu4gkPjaOQ4hTILOazuij/HnxnMuZ+ZxDz6FTCBmOFnIy33CsTQR3hfFwmN2q0/+5FwGvPJqKHYNj2TJ1MJiIBZNh+gFpzKDpvwWRdnBj9HQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iysCb8ui; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iysCb8ui"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b391ca6146eso837089a12.3
        for <git@vger.kernel.org>; Mon, 07 Jul 2025 06:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751896742; x=1752501542; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5AMhK7KdiGJHXv8v11LNp3mdu4M8sBSjI1AlVwfN8K8=;
        b=iysCb8uio91WHgl/U/N63nhjTXa/LNUtpisiUj5SqMJln0e9VStSHcG4JI+t1u3IrQ
         KsID5WRN7kGyOqJhiJD/awwKBiukTcbcXI30EO5pm2AwL+wTNWVqzqm9Y3pzHTXgN6/1
         IBA4vw7QEc1OOZoqPNmJ6iLAIMUzQbQO5+ibHoFJkjo53yPDq8B4DXJ4I+oqKagUv39x
         Sk23yl13vsuSz4BUNG94riwMjlXODxqXcGjX+wDpXFRUcK+9L3He3aOVs6YZbl4BUXBq
         R9ajEy+e01PBd08BlialSeTql6qI3RQPkogVtUHPDVnzEj3UGej4OXUnAg2mDhK9VhBb
         bSGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751896742; x=1752501542;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5AMhK7KdiGJHXv8v11LNp3mdu4M8sBSjI1AlVwfN8K8=;
        b=ga7nJpuZS0e17nAAJhHXIlfYj3AuzpUudO0JxCVVTSIL4q2qXgSMCuqI7v5uGXo3G7
         Umi3wcBwiggq99JjCricYoTf422ulZnjiOf4y0Rq7ojIsjL0dLauYoEv95D0K032QNDI
         sMVoqZ7KkUHwgmqentYhvB7M7V3Q7OGlVVZJXzm12fDJzXMeqSR+HM/WRdriJGKs4gBk
         b0JTOoIwpBYtgE7tWymwq6LWLWEGVlL7lSP3RARlaVENONlLfE3Y/8IUO86AQOkXJ8Hr
         XpFTyJzpc1iokbcWSoVT8slYJbkrxinnKQQqiVxZwpk8NcOlLLylXigHMgERl+LPC74e
         MANg==
X-Forwarded-Encrypted: i=1; AJvYcCXNQELgkPqStHu6oRSqGbU2O+jzz9khPjSkWk7RqmWOr9EG8uYl4wOA/+wZDxfSN9u+YlI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj+08JrrDobB2Tw1rdCQ//PrWE+N9SGB6ghcD+n3Sm601Eh3YR
	LIuPr+x2SfRE9L/Nvpg3ZMQDj01s+w1pcTrMd9Rw+PeKy3wm9ZK/VoQ3
X-Gm-Gg: ASbGnctwMcS3s7fE2aWP/KPmfVQHi8CwtXlQLgI6JSDWlXL39ygG8q3bYouppm8cAuJ
	uIlw/ioMfk2p58DHGb9WG3b3xlZUE8C7SJeFdeIkhiJk3mfjBUHAmnGok/AkI++TGnMrcQz2Gny
	+LTeQ2JunScKgkCb514YObEsFGPUrkd5mnJBHGWRmkAfrXjiHRgYhhZdf83XTVHiPddsQSRZTa3
	o9GBKiQMpXVDP1RGJmdAa9rd469sMLpSBz/O9S7vS/oY4OegdF0EA5t+uqLmq4a4j1h8FibQuMi
	9924UOky50sG40wkQFhSCH00dQuJOvfyoBqVdOwNzpaVvaxt3cfSjkuZZ+/HZh6IXWNDvnPUOhN
	U7G0d20KMGm5FZs/8fkbwprWJP6Q=
X-Google-Smtp-Source: AGHT+IFfzshRCbCc6wPhPx7y7OXUnTmXdtvDuteLDEcAvbOttjHr87Ao8G0ocYVjn7yooWASdUMZvQ==
X-Received: by 2002:a05:6a21:594:b0:220:150b:15d2 with SMTP id adf61e73a8af0-22720cbae26mr14016297637.25.1751896741939;
        Mon, 07 Jul 2025 06:59:01 -0700 (PDT)
Received: from localhost (209.255.125.34.bc.googleusercontent.com. [34.125.255.209])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74ce359d1a7sm9738042b3a.11.2025.07.07.06.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 06:59:01 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Per Cederqvist <ceder@lysator.liu.se>,  git@vger.kernel.org
Subject: Re: [PATCH] remote: detect collisions in remote names
In-Reply-To: <20250705185842.GA2496172@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 5 Jul 2025 14:58:42 -0400")
References: <CAHx6-Um1dq0xJ-RkW+qXe=sEa6JGViSJxjzNw56u55DHLYoT2Q@mail.gmail.com>
	<20250705165750.GA1951664@coredump.intra.peff.net>
	<20250705185842.GA2496172@coredump.intra.peff.net>
Date: Mon, 07 Jul 2025 06:59:00 -0700
Message-ID: <xmqqqzys5cgr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Sat, Jul 05, 2025 at 12:57:50PM -0400, Jeff King wrote:
>
>> So I dunno. It feels like a configuration error in most cases, but not
>> all. I'd probably say that people touching the config manually should be
>> allowed to do what they want, but maybe "git remote" should be a bit
>> more careful about names being proper subsets of existing remotes (it
>> should already prevent the exact-match above, I'd think, because the ref
>> namespace it uses will always match the configuration name).
>
> So I'm not entirely convinced we should do anything here. The answer
> might just be "if it hurts, don't do it". But if we wanted any
> protections in the "git remote" porcelain, they might look like this:

I have firmly been in the "if it hurts..." camp.  People can do
weird things that may not make much sense to me, but do make sense
in their workflow that may be vastly different from mine.

But I do not think of any downsides from forbidding outer and
outer/inner existing at the same time, either ;-).

Thanks.
