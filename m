Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672F45A4C4
	for <git@vger.kernel.org>; Mon, 18 Mar 2024 21:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710798881; cv=none; b=he2rG0F/cevUGB7x4WVQ3O9OhnPKAmy59inxoSwqViCNSljckqUyYEfhNnOXWYMhCoYDn9Mc43wEhBdARbiBxwnyyJk9FEbsuRyIa/PusO9FPygg5MP0pYh8U4u55stgGkR4c/1ABEWEtJiKsB+i4jMuq01/EYHCXoFZF/IQXNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710798881; c=relaxed/simple;
	bh=0v5oHrU3AEYEjjiJqRG42hYy7fv1G+MwFqD2azkRl6U=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=ukXSIyC3q8eUI+HlRMa+Sb5a2b8kTknwz4F3cSz+HQasaiCyc++xL0UCqlGx77JIJvUgumxEEG7YsNXFb2VIQJqTi6DdkD6Mi3nb04JLLs7EbPp7Yk7BPRGCev2HraichiGfUzQeKKZCxA3g5wXNRJARLFkMkG6IUAOfd4yHAZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=GbWV2cS2; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="GbWV2cS2"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1710798876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5T8ksb20uhEpLawDp62y6MCIYuzpfrzckQfL5I5utMc=;
	b=GbWV2cS2S+TDAaga3KlGB+fK65xanZbIeWwIMe3uAGZm4tn0YgXVIYal12EhpNAmq7gPEa
	Womwy1zB4lyOkpJw75KRDkypEMuGAzEsU/r1njvo60C9JMOi+xLxDkLzpQTuv9+jxj+Wc5
	7sWUXksm/7IPFipB15/BD2rsL6F+cO/tzE146i9PxXXrR5VLyY48JKQ3Yl0kHAUBLmEhn8
	hKHxvs5XSEyznOAxwRkdMif0ukDifd3o8b5Z6b+NiBYB9WSo0dEHijcaYsZD2aWdlsRdZ8
	vvbC95mQcPw8u6Ltc6KKSlCNm4RYfvjVELI7jIzT9Ds1sYD5A1J0a87Ef3rFTw==
Date: Mon, 18 Mar 2024 22:54:32 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org, gitster@pobox.com, rsbecker@nexbridge.com,
 github@seichter.de
Subject: Re: [PATCH v2 4/5] t1300: add more tests for whitespace and inline
 comments
In-Reply-To: <CAPig+cSJdBm+sRcXSpdZYUqSqktN3ytcjD3kmhu6WfTRuqkPrg@mail.gmail.com>
References: <cover.1710646998.git.dsimic@manjaro.org>
 <9a73e7d3cbb9ea210ed1098c5a304b0f5d5e1a2e.1710646998.git.dsimic@manjaro.org>
 <CAPig+cTVmQzC38DympSEtPNhgY=-+dYbZmkr0RTRbhG-hp2fmQ@mail.gmail.com>
 <9996af464aabe2bf594c63c237d7a6e0@manjaro.org>
 <CAPig+cTLrsUpvKVjkFUgs1b1gvj54rm6FBa=5v3uoQtJnB4rZQ@mail.gmail.com>
 <c579edaac0d67a6ff46fe02072bddbb4@manjaro.org>
 <CAPig+cSJdBm+sRcXSpdZYUqSqktN3ytcjD3kmhu6WfTRuqkPrg@mail.gmail.com>
Message-ID: <9e72093587177459a40d4aefb213b8b5@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-03-18 20:17, Eric Sunshine wrote:
> On Mon, Mar 18, 2024 at 4:17 AM Dragan Simic <dsimic@manjaro.org> 
> wrote:
>> On 2024-03-18 03:48, Eric Sunshine wrote:
>> > Readability wasn't my reason for bringing this up. As a reviewer,
>> > every time a question pops into my mind as I'm reading the code, that
>> > indicates that something about the code is unclear or that the commit
>> > message doesn't properly explain why it was done in this way. People
>> > coming across this code in the future may have the same questions but
>> > they won't have the benefit of being able to easily ask you why it was
>> > done this way.
>> 
>> I see.  How about including a small comment in the t1300 that would
>> explain the additional indentation?
> 
> I'm just one reviewer. Unless others chime in with similar
> observations or questions regarding the patch, I don't think such a
> comment is necessary. Aside from the other more significant points
> (such as not introducing x_to_tab(), using "setup" in the function
> title, etc.), this is extremely minor, and what you have here is "good
> enough" (though you may want to take Junio's suggestion of using a
> leading "|" to protect indentation).

Just to reiterate, both x_to_tab() and the test naming have already
been addressed in the future v3 of this series.

>> As a note, there are already more tests in the t1300 that contain such
>> indentation, so maybe we shoulddo something with those existing tests
>> as well;  the above-proposed comment, which would be placed at the 
>> very
>> beginning of t1300, may provide a satisfactory explanation for all the
>> tests in t1300 that contain such additional indentation.
>> 
>> Another option would be to either add the indentation to all relevant
>> tests in the t1300, or to remove the indentation from all tests in the
>> t1300 that already contain it.  I'd be happy to implement and submit
>> patches that do that, after we choose the direction we want to follow.
> 
> It would be better to keep this series focused on its primary goal of
> fixing a bug rather than being held hostage to an ever increasing set
> of potential cleanups. Such cleanups can be done as separate patch
> series either atop this series or alongside it. Let's land this series
> first, and then, if you wish, tackle those other less significant
> issues.

Thanks, I totally agree.

>> > If these new tests are also checking leading whitespace behavior, then
>> > to improve coverage, would it make sense to have the leading "X" on
>> > some lines but not others?
>> 
>> Good point, despite that not being the main purpose of the added 
>> tests.
>> I'll see to add a couple of tests that check the handling of
>> indentation,
>> possibly at some places in the t1300 that fit the best;  improving the
>> tests coverage can only help in the long run.
> 
> As above, such additional tests probably aren't mandatory for this
> bug-fix series. As a reviewer, I'd like to see fewer and fewer changes
> between each version of a patch series; the series should converge so
> that it can land rather than diverge from iteration to iteration. Such
> additional leading-whitespace tests may be perfectly appropriate for a
> follow-up series.

Agreed once again.  Let's wrap this up, and I'll come back with the
follow-up patches.
