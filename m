From: John Szakmeister <john@szakmeister.net>
Subject: Re: [PATCH v3] build: add default aliases
Date: Tue, 24 Sep 2013 15:30:12 -0400
Message-ID: <CAEBDL5Xa2C_zXdaE+Db9Rh7o_xyF6gC-72_Nxb0u5_o4ACjuFw@mail.gmail.com>
References: <1379791221-29925-1-git-send-email-felipe.contreras@gmail.com>
	<20130924045325.GD2766@sigill.intra.peff.net>
	<20130924183958.GK9464@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 24 21:30:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOYJj-00020k-Cq
	for gcvg-git-2@plane.gmane.org; Tue, 24 Sep 2013 21:30:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754297Ab3IXTaP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Sep 2013 15:30:15 -0400
Received: from mail-we0-f172.google.com ([74.125.82.172]:46336 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754133Ab3IXTaN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Sep 2013 15:30:13 -0400
Received: by mail-we0-f172.google.com with SMTP id w61so5167687wes.3
        for <git@vger.kernel.org>; Tue, 24 Sep 2013 12:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=fLhv6AinYnL/8QkokwxHFBpPWSath7FSGRhfcZ5O1KE=;
        b=r4TcriNRZI/cpOINqe/G+LTY54TLkA103Ej/Sn17OB0b9lYvKG+9+/lNt7Gj35dSAW
         zLUxTisCylRENyBZjLvt+BGz6jioqDPOf6X1cOKfgWFhyGktKJbL4HKzv6C4aGybG1SB
         JABrocAGeW5IecYuXYuPq0lfCdWWpxNmNjD2dW4HWlBdaUyiwDXi25e91WORnrRrMxSs
         EAo9P0ic3aLerPRACB0uFqZpWie5xfEHN87sH7x7goF2QcxjX0HylK7kX3fIc4C5s8uF
         DDQFmZ2UY9qRy5ED+yJwtWpYqSgoK8VQffyfvuKdBxFwqWW/DEa+qjlXP3NMqEnlJ5GH
         HOIQ==
X-Received: by 10.180.20.13 with SMTP id j13mr19343284wie.6.1380051012449;
 Tue, 24 Sep 2013 12:30:12 -0700 (PDT)
Received: by 10.180.228.42 with HTTP; Tue, 24 Sep 2013 12:30:12 -0700 (PDT)
In-Reply-To: <20130924183958.GK9464@google.com>
X-Google-Sender-Auth: Tx0TRFlEdXatjHXEZtupbZ6GssU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235310>

On Tue, Sep 24, 2013 at 2:39 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
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
>
> It would be a different story if this were a patch to update
> documentation to suggest adding such aliases at the same time as
> telling Git what your name is.  The user manual doesn't explain how to
> set up aliases at all yet, and that should be fixed.

Yes, better documentation around aliases would be a good idea.

> But making 'ci' a synonym of another command by default while still
> keeping its definition configurable would be doing people a
> disservice, I fear.  As long as 'ci' works out of the box, it will
> start showing up in examples and used in suggestions over IRC, etc,
> which is great.  Unfortunately that means that anyone who has 'ci'
> defined to mean something different can no longer use those examples,
> that advice from IRC, and so on.  So in the world where 'ci' is a
> synonym for 'commit' by default, while people still *can* redefine
> 'ci' to include whatever options they like (e.g., "-a"), actually
> carrying out such a personal customization is asking for trouble.

I'm not sure I agree.  Yes, if someone has configured their shortcut
differently, they may not be able to use the example exactly.  OTOH,
shells have aliases, and while there are sometimes problems, I think
most people overcome them.  I don't see the situation being very
different here.

FWIW, I'm not overly convinced one way or another.  What I can say is,
in the circles I run in, I can only think of one person has gone
without setting up aliases to commit (ci), status (st), and checkout
(co).  The full names are simply to long for day-to-day usage.

-John
