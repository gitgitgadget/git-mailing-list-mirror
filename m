From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Sun, 7 Apr 2013 12:57:14 +0530
Message-ID: <CALkWK0n64BW8zQXweR38T6DjT+iYBbsZDPCLZ-4igqGJHoFwKw@mail.gmail.com>
References: <1365100243-13676-1-git-send-email-artagnon@gmail.com>
 <CALkWK0mM9HBUvHGHPEw4Vdosp_qfu_1L49TaZrzdC5n3soWkYg@mail.gmail.com> <7v61zz9fu3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 07 09:28:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOk1A-00048X-Qv
	for gcvg-git-2@plane.gmane.org; Sun, 07 Apr 2013 09:28:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757562Ab3DGH14 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 03:27:56 -0400
Received: from mail-bk0-f41.google.com ([209.85.214.41]:65341 "EHLO
	mail-bk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755744Ab3DGH1z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 03:27:55 -0400
Received: by mail-bk0-f41.google.com with SMTP id i18so2661245bkv.0
        for <git@vger.kernel.org>; Sun, 07 Apr 2013 00:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=bBPmwc+nZFN6NocI7ALH+UUT2GQJt4Xo11vIp2t8atw=;
        b=sZQGWzbAaEBFM1+clnUXcjSjDzHhR67TNeVGk0JPDc3JrsPZ/g0qVgYyg1DaLXzpVQ
         Hgy9uabwxfz6eFZVX+KWuwEBX3YcECOje2REZoDmEnK9tFIA4Isvl29Y2iXV/Ex76ahG
         zped06QQY8/q4eITxPjG+ZSX+WBqLltUU6Oac9ZQxJCVCUOB0OuYhcU/9KVPpPDrpjw3
         7GzjD8HZauYEuWcUQGg1CHssAi7hZ8CvLvfynmUMHwC2ppldCYI1KvVyQ96+bH1ENWxO
         qBJ/viBRlEheIXqH1b+kwLPIsq9Tt5lhZZjc3p99ejYwDF4qUwqbG4o0vgsZd0rC+0ZN
         M9jA==
X-Received: by 10.204.98.77 with SMTP id p13mr648719bkn.86.1365319674223; Sun,
 07 Apr 2013 00:27:54 -0700 (PDT)
Received: by 10.204.237.65 with HTTP; Sun, 7 Apr 2013 00:27:14 -0700 (PDT)
In-Reply-To: <7v61zz9fu3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220288>

Junio C Hamano wrote:
> I think it is too premature to discuss _your_ code.  The patches do
> not even tell us anything about how much more work is needed to
> merely make Git with your patches work properly again.  For one
> thing, I suspect that you won't even be able to repack a repository
> that has OBJ_LINK only with the patches you posted.

Let me try to rephrase my original request: I'm an inexperienced
contributor trying to do something very ambitious.  Having authored a
huge part of it, Linus and you understand git-core much better than I
can ever hope to understand.  These are things that you need to tell
me after reading the patches.  I only have a rough idea to make Git
work properly with my patches again: I can't know for sure until I
write all the code.  What's more?  Your guess will probably be better
than mine after you read the code.

You're asking me to submit a perfect 40 or 50 part series that's a
potential candidate for merging.  I'm sorry to say this, but I'm
incapable of doing that without posting intermediate work and getting
help.  Frankly, it's a very unreasonable expectation; I don't think
anyone except you or Linus can even get close after making such a
fundamental change.

I might end up writing all the code (which I'm perfectly okay with),
and all I'm asking from you is to constantly keep picking my brain (by
reviewing my code and posting good critiques).  Am I being
unreasonable?

> At this point the only thing that we can gain from reading your
> patch is that you can write C to do _something_, but that something
> is so fuzzily explained that we do not know what to make of that
> knowledge that you write good (or bad, we don't know) C.

C is irrelevant here: I'm not asking you for style/ structuring tips;
I'm asking you for a critique on the implementation of this idea.
Linus raised some good points after reading [0/7] that I countered,
and there isn't anything else either anyone can raise without reading
more.  Code speaks more clearly than the English in [0/7]: you should
be able to deduce a lot more intent and direction.

> It would be much more productive to learn what these specific issues
> X, Y and Z are, and if the problems you are having with existing
> solutions are really fundamental that need changes to object layer
> to solve.

To reiterate: link does not make possible something that is not
fundamentally _possible_ with a .githack and a 100k-line Perl script.
At its core, every variant of submodules does this.  What I'm
essentially proposing: break up the information in .githack into
smaller bits and create a new object type so it can be parsed by
git-core easily.  If you agree that my proposal doesn't make
impossible what was possible earlier, and that it makes life easier
for everyone, we should be good to go.

When the series matures, we can investigate the other implementations
in greater detail so we can pick out more optional fields to add to
the link object before getting it merged.  This is not the right time
to do that: we're currently trying to get git-core working with the
mandatory fields.

> I do not think we have heard anything concrete and usable about what
> you are trying to achieve yet.

I'll try to rephrase your concerns here:

0. We don't know if this approach will yield a mergeable series at
all, because it breaks so many things and is so difficult to complete.

1. We don't know how much work is needed to bring the series to a
point where it is in a mergeable state.  There is no timeline
specified.

2. We can't build an exhaustive list of the problems that this new
approach will solve (ie. we haven't finalized the optional fields).

3. We don't have anything useable yet.

And your non-concerns should be:

1. We know that this approach won't fundamentally limit us in not
being able to solve some specific problems that the .githack approach
solves.

2. We know that this approach makes life easier for everyone, and
there are significant concrete benefits to teaching git-core about
links.

I agree with all this fully.  I don't have a concrete roadmap; we'll
just have to dive in based on what we've seen so far, and hope that
we're able to finish what we started.  So, my final question is: are
you still not convinced that this approach shows a lot of potential,
and is worth exploring now?
