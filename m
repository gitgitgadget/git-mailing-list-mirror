From: Andrew Sayers <andrew-git@pileofstuff.org>
Subject: Re: Some help on gitweb project.
Date: Sun, 13 May 2012 19:53:34 +0100
Message-ID: <4FB0032E.9060302@pileofstuff.org>
References: <CAH-tXsAFMyrkAD1FWZKimbJt-gzmcyyXqt7gymtKozwfFt_aSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git mailing list <git@vger.kernel.org>,
	=?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>
To: jaseem abid <jaseemabid@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 13 20:53:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1STdvW-0000dO-PF
	for gcvg-git-2@plane.gmane.org; Sun, 13 May 2012 20:53:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752710Ab2EMSxj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 May 2012 14:53:39 -0400
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:29796 "EHLO
	mtaout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752072Ab2EMSxj (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 May 2012 14:53:39 -0400
Received: from aamtaout03-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout02-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20120513185336.OAEZ28930.mtaout02-winn.ispmail.ntl.com@aamtaout03-winn.ispmail.ntl.com>;
          Sun, 13 May 2012 19:53:36 +0100
Received: from [192.168.0.2] (really [94.170.150.126])
          by aamtaout03-winn.ispmail.ntl.com
          (InterMail vG.3.00.04.00 201-2196-133-20080908) with ESMTP
          id <20120513185336.ENMH13318.aamtaout03-winn.ispmail.ntl.com@[192.168.0.2]>;
          Sun, 13 May 2012 19:53:36 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.28) Gecko/20120313 Thunderbird/3.1.20
In-Reply-To: <CAH-tXsAFMyrkAD1FWZKimbJt-gzmcyyXqt7gymtKozwfFt_aSA@mail.gmail.com>
X-Cloudmark-Analysis: v=1.1 cv=R50lirqlHffDPPkwUlkuVa99MrvKdVWo//yz83qex8g= c=1 sm=0 a=yXtjXN6ItgYA:10 a=LbmhvjwabHoA:10 a=u4BGzq-dJbcA:10 a=IkcTkHD0fZMA:10 a=h7juetKEAAAA:8 a=3g80flMcAAAA:8 a=NEAV23lmAAAA:8 a=1NILi2k_KaSHdV_rVMIA:9 a=QEXdDO2ut3YA:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197752>

Jaseem and I discussed this in IRC.  You can see the log here:
http://colabti.org/irclogger/irclogger_log/git-devel?date=3D2012-05-13

Or see the (roughly) equivalent text below.

On 13/05/12 18:41, jaseem abid wrote:
> Dear all,
>=20
> CC : Andrew Sayers, Jakub Nar=C4=99bski
>=20
> I have been working on gitweb for a couple of days as part of a
> rejected GSoC proposal. I would love to get some help on this and if
> somebody can, that would be thankful.
>=20
> 1. How is code tested after some change? I am not talking about unit
> testing but about making sure that application is doing what it is
> actually intended to do. Do you have to re - install git/gitweb with
> every version of code you commit and make sure that it works well and
> as expected? Or, is there some other way? Sorry but I am a newbie whe=
n
> it comes to FOSS contribution and as well working on a project of thi=
s
> magnitude.

Your later suggestion of symlinking /usr/share/giweb seems like it
should work.  Alternatively, you could point Apache straight at your
repo.  I don't think this is a situation where subtle issues creep up o=
n
you - if it looks like it works, it probably does.

> 2. How I should be committing ?

Private commits are your own business.  When it comes time to push work
out for public consumption, I like to think of it as telling a story -
start at the beginning and concisely explain what happened.

> 3. How will I submit a commit like "Adding jQuery library"? Mail a
> whole minimized JavaScript library to the mailing list? How can
> somebody crosscheck the contents of a minimized JavaScript library ?

Probably best not to include jQuery in git itself - aside from anything
else, it will be a big hassle to maintain.  Better to have a variable
like "jquery_url" with a default like
"https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js" (i.e=
=2E
Google's CDN).  That avoids the need to include jQuery in git, and lets
people e.g. link different gitweb instances to a single library on thei=
r
local network.

> 4. At what stage is code to be submitted? After the full project is
> done or in a modular manner? Can I ask for some review and help from
> if I push the code to github and share the link, or do I have to mail
> that also? I don't want to repeat this :
> https://github.com/torvalds/linux/pull/17

I expect it will become obvious when to submit code as your work
continues.  For example, if you get into TDD and write a bunch of unit
tests before anything else, you might want to send them in their own
patch series.  I guess it's more likely you'll end up with one big patc=
h
series though.

Speaking for myself, I'm happy to look at code either here or on github=
=2E

> 5. What should be my base commit/branch for starting the work ?

Documentation/SubmittingPatches says:

 - A new feature should be based on 'master' in general.

	- Andrew
