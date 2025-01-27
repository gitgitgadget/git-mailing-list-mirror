Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BB519007F
	for <git@vger.kernel.org>; Mon, 27 Jan 2025 19:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738005889; cv=none; b=USzP3J2DuyPDluZTBQd25R/d6HJA3Z21Hqkh7m68+vQYg3FxXmIBktThN53VePec4UuUSGZ6Jpb0murVHYJnSEdMFgXiPhoCw1GDdIyJDveyX7IZWzPzV6Lq7Jv+MBUmML6FaR5xXKX+oYdl2S5XrSViGg1iV7Zsw8uuNutbA4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738005889; c=relaxed/simple;
	bh=hnUWuvhdlZCT+yQuMc9AlczFOFJMoyj4ZCXhr49dGMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HWw+V+6c5pqgT2QP8kRxfokRS4iSKra9W/kgG9c8WZuCiQB6kS+LEIeaI9IIIBxmbxH91eGccWCRn84drkMb463B9mpXNBJQ0M3hXe0EYWYX7lptzIgh9CcxQbYbUD7C8ajFBy5oPaB5MkXH+dXCRxVmoJdEhIhTu1MotZsUgzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OG1jvb/4; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OG1jvb/4"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5f33d944ce0so4786305eaf.1
        for <git@vger.kernel.org>; Mon, 27 Jan 2025 11:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738005887; x=1738610687; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u3PG5q/PRNZy9KD+Rxozgf4sbrXpXJKVgEUNvGAuwnA=;
        b=OG1jvb/4cAbqjI/mMk1SV64BWMIUncdHkMnJXkxq1To8jQY4ysD0S6Y9VdjmkhZz/y
         Q7wMzDoALSs7MlFPH/oZIVKHKMhUAPTVo/jekwRoYYglc6wDknH2lOnhphZmQHBEqQjv
         zE5JhjfVck57bJzbd9dxHYiXpmGNi1BmqPD8v1+WhqhDcRMVjadbUvbrWz8ME7qOjs3f
         txMUbflwgWWIUyCSjAX+LjY8fw4bhVlujaCFY4+6K6XCRIgbnNdapApgNg/O5uy1zom9
         i40ZYkf6EnLA7nqv5Ju9wbPMYrhp2EHOTZ+TTiwp3ppgGGT/kcyeUHz/DtezDaTYReu7
         QUKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738005887; x=1738610687;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u3PG5q/PRNZy9KD+Rxozgf4sbrXpXJKVgEUNvGAuwnA=;
        b=uFCbWXI5J+Y8+BqkNrQxm0AvnlMq14dEFz/Ecydrjip2dmSKLDYP7a63tu8z1WhqzL
         ZDlyoXaZV96/lZ6oDeImSs50YGaTLFe0QSIcWZF8B0oMTl1T9JTfFZ67vKK97p/0SprB
         FCb7H4xrmMNz6mbrBYRjWSyw7Gox6/kY49ioKiZvrvthdUc7AZ+A+wdqRwko5DzGaYvc
         W+lieEA6uOEAhddeRf4Prz0JI8WNY/ovZ5sRXmejwl7YjOb0KWptfg6ykYGssEmGmp3N
         60CK2j8fyt1nWJpNbFaKVQp4l4qPaXAG0ZCPvFU5xE6lFnKT4UPyNHFz6wVVrCVbS5bO
         xUaw==
X-Gm-Message-State: AOJu0Yyhro0Y54MWJFxRtO6Q3bkz0q2cFZ5jj02rTXtVTmQYt7fr/hUh
	OQllIpogl4Xd3dp4Yo7kQi+Zgqon+PrZc3en4xbhpr7IqZ5MjfE/fjgyRw==
X-Gm-Gg: ASbGncu/Sq6CjPSpuB8PF0YNjxBLV4wcN43bG6U8bA+d8tOqLIPTFGztvICQltXVq0x
	M3UzKUjDgJ3cm43T4/j6DTY63jO8azt7NHN24V675r+dD7o0zH7nuPJvMyuMnkGHMbHlxMGC35r
	Y2XQd0+Or9L2yMt5e0sc26EcIayux2H9Cy14k0jawDF5DX4RK64xy/ZAxcFCDGepKPE61YpxGoF
	4IZKbS5HlfO3c8VKDWC5tfMmj8gUU2YqGQIhXGcFrae7gN7yjm6n+0FCdmrGUyi/ordvxL31A==
X-Google-Smtp-Source: AGHT+IE/ZwzWj2eSk3KVdaKxr5dXOyuoTl80xLOypP44OXDxOOZjSeHOQEyXerqGGVoJqwkDLS5pxw==
X-Received: by 2002:a05:6820:206:b0:5eb:b282:5916 with SMTP id 006d021491bc7-5fa388a1180mr24006394eaf.7.1738005886691;
        Mon, 27 Jan 2025 11:24:46 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-724ecf84ec3sm2403352a34.46.2025.01.27.11.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 11:24:46 -0800 (PST)
Date: Mon, 27 Jan 2025 13:21:55 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Edward Thomson <ethomson@edwardthomson.com>
Subject: Re: [PATCH 06/19] reftable/record: don't `BUG()` in
 `reftable_record_cmp()`
Message-ID: <jvue6ynjjlnto657pvobi2trx4xajnu7nyeqc4vnumy64ej4at@5g4wf3vko6a2>
References: <20250127-pks-reftable-drop-git-compat-util-v1-0-6e280a564877@pks.im>
 <20250127-pks-reftable-drop-git-compat-util-v1-6-6e280a564877@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250127-pks-reftable-drop-git-compat-util-v1-6-6e280a564877@pks.im>

On 25/01/27 02:04PM, Patrick Steinhardt wrote:
> The refatble library aborts with a bug in case `reftable_record_cmp()`

s/refatble/reftable/

> is invoked with two records of differing types. This would cause the
> program to die without the caller being able to handle the error, which
> is not something we want in the context of library code. And it ties us
> to the Git codebase.
> 
> Refactor the code such that `reftable_record_cmp()` returns an error
> code separate from the actual comparison result. This requires us to
> also adapt some callers up the callchain in a similar fashion.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
