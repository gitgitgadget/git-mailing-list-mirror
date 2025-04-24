Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF2A230BD4
	for <git@vger.kernel.org>; Thu, 24 Apr 2025 12:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745497631; cv=none; b=G6mxZ78/OlPJO0qsekNVcaR/XIxXUMzgI6j21Qs52ajaElarFVXkDvJt662+li3ogwO4CdfEgivbf/BoHzfKOb6suNhCrzuLd8V3KOuAxJgfz9E4YX3kHm6reAmMRK7s7MgSZp0vCO5uXa4It14AgKA5v9C8xYbRlFKqUOQbckw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745497631; c=relaxed/simple;
	bh=PInaBsOfv170vytuvYSeg0BXBXEQKRKmGnUerQ4OghQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=az91tCfMpmsSgh8XF7lqZ1vbAk2jGG2USFxPWbaRqm2iokIsLbuDiYyNEaDdP5V34fAXnBIIZLACjZ2n32lhsfuwXdJ6mpiJy66wjY9ILrdevdi8eXDqt/UhoPyIfNPyvZhO9aKANJSMzEEqK0CbjZ03xaSNGoK4XzGCWiXPPcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZLdgxkwI; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLdgxkwI"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-30828fc17adso941230a91.1
        for <git@vger.kernel.org>; Thu, 24 Apr 2025 05:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745497629; x=1746102429; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rapfanxBM2BeCh0SVRv5zRivY9zD+nZmaBIJxu69g+Y=;
        b=ZLdgxkwIIcFr6CeRWJPgskEL5vcNV/iOCrxqNcTEciRV02In445JFDSMnU1Oe6u4I0
         O86y0a1ihbOYG9j/MoNZmUYzLwGh/c6k6m40wLIwZPyotpVbgMI+pQCWhnyWHE43Diwt
         colgxI+P0z2zN3YvHldo32stSWRIq8HVOIhDlGmX3IWkem8jBwczFRK+RSqaXkJ+Mv92
         gkFpRBOkijY6fqdGfMLRHhx4qpdopYQPfs/k5RuA6E+CeCXqDdFfTFKf9ILSD60Z4etp
         lQ/nMvKpnQwJ/T+NiT/clZtI9HONfIuuioIhCbrki9+lIvvgt6MzoYRt2ghxcTwrCW5L
         ZS8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745497629; x=1746102429;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rapfanxBM2BeCh0SVRv5zRivY9zD+nZmaBIJxu69g+Y=;
        b=FeLmY2uT4ahcg8vmVKZTZ0D5dcJjCYVmWPy3naw9xgf/1ODRt4rZnJJjiyFDh+nncj
         wcp8OBi91YGhJNNvRJBvs36X+c0sjGslV2gl8VJQKYjUlPxjW8/cZnAFirVQt3cnFfrd
         7SccEnYic9kA7+I+sFrqCESNmFJjfwJ9NKNbPQdpDbGAyIrxQeXtMfAMhk635uhiOmyk
         SoLaPxytPd3st9vt25Ly0ZeIH5hgvRHZeqrs3mE9iwytOm/wMCySo7v1tIuVkEh8P/eN
         SJA6ASYrWpt2v22RqtZV2i9TaI33eWRe6dHcFtyp2rlPZfyFWNZhVgnDVtihROcPziHC
         gPRw==
X-Gm-Message-State: AOJu0Yw9VFtlucTfjg7phhPdK1gkF80jB8cwFUbqQ7g/JJCqD+DVDJgg
	MAXpPZyieY3MuXgOJlDFDdTAXdffJmLPafstAo903pngJz2NBy8W
X-Gm-Gg: ASbGncv1QPMbryR79ibyGB44gNvoUUza/NtoLKHEvqAXiCw9iRw0kY2DNQQg0x3Daea
	C8FbvaunkZY3J9BN0B4biaZcjNDMo0EzYGrDDe4R4+ccZci0MVL1MBLq/ZtmnSvsgL+/V1po1+1
	/9dsk1/iukL2w1TqI7PYnW2UsgNWgJgBUcCcGjP7eeYPAr9OzkOCmEh1kLcjYfCUxgorCTvNIvs
	TzPps2mbnhcqEwDFA0nSRevMQeiHUX9FMWq4gURkDkmFpkDc6+f56FnjkQTLzB5QLQ1guTV9TgI
	IKiNqQT4wCdiscftR92fdzR8jpwGwep8uipmfFOPUphMqwo=
X-Google-Smtp-Source: AGHT+IE4dmj8QYEsk1VP3TfXF/H/Ua5kFClljaUlywu0vgt7Lte/ddBxTs6UY0EKNARG810nBk/eMQ==
X-Received: by 2002:a17:90b:5187:b0:301:cba1:7ada with SMTP id 98e67ed59e1d1-309ed269fa1mr3152654a91.1.1745497628426;
        Thu, 24 Apr 2025 05:27:08 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-309ef0d4a16sm1205430a91.42.2025.04.24.05.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 05:27:07 -0700 (PDT)
Date: Thu, 24 Apr 2025 20:27:18 +0800
From: shejialuo <shejialuo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 1/5] string-list: fix sign compare warnings
Message-ID: <aAouJnCw3nTQHQTG@ArchLinux>
References: <aAetW0dan8S3Fljq@ArchLinux>
 <aAett8cJuDJ_FSdw@ArchLinux>
 <xmqqy0vr3o6d.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqy0vr3o6d.fsf@gitster.g>

On Tue, Apr 22, 2025 at 02:02:18PM -0700, Junio C Hamano wrote:
> shejialuo <shejialuo@gmail.com> writes:
> 
> > However, for "string-list.c::add_entry" function, we compare the `index`
> > of the `int` type with the `list->nr` of unsigned type. It seems that
> > we could just simply convert the type of `index` from `int` to
> > `size_t`. But actually this is a correct behavior.
> 
> Sorry, but I am lost by the last sentence.
> 
> "this" that is a correct behavior refers to...?  That the incoming
> parameter insert_at and the local variable index are both of signed
> integer?
> 

Well, please ignore. I think I made a mistake. I should not say this is
correct but say that this is not harmful.

> > We would set the `index` value by checking whether `insert_at` is -1.
> > If not, we would set `index` to be `insert_at`, otherwise we would use
> > "get_entry_index` to find the inserted position.
> 
> To rephrase the above (simply because the above is literal English
> translation from what C says), the caller either can pass -1 to mean
> "find an appropriate location in the list to keep it sorted", or an
> index into the list->items[] array to specify exactly where the item
> should be inserted.
> 
> Naturally, insert_at must be either -1 (auto), or between 0
> (i.e. the candidate is smaller than anything in the list) and
> list->nr (i.e. the candidate is larger than everything in the list)
> inclusive.  Any other value is invalid.  I think that is a more
> appropriate thing to say than ...
> 

Yes, thanks for the hint.

> > What if the caller passes a negative value except "-1", the compiler
> > would convert the `index` to be a positive value which would make the
> > `if` statement be false to avoid moving array. However, we would
> > definitely encounter trouble when setting the inserted item.
> 
> ... this paragraph.  Not moving is _not_ avoiding problem, so it is
> immaterial.  The lack of valid range check before using the index
> is.
> 

Yes, that's right. Ideally, we should check whether the index is OK. And
I somehow think that I should not make the commit message complicate. I
should just say we should remove "insert_at" function in a separate
commit and then fix sign comparing warnings.

> > And we only call "add_entry" in "string_list_insert" function, and we
> > simply pass "-1" for "insert_at" parameter. So, we never use this
> > parameter to insert element in a user specified position. Let's delete
> > this parameter. If there is any requirement later, we may use a better
> > way to do this. And then we could safely convert the index to be
> > `size_t` when comparing.
> 
> Good.  As we only use the "auto" setting with this code now, as long
> as get_entry_index() returns a value between 0 and list->nr, the
> lack of such range checking in the original code no longer is an
> issue.
> 
> Having said that, in the longer run, get_entry_index() would want to
> return size_t simply because it is returning a value between 0 and
> list->nr, whose type is size_t.   left/mid/right variables also need
> to become size_t and the loop initialization may have to be tweaked
> (since the current code strangely starts left with -1 which would
> never be the index into the array), but fixing that should probably
> make the loop easier to read, which is a bonus.
> 

That's right. And I would clean the code a bit more.

> And add_entry(), since it needs to do the usual -1-pos dance to
> indicate where things would have been returned, would return
> ssize_t---or better yet, it can just turned into returning size_t
> with an extra out parameter (just like the exact_match out parameter
> get_entry_index() has) to indicate if we already had the same item
> in the list already.  It is perfectly fine to leave it outside the
> scope of this series, but if you are tweaking all the callers of
> add_entry() anyway in this step, you may want to bite the bullet and
> just go all the way.
> 

I agree. I'll add more patches to clean.

> Thanks.

Thanks for the review.
