Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA196267B1A
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 12:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740485239; cv=none; b=rXw3+6Y/tsiZh6tvPpeAYvEj9KIyj0+qWg8vypcP+BDquNQI2bo281+DpXZq1WZgczHfHtRJ0BmlJQzVmQmjprdOpvSt8HnI+URs/KzAGNYUPlrK0fs17lFblJkvdWmxwobrUeh9VZacpNjn2wwbLoFyvQOTBzLa2f0mUhdwj8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740485239; c=relaxed/simple;
	bh=E2+mf/cx7Ysqaexr/KuWdpSmWMtyMjWm831KgVRmfvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IZbqsjVtbfb1JVlTW7W8knoHuAp2HAXfysPtaDTwOUQ61BXE32E9vqUXF2+74xZ+zW5HWj0cqQXQDtx3EWJ65MUafPeLjaUZOpdne9gbCD0t4oRIMRGRwRJKyXmYKqgkZyQ6vsEVRcaYt5WTy8dSnB3NbFCju8owzUcz9oO3Avs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y7bE4FBr; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y7bE4FBr"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-220dc3831e3so100422905ad.0
        for <git@vger.kernel.org>; Tue, 25 Feb 2025 04:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740485237; x=1741090037; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eEKMHkBa2dixSaNeqtf2qfjTOjfezSM91iSIe7zcWB0=;
        b=Y7bE4FBr8abQwqrwQ3yYzmo7r7OEm9UELtJK2VHg5OWRpBmNqVAZaI14EMOZlSXZyR
         5+Nq5yc3WSlYNHa+grAcqBcItGwUGUE9k4FfmmrL7gZXjM2fw7vllkhiWFtDHKX5d6bk
         HubZQHzUCH/1hAuWNr4I4ZBpFrFECv5i3Vs1KJomnWcFcomfuhHjIvDvoTz5oWpQkhzs
         c51L0sNaCegfZJCnkphdZ+UnamxIHa8mjp48WNh//y8Qmmq7ZbJ8aR/BLnPO2zGiCHod
         +A6jBc8Qz5wIKiHmxBsRcxwf3UBB2uyIe4NyydFzHwXHp08o5tzEoDg2UPv8hWI0vFY2
         VHDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740485237; x=1741090037;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eEKMHkBa2dixSaNeqtf2qfjTOjfezSM91iSIe7zcWB0=;
        b=mBDWh67t1Y7YkPjYMqR/pdV4hnlyeCF0a4JtseAHepB9JWtVwWNNRe7ymmET0I1h7h
         75LvE8+aQx91M/s3FIaYiukp1ZqEuDfATTbmY/HsBvQOGWlFL471zPHBlGlAsgyFKVx8
         DjYnqIDbhHIOaDTzioit+iqayvKsySk9jQL7FKL7d0SgKwwg3J8rVXDRP75hDKT06ic7
         eVRODfBUDHHZz3U/hTN5RqrR+A7WIP2VvwFpJxpt/WjQyqluszIPVWZyBklg2Kmn8xXZ
         wKgPg9UkJK8M7tWYne6I7jdIfG6fXiuFmTzOvLCMfkmlWw8JTAmP4qqbu2gKxRUhw3l3
         i7Iw==
X-Gm-Message-State: AOJu0YwnMvWU9jwvKeE8+x5zs/KOOiDa1+/szzp0aI+4B3c1BuXLMxtp
	FdjpjVEWwcCBMOfrHv4rYW2F2y75zabuYv2wDGjcGQyOfIh/Dz1N
X-Gm-Gg: ASbGncvVysHOhWgIiRITWiPpu4TzFbqFJPY0VV8medszA3k3+LpigCM5NhaAygUyWQC
	tF/ljJO2mFdX7NjE7sBNJxCoDuJvH7W5PFkATK8yiNpRGKM3V5oiqOrzdbiRNVBfY1i2sc+LCrn
	5aG4CgjP/ceNbxr8sxdPukh/v2+R1LVDsED+RTvTIxoLgzI8uA4o8mjXEPn9nu7mB7a7fD4VfwK
	Xned1EraABIO3QCWbp8fM4iXPuMMzMxpobyQ42dv7Vk5jWBsVr1X808d8clrRbYqpumOz2sHTqc
	rGVxi5BfYEQbWqNbcUbYvg==
X-Google-Smtp-Source: AGHT+IHUA5xTV3yktwXTlbyj23G5s5n3LWXVU2/ZtO6QH056m6TOCReIEy2nwUiTEespVBE/kDXtGg==
X-Received: by 2002:a17:902:eccb:b0:220:ff82:1c60 with SMTP id d9443c01a7336-2218c3f4367mr361503335ad.14.1740485237030;
        Tue, 25 Feb 2025 04:07:17 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2230a0b0e2dsm12526745ad.245.2025.02.25.04.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 04:07:16 -0800 (PST)
Date: Tue, 25 Feb 2025 20:07:24 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 14/16] refs/iterator: implement seeking for
 `packed-ref` iterators
Message-ID: <Z72yfF1samLJeSZd@ArchLinux>
References: <20250219-pks-update-ref-optimization-v2-0-e696e7220b22@pks.im>
 <20250219-pks-update-ref-optimization-v2-14-e696e7220b22@pks.im>
 <Z7yLrKVxCF5qb7gP@ArchLinux>
 <Z71zyrai9f9dPZRK@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z71zyrai9f9dPZRK@pks.im>

On Tue, Feb 25, 2025 at 08:39:54AM +0100, Patrick Steinhardt wrote:
> On Mon, Feb 24, 2025 at 11:09:32PM +0800, shejialuo wrote:
> > On Wed, Feb 19, 2025 at 02:23:41PM +0100, Patrick Steinhardt wrote:
> > > Implement seeking of `packed-ref` iterators. The implementation is again
> > > straight forward, except that we cannot continue to use the prefix
> > > iterator as we would otherwise not be able to reseek the iterator
> > > anymore in case one first asks for an empty and then for a non-empty
> > > prefix. Instead, we open-code the logic to in `advance()`.
> > > 
> > > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > > ---
> > >  refs/packed-backend.c | 62 +++++++++++++++++++++++++++++++++------------------
> > >  1 file changed, 40 insertions(+), 22 deletions(-)
> > > 
> > > diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> > > index 38a1956d1a8..71a38acfedc 100644
> > > --- a/refs/packed-backend.c
> > > +++ b/refs/packed-backend.c
> > > @@ -951,12 +954,41 @@ static int packed_ref_iterator_advance(struct ref_iterator *ref_iterator)
> > >  					    &iter->oid, iter->flags))
> > >  			continue;
> > >  
> > > +		while (prefix && *prefix) {
> > > +			if (*refname < *prefix)
> > > +				BUG("packed-refs backend yielded reference preceding its prefix");
> > > +			else if (*refname > *prefix)
> > > +				return ITER_DONE;
> > > +			prefix++;
> > > +			refname++;
> > > +		}
> > 
> > Although I cannot understand the code, I want to ask a question here, we
> > we need to do this in `advance`? Should we check this for
> > `packed_ref_iterator_seek` or in the `next_record` function?
> > 
> > Before we introduce `seek`, we don't need this logic. I somehow think we
> > should do this in `packed_ref_iterator_seek`.
> 
> We cannot do this in `packed_ref_iterator_seek()` because we need to do
> it for every single record that we yield from the iterator. We _could_
> do it in `next_record()`, but that function is rather complex already
> and really only cares about yielding the next record. On the other hand,
> `advance()` already knows to skip certain entries, so putting the logic
> in there to also handle termination feels like a natural fit to me.
> 

Thanks for the detailed explanation.
