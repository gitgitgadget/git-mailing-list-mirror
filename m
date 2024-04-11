Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76E941207
	for <git@vger.kernel.org>; Thu, 11 Apr 2024 23:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712878611; cv=none; b=c6+aD5fnOjMa0ZEjxwUaSAL3tKnVyCbU0PqNGVUXJZJ6URCq+H4G6EfG8oiexK7uRwkaZ8tEWrh0N/FOK+UcgRdHnALLPI4syimsFgEcP89VqV6WV16QxDMoB5Npa+QGKSuIP1u1g+2t4/s5+RM8zQjmFx2TmaCCQxEiG+Ag/sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712878611; c=relaxed/simple;
	bh=jKZlFrhb4LnTY3SuZNP+EN3Rd+It/6tchoMfxKWl2FI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FyXijcubbikGQc/8y6u1dGNGKTkgTJdicTwTqRdhK2J6SFXdFKokRVZviG/J/57OEaJEyRgL5Re35Nk95VDFP8MQufnLfFjKEu82Al1/6xJOmJkvdcw3yh7V4vo+Fa6N5R6qFlvyQxQnaJXZelcPtrQLPuSNYIpqxtjRCVv250M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OUuXd0qH; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OUuXd0qH"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-417d029bee7so2662345e9.1
        for <git@vger.kernel.org>; Thu, 11 Apr 2024 16:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712878608; x=1713483408; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=novsrEnBq89VCJIv77ox8aHOlvCP6kPuVR2y9fWNKN0=;
        b=OUuXd0qHYq/BnGo3lJa+uvNFEN46CalKo5IhFUj/hRftcrHin5KyqLuR+BjDpaHCLY
         fSHaZBYC0mnvgjhXSUgORsXbJ8LxJHnVLQbnBfmE/EQAldkbXjIqNrnWHtv6jPnuFtNH
         A/Rn8Bxy3o8PeE0wqRQIBxXuseXjYHYgJIk145z9Rgvff0SVnUHyyokdY0V0ePL/zGMc
         gkWz+PVwkpvxi4Fhh7zSebTfkEGDAW2Yq//DKht09TkewSlHPIXE+ImL1NZ2Spe0Gpuz
         BJlc9VU+CQRsI00lnpi0MVCyDzC83CoD10gvaoqhNuNkSTb2XitHzKHS/1GTb7Dml84F
         u3Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712878608; x=1713483408;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=novsrEnBq89VCJIv77ox8aHOlvCP6kPuVR2y9fWNKN0=;
        b=ma7qyY+fJNMOV1V674SUI3tSAMxaBfIqekfT/QGKe927A/p6hF9BTp2WWb7A9iNB3D
         Ln0J+kFsWLDhekEEJNfuccdRXhEdBADQbdlfndkI1OcyHBYoBRN9je95XPznyRCf9dDW
         TGWg7XGxSO0RFx4bkzdojuoImq4oMzoB12pQaj/i8AXnr0geqEupnhhoR+Sx5smMjAbH
         E/Br640pIz2Z7dcj5s9lMybOk4qiYYk2eMZhkT1jL4312vgkc0bzz4UwqVg5cLFjB5oW
         DSTi8S37GliXRn0ed2IXUYK1UTu5XA5FcBniXN+CYu1ltq9NG+0dMKI1mY2Xfx/jjvek
         8Cmw==
X-Forwarded-Encrypted: i=1; AJvYcCX+RIxRsG2STsT9aOqfJYUF5V9Y185X2042c8N7aVMo0+InJSP4DyQO9ahkoPxXlIF+taU4XXlWiSJieam5iv/gtW+g
X-Gm-Message-State: AOJu0YxUgwF0k5oRcqyFOam7AqbW6G45Gqmg/LaAZytsoZDTb3wpJ0rB
	7efjcXgtbC0AwxcOngluMPp8H56D14xAsvcMZ5Tf5z3R57bPmeKD
X-Google-Smtp-Source: AGHT+IEB5RMB6O72/83QESJGoGDR5GnyF3K+w83GVRqZExtlJ1ta+ZCf7Nb/V5hNsbo8Wv+W+ThhKA==
X-Received: by 2002:a05:600c:4511:b0:415:43f2:332b with SMTP id t17-20020a05600c451100b0041543f2332bmr897304wmo.2.1712878608058;
        Thu, 11 Apr 2024 16:36:48 -0700 (PDT)
Received: from gmail.com (188.red-88-14-41.dynamicip.rima-tde.net. [88.14.41.188])
        by smtp.gmail.com with ESMTPSA id p1-20020a05600c358100b00416b28651e1sm3763074wmq.36.2024.04.11.16.36.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 16:36:47 -0700 (PDT)
Message-ID: <f4dbc3e7-5b8c-46d4-a7d6-122e34e0d922@gmail.com>
Date: Fri, 12 Apr 2024 01:36:46 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/12] git_config_string() considered harmful
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqttkeicov.fsf@gitster.g>
 <20240407005656.GA436890@coredump.intra.peff.net>
 <ef8e5f43-5f27-4f0a-acf5-cf4f8281a8f8@gmail.com>
 <20240408205511.GB1639295@coredump.intra.peff.net>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
In-Reply-To: <20240408205511.GB1639295@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, Apr 08, 2024 at 04:55:11PM -0400, Jeff King wrote:
> On Sun, Apr 07, 2024 at 07:58:02PM +0200, Rubén Justo wrote:
> 
> > After Junio's series and yours, I'm on the fence now, but my envision was
> > to introduce:
> > 
> > --- >8 ---
> > diff --git a/config.c b/config.c
> > index eebce8c7e0..7322bdfb94 100644
> > --- a/config.c
> > +++ b/config.c
> > @@ -1345,6 +1345,15 @@ int git_config_string(const char **dest, const char *var, const char *value)
> >  	return 0;
> >  }
> >  
> > +int git_config_strbuf(struct strbuf *dest, const char *var, const char *value)
> > +{
> > +	if (!value)
> > +		return config_error_nonbool(var);
> > +	strbuf_reset(dest);
> > +	strbuf_addstr(dest, value);
> > +	return 0;
> > +}
> > +
> >  int git_config_pathname(const char **dest, const char *var, const char *value)
> >  {
> >  	if (!value)
> 
> Hmm. I think that is nice in some ways, because it is a much bigger
> signal about memory ownership than just dropping "const" from the
> pointer.
> 
> But it is less nice in other ways. Every _user_ of the value now needs
> to care that it is a strbuf, and use foo.buf consistently (which you
> obviously noticed). Likewise, any downstream writers of the variable
> need to treat it like a strbuf, too. So the parse-options OPT_FILENAME()
> macro, for example, needs to be replaced with a strbuf-aware variant
> (though arguably that is an improvement, as using the wrong one would
> fail catastrophically, whereas using a non-const pointer with
> OPT_FILENAME() creates a subtle bug).
> 
> I'm also not sure what the solution is for setting default values, like:
> 
>   const char *my_config = "default";
> 
> Of course that is a problem with my solution, too. Perhaps in the long
> run we need to accept that they should always default to NULL, and
> readers of the variable need to fill in the default when they look at it
> (possibly with an accessor function).
> 
> Or I guess the alternative is to stop using bare pointers, and carry a
> bit which tells us if something is heap-allocated. Which starts to look
> an awful lot like a strbuf. ;)
> 
> I think in the past we've talked about being able to initialize a strbuf
> like:
> 
>   struct strbuf foo = STRBUF_INIT_VAL("bar");
> 
> That would use "bar" instead of the usual slopbuf, but we can still tell
> it's not a heap buffer by the fact that foo.alloc is 0.
> 
> -Peff

Hi Peff.

Thanks for your ideas.

For the globals we have in environment.h, maybe we can keep them const
and avoid the other inconveniences, doing something like:

diff --git a/config.c b/config.c
index 146856567a..ead3565c27 100644
--- a/config.c
+++ b/config.c
@@ -1671,8 +1671,13 @@ static int git_default_core_config(const char *var, const char *value, void *cb)
                return 0;
        }

-       if (!strcmp(var, "core.editor"))
-               return git_config_string(&editor_program, var, value);
+       if (!strcmp(var, "core.editor")) {
+               static struct strbuf editor_program_ = STRBUF_INIT;
+               if (git_config_strbuf(&editor_program_, var, value))
+                       return -1;
+               editor_program = editor_program_.buf;
+               return 0;
+       }

        if (!strcmp(var, "core.commentchar")) {
                if (!value)

