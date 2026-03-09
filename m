Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC0735CB81
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 18:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773081954; cv=none; b=rm60ewmg0yxoaJ8XZ4OrPO2HZepxM/H3dNG3VvjJSFqJIEi6fkWjMIaZpNWrQ4YR+5gCcAhrPmUf8/a0WnB3rHABCQspqO1jfKs7Ck9vniHYmm0tILd0eQ3Cvsj9ZTSgiF0WFM3dJU+7DTsycxz2CXG/dGZWphL6qVwcDL+UDhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773081954; c=relaxed/simple;
	bh=SsZ8nLmSk/1kx5qMeQruq5XwHVABtKhsZqha+AIQuk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O30FE8X8rSTw9DrPj63UDKYmg2nnr8UAUz/RaLDlvYYLrtkimOTCZ97eqNa12024e9HFsXG5nKMeqhXKfKHA97h9WUNVmojjll/KFll0RE2+Wh1JMvdQ1985KTWdOAj19YA6HhY2uo9GP1HyLvn2KoDNr3cEY6eeI8zMSApsQRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A49x6J3W; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A49x6J3W"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c73a5473bbdso773061a12.2
        for <git@vger.kernel.org>; Mon, 09 Mar 2026 11:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773081953; x=1773686753; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SsZ8nLmSk/1kx5qMeQruq5XwHVABtKhsZqha+AIQuk8=;
        b=A49x6J3WjCCC2zW400+6q6R7gdqCaoxgWWoNRKsfhzdktp9FcsG5h3HMjJWgkxzT+C
         tS0R7jbwvoi7GsRgWlvMPbekDMy2rxNBLLRQST+m8ULF49jBYftBGASWAsh4UmgN90Pq
         xYd2qbO506Q7dXhgwBuoP0zEUouBw2YU6CYPKscdh6noBXffBiaAnGcBBoFwbPXdDsaU
         yyZJJOQos5WCc7pQpw6wN8rLmZkW89Jb19ySlxYm8EhlwSDd8gMhbNyJfZoBaJIBxTX+
         6qF+cS1YQ7tA65+9DIZggA2rlVzgQqBr9WCk/f2niP4UIqQ7fBbMkAnvdkaip8g3KHqa
         XVsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773081953; x=1773686753;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SsZ8nLmSk/1kx5qMeQruq5XwHVABtKhsZqha+AIQuk8=;
        b=Q8j/3spoYSeS26kYIh5qclIxkGktvBB9u8ot9Zzk/Da0Q3nKJXx8hh4bTZe6GlCrhG
         FR6E/Kx9pIq1Ki4tCEfPTMHTWWQc6yIfy9k4kPLEGnOEn3VQLYZNkTDX4Rrdgo1l5IlZ
         cLh/rS/q9BbcuNpTe5oJU2gUkji1QIqmXpB7UDOmwy5sE2Y/KGDMy/yjL29hI1mv5E4H
         mKlleQ+uQcP3nCuDrlhIzouvtenFvukXLGgQugGhL8ZXaSEBGjJYlcY3FYvmaoy37WVV
         qWoiI14RBbGU3wYdjdN43RtYbqlG34XPEXjquMHwbVKmQQ2xsFfHm3img9S7gPSu0Ldq
         AfSw==
X-Gm-Message-State: AOJu0YyqMOBXB4ksaAeuulOKf6xoLmVeePjSJKmjeFZGnf9pLQaI1kz0
	BV4P9IZNQ/dIHFHRlXJWdKfWmfrv2bGsSbcEXHHwCUrQ31P+ycozZfrB
X-Gm-Gg: ATEYQzzPIa9ziNXNMmiyNp4wMxSugRzqmKKnWcu44hz6OdyKRu8JhUgl95Psiy7p+uD
	fmSSLlGY0mHmcaEw6TWsok9aiw/+zssNe3Kqv2+iE8lLVjC6zlM3ZRDqDil6iMDz13hoMhfzX0o
	SZs7T8tzjFyirXyjzwb5efBmNV0UyqhDIqTCftLn7WyX1Cb+poHE0TDpMiuLzkxkpJ6o/i5Ma3j
	TDc62YL2BIPX5sfpIgq8kBsONNxHeyOolN4A09/iD0yo2hUWNxmvyi3FRPX+GzK7s4i0G/TC0/g
	MKNt3arGwW7FtFPh5Ancyp2Vb+3tbmOnxFZ0wB1zl5HOskvUIvLBvR5sV2Y5HuQQiD3ua2d1DmI
	vQzWHjH3rIBbrtXXDz2utKcQaFFWUbbMCxrkD8moSBAu9yRBEt7XLMrct7Z2sWYVVllTT6+W6B7
	3M8TvPqK4qLT2JLDVF8FNNhJvwaPClYJGNscNur5ZuApXvtfv6ZUfFK2u9KkmZzsbRWHdQWfrCc
	T+YpT+PSdvS0UhJgBn3p46sR0G+jwdwk1djDZHngwBYA7RqQKoblUA=
X-Received: by 2002:a05:6a21:3988:b0:398:8f38:441a with SMTP id adf61e73a8af0-3988f384c93mr4284327637.0.1773081952645;
        Mon, 09 Mar 2026 11:45:52 -0700 (PDT)
Received: from ThinkPad-E14-Gen-6 ([220.158.168.165])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c739e16cebbsm9600602a12.16.2026.03.09.11.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 11:45:52 -0700 (PDT)
Date: Tue, 10 Mar 2026 00:15:46 +0530
From: Yuvraj Singh Chauhan <ysinghcin@gmail.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [QUESTION] Improving disk space recovery for partial clones
 (GSoC 2026)
Message-ID: <aa8VWlv7dosrrRwv@ThinkPad-E14-Gen-6>
References: <aa65h6Z_TrpJbmkj@ThinkPad-E14-Gen-6>
 <CAP8UFD3sicsPd903FU8bsj2B_4Q1DE1xB+--OxryY_jhL=sHdw@mail.gmail.com>
 <aa7XkqhcG6Kb6IhN@ThinkPad-E14-Gen-6>
 <CAP8UFD2iM-z7F_FeDkP5v=1OAJhS2AcFsgPnicvHNFMUcmxbpQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP8UFD2iM-z7F_FeDkP5v=1OAJhS2AcFsgPnicvHNFMUcmxbpQ@mail.gmail.com>

I have been studying the different commands and how they work, I will put together
my understanding in a pros and cons list for each command and send it asap.

Also the contributor application period starts March 16 and ends on the March 31.
Can I complete my proposal for community review in between that period as well? or
should I rush to write a draft version before that.

sincerely,
Yuvraj
