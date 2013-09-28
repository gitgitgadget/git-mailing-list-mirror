From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3] build: add default aliases
Date: Sat, 28 Sep 2013 17:41:41 -0500
Message-ID: <CAMP44s0UcP5AhWrm7vjBDLvY6CupzL03kys1YXs9cpGJNxkBBA@mail.gmail.com>
References: <1379791221-29925-1-git-send-email-felipe.contreras@gmail.com>
	<20130924045325.GD2766@sigill.intra.peff.net>
	<20130924183958.GK9464@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	David Aguilar <davvid@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 29 00:41:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQ3Cx-0000St-0d
	for gcvg-git-2@plane.gmane.org; Sun, 29 Sep 2013 00:41:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755193Ab3I1Wlp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Sep 2013 18:41:45 -0400
Received: from mail-la0-f54.google.com ([209.85.215.54]:53551 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755153Ab3I1Wln (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Sep 2013 18:41:43 -0400
Received: by mail-la0-f54.google.com with SMTP id ea20so3288930lab.13
        for <git@vger.kernel.org>; Sat, 28 Sep 2013 15:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=QfHPIXJuYEIESDYYCSKPqty8jaMM0gFWqSGAVZmBp1s=;
        b=Q9y4j4xMB+P2uSfM0KeRLDdMPPrhhLSu67uViw/qOZdbm+/bJABYIO316ZF5T6aXDO
         TXidScd3/x7jqBxVBY0Au9W12Cc2lpsImLYBPRXHbJn6NXi16s0Gxv75PPEWFKhc9U22
         m8gb0bbJApM4FhB4cSQpWAJrr68EvEn7Qjkztcn3IyuUi2Gvk3kwVEfzotjkWAneIN2I
         rDKnVRZ3suDLkOHLU6hscRgXd35PVx5eyACRK63hz40I6+BjXcHWNZ6grivTgBrqTq0t
         bqXn3SkLDV3QIAKvyaeYYftZPb8/fmxztkZlHZjp2WomGI8+xntWmau9z+VO++PklasC
         OMHw==
X-Received: by 10.152.88.74 with SMTP id be10mr12494709lab.4.1380408102019;
 Sat, 28 Sep 2013 15:41:42 -0700 (PDT)
Received: by 10.114.91.230 with HTTP; Sat, 28 Sep 2013 15:41:41 -0700 (PDT)
In-Reply-To: <20130924183958.GK9464@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235565>

On Tue, Sep 24, 2013 at 1:39 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Jeff King wrote:
>> On Sat, Sep 21, 2013 at 02:20:21PM -0500, Felipe Contreras wrote:
>
>>> For now simply add a few common aliases.
>>>
>>>   co = checkout
>>>   ci = commit
>>>   rb = rebase
>>>   st = status
>>
>> Are these the best definitions of those shortcuts? It seems[1] that some
>> people define "ci" as "commit -a", and some people define "st" as
>> "status -s" or even "status -sb".
>
> I feel bad about having waited for 4 rounds of this patch to say this,
> but the basic change (providing "co", "ci", etc. as aliases by
> default) does not look well thought through.

To you.

> It would be a different story if this were a patch to update
> documentation to suggest adding such aliases at the same time as
> telling Git what your name is.  The user manual doesn't explain how to
> set up aliases at all yet, and that should be fixed.

That's a completely different subject.

> But making 'ci' a synonym of another command by default while still
> keeping its definition configurable would be doing people a
> disservice, I fear.

And I and many (most) users disagree.

> As long as 'ci' works out of the box, it will
> start showing up in examples and used in suggestions over IRC, etc,
> which is great.

It might, or...

> Unfortunately that means that anyone who has 'ci'
> defined to mean something different can no longer use those examples,
> that advice from IRC, and so on.  So in the world where 'ci' is a
> synonym for 'commit' by default, while people still *can* redefine
> 'ci' to include whatever options they like (e.g., "-a"), actually
> carrying out such a personal customization is asking for trouble.

Precisely for this reason it might not. If people know aliases can be
different in different machines, they would avoid them in
documentation which is meant for all machines.

If you truly want to be pedantic, you could add a warning if the
default alias is not used, and this warning gets silenced if the user
configures the alias manually.

> Incidentally, that is also the reason git already doesn't allow
> aliases to override built-in commands such as "git commit", even
> though it would be convenient to some to not have to remember to add
> "-a" each time.  As consolation we have been able to say "But you can
> take the even shorter-and-sweeter 'git ci' and make it mean whatever
> you want".  Now we should take that avenue away for people?

Who is taking away that avenue? Certainly not this patch.

> Bad idea.

Only if you assume your hypothesis is a fact, which is not, and even
if you do, it's still not.

> Hope that helps,

The project? No, it doesn't. Virtually every VCS out there has default aliases,
and Git somehow cannot manage to get them done.

And BTW, look what I can do in mercurial:

.hgrc
---
[alias]
status = status --all
---

OMG! The world is going to end! No, it's not, it's no problem. What you think
is so clearly a bad idea, seems to be doing just fine in Mercurial.

-- 
Felipe Contreras
