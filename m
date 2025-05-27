Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF93727BF7C
	for <git@vger.kernel.org>; Tue, 27 May 2025 16:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748364603; cv=none; b=NtoeVmS2AizGZ/sDGk+w7PbDQhoDsWuHO1riZcAqXLjkqs/BeW1IGs5/26Ikp+951WiePfst9HKupp0qMAvHb7DJtDBHvo0/E63hor6ArPcNlF+X6GX5YWAbxvLPfGtSdb47+6i+CINS2x8Fx88RaZAvYKaaWurKG1Dr/VFALDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748364603; c=relaxed/simple;
	bh=/9HG2XFqtfoJo6bs91r9BiuHjyiyEU1TG8YQGXqX0+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EckvTBeDjE3W+RdRmGIrRZq/dHGzlnEQftSQBoCa0AL+QE8nW7YPqiGXQ1ReolTBcgwl5obLtbIz0Rx/t0cf8ptvWEyvTeX40TNT5LIWWS2SEhOoJcJAMJ+ylNjuO/7uluQukFN/TyGfWITFrnZQKkvncjsfchFPL9LGV3YhrjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WIObyebJ; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WIObyebJ"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-404da7584adso1437623b6e.3
        for <git@vger.kernel.org>; Tue, 27 May 2025 09:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748364601; x=1748969401; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MMcNSnyEkGhwvkcyc8lBjqaKLTceqpUCQfIiq7WzyqU=;
        b=WIObyebJOohVS4h3S1peJaXWuZu3Xm+uy+k5DsegITr1nLndVG4QXW90vH9WQB59F1
         EblhxfcKI6TBnP+wKXTQtZk/VtEFZG1rZnjTL8bZAYF+adQfvcniVUOCF2gxFXsM9uLY
         s0lipasm9lihDoE1lqmb6NrHK9RA/faJKi3JNAqdHRovCwNfPF4wuem45CHVUrFuAzlh
         k2JzaMWiiWb53QP+cOPGq6PxG4/XMATb1u/Kb7NJkM6zcqCXe5AnoDY2927MBff8Dhzc
         cXaoHmpu43pHfpXYU0rfloA6Wfv6n2HicMl1m/IMn7f5r7qY1BPhqDjND4RDlO1GcV09
         ZEUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748364601; x=1748969401;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MMcNSnyEkGhwvkcyc8lBjqaKLTceqpUCQfIiq7WzyqU=;
        b=D1c+2iiAdNPEQmFM+adZRThAi97+vVKQ/Ej7RQJN3An4ckIa4jFGnga6qPTVPh3bGI
         A/UlCWiM4q0U0bKGaYHxloSrMbJfqQAZkdgjOQKD3IEWyqYC0ztaVTWkgqjpV2FY46J9
         NlI9EAQPDGtZ0LshukZQSbzYZrKB+dR9hCRkz8Ks9zrWdxxKbZRATrcfOx968D3GCRiO
         +GLCvUToapnS+EBLrR+wpJRuOWgicwM4p6GbFw7OXStDL21QQs5GFREWmTvYfGmBV5q8
         eqinfaMg1tur6pcAZBeo/KDI6rUj6cWJI56fAMRJon/sikxAGXOvi27bC4Q6hzQOWOiT
         L5iQ==
X-Gm-Message-State: AOJu0Yxe9Drfs2r8D9W+U9yQMJwf0Ye/JSgU6wYX3I+WhAJZuFJ9NM5c
	wUwl6sBMtDDMfCt9Sayomr7TyRY/NwO2AicusOaKM/8CW7YoCc7vtPb+
X-Gm-Gg: ASbGncvMFfracSL/bHafOi90YmKdJGm5AGsel58RHdEUBV/0/KaLl9JKJAsWgV0VE/l
	furyVIe4w0Xb3/8JiXZpkMCStbh8pDJGvx8bm9U9CLXu058aPfY85ppvB4nMkZvnft0zozBb1Iu
	9FpHhuJpXwsI4qipIiHNht2wHe8uFGhqalToFYInQ5P4481WYtuC8IJUsvuU9Zz/nA5Snfzn19s
	lAxlnAE0n5jZ2Wbnq3duoGUus/J/rqhIo3IA95akL4vKA/0iw+kxmRtwX8XZ98+ZlrKXA959qNV
	0NdjL1JJax6RkyfyTtB0+JqgPRVyjHO3SPbhDCR4TlbK
X-Google-Smtp-Source: AGHT+IGFgriLpwdnn/orSX8NDZko6xG1PoQsB12fWFO4Wk21/MbWHjl4EsH0og/eQUb+SiDYa0irrg==
X-Received: by 2002:a05:6808:6b8e:b0:404:dad4:f971 with SMTP id 5614622812f47-4064686024bmr7426968b6e.33.1748364600716;
        Tue, 27 May 2025 09:50:00 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-734fa986d42sm4352594a34.12.2025.05.27.09.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 09:50:00 -0700 (PDT)
Date: Tue, 27 May 2025 11:45:14 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, Toon Claes <toon@iotcl.com>
Subject: Re: [PATCH v3 02/17] object-store: rename `object_directory` to
 `odb_alternate`
Message-ID: <euflgbipchqi7jvmz4yzwzx6ao5guen6xmupkdaubjbc5ksgkp@aheynye35bby>
References: <20250514-pks-object-store-wo-the-repository-v3-0-47df1d4ead22@pks.im>
 <20250514-pks-object-store-wo-the-repository-v3-2-47df1d4ead22@pks.im>
 <tjsbotrnrffykmi3letktpb3bly4nqw4wxzyrszgbln7pznem4@3kwiq4zvaebw>
 <aDP_-VX_Rz-MqiAS@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDP_-VX_Rz-MqiAS@pks.im>

On 25/05/26 07:45AM, Patrick Steinhardt wrote:
> On Thu, May 22, 2025 at 05:13:55PM -0500, Justin Tobler wrote:
> > On 25/05/14 07:12AM, Patrick Steinhardt wrote:
> > > The `object_directory` structure is used as an access point for a single
> > > object directory like ".git/objects". While the structure isn't yet
> > > fully self-contained, the intent is for it to eventually contain all
> > > information required to access objects in one specific location.
> > > 
> > > While the name "object directory" is a good fit for now, this will
> > > change over time as we continue with the agenda to make pluggable object
> > > databases a thing. Eventually, objects may not be accessed via any kind
> > > of directory at all anymore, but they could instead be backed by any
> > > kind of durable storage mechanism. While it seems quite far-fetched for
> > > now, it is thinkable that eventually this might even be some form of a
> > > database, for example.
> > > 
> > > As such, the current name of this structure will become worse over time
> > > as we evolve into the direction of pluggable ODBs. Immediate next steps
> > > will start to carve out proper self-contained object directories, which
> > > requires us to pass in these object directories as parameters. Based on
> > > our modern naming schema this means that those functions should then be
> > > named after their subsystem, which means that we would start to bake the
> > > current name into the codebase more and more.
> > > 
> > > Let's preempt this by renaming the structure to `odb_alternate` now
> > > already. This name is agnostic of how exactly objects are stored while
> > > still specifically pinpointing that this is about an alternate object
> > > database. Furthermore, it is already used in Git to represent this
> > > context -- the only stretch is that the primary object directory is now
> > > the primary alternate.
> > 
> > I know the naming here has been discussed in other threads, but
> > `odb_alternate` doesn't feel quite right to me. When I think of an
> > object database alternate, I think of the additional object sources that
> > may be configured for a repository.
> > 
> > From my understanding, the `odb_alternate` here applies to any object
> > source, even the main one. Using "alternate" makes me think there is
> > another object database somewhere which may be confusing in scenarios
> > where there would only be one.
> 
> Yeah, I do get that. On the other hand I don't think it's too much of a
> stretch: the local object directory of one repository is another repo's
> alternate. 

Ok, I was only thinking about this from the perspective of the
repository we would be operating in. But I can sort of see how any odb
can be an alternate from the perspective of a different repository.

> Furthermore, we already do have the distinction between
> "local" and "non-local" objects, which translates quite well into this
> new naming schema.

Just to clarify, are you referring to how we differentiate between local
and alternate odbs? I'm not quite sure I fully understand.

> 
> > Ultimately I don't want to bikeshed too much on names, but wanted to
> > voice my thoughts. As an alternative to "alternate", maybe we could do
> > `object_source`? :)
> 
> If we were picking something more "generic" I'd favor `odb_backend` over
> `object_source`, to be honest. But we have agreed in the previous
> version of this patch series that this isn't the way to go.
> 
> So I'm not quite convinced that `object_source` is better, and if we
> were to go this way I'd also rather call it `odb_source`. If others
> agree that `odb_source` is better than `odb_alternate` I'm happy to
> adapt. But until then I'd rather leave things as-is.

That's fair. Between `odb_backend` and `odb_alternate`, I would probably
still prefer the former, but ultimately I'll acclimate to whatever is
choosen. :)

-Justin
