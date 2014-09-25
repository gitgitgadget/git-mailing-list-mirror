From: Joe Perches <joe@perches.com>
Subject: Re: project wide: git config entry for [diff] renames=true
Date: Thu, 25 Sep 2014 11:06:31 -0700
Message-ID: <1411668391.3460.2.camel@joe-AO725>
References: <Pine.LNX.4.44L0.1409241106100.1580-100000@iolanthe.rowland.org>
	 <1411591401-5874-1-git-send-email-sojka@merica.cz>
	 <1411591401-5874-4-git-send-email-sojka@merica.cz>
	 <20140925150353.GA15325@kroah.com> <1411660111.4026.24.camel@joe-AO725>
	 <20140925180005.GA11755@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michal Sojka <sojka@merica.cz>, linux-usb@vger.kernel.org,
	Alan Stern <stern@rowland.harvard.edu>,
	Bryan Wu <cooloney@gmail.com>, Felipe Balbi <balbi@ti.com>,
	Linux LED Subsystem <linux-leds@vger.kernel.org>,
	linux-kernel@vger.kernel.org, michal.vokac@comap.cz,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: linux-leds-owner@vger.kernel.org Thu Sep 25 20:06:40 2014
Return-path: <linux-leds-owner@vger.kernel.org>
Envelope-to: gll-linux-leds@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-leds-owner@vger.kernel.org>)
	id 1XXDR9-0005GB-Dd
	for gll-linux-leds@plane.gmane.org; Thu, 25 Sep 2014 20:06:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753094AbaIYSGi (ORCPT <rfc822;gll-linux-leds@m.gmane.org>);
	Thu, 25 Sep 2014 14:06:38 -0400
Received: from smtprelay0149.hostedemail.com ([216.40.44.149]:44323 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753127AbaIYSGg (ORCPT
	<rfc822;linux-leds@vger.kernel.org>);
	Thu, 25 Sep 2014 14:06:36 -0400
Received: from filter.hostedemail.com (ff-bigip1 [10.5.19.254])
	by smtprelay03.hostedemail.com (Postfix) with ESMTP id E3FE86B069;
	Thu, 25 Sep 2014 18:06:34 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::,RULES_HIT:41:355:379:541:599:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2194:2199:2393:2553:2559:2562:2736:2828:2911:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:4321:4425:5007:7652:7903:10004:10400:10848:11232:11658:11914:12517:12519:12740:13019:13069:13149:13230:13311:13357:21080,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:none,Custom_rules:0:0:0
X-HE-Tag: kiss91_392f444ae3513
X-Filterd-Recvd-Size: 2435
Received: from [192.168.1.155] (pool-71-103-235-196.lsanca.fios.verizon.net [71.103.235.196])
	(Authenticated sender: joe@perches.com)
	by omf02.hostedemail.com (Postfix) with ESMTPA;
	Thu, 25 Sep 2014 18:06:32 +0000 (UTC)
In-Reply-To: <20140925180005.GA11755@peff.net>
X-Mailer: Evolution 3.10.4-0ubuntu2 
Sender: linux-leds-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-leds.vger.kernel.org>
X-Mailing-List: linux-leds@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257489>

On Thu, 2014-09-25 at 14:00 -0400, Jeff King wrote:
> On Thu, Sep 25, 2014 at 08:48:31AM -0700, Joe Perches wrote:
> 
> > On Thu, 2014-09-25 at 17:03 +0200, Greg Kroah-Hartman wrote:
> > 
> > > In the future, please generate a git "move" diff, which makes it easier
> > > to review, and prove that nothing really changed.  It also helps if the
> > > file is a bit different from what you diffed against, which in my case,
> > > was true.
> > 
> > Maybe it'd be possible to add 
> > 
> > [diff]
> > 	renames = true
> > 
> > to the .git/config file.
> > 
> > but I don't find a mechanism to add anything to the
> > .git/config and have it be pulled.
> 
> There is no such mechanism within git. We've resisted adding one because
> of the danger of something like:
> 
>   [diff]
>     external = rm -rf /
> 
> diff.renames is probably safe, but any config-sharing mechanism would
> have to deal with either whitelisting, or providing some mechanism for
> the puller to review changes before blindly following them.

Another mechanism might be to add a repository
top level .gitconfig and add whatever to that.
