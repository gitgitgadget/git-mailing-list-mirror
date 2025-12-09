Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5DE2D879F
	for <git@vger.kernel.org>; Tue,  9 Dec 2025 18:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765303574; cv=none; b=d3U3fsX2LybJOCmq4WIVQ/v/JQyr74SXbI0gYHrWWTx8r5Pqw04X8kDDMZ23rIm6nEXkP5NcoUucQT3jICo2jZA0ZjnhmskB5uMLwmd5Q1ZNfP8TOnbmr+sEysP3q3NakiMb0EQOBI9/jEdVLf4lW7Iur4C60LXtbPmsfFIJPyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765303574; c=relaxed/simple;
	bh=eCvtGPG0Dk7trfoPwEh5V6JoZTHeczJEX1mTekuaRMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O8z/TexD1hHqUKEjIzlGhfsbESJPotwlYqbmheDHuJe+MM4Um09ida2JrhACO7cHuIhfe+u4lDTNi0Xnej8CAydATtYilroou9Ud0INEVj6fhyUflooGI4Q0J23eJ2IquoagiDdpO9UmuBIIqwP/LZMMJAYE/kW6QYnfLKmUyxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lhnmvF10; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lhnmvF10"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7c765f41346so3461928a34.3
        for <git@vger.kernel.org>; Tue, 09 Dec 2025 10:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765303572; x=1765908372; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CD2Xpg3L+JUUo8li2kKzLC6+wzJdhM/0VdM/PEvZKZk=;
        b=lhnmvF10a5V6QH+QCxCnHc+EXBjgASg7xL26J8STfJ75TJvWmoGd0tZ0n40W/ym9HE
         K7DffOua+KUfJGkBshtfj6zqoxQ2Y+1qcScgk3mQW42+trPhGHZEQTkPlp1kMM9tqPr+
         exyqR4OaT178LghYnu3JWGKgj1tDIy49bBHea40KYhnCR8ANuuo/DQ35+ekFjMz53mAB
         YcauagYi+DLFafw9w/cqpTHq3Qq25EkqvOAiyX4+iLvKAfsrjeati/ebbG8E+zhLTylH
         5AlgR2igBU1w4B7Ek7Lk+Hq3FG17IayapOyRv6Ec15ASF+nQUa2ufU6BffW5CypzHGxI
         pyQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765303572; x=1765908372;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CD2Xpg3L+JUUo8li2kKzLC6+wzJdhM/0VdM/PEvZKZk=;
        b=BN2y3ktKkjQmbG7i2MqGOLpmTIlVNi16VMdyz+Yv9mA7/h5LCtNUBmqQEnc+xLlQIg
         GsyuISl4hiH4ZfTqFiF6xutMQrzopVyk3MM+5mCV9YCpuqtsJ/xNJCimAxhje55D45TP
         IgGzpaGidqv4DPLgOTbY5nicYzvORMPa6in+NfBP/IAXvTcQCzEQhAMjEzHW8fks2LT2
         m4ffCP1Rxyf4SHxRnkrqOV/XEtFaQ6GQrGDfUJqj/5NnhWUIIpG+xMcQyZsh5rV4b6NG
         AQdTiXfHz6T6NLUvGsg4axpEGoM0TR7/POyRNkeyXTzFS2vI7Jk3N1vrnvsYaRJWD6z0
         0K6A==
X-Gm-Message-State: AOJu0YxUc3gU8DE24E/H97snti8k7NTrcfRV4+UAMG9JDfiP9q6kNjiO
	3WaLarD7a9yiOMUxGAeyWJBl1ncYB6XQK54cBkOI4M4dtryAyidltADHbPS2rw==
X-Gm-Gg: ASbGncs/V/6jX4tt/urHx0WvCnrkUiQyk40KwfCDvWR97RhyzHvcEcXUaa5rcf4/85f
	z0QciMnC1sRfQ2TVEO/gbqDtJox+t4+zQIkDlHOpqPZMxBKKfa9vWigfi64VYU64Uw3vOytpEea
	pUf8sRHvboV+GtNqKqH7CwpQc3YouBD48uYVREqdXnvhC4ecmTgHDTiHRL8wfo5rN9GiWIVS1Ed
	Y4JmOhCZNRurYsMLF4vDFof6GUYOuYllfDyQ12rUi9OihvfKpmtBib8Fvg+zSoy5q/NHDgAlC9s
	D4OwRO5lABNtf+0HoubjXqtkg1I+V0CncSw9zeRJbXMP4siEMa/LS7huW6IYddbkdNlJGEUkc1t
	6WIKDa6EEJf11sTok9Md7SY09CXfuZxYVr3BS/bTbxa/SOO65npIsaszSFXRZrOIFC6pImozU7N
	E3Ms87
X-Google-Smtp-Source: AGHT+IGRv9Xim846vSkcfUT0LrzAE/JB6YPI5qVYs2yaizwqlZ9+gf1SaRRFfFXEPOebBYB5pGFJDg==
X-Received: by 2002:a05:6808:1687:b0:450:907:b523 with SMTP id 5614622812f47-4539ded8407mr4331024b6e.6.1765303572034;
        Tue, 09 Dec 2025 10:06:12 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4537f6bc9d5sm8118214b6e.0.2025.12.09.10.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 10:06:11 -0800 (PST)
Date: Tue, 9 Dec 2025 12:06:09 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/8] odb: resolve relative alternative paths when parsing
Message-ID: <5lkaw3kfqzjt45jhomeb34cqu6nxigapmobtqrzpyoq7mh6655@3zgqsyfui23j>
References: <20251208-b4-pks-odb-alternates-via-source-v1-0-e7ebb8b18c03@pks.im>
 <20251208-b4-pks-odb-alternates-via-source-v1-2-e7ebb8b18c03@pks.im>
 <kz2eftlrmaxpxjybhjwqlewy3dx44sdznimzs6reoqtev4qtox@hl3s2gxz3sk2>
 <aTfYBGr-0SIDinYF@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTfYBGr-0SIDinYF@pks.im>

On 25/12/09 09:04AM, Patrick Steinhardt wrote:
> On Mon, Dec 08, 2025 at 08:09:30PM -0600, Justin Tobler wrote:
> > On 25/12/08 09:04AM, Patrick Steinhardt wrote:
> > > Parsing alternates and resolving potential relative paths is currently
> > > handled in two separate steps. This has the effect that the logic to
> > > retrieve alternates is not entirely self-contained. We want it to be
> > > just that though so that we can eventually move the logic to list
> > > alternates into the `struct odb_source`.
> > 
> > Naive question: is the intent here to eventually move alternate ODB
> > sources under the primary ODB source? Or just to record the alternate
> > dir info in the ODB source?
> 
> Not only the primary ODB source, but into ODB sources in general as
> alternates are recursive by nature.
> 
> The problem I am trying to solve is that ODB sources may not even have a
> filesystem-local directory, but the way we use alternates recursively
> very much assumes they do. I don't want to treat "files" sources
> specially though and only recursively add their alternates. Instead, I
> want to move the logic of enumerating alternates into the source so that
> every source can have a different way of enumerating them that may or
> may not use the filesystem.

Ah, that makes more sense now. Thanks for the explaination. :)

> > > Move the logic to resolve relative alternative paths into
> > > `parse_alternates()`. Besides bringing us a step closer towards the
> > > above goal, it also neatly separates concerns of generating the list of
> > > alternatives and linking them into the object database.
> > > 
> > > Note that we ignore any errors when the relative path cannot be
> > > resolved. This isn't really a change in behaviour though: if the path
> > > cannot be resolved to a directory then `alt_odb_usable()` still knows to
> > > bail out.
> > > 
> > > While at it, rename the function to `odb_add_source()` to more clearly
> > > indicate what its intent is and to align it with modern terminology.
> > 
> > Alternates are indeed just additional ODB sources appended to the
> > sources list. IIUC though, doesn't this function only add alternate
> > sources? If so, maybe it would be better to use
> > `odb_add_alternate_source()`?
> 
> Hm, yeah, I think you're right. We still have the recursive nature at
> the end of this series, so let's call it accordingly.

On a semi-related note, part of me thinks it would be nice if alternate
sources were a bit more first class in `struct object_database`. IOW,
explicitly defining the primary and list of alternate sources
separately. From the perspective of reading objects, having a single
list of sources is nice, but when writing objects only the first source
is used. This isn't too big of a deal, but certain operations like ODB
trasactions will reorder the source list to change where objects get
written to which feels a bit fragile to me. I guess another way to
resolve this concern could be to change ODB transactions to use a
separate mechanism though.

-Justin
