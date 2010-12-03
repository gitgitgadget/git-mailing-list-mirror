From: Ben Jackson <ben@ben.com>
Subject: Re: [RFC/PATCH] Re: git submodule -b ... of current HEAD fails
Date: Thu, 2 Dec 2010 17:21:56 -0800
Message-ID: <20101203012155.GA30999@kronos.home.ben.com>
References: <20101201171814.GC6439@ikki.ethgen.de> <20101201185046.GB27024@burratino> <4CF80B71.3010309@web.de> <4CF844E5.5010808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Klaus Ethgen <Klaus@Ethgen.de>,
	Sven Verdoolaege <skimo@kotnet.org>
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 03 02:35:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POKYy-0004ZX-Dc
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 02:35:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758334Ab0LCBfr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Dec 2010 20:35:47 -0500
Received: from kronos.home.ben.com ([71.117.242.19]:49710 "EHLO
	kronos.home.ben.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758273Ab0LCBfq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Dec 2010 20:35:46 -0500
X-Greylist: delayed 816 seconds by postgrey-1.27 at vger.kernel.org; Thu, 02 Dec 2010 20:35:46 EST
Received: from kronos.home.ben.com (localhost [127.0.0.1])
	by kronos.home.ben.com (8.14.3/8.14.3) with ESMTP id oB31LuPs031773;
	Thu, 2 Dec 2010 17:21:56 -0800 (PST)
Received: (from bjj@localhost)
	by kronos.home.ben.com (8.14.3/8.14.3/Submit) id oB31LuT6031772;
	Thu, 2 Dec 2010 17:21:56 -0800 (PST)
	(envelope-from bjj)
Content-Disposition: inline
In-Reply-To: <4CF844E5.5010808@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162758>

On Thu, Dec 02, 2010 at 08:16:21PM -0500, Mark Levedahl wrote:
> On 12/02/2010 04:11 PM, Jens Lehmann wrote:
> > Nope, these lines date back to the time before I got involved in the
> > submodule business ... Seems like this "git checkout" was added in
> > March 2008 by Mark Levedahl (CCed), maybe he can shed some light on
> > that.
> >
> > But to me your change looks good, so feel free to add:
> > Acked-by: Jens Lehmann<Jens.Lehmann@web.de>
> >
> >
> >> diff --git a/git-submodule.sh b/git-submodule.sh
> >> index 33bc41f..6242d7f 100755
> >> --- a/git-submodule.sh
> >> +++ b/git-submodule.sh
> >> @@ -241,7 +241,7 @@ cmd_add()
> >>   			# ash fails to wordsplit ${branch:+-b "$branch"...}
> >>   			case "$branch" in
> >>   			'') git checkout -f -q ;;
> >> -			?*) git checkout -f -q -b "$branch" "origin/$branch" ;;
> >> +			?*) git checkout -f -q -B "$branch" "origin/$branch" ;;
> >>   			esac
> >>   		) || die "Unable to checkout submodule '$path'"
> >>   	fi
> >>
> These lines were actually added by Ben Jackson in commit ea10b60c91 in 
> 2009, long after I last touched that module.

I didn't mean to change any functionality -- I just wanted to fix a
portability problem (/bin/sh is ash on FreeBSD, hence the comment at the
top of the context).  Looks like `checkout -B' (capital B) didn't even
exist at that time.  Seems reasonable, though.

-- 
Ben Jackson AD7GD
<ben@ben.com>
http://www.ben.com/
