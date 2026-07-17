Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC1A388E7A
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 12:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784292185; cv=none; b=QicwoAFjAHgOxldgysbwz/WOlVAFPXown9mlevaF9cBkKcznXOMsh1eUx+S8IDCj1oAPDE73Rk1U7iuyvabZg7gVE0w77H97GTBZkX8AOmES/6DrNpPZPdS1s0HAw0kkkE00y0XHtpXzU3VpjiA9OQhzrnELeCLvs4VR7Z+eaqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784292185; c=relaxed/simple;
	bh=zo2ue/qnGrVVoAQCtcbx5ZyYotWQF4uxeDch+9Zh5Us=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g9dJO+SH40eDZBSEb6PMsQKPLbJRjc0bP4yDIZPNCFqGiV2M40Jw7PvYjymEy4NqBOYSsSIqzo9weTOu0Jd+WxM3rwjwSGeGi3kCADpm94mbGyJgG3gpxT52vNIZ+UBsCWq+bk+MfmiR0+00FTOsjb/Mh6s39s23PA7NvaUsPlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org; spf=pass smtp.mailfrom=wyuan.org; dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b=PVZ+7VKh; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wyuan.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b="PVZ+7VKh"
Date: Fri, 17 Jul 2026 20:42:53 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wyuan.org; s=key1;
	t=1784292180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T8L3MmyXqjrYrEVQ7K3GZn0VIsxV3BhNU4Stm63KZCM=;
	b=PVZ+7VKhJ2vi3Xoi4ppNbRjELDIitW6E1qGbFM0pVs1FXO8qrDrOd71+rG7s0G+AMBLI8h
	drXeQtPen5aiVoAXTAdv+9m8jeZt3915/s1RWUB775IqWXlIYbLTu7rU3BGJqE2jVVlpUe
	X3wc8ubit0fKB+gjCoIVp2YwddveKX4ttA/TP3yXGi1Vlp4jb0MvBw5P0+u5d7qVMxJawP
	AT+It2ghdBrR8VYmuNa1pzvDZrUxXS9+KjJyHQMKk6h/UcvLlbesSIKAFxtZpoYjnF2UJf
	NpuLuA8pN2iHuBK7j4WsDE6c4QJ1xEhWuk03PwcTsiirVEESOCLdtBGLL9K8+Q==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Weijie Yuan <wy@wyuan.org>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Montalbo <mmontalbo@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/6] SubmittingPatches: clarify expected structure of
 commit log message
Message-ID: <alojTem4a5q1Xu4X@wyuan.org>
References: <20260711192650.2417665-1-gitster@pobox.com>
 <20260711192650.2417665-2-gitster@pobox.com>
 <CAC2QwmL05MbVS=jtk7ARj6jJUT461Ws7BcYqUAUrywvDDXjJqg@mail.gmail.com>
 <xmqqcxwr3g7r.fsf@gitster.g>
 <alTy306FaTAe2E8w@wyuan.org>
 <CALnO6CD8HFWaeN-4Gccopy0nw601cMyak_LSXfTsAa8xwOjKpQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALnO6CD8HFWaeN-4Gccopy0nw601cMyak_LSXfTsAa8xwOjKpQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Jul 14, 2026 at 06:46:05PM -0400, D. Ben Knoble wrote:
> On Mon, Jul 13, 2026 at 10:42 AM Weijie Yuan <wy@wyuan.org> wrote:
> >
> [snip]
> > I think this might confuse readers. Now you place these points in
> > parallel:
> >
> >  1. Title
> >  2. Body
> >  3. Observation (The Status Quo)
> >  4. Solution Design (The Approach)
> >  5. Implementation (The Execution)
> 
> Without commenting on "confuse," I find this style of heading
> 
>     Thing (The Other Thing)
> 
> needlessly suggests an LLM's involvement with the text.

Aha, kind of. But I guess Junio didn't use LLM here ;-)

> That by itself is not grounds for my objection; instead, I'll note
> that often the parenthetical restates the original header in some way.
> That makes it redundant. (In some cases in the wild I have seen
> examples where the 2 were not synonymous, which _is_ confusing :)

True.

> > But acatually you mean:
> >
> > 1. Title
> > 2. Body
> >    The body typically follows three parts:
> >    a. Observation
> >    b. Solution Design
> >    c. Implementation
> >
> > But I haven't written much about adoc, so I don't know its syntax and
> > how to write it.
> 
> This is nice. If I had to suggest anything further, it would be "don't
> be afraid of long headings":
> 
> 1. Title: Summarize the change
> 2. Body: Describe [Justify?] the change
>     a. Observe the status quo
>     b. Explain your approach [solution/design/etc.]
>     c. Command the code to change [or: Describe the implementation/execution]
> 
> ?

I agree. More explanatory descriptions here are very likely to enable
contributors to express their ideas more clearly and understandably.
