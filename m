Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DE5218E8B
	for <git@vger.kernel.org>; Fri, 27 Jun 2025 23:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751065556; cv=none; b=dctqy+wPTN3jCpTd+fnMqr3NSS8DyTZ4iUMjdJOrUq1qnVy/fWAiY4+ECqjLo7CxYf6I7OZAtKWYm6yly/pfgO2Zcq5Zw5fo7M7VJVZoi3Qx4C1L2pKIp9R57snG4unfumyxyw1Pq35gwHJeK3bAayi/AdhmBYKpnZYx+iT1Kfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751065556; c=relaxed/simple;
	bh=sloeRK+GSwkX8k+ea0uq4ueM02ubw/ZTdfq696W7U04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s2pOIG04rfYLAx+QSA5pkvPCtqgo9mUrMOPgt5juaQgPcRT7R9zN27mt4TjptpGPkvjTbxRj+qWgl2LBSXJpGamebN1vuivpKvr8j/F0Bl3RR7Lb0Dxu4srk9lHqw16bXNCSvPKiLMxTmp1ebktZQhFO4gZEgTlq6s3uyaGqLQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DQio+Awo; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQio+Awo"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-313bb9b2f5bso2568053a91.3
        for <git@vger.kernel.org>; Fri, 27 Jun 2025 16:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751065554; x=1751670354; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=F9Wiz5bCJGgRfmxawvMKFzwSuuWCBOlz3eB52GU0Z0c=;
        b=DQio+Awo2ZVikrg+Cshlx2hoZvIEtJVfbZtCz5cclQVIMr+2DrhWkIBH2fxZ+JSuIp
         qDFt6N/xrolWtdye7uzj8FVGl8y/wWycIOKwOWf3FBxJa95DpG73nYqOuh4+SMt+6A+R
         6IkAI7X9FfdG4EJYQs8vtQJIZjc1PdKTKSLhOqgrMjw7ZmIblyShlYan6Jt+93pxH40H
         xi1dGVgo4CGGoiT9pI//8Tk85FBHOcdgLwMxr5Vha6ui34uwu+2BdEFMV7op+YSjkbiG
         txInEUEScgj1+yMHLXf+whHhZ8qULA5WhpxO/t0QcJVc+JajbYfvREecQWpFY1UnwUif
         3Zow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751065554; x=1751670354;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F9Wiz5bCJGgRfmxawvMKFzwSuuWCBOlz3eB52GU0Z0c=;
        b=Nk6CYPJnBAaKDhFVq00YX8+AASdDfmwvpYlrBX/mvr0pYqZQAfp5B4vL/yuJwQH195
         Rs00NmylOADMi1L/CuXMJ9W8uE3B/fR5gM2Xu4NlcIT6z5alD212IjQyCrXCWnzuiOrl
         vDKcDj/ydGe61pXpRhbP9UFO9k1td/BkhHE9HhEFoikHGMbVoO4/00PDZbfRBlhDfb61
         9HLVyGG8u8cQH+QTna/HlJM/As3ZIe0osQZfqII/xFJmi3R1g1DfjO/KFKD9XbRAgPBF
         tTOam6/ES+4LmrO5KZZgHqqdWEXu2Z2mRXiQr8K1UJV1nTOWs7ilarOAUdl7BbX6xAZR
         srng==
X-Forwarded-Encrypted: i=1; AJvYcCWFHwxVpVY1MNDP+N4EZRAIzk0BE5oyKts3z12HPZv+MevxPFY+XDt3qWZ6v4cD7yoMxas=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZTq8N5D5LpoqbFPM0SekS9zgm08JvxzaAnMqTvfSB4/cRhh/J
	ikiKRI1kAVnN2xGYi6hujC4oKsMvHpcwCyv50mtMFJg/CtGgzopjvYQN
X-Gm-Gg: ASbGncsuoz+dBHxSbvoqWIikUXA7O83b4O0DVchk7s5HC8MqRAU5Bv7OJj1RAVno+pP
	G1VK8KpZgJAQx4VMq4Ps8g2l4Lp1aOjp2IMHqpwmmqPf2M4EBhZlyD3Aziq7kFln2bT9Cqqu39/
	CgVH8v72KbipOkOcaNFgfeBvYIWQH8B4Ek5tR9dnw55mLeDdVlpKXi8XKRRERQPqUsGjLjgwur0
	hl8MTGE92p8Ig2NOU+CIFgsyXmAzs2nlQYEHJEZUvrcwbtNhSm+IXL8f/g40z0cxjswkKJXJBSH
	MjOLkiE3r2toDd5uOOGi+64jXZyVB31FKw59pngsuY7sAIsCz19td439tqATBI4jujj52WQZun+
	3pnjVgFbkB/AqhHiHiB/A9e0=
X-Google-Smtp-Source: AGHT+IEpQycRLWuiSSG19MV1zPHd1200NSFqDqYEvuBcx3119Z4NXkvaP5MdBS17KPhFP+p3ko/0lw==
X-Received: by 2002:a17:90b:3e8a:b0:311:ff18:b83e with SMTP id 98e67ed59e1d1-318c8feefcemr7748938a91.9.1751065554374;
        Fri, 27 Jun 2025 16:05:54 -0700 (PDT)
Received: from Carlos-MacBook-Pro-2.local ([2601:640:8e80:3680:fdae:9b06:496e:5a9c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-315f542708esm7770951a91.30.2025.06.27.16.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 16:05:53 -0700 (PDT)
Date: Fri, 27 Jun 2025 16:05:52 -0700
From: Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: phillip.wood@dunelm.org.uk, git@vger.kernel.org, 
	yoshfuji@linux-ipv6.org, kristofferhaugsbakk@fastmail.com
Subject: Re: [PATCH v2] daemon: correctly handle soft accept() errors in
 service_loop
Message-ID: <vgailqqh3bcip3gxtdffoo4ey7xjso4xerewxncy22shrzn4k2@25hst4sfgxq4>
References: <20250626161038.85966-1-carenas@gmail.com>
 <20250626172159.87204-1-carenas@gmail.com>
 <08804dbe-56dd-4c0e-b36b-a82768b0aa29@gmail.com>
 <u4scxaxivz62fsljo7okkfdvcle3zdby6h2sdzd6ed5n6wi5xb@5ekxdycixwxe>
 <xmqq34bl7xa1.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq34bl7xa1.fsf@gitster.g>

On Fri, Jun 27, 2025 at 01:19:18PM -0800, Junio C Hamano wrote:
> Carlo Marcelo Arenas Belón <carenas@gmail.com> writes:
> 
> > On Fri, Jun 27, 2025 at 09:38:47AM -0800, Phillip Wood wrote:
> >> 
> >> On 26/06/2025 18:21, Carlo Marcelo Arenas Belón wrote:
> >> > 
> >> > diff --git a/daemon.c b/daemon.c
> >> > index d1be61fd57..f113839781 100644
> >> > --- a/daemon.c
> >> > +++ b/daemon.c
> >> > @@ -1145,6 +1145,7 @@ static int service_loop(struct socketlist *socklist)
> >> >   		for (size_t i = 0; i < socklist->nr; i++) {
> >> >   			if (pfd[i].revents & POLLIN) {
> >> > +				int incoming;
> >> >   				union {
> >> >   					struct sockaddr sa;
> >> >   					struct sockaddr_in sai;
> >> > @@ -1153,11 +1154,19 @@ static int service_loop(struct socketlist *socklist)
> >> >   #endif
> >> >   				} ss;
> >> >   				socklen_t sslen = sizeof(ss);
> >> > -				int incoming = accept(pfd[i].fd, &ss.sa, &sslen);
> >> 
> >> Why is the declaration of incoming moved but retry is declared here?
> >
> > Separating the declaration and assignment for incoming is needed so we can
> > insert a label for goto; moving it up just removes distractions so the rest
> > of the logic is clearly in view.
> >
> > Obviously that includes the definition and assignment for retry.
> >
> > How would you suggest to arrange this better?
> 
> I think what Phillip meant was more like this, perhaps.
> 
> 		socklen_t sslen = sizeof(ss);
> -		int incoming = accept(pfd[i].fd, &ss.sa, &sslen);
> +		int incoming;
> +		int retry = 3;
> +
> +		incoming = accept(pfd[i].fd, &ss.sa, &sslen);
> 		if (incoming < 0) {
> 			...

That seems unnecessarily restrictive just to minimize churn and leaves the
deflaration of incoming strangely sitting in between two assignments, which
while it doesn't trigger -Wdeclaration-after-statement seems to go against
its spirit.

Will include in a v3 with all other suggestions, but frankly think that the
original was overall cleaner.

Carlo
