Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32234422
	for <git@vger.kernel.org>; Sat, 28 Oct 2023 17:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="bZdBfc25"
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B51F1
	for <git@vger.kernel.org>; Sat, 28 Oct 2023 10:41:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1698514907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DXhKkWQX56urA5GZm9j7wq+GmjMM4vXKOhdAx1lHR3k=;
	b=bZdBfc25jzI3pxV0gwU+bR59FxAPHeDEs72Nd/xP4uMYp8sgg0/FuU64FTstYVqSdoShT/
	R/d7P+sc2K3RjrN4mrWnj5S2eeIJZ/b2dE9dBomkioX7mU8FeiLhkeyqgZ/1ZaRD6WBKAe
	M9ZTZU7Wd/jp+XloaY45O2NnP5i7pDkgf1rbGKTZu10LnUrDiWhNv+ExoFYrIOuA8xsKqj
	lPO5KmoUnj7XNTaA9dHFRWbcbcVA65i6O/mSs7Qr0UPkwsO4xUYTINlk94BAj7bPeW+RMU
	zHYSMdLcQRyM96pK4fR008MNybhEC5nN5ngtMtYBuQWHgh0jZlt+jhOyy0qXTA==
Date: Sat, 28 Oct 2023 19:41:47 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Jacob Stopak <jacob@initialcommit.io>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Oswald
 Buddenhagen <oswald.buddenhagen@gmx.de>
Subject: Re: [RFC PATCH v2 0/6] Noobify format for status, add, restore
In-Reply-To: <ZT1GWw886XuXwqlw.jacob@initialcommit.io>
References: <20231020183947.463882-1-jacob@initialcommit.io>
 <20231026224615.675172-1-jacob@initialcommit.io>
 <ca47d328c280e4b4c13bfa6dd9958a57@manjaro.org>
 <ZTvvz6/GFdwagVa+.jacob@initialcommit.io>
 <9b93115810ca269c87ec08f72fdc9c12@manjaro.org>
 <ZTx3fIGpdGl4JpaV.jacob@initialcommit.io>
 <2a0ba4c8e96cb7d2ea66dd1e78cdd39c@manjaro.org>
 <ZT0m68HWZS/tDGtH.jacob@initialcommit.io>
 <37e7bd8f6f4b75aa3b31dc98804b1334@manjaro.org>
 <ZT1GWw886XuXwqlw.jacob@initialcommit.io>
Message-ID: <fd54ef08fa676ec12ad6835f0122c4c0@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2023-10-28 19:35, Jacob Stopak wrote:
> On Sat, Oct 28, 2023 at 06:20:41PM +0200, Dragan Simic wrote:
>> I agree, there should be a well-placed hint, but we'd need to think 
>> really
>> well where to place it, so we don't annoy experienced git users too 
>> much,
>> while we also inform the less experienced users.
> 
> Yes, hmm, I wonder if maybe we could add the hint for the extended 
> option
> only in the case that the user uses the --verbose option either on the
> command line or via the config setting. Since using the verbose option
> tells us the user is asking for more details, that might be a good time
> to inform them of the _even more detailed_ option, but of course that
> hint could be disabled easily if they preferred the "basic" verbosity.

That's something we can keep thinking about, until we find a good 
solution.  Also, a detailed review of the current logic behind 
displaying the hints should be performed first, if you agree.

>> Sounds good, thank you.  If you agree, I'll go ahead and implement 
>> support
>> for a few "<command>.verbose" configuration options during the next 
>> week or
>> so, and submit the patches.  I'll most probably come to some more 
>> important
>> conclusions while implementing that, which I'll relay over, of course.
> 
> Yes I agree, that sounds great! Maybe I'll just wait then until seeing
> your implementation of that before I poke around on mine more. Then 
> I'll
> apply your patches locally to add my extended option.

Great, thanks.  I'll start working on the patches tomorrow or so, and 
I'll get back with any important conclusions or open questions arising 
from that, so we can discuss them further.
