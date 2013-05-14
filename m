From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 00/10] remote-hg: fixes and cleanups
Date: Tue, 14 May 2013 15:02:26 -0500
Message-ID: <CAMP44s2cOg5xs1ZSmyL+0GDmuWTyn6CRtgsV0q4w=-CCfoYAYQ@mail.gmail.com>
References: <1368486720-2716-1-git-send-email-felipe.contreras@gmail.com>
	<7vfvxql66j.fsf@alter.siamese.dyndns.org>
	<CAMP44s134n9az4anLAnNH6DLT92kAJjW3_rYUx1hGZJ6ECWAYA@mail.gmail.com>
	<7vhai5juc9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 14 22:02:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcLQf-0001qU-Az
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 22:02:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757963Ab3ENUC2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 16:02:28 -0400
Received: from mail-la0-f49.google.com ([209.85.215.49]:40475 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755376Ab3ENUC2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 16:02:28 -0400
Received: by mail-la0-f49.google.com with SMTP id fp13so355126lab.22
        for <git@vger.kernel.org>; Tue, 14 May 2013 13:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=ftalsNuiR41ywDeBcMmDJENwfA5VsIcXLrPnn5A5/pg=;
        b=k9mAZ3besGo7DSuRkP/v8S9cAUZcL3XNZ2ZOjJ7KTezyBAjLST9G+nBcRBucXVhMMg
         dso98/nyxnQGAAnzpMXlpNuLvO4ubbWPEhTAKACGCftnfOhJVp8hczwDtMX6p4daANV6
         5w2cGe7TEV2Apyz2wG+GobSww0v8arlDd8lSSQX7KwomzLw7qO9APgLguVFBNlsy1oTX
         ASzHvKiHz6Su2oZC004343+XQjIC+WLYMX/90vWwW9i4Ci+s6udaobS1IYj3SSY83onn
         l1H/yak91lk2SIBTenBQZFanl3OslhZzAkJq/0he1DXV6o+UR4PsIP//5WDDFGqZYaTD
         PUeQ==
X-Received: by 10.112.135.70 with SMTP id pq6mr16222390lbb.82.1368561746717;
 Tue, 14 May 2013 13:02:26 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Tue, 14 May 2013 13:02:26 -0700 (PDT)
In-Reply-To: <7vhai5juc9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224329>

On Tue, May 14, 2013 at 1:21 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Mon, May 13, 2013 at 8:08 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> And others, please spend time on testing the 1.8.3-rc2 to make sure
>>> what we are going to ship is free of embarrassing regressions.
>>
>> The whole purpose of this series is to avoid regressions, that's why I
>> sent them for 1.8.3.
>
> We agreed to make an exception to let remote-bzr updates go in even
> after v1.8.3-rc1, because it is too young and you can afford to
> check that the updated code will give only gains to its userbase
> that matters without hurting them by checking with Emacs and other
> projects.
>
> I do not recall us doing a similar exception for remote-hg.  Did we?

The exception was for massive changes, theses are not massive changes,
they are no-brainer fixes that would possibly fix regressions.

> If we didn't, then a 10-patch series at this point in the cycle is
> way too late for me to be comfortable taking.

Well, don't blame me if users hit regressions then.

> We merged the 21-patch remote-hg series from you on Apr 21st, a week
> before -rc0, and it has been 3 weeks.  Back then you thought it made
> things better without regression, and I expected that loose ends
> could be fixed by -rc1 with enough time to cook them in 'next'
> (meaning tying such loose ends would be just the matter of a couple
> of trivial patches at most).  But now you are saying they regress
> things and need 6 (in 'next') + 10 + 47 patches to fix on top, in
> order not to hurt existing users?
>
> What is going on?

No, I sent *four* patches for 'master', which I eventually increased
to ten, because the increased ones are all simple cleanups.

And the fixes are obvious and can't possibly introduce regressions,
specially since the important change re-introduces the same behavior
we had in v1.8.2.

The 47 patches I sent are for 'next', and are clearly marked as so. I
included the same 10 fixes I sent for 'master', because they never
landed on master.

> People make mistakes and the initial submission being buggy is *not*
> a problem per-se, but what quality assurance do the 10-patch and/or
> the follow up 47-patch series have over these 21 patches to assure
> us that they do not introduce more problems, when we are this close
> to the final, way less than the 3 weeks we had?

Read the patches and you would see.

> The best we could do to avoid regressions (if there are reported
> ones) is to revert specific changes that cause the regression that
> are already in v1.8.3-rc2.  Which one(s) should we be reverting, and
> do you have a regression report that says the commit(s) in question
> breaks things for a specific project, and reverting it(them) makes
> things work again?

I am going to go one by one to show you the patches make sense for 'master'.

-- 
Felipe Contreras
