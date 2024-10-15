Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AD833C5
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 00:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728952448; cv=none; b=H89CPGlE+BppDmFtZzo9jryP9ydfKjLQhVJqdXnC0kRsqOvjdF/OSL36WgW1gbfUSuF0nMRhUqZXXj6941/qNs4uXdIxx3BzDnp1TCj38JmChTHqIm4yZPDYaeBSxfVPAlQxcA3HjpzOqIVeFzFR4dhsswt30Xgz9Rws5AVEzuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728952448; c=relaxed/simple;
	bh=CyWf7ViMJO6fTliX/e8QeFkOZ3+h7dDMHiXznnijWC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PwYolGxbP3M6+3Cb28c2Vn0OB1VjKvtTPwa87k7GDfIIzDNHK1WQVZG/E+ZyjVEw1gj76AtivPl7Qf4reAuiUrIGyOjbeOUV+nc6JfnfzOLTFpakESg3WDdo1RQj6pUa5JN7q+8n1uUsUItMB1VwB8FRtlo1UT4avhpfKj0DYjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=UMfwoe+V; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="UMfwoe+V"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6cc1b20ce54so9303836d6.0
        for <git@vger.kernel.org>; Mon, 14 Oct 2024 17:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1728952446; x=1729557246; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CyWf7ViMJO6fTliX/e8QeFkOZ3+h7dDMHiXznnijWC0=;
        b=UMfwoe+VYS1y/cYt4+LEyD+/WoPPbOpOGagd3duGh3B49HBO+r+9Lbgnz5SrolUHJy
         mxf5B+Jqt8wNDDhZOjhkdrfxZk9+5MjvhpIhZEGVMG8ISWWrQhafuTwaeSeg3GR6pjtC
         ou5sMLQ3cRyS0bweuuSo2f6nrIQ43YPLtpYksdO673ewkufTuuSro+RngdKoZC//fNXC
         qYWjFSEz4BBuepizgl6oygnNb1Ghi6jbJVJTV15To6R079CH95FKiTGkt9Y1VyQBiql/
         4DptbZsBZEhpC1G/w0Ls8+FFBfVCbpqCDSfvjZ10A04OShc0JWzd2aIWl2wSO1OaMMxR
         M3dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728952446; x=1729557246;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CyWf7ViMJO6fTliX/e8QeFkOZ3+h7dDMHiXznnijWC0=;
        b=s58ic+cgltgOMe3+Phums/kieQeyY9j7xfM5D4tcDHSM038cNPjIZ1g8Ok22lHxSA9
         eCMBmZbDZSQJFj34CoaYou62FDotymvog4kAolHoBpd+qOkSQP+unFU5/jutsg1iILFL
         KhReMG8aHt/ib6YO+yvP8km3eQ4JJ9kJJS7AnxF5vAge8RDllRHFzgftZgP3R3oVV5Gk
         H6FPObqFbqu0RkK5YnCYul6QWKhopcFzBYlOSHVB2qz3J98bDbp1YSoCDToQ7CEUX/yZ
         RVk/e/cyF8YIg46afyVZVEgiu123quu7HoHH8uFLd27nwNjpnSi982SMDf/O6LDLqGoA
         CIMw==
X-Forwarded-Encrypted: i=1; AJvYcCXTTOzKZoeBBTTNhpIYawm86k7LycnwClfMzmfJD9RYhqrV9wJm5J7o4KZmlFSPSjqMhmw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVU7fU5iyDjcEKJs6LYdVW/0YQ/IumiJZcB75qbiOQmhu6EBsA
	KnzHe/9Clu2GKd4H/TdeDWHBqDrscIsWb57D4R2I06LD+OCM4eeZZAGNL2evNV4=
X-Google-Smtp-Source: AGHT+IF4M7K325aCmsfOvB4gNihUGtaOkIypPDTJkKm8nvnyncPtMpID/Xu7/f2r1zbx1DzoIrF37Q==
X-Received: by 2002:a05:6214:2f02:b0:6cb:f276:3c1e with SMTP id 6a1803df08f44-6cbf9e8b7a0mr189809556d6.46.1728952445949;
        Mon, 14 Oct 2024 17:34:05 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cc229698fbsm1007566d6.126.2024.10.14.17.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 17:34:05 -0700 (PDT)
Date: Mon, 14 Oct 2024 20:34:04 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v2] Makefile: fix dependency for
 $(UNIT_TEST_DIR)/clar/clar.o
Message-ID: <Zw24fMNMTK14EqfL@nand.local>
References: <pull.1810.git.1728323033680.gitgitgadget@gmail.com>
 <pull.1810.v2.git.1728667787227.gitgitgadget@gmail.com>
 <Zw0HmISykehEiC-p@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zw0HmISykehEiC-p@pks.im>

On Mon, Oct 14, 2024 at 01:59:25PM +0200, Patrick Steinhardt wrote:
> On Fri, Oct 11, 2024 at 05:29:47PM +0000, Philippe Blain via GitGitGadget wrote:
> > From: Philippe Blain <levraiphilippeblain@gmail.com>
> >
> > The clar source file '$(UNIT_TEST_DIR)/clar/clar.c' includes the
> > generated 'clar.suite', but this dependency is not taken into account by
> > our Makefile, so that it is possible for a parallel build to fail if
> > Make tries to build 'clar.o' before 'clar.suite' is generated.
> >
> > Correctly specify the dependency.
> >
> > Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
>
> Thanks, this version looks good to me.

Thanks, both. Junio had already marked this one to merge to 'next', so I
will go ahead and merge it down in the next integration cycle (which
should be tomorrow, assuming I remember how to do it correctly).

Thanks,
Taylor
