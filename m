Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AD91D6DC5
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 13:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739970421; cv=none; b=IxySeW7dSLVZ5HAaCHFRCBQxYxEbXMlc8LvaQ/zDsa2vl70AXslW+cdGwouzhcofCatxif4PT1yh98+oONGwlxCF0rqt7UCtHSAkBEwjM4wp2KzxiGjd46IS6P7JokyYi/B133WbmRXvEb8VnQumV6ieW5MPZdcDZRVJgyf6vNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739970421; c=relaxed/simple;
	bh=eInjH/8xtnmDH3WFnvAtm//4oUeIxhM0atumsWhvx4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XgYfn8kSOzvgRKoTdJHdY6F0oiaIg+FhOMO+N/bPDOTwGh1wpUnqbR8E9WBVwdPT1gFlx6UyGNh9RPBaCDGpQ+zy1L44XO1Nxh0LLEqmSxEZhd3Ni8k3elzwzefD8j0AxpnQJeUiiKEXfiN1Yt7sOek+5RsxN50CnzbWrPMczPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EnR48dF0; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EnR48dF0"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2211acda7f6so78533035ad.3
        for <git@vger.kernel.org>; Wed, 19 Feb 2025 05:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739970419; x=1740575219; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ava9UsnJwXQo47G/eDoXIArUG1Q4Lm01QfVqu3I/fpU=;
        b=EnR48dF0RfTPR33T5+hINIg8vLTZw4MaaqFPJLfsjaGuqm8tt+tV1LtQL4ZpzQpu40
         SBjymUvLIa5NCZYKe/ZARu7gPLlad12b7isYlQkAUelW8tqKrVa3Z93eq7BmcCs3os0N
         2Zsvh6yBZfEXxbM70JNfFsx5kA82TdN40qjK+Nz/HP64DxCwJvmZymVoU27m7gblpCIh
         5E+humwQv1GMdu7H8xPziWOR0kirDgnBXdA3ep3P12wPXKphD+AHucmoLc3EgiDwAH59
         HsAjWK6ZuzSOyVU6yIMwIEgIKoXEiS8Zo7aZCnOEoSuggzhXD9dfyH7xRD3oPH2GHQIh
         3SaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739970419; x=1740575219;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ava9UsnJwXQo47G/eDoXIArUG1Q4Lm01QfVqu3I/fpU=;
        b=mnDECo1Xqv06nFGR8VaatKu4FJgvqC/dsIi9hXqRpkvWTpUhxqORdr2mrm2FleTlBC
         ZcF5rnL/HQt0+k9d2fywmDiEHcEpmbyr5jwssZGutgAhsjURuCyk5fXvjNaFynrAfl0r
         bLID6xYCoMsMOYsMGMhIFYMlIlrmm7UE5DxOY5PczaYVNu396yH8cB2T2UKwZCx/dVT8
         gfZZQy5ap8P7xQggj/kyQCZRsUXOxIyLilVDifBMKOgLP3i1csOxUCBIiX7Ouds34QFX
         JkrtFES6Y20cs8Y46n6Ga0YMSXWgrckiBAVbMJSJWhjLOeH9Ep2kIZf3W5LV5UZhP88L
         vS4w==
X-Gm-Message-State: AOJu0Yz+4l6spDGYv2Qrd521qky8dKxpvXiZpBECadbMzywmtH44wntR
	5aOGawC6USLX630z6Cs7COh5Xz0PdDcWVP9m/izezTywGr7bdKVUIp3O/w==
X-Gm-Gg: ASbGnct+n0rfw4FjQ4bLPqrmjhckNJHhnI86AuJIx+WLVR+mOpweh4FCNseIwzjzYQm
	K1b6U2548ZwuV1QFkOfZRHHYcwWkVFO96PlBRfm210pKZNxnpCSGLequbZQ4PlmFM2Fhmhw6bqp
	Z+X6hb3tjwOhsSc3tkYunBI2iPWD7T5lYsCfhrNY1jtOE82PWd89jWANSxXf9IAy9H0kaBP6293
	9W7JTUgSbxMY89T4aFUz74V43B750pYLwquZz02tG8XHGNccK6XyQbAmBbPDMUxQNwvtwz52+i5
	CjHWSUdlMMc=
X-Google-Smtp-Source: AGHT+IFr3cMNYjzHQtZxssW+WvZXJYabAjIdLyVBsre9oIy81qF/ldw4E61ZzGXwTJFpLie0QxjekQ==
X-Received: by 2002:a17:903:244b:b0:220:fb23:48df with SMTP id d9443c01a7336-2217119ecd2mr66196785ad.36.1739970418708;
        Wed, 19 Feb 2025 05:06:58 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d556f97dsm104693705ad.172.2025.02.19.05.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 05:06:58 -0800 (PST)
Date: Wed, 19 Feb 2025 21:06:58 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 07/14] refs/iterator: separate lifecycle from iteration
Message-ID: <Z7XXcp9o0fb7FloS@ArchLinux>
References: <20250217-pks-update-ref-optimization-v1-0-a2b6d87a24af@pks.im>
 <20250217-pks-update-ref-optimization-v1-7-a2b6d87a24af@pks.im>
 <Z7S6xzmPb3lK-SdT@ArchLinux>
 <Z7XF5pGsa42jrIcN@pks.im>
 <Z7XRX1gfo942QdNR@ArchLinux>
 <Z7XVoeNMjXJnlrmX@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7XVoeNMjXJnlrmX@pks.im>

On Wed, Feb 19, 2025 at 01:59:13PM +0100, Patrick Steinhardt wrote:
> On Wed, Feb 19, 2025 at 08:41:03PM +0800, shejialuo wrote:
> > But there is one thing I want to argue with. I don't think we need to
> > rename "abort" callback to "release" and also "ref_iterator_abort" to
> > "ref_iterator_free" for the following reasons:
> > 
> > 1. We never call "release" expect in the "ref_iterator_free" function.
> > For other exposed functions "ref_iterator_advance", "ref_iterator_peel"
> > and the original "ref_iterator_abort". We will just call the registered
> > callback "advance", "peel" or "abort" via virtual table. I somehow think
> > we should follow this pattern. But I don't know actually.
> > 2. When I read the patch yesterday, I really wonder what is the
> > difference between "release" and "free". Why do we only change the
> > "ref_iterator_abort" to "ref_iterator_free" but for the callback, we
> > rename "abort" to "release". I know that you want to distinguish to
> > emphasis that we won't free the iterator but only release its resource
> > for ref iterator. But could abort also mean this?
> 
> The difference between "release" and "free" is explicitly documented in
> our CodingGuidelines. Quoting the relevant parts:
> 
>     - `S_release()` releases a structure's contents without freeing the
>       structure.
> 
>     - `S_free()` releases a structure's contents and frees the
>       structure.
> 
> So following these coding guidelines, we have to call the underlying
> implementations that are specific to the iterators `release()` because
> they don't free the iterator itself. And because the generic part _does_
> free the iterator itself in addition to releasing its state, it has to
> be called `free()`.
> 

Make sense.

> Regarding the question why to even rename `ref_iterator_abort()` itself:
> this is done to avoid confusion going forward. Previously it really only
> had to be called when you actually wanted to abort an ongoing iteration
> over its yielded references. This is not the case anymore, and now you
> have to call it unconditionally after you're done with the iterator. So
> while the naming previously made sense, now it doesn't anymore.
> 

Good point, I didn't realise this part. Thanks for the detailed
explanation. I will continue to review the later patches. However, I
won't touch the oid part, because I am not familiar with this. By the
way, I think we miss out one thing in this patch:

We forget to free the dir iterator defined in the
"files-backend.c::files_fsck_refs_dir". I have just remembered that I
use dir iterator when checking the ref consistency.

Thanks,
Jialuo

> Patrick
