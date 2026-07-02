Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E184C0427
	for <git@vger.kernel.org>; Thu,  2 Jul 2026 14:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783001281; cv=none; b=GqMI9xwJFjsQMmFNNLuhLMPrvxJAjJLSEgUJarf4uLckCBBOG7gGzMWNtwe5ctfCOTpTNRQc0Te1iLa7lVpA2OrzEujJ/EZ4OvQ/8hMwvxloSZeLvayulRnGA5YPjNtnVKpT5UxukVXOdgRCdTj8uIQTxVImcyS0x9MrzZOt6Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783001281; c=relaxed/simple;
	bh=KKeydK7K+aXODaEd/1zHnXRxXrH7zMQ6VrAT8q3+geM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kA/ZA6fRceEv0XO5SJSw3v5Wso/NFG078daMw5CJ3e8fSXCJteFQePySNYH/uewU3Fc1rYzQNIFMdfcsauSLoWmZzsFvUb+ZoYKrz8h3unvqe44EHAGOz1ZjpWy5+SVDDtioldMjWNx5uwddug3kerXZa7GT699zOB4kNh31Vf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org; spf=pass smtp.mailfrom=wyuan.org; dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b=eT/W+stk; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wyuan.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b="eT/W+stk"
Date: Thu, 2 Jul 2026 22:07:16 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wyuan.org; s=key1;
	t=1783001276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oYdjGK9BJp0DC4FggMsF6KcNkIbvwpc4A0OxEXxfWQU=;
	b=eT/W+stkgil8D1FbZ2VX/ExJtYCSfIVLo99KfaHS1EDHOKPitQAu36wlpu9Vbq+TKgEEx6
	WxXKfUV/vEsIRmrwptPd1C7foxgl0FQr72iQ2FKL2hT0UlCxpIlDmvgKdd6UJP23cqnAZ/
	EMR6I0SuR+6eIwPqdZK0Km7CS2jA3gtbWXVDin6miixk/quX7J5Wk7idCtRuukvgt7ZcIc
	W500SK4IF0zEJGVm20e6GLdL501wTUOhxiVJcB4Wxf49Khu0Lert1JJUabxSrxrE4DkwzD
	FO7HdTX5TIaH/ajMZf7FieMTQSD1ERiia3D2lKLbsOf1BEJshpGfDsH4Ze8Iow==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Weijie Yuan <wy@wyuan.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
	git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git v2.55.0
Message-ID: <akZwlNzG8HFyO5GT@wyuan.org>
References: <xmqqv7b1w9vr.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqv7b1w9vr.fsf@gitster.g>
X-Migadu-Flow: FLOW_OUT

On Mon, Jun 29, 2026 at 10:10:16AM -0700, Junio C Hamano wrote:
> The latest feature release Git v2.55.0 is now available at the
> usual places.  It is comprised of 505 non-merge commits since
> v2.54.0, contributed by 100 people, 33 of which are new faces [*].
> 
> The tarballs are found at:
> 
>     https://www.kernel.org/pub/software/scm/git/
> 
> The following public repositories all have a copy of the 'v2.55.0'
> tag and the 'master' branch that the tag points at:
> 
>   url = https://git.kernel.org/pub/scm/git/git
>   url = https://kernel.googlesource.com/pub/scm/git/git
>   url = git://repo.or.cz/alt-git.git
>   url = https://github.com/gitster/git
> 
> New contributors whose contributions weren't in v2.54.0 are as follows.
> Welcome to the Git development community!
> 
>   Abhinav Gupta, Aliwoto, Arijit Banerjee, Brandon Chinn, Claude
>   Sonnet 4.6, David Lin, Dominik Loidolt, Ethan Dickson, Hugo
>   Osvaldo Barrera, Ivan Baluta, Jean-Christophe Manciot, Jonas
>   Rebmann, Kévin Leprêtre, Koutian Wu, Kristofer Karlsson,
>   Kushal Das, lilydjwg, Luke Martin, Luna Schwalbe, Matheus
>   Afonso Martins Moreira, Matteo Beniamino, Michael Grossfeld,
>   Owen Stephens, Rob McDonald, Saagar Jha, Scott Bauersfeld,
>   Scott L. Burson, Sebastien Tardif, Shardul Natu, Siddh Raman
>   Pant, slonkazoid, Tamir Duberstein, and Weijie Yuan.

Looks like your script counted Claude Sonnet 4.6 as one of the 33 new
contributors. ;-)

Anyway, let´s celebrate Git v2.55.0!

Thanks,
Weijie Yuan
