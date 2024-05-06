Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F348656B76
	for <git@vger.kernel.org>; Mon,  6 May 2024 20:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715026483; cv=none; b=jce7hxZ9+NAwF48QlQ6yF1GFZ4NSz4llAk5gljrCpJ088Su/ZZvQ/6t8sGHZ2ek65kn37UWyFw6DKdaTQhGt5oDswhjQ/JKOPRSAZHxvUB1HCi9//IaDSOba6F8egodDKjB/HzSk+X3oHSTVOhx0GaUJtjyuLywm4M/FPIirBGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715026483; c=relaxed/simple;
	bh=la4rzeO1HK4OL8j4jWbuR/yXZjjH73ofGw2y+9zFBGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c4XMEcZQ4BLDO8XB/VJsxkCsa8YDYHolfabbhKb4AiHCwbME4XS7wQVGFD4o6UkNRaMr2ywBePnncm1jMm05ktmmp4tRPgcNWzSDW3qDNtPBmdnLH5CdBk45RrgjYW+Xiv6k61cUB/98yNTeahYFOWmrNrHJSja1MtsKjNiWAsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=hpDjWcpo; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="hpDjWcpo"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-69b5a87505cso13965866d6.2
        for <git@vger.kernel.org>; Mon, 06 May 2024 13:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1715026481; x=1715631281; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=la4rzeO1HK4OL8j4jWbuR/yXZjjH73ofGw2y+9zFBGs=;
        b=hpDjWcpo85W1DYpEDc6y3dhX/Gn+FHh1I7Uz6Hv17l0lUMewRPLEiRSFqRbcWDceP9
         RClIQOmIJyrzr6vcaPMAuMJHW2jmoh0Gpa+LUovboPWeyUyayXOnA8g9B/zb6+MvJkCR
         7+Iqvre/k+9/pxwgzusO1MmAiPtJqLBOws/8zdJz4z6quJ5chi/60AVo32GNhsHzzqvA
         iZNKhbUBId+dscMwlZQlcnxi+cb+IAjGh5PjdpqTpckQFp38vg1rzPa0EyBvufXGHgJi
         gEbzf0bzv1eJiGHxT4Iq8O65ZxAnt5Gtxfopn68QE6vDH6pfsNGxX6sg1V+JBLkVr4um
         Rmxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715026481; x=1715631281;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=la4rzeO1HK4OL8j4jWbuR/yXZjjH73ofGw2y+9zFBGs=;
        b=r+bzvuBgkS09mw+zwzx4sjbodAGoSdyGsz2Cy62883QX7ZjGOftHS5o1B7UdJkMve6
         Ri/Ep5Jugpkj/fP+k5dV9eOlZpZDSsI3RyTi7BdHaIS0YtQxk/MVOq2Nb0g+947RuDCu
         pf8AeWLkyIBur4NZnP5rRzONz2nC1p9XfueIbSVlVaaPHWJj9LvYcIsG8xEC3ZpJIvIk
         PjIHkMXM2487stQOWWxmSOxZdhr2WqMTI+fbC5mImlrNmgaCeTmqrkGD8AU5RzgVqIH6
         NR4sEvOqXrrsjNcyeeHszhQyjjRC0zdRatU9gRrZ/OJfAxwvfUjDvOYx7irM/SCOpH/x
         uFog==
X-Forwarded-Encrypted: i=1; AJvYcCULtyqDTnG8wu36dj+HwbhMeBdWSFgDJ0V4opADHbps6jkopbzmJ4W8vm1oFGW2m2+9hy6Anx3sG/sU5JGGbHeQhnSQ
X-Gm-Message-State: AOJu0YxVvLwinqWFf3R1uF0unq7/1Jm+M6qp4kMSuIpQ3dWDOFI6GvAh
	RUlBe85sxinrxXi5uC/iAiq6BYYt2/PRWuEsJct/kz5X3cYAhdtRjUpkqxCGBL03Y9DtEt38ftY
	W84E=
X-Google-Smtp-Source: AGHT+IF/rdYakG3wm19/gRWlam8Rc2pAvHHwA8X0v8Z8Mq2+ktF71a74414ETzvHZM0fQjlVA3N/eg==
X-Received: by 2002:ad4:4ea6:0:b0:6a0:e827:d8e with SMTP id ed6-20020ad44ea6000000b006a0e8270d8emr11061267qvb.40.1715026480631;
        Mon, 06 May 2024 13:14:40 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id u4-20020a0cee84000000b006a0f4777dd5sm4038326qvr.13.2024.05.06.13.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 13:14:40 -0700 (PDT)
Date: Mon, 6 May 2024 16:14:39 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, Josh Steadmon <steadmon@google.com>,
	git@vger.kernel.org, avarab@gmail.com, christian.couder@gmail.com,
	Enrico Mrass <emrass@google.com>,
	Emily Shaffer <nasamuffin@google.com>
Subject: Re: [RFC PATCH] doc: describe the project's decision-making process
Message-ID: <Zjk6LxhEQ75/BsKA@nand.local>
References: <b2ef74c1b0c7482fa880a1519fd6ea1032df7789.1713222673.git.steadmon@google.com>
 <20240417163244.651791-1-emrass@google.com>
 <xmqqr0f47wp9.fsf@gitster.g>
 <xmqqseyzar96.fsf@gitster.g>
 <CANq=j3u5ZHYbJQjhwtnq05GocOE_AVrHodjPOqVCNN7OZHwVsQ@mail.gmail.com>
 <xmqqfruy7oq8.fsf@gitster.g>
 <ZjU7CWdwb+xKubul@nand.local>
 <ZjiCz4_2KABLshLx@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZjiCz4_2KABLshLx@tanuki>

On Mon, May 06, 2024 at 09:12:15AM +0200, Patrick Steinhardt wrote:
> On Fri, May 03, 2024 at 03:29:13PM -0400, Taylor Blau wrote:
> > On Fri, May 03, 2024 at 11:08:15AM -0700, Junio C Hamano wrote:
> > > > Yes, sorry for silence on this thread. I am working on a V2 but
> > > > probably won't have it ready today.
> > >
> > > Don't be sorry; the message was not addressed to you, but for wider
> > > community participants---especially the ones with more "clout" (or
> > > "long timers" or whatever word we would use to describe those whose
> > > opinions are trusted by others and count more) need to buy in if we
> > > were to first agree on that it is good to have a set of written
> > > rules, and to then agree on what rules to adopt.
>
> Fair enough. Given that I have been contributing quite a bit more
> recently I'll feel myself addressed here.
>
> > I have been meaning to respond to this thread since I was mentioned in
> > it by Emily, but have been unsure of what to say.
> >
> > On one hand, I think the document basically outlines the status-quo of
> > decision making for issues that are larger than the scope of a single
> > patch series (think "should we use Rust?", "what is our platform
> > support policy?", or "how should we approach libification?" not "is this
> > particular patch (series) correct?").
> >
> > So in that sense, I think that the document is a good starting point,
> > and I think that it reasonably captures the status quo.
> >
> > But I wish that we didn't have to have such a document in the first
> > place. In my opinion, I would much rather see decisions like "what is
> > our platform policy?" made according to discussions on a patch that
> > defines what that policy is. That way such decisions can be treated in
> > the same way as ordinary review is today, and we can avoid the need for
> > a separate process.
>
> With "such a document", do you refer to the one documenting the process
> to do such changes or the RFC-style document?

I did mean the former, but...

> If you mean the former I disagree and think that it would be great to
> document reasonable approaches for how to get to an agreement with the
> Git community. It's especially helpful for newcomers to the commuinity,
> and I do get questions around "How to reach consensus in Git" all the
> time at GitLab.

I think that this framing is more useful. I'd be happy to see us write a
helper document intended for new-comers that gives some techniques and
suggestions on how to drive discussions forward.

I would be less excited about a document that outlines a rigid process
for declaring when consensus has been met, since I think each situation
is unique, and the large-scale decisions that Josh's document seems to
target are probably not amenable to a one-size-fits-all approach.

> Now the important part to me is that we should retain flexibility and
> allow us to adapt. It should rather be a helpful resource to newcomers
> than a rigid set of requirements that everyone has to follow, in my
> opinion.

Yes, definitely.

Thanks,
Taylor
