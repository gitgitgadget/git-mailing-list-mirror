From: Pete/Piet Delaney <pete@bluelane.com>
Subject: Re: Qgit performance and maintain CVS environment with GIT repository
Date: Fri, 19 Oct 2007 02:12:56 -0700
Organization: Bluelane
Message-ID: <47187518.1090007@bluelane.com>
References: <598689.78740.qm@web56015.mail.re3.yahoo.com>	 <47159779.6010502@bluelane.com>	 <e5bfff550710170030y7778e96ax146acea7a0e57a67@mail.gmail.com>	 <200710171800.37345.robin.rosenberg.lists@dewire.com> <e5bfff550710171626h733228aw7a251746d2b43c63@mail.gmail.com> <4717EF40.6000509@bluelane.com> <4718594A.2070407@op5.se>
Reply-To: pete@bluelane.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Marco Costalba <mcostalba@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	piet.delaney@gmail.piet.net,
	Linus Torvalds <torvalds@linux-foundation.org>,
	VMiklos <vmiklos@frugalware.org>,
	free cycle <freecycler23@yahoo.com>, git@vger.kernel.org,
	piet.delaney@gmail.com, Piet Delaney <pdelaney@bluelane.com>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Fri Oct 19 11:17:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Iinz1-0006GB-DB
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 11:17:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764466AbXJSJNG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 05:13:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764500AbXJSJNF
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 05:13:05 -0400
Received: from outbound.mse2.exchange.ms ([69.25.50.247]:56882 "EHLO
	mse2fe1.mse2.exchange.ms" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1763744AbXJSJND (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Oct 2007 05:13:03 -0400
Received: from piet2.bluelane.com ([64.95.123.130]) by mse2fe1.mse2.exchange.ms with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 19 Oct 2007 05:13:01 -0400
User-Agent: Thunderbird 2.0.0.6 (X11/20070728)
In-Reply-To: <4718594A.2070407@op5.se>
X-Enigmail-Version: 0.95.3
X-OriginalArrivalTime: 19 Oct 2007 09:13:01.0565 (UTC) FILETIME=[3FA642D0:01C81230]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61681>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Andreas Ericsson wrote:
> Pete/Piet Delaney wrote:
>> Johannes:
>>   I read somewhere in the past week that it was possible to maintain
>>   our existing CVS environment with git. I though it was a separate
>>   package to export git back to cvs but I just noticed a git-cvsserver
>>   and as a std part of git and was wondering about using that.
>>
>>   We have a number of build machines with flamebox perl scripts pulling
>>   out CVS branches for builds. I was wondering what is the best way to
>>   use git and it's nicer pull/push model and merge facility and possibly
>>   maintain CVS exports for scripts doing builds if possible the cvsweb
>>   and bonsai (CVS Query Form) that a number of engineers are currently
>>   using. I started looking over out flamebox scripts with the intent
>>   up converting them over to git but I mentioned the git to cvs
>>   coexistence and we are wondering if that's a better route than
>>   upgrading the flamebox scripts. Having our existing cvsweb, bonsai,
>>   and gitweb along with the git utilities seems at least desirable.
>>   Any thoughts or suggestions?
>>
> 
> If you do convert them to git, you can fairly easily do an automatic
> bisect on build-errors, and the developer can (after some time) get
> an email of what machines they broke the code on and what the bad
> commit was.

Could you explain that a bit more. Sounds like you saying it's worth
messing with the flamebox scripts to use git instead of using the git
cvserver and letting them pull the cvs branches as they do now. Is the
existing flamebox email of build log effected buy switching form cvs
to git? I hadn't expect it to change.


> Besides that, it's not a black-and-white scenario. If I were you I'd set
> up git-cvsserver and make sure that works for all the scripts, and then
> pick one or two auto-build things to convert to git. Preferrably on a
> separate machine, so everything keeps working the same as always while
> you're fiddling with the auto-build stuff.

I get the impression your suggestion to first get git-cvsserver serving
the repo so that the build machines works without any change and then to
go to each build machine and update the scripts to use git instead of cvs.

Are there any tricks I need to so on the repo to make the branches pull
out with exactly the same commands that we are currently using. My guess
is that the branch checkouts should work without any messing around.
> 
> Just my two cents.

Hey, you two cents could easily save me hours of messing getting this
conversion done.

BTW, I don't think anyone is checking into the repo, but if they do
can I do another git-cvsimport to just update the one I already did?

- -piet

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHGHUUJICwm/rv3hoRArHsAJ9GQMjpLc5CzpBXnHkxLfBgfwEo/QCdGNfj
DiivgfDDSbIB+9YBZvj/5Z0=
=SBSg
-----END PGP SIGNATURE-----
