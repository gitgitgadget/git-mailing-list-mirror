Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9734C1E511
	for <git@vger.kernel.org>; Mon, 18 Mar 2024 08:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710751077; cv=none; b=fFm9ckncuS6T9IoVtbsjqxx74fo9xHDqT69gk6qgK7MO3v74HoV6IwnNSOR/L+FYqSu1Sm7Z8NX0mWTxdKBb1/+gke4tCJNuSGy133HFmSucKrFAHJOsRmc3PYlY3bmXPqopdoM5NzyDLfqEStXSUa+kwgsnG20GivRj+7CqdvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710751077; c=relaxed/simple;
	bh=b/ZnpP4m75wBqR1MIbij5L02SjPykoQeFqmntztbeOU=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=kdXxMAeidQiVdQupPwqAHgOF5pACK+OdKMZgDp8WvyB4ApVbQS3823YUPz1Pv3I+gAFAjFIPs/dk3pgOw8CmBvnSP8JR6AoEdUrGRyFsOztYFT3/BTR1gvl9/vMDcyLgdwG31uCiyzaBJe1LBZ3ZtvBd5NNLfTrQpCdkNY6o93Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=vQAS9hwf; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="vQAS9hwf"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1710751072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vC7uB6P1AWlhadi/OecEGzqBwxoKH21rPbEhBnGD2Rk=;
	b=vQAS9hwfgTArmsyA/XYIp8stjmOqZTJAdooze2gHg0hJA7cedevBgtkk5Pb0AKik9Af4NI
	oO2l1NmZavFmoRGDLKuaPMtsoRgsrnntQVUjVPn2t5GIRkaP4nlUl63yesj1bgASEbC0AA
	gHr5KKYWWl6yX9di0cXAQlpmfJbV/fkgW92PjIn+pI2Gpo6maGm4FH2hyCs+lseTRYhkny
	eV7N93lJZBZmXx5d0x0f6uesm4U0dwR26iT784w1B1APbwy1LKzBPbG7Yj7/8JWwApdyUI
	tFZFo68ZRl+RvOAtgUJAWwEy2/CzEXya6+nvMMYpXAJ9Adda1UYY2qTkFqODCw==
Date: Mon, 18 Mar 2024 09:37:52 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
 rsbecker@nexbridge.com, github@seichter.de
Subject: Re: [PATCH v2 4/5] t1300: add more tests for whitespace and inline
 comments
In-Reply-To: <xmqqttl4kvch.fsf@gitster.g>
References: <cover.1710646998.git.dsimic@manjaro.org>
 <9a73e7d3cbb9ea210ed1098c5a304b0f5d5e1a2e.1710646998.git.dsimic@manjaro.org>
 <CAPig+cTVmQzC38DympSEtPNhgY=-+dYbZmkr0RTRbhG-hp2fmQ@mail.gmail.com>
 <9996af464aabe2bf594c63c237d7a6e0@manjaro.org>
 <CAPig+cTLrsUpvKVjkFUgs1b1gvj54rm6FBa=5v3uoQtJnB4rZQ@mail.gmail.com>
 <xmqqttl4kvch.fsf@gitster.g>
Message-ID: <62a4ec0dace46d7c56e75dac9c42c297@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Junio,

On 2024-03-18 05:38, Junio C Hamano wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> 
>>> >> +       x_to_tab >.git/config <<-\EOF
>>> >> +       [section]
>>> >> +               Xsolid = rock
>>> >> +               Xsparse = big XX blue
>>> >> +               ...
>>> >> +       EOF
>>> >> +'
> 
> Just this part.
> 
>> My assumption, perhaps incorrectly, was that existing tests already
>> verified correct behavior of leading whitespace and that the tests
>> added by this patch were about internal whitespace. If that's not the
>> case (and perhaps I didn't fully digest the commit message) then my
>> question about the leading "X" is off the mark.
>> 
>> If these new tests are also checking leading whitespace behavior, then
>> to improve coverage, would it make sense to have the leading "X" on
>> some lines but not others?
> 
> If "<<-" (I have here-doc but please strip the leading tabs because
> I am aligning the here-doc with them) gets in the way for testing
> material with leading tabs, the way to write and preprocess such a
> here-doc is:
> 
> 	sed -e 's/^|//' -e 's/Q/   /g' >.git/config <<-\EOF
> 	|[section]
> 	|	solid = rock
> 	|	sparse = big QQ blue
> 	|	...
> 	EOF
> 
> It will make it clear where the left-edge of the "sheet of paper"
> is, removal of leading '|' does not get in the way of using '|' in
> the middle of the line if needed, and Q being the least used letter
> makes them stand out more in the middle of the line.  As it is
> obvious that what is before solid and sparse is a tab (otherwise you
> would not be using that '|' trick), you do not have to write Xsolid
> or Qsolid there and still the result is much easier to read.

This looks quite neat.  Furthermore, I think we should also consider
the already existing tests in the t1300 that contain such indentation.
As I already explained in my earlier response to Eric, [1] the choice
of including the indentation or not seems random to me, so we should
perhaps consider taking some broader approach.

How about this as a plan for moving forward:

1) Sprinkle a couple of tests onto the t1300, which try to be
    focused on the verification of the indentation-handling logic;
    maybe those additional tests could be even seen as redundant,
    but I think they can only help with the test coverage

2) Create a new helper function that uses the logic you described
    above, to make it simpler to include the indentation into configs

3) Finally, propagate the use of this new helper function into the
    new test and the already existing tests in the t1300 that already
    include the indentation

I'd be happy to implement all of the above-proposed steps in the next
couple of days.  Sure, it would be quite time-consuming, especially the
third proposed step, but it should be worth it in the long run.

[1] 
https://lore.kernel.org/git/c579edaac0d67a6ff46fe02072bddbb4@manjaro.org/
