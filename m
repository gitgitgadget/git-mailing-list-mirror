From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/3] fetch: add --allow-local option
Date: Thu, 16 May 2013 18:07:47 -0500
Message-ID: <CAMP44s2W5MUneTwcSnr=Ey715paKgSL6MqXmYKdSmw4NqdL4qQ@mail.gmail.com>
References: <1368689474-28911-1-git-send-email-felipe.contreras@gmail.com>
	<1368689474-28911-2-git-send-email-felipe.contreras@gmail.com>
	<7v61yi9arl.fsf@alter.siamese.dyndns.org>
	<CAMP44s14TSGtQ7kvWUgrOQvT1uKciSV5fd5pQvy1ven8Z=qVcg@mail.gmail.com>
	<7v8v3e7udi.fsf@alter.siamese.dyndns.org>
	<CAMP44s0Szu8oHBKMapZ6dQ1K67MXDcACuUF-+Y-jC+EgHs2QEA@mail.gmail.com>
	<7vk3my6bu1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 17 01:07:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ud7H8-00072m-4k
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 01:07:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755231Ab3EPXHt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 19:07:49 -0400
Received: from mail-la0-f42.google.com ([209.85.215.42]:48425 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755216Ab3EPXHs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 19:07:48 -0400
Received: by mail-la0-f42.google.com with SMTP id fg20so1358448lab.29
        for <git@vger.kernel.org>; Thu, 16 May 2013 16:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=f3HVb6mjpt79vv2MWgTESNhdRMEgIswueIv4Up+Bs1A=;
        b=QwJoVsW0sqg42a4z1nYa76RKhNPpFq1yq3HP1/yHpiEUYIGdbAqxqMze1+p3FBa0LI
         cDtgNFNQMD/NNH67HME9OOVHUumKDtQhTRixZ3IH+II+aG7oLIFj4jujel4EKV/71kex
         DuAu8p4T132To+Hy+VjUrMLjN7u2Alx2fRRhPbS20ShIFMDxLMjAIyoFCRz3EtIFELGo
         IkR0oV7sho0ef5qXM7qSr3T/AObyYHpn2RWZl5FrtYgRQ/Bn7WFuIT85IDri8LjW5rDb
         NNJhXslAshsi7OqKJoYeI+NN8cOjnLgcbd8M+PRediAW5Wf4hHsG8+1BVYy4iU4hH0hK
         Wmrg==
X-Received: by 10.152.87.69 with SMTP id v5mr21571715laz.24.1368745667346;
 Thu, 16 May 2013 16:07:47 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Thu, 16 May 2013 16:07:47 -0700 (PDT)
In-Reply-To: <7vk3my6bu1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224628>

On Thu, May 16, 2013 at 1:04 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>>> If you come from "git pull" is "git fetch" + "git merge",
>>> and if your current branch is integrating with your local branch,
>>
>> How many times do I have to say that 'git pull' is not 'git fetch' +
>> 'git merge'?
>>
>> You must think everybody has 'merge.defaulttoupstream=true'.
>
> I am confused.  What does that have anything to do with this topic?
> It only affects what a lazy "git merge" (without any other parameter
> on the command line) does, doesn't it?

And that's what we are talking about here; commands without any other
parameter in the command like.

So "git pull $nothing" is *not* "git fetch $nothing" + "git merge $nothing".

> In the above "git fetch" + "git merge", I did not mean "git merge"
> is literally what the command line of the command invoked
> internally.  "git pull" of course chooses what is to be merged.
>
> But that does not change the fact that before merging (or rebasing,
> if you are running "git pull --rebase"), "git fetch" is done in
> order to make sure the history you are merging with (or rebasing on
> top of) is available locally and FETCH_HEAD is prepared so that "git
> pull" can decide what to merge with (or rebase on).

We are not talking about 'git pull .', we are talking about 'git fetch
.', and it doesn't make any sense.

> The merge.defaultToUpstream configuration does not change that, does
> it?

It changes the equation 'git pull' = 'git fetch' + 'git merge'.

-- 
Felipe Contreras
