Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CDE1862
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 19:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782759851; cv=none; b=DXAk0uycEaxj5Eu9oVHojWELSLT6CjIZmRn9X/DQXq65GZrpK/W/oLSVgEz3iMi/nhtQ0NihoUh0CtjsSHxeNP7F/LZBjCZFwFMSQk8mX42TkKKIbHSWjPsk63BVfwQy3AcN9ACrGzGVgRgvW4CZ0kW+LebwdFDhbjIQ8GlELVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782759851; c=relaxed/simple;
	bh=jEGEiRz4fWdR4+Nf1SKt5ledQ6ViZPZLX06mhBhuC7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y0e17QLK4ifvCIJRHJAnDXTj3glnUA9DhxQq5BsqdR007b09GnOFYmcXWcPagf4fhxgGzyjEggdq77A5PrAEuK6iQACoBIt+yaIm21IzJSGmkj2sG3G3iqn5CV9Ff6nuJiV7YE4Yt8fsqxQYFyMgTkGBIEoK6UeCVkeNOLWixTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dr4h/5ha; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dr4h/5ha"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6a0b1edbe32so3068900eaf.1
        for <git@vger.kernel.org>; Mon, 29 Jun 2026 12:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782759849; x=1783364649; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TQpcyr4NvEmSXk6QzjA8pXqKzR7aJL3RujKh7PxdJkA=;
        b=dr4h/5hac+rp8XMlh7rsnDyi1bCc/s58blyiRK45nekvpGDaguWzc9n17E8GPZhWWE
         /RlmtpnubfH0x6u2auvQXkBlEwgVLjkzmJkgXZgegS1yb9Lf0MfZvuAnpR8qLQjcUR0+
         V1/E3eqedSsA9BxjKXRN9pyw9QsT5PGnZORxBCpYdYuCZUyRmM0n1h6vY9UmvyZxBBUD
         DV+tSNDlIU2eKNg1T+iSKR+oSdh3/O8PTLhRvqmIbTDipXHlh3elTOI17IHlhNehLqyu
         e9NgzfbDxtKJXtyDQqieeY7A7w89S6SxZiqRUM/mXe3HohyPWkHIjBKbz8mUkWnccWCl
         fM7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782759849; x=1783364649;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TQpcyr4NvEmSXk6QzjA8pXqKzR7aJL3RujKh7PxdJkA=;
        b=FPzuY5bQ0Sw6CW7SLOQRaIXeiLhBuONjp41ARumP4Y+YtUOePT+VpkimNq+T7q/bQi
         12LknUHH6FY+ObJL1nNPcrYEmIyzg9Z6vCCUCO+/NNQIEME83bBx0oy89PCAdInGxiJD
         DAmg53SAH0TcfCwrIckOqRAHkFuLxFGouVukl/0ifkUQDKXTtIpHPNxuTKfuN6OxCpkZ
         BhvYWu3UXDU4vFlmPabrZsaagHnbwlMJK8biYTeTuSUm+o4pktRyTvjfXpLnbpkHw/JU
         rw0U6QCQPjrTj05Fsoj+x1D8Ux5wpas3/1c4zZXetqxnrU39ZEc/I1EtzJF76vWe7SGI
         BBHg==
X-Gm-Message-State: AOJu0YyR51ayrCA4AhfVGWwQq20ruyKAwY6U7jjtMYNjrwl9UYfviFpk
	osoMda/ZkijI35cbZVdadj5BXflWigzQY4iviKlYx7tJ7aGkwoGRNURgTXczNQ==
X-Gm-Gg: AfdE7cl1qY4bfehPoj9KcrGFrMBOpF9AMFkCeLRTiADsw5y/n066mCdeU0tfITIv7kY
	IcQCvE5ZvxuEx3Rrq9LQojbqH+7ZRjtDOOOQR2QA6d3NR9kCI6hqxPI7p4X5pzVB0rnCaEsZWxv
	/pf6oWvPXqvC1mTstnFS7IDkVAPWAMnsLsV0BoRZ+36N2aLcltei/mh7WpcsGmlZ5PgaJ7rmlu1
	qxWjcxE9xiRGvWx6R8jtWFaWpNO4Eai6Y6ECtOG+ZZHw4Y3dewOZOWIWPcp4RQi8CPUonl+nQO+
	9BHZ1yiogx9HGEzqf8SNC8UQ4ScFUxkdoq1DvN2rWYmcKYWH45G0EOCBXxyFngadhvp5Y6puMTV
	XCTgJVa3+ObRvibFKp5/PKJoKSuX27wSBXUkhvdGfEuvnOVZ+otDR67qFOB/GyeYO4KUrC/BQ+O
	A6/npkiA==
X-Received: by 2002:a05:6820:1606:b0:69b:3fff:1407 with SMTP id 006d021491bc7-6a18923b246mr636155eaf.54.1782759849007;
        Mon, 29 Jun 2026 12:04:09 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-448db93e300sm499401fac.2.2026.06.29.12.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 12:04:08 -0700 (PDT)
Date: Mon, 29 Jun 2026 14:04:08 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/6] object-file: propagate files transaction errors
Message-ID: <akLBFaTfBEq8vHUr@denethor>
References: <20260624041920.2601961-1-jltobler@gmail.com>
 <20260624041920.2601961-3-jltobler@gmail.com>
 <aju-7Z-ecJG_ORow@pks.im>
 <akK1roQJknYstX0u@denethor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akK1roQJknYstX0u@denethor>

On 26/06/29 01:58PM, Justin Tobler wrote:
> On 26/06/24 01:26PM, Patrick Steinhardt wrote:
> > On Tue, Jun 23, 2026 at 11:19:16PM -0500, Justin Tobler wrote:
> > > @@ -511,11 +511,15 @@ static void odb_transaction_files_prepare(struct odb_transaction *base)
> > >  	 * added at the time they call odb_transaction_files_begin.
> > >  	 */
> > >  	if (!transaction || transaction->objdir)
> > > -		return;
> > > +		return 0;
> > >  
> > >  	transaction->objdir = tmp_objdir_create(base->source->odb->repo, "bulk-fsync");
> > > -	if (transaction->objdir)
> > > -		tmp_objdir_replace_primary_odb(transaction->objdir, 0);
> > > +	if (!transaction->objdir)
> > > +		return -1;
> > 
> > Huh. So previously we just didn't handle this error at all and just
> > continued to tag along? Did that result in anything sensible or was this
> > just YOLOing it?
> 
> Good question. Previously if there was an error, we wouldn't end up
> creating any tmpdir and would instead continue to use the primary ODB to
> write objects in. This change would make it a hard error if we fail to
> create the temp dir. This matches the behavior that git-receive-pack(1)
> expects, but I didn't consider that the existing callers could
> transparently handle there being no temp dir.
> 
> I suspect we may want existing ODB transaction users to continue being
> resilient in the same manner. In the next version, I'll maintain the
> same behavior.

I think I got a bit ahead of myself. The existing callers of
odb_transaction_files_prepare() still continue to ignore this error. So
the behavior already does remain the same here.

-Justin
