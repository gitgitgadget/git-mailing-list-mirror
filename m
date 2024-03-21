Received: from taslin.fdn.fr (taslin.fdn.fr [80.67.169.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35187C6DF
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 13:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.67.169.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711026435; cv=none; b=gutBlebtoO1qW5XRUjifFTXvF7sWpolLF4SJSXgR+LlbkIKxqbVyx8LIu9z73PlJ3ocqW81xOFJnj7MTHRA8GkkpoaWkayJNZsSEsIq+MaY5ugxIX0UOPOat3rAF14lCidm9d7BTsOaSNLCGhopJXnvkWGUqtjfti+URwn56YbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711026435; c=relaxed/simple;
	bh=fnrAfqyMYsysguqBH638c6aQFl7u2Bq9rzEIpnoTEPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aMy8t9gXImT7vwn/WU8YQOBb8l0HnkwMhk4fqOJOUzQ+0pmOz2rfo4vcww97j8P7fuUSF9wFW/gEBgU3sm2ma7jl3x+20BzWjwiyRhLL0tRnXrc+d/U90sS5l4C+jPjhWyQIy/r5AuFPk+i2JNUZlzRZP3E5KcQ+LfyYDxM6mJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name; spf=pass smtp.mailfrom=max.gautier.name; dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b=nwtWCRp4; arc=none smtp.client-ip=80.67.169.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=max.gautier.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b="nwtWCRp4"
Received: from localhost (unknown [IPv6:2001:910:10ee:0:a24:f690:de50:c41e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by taslin.fdn.fr (Postfix) with ESMTPSA id 7401760320;
	Thu, 21 Mar 2024 14:07:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=max.gautier.name;
	s=fdn; t=1711026423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EmYffFxMD67YIHIMcmSP1BNGhZemAX7mo6tGQIkxe20=;
	b=nwtWCRp4V2YIak4qclLrqVB/4Eg44J0extMk3foqQQh5V10a6JdFIRGUhoEoUJkgtvcL6J
	RhP/Rbk5rBuE40SjHgrEBjimAcVVuuNT8uACbIe3zE4jU/qN4C9BO0KipHGEiBFZpWPkyp
	IjSddGGsCbWJzxEGCcVg3jvKjy/ZEa0e7enLG7c1k3pNX8t+1GhfdYIupPGhauTtIe6Vym
	Qvlg4FHarSoXj49e3HW0+j6Yl2u4QjfijnMtJ41eHIJZC4L+2ysIlL8fUAcl9X0ko0aj5M
	kj4daIymPrpv5n5IglW+/UkQHtEzlTpeax+Evh83wYmMeHWzjUklRtwMbC57KA==
Date: Thu, 21 Mar 2024 14:07:02 +0100
From: Max Gautier <mg@max.gautier.name>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, =?iso-8859-1?B?TOluYe9j?= Huard <lenaic@lhuard.fr>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [RFC PATCH 1/5] maintenance: package systemd units
Message-ID: <Zfww9jI2em6ZY4SL@framework>
References: <20240318153257.27451-1-mg@max.gautier.name>
 <20240318153257.27451-2-mg@max.gautier.name>
 <ZfwqCv889UdI0mU6@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfwqCv889UdI0mU6@tanuki>

On Thu, Mar 21, 2024 at 01:37:30PM +0100, Patrick Steinhardt wrote:
> On Mon, Mar 18, 2024 at 04:31:15PM +0100, Max Gautier wrote:
> 
> It would be great to document _why_ we want to package the systemd units
> alongside with Git.
> 

Hum, I wrote that in the cover, but you're right, it should be in the
commit itself.
Ack.

> > ...
> > diff --git a/systemd/user/git-maintenance@.service b/systemd/user/git-maintenance@.service
> > new file mode 100644
> > index 0000000000..87ac0c86e6
> > --- /dev/null
> > +++ b/systemd/user/git-maintenance@.service
> > @@ -0,0 +1,16 @@
> > +[Unit]
> > +Description=Optimize Git repositories data
> > +
> > +[Service]
> > +Type=oneshot
> > +ExecStart=git for-each-repo --config=maintenance.repo \
> > +          maintenance run --schedule=%i
> > +LockPersonality=yes
> > +MemoryDenyWriteExecute=yes
> > +NoNewPrivileges=yes
> > +RestrictAddressFamilies=AF_UNIX AF_INET AF_INET6 AF_VSOCK
> > +RestrictNamespaces=yes
> > +RestrictRealtime=yes
> > +RestrictSUIDSGID=yes
> > +SystemCallArchitectures=native
> > +SystemCallFilter=@system-service
> 
> Curious, but how did you arrive at these particular restrictions for the
> unit? Might be something to explain in the commit message, as well.
> 
> Patrick

I copied the unit file which is defined in strings in builtin/gc.c,
which I delete in patch 3.
Should the moving be inside one commit, in order to explicit the fact
that it's only moving things around ?

-- 
Max Gautier
