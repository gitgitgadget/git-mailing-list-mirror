From: David Lang <david@lang.hm>
Subject: Re: [Administrivia] On ruby and contrib/
Date: Tue, 4 Jun 2013 20:02:15 -0700 (PDT)
Message-ID: <alpine.DEB.2.02.1306041954360.2900@nftneq.ynat.uz>
References: <7vtxld30f2.fsf@alter.siamese.dyndns.org> <7va9n52zjc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	=?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	=?VISCII?Q?Nguy=ADn_Th=E1i_Ng=F7c_Duy?= <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 05 06:11:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uk54e-0003p3-W5
	for gcvg-git-2@plane.gmane.org; Wed, 05 Jun 2013 06:11:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750969Ab3FEELq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jun 2013 00:11:46 -0400
Received: from mail.lang.hm ([64.81.33.126]:43326 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750854Ab3FEELo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jun 2013 00:11:44 -0400
X-Greylist: delayed 454 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Jun 2013 00:11:44 EDT
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id r55438jm015780;
	Tue, 4 Jun 2013 21:03:08 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <7va9n52zjc.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226427>

On Tue, 4 Jun 2013, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
>
> On Ruby:
>
> Assuming "related" is a good idea, to make it as the proper part of
> the system out of contrib/ when its design review phase is finished,
> one of these things has to happen:
>
> 1. Find a volunteer to rewrite it in one of the languages that we
>    know the platforms our current users use already support, which
>    means either C (not a good match), POSIX shell (not the best
>    match), or Perl.
>
> 2. Promote Ruby to the first-class citizen status, which involves
>    making sure people on platforms that matter do not have problem
>    adding dependency on it (I am primarily worried about MinGW
>    folks), and also making sure core developers do not mind
>    reviewing code written in it.
>
> As long as we can get as high quality reviews on changes written in
> Ruby as we do for the current codebase, it is OK to go route #2, and
> that may hopefully happen in the longer term as and there will be
> some people, among competent Ruby programmers, who have understood
> how the pieces of entire Git are designed to fit together by the
> time it happens.
>
> I however do not know how much extra burden it would place to add
> dependencies to platform folks, so obviously the safer approach is 1
> at least in the immediate future.  My understanding is that msysgit
> folks are already having trouble with Python, and we do not want to
> go route #2 at least for now.  Having to ship a variant of Git with
> NO_PYTHON is already bad enough.  And that is why the option 1 above
> does not list Python as a possible candidate.

As someone who builds minimalist builds (firewalls, openwrt, raspberry pi, etc), 
having to pull in a full ruby install to get git installed would not be 
something I'd like to see.

Yes, openwrt (and I) can build our own version, but that's a pain. I tend to 
build my tight systems from Debian and it's nice to be able to use stock 
packages.

I tend to use git for sysadmin type functions as much as for development, so 
it's very useful even on such small and slow platforms.

> On contrib/:
>
> Back when Git was very young, it made sense to bundle third-party
> tools in our tree's "contrib/" section to give them visibility and
> users convenience.  Now Git ecosystem has grown to have many users
> who know Git and who do not necessarily come to this list, and with
> easy-to-use hosting sites where anybody can publish their ware and
> collaborate with their contributors, "giving more visibility" angle
> of contrib/ has outlived its usefulness.  When there are multiple
> third-party tools that address similar needs, there is not much
> point picking one at random and ship it over others, and shipping
> all of them is simply crazy.  In an ecosystem with flourishing
> third-party add-ons, their products should and will stand on their
> own.
>
> As the maintainer, I've been thinking about closing contrib/ area
> for new stuff, and shrinking existing ones, either by moving stuff
> that are only useful within the context of Git to main part of the
> tree (e.g. "contrib/workdir" may move to a new directory "addons/",
> some of remote-helpers in contrib/ may move to "remote-helpers/",
> etc.), and removing others from contrib/, for this reason.  Of
> course, interested folks can take the last version of the removed
> ones and continue improving them as standalone projects.

If you can, you should leave just enough of a stub in place so that people who 
don't know about the change and try to run the stuff that used to be in contrib/ 
get a message pointing them to the new home.

David Lang
