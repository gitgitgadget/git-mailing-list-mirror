Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448EE1D90AD
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 20:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759869423; cv=none; b=PC/tXS+gMGK0WOhydz57Kui/Pz710Lg9cYu54goJyAeB6YMxYssDrPBi+L5x45QBEf3e5lGXIanK99WA+ukQ/HQy7putdgkcpE8x0rPOrtD9yPxB8ZgXbxjREvj0us1EwqecL+qFhODo2fZZDU7zzV7KP8hF3I1fSnPwPYztTfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759869423; c=relaxed/simple;
	bh=+H+hL2ZUnzicx9IJLK8OOyRDkNt/PNJ17q1Lt7OzKlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=env41/qSTcSmcytO9awZ0uoT3DfzwsQUOHyv38nSuvRu2u0J8SxSdyiUrpuVuShPbKPspWby7M4Lbn9m+X9/lwlhjcUqtSKghuONLMtyLxyR4PFT/KgSTppm64Bw2qApUNDBSdzoyTwixS5McwX8FSGnA6i95oYb9qUxhFnC0q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=B9sbbvna; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="B9sbbvna"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-42f7a4bf805so19379885ab.2
        for <git@vger.kernel.org>; Tue, 07 Oct 2025 13:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759869419; x=1760474219; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ccGHUa/Bh6zZLIEoWyFXC2iZW1Il+MjWgTuBUGuUmOs=;
        b=B9sbbvnaOedRvGc+6E84e/N1OREvW1YxfZfz7zDr4W15PGRiy7Ao/goo46ikmyOlpb
         4Fu9s87NLlqvZq0E4WayL8qTii8Wtzd/ABcVzC8krWj+d0qoAwVavtVrYFKTcJ8Fzoug
         b0HOqifpNhiCbNifXIHPJaT1+1MyH5Q3swVxn4lRWnmO39Mi99mvLVF6y3WWvjbnrt95
         wRDHGgo3DU85gsxakGnpLivkhK1twSXNnVMLw/Db81TPMcw3sE1UHWtlE0li12TVS9e8
         q/2UWk6apfbpNdIjXBfIeDDXRxCZUPGYyUXgAdWHoVBlGPNHyY45u7lgpwc0qKaQmvgP
         Ed6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759869419; x=1760474219;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ccGHUa/Bh6zZLIEoWyFXC2iZW1Il+MjWgTuBUGuUmOs=;
        b=kR3pM50wM1pKdZp3Kr2VUGaOttlDKBndq2cAn+pyUWmCIQNy3XjPz39zX5QmDezmzj
         gvpgfTjfxuJ1msTKa+vj31Jq8lR9aGeShiKXtaqVipWgNQ7tWUsy9DBvodQChcHbQix+
         BNtEoxXyfGYmjmT3u21t/Pfb6hHtNMk1wojkpphClc3uS/akHclnIR9/GkV1fgXJC/28
         XbMSFsDb/zBsIVZB+eqqwsB0ZCi6MxTOWMhgYqJ0+rUbUFhLlv3c433knkij209b6YfI
         JKdjg5fqaiyzJUpTFvFdEDozNEaE64QsAbGvnZ9i7BzX7Hf4uCwxjlA78jLiqKws7L9R
         JiTw==
X-Gm-Message-State: AOJu0YzT1hLgAWyeGdynz0hc8FaX6oJ4Y7G+NtCZ+RxOdW3zL1mIqPFs
	7hTDcaike+2KD16ak2uemynq1skGiu66Y+geOgXFr830aiuV7OnUV+GdMZgcYEUW55w=
X-Gm-Gg: ASbGncsXlXLFWxenTcpV+EEwF9val7HugIXWUVV9e7iieEXIZkvKZJnPbbffpWJjRa3
	LLa71hsG/5zs2uvxbw8RjnWt3GzzDOeCNJoQr+YNubEa68mLp7pfiDGqpxBhfGm3dZQgTSM2VHQ
	ZiYTMCli7AZMCLqKo7XNuTy8b+MKIecpxN8n3VVldmH++9mIEyniSv0U8W6fNNQFc0em//XJmnV
	eX2X0cCHgraai4YSgG8+3x7ACbZrtcGHfdudhFQoqu6pz4E/nzALAmfANAM93GTtu5pbpkBRkwv
	J/hxRTA4I/3BkzT76I0yY3r5XFqfkMj5iqWrbuHDDDPubDhJei8It6hGoCJoloRoY0SRPBz3DZp
	Nu4RFvUfCJ0bfv5jpJN/CL6U9pHp1MKnFXMcN2PlMnq37NyslcUtQSjxvOavbLDucxH6s5DhNQ+
	8PXgG9SUB/NbJCihs9rB1/JAgqx2uPPPq5n+xJUj3NiuySwZpxRw==
X-Google-Smtp-Source: AGHT+IE5v8HACP4b+gdhgSUOF7dg9pK+nDF5/zhe0GDqNVvuGtlqLrttlu1YUDSeCN6DLMzppgIAHA==
X-Received: by 2002:a05:6e02:3c88:b0:42d:8b1c:570f with SMTP id e9e14a558f8ab-42f87351e26mr9077125ab.4.1759869419258;
        Tue, 07 Oct 2025 13:36:59 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id e9e14a558f8ab-42d8b281664sm69596505ab.25.2025.10.07.13.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 13:36:58 -0700 (PDT)
Date: Tue, 7 Oct 2025 16:36:57 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH 26/49] builtin/repack.c: remove
 "repack_promisor_objects()" from the builtin
Message-ID: <aOV56Uzley6ebswk@nand.local>
References: <cover.1759097191.git.me@ttaylorr.com>
 <3ba6e86f6116cc42fc8f7d31707dd514f4bc16a4.1759097191.git.me@ttaylorr.com>
 <aNsUl2afoigZZiLm@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aNsUl2afoigZZiLm@pks.im>

On Tue, Sep 30, 2025 at 01:21:59AM +0200, Patrick Steinhardt wrote:
> > diff --git a/repack-promisor.c b/repack-promisor.c
> > new file mode 100644
> > index 0000000000..8bf42fc715
> > --- /dev/null
> > +++ b/repack-promisor.c
> > @@ -0,0 +1,102 @@
> > +#include "git-compat-util.h"
> > +#include "repack.h"
> > +#include "run-command.h"
> > +#include "hex.h"
> > +#include "repository.h"
> > +#include "packfile.h"
> > +#include "path.h"
> > +#include "pack.h"
>
> Nit: these headers should probably be sorted lexicographically?

Yup, definitely. Fixed.

> > diff --git a/repack.h b/repack.h
> > index f37eb49524..19dc4fd738 100644
> > --- a/repack.h
> > +++ b/repack.h
> > @@ -74,4 +74,8 @@ int generated_pack_has_ext(const struct generated_pack *pack, const char *ext);
> >  void generated_pack_install(struct generated_pack *pack, const char *name,
> >  			    const char *packdir, const char *packtmp);
> >
> > +void repack_promisor_objects(struct repository *repo,
> > +			     const struct pack_objects_args *args,
> > +			     struct string_list *names, const char *packtmp);
> > +
> >  #endif /* REPACK_H */
>
> I'm not a huge fan of the code bein gin "repack-promisor.c" while the
> declarations are in "repack.h", as it makes things harder to find from
> my point of view. But I don't feel too strongly about this.

I think we have precedence for this in other places throughout the code
(for e.g., "midx.h" => "midx.c" and "midx-write.c", "pack-bitmap.h" =>
"pack-bitmap.c" and "pack-bitmap-write.c", etc), so I think it's OK
here.

If you change your mind and do feel strongly about it later on, I'm
happy to adjust it ;-).

Thanks,
Taylor
