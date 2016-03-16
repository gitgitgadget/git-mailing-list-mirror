From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [ANNOUNCE] Git v2.8.0-rc2
Date: Wed, 16 Mar 2016 14:33:10 +0100
Message-ID: <56E96096.4020108@drmicha.warpmail.net>
References: <xmqqr3fiaq9f.fsf@gitster.mtv.corp.google.com>
 <56E6D8C4.2010205@drmicha.warpmail.net>
 <xmqqoaahaw99.fsf@gitster.mtv.corp.google.com>
 <xmqqziu19cjz.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 14:33:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agBZj-0006fv-Au
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 14:33:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934043AbcCPNdO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 09:33:14 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:57941 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933804AbcCPNdN (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Mar 2016 09:33:13 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 2727920A44
	for <git@vger.kernel.org>; Wed, 16 Mar 2016 09:33:12 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute4.internal (MEProxy); Wed, 16 Mar 2016 09:33:12 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=+e+YRvApDZE1Doj9JxzvU2QBH9s=; b=lIBvIQ
	9P3CoYZtbf3X2J/iyxZl5rPY5qCvep2Pmnhr25AUaBqXliMN5jBonp1uJA0Niu+T
	PBRG6RMOcXnwf0KdD+FSDTAtqXbi9818eNgDgQip3+d9fsO2Dajrj+BG5F3R1WBq
	dg6ud1ryN9sOA5QXA714LxPLGrmjOPhKLEp4A=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=+e+YRvApDZE1Doj
	9JxzvU2QBH9s=; b=mNlVEb7mbxOJPclZByZQlAvkYJp+7cLbFafAWMrt/Ztp8cc
	MoGwmnYvEQdH8ObipJK8VgAU3HUaVhNORFUraneMmvVYlw0gmhv8ryYsRlsdWADw
	Vn3tsLmfW4c0PfEpr7nbpqIXEonJCY7YH3aF1dyn4TY2CCirGnXf/MlD+jPo=
X-Sasl-enc: Ax3qP/OK9aeAx5ah7K0Wg7aXAZ0juF5i6sJPwOTgvyEb 1458135191
Received: from UltraSam.fritz.box (dslb-092-076-189-025.092.076.pools.vodafone-ip.de [92.76.189.25])
	by mail.messagingengine.com (Postfix) with ESMTPA id 634E8C00012;
	Wed, 16 Mar 2016 09:33:11 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <xmqqziu19cjz.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288971>

Junio C Hamano venit, vidit, dixit 14.03.2016 18:47:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> But if it makes it easier for translations teams and the i18n
>> coordinator to work together if I also pulled the git.pot update
>> myself, I'll do so.  I just didn't know (and still don't know) if
>> that makes things easier for you guys, or if that risks making
>> things more confusing, having to or being able to pull from two
>> trees that are not necessarily in sync down to the minute.
> 
> So, please just tell me to pull it myself too, if it makes the life
> of i18n team and the coordinator easier.
> 
> Thanks.
> 

I don't know about the workflow in general. I'll write up what triggered
my question: I was looking at the FAQ "how do I display the current
branch in git" and into ways to provide some ui (think "git status -sb",
the "+"-line in "git branch"), when I found the problematic output. The
multiple parentheses looked suspicious to me, but given the many levels
of macro expansion I wasn't sure, and simply patching the parentheses
didn't help either. It needed a combination of "make pot" and "msgmerge
...", and the fact that the last merge of git.pot was from 2.7.0-rc
triggered my request to merge what we have.

In hindsight, what happened must have been like this:

"ahead " was marked properly for l10n and translated in the past.

7a76c28 (status: disable translation when --porcelain is used,
2014-03-20) introduced those extra parentheses. Matthieu probably didn't
rerun "make pot" and "msgmerge" so that he didn't notice the consequences.

When Jian ran "make pot" the "ahead "-entry got removed from git.pot:
5e078fc (l10n: git.pot: v2.0.0 round 1 (45 new, 28 removed), 2014-04-19)

When translators ran "msgmerge" with the new git.pot the existing "ahead
"-entry got commented out, for example here for de.po:
74c17bb (l10n: de.po: translate 45 new messages, 2014-04-01)

I'm actually wondering why I didn't notice this much earlier. I don't
know which workflow would have prevented this either. Maybe, since we
have "make pot", we should also have "make l10n" or something to make it
(even) easier for non-l10n-experts to check whether they introduced any
problems.

Strictly speaking, every source file with i18n markup should trigger a
"make pot" (and make l10n) when changed, but there's probably a good
reason why we don't do that.

Michael
