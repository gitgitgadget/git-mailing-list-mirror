From: demerphq <demerphq@gmail.com>
Subject: Re: Why can't I use git-bisect to find the first *good* commit?
Date: Mon, 28 Mar 2011 20:57:38 +0200
Message-ID: <AANLkTikADLZvN0N==_H47O1vcrap1_Mcf7vW69d5sh0d@mail.gmail.com>
References: <AANLkTinQ0rCw2ydisHra779r6_iSOxqRwOStpJrNbx7h@mail.gmail.com>
	<AANLkTin1QCda9BV+gND1kcXRTZBF7hj3Chce5OkLX2a9@mail.gmail.com>
	<4D909DD1.2050904@viscovery.net>
	<AANLkTinC9Lr9uCTUZSVxVR56+FQm2NGRpPu90fm9OHF5@mail.gmail.com>
	<vpq62r3i1z4.fsf@bauges.imag.fr>
	<AANLkTimT+WN2F-BmQzQrAs3uizHig9cCXDUdc7nQ-vC5@mail.gmail.com>
	<vpqr59r6sg5.fsf@bauges.imag.fr>
	<AANLkTinuH4Ut+jtdqRfFrNeXA6JmBK2i0ddCcz4vV6JC@mail.gmail.com>
	<vpqvcz35cjk.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Andrew Garber <andrew@andrewgarber.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Mar 28 20:57:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4HdJ-0001vp-Sh
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 20:57:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753090Ab1C1S5k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 14:57:40 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:52373 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751432Ab1C1S5k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 14:57:40 -0400
Received: by wwa36 with SMTP id 36so4186723wwa.1
        for <git@vger.kernel.org>; Mon, 28 Mar 2011 11:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=33tRPE8C+XjQbmpJ4TOUQCB5ewdfDD73+PTK4l7oN2Y=;
        b=Mc5ipbndzZzRgSgLJ60rgg45l8YAwdIJl0JuwwPCCUeMMYvny5p2dZ3cuemYgRMTxr
         L0gmG5STJNB0qT0lPYtAwljdWiCU2QmVkQCCmg9HFbo2fXg5ef1gqP4mJb6C9+Q6yey1
         PQxYnAawxj3tgDjH147qA30ARQkFo/QctA5xw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=kdxcaO2SvnA8uCKjtSxuhwxXZgq2637JKXULWiqyobOauyoFQmEPRoN2Bg5fV1ln0I
         1oD1y7Gfa2N7IQYcZGfVKQgVfswtVZYGeb7lhXN+i4d73ne6Fgfz7kI5TA2I7fAq1UIH
         2VqEfCiAf0g63Kc5pSS2Zu9Ezs5W9WcBM7q5A=
Received: by 10.216.166.2 with SMTP id f2mr3006196wel.24.1301338658467; Mon,
 28 Mar 2011 11:57:38 -0700 (PDT)
Received: by 10.216.88.7 with HTTP; Mon, 28 Mar 2011 11:57:38 -0700 (PDT)
In-Reply-To: <vpqvcz35cjk.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170175>

On 28 March 2011 20:23, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:
> Andrew Garber <andrew@andrewgarber.com> writes:
>
>> On Mon, Mar 28, 2011 at 1:55 PM, Matthieu Moy
>> <Matthieu.Moy@grenoble-inp.fr> wrote:
>>
>>> Then which commit do you specify as "good"?
>>
>> Any ancestral commit *on the same branch* which is know to be working.
>
> What is the point is finding manually a commit *on the same branch* when
> the tool can do that for you? You don't know how old the breakage is, so
> finding the first good commit will take some time. Knowing that the
> other branch is good gives you a hint that the common ancestor between
> branches should be good, so a good start would be to find the common
> ancestor.

This doesn't make a lot of sense to me. It is just as likely NOT to be useful.

It could just as easily have been fixed in the other branch. So
knowing its good wont tell you where it was broken.

This started off with:

      o--o--o--B
     /
  --o--o--o--o--G

So lets say that the reality of each node looks like this:

      B--B--B--B*
     /
  --B--B--B--G--G*

How does knowing that G* is good help us find what broke B* again?

Your description matches the case of something like this:

      B--B--B--B*
     /
  --G--G--G--G--G*

But what about something like this:

      Bx--B--B--B*
     /
  --Gz--By--B--Gx--G*

How does knowing that G* is good help you to find that Bx broke the
code in the B* branch again?

Presumably 'By' broke the G* branch which was then fixed by Gx and
none of this information helps you at all identify that Bx broke the
B* branch.

Whereas a plain binary search on the B* branch would eventually find
that Bx was responsible.

>> Perhaps you could give a concrete example of where you could use it
>> for multiple branches simultaneously?
>
> Well, see my previous email.

Where you said "It's not uncommon in real life to face the "it works
in branch foo but
not in branch bar, where did it break?" problem. And one expects a great
tool such as Git to be able to answer it."

Seems to me that this is trying to cram two questions into one:

A) where did branch foo diverge from branch bar and
B) which commit between that ancestor and bar did things break.

Of course im probably missing something important here. Id like to
know what it is tho. :-)

cheers,
Yves

-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
