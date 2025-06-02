Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B11E1537C6
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 12:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748866571; cv=none; b=DID9TSCBXrU92vRNi2uBUpEQYB2zhdx1VxRK162rQWSrrQTSNcj3r4970N9ZjJ0BdJtBbgl1+aI5ARUYXF2Wuc3IBCAP0URNgLpzOR6la2qJ5rgEsOOXQydgIDqONsXtZ6pku8cG8ORWiOL3XWsLM8NqWwbWXu7arucVkH+Orlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748866571; c=relaxed/simple;
	bh=EP8nciZti845geo667lwNsPfhcJ2lY2LNLqsw1XmQ3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cQ6oOqlBb3RS+f9BLEHrQA3OZgwsK9syxpZcesyIEt8906LkVS1OXugqJ8zjpbQvCPtizDeWIWWKNPtluajGxx4K6bXevewhZn+9ng9WD3SxUQs2F1Uy5L3M+UdFacMclPHy/h0DYTyvHTQDYxCoUZffBJj4gobid3s5tv0kRFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bSNRUHgW; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bSNRUHgW"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-234d2d914bcso29491975ad.0
        for <git@vger.kernel.org>; Mon, 02 Jun 2025 05:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748866570; x=1749471370; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jb35TAS/GYFQlAUCn8oibcrqbmTpESOHGBe0FhxIFlk=;
        b=bSNRUHgWNu78d476s0lhby6tRN3xwbvF1aOQqoAbKmvPDWKybZNHFwTlsyDmadG9L/
         ahZyuK5zQwXnMUuAdMFJ0l2Z/g7vDl964MVcH2q1TIrdPK0xlbhfWduZwZ9/7ERjtEan
         Wu8SyouCJRrgPi/kSLQRypYtLQxb7hQKBdlpmsbMZJ7l2QbHNPnEw4KB8fx1RRsfq3rv
         8jZ/47homL2FwjNr26XXfUKznMXITBdZFfIa7lT8LUOh3HpaYP2YhtnspjvZo+UaRq9f
         QTbwVpi8Is6OFAVoaCczCqcTw7C3Gm+QESDVqGjWeUMfvbrqWFkZT0/xSMt3LxdY4mOC
         LzmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748866570; x=1749471370;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jb35TAS/GYFQlAUCn8oibcrqbmTpESOHGBe0FhxIFlk=;
        b=rrnNR+KcVS7B7H9COZoJjZlp9xFkR60QoXgqRiSaEqJMx/qD6G7SydkiV5Rqd5/zvF
         yG+eml9ee6Pn9oOhAVb7xDYZTo1r2U0HMbrfx/8/Dn1BwgSltumtmnaAGMGSCX6EgkTl
         3tPlOvgqRQtlyqa7HHcLDQhqp3BQBtlhGVi11q9G/ZHBuQts+1mD5fyfccg/IBnma/Ro
         xr0RAk+MPVrJYNBIgQIzietrx/swabcqGQQa4rSv3e7KIcHq0p+OP+zgUmbqinvdX9JX
         QtVozHCTPMA++tDFt2TiVYCdF5HDkRHU+TiHLHlVPbKY5PI1cbk5CA9eWarnARXbf8xz
         dGRQ==
X-Gm-Message-State: AOJu0YxV5fx6JYHldzH+xt+dQ79O7vf8K10ifQWLDGD6LxPHd1dJGCUi
	AjwFVlmt1WYwR3KHQDouZ7DkwB+c678u3CuTw6Z6DzGibuQbNECG7NgP
X-Gm-Gg: ASbGncs19pJ6kXG3I/8TxNl9AoSYt46LbfBVkTCq+Rs7V8UrON4AayNdHXvq0xkEs5c
	OZfdSHmZ0deLmabApGcNdJ5SUlqXAKo4pYi4yyoWgJ9yaTP66mOP9x8eWSptNxk6gk23TP6PC6M
	SMUUMu6JEWhPWcAZYcNo3NSQS2TgXBQXILuWP00xplSeGSXfQ+z4AhgCC6vUNZ4f/gGOWzxKsKO
	YQmj8+jAYr2MaJcj7drZu5sMrUYLLdlcrKBbAvuM/4xh7lqWnGn/RhZadZD9p0Wdo363wlrqysr
	lzT6g0/LqZ0vwtWp2lxfR2FtjH6UYzZ1IJgr+AxKz6dUU/Y=
X-Google-Smtp-Source: AGHT+IFKlxO6RBbHuM2LvT+JMQft//njqZGtio5ZtY4BihBksUeHP289+pqvKJxE7y0cCw19xkpR0Q==
X-Received: by 2002:a17:903:1c9:b0:234:a139:1210 with SMTP id d9443c01a7336-23529b46870mr200775585ad.53.1748866569586;
        Mon, 02 Jun 2025 05:16:09 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23506bdcb34sm69110875ad.65.2025.06.02.05.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 05:16:08 -0700 (PDT)
Date: Mon, 2 Jun 2025 20:16:06 +0800
From: shejialuo <shejialuo@gmail.com>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fsck: ignore missing "refs" directory for linked
 worktrees
Message-ID: <aD2WBkxVGilxH5vM@ArchLinux>
References: <1d8f471b6dcb7e952afea834490be195189492a7.1748629208.git.code@khaugsbakk.name>
 <aDp55upE6AhYunz7@ArchLinux>
 <b92b5d93-7f7f-4370-ac79-7d9767bb0db5@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b92b5d93-7f7f-4370-ac79-7d9767bb0db5@gmail.com>

On Mon, Jun 02, 2025 at 10:53:50AM +0100, Phillip Wood wrote:
> Hi Shejialuo
> 
> On 31/05/2025 04:39, shejialuo wrote:
> > diff --git a/refs/files-backend.c b/refs/files-backend.c
> > index 4d1f65a57a..bf6f89b1d1 100644
> > --- a/refs/files-backend.c
> > +++ b/refs/files-backend.c
> > @@ -3762,6 +3762,9 @@ static int files_fsck_refs_dir(struct ref_store *ref_store,
> >   	iter = dir_iterator_begin(sb.buf, 0);
> >   	if (!iter) {
> > +		if (errno == ENOENT && !is_main_worktree(wt))
> > +			goto out;
> > +
> >   		ret = error_errno(_("cannot open directory %s"), sb.buf);
> >   		goto out;
> >   	}
> 
> I think it would be clearer to write this as
> 
> 	if (is_main_worktree(wt) || errno != ENOENT)
> 		ret = error_errno(_("cannot open directory %s"), sb.buf);
> 	goto out;
> 
> so that the condition that triggers the error message is explicit rather
> than having to mentally invert the condition to figure out when we return an
> error
> 

I agree with you that by using this way, when reading above code, we
could know explicitly in which situation, we would report the error.

Patrick has given his safety concern with reordering the condition
check. If `is_main_worktree(wt)` were to modify error (although there is
a minor possibility that it would), it could interfere with next errno
check.

Besides this, I somehow prefer the short-circuit way. Although in the
current code, we only have small code paths after the short-circuit way,
this pattern follows a common defensive programming practice where we
handle special cases early and exit quickly. This approach reduces nesting
and makes the main logic flow cleaner by filtering out edge cases upfront.

So, let's keep this. Really thanks for your suggestion.

> Best Wishes
> 
> Phillip
> 

Jialuo
