Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6CA3932F9
	for <git@vger.kernel.org>; Mon,  6 Apr 2026 17:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775498233; cv=none; b=ExKVUY1+ioR8lA7fulGT94Cg6L9JntpDRBt8IVNCB4H0y0+0CKDEMmEYCDu2i0Bn5qciL/YNFlL/r1Ybf2qAj3zZecq3j/CQH9+tUpoX25Ubl62yUFDWwJHBknYXVqiPR2AzIioNtOblfDq4Do0f4M87ism1qT3ZoLYQ6SHl38c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775498233; c=relaxed/simple;
	bh=8MnE+g1AM3FU71lakysB5ImuousNQ76ExZ2qpaoDCvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bBumpkPgXuNbYQ9oUDddDjgniUG7kYYa3QG4l/Q25rNGNg4ogtNGkDsX+eG4F4n2/iELvoLtJCvttlPijkuuBpbXpxlOZSlZlmu4yMB2tuPGYvIjKnkmGCE/xyR5coJWYhfhrtKlGyXa3bcBBSPZi/HYRmdjViGpU9m4qfPwZTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Trj6umNN; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Trj6umNN"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-46aa216a65aso2268971b6e.1
        for <git@vger.kernel.org>; Mon, 06 Apr 2026 10:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775498231; x=1776103031; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=13Ny0cwldPpN81Mkc7Mb5eQdXT8iTVUD0oKc9CcMfrs=;
        b=Trj6umNNSTs86FixSRv1iHUp52htN0g8Q+Jpl2nJjVgDN2i18B55fvyWcGKp9GaohJ
         +U7N6/Lqwtbke4prUBZT+RgYCix8UbOsIj+sdb+8drP3pYVr7wjRKeNC7YvaVaN4E9gr
         m90w+u4PV11n7HtCDOLugN06z6FtMybZ7Rd7b5yVtJxrltYa4EyarLb48AkWZkB+geoQ
         ILwmGYkFuJdyIqsp9qOVfmdzIEh6+2HkUfWw/+2cJ4x2ljt1JBYX7H0+GUmHcoV1rCfe
         K/sR/Y+6n5R32J/EHgmGSEYZukj+eCYUzKLJNNt8bXHPmO/VFI3eGYUlfJa60YwXiBvv
         /qkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775498231; x=1776103031;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=13Ny0cwldPpN81Mkc7Mb5eQdXT8iTVUD0oKc9CcMfrs=;
        b=pHAUtljLzJxI2tre9KcaQiiKtl2MWlKioRp6w2gz5Md0+/4CuvJYEHSPIQB3UlWe60
         /bw7oBHrV9YFv7ZpuBOct7uaHsoc/VomcFoapKKBetvLOIY5SGMH77q4lkUeBiMETCMf
         gVHiLQjOzLgM1Dl6T2cIHjo9+8QrOK0ClRPu7vePM5qSQAUY+wJ7malm0+P/prgnrMww
         sSieggwbcZ8okYQ8ePujxG2dwAHzbo/I1padlisbpEDapKUFSistAoydV1hX0Zx767tB
         YaBEYA2Q62vrbV5t2zv9YHLDNk3Ot+wdJfsUzhTPjs+4Ns9OdI2qD3CDzmY3n135qrm5
         C2Aw==
X-Forwarded-Encrypted: i=1; AJvYcCV8YvckuVsEhsVmwrieMDhXVR4VBoHBA4gMtVT4jdwiGXvMpgiCB/M3NzIjmRyGdsmNOBw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8KTmyNd4tejIEEgy9qTu5SwwHvsfEYvZIIySKHVDSMPX4kAt4
	IldsRpaXTTbUnrqRX0ig3P5E2XcWGF80eutzIrwWn7wvGu4ANV94yo5EBE+1fA==
X-Gm-Gg: AeBDiesdTSxgmFRTtm3zv/eYQ9jaDBnSNxOohVDCMhCXtDKU2laZdy+Ii0ALm3vP0xP
	Bej0xDuMVzWiojQ+uqZpVR7jV71pzTYrkghpRrB/I8DQw6y0wuTa7zolFOw2L+5B/HDDMZAfKxT
	J6xYNGGDIl/T9kKIojF3IrGa2FesdkuOuiNACkJs0rjhX7C8tmS2bcrTG/6pUy+lxRekY4xjrby
	FbbKchKDeLNP4JLd20wFTZCNSuYEPHSmxTbibMuLUVR2ha/8xVHSTqKwBrprWWbN6iOtxHCIyrN
	1JZJSmRoJMWdChr/vdpNjIjLsMkKCJDeHzlkrNF8GmPQSuvc5o1Ie09YT4Pur01RbNI9qWGbNTg
	qHJUN0Wdlr8EjEXaSd7GcHgdokZVohE4eDanZ90z11NDdTw1aCOrqIrJhtQzkOe0qQEYlEcruHF
	G6ROzmr8Un3U48I3CT
X-Received: by 2002:a05:6808:5088:b0:450:d471:dce5 with SMTP id 5614622812f47-46ef8e521c7mr7096854b6e.6.1775498231121;
        Mon, 06 Apr 2026 10:57:11 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dba715bd95sm10411294a34.8.2026.04.06.10.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 10:57:10 -0700 (PDT)
Date: Mon, 6 Apr 2026 12:57:07 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Jeff King <peff@peff.net>
Cc: Tian Yuchen <cat@malon.dev>, Luca Stefani <luca.stefani.ge1@gmail.com>, 
	git@vger.kernel.org
Subject: Re: [BUG] git diff --no-index segfaults on large files (NULL object
 database)
Message-ID: <adPjXKGIT5O7SK6E@denethor>
References: <CAO0HQ0X_pQmew5tJReOL=u+CMxCjAQynx8JfjykoYAUE59YNzw@mail.gmail.com>
 <d6c63949-1998-4cde-8cb0-902fd7db988c@malon.dev>
 <CAO0HQ0VEJsG6MYrp_bSTuU09PDsypGPrM0XazvM8er0kB32Gqg@mail.gmail.com>
 <4be492cf-347b-4fa5-9bdd-83e7ea8abd92@malon.dev>
 <20260404230939.GA1360412@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260404230939.GA1360412@coredump.intra.peff.net>

On 26/04/04 07:09PM, Jeff King wrote:
> Alternatively, should the odb transaction system be more forgiving here,
> and act as a noop when there is no odb?
> 
> Bisecting the segfault yields ce1661f9da (odb: add transaction
> interface, 2025-09-16). Before then, we passed around the
> object_database itself, saw that its transaction field was NULL, and
> returned immediately. After that commit, we pass the object_databse to
> odb_transaction_begin(), which narrows it to odb->sources (which is
> NULL) while passing to object_file_transaction_begin(). And then that
> function looks at source->odb to go back to the object_database! But
> the source being NULL, it segfaults.
> 
> Immediately after that commit, the switch from taking an odb to a source
> is not helpful, though I think eventually it is used to set
> transaction->base.source. But should the whole thing check for a NULL
> source and return early? Or otherwise establish some kind of noop
> transaction?
> 
> I haven't thought about the implications (nor even really looked at odb
> transaction code before). But doing it that way would fix not only this
> bug, but also other potential bugs throughout the code base when callers
> start a noop transaction.
> 
> +cc Justin (author of ce1661f9da) for any thoughts.

Thanks Peff for the cc! :)

Ok so the segfault in question can be reproduced with the following:

  echo foo >foo
  echo bar >bar
  git -c core.bigFileThreshold=1 diff -- foo bar

And indeed the problematic code path is the `odb_transaction_begin()`
invoked via `object-file.c:index_fd()`. In a scenario where git-diff(1)
is being executed outside of a repository and involves files that exceed
"core.bigFileThreshold", `index_blob_packfile_transaction()` is invoked
without the `INDEX_WRITE_OBJECT` flag to stream the "large" object
object and generate its hash only. I unfortunately didn't consider this
use case.

IMO it is already questionable as to why we would want to start an ODB
transaction if it is already known that the object won't be written.
IOW, if we are only interested in streaming the object to get its hash
we shouldn't have to start a transaction. As part of a patch series I'm
currently working on [1], a separate `hash_blob_stream()` helper is
introduced to just hash the blob and is used to bypass the ODB
transaction entirely. Building/testing with this patch does appear to
fix the issue.

This series is only in "seen" right now, so I doubt it would make this
next release. I don't mind extracting this patch from its current series
and submitting it as a fix if this the route we want to go though.

The other option would be as Peff suggested and to make
`odb_transaction_begin()` just return early with NULL or some type of
no-op transaction if there is no ODB set up. I do think the former
approach would be preferable though as I'm not sure there is really a
good use case for supporting ODB transactions when there isn't an ODB
set up.

-Justin

[1]: https://lore.kernel.org/git/20260402213220.2651523-5-jltobler@gmail.com/
