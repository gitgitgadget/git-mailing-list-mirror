From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [QUERY] Why do we have git-completion.zsh?
Date: Sun, 21 Apr 2013 10:06:05 +0530
Message-ID: <CALkWK0=ay452TbW-O+uBwqqMjLgeYw0V-j67vvzMqtVO-PnrXw@mail.gmail.com>
References: <CALkWK0=NrJ-9mxSkOBw=kJ0CTJLUFNWBoGdqGcHEU6YqR-foFg@mail.gmail.com>
 <20130420184539.GA8586@elie.Belkin> <20130420185329.GB8586@elie.Belkin> <CAMP44s3yCW-pHVHc9WfL1BC7BKmnXxZ1WQyPRAMnx967=74_Kg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 21 06:37:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTm1M-0004Zt-B8
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 06:37:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027Ab3DUEgq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Apr 2013 00:36:46 -0400
Received: from mail-ia0-f179.google.com ([209.85.210.179]:56032 "EHLO
	mail-ia0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750926Ab3DUEgp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Apr 2013 00:36:45 -0400
Received: by mail-ia0-f179.google.com with SMTP id p22so577572iad.38
        for <git@vger.kernel.org>; Sat, 20 Apr 2013 21:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=sC+NDCsEvAFFGgTm9/9rhz7sHMcp6kRtfT/IKxPZxmQ=;
        b=aVkY654/9EKVsNOq7PG/Q/oFsHOYFVhfzBFKSCZc8yGV6Kdv3SQT8yYKJuLablPE0U
         MJyUaswBdiAnLl3bCVRd916jNkV0tsrDdml0mF84XRpujVb5wV2kZ/Yf6wY6r4tiZ8Xj
         hYGdmBWlyweBekeB3fSxFJVqtiOiDGclTIou/GJhcq7w3RExNQ4qATKFDEA+UvuqpYuK
         oPD99jy5+hvjbH4ydhueTtydXNcMNe9UiKnUJnJkDJIyYRXxtMLzOjntBz9qAJ9OQu/6
         FfdaimAGBm5l30vBlV65FtTxAvv5nzBQ0Bh5RrK4yqGeiFNQ2HOBf2uFryi9k+JqvqLA
         CVRA==
X-Received: by 10.42.50.202 with SMTP id b10mr10827791icg.7.1366519005274;
 Sat, 20 Apr 2013 21:36:45 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Sat, 20 Apr 2013 21:36:05 -0700 (PDT)
In-Reply-To: <CAMP44s3yCW-pHVHc9WfL1BC7BKmnXxZ1WQyPRAMnx967=74_Kg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221890>

Felipe Contreras wrote:
> To complement the reason; the zsh folks (or perhaps it's only one; who
> works on the git stuff), absolutely prioritize "correctness" over
> speed, that means if it takes ten seconds to list all the possible
> files to complete, grouped nicely, that's exactly what they'll do,
> instead of the way the bash completion does, which lists the most
> likely files, which takes milliseconds.

I see.  Yes, I was looking for a reason like this.

True.  I've noticed that my shell just hangs when I attempt to
tab-complete too early/ something wrong, and this would be nice to
fix.  Does it have to be a hard trade-off between correctness and
speed?  Is it not possible to reach a fair compromise?

Now, I don't know anything about zsh's git completer versus the
gitfast completer.  From a glance, it looks like zsh's git completer
is much larger and stuffed with features that the gitfast completer
doesn't have.  Although I agree that speed isn't the only parameter,
can you shed some light on how these two compare on other parameters?

Or you could help me figure all this out myself.  How do I
profile/debug shell code?  I'm feeling a little lost without gdb and
valgrind.

> And I'm not the only one, when I contributed this stuff to
> oh-my-zsh[1] I got a very positive response.

Found it: https://github.com/robbyrussell/oh-my-zsh/commit/5a11228

> If they wanted my contributions, that would be awesome, but that
> doesn't appear to be the case. And I'm kind of relieved, because zsh's
> completion is monstrous code, and the zsh development practices are
> not good (e.g. all my logically independent patches get squashed into
> one commit).

I see.  I've just started poking them with patches.  I'll see what
happens for myself.

Cheers.
