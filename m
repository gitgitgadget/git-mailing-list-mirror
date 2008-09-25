From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 0/3] [RFC] Support for publishing projects at central
	site
Date: Thu, 25 Sep 2008 12:24:47 +0200
Message-ID: <20080925102447.GG10360@machine.or.cz>
References: <20080924235734.697978308@suse.cz> <Pine.LNX.4.64.0809250951090.5683@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, spearce@spearce.org
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Thu Sep 25 12:25:59 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kio2o-0002gL-RD
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 12:25:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753043AbYIYKYu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Sep 2008 06:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753080AbYIYKYu
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Sep 2008 06:24:50 -0400
Received: from w241.dkm.cz ([62.24.88.241]:45029 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753022AbYIYKYt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2008 06:24:49 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 8FD083939B42; Thu, 25 Sep 2008 12:24:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0809250951090.5683@ds9.cixit.se>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96742>

Hi!

On Thu, Sep 25, 2008 at 09:56:18AM +0100, Peter Krefting wrote:
> pasky@suse.cz:
> 
> > This is not really meant for as-is application, of course, but more
> > to see if people think it is good idea to have this kind of
> > functionality in git-gui at all and how generic it should be. This
> > mini-series depends on pretty much all the other patches I have
> > submitted tonight.
> 
> As long as it is easy to implement the server-side back-end needed to
> automatically accept projects that you publish through this hook, then
> this is something that would really help out in this conext.

Well, the example URL points to a Girocco script - Girocco is cleaned up
and modernized version of the repo.or.cz duct tape, that should be easy
to reconfigure for any kind of deployment and then simply make
install-able. But any kind of CGI script can be in principle hooked up
to this, so you can just write short shell thing that will do the magic
and then

	echo -e 'Content-type: text/plain\n\nRegistration succeeded!'

> I currently need to perform some "magic" on the server-side to set up
> new projects, it would be nice if all the people using it have to do is
> to select a menu option saying "publish". Preferrably through the git
> protocol, so that I don't have to set up ssh on people's machines
> (working in a Windows environment here, so all central repositories are
> set up to use the git protocol for both pull and push).

Which protocol do you use does not really matter, just set up the
locators right (or don't use them if you don't want to). I ended up
using samba exports mapped to Windows drives, but just using the git
protocol might make more sense in many scenarios.

> How do you envision discovering the location to publish to? Some kind
> of automatic configuration option would be nice. Perhaps be able to
> point git gui at some magic URI that would download an XML (or text)
> file describing the central server, perhaps?

I provide customized MSysGit package with tweaked installer and with
custom /etc/gitconfig. I think in these deployments there is either this
possibility or the machines are centrally administrated so the sysadmin
can adjust /etc/gitconfigs.

-- 
				Petr "Pasky" Baudis
People who take cold baths never have rheumatism, but they have
cold baths.
