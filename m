Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89B329A2
	for <git@vger.kernel.org>; Fri, 27 Mar 2026 00:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774569900; cv=none; b=M35DvnI3k1HJXN09RWotg53+hrPfJRJ34UumAL2+x/ACGMMYo6BwIbZP1XkKFEdS29OC7iEZ2XFnGLL3o6vrmOd6Z4nhbR3RREXNzEyBhu8ZpBd7hqVQpkLw1U9baHZjlSFPMROOQGDVUJbXCemRTi66t8SV/Dt1VtQRNWTNBqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774569900; c=relaxed/simple;
	bh=LR9Ae84Frwn4+IGsUy3Hq8clRmrm/TL0hKKHWPHWflk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UWPdj6CE8R6pWno4g4jdkU9DHiTpLE2id+A48JZB8f/umR4pG6CyEpNMME4JK+8FhugKzbQRiiqvw7N3CA7Qokd67EjUktC+lKymGsIl/VCJ9JjcvlQTDvPZtCmXMJPWesU/jMDzSiED3yG/drlfI85o7jLNMIiV++JjZTGttms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=MFkuOEZL; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="MFkuOEZL"
Date: Fri, 27 Mar 2026 01:04:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1774569894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=egFI/yx36krqbFVwaiLMrNJBFEUke3mzZ30oHH4cgIA=;
	b=MFkuOEZL/6zqNUwFAczBbUTg6b9bv1o5U++pe+493vA2/SPloH6wWesn018eUozvaCtag2
	p1uDX+ijXS2CGieq2/pO5Kz8xvT2A8K8SI6NZnYdBAoczUBJnPZOlU8Bl738vPJ5E2o044
	/dSkuuz6/5ryluAlWBLdGXHwUonPhVIBjFTOXv5R+XYdQkc3ZAh8dMJIf80KqXV3nEcXxY
	dV8OAmPQj6fcLRy2pyIxB2MnJUUIRU34RrtPWFP1l+FgbmA3uWtgs3sWZXTcu0b6Aj95lO
	5tgD4TdjOojaXhBkhKWXWjV4Exw6eUIdAM3Y/yyc7rckgpJ7UVbBXSDAU8aumw==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
From: Mirko Faina <mroik@delayed.space>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Quentin Bernet via GitGitGadget <gitgitgadget@gmail.com>, 
	git@vger.kernel.org, Quentin Bernet <quentin.bernet@bluewin.ch>, 
	Mirko Faina <mroik@delayed.space>
Subject: Re: [PATCH] docs: fix git stash grammar
Message-ID: <acXIl2cuBv0ifiK6@exploit>
References: <pull.2255.git.git.1774529148151.gitgitgadget@gmail.com>
 <CALnO6CD-5NBUoooMD+pQAxeyXCjkZ3Za6LJrLrJN57Nrz03xBw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALnO6CD-5NBUoooMD+pQAxeyXCjkZ3Za6LJrLrJN57Nrz03xBw@mail.gmail.com>
X-Spamd-Bar: /

On Thu, Mar 26, 2026 at 12:17:46PM -0400, D. Ben Knoble wrote:
> Now, _is_ the grammar bracketed wrong? "git help stash" says
> 
>            For quickly making a snapshot, you can omit "push". In this mode,
>            non-option arguments are not allowed to prevent a misspelled
>            subcommand from making an unwanted stash entry. The two exceptions
>            to this are stash -p which acts as alias for stash push -p and
>            pathspec elements, which are allowed after a double hyphen -- for
>            disambiguation.
> 
> So _if_ you want to provide options (other than "-p"), the "push" is
> required. I think the existing brackets indicate that.

When it says "In this mode, non-option arguments are not allowed"
wouldn't -m be allowed as it is an option and not a non-option? In fact
if we do try to run "git stash -m something" it does correctly stash
while if we do something like "git stash pathspec" it does give back
"fatal: subcommand wasn't specified; 'push' can't be assumed due to
unexpected token 'pathspec'".

If that is the case then there is an issue with the way the usage
tooltip shows the optionality of "push".
