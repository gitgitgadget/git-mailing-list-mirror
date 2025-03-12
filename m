Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B18145355
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 21:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741816159; cv=none; b=mfhu2Wg4s7g3A+ZtY+4jKSpi+nXHIN6iUtj1DnS/8V6nR+Gv6sYRj/ZX/h4TkeNnO9h6DIHv2cTETgtexiAisQH+NtawTPVSpid/HWJ4t8LldgerPfbg1+XiJdvK7ZeZ2ubp2bqz0hH57v5GjmJy0WQJEmDTVuFgYMRLh+fmrOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741816159; c=relaxed/simple;
	bh=2QEt03/QtkTiYK81swqiW17z5NNGHyHpnF7SwkRfCEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PH56V+NBe5DpXSAuizI4Q6KQPkW1M/iLJgCDGV6gFVBNnFSrQjCENbibVzBnl4rdp3YZ3iXunzco8mKbzS/TSUJ6n66Trti3sP/5wSDK8KN0cETxu2riLHhTKKY4k/7mE//KSRXbgL1DYEV4DCPiOjb9r4/FU7c7qISCIWBesFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VG5+xilj; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VG5+xilj"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5fcd61e9bcdso125642eaf.0
        for <git@vger.kernel.org>; Wed, 12 Mar 2025 14:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741816156; x=1742420956; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XP+VYPn0nNgfmLYLOp8s7CJpWaz26fG8p+aQRaQ03Uc=;
        b=VG5+xiljJSrXAH0vWMpcz+UlL1QnasB2XMmd58ii6GUj8wJgKOQ3seUkuhZoo5gcRL
         4R617UvSD66K+Q9maILXXYr/W5KEys+kBEqpY1dlhifNIiHzRhWkhWlwQR5VmDCdA92w
         q4pjphe4tXfYt8Z7bDIQwH4drpWg75044maAhkpPSKbPSXRNf6vzUkU5+nReyFXRA3o2
         je5ZrErTus4mab2vmw+DEhU6YYW1lBfuz7/tGPnUVoXo2TgfVgMiSewFuOt7JTh6boJU
         Q65cvY3PvULZHR1cpoYdrqUs3b2aawx/9iSoCaE1s78BVapOwxLGuLqVT8/zuiRhksT0
         5ngw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741816156; x=1742420956;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XP+VYPn0nNgfmLYLOp8s7CJpWaz26fG8p+aQRaQ03Uc=;
        b=KSmmI25ZM5yLhVo2SBS17jKQ1q4U1jCpKD+f3vGEDZ3TkDlqeSb0h70Nhe0lpyik1q
         GWPsf8iVYGYUDoI7UDsrh+x3nSXuSnM6Ov2r9T1aRNy44jiIMLU91C9kdCJUwi+5BSWE
         jkogbMjT+fc8wBrmjBFnp6igbUZnYOrzGmtKl4ay3qg+rTm7Y92i/1TnipqTk9TjYCML
         D9GtOFpCkhxdWyQ7ieV7VDpJIosBfB1Mgxn69VdWjJKjZeYL69wu8pmcaAwcXrhD7LnQ
         rt3uypUz3vzUZ5rI5+AdSJm8gIC51SjiWN4VpYCMN15jC8829mUOqK78r346p028XG+C
         dgTg==
X-Forwarded-Encrypted: i=1; AJvYcCXeFqFdK0jDWIjQerktbSTLcE+3c+7rZK6r6bd1VVR17kqeTeZKh9s0TxUO2zkzqgc+3jE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpw19CIWAL7o95G4i3cN0QaGxsgBUOivvzUYjq5fv5SOHxd1Xl
	kGngOdswrDnoOgB/nIhTOJ92Wq+JvL92rVfUnkCkODOZYdgv33mp
X-Gm-Gg: ASbGnctTFrGcIre+rXZWdz4FjedHoBj8YG3hhRHcfOTZu0/y0EF0IWF3nwJ7y6eXwrI
	P5zo8iBDnUOpqP8MUWhywq5j/TgRgdhoMe2ev6c8f6PZ2RvjrdxR+N0VmRgI82LlzryfUDqS1BN
	k6PWjeqzIHfGj3catG67I5V1HljkSrPW60Tbf40db/Jvd+94fFgL+pfKYXh/JbxuQeYKMqD2pXn
	aZjdSOwA/h5CAaKIQ8uolyLhl0714eQRZN1nxBMAXinkf6IaQQr9LAn5CUcBSQaBr4mAPYB5GRM
	9xO+qKlQ5O+hCRtMoVoVhQziS71s2zdDqok4mA==
X-Google-Smtp-Source: AGHT+IGdGCDRGDDyj4kiSP19jLYzVJfc616NDZoQJsToF9Nxi5Kz0874ZT1cnsWB7OSOwFnq4yfScg==
X-Received: by 2002:a05:6820:1e01:b0:601:a9e0:6336 with SMTP id 006d021491bc7-601a9e0643fmr6764261eaf.5.1741816156611;
        Wed, 12 Mar 2025 14:49:16 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 006d021491bc7-601a64c6551sm1598801eaf.14.2025.03.12.14.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 14:49:15 -0700 (PDT)
Date: Wed, 12 Mar 2025 16:45:47 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	christian.couder@gmail.com
Subject: Re: [PATCH 0/4] rev-list: introduce NUL-delimited output mode
Message-ID: <pwovu5vmheonndcyq7hmpdzagengq4p5dxsyjshygjcdt45g7g@g7gebobbrygu>
References: <20250310192829.661692-1-jltobler@gmail.com>
 <xmqq34fk7hb7.fsf@gitster.g>
 <nfrfyg56nq7m2bcko4v4tsfdklrafpkybc6uhqgo25swdeebh3@a7aneoylg46u>
 <xmqq1pv32kvp.fsf@gitster.g>
 <Z9E5qXQ2v4lu9hom@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9E5qXQ2v4lu9hom@pks.im>

On 25/03/12 08:37AM, Patrick Steinhardt wrote:
> On Tue, Mar 11, 2025 at 04:44:10PM -0700, Junio C Hamano wrote:
> > Justin Tobler <jltobler@gmail.com> writes:
> > 
> > >>  (4) The traditional "rev-list --missing" output loses the leading
> > >>      "?"; it is replaced by "missing" as the <attr> name, i.e. such
> > >>      a record may look like "<oid> NUL missing=yes NUL..." together
> > >>      with other "<token>=<value> NUL" pairs appended as needed at
> > >>      the end.
> > >
> > > I think this is good. Instead of prefixing missing OIDs with '?', we can
> > > just append another token/value pair `missing=yes`.
> > 
> > And we may want to avoid excessive bloat of the output that is not
> > primarily meant for human consumption, in which case perhaps a
> > common things like "missing" and "path" can be given a shorter
> > token, perhaps like "m=yes" and "p=Makefile"?
> 
> I would prefer to keep longer paths here:
> 
>   - While the output typically shouldn't be seen by a human, the code
>     handling it both on the printing and on the receiving side would.
>     And there it helps the reader quite a bit to get additional context
>     rather than cryptic single-letter abbreviations that one would have
>     to always look up.
> 
>   - By keeping with long names we also avoid "letter squatting" when two
>     attributes of an object start with the same letter.
> 
>   - I doubt that the couple of extra characters is really going to
>     matter much given that most of the time will most likely be spent
>     reading and decompressing the objects from disk anyway.

I also would prefer to keep the longer token names here. I don't think
the extra bytes should be much of a concern and it allows us to avoid
having to conditionally change the printed token name when in the
NUL-delimited mode for missing object metadata.

-Justin
