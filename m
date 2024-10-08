Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BDD17C7C9
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 13:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728394660; cv=none; b=G+OXgE6xXOkhzL+0qvRf/inHfVZpZUtYaTJQaFwL4JRNNlMzBddDgrrnLdE35PBkRRdfGgUJxMtzK2xEvkNOO1FMxQAP44VncmVYGuJzB2QWBYNcw0HWwkmpuI+AY1p+llbm+p6CLujA9C2NepQDA62E/4VtD/cI7mClXbQF/6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728394660; c=relaxed/simple;
	bh=NoQJbrWXUtZ6NBvOgLH+byIhH5N5xobQ2j03rO4bdC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P5pGOntg6icZwC4vosDi0YOOJMJEwiYzuD4gQGO++SFSRF6XkKstU828S/NXazDVPGU/NJuWcDzRa6nCDaB4VruWjF53pGZ16my/hETcfuL43xZBZg+xMc3z6I6+6wvoWUSfJyQTLIFPZsChIP4MWIYk0EmdNagLdebcdFg8/PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aO9leQU5; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aO9leQU5"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42ca6ba750eso35722995e9.0
        for <git@vger.kernel.org>; Tue, 08 Oct 2024 06:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728394657; x=1728999457; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A5zO2xr5PFSuiYXHSkSeZGCvhlsxhYyMnBQtS9BodXo=;
        b=aO9leQU5TXspCGkuX4JSR6XGW3p4gZ8u4nYpYZ+Gh3Aj9zSeoCboZ7snOFEMAQxIwV
         aUXmwcFZgaPqjUPc+YRa9U8rFrlz0ay4xBtYSuJKhCREgbNdhW9fSZQtxsioi7qUSIqT
         zhX5GGAYJbGufsdfI3PzYkj5e3d0I34cUzJl+RIiifB09jlTVcGIt7yqpvwbUOq3K5iT
         nDPkjmEaOeKsZcLA7OzgCXdVv9VYX/rc5v9Bd1IvrA+Nvd0UV1MsTUD6pRQHTZ4sF7MZ
         h2eYkgfYT9iDArQLmVaYuJl3mt4NmDusH3Z4GmFUeTuDFB8PAeS1WkaFA+mhxUJnrGr4
         759w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728394657; x=1728999457;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A5zO2xr5PFSuiYXHSkSeZGCvhlsxhYyMnBQtS9BodXo=;
        b=CLVpEiPDTtNU2GTfrUlLBkTxMTA3i7/jT9ThEyJ6D5jhlKYJM7aK+ucOoDWDOGAtTX
         IiY+t6+KdD4zkrX++Z7KAkhXAGurG2SnZABii0RCpt/Hujcqql97kZOXHvBAWTwekaek
         vRwuo5Z1rjIjTJNryw/acS8zhDLeiB9UsiaVfa8cxIw+a/7xdBSiCLP9F4A9PjR/XPnW
         vZWibZil5qUJhbx18xHeGk/KZzLQWferr0SzeB7e/k7dzO/Xjf0alf5zio4R40aJV9jP
         d+lBug58y9QHEtQcSeEorKlGtLieKcgkEbUiwEFdkvehSXg900TX0rSdf3GEJINZ9Ya6
         i4Wg==
X-Gm-Message-State: AOJu0YxkfLZmWVdo8vLzpLUiJKgQvvHdvcsVQa0TWrztVTOfWbqyeZrM
	pDZNnp8m1L+WVptXBpWl0i3Sud1ulN/T2KyInVw9fPoIlYkJth2Prhp/igZvICw=
X-Google-Smtp-Source: AGHT+IHxSyGPw0Id0r/3ovuKF9Cyy46paa70NLWQ9QjpSFUTKd9JwFTjzMsKVJo2OLDKsG2z7MPjrA==
X-Received: by 2002:a05:600c:3b88:b0:42f:8515:e4ad with SMTP id 5b1f17b1804b1-43057b8792bmr1087105e9.14.1728394656955;
        Tue, 08 Oct 2024 06:37:36 -0700 (PDT)
Received: from void.void ([141.226.169.59])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d2e65d618sm1468484f8f.23.2024.10.08.06.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 06:37:36 -0700 (PDT)
Date: Tue, 8 Oct 2024 16:37:34 +0300
From: Andrew Kreimer <algonell@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/5] Fix typos
Message-ID: <ZwU1ntz8gZ3Ewrcb@void.void>
References: <20241002223816.14858-1-algonell@gmail.com>
 <CAPig+cSjiNF0o8SDOQ5Xgg9dMJnzQBgC71W4VSCFok-DL73OPw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cSjiNF0o8SDOQ5Xgg9dMJnzQBgC71W4VSCFok-DL73OPw@mail.gmail.com>

On Wed, Oct 02, 2024 at 06:49:06PM -0400, Eric Sunshine wrote:
> On Wed, Oct 2, 2024 at 6:38 PM Andrew Kreimer <algonell@gmail.com> wrote:
> > Fix typos in documentation, comments, etc.
> >
> >  gitk-git/gitk      | 2 +-
> >  mergetools/vimdiff | 2 +-
> >  perl/Git/I18N.pm   | 2 +-
> >  reftable/reader.h  | 2 +-
> >  trace2/tr2_ctr.c   | 2 +-
> >  trace2/tr2_tls.h   | 2 +-
> >  6 files changed, 6 insertions(+), 6 deletions(-)
> 
> The gitk fix, though, may need to be sent separately since gitk is
> maintained as a separate project which Junio periodically pulls into
> Git. (Unfortunately, however, the gitk maintainer has gone missing,
> so...)

Thank you.
