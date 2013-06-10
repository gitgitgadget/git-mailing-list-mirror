From: Ian Kumlien <pomac@vapor.com>
Subject: Re: git-daemon: needs /root/.config/git/config?
Date: Mon, 10 Jun 2013 14:06:53 +0200
Message-ID: <20130610120653.GA14168@pomac.netswarm.net>
References: <20130604141314.GD22308@pomac.netswarm.net>
 <20130604160815.GB15953@sigill.intra.peff.net>
 <20130605111918.GE22308@pomac.netswarm.net>
 <20130609124757.GA3347@client.brlink.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: "Bernhard R. Link" <brl+git@mail.brlink.eu>
X-From: git-owner@vger.kernel.org Mon Jun 10 14:11:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um0x3-0000T5-M7
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 14:11:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753484Ab3FJMLy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 08:11:54 -0400
Received: from mail.vapor.com ([83.220.149.2]:57814 "EHLO nitrogen.vapor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753472Ab3FJMLx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 08:11:53 -0400
Received: from twilight.demius.net (c-297271d5.013-195-6c756e10.cust.bredbandsbolaget.se [213.113.114.41])
	by nitrogen.vapor.com (Postfix) with ESMTPSA id F138540C474;
	Mon, 10 Jun 2013 14:11:38 +0200 (CEST)
Received: by twilight.demius.net (Postfix, from userid 1000)
	id 3D9BD8E36CB; Mon, 10 Jun 2013 14:06:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20130609124757.GA3347@client.brlink.eu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227277>

On Sun, Jun 09, 2013 at 02:47:57PM +0200, Bernhard R. Link wrote:
> * Ian Kumlien <pomac@vapor.com> [130605 13:31]:
> > Yes, i agree, it's suboptimal but I for one would use getpwuid to get
> > the home directory of the executing user to avoid this - though i don't
> > know how portable it is (or if there is any other issues)
> 
> It's not only suboptimal but simply wrong. getpwuid gives at best the
> initial home directory, and even there it is only a guess. (If you are
> looking for some home directory of a different user it might be a good
> guess). But using getpwuid(getuid())->pw_dir if HOME is set is a serious
> mistake, as you throw out the good value for some almost but not quite
> totally unrelated value.

Well i never intended for it to replace the environment variable, it was
more intended as a fallback - if there will be a "less strict" mode then
perhaps a fallback would be a more controled way of doing it.

>         Bernhard R. Link
