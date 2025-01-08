Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCB31DFD8
	for <git@vger.kernel.org>; Wed,  8 Jan 2025 00:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736297593; cv=none; b=MPfx+LUo86raQwwkChUSRsDGObpAT7Ne9dWUpNpnMskYjnzVXVLpmGOlDKegS6mDB3JMu26GLqohwatCe+bck/sh0l5TwtZGnipZfB0ws+kVLMxz+vPZw6LSlCk5dxWTea3EaFGa/cB/waSyGXo85bh7xbeu8A+QX2qI4JfSsiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736297593; c=relaxed/simple;
	bh=TyAnDHVbW/0AllAs8mPlvrm2qmOYbuwkbFB+R2dsr88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g9cNliV4FpsXLwYxe7arrwBNUPfVt+2CQ/r7uNCpJK0FLksykfQ05+XHphRyqCRJv8AtgqkziNT1pIEF9Qc8X5Wx8fWbol7lOMZrsE/ur4ERk80X/SmgJGxhH5ZyPpd637UBEn7iF8FcbWLjp9dpkUPv5svD5waD/4nnsXEGPWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O73M5A+G; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O73M5A+G"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2f44353649aso19405146a91.0
        for <git@vger.kernel.org>; Tue, 07 Jan 2025 16:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736297591; x=1736902391; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ewEsHrd/Ag4YLWUWtFREZLJV4W0ZXdRqGx2VsAsGrVQ=;
        b=O73M5A+G0t7b1CcwbZEtoyrGSvm4Xvk5OQz8/2M1oWsMObqSzs+VYaR3eETqvH46G0
         uwFV88g28gi5dNhy8gzimECWHVxoJlya7ITpjx+JresSGMQRsuiJFFuY3Dj7CYe4F0od
         PvFaLtwe5ZsQbq+/TmsuHptcIHUXBnh1+EklV6vEsWB52K4iadb5wYpWAKMfCZzGQaSB
         k+HoolqJU7nR7f7+4JdL46eiyVVA/JmcZkgw3sQY1Bkg7ezG9RI5o+BglK2mixH5K1ad
         VjPr2iymMNCWgNGJ+5X6DEYh3tLDOY3BrfXLHlXREKY8ytjHsVTfVszrIqqfHwJSROD4
         /zfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736297591; x=1736902391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ewEsHrd/Ag4YLWUWtFREZLJV4W0ZXdRqGx2VsAsGrVQ=;
        b=onPJ/FadvqndiZsS1Q74xxnqexCfThrSYhWn832BdqVt0/d0631EGcIS61Kqs6o83A
         YcSI3KsChIIS2+7oUROFXQoZyv9KfLILRuGK8x5rTkfnQhdZdrZfGz3AzNUEKYpeZl7q
         nktkC6tTBjmVQRkoZRCZnTQuo6KfSTi3ErOziFQbHMQKUtih4gPsbZY4u2ck+vIMc9XB
         EnoUS1CCRU+iKfrekp4syB4PxaxW81lDF5zF0u6tvvl9X70L4bWAlAXKUkrQk9N6hbVc
         MyQfCz0yZa4KkfVWwIBGTGYVIlPdbX+choReH1Xif8GfuXWaRa9c4X5oDP0zwlDlb5h+
         HbzQ==
X-Gm-Message-State: AOJu0Ywoha6DMdsdiGzVRcKeW5eByT+Ht2c3P8HpvoBSSmJhks330Ir5
	zjGgz5IdFHq4Celpm8EZiQd70Xw9tlfF0DNI7p31wNXtr+p9S2Gyqaw3Aw==
X-Gm-Gg: ASbGncuOLm2wC2c+d7QiXYli5H16p9w2DUQdPiVSnCkFKrUeTP2dl8Tt3JVhta+6TBA
	ZgactTIbSCep1QvMCHK0wMElAVyrRR5bQhzyDRVwrfAbZov986sA3W88od46N7pZjgKJydSxh3u
	aghtieacX7I2RR8XeiWnJDdwbyNnCvv7XtjWCp1H6gBl/1rhIHyzyQ1teocudWKW89fbE8Fvut+
	b4PJfom5HzHmdAngFWZsvNtIwfUZrv2d8A=
X-Google-Smtp-Source: AGHT+IEfx+cRnOtjgFFct47aUYrrFrH58G6ZZ+Xw+0qohs3BaTek+siN8kauiDyMjBKoHzmXMFdtuw==
X-Received: by 2002:a17:90a:d00b:b0:2ea:4578:46d8 with SMTP id 98e67ed59e1d1-2f548eb9e19mr1466529a91.9.1736297591114;
        Tue, 07 Jan 2025 16:53:11 -0800 (PST)
Received: from localhost ([2604:5040:11:69e::e973])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9d94c4sm314782335ad.115.2025.01.07.16.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 16:53:10 -0800 (PST)
Date: Wed, 8 Jan 2025 08:54:14 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 04/10] packed-backend: add "packed-refs" header
 consistency check
Message-ID: <Z33MtrbgN1kxsyGM@ArchLinux>
References: <Z3qNUizvHJLgMx1y@ArchLinux>
 <Z3qN8U2VbZBnUSWj@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z3qN8U2VbZBnUSWj@ArchLinux>

On Sun, Jan 05, 2025 at 09:49:37PM +0800, shejialuo wrote:

[snip]

> However, when adding the new test for a bad header, the program will
> still die in the "create_snapshot" method. This is because we have
> checked the files-backend firstly and we use "parse_object" to check
> whether the object exists and whether the type is correct. This function
> will eventually call "create_snapshot" and "next_record" method, if
> there is something wrong with packed-backend, the program just dies.
> 
> It's bad to just die the program because we want to report the problems
> as many as possible. We should avoid checking object and its type when
> packed-backend is broken. So, we should first check the consistency of
> the packed-backend then for files-backend.
> 
> Add a new flag "safe_object_check" in "fsck_options", when there is
> anything wrong with the parsing process, set this flag to 0 to avoid
> checking objects in the later checks.
> 

Here, I made a mistake. The most simplest way is to call the
"disable_replace_refs" function in "builtin/refs". So, there is a lot of
code and commit message needs to be fixed in the version 2. I have just
realized about this.

So, tell the reviewers in advance about this.

Thanks,
Jialuo
