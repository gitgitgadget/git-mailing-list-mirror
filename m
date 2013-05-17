From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Random thoughts on "upstream"
Date: Fri, 17 May 2013 22:31:13 +0530
Message-ID: <CALkWK0mLtc8dmMPOcLMez1agF1+ZMUDAUwtwmiKSxOCfyiW0Bw@mail.gmail.com>
References: <7vobca6c7r.fsf@alter.siamese.dyndns.org> <CAMP44s2t3+yBQMj9uSd_=3w0CgeJsHeAQM051j7Xt+SqVthvzQ@mail.gmail.com>
 <7vobca3465.fsf@alter.siamese.dyndns.org> <7vzjvu1jes.fsf@alter.siamese.dyndns.org>
 <CALkWK0=rHFQ14G8baYpY7gYo+Qb+5a0qOKZGBTrp6BamKC2vRg@mail.gmail.com> <7vk3mx1rox.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 17 19:01:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdO2Z-00058g-0r
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 19:01:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756293Ab3EQRBz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 13:01:55 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:35784 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755575Ab3EQRBy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 May 2013 13:01:54 -0400
Received: by mail-ie0-f171.google.com with SMTP id e11so9849368iej.30
        for <git@vger.kernel.org>; Fri, 17 May 2013 10:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=LEEVw5wo3xSpxXQ00vH2iBuGHRRu7opr19+OAn1rgXI=;
        b=iYZI+c5/pwAfOItwHnmBpMiG6JfFyQGAl9+xelq5aMvOnYYVRj90k1ogyu9XmEOY8n
         DoOM3eX99E3LtTXVEFqU495F84zQrG+s/GZ6kq9KeK6mm24265KY1jPrRWoG0at89zx0
         nRxVqFBjdy+WmrwxlOmiWjYA6ZGbcqTTzOg0ftK48ADgFEaJV8pTx36N3vjczFYqwYBK
         UFsRG+arJMvDu9TruzKnZlbkEe51ta11yvT03F5KdpNJWkwc1wUzZEL8HfADglPpw0bu
         wWKFKLy6DIExO7PFS/0hazAwt4dpjX/5Ikbu1Il4Nv63tVW5UqEIK4UxoJ+0IZ2Snf5O
         fDrA==
X-Received: by 10.50.33.19 with SMTP id n19mr13595299igi.44.1368810114033;
 Fri, 17 May 2013 10:01:54 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Fri, 17 May 2013 10:01:13 -0700 (PDT)
In-Reply-To: <7vk3mx1rox.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224705>

Junio C Hamano wrote:
> Please clarify the semantics of @{f}.  Does it conceptually refer to
> where the current branch is going to be pushed to (i.e. a pair of
> (<remote>, <ref>))?  Will we have a remote tracking branch for it
> to record what we pushed there the last time?  I am guessing that
> your answers to both of these questions are "Yes", and frotz@{f}
> would resolve to refs/remotes/there/topics/frotz-for-juno in the
> sample set-up in the message you are responding to.

Yes.

>         Side note: I do not think "fork" rings bell to the end
>         users.  Who is forking from what?  I am guessing you are
>         trying to make a short form of "the branch in my public
>         pepository I push this branch to, and other people would
>         consider it my fork of the upstream project", but it is hard
>         to do the reverse, i.e. a new person who is presented a word
>         'fork' to guess that you wanted to refer to the above by
>         that word.

GitHub is an overwhelmingly popular service, and many end-users are
used to clicking on the "Fork" button on various projects to
contribute.  Here, "fork" is short for "my fork".  Do you have a
better name in mind?

> But it has exactly the same issue as branch.<name>.pushremote;
> adding it without having the single "all of my pushes go to here,
> not to 'origin'" would have meant that for N branches you have to
> set the same thing N times.  We fixed it with remote.pushdefault
> before the series graduated.  If you only add branch.<name>.push,
> then people have to configure it N times, for N branches they want
> to push out.

Oh, I'm completely against just adding branch.<name>.push as I've
pointed out on the other thread.  Even in the part you clipped out, I
clearly stated remote.<name>.push above a branch-specific thing in the
priorities.

> Reusing the existing push refspecs was just a suggestion to solve
> that issue, and I am not married to that particular design.  You or
> Felipe may be able to come up with a better alternative to achieve
> the same goal and that is perfectly fine.  I just wanted to make
> sure that we do not force the user to repeatedly set the same thing
> over and over in the common case.

Ofcourse.

> I do not think of a reason why you cannot implement that @{f} with
> the 'single' matching (or its better version you may come up with).
> If "git push" can figure out where it would push to, you certainly
> should be able to borrow that same logic to see what tracking branch
> you are locally using to track the last push result for the current
> branch in response to @{f} request, no?

Ofcourse, I'm not saying it's not possible.

1. Getting @{f} requires extra computation, and that might be ugly/
undesirable/ surprising considering how @{u} doesn't require it.

2. Setting @{f} with branch --set-fork-to won't operate on the
branch.<name> section, and this might be surprising.

3. If remote.<name>.push is only going to be used by the Gerrit
people, @{f} is not going to work anyway.

These issues aren't deal breakers, but are certainly worth mentioning.
 Frankly, I'm not overtly fond of the branch.<name>.push idea, and am
tilting towards this now.  What do you think?
