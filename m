Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA5E31D39F
	for <git@vger.kernel.org>; Thu, 29 Jan 2026 19:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769715279; cv=none; b=KBM9dmT4IFJXVK9xhAZDNoZHj32Hh8hrowcFpmN7cPDIHzJcafHgar/2Uom7nAsvvLQken0X5zpB9Py96YT2URe97tMgIEtG/4MqKxLRmVrKdCY+Q9yJeiWK7gyxQJEVaZEGtldQ1e9ea/CsQbDJp30aO0MM0xyEEOD9lXYevAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769715279; c=relaxed/simple;
	bh=Jrd1apgn1FCzDUfn/EGSLp3eHSet2bPW35Vh14A/ShI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qn3ZDKi7VBBz2TFuI64BayJqQdoPH0woY5COlGzC6OrI94ySnMOdE+cSNna0rV9VODwUEWLY+4kvJRDnJALCHIUNuGyWcv7zrzIEKPB0CF7PkG06xtCCnrU2Tufvzf6ekzy9SGl0cXrWPINr4aQIMxdU9a3uSigsED1qRFkAKYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=kb8p8Dct; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="kb8p8Dct"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-78fba1a1b1eso21547577b3.1
        for <git@vger.kernel.org>; Thu, 29 Jan 2026 11:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1769715277; x=1770320077; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yjjSNdTVf2NqQOV+SpAet+B/2sZrxxPKoVbtRjzDv94=;
        b=kb8p8Dctud4SIUkU+eReGi1wWnjEFwA760SXRNzKjU6YaVf0MlDZwALf2ZbjN21k/B
         9xhETIUEQZ65dNtS4ADD55SocKEgpGznsEwHPZ3LRBksVlPk+U3lIbn9pwfoZyb7A7Ie
         5U/QG2PGYxAmaWOhp5dLLxPhyoZkDj94/oLuR948J+GR75cB++n6l2eMc3YI/zbouYia
         MXe1v6JrWU14QQSLh//S/pzYTtIbNVpjjWEWMpriVGMnX0thM0chkRWCY8ZGFKV4VI7E
         sKQ3WbsO1enNP6vfhPjJgQyrQe9ouq9uV05IkoY92c4J/ynrP6FvkP56h7O+niD3GX3g
         njNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769715277; x=1770320077;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yjjSNdTVf2NqQOV+SpAet+B/2sZrxxPKoVbtRjzDv94=;
        b=s1mZwCb+18/jE85F6+XX1wRNLmaihZ13gWhfVcvPzsdnwWhCkYlzhPnXzJ/HUDShvc
         157EV0oNv8d3omQurCoFPmb3Ciqs3evYK8VvTrGao4otlY+A1nFANghLAeggdyzplJsM
         O4DhTxtUlseeJSP3WcyaJZ1unm3V6JobxxSHxxPcGttWrMahO4yPqP7ERqD3eVSOuyXH
         62dag1bZA1t8YVmS43tT8C44YktN6RAGiyc6Cw5xg92pVa2RbTFG+xmMZLzfQhGcN/AE
         BgcQ036/AuTvcmOf0RZQAGCxv8Z6V0zaE+jP8ESBs4I7UhLm7Rcmloz1ITKtEJtP1mRd
         AyiA==
X-Forwarded-Encrypted: i=1; AJvYcCWlyWtADiocDmdKnxkO8aPq2xUDDjQQjaBs/dv3VxdpRFR/yk+nMqyYIXq054iH8V1zgfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoKoX1Wqa4DHVdnBn4CVpqVe/CE6Z0UNUy0lY5m9Xdw9YuSOG1
	8dUmkhrKeNmJv8l+W/jiQ3XMluSlnRwMvu5GITbxCvO5uAgA1lQnkNxZiwZI373F784dnVkafgi
	5+74UfgE=
X-Gm-Gg: AZuq6aKGAAWWf5ePZN7gk0xHfLbRr7DjBVYgCroDf36lg4BoztCmmLFfhs095cZnjvH
	uaZp3Ra9GxcARAMYIUD3W7R8NxZefOoVGY/mM3145Ad8Afydy54StIhPaDKWXa1y0b6+4kG5Le5
	JmzctTfth1YVA9dwtcY+c0VvePiVEdZextTL7tLfi6N4r2vRdLI4XeF1SwhmN0jTeMVXsKsrJht
	PvuYTSz1c3ZrF0/lSOoozX73sHXjVw+Zg5E2M62N6bUtmlT+4fEs9I1Jhz3qF2M7CybYpA7hmqD
	iT9aKq9deTuRava8nmvfb+2Ga/mXqSdEdkJyuC61xWaOcGks9wbrruUOQozC5zUQhYu2LYYSSEo
	6eEF1eOK6wq2/Rr3Klimf7KhV3WFHe+6+5q69ZV7NosUlT9kCajbVmg7n4JwrwQoZcmxgV+EMoR
	4xzXe9VZAiWvVqbEI4howIJtvrZK0TLW9xnLoNMzgq9zM15t7OCXz/EgoM+TwvJjqN+O0aoT85p
	1TNvnpRci5to8WMXg==
X-Received: by 2002:a05:690c:ec9:b0:787:badd:4f with SMTP id 00721157ae682-79490d3e622mr37602747b3.17.1769715277124;
        Thu, 29 Jan 2026 11:34:37 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-794828f876fsm28025577b3.54.2026.01.29.11.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 11:34:36 -0800 (PST)
Date: Thu, 29 Jan 2026 14:34:27 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 2/3] pack-bitmap: fix bug with exact ref match in
 "pack.preferBitmapTips"
Message-ID: <aXu2Q1TgsaUIo30+@nand.local>
References: <20260128-b4-pks-fix-for-each-ref-in-misuse-v1-0-deccae3ea725@pks.im>
 <20260128-b4-pks-fix-for-each-ref-in-misuse-v1-2-deccae3ea725@pks.im>
 <aXrGfGUJQ34JAmuz@nand.local>
 <xmqq7bt0cqec.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7bt0cqec.fsf@gitster.g>

On Thu, Jan 29, 2026 at 08:52:43AM -0800, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > Looking at the implementation of bitmap_writer_select_commits(), we do
> > not guarantee that *any* reference specified by pack.preferBitmapTips
> > will receive a bitmap. That's because we don't necessarily enumerate the
> > entire set of commits when determining which ones to bitmap.
>
> Hmph.  Is this documented?
>
> 	... Goes and looks ...
>
> Yes, it is documented.  We say "This is because ..." but it just
> explains it as what the chosen design of the implementation happens
> to do, without saying for what benefit the implementation was chosen,
> so it is unclear if this is designed behaviour, or more importantly,
> even if this were designed, what the rationale of choosing that
> design was.
>
> "When they are so close to fall into the same chunk, there is no
> point having bitmaps individually for them, as their bitmaps will be
> very similar anyway, so this design saves space without sacrificing
> the quality of the resulting set of bitmaps" or something?

The commits are generally presented in the order they are traversed
(regardless of whether we are generating single- or multi-pack bitmaps).
That makes it likely that commits within the same window are likely to
generate very similar bitmaps, but it is not guaranteed.

When looking at the documentation, I ended up with the following:

--- 8< ---
diff --git a/Documentation/config/pack.adoc b/Documentation/config/pack.adoc
index 75402d5579d..b65cbaaebb4 100644
--- a/Documentation/config/pack.adoc
+++ b/Documentation/config/pack.adoc
@@ -168,7 +168,10 @@ pack.preferBitmapTips::
 Note that setting this configuration to `refs/foo` does not mean that
 the commits at the tips of `refs/foo/bar` and `refs/foo/baz` will
 necessarily be selected. This is because commits are selected for
-bitmaps from within a series of windows of variable length.
+bitmaps from within a series of windows of variable length (in order to
+space bitmaps out throughout history), and we only select one commit per
+window. Thus if multiple preferred commits appear in the same window,
+only one will be selected.
 +
 If a commit at the tip of any reference which is a suffix of any value
 of this configuration is seen in a window, it is immediately given
--- >8 ---

> > At the very least, if we do end up going in this direction (and I am not
> > necessarily advocating that we do, since I would prefer a more
> > consistent set of behavior), we should at minimum document it in
> > git-config(1).
>
> The documentation says "... reference that is a suffix of any value
> of this configuration".  Is "refs/heads/foobar" a "suffix" of
> "refs/heads/foo"?  I actually find this phrasing fairly strange, as
> I do not think of "refs/heads/main" be a "suffix" of "refs/heads/".

I agree, the use of "suffix" is confusing at best. I think if/how we
change this section depends on the outcome of this series, but the
original intent was to say that preferring "refs/heads/foo" would make
the commits at the tips of "refs/heads/foo/bar" and "refs/heads/foo/baz"
preferred, but not "refs/heads/foobar".

Thanks,
Taylor
