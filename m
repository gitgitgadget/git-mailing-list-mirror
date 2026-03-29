Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A7F3644C9
	for <git@vger.kernel.org>; Sun, 29 Mar 2026 12:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774789169; cv=none; b=OgwXwZojAxms6ZgbpSYxZl/V44eqySp6Da7HH13NZV1qitbX7YXN+QFBTH8zNaTUvYQb0V7F0SXi2Au5dN8lCHHnCWJ4auPRwlNNkeQe+6waxjWNMTM6DITjBbvfRCGDOkF8PerxspgycKaDCHt25js03blvUzkfXH3NLWmlo/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774789169; c=relaxed/simple;
	bh=n11r509uWH7RKZr0ESAcIDADstU3bAJKXilIVpYpJcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LHHPRNwuIWH9SZY21+8De+NV6NpVfiOWrUm2b1F7ELVXKCnfiFQajazKTLkUcEjopkfFurSUlX4JZWvPuNwgG2kynf6yxyrcqIGVz+xKTdH6uGtKjsg81GZlbEmEIWR1IASBebDK1jQj6AmpyXecGDYS+4uQsNzqpSeNCpP7vRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jS0y8K5c; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jS0y8K5c"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-82a3d3235c9so3098043b3a.2
        for <git@vger.kernel.org>; Sun, 29 Mar 2026 05:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774789168; x=1775393968; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P+KEq34s7Uwu3520tZojGE206Lh2/4aCvKMJu0Cs73k=;
        b=jS0y8K5cHr56a2Kj90fNB3EugR4aOjtPjSJO7MtgXB5paikP5ySOQ/TomLL7JfY2+Z
         9JzGdCsG2rf6nJMR4Vwvloqvd4Gh8AGx7+lkvNF7FXlwSSOWCF2Qi1KHq4+aJyoKp08S
         WhbntVwQYug9Q/tGD56TLa+3iz7t74xU+tcy2LJPUAtoWRG57rTAb+nYxzI3K7j7e5O7
         nZtUxNi+OIkW6dnP6F/gENpNhlg25+82RdpypUZ7dwgCXVk1WkdKR15e80tJJ7lXFZbr
         E5zsMYUVzNbVZ0vOCxass605FbHGtq6C+lFW/v2o3glc47Af//PTmhMdw/l9u2G0y+e7
         tmAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774789168; x=1775393968;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P+KEq34s7Uwu3520tZojGE206Lh2/4aCvKMJu0Cs73k=;
        b=AprDu2BFcql5KP+BKm/VZO11FwBpKhhD0pRNOSwoU2IT02RfzWHl5wWSi1q7+jOPdL
         VYtuni0WfcuiC5Ye8Hs4Iz77icNhphjoBXjBnR0sbYynGm7Ilx0WtBMRvv2/hRr3koPX
         sETXqYRVhNcK4llJtXLD2GI8JsBhYPI0SrUvNzK9oi/GOS5tvoKlKiTI2EpHa98GT8He
         5WTbeB58QUiOLMu3ToY6FRZ8iUfe1ZHXQhUo4QN4PzFI8B0c20QRSUB/bNtHfX8uLv9t
         g6+xMYpJ/vlllUEWgyUBWZRjw33Q6UOaN/a8ZJPqVcpqa3gBfG3dhiozCTkFtST2hpsL
         mUMQ==
X-Gm-Message-State: AOJu0YxYyUmPa91xPqKDAhZh4zXZ14UdXD6TJqRNUUbOZGx3Rm5iBpeM
	PVOGV1P5bbTA5N0JWrwu7Gk++FfPmpiKTggNWn0zl/+kuecewVJc1BuT
X-Gm-Gg: ATEYQzwfkv6/BDazCT1smWy6KfyP9zRjKBNbc/uWXwY8RgDutKzFdtVQTO7U6FTl3yY
	olwrMIoLgCvAnFVuUxJYS/u3dSNDvNosZf1TJrzbBcwOJ031Gmu0ogmAs03gzbq6WhlPEe1dPOa
	je2BYfGp5OYLBNe7c74zRL2aAnjKSFL2ELmmGCWDyoP/BEn1YV7hPX8KQfgvGaSg7v5V+xBm8cJ
	zVIH6akuZj+vS63/VlhQRx0XQZhEg6Y6ALMgIL1nyeSpa2xrUhdp2bvXXwbgPTk0jgJrsdIaQkD
	aLnM+QKfHdMullT5P/OGhrbQpWXqNi3+E/LUzD7F6PcAj6MkDEZcolWZIbOr5pvc6jpc1A/gAoF
	yAVJWkjDaoJjQYIpKHQEGmTmJCgudFpNiUUCs9uqDWf8wZ3I6XUhgamwe0IaenWfofgYbZ7g6Jj
	EOKf+nFrnoCyfUiO9iLgHbu+U54TnlGQ5EuA==
X-Received: by 2002:a05:6a00:408c:b0:82c:6f07:2dc4 with SMTP id d2e1a72fcca58-82c95c175eamr8890583b3a.21.1774789167950;
        Sun, 29 Mar 2026 05:59:27 -0700 (PDT)
Received: from localhost ([123.19.199.205])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca80d0b6esm5147775b3a.0.2026.03.29.05.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 05:59:27 -0700 (PDT)
Date: Sun, 29 Mar 2026 19:59:21 +0700
From: Trieu Huynh <vikingtc4@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [GSoC PATCH 00/16] Microproject: avoid suppressing git's exit
 code
Message-ID: <ftwnrutdbvyf7phr4ad76agt2jvzgieqnxprvmoyw2vzwbhgqy@z4x2g2n3ft4r>
References: <20260328200255.247759-1-vikingtc4@gmail.com>
 <xmqqpl4nh3b3.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqpl4nh3b3.fsf@gitster.g>

On Sat, Mar 28, 2026 at 05:44:48PM -0700, Junio C Hamano wrote:
> Trieu Huynh <vikingtc4@gmail.com> writes:
> 
> > Piping git command output directly to subsequent command (eg. grep)
> > hides the exit code of git behind the pipe.  A crash in git would go
> > unnoticed because the shell only sees grep's exit code.
> >
> > This series extends the same fix to 16 more test files, following the
> > approach introduced in t8003 [1] (redirect output to a temporary file,
> > then use test_grep on that file).
> >
> > Note: t2206 is a special case -- some tests cd into a subdirectory
> > that is itself a git repo and run 'git add .' on the whole working
> > tree.  To prevent the temporary file from being accidentally staged,
> > it is written as '../actual', outside the inner repo.
> >
> > Related-to: https://lore.kernel.org/git/20260328132955.172262-1-vikingtc4@gmail.com/T/#t
> > See-also: https://lore.kernel.org/git/xmqq4im2sjnu.fsf@gitster.g/T/#t
> 
> See also https://git.github.io/General-Microproject-Information/#:~:text=Only%20ONE%20quality%20focused%20microproject%20per%20applicant
> 
> Thanks.
Ack, I missed that point. Could you clarify how many patches or
files changed are considered appropriate for the microproject?

BRs,
