Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E965A23775
	for <git@vger.kernel.org>; Mon, 18 Mar 2024 08:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710749885; cv=none; b=u5BRdKexWMlKvSqus6F3xr/4ex+Xh4b5hSVDja5J8k1vHZpQaqmZ+DK5x7BtVO/pwn17nVBz7Y5FVnM4A4ORykRGLrgPv3qKopLY5bLAwph+mqqXr39VNTYfUnTzw5fstpJonX2cy98GoMJQHZcP4VxJNHgJsm8fK8NVOL1UO5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710749885; c=relaxed/simple;
	bh=gdk3/iKW4CFRMR/riZkFBuye0R9PNGLTb1y6qHH113U=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=DG1joqbtcgW3wTKYuY45gSbxNzuSLoAx7RonB5Y4f2tjwbJNlnNPPsUHj4bMoXRlA9r0ZRtx/Hzk/LXo6nWAHm8z6TQv782ya0DzI40qQD1rc4TD3sQEAGQuNhqVkP72kRyO2qG6bhGa3n24yPUk12Pu/LzD/CDfiqi7sHuvKVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=un+r/v46; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="un+r/v46"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1710749873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iPmza/MuMdqJxlg2LKFEuL36BTfgvModuezgHwtyjq0=;
	b=un+r/v46k/HQgo03kpZDX/v8bmNykVzYAGMf2BqGgPTm9vylx92cvtNdlI0G8AjwDvvEXE
	lObDHJV92zl3C68DQ9Y52wyrpeEajCOR3RTaKUIcQADo4CHgDu12FcP+4h1ZcpAgUJ2aLG
	ic7zT3S1b4+TH1FHWusR2Es4uMPDiZJnZECfRKRPtaWr+8Ivmd096LVnI+8Sb2JdmawZF1
	r5IrQ6h4rH5wCK9LbEyUhuZjitCFhzvYv2HSDWVVukpErVU8b4AlwgyL1QzZZl0YdTjgNs
	f7C5jenBBC2IATcyIjvwO8GDfA5Jo23IVLrFAZSltSdD5rwb17M8we0rjjYo0w==
Date: Mon, 18 Mar 2024 09:17:52 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org, gitster@pobox.com, rsbecker@nexbridge.com,
 github@seichter.de
Subject: Re: [PATCH v2 4/5] t1300: add more tests for whitespace and inline
 comments
In-Reply-To: <CAPig+cTLrsUpvKVjkFUgs1b1gvj54rm6FBa=5v3uoQtJnB4rZQ@mail.gmail.com>
References: <cover.1710646998.git.dsimic@manjaro.org>
 <9a73e7d3cbb9ea210ed1098c5a304b0f5d5e1a2e.1710646998.git.dsimic@manjaro.org>
 <CAPig+cTVmQzC38DympSEtPNhgY=-+dYbZmkr0RTRbhG-hp2fmQ@mail.gmail.com>
 <9996af464aabe2bf594c63c237d7a6e0@manjaro.org>
 <CAPig+cTLrsUpvKVjkFUgs1b1gvj54rm6FBa=5v3uoQtJnB4rZQ@mail.gmail.com>
Message-ID: <c579edaac0d67a6ff46fe02072bddbb4@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Eric,

On 2024-03-18 03:48, Eric Sunshine wrote:
> On Sun, Mar 17, 2024 at 12:50 AM Dragan Simic <dsimic@manjaro.org> 
> wrote:
>> On 2024-03-17 05:21, Eric Sunshine wrote:
>> > On Sat, Mar 16, 2024 at 11:48 PM Dragan Simic <dsimic@manjaro.org>
>> > wrote:
>> >> +       x_to_tab >.git/config <<-\EOF
>> >> +       [section]
>> >> +               Xsolid = rock
>> >> +               Xsparse = big XX blue
>> >> +               ...
>> >> +       EOF
>> >> +'
>> >
>> > The <<- operator strips all leading TAB characters, so the extra
>> > indentation you've placed inside the "[section]" section is stripped
>> > off. Thus, what you have above is the same as:
>> >
>> >     x_to_tab >.git/config <<-\EOF
>> >     [section]
>> >     Xsolid = rock
>> >     ...
>> >     EOF
>> 
>> Yes, I was already aware that such indentation ends up wasted,
>> but having it makes the test a bit more readable.  At least in
>> my opinion, but if you find it better not to have such whitespace,
>> for the sake of consistency, I'll happily remove this indentation
>> in the v3.
> 
> Readability wasn't my reason for bringing this up. As a reviewer,
> every time a question pops into my mind as I'm reading the code, that
> indicates that something about the code is unclear or that the commit
> message doesn't properly explain why it was done in this way. People
> coming across this code in the future may have the same questions but
> they won't have the benefit of being able to easily ask you why it was
> done this way.

I see.  How about including a small comment in the t1300 that would
explain the additional indentation?

As a note, there are already more tests in the t1300 that contain such
indentation, so maybe we shoulddo something with those existing tests
as well;  the above-proposed comment, which would be placed at the very
beginning of t1300, may provide a satisfactory explanation for all the
tests in t1300 that contain such additional indentation.

Another option would be to either add the indentation to all relevant
tests in the t1300, or to remove the indentation from all tests in the
t1300 that already contain it.  I'd be happy to implement and submit
patches that do that, after we choose the direction we want to follow.

> So, the ideal patch is one in which the reviewer reads the code and
> simply nods in understanding without having to question any of the
> author's choices. And the ideal test is one in which does the bare
> minimum to verify that the condition being checked is in fact correct;
> there should be no extraneous code or behavior which could mislead the
> reader into wondering why it was done that way.
> 
> In this particular case, it wasn't clear whether you, as author,
> realized that all leading TABs are stripped from the heredoc body, and
> whether or not that mattered to you and whether or not you expected it
> to be significant to the test's behavior.

I fully agree with the most of your points above.  The only slight
disagreement would be about the bare minimum when it comes to automated
tests;  in my, opinion, it's actually good to have a few twisties here
and there, simply to exercise the underlying logic better by such tests.

This probably opens a question whether the automated tests should be
orthogonal?  Perhaps the majority od them should, but IMHO having a few
composite tests can only help with the validation of the underlying 
logic.

>> > On a related note, it's not clear why you use 'X' to insert a TAB at
>> > the beginning of each line. As I understand it, the configuration file
>> > reader does not require such indentation, thus doing so is wasted.
>> > Moreover, it confuses readers of this code (and reviewers) into
>> > thinking that something unusual is going on, and leads to questions
>> > such as this one: Why do you use 'X' to insert a TAB at the beginning
>> > of the line?
>> 
>> Well, resorting to always not having such instances of 'X' to provide
>> leading indentation in test configuration files may actually make some
>> bugs go undetected in some tests.  To me, having leading indentation 
>> is
>> to be expected in the real configuration files in the field, thus
>> providing the same indentation in a test configuration feels natural 
>> to
>> me, despite admittedly making the test configuration a bit less 
>> readable.
>> 
>> Of course, consistency is good, but variety is also good when it comes
>> to automated tests.  I'm not very familiar with the tests in git, so
>> please let me know if consistency outweights variety in this case, and
>> I'll happily remove the leading "X" indentations in the v3.
> 
> My assumption, perhaps incorrectly, was that existing tests already
> verified correct behavior of leading whitespace and that the tests
> added by this patch were about internal whitespace. If that's not the
> case (and perhaps I didn't fully digest the commit message) then my
> question about the leading "X" is off the mark.

Frankly, I can't be 100% sure without spending quite a lot of time, but
I don't think that the already existing tests in the t1300 were tailored
specifically to cover the verification of the leading whitespace, i.e.
of the indentation in git configuration files.  To me, it seems more 
like
a random choice of including the indentation or not.

Such a random approach may actually be good, despite bringing back the
above-mentioned question about the orthogonality of the tests.

> If these new tests are also checking leading whitespace behavior, then
> to improve coverage, would it make sense to have the leading "X" on
> some lines but not others?

Good point, despite that not being the main purpose of the added tests.
I'll see to add a couple of tests that check the handling of 
indentation,
possibly at some places in the t1300 that fit the best;  improving the
tests coverage can only help in the long run.
