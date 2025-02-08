Received: from mail.inka.de (quechua.inka.de [193.197.184.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB13C243959
	for <git@vger.kernel.org>; Sat,  8 Feb 2025 21:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.197.184.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739049010; cv=none; b=Sl7kJ1ZSywrhZOqHQWz2jw1NAukPkOgRPJzXe0KkGoENIFljBuODhE7C43jD6RQPEvtY5G4LOY08kAEH+GAlL8zOncm/6CNo2Xc1Le6cug1JMaLlX64ygFWr/0gVerdABDITF/i6myFbB8Fu1nVXlVpFlSBBr/E1G/1M2vOMpqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739049010; c=relaxed/simple;
	bh=L30nb+zac2WWI5do2yZcRtKjs7aqPOceGpeaC/NGFQg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pNsb4n6eg0uV9IWWp2lMCsq1Q/0FPx0rVv6rs+7ORil/J2uYhWhdcoeJvOySsYxgBA9zNXB7X3UKOcPkeCGcDrw1wpbHo4d4/vHfgo4cNpv5SzfNgStqnvU5dzKdsWFgtgWsTAGwia7/BSIONFEalk5J7m1nDbbd/KFZ5xGQvPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=raven.inka.de; spf=pass smtp.mailfrom=raven.inka.de; arc=none smtp.client-ip=193.197.184.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=raven.inka.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raven.inka.de
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1tgs5U-0053Fv-JM; Sat, 08 Feb 2025 22:10:04 +0100
Received: by raven.inka.de (Postfix, from userid 1000)
	id 7E28060117; Sat,  8 Feb 2025 22:08:24 +0100 (CET)
Date: Sat, 8 Feb 2025 22:08:24 +0100
From: Josef Wolf <jw@raven.inka.de>
To: git@vger.kernel.org
Subject: Re: renormalize histroy with smudge/clean-filter
Message-ID: <20250208210824.GI30202@raven.inka.de>
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
References: <CABPp-BFZ3oyKiryKMPph+nfokC=sFa7wn1wdas863273bzy7pA@mail.gmail.com>
 <20250206134006.GC30202@raven.inka.de>
 <20250206200418.GD30202@raven.inka.de>
 <CAPx1Gvc2piLT=p+dvzcJPTMDQAAjQfz__O4KiRWs-fOMg8dpTw@mail.gmail.com>
 <20250207104510.GE30202@raven.inka.de>
 <CAPx1GvcyaZqYK+SvgtfsajqtkMty1jOcVAtwfmam-LpOjyd0jw@mail.gmail.com>
 <CABPp-BFnx2m75jsa3_kTPet97HY+xwb_6JmPiKM5+OARPy=mGA@mail.gmail.com>
 <20250207203248.GG30202@raven.inka.de>
 <CABPp-BFGUa_DRBe1WLVfCOKh53+F15KxW_c_OZAMwZCxuAQCiw@mail.gmail.com>
 <ba65ce17-8768-4d60-aec6-badd12930b81@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba65ce17-8768-4d60-aec6-badd12930b81@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Sat, Feb 08, 2025 at 11:14:57AM +0000, Phillip Wood wrote:
> The modification is to add "--attr-source=$(git rev-parse HEAD)"

Uh!

My expectation would have been that this is the default?

Why on earth would one want a changing filter setting during a rebase?
Can anybody outline a use-case for changing filter during operaion?

If I define a filter, I'd rather want it to be in effect on every commit of
every branch.

-- 
Josef Wolf
jw@raven.inka.de
