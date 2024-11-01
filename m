Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C2D1537C3
	for <git@vger.kernel.org>; Fri,  1 Nov 2024 14:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730471586; cv=none; b=hMa0Hh3q4cvfl1/qJDL0AwDZ1XrRQITHSVGSSs+IFhu8UPW5t/Mzdzei/6LcTpWxXqfXFMBNTOKIFcDiOkO0NlfP0rjUjzrkh0ljjnW5JQyK4d2S9+8H2EpWCb5w5mQUusBXd3K17syiLGp6nWvNb2HIcWkVRRCqM9xj5cF5660=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730471586; c=relaxed/simple;
	bh=vcR//FSrA3YlDsl/PwK7Ym8DFFbKOug+yB/qc/KFo9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jf0jT0+OJ07mHIUKSb8b0+yh0HOjrCqs9x9K2rxMMq8Ll2F4p+/GL7jpSBTjIX460rLga0bCeuZyGMe9xYk+qaoKT7d1orZ4wu3opMPFx92o7P+Rk6vQzVyW7QqjqB3F5vBlarPnXxj39EDRvBHHccUy6h4SOZyIDSY+SLk3VnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=yafhWiyt; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="yafhWiyt"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6ea656c60a4so10547437b3.3
        for <git@vger.kernel.org>; Fri, 01 Nov 2024 07:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1730471583; x=1731076383; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vcR//FSrA3YlDsl/PwK7Ym8DFFbKOug+yB/qc/KFo9M=;
        b=yafhWiytHRfhj4BfkDQqz6R59rQoxSCNfCUjiQvxVAO8nl0BjDsgJ/ltnfljJJyrCE
         fymUZgdDgfvttXqHIN1kx0SLG2LccBlOuOGcbnLzZVULIDctUdNpUHofqIZ1Ca7J4AAI
         o2R5UsirAZfBDW42ScOaw8nrVX9Kv9SzKKhgj87pIbYdvfixR9MYAo3A89hLtboEvMA+
         u/1JVUmdjXodX8HKOK0t7TSimhUsB8Km6H5jV8ZYPqhs7KswsM0SbaBKbzRReekIuYuc
         8JUWrbjc1lLqZY7aYz7XJYOzg4lAycuEfvKIEgepMt20cJrNG/DVbjUeOuOmLKufL/0I
         dFrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730471583; x=1731076383;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vcR//FSrA3YlDsl/PwK7Ym8DFFbKOug+yB/qc/KFo9M=;
        b=pi04qiNTsBAhOcTJAtz27LkiX/SPFqImn2Kc1EiNoJGJ8QMkh5rrC1+wOSgG4WMXk5
         1wmm7jFBhBUbHeTxu32DgTmOrYFd3XA2ysz9Hsz9Nr9yNpn2NgmoUKfkVwQE5r5Zuqzu
         zzxjITIDSvP+bm+ejWcVfuFytyoNbEnaLATLGPE92mcfI4UWC0vfdSh3GcHgk81/rWnn
         Ddl08HCHBVCyb567Ueu5lcjgUdw39YEIwN7QKYwhTYodkbBrAI0gAg14EOEdGFY9Fd5W
         xSi+uHh0y5GaVlkxB7UhlU6V4uAZWaMmDXPGw1TEI66Uw5+dt8i7c2gYkVOCerLzpRw9
         tH4w==
X-Gm-Message-State: AOJu0YyEUGYN9Ac/fjpSVu6+4kcFFK2hA5RacIcjYRJeiIqyQSepnJ7O
	j/XorNh3c3IAIV2q5A5zX4Akl0i+4SSqqIyx1v3LBE9v2UaFaCO0GJ6i07ez2057xtguLHDHJtP
	46T4=
X-Google-Smtp-Source: AGHT+IEZANvPXkrTgIE4U1opoBXDAmCDgtfho6RUtvQLZan8+pJFxSUwzhI1/Bgb5wgTtVUHTVRmGQ==
X-Received: by 2002:a05:690c:6610:b0:6e5:cb46:4641 with SMTP id 00721157ae682-6ea3b8961efmr131348167b3.13.1730471582570;
        Fri, 01 Nov 2024 07:33:02 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ea765dc5aasm923817b3.140.2024.11.01.07.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 07:33:02 -0700 (PDT)
Date: Fri, 1 Nov 2024 10:33:00 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jonathan Tan <jonathantanmy@google.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] fetch-pack: warn if in commit graph but not obj db
Message-ID: <ZyTmnDHGdblD3/FU@nand.local>
References: <ZyPvqPK1s5lUtH+N@nand.local>
 <20241031214319.550776-1-jonathantanmy@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241031214319.550776-1-jonathantanmy@google.com>

On Thu, Oct 31, 2024 at 02:43:19PM -0700, Jonathan Tan wrote:
> > Another thought about this whole thing is that we essentially have a
> > code path that says: "I found this object from the commit-graph, but
> > don't know if I actually have it on disk, so mark it to be checked later
> > via has_object()".
> >
> > I wonder if it would be more straightforward to replace the call to
> > lookup_commit_in_graph() with a direct call to has_object() in the
> > deref_without_lazy_fetch() function, which I think would both (a)
> > eliminate the need for a new flag bit to be allocated, and (b) prevent
> > looking up the object twice.
> >
> > Thoughts?
>
> This would undo the optimization in 62b5a35a33 (fetch-pack: optimize
> loading of refs via commit graph, 2021-09-01), and also would not work
> without changes to the fetch negotiation code - I tried to describe it
> in the commit message, perhaps not very clearly, but the issue is that
> even if we emit "want X", the fetch negotiation code would emit "have
> X" (the X is the same in both), and at least for our JGit server at
> $DAYJOB, the combination of "want X" and "have X" results in the server
> sending an empty packfile (reasonable behavior, I think). (And I don't
> think the changes to the fetch negotiation code are worth it.)

Thanks for the clarifications above. What I was trying to poke at here
was... doesn't the change as presented undo that optimization, just in a
different way?

In 62b5a35a33 we taught deref_without_lazy_fetch() to lookup commits
through the commit-graph. But in this patch, we now call has_object()
on top of that existing check. Am I missing something obvious?

Thanks,
Taylor
