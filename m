Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C23234CEB
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 20:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737060671; cv=none; b=oXPgAm9+S6/ftnKogTgWkEF1OmonUV1utU8bVhcOl8LktKTndbhFaahithdHiutoSlBCF8N55K9ZIpJG0oOuk/YzqJemH3ORacL2jySS6K9FAhQjS7eFLzSiEOsCZocIywmjIDVMCsLYh5aW8YmNGUZ9/co3mbvIagj+kuydc3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737060671; c=relaxed/simple;
	bh=2nfPaGIjMwX+yXnkMCf71XlrAEb4mTEVFZXUyCHtAkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lKLGJUgUnss8KWlt56AVy0USQ7vV6EZL1jKpi3foky4woa8Z9fzaqdni0EdcrYcfbRZj9GmQFX6AhlCI6IzJCOkzv7K3E8MBoc1HklCSxaoBI9Lw4ySu/8wycQys0Mh/AM1eRmR2PbdPXMpNlt9nWSuRLEl2TM8gqHA3vvEvkEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0Kwq71FW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0Kwq71FW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E762C4CED6;
	Thu, 16 Jan 2025 20:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737060671;
	bh=2nfPaGIjMwX+yXnkMCf71XlrAEb4mTEVFZXUyCHtAkQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0Kwq71FWvnVu3tSFlR6WbV7ZcYNJ89NXWt50wXB983QCRS22dYqm7Tzc+AC/f9HX+
	 HKRMgxDwdQ9QldQ61C8N2Omwy8UNj6yGFgOuQpAenOGGh3AGLntHeyMjdCLhe73dUC
	 V0SsSU7ddlSes9sMg7JEVuoOqXJD9uJEfkEKk4tE=
Date: Thu, 16 Jan 2025 15:51:10 -0500
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 00/10] compat/zlib: allow use of zlib-ng as backend
Message-ID: <20250116-chirpy-realistic-horse-fad0db@lemur>
References: <20250110-b4-pks-compat-drop-uncompress2-v1-0-965d0022a74d@pks.im>
 <20250114-b4-pks-compat-drop-uncompress2-v2-0-614a2158e34e@pks.im>
 <xmqqjzax2nqw.fsf@gitster.g>
 <xmqqa5bt2jc8.fsf@gitster.g>
 <Z4dLeyF8N8PhYAZq@pks.im>
 <20250115-eccentric-zebra-of-hail-c22ba0@lemur>
 <Z4fhd9UpI76vb6oB@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z4fhd9UpI76vb6oB@pks.im>

On Wed, Jan 15, 2025 at 05:25:27PM +0100, Patrick Steinhardt wrote:
> > I'm not sure why --full-index was added there -- I don't think it's needed for
> > --binary? Please feel free to send a fix for that.
> 
> No, it shouldn't be needed. `--binary` implies `--full-index` for that
> particular binary diff anyway. I'll send a patch.

I've applied it to master and stable-0.14.y, thanks! I should have version
0.14.3 out in the near future with this fix.

-K
