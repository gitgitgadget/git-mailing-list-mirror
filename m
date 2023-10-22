Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBCCA48
	for <git@vger.kernel.org>; Sun, 22 Oct 2023 06:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="Cq0Ne4hW"
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E376D9
	for <git@vger.kernel.org>; Sat, 21 Oct 2023 23:38:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1697956700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/bfB7C8rwSlf+0QwVrYuDVU4qpifAk3nGzGROsjchsc=;
	b=Cq0Ne4hW9M4JZ6EghJgE0VORS9QdUc7s6Z7OBnNCFur3IEcU/2Vqqv2Lje0r87aTabVUnZ
	bERSjamYSaeRRk1VgXbJuzb+/5eTj5OhOYEMIyes5xGA4lB3b6Meo+8xe4BZFDa2swFxPX
	QQyiTR3ry39LQGU4RbM8g5Ql+z2WGehQXMIwiytlCooze3+MyumTlvJBJ0eYUAdhR8uh35
	zeV2kCwME/XPTgdmNOHdfwSgYpQck2+BnoQkbNg0CTVBDt6PSf3Ls2zXRXGbSD4vV+4aP4
	EclcqEw7dO+oAtFAe5rcfO7A48/o2cnNL5V7jnjk0ePfQ6jdsH7lIHgyfl9IRg==
Date: Sun, 22 Oct 2023 08:38:19 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Jacob Stopak <jacob@initialcommit.io>
Cc: git@vger.kernel.org
Subject: Re: [RFC PATCH 0/5] Introduce -t, --table for status/add commands
In-Reply-To: <ZTS4jfsU6oS6LW0u.jacob@initialcommit.io>
References: <20231020183947.463882-1-jacob@initialcommit.io>
 <fd26df85661d554ced9d8e0445f75952@manjaro.org>
 <ZTL1wJIIK/5YWQK5.jacob@initialcommit.io>
 <d3bbe53c3b910f891c80465ea0c3f53f@manjaro.org>
 <ZTS4jfsU6oS6LW0u.jacob@initialcommit.io>
Message-ID: <5fac8607a3c270e06fd610551d7403c7@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2023-10-22 07:52, Jacob Stopak wrote:
>> Frankly, based on my rather broad experience, there are two primary
>> categories of the beginners in the world of version control software 
>> (VCS),
>> be it git or any other product:
>> 
>> 1) People who are forced to use some VCS at work, and they actually 
>> don't
>> give a damn about it.
>> 2) True enthusiasts who love what they do, and who love expanding 
>> their
>> knowledge.
>> 
>> For the first category, nothing helps.
> 
> Interesting categorization I didn't think of splitting users that way. 
> I
> guess for group 1 that's true, if they are shown a GUI and can run 3
> commands that can do what they need, that's all they will ever use.

Coincidentally, yesterday I was demonstrated for the first time in my 
life the way VS Code works with git, by a member of the first category 
of users.  It's dumbed down to the extreme, hiding pretty much all the 
details and git specifics, which is exactly what the first category 
wants.  Now I understand why the VS Code is so much popular.

The second category, myself included, tends to be genuinely disgusted by 
such an approach that makes everything nearly sterile.  But I do 
understand why many users simply love it that way.  Maybe I digress.

>> For the second category, a nicely
>> written tutorial is all they needed to start with, aided later with 
>> the man
>> pages, Stack Exchange, and perhaps some textbook.
> 
> This is the exact way I learned Git and became comfortable and 
> eventually
> confident using it. Reflecting on that, I really only started to become
> truly confident after understanding the core underlying concepts (maybe
> this is obvious / true for anything). And it's always easy once you get 
> it.

I agree, understanding the internals of some project or product, with 
many or all of its outer layers peeled back, is often the only way to 
really get to know it.

> However, there is one main benefit of a feature like this, that none of
> the other options (man pages, stack exchange, a textbook) can provide:
> 
> Since the tool (Git) has access to and knows the exact state of your 
> local
> environment, it can provide instant feedback that takes into account 
> that
> context. That is immeasurably more helpful than trying to figure out 
> how
> to best ask Google your question, and then piecing together your 
> problem
> with a similar one some lost soul ran into 10 years ago.

True, but I still think that having git put its thoughts into tables is 
actually not helpful.  To be precise, it actually might be helpful, but 
only to the first category of users, who will never reach it.  I mean, 
never say never, but in this case I'm pretty sure it's safe to say it.  
Unfortunately.

>> Please don't get me wrong, I understand your reasoning, but again, it 
>> all
>> comes down to the two categories described above.  IMHO, the second 
>> category
>> will likely start turning off the default hints sooner than turning 
>> the
>> table formatting on.  The first category will choose some GUI anyway.
> 
> The default hints are an intersting consideration. I've found them 
> handy
> for commands that I use infrequently, and also when I find myself in a
> scenario that is not a part of my usual workflow.

The built-in hints are useful without doubt, and in fact I still have at 
least a dozen of them left enabled.

> And the hint feature does show that Git has some "helper" features to
> hold the user's hand at least a little bit.

IMHO, git strikes a very good balance between holding the user's hand 
and leaving them on their own.  For the second category of users, of 
course.

>> No pain, no gain.  That's the ancient mantra, but IMHO it still 
>> applies very
>> well to many things, and of course not to the first category mentioned
>> above.  Nothing applies to that category.
> 
> Somehow I do feel some sense of satisfaction at the countless times 
> I've
> I've been stuck on some menial issue only to find out it had a stupid
> solution I overlooked. It's also just kind of funny in hindsight.
> 
> Regardless of a table formatting feature in Git, there is still plenty 
> of
> sweet sweet pain to be had with software dev in general.
> 
> But in the moment I always do appreciate being able to get past a
> roadblock as quickly as possible. I would want a tool I design to be
> known for avoiding pain rather than causing it.

I agree, software in general shouldn't cause people pain, it should make 
people's lives better.  However, many people expect software these days 
to be some kind of pain killer, which it simply can't be unless dumbed 
down to the extreme.  If you ask any doctor what results from taking 
pain killers for an extended period of time, they'll answer you that 
stronger pain killers will usually become needed.
