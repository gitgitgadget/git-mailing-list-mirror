From: Marcel Partap <mpartap@gmx.net>
Subject: Re: Git ~unusable on slow lines :,'C
Date: Tue, 09 Oct 2012 16:06:11 +0200
Message-ID: <50742F53.3050205@gmx.net>
References: <50731B2A.6040104@gmx.net> <87lifgct3j.fsf@centaur.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>
X-From: git-owner@vger.kernel.org Tue Oct 09 16:06:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLaS6-0000GU-MH
	for gcvg-git-2@plane.gmane.org; Tue, 09 Oct 2012 16:06:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755637Ab2JIOGV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2012 10:06:21 -0400
Received: from mailout-de.gmx.net ([213.165.64.23]:51616 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754156Ab2JIOGT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2012 10:06:19 -0400
Received: (qmail invoked by alias); 09 Oct 2012 14:06:17 -0000
Received: from unknown (EHLO [10.46.63.113]) [82.113.121.113]
  by mail.gmx.net (mp069) with SMTP; 09 Oct 2012 16:06:17 +0200
X-Authenticated: #724076
X-Provags-ID: V01U2FsdGVkX19jRrF7zP1jeqW2nM/iIAyZIAVK0uf6R4TzH0A4Hd
	VuWuLIyjr9yBSb
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:13.0) Gecko/20120615 Thunderbird/13.0.1
In-Reply-To: <87lifgct3j.fsf@centaur.cmartin.tk>
X-Enigmail-Version: 1.4.1
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207320>

>> Bam, the server kicked me off after taking to long to sync my copy.
> This is unrelated to git. The HTTP server's configuration is too
> impatient.
Yes. How does that mean it is unrelated to git?

>> - git fetch should show the total amount of data it is about to
>> transfer!
> It can't, because it doesn't know.
The server side doesn't know at how much the objects *it just repacked
for transfer* weigh in?
If that truly is the case, wouldn't it make sense to make git a little
more introspective? f.e.
> # git info git://foo.org/bar.git
> .. [server generating figures] ..
> URL: git://foo.org/bar.git
> Created/Earliest commit: ...
> Last modified/Latest commit: ...
> Total object count: .... (..commits, ..files, .. directories)
> Total repository size (compressed): ... MiB
> Branches:
> [git branch -va] + branch size

> The error message doesn't really know whether it is going to overwrite
> it (the CR comes from the server), though I suppose an extra LF wouldn't
> hurt there.
Definitely wouldn't hurt.

>> - would be nice to be able to tell git fetch to get the next chunk of
>> say 500 commits instead of trying to receive ALL commits, then b0rking
>> after umpteen percent on server timeout. Not?
> You asked for the current state of the repository, and that's what its
> giving you.
And instead, I would rather like to ask for the next 500 commits. No way
to do it.

> The timeout has nothing to do with git, if you can't
> convince the admins to increase it, you can try using another transport
> which doesn't suffer from HTTP, as it's most likely an anti-DoS measure.
See, I probably can't convince the admins to drop their anti-dos measures.
And they (drupal.org admins) probably will not change their allowed
protocol policies.
Despite that, i've had timeouts or simply stale connections dying down
before with other repositories and various transport modes.
The easiest fix would be an option to tell git to not fetch everything...

> If you want to download it bit by bit, you can tell fetch to download
> particular tags.
..without specifying specific commit tags.
Browsing gitweb sites to find a tag for which the fetch doesn't time out
is hugely inconvenient, especially on a slow line.

> Doing this automatically for this would be working
> around a configuration issue for a particular server, which is generally
> better fixed in other ways.
It is not only a configuration issue for one particular server. Git in
general is hardly usable on slow lines because
- it doesn't show the volume of data that is to be downloaded!
- it doesn't allow the user to sync up in steps the circumstances will
allow to succeed.

#Regards!Marcel.
