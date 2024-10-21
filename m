Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557111D2781
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 20:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729540952; cv=none; b=I6Zt/d3J4m4FR66IeO1UnGtQqOnG96V7qo/d1qz6k9OpXzyQ5j/jNc6GiQ674WrdPIeowl3cgG2xDWzIn3DSgjfjDpNGBb20Cp23fkP5uz6CQoEtG3p3TaQA34xTK4qQXeldm0uHxzq616MKioTD0WjMX9oCkS9f2GDN0isA2SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729540952; c=relaxed/simple;
	bh=pzCXHuRWnRoIeI44DUM1JPqq7o3z811Oe7Ryc86D+1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s+I75n047CJ9vO7t38+/3IFIlxhZSo+SyzoVX0gISk71oBq5K6gFgFUZq6Bnuxcgdyr9vHrLfqhZQhKsCSXlkqvhuHNEBIF48vzXbOve8qwqr2V8Xp9jqrqwSh+uFuu17kaUa535DZMBfn8ivDt5q5r3GLQmEsp5wBGFAw21I2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=s2fvvZtx; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="s2fvvZtx"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6e59a9496f9so54900147b3.0
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 13:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729540950; x=1730145750; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c8c9QAWGBeCXFO6ev5C7tap4uaLE9ZkEQKJE4edgN0s=;
        b=s2fvvZtxouEWYUVQLSp6M1GoyV0J7E061VAwt1kOa76LJnzq4QkSPxLopB3RT+Y4Xc
         AMw67Rx0ZCTLq6g9Q9TI+rEc1McHfrsRjWeylHVZf4yh8tEZeiOOfki1a9vVxwgKbT5y
         r2kbEtz9AhQ+lN2Ezb/5RHCt+lz1hUPpVd9Q7lqZ6/sUKiLl9AI5vW3tL1dowGmLSZB9
         LfXXQhDrCBZE9EH6XXS1JZdKEGPgaqac1GROy95HWJkLg+wibdXivlJyPkfUGtrpEi68
         m8+AAPAE30fZmpUhIe336U5AhiTsSH6Kfmtjd6iJLiOxooGARsLe3Js6mQQqk9qqsMH4
         ZTbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729540950; x=1730145750;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c8c9QAWGBeCXFO6ev5C7tap4uaLE9ZkEQKJE4edgN0s=;
        b=hHTtHSEdVjeIgaGzh398HWyV7gzAhvopf2w+XKX24JcXI3JB04DWMtvZWlyUO2iIow
         frOwCTt4vGxu2A2bfO0O70iTKapu9GUXdqbCype5UP99DMzqMCN1hAEfaRxaH0jtn89k
         /boglQE3QE5UWAP6nKwBHyafDET6VHQ/ZopWqu+sVtvmRuN4YOKZ9BNBlOj1mq27nMXA
         YKjJ1Nyj3cMjKtsgVnxXjfAW26Pg8KOjMXmKOldwPF63cln1V0ScoRIDLsepkO6Y72N0
         TScLwgl2OVWHlnHSxz1ylhEurf5cTTMAY0mXLt5ladZQShvtg5uclzud33b87HP6u05t
         Gzpw==
X-Forwarded-Encrypted: i=1; AJvYcCXLABdFxJfwqttop1Sk37eMPYhszORnuwSVPWOLpIR6LSMvdPjtQUV5oL4fUCrYX9n9z3k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyczLh4zyEyLFv5Wn5c4Ws765HTcMdPRKgZ6QE8Ugar8QhfoXj0
	RGGaki7emGD9RbkFhMD5FgR1SjZvTO3nQH/ORGz+/V3iBukmv35xi5BoHHIVR6QdN8WwYcG1HLe
	i
X-Google-Smtp-Source: AGHT+IEb2vLlBobfAxBqWtiURpm9cCMzcxvECL98bEHw8PQrrFDpbvytUni9zy4EBIkdB834sX4MsQ==
X-Received: by 2002:a05:690c:11:b0:6dd:d0fa:159f with SMTP id 00721157ae682-6e7d82af510mr2177567b3.34.1729540950135;
        Mon, 21 Oct 2024 13:02:30 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f5cc8df1sm8069757b3.82.2024.10.21.13.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 13:02:29 -0700 (PDT)
Date: Mon, 21 Oct 2024 16:02:28 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] CodingGuidelines: discourage arbitrary suffixes in
 function names
Message-ID: <ZxazVG65+W0qKLXh@nand.local>
References: <20241021124145.636561-1-karthik.188@gmail.com>
 <ZxZP01C-9RngukZy@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZxZP01C-9RngukZy@pks.im>

On Mon, Oct 21, 2024 at 02:59:00PM +0200, Patrick Steinhardt wrote:
> On Mon, Oct 21, 2024 at 02:41:45PM +0200, Karthik Nayak wrote:
> > We often name functions with arbitrary suffixes like `_1` as an
> > extension of another existing function. This created confusion and
>
> Micro-nit: s/created/creates/
>
> [snip]
> > diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
> > index 30fda4142c..b8e2d30567 100644
> > --- a/Documentation/CodingGuidelines
> > +++ b/Documentation/CodingGuidelines
> > @@ -621,6 +621,11 @@ For C programs:
> >      - `S_free()` releases a structure's contents and frees the
> >        structure.
> >
> > + - Function names should be self-explanatory, clearly reflecting their
> > +   purpose or behavior. To maintain clarity and avoid confusion,
> > +   arbitrary suffixes such as _1 are discouraged, as they provide no
> > +   meaningful insight into the function's role.
>
> Names being self-explanatory is certainly a worthwhile goal, even though
> I guess that it's a bit more on the idealized side of things. Functions
> will often not be fully self-explanatory, which is likely just a matter
> of reality. I mostly just don't want us to end on the other side of the
> spectrum where we go militant on "Every function must be no longer than
> 2 lines of code such that it can be self-explanatory".
>
> And yes, I'm of course stretching what you are saying quite a bit, I
> know that this is not what you want to say. I'm merely writing down my
> own thoughts while thinking it through.
>
> So, that being said, I agree that we shouldn't use arbitrary suffixes,
> as these are quite hard to understand indeed and typically don't really
> provide any context. So as long as we interpret this rule leniently I'm
> happy with it.

I am not sure here... I think that using a "_1()" suffix means that the
function is processing one of a number of elements that all need to be
handled similarly, but where both the processing of an individual
element, and the handling of a group of elements are both complicated
enough to be placed in their own function.

It's also a helpful convention when you have a recursive function that
does some setup during its initial call, but subsequent layers of
recursion don't need or want to repeat that setup.

So I'm not sure I agree that "_1()" is always a bad idea as this changes
suggests (i.e. by writing that "they provide no meaningful insight into
the function's role").

Perhaps we could rephrase what is written here to suggest a couple of
instances where we wouldn't want to apply this rule, and the two that I
have written above could perhaps be a useful starting point. But I lean
more towards not adjusting our CodingGuidelines at all here.

Thanks,
Taylor
