Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D4D18E15
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 19:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QwNgcHEv"
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEDE7F7
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 12:06:23 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-77063481352so101840385a.1
        for <git@vger.kernel.org>; Wed, 01 Nov 2023 12:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698865583; x=1699470383; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eH9NFnZFsoBQ2+dpPIXX/wL3f1467k6bV/M3UY213nk=;
        b=QwNgcHEvWx2YMSB+RcOzy73G3k+g8n2hN6FKK3vTHMmkEvIDm5sYFn5fGlSvziPrLx
         oiS97SQEslk/PDxDtyYM61q/udaOdkJS126fVZAau2XiJIOYVnHYHrG3/vsLMRhDzqls
         bHlUGeUeJPsNmqASCGKJoNdg5YfudbC2XqhnvmkOX86VZNSDnySeyqHgezLsV+ckmuOV
         fWLJHFBmYlx1GOCuR8TGIfLZptEuZENB1UWht/Hd53zalga8dVsAdB5ImvS8ArlPYjjS
         eauJwbJ+a56x1Aj/YZE+gzn4u/LBx1AjSitlOiKYZvScfvMEbOoIPeSSV7EdmXI4/4vq
         348w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698865583; x=1699470383;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eH9NFnZFsoBQ2+dpPIXX/wL3f1467k6bV/M3UY213nk=;
        b=mopG0leRkyf7fScHqduDhclrX06jErliroW8Tklb81SvY8hNIwUT6kxyLzrrea70+T
         o1lctEy2lZ3a1pCTds9Oi4OMsdf9QIz8uGDmBe/wR+9HvotFtOscpyrMj8HCakx16m5y
         lPnMlhS+I4MoRLWDgC7Mjg3DkzUAryjQUfXzTkiLLCNfQl4g0v9xD+f5cvQIzGTE/Jsk
         4+OIwAYqPCKvbtehKh25ndDOZkWcm1gpOkDAZexqPer4hiefzN2ySD5KPYdda+5Eilyg
         rnHCD6DrN1bfjhM/GzZlSx4ZTBSLLGh8ax9KUiKD3CYe7CsXA9O3TJXHcG6PX3DTRI5L
         ZsBA==
X-Gm-Message-State: AOJu0Ywm1XHvW//mopufjCPdggkGL7xjnTfJW64lKzZrjr2gGUSANz7n
	oJjPsM4u2X0xjsq9SwyyKSE=
X-Google-Smtp-Source: AGHT+IFnecxMhZo8+85Ww3Rpn1RIR8IbkxQ2L0C8TrJS5eBC0W3sXu4vV5JJway6c/qugZAWzUgEMA==
X-Received: by 2002:a05:620a:2983:b0:76f:b00:4e66 with SMTP id r3-20020a05620a298300b0076f0b004e66mr4699995qkp.9.1698865582835;
        Wed, 01 Nov 2023 12:06:22 -0700 (PDT)
Received: from shaak (modemcable063.135-226-192.mc.videotron.ca. [192.226.135.63])
        by smtp.gmail.com with ESMTPSA id c5-20020a0cfb05000000b0066d05ed3778sm1714593qvp.56.2023.11.01.12.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 12:06:22 -0700 (PDT)
Date: Wed, 1 Nov 2023 15:06:20 -0400
From: Liam Beguin <liambeguin@gmail.com>
To: Jeff King <peff@peff.net>
Cc: Andy Koppe <andy.koppe@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Kousik Sanagavarapu <five231003@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] pretty: add '%aA' to show domain-part of email
 addresses
Message-ID: <20231101190620.GA3139350@shaak>
References: <20231026-pretty-email-domain-v1-2-5d6bfa6615c0@gmail.com>
 <20231027184357.21049-1-five231003@gmail.com>
 <xmqq7cn7obah.fsf@gitster.g>
 <20231028021301.GA35796@coredump.intra.peff.net>
 <20231028032221.GB1784118@shaak>
 <9a1e3e90-3e94-41fa-897d-5c64c4a42871@gmail.com>
 <20231030091011.GB84866@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231030091011.GB84866@coredump.intra.peff.net>

On Mon, Oct 30, 2023 at 05:10:11AM -0400, Jeff King wrote:
> On Sat, Oct 28, 2023 at 07:58:31AM +0100, Andy Koppe wrote:
> 
> > > I chose the "a" for "address", but I'm not sold on %aa either.
> > > I just couldn't find anything better that wasn't already taken.
> > > 
> > > What about "a@"?
> > 
> > Makes sense, and I suppose there's "%G?" as precedent for using a symbol
> > rather than letter in these.
> 
> This is pretty subjective, but I somehow find "%a@" hard to parse
> visually (despite the fact that yes, "%G?" already crossed that bridge).
> But I think the real nail in the coffin is your later comment that we
> cannot use capitalization to make the raw/mailmap distinction.
> 
> > If that's not suitable though, how about "m" for "mail domain"? It also
> > immediately follows "l" for "local-part" in the alphabet.
> 
> FWIW, that makes sense to me over "a" (though admittedly it is not
> really any less vague than "a", so it really might vary from person to
> person).

Okay, I like 'm' better as well. And '@' is a no go because the
mailmaped version. I'll resend.

Cheers,
Liam
