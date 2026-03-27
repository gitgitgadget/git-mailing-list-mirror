Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8559015A86D
	for <git@vger.kernel.org>; Fri, 27 Mar 2026 00:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774570867; cv=none; b=aDB+UK38M6kpMNIrX6JfEFSGLYgi75iFkkSOVp2E8WbJKWSZe/dIP4wUr5Hyi3hJXuY/zEsNWhKgmRx80zEQ9CwKNPw4pKJaQFQLwJnstBXpa+pSuaC8iGu9tE2cIrBGE2nKdW8Q86pfcvCtsh/Hw+wSe8pp5y8S3e/Ftwr4Deo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774570867; c=relaxed/simple;
	bh=RSwaXBPIrB78RFbTOpIxf9Xmf18wTn6xMPCgaLaPJF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UuiZ3P+WAVkjasePdFikF4taY8ASb2QDPtDhJJOacYBWk6eZQFmygTT4Z2ePTf6rZbc1PAIh+Iz5USZ+aOhGi5Ly324S3PSNK2D+6wovxlRy4NJOAKDwBn/tNH9+DAnZTzX4hcAHzl5ykt111h/n4xy6CjrzdUKpjkaV4x2Q7IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=YS4qWuMI; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="YS4qWuMI"
Date: Fri, 27 Mar 2026 01:20:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1774570860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a2TbKp0r88H7Qldmgtc+3p7B5g+k77CEYHePeP1aGUk=;
	b=YS4qWuMIRgbfPFoiFAhNjHnKqu630KGIoAu/Goj+Acv7jrs7RIe1TXqxzTRCqXCjInzd3V
	QbXIioSWPUvqya8sXHmhs4RolTvg4Wvj/c/EuImQz2S0UuijjEeHwgMBfH0INhXNZFxBiO
	bQGws7FE8QHoxy/dVNjTz0Q957D4SCxNC3QAcsNITkgrwx1ZCK9fEfeBsBYwPLT530ipus
	D8pM+UyJiYwu6V5bc5iCe0a1PNShGiqtwzXXx+PBn14tro2yPyf4QpauHDl4//iD8cNz9x
	N0HAS6lbNffXWGtO83/SXgQUws+xfgdOWxsWYEy1TRRpRK6FzgmbVJVZUJGwYQ==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
From: Mirko Faina <mroik@delayed.space>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Mirko Faina <mroik@delayed.space>
Subject: Re: [PATCH v2] docs: fix --commit-list-format related entries
Message-ID: <acXM3e23Us-mJxeE@exploit>
References: <20260326185541.17523-1-mroik@delayed.space>
 <20260326200643.20251-1-mroik@delayed.space>
 <xmqqse9mnwv8.fsf@gitster.g>
 <acWbpJTRusOv6bPk@exploit>
 <xmqqo6kanvpn.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo6kanvpn.fsf@gitster.g>
X-Spamd-Bar: --

On Thu, Mar 26, 2026 at 02:10:12PM -0700, Junio C Hamano wrote:
> Mirko Faina <mroik@delayed.space> writes:
> 
> > On Thu, Mar 26, 2026 at 01:45:15PM -0700, Junio C Hamano wrote:
> >> Being verbose is usually a good way to discourage readers from
> >> reading.
> > ...
> >>     The use of this command line option implies `--cover-letter`,
> >>     unless explicitly countermanded with `--no-cover-letter`.
> >
> > this part in particular is no different than the original text:
> >
> >     This option implies the use of `--cover-letter` unless
> >     `--no-cover-letter` is given.
> >
> > If we want to emphasize that the configuration variable doesn't imply
> > --cover-letter, we have to add the note on `format.commitListFormat`.
> 
> I do not think so.  
> 
> If we mention a variable, the readers would wonder if the variable
> has effects.  You can explicitly say that that it does *not* have
> effect, but we are often better of not mentioning what is not
> relevant.

So the issue with the original is simply the fact that it wasn't
explicitly said from the command line? If that's the case then the v2
should be fine but without the note about the configuration variable,
i.e. "This option given from the command-line implies the use of
`--cover-letter` unless `--no-cover-letter` is given."

Thank you
