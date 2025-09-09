Received: from disco.pogo.org.uk (disco.pogo.org.uk [93.93.128.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410F0257ACF
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 21:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.128.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757452951; cv=none; b=rGgI0lPnZS9vRDLmkLM8fSry3dnskj+AcoaYAuYOX8HS87u1JLNvj/6FjUVfb3atYcKYLzCL25UeFNFABHFSE3JLY2Ijhh3M9xbjSV42NOk8eJbbjYEQP5YjdnZu80I8+L4v1dPBm0X9KXFn9tsgM0EjXhTdnzr6QksnDbZBL2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757452951; c=relaxed/simple;
	bh=SU0Odvnm3LfoZqrFclCWN4Z5hOe6ahAUIezBsKd+2Iw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=qGqriqjT+BT2fKfJlP9tzCP6XfFavjtrsRW9LclPBfFpQcrR8KXMvG2gczsYdBimL9O+u6MopEnuJ8UQmkWR1a2f5/R3ikF1XTcBSRgQdVQnLLxP0Z/G0D2FwSSPl9aYsAY8n9fWgPc6Oo9ahYc4X9eYXbj/l2rT0iOZmGf7V/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xwax.org; spf=pass smtp.mailfrom=xwax.org; dkim=pass (1024-bit key) header.d=xwax.org header.i=@xwax.org header.b=Z1vOjT6n; arc=none smtp.client-ip=93.93.128.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xwax.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xwax.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xwax.org header.i=@xwax.org header.b="Z1vOjT6n"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=xwax.org;
	s=swing; h=Content-Type:MIME-Version:References:Message-ID:In-Reply-To:
	Subject:cc:To:From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description; bh=HeSk30z3Gd/tywi84p8LUTu8iLY4omctzzW38Z+GAzs=; b=Z1vOj
	T6nrLIEODRWvdOE8YRYHK3ms9JTB6WNnabKyvkzeXVlpH5hPVh7JOjFp7nESkO4ryhkETTkV5Qu41
	42/dSgIU6xgTZU1Hdscg9ktp2or3MOOAgbDwUGHmPhsxs+1sizq6dvKxMOeZ0O6LPUDQlpl2Pm2ip
	XQIujPHQYxZA=;
Received: from cpc93786-hari17-2-0-cust786.20-2.cable.virginm.net ([82.36.99.19] helo=stax)
	by disco.pogo.org.uk with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2 (FreeBSD))
	(envelope-from <mark@xwax.org>)
	id 1uw5LH-00000000O3p-25yF;
	Tue, 09 Sep 2025 21:53:31 +0100
Received: from localhost (stax.localdomain [local])
	by stax.localdomain (OpenSMTPD) with ESMTPA id 96610fce;
	Tue, 9 Sep 2025 20:53:30 +0000 (UTC)
Date: Tue, 9 Sep 2025 21:53:30 +0100 (BST)
From: Mark Hills <mark@xwax.org>
To: Johannes Sixt <j6t@kdbg.org>
cc: git@vger.kernel.org
Subject: Removal of classic Tk widgets (was Re: gitk bug: Disabling "Themed
 widgets" breaks preferences dialogue)
In-Reply-To: <2005fae0-5991-41e3-a1f2-4625086de7b3@kdbg.org>
Message-ID: <e7cbfbf5-2a50-e1a9-a3f3-08cf5a4e5b8e@xwax.org>
References: <075a1389-c5d6-18f4-ed19-13b0041dbbd0@xwax.org> <2005fae0-5991-41e3-a1f2-4625086de7b3@kdbg.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

On Thu, 28 Aug 2025, Johannes Sixt wrote:

> Am 28.08.25 um 16:02 schrieb Mark Hills:
> > I use Alpine Linux 3.22 (latest).
> > 
> > Recently gitk's preferences window refuses to open.
> > 
> > This seems to be a direct result of switching off the "Themed widgets" 
> > setting, which is my preferred choice.
> > 
> > Error message:
> > 
> > invalid command name "::combobox"
> > invalid command name "::combobox"
> >     while executing
> > "${NS}::combobox $page.wrapcomment -values {none char word} -state 
> > readonly  -textvariable wrapcomment"
> >     (procedure "prefspage_general" line 41)

> This bug was introduced by 904b36b815ff, which is in Git 2.48.0 and was
> fixed by daa364cfb7a1, available since Git 2.50.0.

Yes that commit does indeed fix the bug.

But then starting with commit cb9fa4d9ecd97 only a month later (v2.51.0) 
systematically strips out all support for this preference.

That seems a bit over-enthusiastic to me, considering how at least one 
user proactively submitted a patch when a bug got introduced.

The justification here seems to be that it's not the default; and 
therefore there's less code to maintain if it's removed -- however this 
would justify the removal of most features in most software...

commit cb9fa4d9ecd97b9e7e9bbd449c5106cad64215e8
Author: Mark Levedahl <mdl123@verizon.net>
Date:   Sun Jun 8 08:16:34 2025 -0400

    gitk: always use themed Tk (ttk)

    gitk added the option to used themed Tk (ttk) in 0cc08ff7dd ("gitk: Add
    a user preference to enable/disable use of themed widgets", 2009-09-05).
    Using ttk had to be optional as Tk 8.4, then in common use, does not
    have ttk. ttk is the default when available, so the ttk code paths are
    by now very well tested. gitk also has code paths for the older default
    widgets, increasing the maintenance burden. Let's make ttk non-optional
    to reduce code complexity in later commits.

    Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>

-- 
Mark
