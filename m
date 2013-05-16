From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/3] fetch: add --allow-local option
Date: Thu, 16 May 2013 11:52:53 -0500
Message-ID: <CAMP44s0Szu8oHBKMapZ6dQ1K67MXDcACuUF-+Y-jC+EgHs2QEA@mail.gmail.com>
References: <1368689474-28911-1-git-send-email-felipe.contreras@gmail.com>
	<1368689474-28911-2-git-send-email-felipe.contreras@gmail.com>
	<7v61yi9arl.fsf@alter.siamese.dyndns.org>
	<CAMP44s14TSGtQ7kvWUgrOQvT1uKciSV5fd5pQvy1ven8Z=qVcg@mail.gmail.com>
	<7v8v3e7udi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 16 18:53:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ud1QM-00065h-Ll
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 18:53:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752323Ab3EPQw6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 12:52:58 -0400
Received: from mail-lb0-f181.google.com ([209.85.217.181]:52473 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751033Ab3EPQw6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 12:52:58 -0400
Received: by mail-lb0-f181.google.com with SMTP id w20so2974883lbh.40
        for <git@vger.kernel.org>; Thu, 16 May 2013 09:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=UfrQE4BsaCDue6phDEPnBKgjIxhfppFagjLmLMWWINs=;
        b=JD8D/M5gg97eiGmiHSuPUCV7eKslf6bj5XQJrXcOiL5vmvNZyy5lpeZyIHa5o5Klzd
         xkmp3F/Q7gZf+peDT9r/D0rmTMw+SCDWLUEBzECYAh+F5QvqqJy1bRla84FPfaewzIDA
         wHv96jM9eO7umsjKBDCKmeurUsjTb7cSahF306K+p9oZnFcgIpWDQWOhbZDg2OgnHpZo
         3BhN6BW38fzNTZALty1bOzz49Yt5mfXNUH1mhzroA0ZNNopdQNcaHYqAjo5xUN+zJ/zC
         mP0+HRFxjW1ZQHfJDUn06wxaUH58I+R6D4KhT1a2t3dnQlFcjgJrqjfKEW0moI6t67T5
         cAmw==
X-Received: by 10.112.135.70 with SMTP id pq6mr20584396lbb.82.1368723174095;
 Thu, 16 May 2013 09:52:54 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Thu, 16 May 2013 09:52:53 -0700 (PDT)
In-Reply-To: <7v8v3e7udi.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224601>

On Thu, May 16, 2013 at 11:38 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> That doesn't change the fact that 'git fetch .' does not make any
>> sense whatsoever. The user *will* get confused when (s)he does 'git
>> fetch' and nothing happens. The problem is not solved.
>>
>> % git checkout -b fixes master
>> % git fetch
>> % git branch -u master
>> % git fetch
>>
>> # scratch head
>
> # reads manual, perhaps?

You expect too much from users. But...

% man git push
/default

Nothing.

> Why do you declare without justification that "git fetch ." does not
> make sense?

What does 'git fetch .' do?

> If you come from "git pull" is "git fetch" + "git merge",
> and if your current branch is integrating with your local branch,

How many times do I have to say that 'git pull' is not 'git fetch' +
'git merge'?

You must think everybody has 'merge.defaulttoupstream=true'.

> it
> is natural that "git fetch" that does not say where to fetch from
> fetches from your local repository (object-transfer wise, it is a
> no-op) and update FETCH_HEAD.  You can say "it is not necessary, as
> we can directly go to @{u}", but that is different from "it does not
> make any sense".

It literally does not make any sense. From the point of view of the
typical user it does nothing.

> I think the real cause of the problem is that some people advocate
> the use of "git fetch" that does not say "from where" and "get
> what".  When the user understand what it does and what it does it
> for, not having to type is a convenience, but as a recipe to be
> blindly followed, it leaves the new people in the dark.

That's totally irrelevant. Whether the user knows all the details or
not doesn't matter. Typing less is good, and it's important that
commands without arguments do something sane, and 'git fetch' doesn't.
The user should not be forced to type the remote when it's not
necessary, and wasting the 'git fetch' command to do absolutely
nothing is not smart.

-- 
Felipe Contreras
