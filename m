Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CF81B0420
	for <git@vger.kernel.org>; Sat, 27 Sep 2025 21:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759008762; cv=none; b=VSYG8mptPisiQb3LxxJcF/HkDVoQQoy7r4pU07JjScwY9Y31onuelHFXBe12Ty9e8y01P2FflRDsJNaANJMW6LpbG+e5DuEQKd6ddecS/vlfYwkD6clKKRAVqN22q0ar03uSWoyMVlNwdHqp1v5teqSzG/cJ2mTJGlgYPFa1ihw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759008762; c=relaxed/simple;
	bh=hlsbTIRoFEeXsGBi2ovQMyyOkec8VY18Tn7GWhiXXNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YwfcUNHEVKnvvw6sGCGNmhlQ2EIge3tA6GMWzvskfocvYR7CQgBFQq+eYFR8H+CX+g0vWKDyqNQdnyizaUUCBEdgA5jXGPKUyyO2dyAwu5TRo4jDhrYARSdFgwRqCzjkpgQd9gyW8hmBjvx2pDs+DFbtw6niuPc3xXMZbfKL2Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=HYNZbQdB; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="HYNZbQdB"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-6089a139396so3117492d50.0
        for <git@vger.kernel.org>; Sat, 27 Sep 2025 14:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759008759; x=1759613559; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SElHc2Lj3Jzq/rwI+TwRKq655LGTP+R5wtY+OIRAOjc=;
        b=HYNZbQdBSGoacNe6Dlb5rrHSPJEEqP5dTzjpOs1qdKPU32ymRXjcD7zLUt/aWrCAIS
         xkuUKsFGTEo1oamTka0kXo+oFSAxz1vHckFKLWSK2QPAFeZEqsaKvcVmELhL0iIO1LBs
         Ii/2CxpDK5nes1JmWNmjZ6OmyQzMkDG+uhr09JNJ5o3Dh9jHIrPflfsjg2PMEobV0JoV
         eRzm5Wko6HLUX4d9XcBYgqxzyth1MorVv54hF3Uw61pPr/gDwYUe9qfZYT5wnaDx1icf
         Bp7ifHF+Ej1h8bO7kohMBYinKZRV7FPZ6DUXzOOuJ6t2TtbvVljPXglcs6whSiaJI/Uq
         XeIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759008759; x=1759613559;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SElHc2Lj3Jzq/rwI+TwRKq655LGTP+R5wtY+OIRAOjc=;
        b=NSofPgSJX2V0x7aCjjb0R4tkGS/K/4pzFcTOQ9Urcfy+xvmzGzHAMulfpPOxkc2qE9
         4f3kEUJKIdMko3N3pgdV+Iu5hH2xgCSTV1lerdM7NTDDsPNAgzkUmQxeVYHefg09q0YH
         MNxNHMVIeo0+uen+qW1wihyifk+7/KDUk+H4SezkpbT6lw1m15btL3BkHJ/7na7eD9KQ
         BMaVFjkOAsqcwolLZCxvlafWW5YgO3DXzwg/BVVCk9CNO+mUnZ1fqiPtaF6HC9ri1SDB
         pw07Q5IwAN329ROnkI2N1wg90PiEGMnUdLQXL2oAcO9lfKIPjBNv2mv9YmqlT4igNpe4
         dZNQ==
X-Gm-Message-State: AOJu0YzLYR3oy5SolAKDcCUBhKTAwaANxh5r8g83Q1ZkPFzcXDI5f6HD
	CsPxehSygBRPc/m0XLEOBh1g6dXpzq88dQPo0IYIXBHESADOdC1ek/2yKyVAUjo9U1vnBglD1aQ
	LKZ02wxtj1A==
X-Gm-Gg: ASbGncujAxCQGQg6yrSOfvGaW7y0vgKT5zYYd+o6noapirYK0OTDgT07XmNk+DfSlZq
	oOP9Z9SWgPk9v8igXNaDfUrNJxOdsxczzbPQT41xuknqNQhpis3q1YERUiyXQ9LE9MkzDFR6CKG
	KrJKO6IVlQX0sY5XiDomN3FT7mFindVUr3d379EuD6eS86Oz+4FslPhAI3GchTC7ZZNT6b/uBXt
	OuaXqzcZRqD2TKD+pmjghRZR2NPOBOJCVwvSkGmiwC4RUEs4by0IUaSCCn/7V2j3SWQNgXec02n
	fAa/tpGOrVlNfWA2sbz3GQ3AF+hiN21Vqi2CTTOFFWzEZVsoon8EWIpH9Knu6MCF7hvnO8+6Qan
	O1NrAOE1AIRPv8fDjvG8itdGZ18XNURQpbpzLR5ThVfGAYQmw8lRZo9jVIZW00+ypeS5BVRUdr2
	InvOc8rB/Q/bm/UFSXu3BO9ypwTA==
X-Google-Smtp-Source: AGHT+IFv/SvWIAfjHxMXvm3pCojNC7dZxnAf3qoV8k7BvI0s0aBlSuSinR1hpgATdBaXmpm1QPEb7A==
X-Received: by 2002:a05:690e:4286:20b0:62e:a75a:3944 with SMTP id 956f58d0204a3-636ddd41e48mr4527944d50.1.1759008759146;
        Sat, 27 Sep 2025 14:32:39 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-eb383894125sm2307107276.15.2025.09.27.14.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 14:32:38 -0700 (PDT)
Date: Sat, 27 Sep 2025 17:32:36 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [RFC] How to accellerate the patch flow (or should we?)
Message-ID: <aNhX9AJ/zq4IYhmW@nand.local>
References: <xmqqldm0am4b.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqldm0am4b.fsf@gitster.g>

On Fri, Sep 26, 2025 at 03:24:04PM -0700, Junio C Hamano wrote:
>  4. While the above cycle is running, the maintainer may queue it in
>     'seen', for two purposes.  (1) not to lose sight and forget
>     about the change.  (2) to catch potential conflicts and overlaps
>     with other in-flight topics to keep their interaction manageable.

Perhaps a third purpose is to let the maintainer (or those who use
and/or build off of 'seen' as their daily driver) detect any bugs in
that topic, or via interaction with other topics in 'seen'.

> The time taken during 7. is pretty much fixed and unless we are
> willing to sacrifice the quality of the end result, cannot
> reasonably be shortened (note that this is based on the assumption
> that "find any remaining bugs while it is in 'next' before it hits
> 'master'" philosophy is working, but we have never run experiments
> to shorten this to say 3 days to see if we see more bugs on 'master'
> yet).

I have mixed feelings about this. On the one hand, I am a little
uncomfortable with the idea of shortening the time in 'next' to fewer
than 7 days. I, too, have the feeling that having more time in 'next'
gives us a greater chance of spotting bugs in a topic that is otherwise
destined for 'master'.

On the other hand, how many people are using 'next' as their daily
driver? Of those, how many are actively looking for bugs in the topics
that are in master..next. And of those, how many are actually triggering
unique code paths that would expose those bugs in the first place?

I have a vague recollection that Google internally has their engineers
run a version of Git that is based on 'next'. But after spending a few
minutes searching through the list archives, I can't seem to find any
record of that.

Assuming that Google does provide a large user-base for 'next', I think
we could reasonably experiment with shortening the time that topics cook
in 'next' before graduating, and compare how many bug reports we get.
Otherwise (if Google is not daily-driving 'next'), I think that we could
still run that experiment, but I think it carries somewhat higher risk.

(In either case, if we were to run that experiment, I'd suggest that we
do it towards the beginning of a release cycle. That will give us as
much time as possible to squash any extra bugs that might make it to
'master' without having to quickly revert out topics towards the end of
a cycle.)

> But I wonder if 5. can be accellerated without sacrificing the
> quality of the end result, every time I send out a "ping" e-mail to
> old discussion thread, with "The discussion seems to have petered
> out at this point.  Is everybody happy?"  Either I could have sent
> such "ping"s earlier, or reviewers who were involved in the review
> could have given a positive "oh, this looks good. let's declare a
> victory" sooner.  Of course, from the point of view of distributing
> the load and making the process as parallelized as possible, the
> latter is more preferrable.

I found that this was somewhat burdensome the few times that I have
served as interim-maintainer. I think that too often (and I am guilty of
this myself) reviewers will comment on a handful of patches, and, if
they don't have any blocking feedback, leave it at that when they would
otherwise be happy to see it merged.

I know that we have talked about encouraging more reviewers to give a
"stamp of approval" by responding to the cover letter with an "ack" or
"this looks ready to merge". When that does happen, it's very useful for
the maintainer. But when it doesn't, it leaves the maintainer in an
awkward spot of having to keep track of all pending topics on the list
and how long they have been quiet for.

Maybe tooling could help with this. But I think that we could also push
ourselves to be more proactive through policy changes. What if we
required that (unless the maintainer wants to unilaterally merge a
topic) that at least one other reviewer must give it a positive "ack"
before the maintainer starts merging it down?

(As a side-observation, that matches with my expeirence in how code
review is done at GitHub, where at least one other person must provide
an approving review, as opposed to just not leaving any blocking
feedback.)

That would leave topics which do not have active reviewers in a lurch,
but I think that is sort of the point. Contributors should expect to do
some of the work of making sure their topics get reviewed themselves,
and that shouldn't fall entirely on the maintainer.

>   * cc/promisor-remote-capability: 8 iterations (v1: 2025-04-14,
>     v2: 2025-04-29, v3: 2025-05-19, v4: 2025-06-11, v5: 2025-06-25,
>     v6: 2025-07-21, v7: 2025-07-31, v8: 2025-09-08).
>
>   Past round 4 or so we started seeing fewer reviews if any.  The
>   topic has lived almost since its inception in 'seen' until the last
>   round was merged to 'next' at 367d83c0 (Merge branch
>   'cc/promisor-remote-capability' into next, 2025-09-15).  Again, this
>   last round wasted 7 days in 'seen' without any activity, which I
>   wonder if we could have somehow avoided?

I haven't followed this series closely, but I feel like subjectively
having had my own series get into the v5-and-beyond range, that is
usually a signal that the topic is too complex/large and needs to be
split up. Not a critique of cc/promisor-remote-capability in particular,
just a general observation.

> Opinions and ideas to help topics not to waste too much time waiting
> for step 5. is very much appreciated.  The most radical idea I can
> think if is to introduce two more "maintainers" and any two of them
> can vote to merge a topic in 'seen' to 'next' without waiting for
> the other maintainer, but there may be simpler approaches that do
> not require huge workflow changes.

The best that I can come up with is the above (one or more contributors
must provide a positive "ack" before the maintainer merges a topic, up
to the maintainer's discretion). I think something like the following
would be worth trying:

--- 8< ---
diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 86ca7f6a78a..789febefff8 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -506,7 +506,10 @@ After the list reached a consensus that it is a good idea to apply the
 patch, re-send it with "To:" set to the maintainer{current-maintainer}
 and "cc:" the list{git-ml} for inclusion.  This is especially relevant
 when the maintainer did not heavily participate in the discussion and
-instead left the review to trusted others.
+instead left the review to trusted others.  Patch series must receive
+a positive "ack" from at least one contributor other than the primary
+patch series author in order to begin integrating it, subject to the
+maintainer's discretion.

 Do not forget to add trailers such as `Acked-by:`, `Reviewed-by:` and
 `Tested-by:` lines as necessary to credit people who helped your
--- >8 ---

I am not sure the idea of adding more maintainers is a good one or not.
Since I am not sure exactly what you are envisioning here, I think there
are a couple of cases:

 - There is a quorum of maintainers, who are all collectively
   responsible for building 'jch', 'seen', 'next', and 'master'. Any two
   of them are required to agree to move a topic down in order to do so,
   without needing the other maintainer to weigh in.

 - There are sub-system maintainers who are responsible for their own
   trees, and who send pull requests to the primary maintainer to
   integrate their trees back into the primary maintainer's.

The "quorum of maintainers" idea has a couple of drawbacks. Unless one
maintainer has the special role of being able to unilaterally merge
topics, each topic would require twice as many maintainers as we
currently have in order to merge it down ;-). I could also imagine there
being some coordination overhead between maintainers when shuffling who
is building the integration branches to make sure that topics don't
mysteriously get added or dropped when shuffling between maintainers.

I don't have strong feelings against the idea of having sub-system
maintainers, but I am also skeptical that it will meaningfully speed up
development. For any sub-system that has enough active contributors to
find a suitable sub-system maintainer, it is likely that patches in that
area are already getting reviewed (and hopefully merged) quickly.

It's the areas that don't have enough active contributors to have a
reliable sub-system maintainer that I worry about. Those areas are
already likely struggling to get patches reviewed and merged, but I am
not sure where we would even find a sub-system maintainer for those
areas in the hopes of speeding it up.

I think that last point is an argument in favor of the "must have a
positive 'ack'" rule above. It flips the responsibility of finding
reviewers back onto the contributors, and encourages more people to
become reviewers in new areas. In other words, if a contributor wants to
write patches in a area that traditionally struggles to get timely
reviews, they are incentivized to find and encourage new reviewers to
work in that area, which is a net benefit to the project.

So, I dunno. I guess I had more thoughts about this than I expected to,
but I would be interested in trying either shortening the period topics
cook in 'next', or trying out the "must receive a positive 'ack'" rule.

Thanks,
Taylor
