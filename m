Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A2679DC
	for <git@vger.kernel.org>; Thu,  5 Dec 2024 20:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733429996; cv=none; b=VOkHQRYBvjXoK26PnZ8PvpSU+HkMowNdqyyX1VSNuvmZUfqwhqoyRDlamRrRhBh6NadtKSM/gjgCbntuknmbxbG4nifju/eNZ/DLlsXCUZuzUh2b21nqLlrJbqYR9jackZWbUtjPG4ckOXiga7GJbxddc5xGVoKPfMXFrHd3AMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733429996; c=relaxed/simple;
	bh=6s7W0BSje5BffZ3ofroey0BpiibP8i3Q4oOWZVAROB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OETCQcaqcnpEr6MTcT8dmPXFfbFIvPKMmF3C/EJcPucbE54q5SpX6aw1g7JQ3I1N2R2S9og7wKVDQktiNU7lX8Zu7O+0vSuC4HisiPXw9/nFjeGX/hipYSN/+LoPx7fBejymAw68HTQbAFW6U6oen4KWjKIOlZVS2IWem7Ayfuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=dHukb2vG; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="dHukb2vG"
Received: (qmail 32016 invoked by uid 109); 5 Dec 2024 20:19:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=6s7W0BSje5BffZ3ofroey0BpiibP8i3Q4oOWZVAROB8=; b=dHukb2vGEth+e6z5PmS7XbgUVv1DLfRNtt1QcCTs9SwmKinGE6lDHpcnQkIB3SbaNubaqla+vqLs4VuIn8smIeYnGhZsUgwPNRL+nprHxO/muAj8N0IRSsdLFrLpjK7eLsObb7dE0o3YDxtkplHe6tNtlXCGvcCRC2tGhIEZHQrwGcEz5krVJ7Uhy+ZZVJZcq6Et68l4JcGe1P1jRekfCQDmdn/CeaCDQ63geFBmq3uz7+49cCSMWMaxoe8DYQn/hlJqOZXPITHryjdYSSLK+Xq03ZsbrrP+y/4OHcFVDP1xPxRRCfdsH8kLE3ElK5IVYycU0D/SAj4dKg3AIabg5Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 05 Dec 2024 20:19:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9576 invoked by uid 111); 5 Dec 2024 20:19:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 05 Dec 2024 15:19:52 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 5 Dec 2024 15:19:52 -0500
From: Jeff King <peff@peff.net>
To: A bughunter <A_bughunter@proton.me>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [help] git status doesn't seem to work.
Message-ID: <20241205201952.GB2635755@coredump.intra.peff.net>
References: <n8KYxrArhb3MywPvDHVmEz0dka8QYYWikLDZE_aboUX9GBgF2X9uomuxtrPA6VmS33TxXyltJB4xqjALIuprVvE12prKd_ZW4MYM9kC4Qds=@proton.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <n8KYxrArhb3MywPvDHVmEz0dka8QYYWikLDZE_aboUX9GBgF2X9uomuxtrPA6VmS33TxXyltJB4xqjALIuprVvE12prKd_ZW4MYM9kC4Qds=@proton.me>

On Thu, Dec 05, 2024 at 07:52:37PM +0000, A bughunter wrote:

> [help] git status doesn't seem to work. See how a pull caused updates after status showed "up to date"
> 
> ```
> ~/Peeranoia_Framework $ git status
> On branch main
> Your branch is up to date with 'origin/main'.

This is comparing your branch with the local tracking branch we have,
refs/remotes/origin/main. It doesn't touch the network, and that
tracking branch is essentially a cache of the last value we fetched.

> ~/Peeranoia_Framework $ git pull
> Enter passphrase for key '/data/data/com.termux/files/home/.ssh/id_ed25519':
> remote: Enumerating objects: 17, done.
> remote: Counting objects: 100% (17/17), done.
> remote: Compressing objects: 100% (15/15), done.
> remote: Total 15 (delta 4), reused 0 (delta 0), pack-reused 0 (from 0)
> Unpacking objects: 100% (15/15), 6.41 KiB | 312.00 KiB/s, done.
> From github.com:freedom-foundation"up to date"/Peeranoia_Framework
>    03edf66..4cf4f51  main       -> origin/main
> Updating 03edf66..4cf4f51
> Fast-forward
>  README.md | 24 +++++++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)

This pull is doing a fetch under the hood (since pull is essentially
"fetch + merge"). It updates the tracking branch origin/main, at which
point a "git status" would show that your local branch is not up to
date. But since it then immediately merges the result, you find that
afterwards:

> ~/Peeranoia_Framework $ git status
> On branch main
> Your branch is up to date with 'origin/main'.

...your branch is now up to date.

This is all working as expected. If you want a more up-to-date view of
"origin/master" when you run your "git status", try "git fetch" to hit
the network first.

You might also find more information in:

  https://git-scm.com/book/en/v2/Git-Branching-Remote-Branches

-Peff
