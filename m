From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: The imporantance of including http credential caching in 1.7.7
Date: Wed, 07 Sep 2011 14:56:03 +0200
Message-ID: <4E6769E3.4070003@drmicha.warpmail.net>
References: <CAFcyEthzW1AY4uXgpsVxjyWCDXAJ6=GdWGqLFO6Acm1ovJJVaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Kyle Neath <kneath@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 07 18:33:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1L3y-0001xI-5j
	for gcvg-git-2@lo.gmane.org; Wed, 07 Sep 2011 18:33:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752695Ab1IGQcR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Sep 2011 12:32:17 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:60252 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752378Ab1IGQcP (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Sep 2011 12:32:15 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 70B0A2A29A;
	Wed,  7 Sep 2011 08:56:05 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute6.internal (MEProxy); Wed, 07 Sep 2011 08:56:05 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=t0fVUrP6V8Xh/FQLfjSHP7
	qrmN0=; b=dCpzBzxhD7ilSxgk9ce5ZlUT6yxcihsa0D2NZoT4kf1grm9DexYRNc
	dibCdQnoU9mEbrENgrxqgz+Ya7L+HaO4CaPDDUtxN0VZQoDsDGC57puAUcB8tsm7
	SnQapkcBE6V4f7dg/w8Xf8iZezVAnzG6I5qLv/kCdTvBYYnaFXpJ4=
X-Sasl-enc: PGcMtlMrK+wjg6QIeCbKUsFzK6dtbeMD/ihX3jFVdgR1 1315400165
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id E53B6B61643;
	Wed,  7 Sep 2011 08:56:04 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0) Gecko/20110816 Thunderbird/6.0
In-Reply-To: <CAFcyEthzW1AY4uXgpsVxjyWCDXAJ6=GdWGqLFO6Acm1ovJJVaw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180864>

Kyle Neath venit, vidit, dixit 07.09.2011 07:33:
> Earlier today, Scott Chacon alerted me to this email thread:
> http://www.spinics.net/lists/git/msg164192.html (many apologies to the list, I
> am not sure how to properly reference this email or reply to it since I have
> not been subscribed until today).
> 
>> * jk/http-auth-keyring (2011-08-03) 13 commits
>>   (merged to 'next' on 2011-08-03 at b06e80e)
>>  + credentials: add "getpass" helper
>>  + credentials: add "store" helper
>>  + credentials: add "cache" helper
>>  + docs: end-user documentation for the credential subsystem
>>  + http: use hostname in credential description
>>  + allow the user to configure credential helpers
>>  + look for credentials in config before prompting
>>  + http: use credential API to get passwords
>>  + introduce credentials API
>>  + http: retry authentication failures for all http requests
>>  + remote-curl: don't retry auth failures with dumb protocol
>>  + improve httpd auth tests
>>  + url: decode buffers that are not NUL-terminated
>>
>> Looked mostly reasonable except for the limitation that it is not clear
>> how to deal with a site at which a user needs to use different passwords
>> for different repositories. Will keep it in "next" at least for one cycle,
>> until we start hearing real-world success reports on the list.
>>
>> Not urgent; will not be in 1.7.7.
> 
> This is very disheartening to hear. Of all the minor changes, bugs, and
> potential features, I believe that http credential caching is the absolute
> most important thing that git core can do to promote adoption. I've believed
> this for more than a year now and I'm incredibly disappointed that it's being
> shelved for yet another release.
> 
> Over the past two years as a designer for GitHub, I've answered ~thousands of
> support requests and talked face to face with ~thousands of developers of
> varying git skill levels. Once a month our company does online git training
> for newbies - https://github.com/training/online and I've had many discussions
> about newcomer's struggles with Matthew McCullough and Scott Chacon.
> Previously, I worked at ENTP where I helped polish the very popular "Git for
> Designers" guide http://hoth.entp.com/output/git_for_designers.html based on
> feedback. I was also lead designer for GitHub for Mac - an OSX GUI aimed at
> people less familiar with the command line.

So, it's been a year or more that you've been aware of the importance of
this issue (from your/github's perspective), and we hear about it now,
at the end of the rc phase. I don't know whether jk/http-auth-keyring
has been done on github payroll or during spare time. But as you can
see, all that is missing is real-world success reports, along with the
single-user-multiple-passwords issue which is probably answered best
from the real-world perspective (how common is it, do we even need to
address it now). So, given the importance this has for you and the
company, you sure can help out with what is still left to do, can you?

But note that the credential api is only as good a solution as the
helpers. Do we really want all users to employ credential-store because
it is "much simpler than ssh"? Deploying what we have now and advocating
it as a solution for the ssh-challenged (which will happen whether we,
you or someone else advocates it) could easily mean telling people to
store their credentials unencrypted. The slash-dot story will be "git
security hole", "git stores passwords unencrypted" and so on. And I
don't care as much about the PR as about the users whom we'd be serving
badly.

So, for the ssh-challenged, we really should make sure that secure
helpers are in their hand when the credential api hits a released
version (or revert the insecure store helper). There's a KDE attempt on
the list. Gnome, Win, Mac helpers anyone? Win version of the cache helper?

Michael
