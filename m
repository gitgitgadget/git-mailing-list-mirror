From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: What's in a name? Let's use a (uuid,name,email) triplet
Date: Thu, 18 Mar 2010 19:12:02 -0400
Message-ID: <9e4733911003181612m217e805cl95888b4eb0d36a18@mail.gmail.com>
References: <alpine.LFD.2.00.1003181022040.18017@i5.linux-foundation.org>
	 <4ba2293f.c5c2f10a.5e9c.5c4a@mx.google.com>
	 <4ba27424.9804cc0a.4b1f.11b1@mx.google.com>
	 <20100318204416.GM8256@thunk.org>
	 <b4087cc51003181412s78d153c8t48984eb87eb75e0e@mail.gmail.com>
	 <alpine.LFD.2.00.1003181411400.18017@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Witten <mfwitten@gmail.com>, tytso@mit.edu,
	Nicolas Pitre <nico@fluxnic.net>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Wincent Colaiuta <win@wincent.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Mar 19 00:12:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsOsw-0007n6-EP
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 00:12:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421Ab0CRXMI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Mar 2010 19:12:08 -0400
Received: from mail-qy0-f182.google.com ([209.85.221.182]:52615 "EHLO
	mail-qy0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751000Ab0CRXMG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Mar 2010 19:12:06 -0400
X-Greylist: delayed 14119 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Mar 2010 19:12:06 EDT
Received: by qyk12 with SMTP id 12so604160qyk.5
        for <git@vger.kernel.org>; Thu, 18 Mar 2010 16:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=K05kibcoflXaW0kxJ1hVe5My84v8Sqkd4eRevJGAsVo=;
        b=aUl33sDdHCwwGCw4P4C02Eb+Gbnl7C3HHPWvrvSQp+Nos95Zvk+GHpulOsjtCrydpY
         ScUk5OontrrgSWHcxvxeHz2D2qSuzl9lGki6bgp061hG7/4dhbjNsAmcEYCBYW0koVPY
         zX7Rggbyx4iOs9FFKUFzLkWvR2h1XXnPXpnPA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=kaAAFlbD/FnEkOQexXnyN84Ka6YvHvUcFUHRGKpII98tctN5exQ+xt1jjt0Yg05a8W
         y0qDGifgUZo8CRRg43FTyF53t/IX/Ia4FgM6vL0oMYrMYMS3clprJja46wYg99+HQrwz
         SoWXAbyC/p+Yz5nZ/1fq4X7nwco82eATKUBa0=
Received: by 10.224.59.134 with SMTP id l6mr991582qah.224.1268953922800; Thu, 
	18 Mar 2010 16:12:02 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1003181411400.18017@i5.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142533>

On Thu, Mar 18, 2010 at 5:27 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>
> On Thu, 18 Mar 2010, Michael Witten wrote:
>>
>> This is all that I'm saying: Keep git exactly the way it is, but add
>> one extra piece of identifying information for each person.
>
> The thing is, you don't seem to realize that most authorship is over
> email.
>
> Let's take some numbers from the kernel archive, for example. Here's =
_one_
> trivial way to count it:
>
> =A0- number of commits where author/committer email matches (presumab=
ly
> =A0 _not_ emailed, although sometimes people commit their own patches=
 that
> =A0 were emailed around):
>
> =A0 =A0 =A0 =A0[torvalds@i5 linux]$ git log --no-merges "--pretty=3Df=
ormat:%h-%ae%n%h-%ce" | uniq -d | wc
> =A0 =A0 =A0 =A0 =A033473 =A0 33473 =A0959167
>
> =A0- total number of commits:
>
> =A0 =A0 =A0 =A0[torvalds@i5 linux]$ git rev-list --no-merges HEAD | w=
c
> =A0 =A0 =A0 =A0 176415 =A0176415 7233015
>
> IOW, less than a fifth of the patches were done by the person who act=
ually
> committed things. 80%+ of all changes were committed by somebody else=
 than
> the author.
>
> How do you think the authorship information can be transferred sanely=
,
> considering that the author didn't even use git in the first place?
> Really?
>
> That's where the typos/mistakes/missing-info really happens. And it o=
ften
> starts out with incomplete information, because the person has a bad =
email
> setup, and the thing only has an email address to begin with, ie the
> "From:" might literally say just "tytso@mit.edu" or something (to pic=
k an
> example from the Cc list in this discussion - when Ted sends real ema=
ils,
> they tend to have proper naming).

If I recall correctly the top source of errors is variations in the
domain name of the email address. Second place was mangling of names
from non-ASCII charsets. Third place was human typos. Fourth was
inconsistency in the human name, like Ted's example.

A really simple check would be for git to say - I've never seen this
name/email combo before, are you sure it is correct before I commit
it.

PS - I am not in favor of the UUID scheme.

>
> Sometimes we'll edit the messages to have the "From: xyz <abc>" thing=
 at
> the top, fixing up the incomplete thing then. Typos happen there. Or =
the
> patch will simply come in two different ways, so there's no typo, yet
> there are two different emails that get author attribution.
>
> The thing is, development really is about human interaction. Yes, the=
re's
> a tool involved (git), and once the data is in the tool we won't lose=
 it
> any more, but this is about getting the data _into_ the tool in the f=
irst
> place.
>
> And the data you want to add simply DOES NOT EXIST. And we can't make=
 it
> exist. The fact that even the trivial and obvious data that git _does=
_ ask
> for gets to be incomplete should tell you something.
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Linus
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
Jon Smirl
jonsmirl@gmail.com
