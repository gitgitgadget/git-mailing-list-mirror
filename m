From: John Tapsell <johnflux@gmail.com>
Subject: Re: git push
Date: Wed, 25 Feb 2009 09:08:36 +0000
Message-ID: <43d8ce650902250108q48837d85mfcee33b990c5bf00@mail.gmail.com>
References: <43d8ce650902242238s7ab4c851p9c820c96b67aa62b@mail.gmail.com>
	 <7vskm3c84t.fsf@gitster.siamese.dyndns.org>
	 <43d8ce650902242309nef12bd9j9088170b18cc8d4e@mail.gmail.com>
	 <7v4oyjc64z.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 25 10:11:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcFmv-00030s-HV
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 10:10:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761537AbZBYJIq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Feb 2009 04:08:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758573AbZBYJIo
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 04:08:44 -0500
Received: from qw-out-2122.google.com ([74.125.92.26]:63528 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761526AbZBYJIj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Feb 2009 04:08:39 -0500
Received: by qw-out-2122.google.com with SMTP id 5so2563302qwi.37
        for <git@vger.kernel.org>; Wed, 25 Feb 2009 01:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=vx7wl9N75UbVcXcQkFP6QyTmakDP7dU9zBO+osTbif0=;
        b=DNmvinVcwjIJ/jj3pP38kYExiZTUZkaBTdchAgTeH+p8vVcDQN5epb4pjvAcgE+XHA
         hsfmXaKaviPlNOuEeoG4H7RXfsXOZNpzi7JHbqu1UrCxsv5CvSZtICCM/P+V9CKwOu8L
         yTABd4fUenM0BVg4HiMAbIGowPVczg9/oiJY0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=oGM5OAWR5OcDwUFpT+rxpc3GJvAKCMYtSJTfQXPBykDZ2Wp/4W67ZIIyudgpcj94+I
         ucfMDk6GsZwT6TBrZgyZIJSUT3yPvIeRrxtj6g+YoECjrA4xP96hnDsInEMCydNxgR9F
         g7zXIvgT5unASSmy37rRdTOo8mVN/t6H3qlVM=
Received: by 10.224.80.141 with SMTP id t13mr1508813qak.351.1235552917012; 
	Wed, 25 Feb 2009 01:08:37 -0800 (PST)
In-Reply-To: <7v4oyjc64z.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111417>

2009/2/25 Junio C Hamano <gitster@pobox.com>:
> John Tapsell <johnflux@gmail.com> writes:
>
>> 2009/2/25 Junio C Hamano <gitster@pobox.com>:
>>
>>> Having an easy way to ask to push only one branch (typically the cu=
rrently
>>> checked-out one) is a good thing. =C2=A0You can obviously say "git =
push origin
>>> master" (or whatever branch you are on). =C2=A0We also added "git p=
ush origin
>>> HEAD". =C2=A0I thought we even added "git push HEAD" or "git push -=
-current",
>>> but I may be mistaken.
>>>
>>> But if you are talking about changing the default when "git push" i=
s run
>>> without any parameter, I have to say it is a terrible idea, for two
>>> reasons, and one is too obvious to state so I wouldn't repeat it an=
d talk
>>> only about the other one.
>>
>> Presumably the obvious is that it might be confusing to existing
>> users? =C2=A0Perhaps, but it doesn't cause any damage. =C2=A0It's mo=
ving to a
>> 'safer' default.
>
> No, it is not merely confusing but is outright dangerous to people wh=
o
> expect the "matching refs" behaviour. =C2=A0It is not safer at all.

I see your point - perhaps "git push" should push the current branch
if the branch name matches the remote name (so if the current 'git
push' would have pushed it).  Otherwise tell the user how to force it
to push.

> Please don't talk about changing the default without thinking the
> ramifications through.

Talking about doesn't harm anything.  I don't really get why you're a
bit hostile.


>>> I've noticed that people who ask for such a default tend to push to=
o often
>>> and worse they tend to push before they have their act together. =C2=
=A0Surely
>>> their other branches may not be ready, but it is likely their curre=
nt
>>> branch isn't either ;-)
>>
>> You're against making push affect only the current branch in order t=
o
>> punish people who push too often? =C2=A0Okaaay..
>
> "Too often" is not a problem by itself per-se, but "still broken"
> certainly is, and "not thought through" also is to a certain degree. =
=C2=A0You
> often see people commit and push out an early part of a series, and t=
hen
> later regret that they realize the approach in these initial segment =
does
> not pan out and another avenue was much better, but it is too late to=
 take
> them back and rebase.
>
> And there unfortunately is a correlation between "too often" and the =
other
> two. =C2=A0Not very strong correlation with "still broken", but moder=
ately
> strong correlation with "not thought through".
>
> And this is not about punishing. =C2=A0It is about getting into a dif=
ferent
> mindset. =C2=A0Unlike CVS/SVN, committing and publishing can be made =
into
> different phases with git, and not pushing too early allows you produ=
ce a
> lot better results. =C2=A0"I want to push only this branch" is often =
(not
> always, but "often" stands with strong correlation) a sign that other
> things are not ready, and by definition you couldn't have thought thr=
ough
> interactions between what you _think_ is ready (i.e. the current bran=
ch)
> and the other ones that are not ready. =C2=A0In other words, it is ab=
out
> encouraging people to think things through before publishing.

I'm a bit surprised that you always push all your branches at once.  I
often have several branches checked out at different stages of
development.  Perhaps working on a branch, then I find a serious bug,
so I switch to master and fix the bug there.  I have never wanted to
push multiple branches at once.

>>> If you shoot for the least damage for such people, the sanest defau=
lt for
>>> "git push" would be to do nothing. =C2=A0You *always* say what to p=
ush where,
>>> then there is no risk of pushing something you did not intend to. =C2=
=A0Perhaps
>>> "push.default =3D never" configuration may not be such a bad idea?
>>
>> That wouldn't be a terrible idea, although perhaps a bit strange.
>
> I would say that is the sanest default, and I often wish people in th=
e git
> training industry never teach "git push" without $remote and $refs
> parameter to new people until they understand what they are doing.
>
> You can add words other than 'never' to the repertoire, such as 'curr=
ent',
> or 'matching'. =C2=A0I think the configuration actually should be
> "remote.<name>.push", not "push.default", though.
>
> Oh, and the value 'current' can be spelled as 'HEAD' already there.
