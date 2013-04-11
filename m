From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/2] transport-helper: report errors properly
Date: Thu, 11 Apr 2013 12:57:34 -0500
Message-ID: <CAMP44s1KgpT5YGwAr2KAToaoB6rUmtM3ocA-OtFSGfOzudx5RA@mail.gmail.com>
References: <20130410211311.GA24277@sigill.intra.peff.net>
	<20130410211552.GA3256@sigill.intra.peff.net>
	<CAMP44s02K5ydKLNi0umMkuAicoVTWyCdVfjs0yssCa2oyFShGQ@mail.gmail.com>
	<20130411161845.GA665@sigill.intra.peff.net>
	<CAMP44s2-4i_tSzz8Y88_YnK5d1AjNoTqOa7eXZ0W5Vzk9Uosng@mail.gmail.com>
	<20130411165937.GA1255@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 11 19:57:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQLkk-00030s-TQ
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 19:57:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161312Ab3DKR5h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 13:57:37 -0400
Received: from mail-lb0-f179.google.com ([209.85.217.179]:37862 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161205Ab3DKR5f (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 13:57:35 -0400
Received: by mail-lb0-f179.google.com with SMTP id t1so1831765lbd.24
        for <git@vger.kernel.org>; Thu, 11 Apr 2013 10:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=9kmzKqLsIJa1iSFhPR6RN5g+j8DD/0Js/4jl8X5Swhg=;
        b=0OL8pUIaAxYK/U/VglTMIAjFVhdOYP13QQS9kWScoA9suwxz+vf4fVrvzF8TrR01v6
         IC2SHtB6DQ/BGNy7KEwnZRAbXxyiqT+oQwgKwTCzmFEfJIQ2sbMMfsgLNYKmFyef+I8n
         LMsWI90uWW2Id6Sklu7BbLtHXivs8V0gWhdUsKiDY8OXvVpOtdXg9nOBuxFh96ACnYgV
         EXGDTVXuebzCxCZvlBvP/WBmx4ebKafl137zbqhQDjZ4v2cNFf2tFw1O4xTRmKRWjhPI
         zC7ntqHJnMX4ZislgSSp4t9Od6+C50r68hQSe9YxpB4ZCtCyPsaT9gTHxAgkmdM6gIf2
         PLBA==
X-Received: by 10.112.163.6 with SMTP id ye6mr3778611lbb.59.1365703054155;
 Thu, 11 Apr 2013 10:57:34 -0700 (PDT)
Received: by 10.114.59.210 with HTTP; Thu, 11 Apr 2013 10:57:34 -0700 (PDT)
In-Reply-To: <20130411165937.GA1255@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220901>

On Thu, Apr 11, 2013 at 11:59 AM, Jeff King <peff@peff.net> wrote:
> On Thu, Apr 11, 2013 at 11:49:11AM -0500, Felipe Contreras wrote:
>
>> > I am OK with adding the test for import as a separate patch. What I am
>> > not OK with (and this goes for the rest of the commit message, too) is
>> > failing to explain any back-story at all for why the change is done in
>> > the way it is.
>> >
>> > _You_ may understand it _right now_, but that is not the primary
>> > audience of the message. The primary audience is somebody else a year
>> > from now who is wondering why this patch was done the way it was.
>>
>> Who would be this person? Somebody who wonders why this test is using
>> "feature done"? I doubt such a person would exist, as using this
>> feature is standard, as can be seen below this chunk. *If* the test
>> was *not* using this "feature done", *then* sure, an explanation would
>> be needed.
>
> If it was so obvious, why did your initial patch not use "feature done"?

Because I didn't want to test the obvious, I wanted to test something else.

> If it was so obvious, why did our email discussion go back and forth so
> many times before arriving at this patch?

This patch has absolutely nothing to do with that, in fact, forget
about it, such a minor check is not worth this time and effort:
http://article.gmane.org/gmane.comp.version-control.git/220899

> It was certainly not obvious to me when this email thread started. So in
> response to your question: *I* am that person. I was him two weeks ago,
> and there is a good chance that I will be him a year from now.

No, you are not. I didn't send a patch with "feature done" originally,
the only reason you wondered about the patch with "feature done" is
that you saw one without it. It will _never_ happen again.

> Much of
> my work on git is spent tracking down bugs in older code, and those
> commit messages are extremely valuable to me in understanding what
> happened at the time.

Lets make a bet. Let's push the simpler version, and when you hit this
commit message retrospectively and find that you don't understand what
is happening, I loose, and I will forever accept verbose commit
messages. It will never happen.

> But I give up on you. I find most of your commit messages lacking in
> details and motivation, making assumptions that the reader is as
> familiar with the code when reading the commit as you are when you wrote
> it. I tried to help by suggesting in review that you elaborate. That
> didn't work. So I tried to help by writing the text myself. But clearly
> I am not going to convince you that it is valuable, even if it requires
> no work at all from you, so I have nothing else to say on the matter.

Me neither. I picked your solution, but that's not enough, you
*always* want me to do EXACTLY what you want, and never argue back.

It's not going to happen. There's nothing wrong with disagreeing.

Cheers.

--
Felipe Contreras
