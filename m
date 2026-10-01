Received: from quail.birch.relay.mailchannels.net (quail.birch.relay.mailchannels.net [23.83.209.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6233CD8D7
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 22:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.209.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790892990; cv=none; b=T2WQM1Sl7MVJ4NeQVKogL/F4+C10ePJ1i7HIaWFi7/t+ey2Jr1juHON0JWuG7BV3w3Dg4OsEd+DHPDujfXf/Kd97jjiyumi1WPtK5lOPUQfzfx8A1S3cqnPdo51Ix8+829wCIdozUBoWfxdm6YsWpXOck+azGtQSW0VbEhELhIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790892990; c=relaxed/simple;
	bh=zqVPhaTxLRD+5Wj/Lkeq1IptmL08KWfxymlp9ZunyQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z3wt3Dv1zWuymlC8KedpaK8VpM7Rsrd923DZ1BE1UR6rBusScJfTXPadt9V8pJvrtyZWm+UPVQ00ktHnvA7lQvMs2u0eve8Gm2HiLOvpQx0Khj+noOBQ414Td0cN26UnTQj8copGNbvx/lYhO7EAlmWKBn1Zp+YO6Rwho7VIoyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com; spf=pass smtp.mailfrom=cryptonector.com; dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b=EYOiNfpt; arc=none smtp.client-ip=23.83.209.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b="EYOiNfpt"
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 79E6F403818;
	Thu, 01 Oct 2026 21:01:04 +0000 (UTC)
Received: from pdx1-sub0-mail-a234.dreamhost.com (100-96-21-185.trex-nlb.outbound.svc.cluster.local [100.96.21.185])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id E7D0E403545;
	Thu, 01 Oct 2026 21:01:03 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|nico@cryptonector.com
X-MailChannels-Auth-Id: dreamhost
X-Oafish-Illustrious: 2e14a1931af00760_1790888464162_285693251
X-MC-Loop-Signature: 1790888464162:285367060
X-MC-Ingress-Time: 1790888464162
Received: from pdx1-sub0-mail-a234.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.21.185 (trex/8.0.2);
	Thu, 01 Oct 2026 21:01:04 +0000
Received: from ubby (unknown [24.28.102.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nico@cryptonector.com)
	by pdx1-sub0-mail-a234.dreamhost.com (Postfix) with ESMTPSA id 4hwkpl31rPz104k;
	Thu,  1 Oct 2026 14:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cryptonector.com;
	s=dreamhost; t=1790888463;
	bh=4mbO7GJ6QXsrEWOoZlsxVTEUP9tBEZABHHtIcjLg1gQ=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=EYOiNfpt54gVQ8NqwN1bFgUOw+JbOmBDedTjqL8r9x2IoVnWm31zXaPhFFt9NYJfg
	 fXXi0lMTAwvqtCH9solpKZP8Kqjj9v0sj9J+0jpk1D9HYiL+QfMFSul6ttMWdLBnoL
	 GCg11TSmdqLc6YlBQBZyslWIebM/dWrp8UPDZlcfiEQlEDlQ7VPwJ0zOizMEgc7jlT
	 uCTgmvHFbmKH2mzfzln0dSyRNQBhkCA6KWQob1dXQRrd+Glbigce0o6VD0oWDACNLB
	 wINeRChbzJKWv46ph/CbMPo5TdFa8q1/iTsTvVr7LpR0faneE02Cii+wKJdSeSH+sM
	 efhLqOl0bVebw==
Date: Thu, 1 Oct 2026 16:01:01 -0500
From: Nico Williams <nico@cryptonector.com>
To: Alejandro Colomar <alx@kernel.org>
Cc: git@vger.kernel.org
Subject: Re: git-rebase-walk
Message-ID: <ar7KDbV2ra7Rtzl6@ubby>
References: <ar5KL4_IKXYbx3Sb@debian>
 <ar6GExDLasWWFajm@ubby>
 <ar6LUeH3AjxbiMgd@debian>
 <ar6a8OkGhmYVoM7E@ubby>
 <ar69ZZ4r9ZxISIHz@debian>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ar69ZZ4r9ZxISIHz@debian>

On Thu, Oct 01, 2026 at 10:29:41PM +0200, Alejandro Colomar wrote:
> Here's the implementation:
> 
> [...]
> 
> It seems to work fine, and the source file uses 52 lines (including
> blank lines).  The behavior seems intuitive, and not too verbose.

Yes, exactly.

> Now, compared to your script, the source length is similar (most of the
> difference is printf calls).  I use more pipes, while you use shell
> features like arrays (I have a very hard time reading shell code that
> does heavy use of shell features).  Other than that, they look
> fundamentally similar (except for the paragraph below).  :)

Indeed.  My script minus unnecessary vertical whitespace and printfs is
very similar in size.

> One thing I'm surprised, though, is that you take two parameters instead
> of just the target branch.  I very much prefer my script in this sense,
> which is like git-rebase(1), which rebases the active branch on top of
> the target commit.  It's up to the caller to make sure that the active
> branch is the right one.

Oh, I know... I... was being paternalistic there.  It's completely
unnecessary, I agree.  I'll remove it.

> > > I'll certainly try your script; thanks!
> > > 
> > > Out of curiosity, did you offer this script to git(1)?
> > 
> > No, though I think I've mentioned it here before.  I'd be happy to
> > submit a patch, but I'd first have to get employer approval for it
> > (which is not a problem -- it will only take time).
> 
> Please!  :)
> 
> Or I could send mine; I don't need to do any paperwork.
> Actually, due to the difference in parameters, I prefer to send mine.

You're there already, so go for it.  You can credit Vitor Dukhovni and
me for this idea (he wrote slow-rebase.sh, and he and I rewrote it
together into bisect-rebase.sh when I just didn't have the patience to
babysit a slow rebase of my PG work), though.. it's fairly obvious, so
much so that there's also the three alternatives mentioned by @pabs3 in
a comment on my gist any or all of which you could credit as well, and
probably more if you look hard enough:

    https://github.com/CTSRD-CHERI/git-mergify-rebase
    https://github.com/mhagger/git-imerge/
    https://github.com/brooksdavis/mergify/

I agree with you: smaller and simpler is better, which is one reason I
prefer bisect-rebase.sh over git-imerge.  But I confess I've not looked
a those three alternatives in much detail because, frankly,
bisect-rebase.sh is so simple and easy to use, and since I [co-]wrote
it, I know it well, so for me it's the best choice.  Since it seems to
be a best choice for someone other than me, it might actually be a good
choice for others.

Nico
-- 
