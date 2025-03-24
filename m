Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FFF25D527
	for <git@vger.kernel.org>; Mon, 24 Mar 2025 15:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742829266; cv=none; b=dw7l/k5QC4g8w4JZcIufkEH7a/nEqiua4hHOXbBqESlk51W5ZipZKpJoLGyHnREYEbNt2ds3P3WVmtKpTVyytFbMyAhgXeiUIVJD+OxqlYVIsPwi/c+S5438UX4nxkFIQUgvBzGLII+d1cCJjwnc6BBeTU5CERAwivYIOLGCtpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742829266; c=relaxed/simple;
	bh=Fq78Rajna4AR3hIpnvcg9eQ+o+RZUCLyeLbhhSjcVA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YfaEOf3bP07VZZDlkD7B4uWOjs5GiqkjWTUiVnHGPT1UfVQZo93Gzq5/WKwZVq60LF2yQvVqIwPJcysx4YRqbk3khvn69FpQJqhL6IxG0nX2gQN5AWRnHWcPPkm4+GWDLTNRyoRdPtx07mSEgKGFBTxK91YaCf8jUUzRATPp5/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BzhbSUVb; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BzhbSUVb"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-601ff283d70so1251919eaf.3
        for <git@vger.kernel.org>; Mon, 24 Mar 2025 08:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742829264; x=1743434064; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OmZJF9Ta3htBujL1xByblFqXyqZLMcVP1oC9oDCNryY=;
        b=BzhbSUVbFFVWyneuCqrua066hgCv3SJs2yNAeVRxCTZAacrtcJ1efAvQ/YCzgWWBwW
         xc/f2mMGuFHYFiVp1fe8UI0iZZYNwQjDMrKgDYIVR03nIgovJkao7Or0UYOMgwxtB8zL
         8N7ZqjTVFHRt4gMELyElhxF7he1v4YmKL9hNHraBaFvGVtRBMwfk42JY5AIyJYcUHCI0
         lZl/UCV4HSVMQmDlKMI9IEtQwtTtW1MzbP1NjL82T2lqiFrvjRqXSiCFulbVMGeOpw9Z
         VBLjIES1LzKzi46IAF2dvE7Q748MP2f7IhIbVxL3opFOoVuXBze+6Z/CjGqO34Whcg78
         Ty9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742829264; x=1743434064;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OmZJF9Ta3htBujL1xByblFqXyqZLMcVP1oC9oDCNryY=;
        b=JTE0IVRGlZ7j4T68JdeIoEoBuuLty1ZNKKJy7/clgaivaR5CK6HmJowIL0NQjTdl2W
         MclDNdkg+dxblkipgqDtyLo16U/1+OV0sIfRjI66cW7GDJ0qAlV6DH2YFfE7NDuJPKWE
         0h6EtirJjVjug2s05YopYrG6nc3tO8GgahfONV00Ex6xCJwCNAT1fh/7tBjs9K34ozSL
         JkLR28WQGI7x2mdSBPpYRacOYI2CFv2sKC5Cz2rMRH7WHmAScd/d9iWN16JvahtAkM9U
         Gl4YBa6Loxew7tsDilEeHQx7rr0xIEhM5dmsxLEA69rRP9cMJAuasWNjklquNhRCtl3y
         HVKA==
X-Gm-Message-State: AOJu0YwbrfvwO7JwaGAOT/Mmb/iOsh4xy15X8W2dNfAJzfyE5NTWUoCE
	fZTVQG2v8nPAdHmPZwxDUF8FEqO6rzegNeiodFjXlLzd8XbK58J2eg6h1A==
X-Gm-Gg: ASbGncuZHvTBz6kw82vY+Ms9qmyV2zDckayM7aAH8K+dWJLPFJRXLnjPYWSx0+tiBgN
	oQFdpY/6XpzJDulvOBz/YWasJ6FzFbXjNab+FWWQ941x5TvA7kNO1AUm3vly/iOAw9HB4xvmTzM
	DsJMyPzuhmNK2J8qPGE86oYrF7rQBNCcVVp3NbEO/lVsp6vwrYP2Vc0UF0+rlR6jsYowwUnaxDL
	UrQ7gcRvnpwtpKLK/ff2sPZ3gR5hytJGe5ED6+exnPlu5rjrHAs1TQAGPu5oV4dS03kelYhJcN9
	A8vmby9iOtebLxIoQzAgFCiFqfkAvVD1S7a5Fw==
X-Google-Smtp-Source: AGHT+IG8iwUcxNzxVKkJKjBRggE9EiCYl1oeHv9Kc+GzMUmUB8fBwHcKDSaUlBErVr9776ZrJaA1xw==
X-Received: by 2002:a05:6808:118b:b0:3fb:eb1c:2a7e with SMTP id 5614622812f47-3febf792d2bmr8803820b6e.33.1742829264027;
        Mon, 24 Mar 2025 08:14:24 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 006d021491bc7-60234783ac2sm1192897eaf.23.2025.03.24.08.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 08:14:23 -0700 (PDT)
Date: Mon, 24 Mar 2025 10:10:44 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, likui@oschina.cn
Subject: Re: [PATCH] builtin/fetch: avoid aborting closed reference
 transaction
Message-ID: <vmmr2cwiyd2iz7c3yfyzym3l2aono7lsx7wig3pwmw33gst37h@orjtfygfyow4>
References: <g4baz2kt25ysb6wcesoqxhvw2ooxkmqio3dj6b44h6gt5l6z3r@rocsjlys5nqs>
 <20250321004437.505461-1-jltobler@gmail.com>
 <Z-E2ns9VziejSLB2@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-E2ns9VziejSLB2@pks.im>

On 25/03/24 11:40AM, Patrick Steinhardt wrote:
> On Thu, Mar 20, 2025 at 07:44:37PM -0500, Justin Tobler wrote:
> > As part of the reference transaction commit phase, the transaction is
> > set to a closed state regardless of whether it was successful of not.
> > Attempting to abort a closed transaction via `ref_transaction_abort()`
> > results in a `BUG()`.
> 
> Yeah, this is one of the more intricate parts of ref transactions, and
> it has been biting me several times in the past. It feels somewhat
> similar in spirit to how the `ref_iterator` used to automatically free
> itself once it has reached its end, which led to the same class of bugs
> due to the interface being way too intricate.
> 
> So I wonderer whether we should refactor this interface in the same way:
> instead of automatically freeing the transaction on commit/abort, we'd
> never do so and require the caller to always free it themselves. This
> would make it way easier to use because we can now unconditionally free
> the transaction everywhere.

I was also considering this. The interface here feels rather awkward
since aborted transactions free themselves automatically while committed
ones do not. It would be easier to reason about if the caller was always
reponsible for freeing the transaction.

> That wouldn't help with the fixed bug though, which is that we call
> abort after a failed commit even though the transaction was already
> aborted.

I wonder if it would make sense to stop closing the transaction on a
failed commit and require the caller to abort it. This would allow error
handling to unconditionally abort the transaction during cleanup.

I wouldn't mind sending a followup series to refactor these interfaces
if that is something we would be interested in.

-Justin
