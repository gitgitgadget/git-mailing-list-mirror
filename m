Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631C915A8
	for <git@vger.kernel.org>; Mon, 30 Jun 2025 03:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751252494; cv=none; b=Yo+f/CFFTK6K0/WshhU5VU1k7r0G3cZsIPocGtGb506z4MmQIvUWmzPlWMsWjCTBSsw/mFTtKtKXZPpx6zuBMvqlk2lksIg/pRiFgsFwPqtOWjExilqO3sVR8BXf+cnQqh5z85FhZrXX04S8lz5NnjSz2OQYUtUvSW2yzyNo+iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751252494; c=relaxed/simple;
	bh=EsViCkzmKKWuHtgLfCFPsyNFFzp6WFBktA9pzmar8L8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RyrIWnBt1drpbIF5/tUsZPQhW4BSxcY8KJ+xO/ZABJ+bQWnn9z2ORSjmsA5AThRfaFkwJHhEUm4DWvxJpoJgOvTQS2sOYw9RZNJdW7bJipriome8iR4KufQZ76CIRmdGS5yXO3mn/33YmMvRpv5bKl00j6QwkDU2N/3mEEwzBJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ru07LD10; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ru07LD10"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-40a4bf1ebb7so983466b6e.0
        for <git@vger.kernel.org>; Sun, 29 Jun 2025 20:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751252492; x=1751857292; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7rFypwWa/4VkoNlrQA+IxaexdLgGMdrU5uSCNp1xUCo=;
        b=Ru07LD10ngfaBwiQ/vvyXJDAWK6+EPDYIwogAWgRbXGoxsYHL+L6QDJYSWS2XcsgtW
         ypDPZ+SliechDVctQGuspxTPQz9IjnDrbpBwiQtfszrq5AkIFx0zt8SKqdlofHXUGRet
         R8NrlWMFKmA5d4ez18uwV1i+0sk7g7TrXagr/vT/RLA5O61ACOcrkETb8cLMSEpX69/p
         gB3+hl5V6VpqMWnXVGzrX2AmSmRv82thinsoGcdd3K7oHkzc/eZBr8cP5kZzfl45qKJc
         7U4Em9z3G4J+hWeXLFbpeDKOKFpc/vMbamJDjxQVcZGiu/bpjBmtzHMX1gVFmu2G8lGH
         A8yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751252492; x=1751857292;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7rFypwWa/4VkoNlrQA+IxaexdLgGMdrU5uSCNp1xUCo=;
        b=p5b0AicqYy7/ruv5Q7rEp/UP5wJGCqSfMZ9W5r/j92iO47MGy+kgEL/mVigyA3eAyz
         jmC3eBhvjkU6V6+CsEYXwer5bHMtFjVurnvBdQ+TYmDUeVqo222c7ghfODyNe/HJqN3L
         LYunfJZaAd31GyHcUX4yurGXkG4ALDs7fQNGpLaaRwuFQJpAq1vcpEuBhSAyNGWzVkum
         he90QW9KvKAkThNC9phPfySmAzTLqbPyJstA2UNNAwgeJKR8BMjFH549oXMromLoDf7u
         MOttex0JbZdL+jbRaQjn10G7XKSlPRFK5Vk08e6rRh+OMo4gni8cDEFnWWaNBVyMsHz4
         6uhg==
X-Gm-Message-State: AOJu0YxA4On+ebzMMGiNS0QC+xPFC+UtTUqdUdppMxoG0Vhv3dsEqKnh
	eXFz0D6Tyj2qFW/SfkyzX5q60kFmhKWUTebP5aaAXMe3ldvyGLPlPvgFl33+JA==
X-Gm-Gg: ASbGncuC92hFyrdzxOb1+gflTzSLv7BgevORun2UchjhynEgF7Gx7R4WjHzSfk4LYft
	uA93rQ6VctxfCSfpqkja8jb/4mSRXpWpWuyfEGR2UQW5wwWtXEMByO8o36KO+WSNyYDrZPgAWsK
	tv12N77FvZ21g7VBCOXTPToC08doLZxjcIvBGVJ0kZgEq9B0iul0jl7uZbRurEDnmKHE4zeM3VH
	G9vVqEfWm+gtUQeV2xLxexrNp0V41jS9ZoFukYqCTzAafF7ZqlCbk59RPt5meqQu1yHc2IKV+P3
	qL+ONAHK4HT30Kn+1umoXWBFjiyc41H/7LdSfWT35zCxnGGr0BkK/fU=
X-Google-Smtp-Source: AGHT+IHjHrnl7E1+bi4tJCKHEEuE0mLDarDDqKFgMS7B8uI7xQ6ToPV9otDct7SJ3B/vaB+g90R9jQ==
X-Received: by 2002:a05:6808:158a:b0:40a:533c:c9cb with SMTP id 5614622812f47-40b33e7196bmr8790240b6e.38.1751252492381;
        Sun, 29 Jun 2025 20:01:32 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 006d021491bc7-611b85c7d84sm1003566eaf.37.2025.06.29.20.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 20:01:31 -0700 (PDT)
Date: Sun, 29 Jun 2025 21:56:05 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, Toon Claes <toon@iotcl.com>
Subject: Re: [PATCH v5 08/17] odb: get rid of `the_repository` when handling
 alternates
Message-ID: <zsrwwg5mhxx7xk53i7czza5sageivnm2hxj5nlvunpe4gzrrjq@n5ne6qwovyom>
References: <20250605-pks-object-store-wo-the-repository-v5-0-779d1c28774b@pks.im>
 <20250605-pks-object-store-wo-the-repository-v5-8-779d1c28774b@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250605-pks-object-store-wo-the-repository-v5-8-779d1c28774b@pks.im>

On 25/06/05 08:46AM, Patrick Steinhardt wrote:
> The functions to manage alternates all depend on `the_repository`.
> Refactor them to accept an object database as parameter and adjusting

s/parameter and adjusting/a parameter and adjust/

> all callers. The functions are renamed accordingly.
> 
> Note that right now the situation is still somewhat weird because we end
> up using the path provided by the object store's repository anyway. This
> will be adapted over time though so that we instead store the path to
> the primary object directory in the object database itself.

Just to clarify, are we walking about the path to the alternate odb? I'm
not quite sure I follow.

The renames and refactors in this patch look good.

-Justin

> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
