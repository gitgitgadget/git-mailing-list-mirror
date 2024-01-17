Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822AE25624
	for <git@vger.kernel.org>; Wed, 17 Jan 2024 21:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705527057; cv=none; b=Bl2lbT68KWXpNnqFgq/WMRF4aj4ZUcZ7CtaI7n97iC5gnIrFMfV++D+wEZGACCALLvK1pHQmNCdVyixg8+8dm2Nj0FISrpVFk+XWqjMT2vo4NlFm3DH3EdptV43WoOAqzP182grpe1WbBWsxuWJbg849P6/Tr5l58FcN63utNqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705527057; c=relaxed/simple;
	bh=2nFt2gRzuV9vpMol351N6GAxyT02Hgq6VO1uNi3Ak6s=;
	h=MIME-Version:DKIM-Signature:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID:X-Sender:Content-Type:
	 Content-Transfer-Encoding; b=CRpYNdFxwOiwSQDi20NWGRZET+4DZXl+bpMEWHdcipPBhqGqWV1QhP82UzUtbbe9WqIL6oYNvvwfrA7EI6HVud+L6bJUoofgY1V6JEVss+7LnonsQ0rD7P28RLJEhKMq+DcvbGEDzd2kqO6s+hRXhVwmfhKO8GeTAlMKevJ3NaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=KRr+Ydsb; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="KRr+Ydsb"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1705527046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aLPqB4ybs/Ve5w+3ZIa/z5KxVfHX7SHx3SBG3o7xEgw=;
	b=KRr+Ydsb9dFcOUJ0ymqu56jpIAoACGrrOunb/5VcKIBeYBmlrdRFWgF3gshuiHq/PqCVS0
	fGtgiX8ZNfryQ5uVv5FX6tbGBXQ/7lV9cty0kZx/LQQuN46u+wqR4UL2+Tuho+4HQ2rqAP
	Qw7yQD9hvIVeaJLgXd9QcjxjWaeXVWbn+KPslK5TKJUsu6M/BFo1ujkjeGvPt7ZMGJUOSG
	0yotlC6NOi/i4b81myHNZZQA/pttm7S8flgPxR8BsfFoH9TyuyH28eelQZ7fh/Wk+Hz9B1
	ydmxmAsw6HiEXFKGhdb2zqu2SKoA8MX/M6zx4LlPWF1YRaglW0YUAJVuzRV+bg==
Date: Wed, 17 Jan 2024 22:30:45 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Elijah Newren <newren@gmail.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [DISCUSS] Introducing Rust into the Git project
In-Reply-To: <CABPp-BFWsWCGogqQ=haMsS4OhOdSwc3frcAxa6soQR5ORTceOA@mail.gmail.com>
References: <ZZ77NQkSuiRxRDwt@nand.local>
 <b2651b38a4f7edaf1c5ffee72af00e46@manjaro.org>
 <CABPp-BH3sva=CNtx8YFGP4Egyau-hR+7njZPFEd-DRTw91BK2w@mail.gmail.com>
 <f5b9a57b6e2b513f1d79a93c6f0ccf45@manjaro.org>
 <CABPp-BFWsWCGogqQ=haMsS4OhOdSwc3frcAxa6soQR5ORTceOA@mail.gmail.com>
Message-ID: <45bfda3a350b4040a28a25993a2b22e0@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-01-11 17:57, Elijah Newren wrote:
> Hi Dragan,

I apologize for my delayed response.

> On Wed, Jan 10, 2024 at 9:39 PM Dragan Simic <dsimic@manjaro.org> 
> wrote:
>> 
>> On 2024-01-11 01:33, Elijah Newren wrote:
>> > On Wed, Jan 10, 2024 at 1:57 PM Dragan Simic <dsimic@manjaro.org>
>> > wrote:
>> >>
>> >> Thus, Git should probably follow the same approach of not converting
>> >> the
>> >> already existing code
>> >
>> > I disagree with this.  I saw significant performance improvements
>> > through converting some existing Git code to Rust.  Granted, it was
>> > only a small amount of code, but the performance benefits I saw
>> > suggested we'd see more by also doing similar conversions elsewhere.
>> > (Note that I kept the old C code and then conditionally compiled
>> > either Rust or C versions of what I was converting.)
>> 
>> Well, it's also possible that improving the old C code could also 
>> result
>> in some performance improvements.  Thus, quite frankly, I don't see 
>> that
>> as a valid argument to rewrite some existing C code in Rust.
> 
> Yes, and I've made many performance improvements in the C code in git.
> Sometimes I make some of the code 5% or 20% faster.  Sometimes 1-3
> orders of magnitude faster.  Once over 60 orders of magnitude
> faster.[1]  Look around in git's history; I've done a fair amount of
> performance stuff.

Thank you very much for your work!

> And I'm specifically arguing that I feel limited in some of the
> performance work that can be done by remaining in C.  Part of my
> reason for interest in Rust is exactly because I think it can help us
> improve performance in ways that are far more difficult to achieve in
> C.  And this isn't just guesswork, I've done some trials with it.
> Further, I even took the time to document some of these reasons
> elsewhere in this thread[2].  Arguing that some performance
> improvements can be done in C is thus entirely missing the point.
> 
> If you want to dismiss the performance angle of argument for Rust, you
> should take the time to address the actual reasons raised for why it
> could make it easier to improve performance relative to continuing in
> C.
> 
> Also, as a heads up since you seem to be relatively new to the list:
> your position will probably carry more weight with others if you take
> the time to understand, acknowledge, and/or address counterpoints of
> the other party.  It is certainly fine to simply express some concerns
> without doing so (Randall and Patrick did a good job of this in this
> thread), but when you simply assert that the benefits others point out
> simply don't exist (e.g. your "Quite frankly, that would _only_
> complicate things and cause fragmentation." (emphasis added) from your
> first email in this thread[3], and which this latest email of yours
> somewhat looks like as well), others may well start applying a
> discount to any positions you state.  Granted, it's totally up to you,
> but I'm just giving a hint about how I think you might be able to be
> more persuasive.

I totally agree with your suggestions, and I'm thankful for the time it 
took you to write it all down.  I'll take your advice and refrain myself 
from expressing my opinions in this thread.

> [1] A couple examples: 6a5fb966720 ("Change default merge backend from
> recursive to ort", 2021-08-04) and 8d92fb29270 ("dir: replace
> exponential algorithm with a linear one", 2020-04-01)
> [2] Footnote 6 of
> https://lore.kernel.org/git/CABPp-BFOmwV-xBtjvtenb6RFz9wx2VWVpTeho0k=D8wsCCVwqQ@mail.gmail.com/
> [3] 
> https://lore.kernel.org/git/b2651b38a4f7edaf1c5ffee72af00e46@manjaro.org/
