Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0996227FB2A
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 14:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783952092; cv=none; b=YZSnMrFOhU29/2USjg0u4Ul5NoZ+YGvcDFj2wLeWDigMZm4OM9Q5srnPSdOMxFaZ7urlXnf/8oGodjTTJLgAcgtUINzsxN2C92PTokwW6pMgkhw0IvtbX0KadN14wpiesdul5+K2oXgDBPH6n1gS0OHsH2x4IgzRXufeAJMuXjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783952092; c=relaxed/simple;
	bh=ODSlnD3sKWfWmXoLivFrD/k01UX0fH3tCA2lOzCNCHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NX58OgDJ3hJexYyGZOqVckCqo7fQkPApPuHXO6OKVA+KA3eTHNWq/S65LpBm9sMY/2b81FkwQDTd2VA7E3wUviVO+zb0FTqIzSAzvdH3AwccGwQRLbc6X8fMmQQ5evWcwmSnBnOsyw0E5Q4SjYfx/UQcg+VOuarXNddP+m+GjTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org; spf=pass smtp.mailfrom=wyuan.org; dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b=WSOCCBaq; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wyuan.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b="WSOCCBaq"
Date: Mon, 13 Jul 2026 22:14:15 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wyuan.org; s=key1;
	t=1783952088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RJIJhyKKAg2q1QKom6cD4gTt+DWneW0KFwxvQdqURSA=;
	b=WSOCCBaqgtk9NSy6ULfAXaYBKuNLlIPUjCJQvfwIz/DOjz1fKs1haFUAbOmZwhr6UIit2e
	6XIJb4dVI+Mf+kZWf7JnhmlXmR/YRP/62EUGTwm1LRT4AliX2KhUc+w2Z9iZHymXj4bVGQ
	wG5vmdAUnQcPf/QlXnpsEsd7RyWPBFAQ2cxyxhdVeaCSJi5b98ttgA1v/o5RH8k68wZDvk
	lNXTy7uNjkPqgtnn/e81IgS2mX0EMZOzCbXU+rpRUydfipSaqveACCl/BcP3YCxBhwPtod
	Wj3mVowVmO8S6ug0SyNC26u3mBQoHEODnEMu1iuTa6I+RcswGINb72Gimp9NZw==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Weijie Yuan <wy@wyuan.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/6] SubmittingPatches: clarify expected structure of
 commit log message
Message-ID: <alTyt7hVW6gQOWQ4@wyuan.org>
References: <20260711192650.2417665-1-gitster@pobox.com>
 <20260711192650.2417665-2-gitster@pobox.com>
 <alOplirhJxIkpDYh@wyuan.org>
 <xmqq7bn042ez.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7bn042ez.fsf@gitster.g>
X-Migadu-Flow: FLOW_OUT

On Sun, Jul 12, 2026 at 09:07:32AM -0700, Junio C Hamano wrote:
> Weijie Yuan <wy@wyuan.org> writes:
> 
> >> +2. **Solution (The Approach)**:
> >> +3. **Command (The Instruction)**:
> >> +   [[imperative-mood]]
> >> +   Command the codebase to change.  Write this in the **imperative
> >> +   mood** (e.g., "make xyzzy do frotz" instead of "This patch makes
> >> +   xyzzy do..." or "I changed xyzzy..."), as if you are giving orders
> >> +   to the codebase to change its behavior.
> >
> > Stopped and confused for a moment. I am not sure that "Command" belongs
> > alongside "Observation" and "Solution" as a third part of the message.
> > Sometimes the command still describes the solution. In other words,
> > Solution and Command seem not to be logically completely separable.
> 
> I do not think "Command the codebase to change" is a good phrasing.
> It would have been better to highlight the distinction between the
> design of the solution (approach) and the implementation.  Perhaps
> 
>     2. Design (The Approach)
> 
>     3. Implementation (The Changes)
>     [[imperative-mood]]
>        Describe how the change is implemented.  Write this in the
>        imperative mood. ...
> 
> or something?

Yeah, that is much clearer. I'm reading your draft in your reply to
Michael, seems good.

> >> +* **The Body**:
> >> +  * Explain the *why* rather than repeating the *what* of the diff.
> >> +  * Try to make the explanation self-contained.  Avoid relying on
> >> +    external URLs (like mailing list archives) as the sole
> >> +    explanation; summarize the relevant points of the discussion
> >> +    instead.
> >> +  * Wrap lines to 68-72 columns.
> >
> > MyFirstContribution:
> >   This commit message is intentionally formatted to 72 columns per line
> >
> > Should we update both?
> 
> Perhaps just to stick to "around 70".
> 
> I do not think the defaults in various editors matter.
> 
> The "wrap around 70 columns" rule exists so that in a text based
> email exchange, where you lose two columns to leading "> " when
> quoted, and an additional column with each subsequent reply, the
> lines will still fit on standard 80-column terminals.

Yes, got it. I just want to say that I often see 72 columns, but I
haven't seen 68 very often. (maybe I'm too young ;-)

Thanks.
