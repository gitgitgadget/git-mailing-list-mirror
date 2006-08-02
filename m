From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] gitweb.cgi: Customization
Date: Wed, 2 Aug 2006 13:30:03 -0700 (PDT)
Message-ID: <20060802203003.61929.qmail@web31802.mail.mud.yahoo.com>
References: <1154535801.19994.15.camel@cashmere.sps.mot.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git List <git@vger.kernel.org>, Martin Waitz <tali@admingilde.org>,
	Matthias Lederhofer <matled@gmx.net>
X-From: git-owner@vger.kernel.org Wed Aug 02 22:30:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8NM5-0006DP-Dl
	for gcvg-git@gmane.org; Wed, 02 Aug 2006 22:30:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226AbWHBUaG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Aug 2006 16:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932228AbWHBUaF
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Aug 2006 16:30:05 -0400
Received: from web31802.mail.mud.yahoo.com ([68.142.207.65]:51613 "HELO
	web31802.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932226AbWHBUaE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Aug 2006 16:30:04 -0400
Received: (qmail 61931 invoked by uid 60001); 2 Aug 2006 20:30:03 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=ViFbmafpGB0Gdu6SpiRcVUZgQ2HEqCZ3R1oB556csnR+JoXAXCiDdt8Ox/5BgKxuj1ww0PTJiiw4Gm2Sh04H7kRa8nEtA2/+dc+LRXb6aKoUzIIIfnYQhdKpFwnvUeiUaJ93/uxKRJkogK+GPuWUlruYwf/wAKpC4gIIoJi5zAk=  ;
Received: from [64.215.88.90] by web31802.mail.mud.yahoo.com via HTTP; Wed, 02 Aug 2006 13:30:03 PDT
To: Jon Loeliger <jdl@freescale.com>, Junio C Hamano <junkio@cox.net>
In-Reply-To: <1154535801.19994.15.camel@cashmere.sps.mot.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24678>

--- Jon Loeliger <jdl@freescale.com> wrote:
> On Tue, 2006-08-01 at 18:54, Junio C Hamano wrote:
> 
> > In any case, I think tweaking gitweb.cgi from Makefile like
> > Martin Waitz did is as easy and clean for people who want to
> > customize; it should just be the matter of defining the
> > necessary params in config.mak.
> 
> I disagree.  I run multiple virtual web servers on one
> physical machine.  Several of them run different gitweb
> instances, each with different configurations.
> 
> With this "params in config.mk" approach, I have to
> run it multiple times, once for each web server I run.

That's exactly my sentiments.

> I _really_ would prefer an "include from ." feature
> where I can place the specific gitweb_config.pm parts
> in the same directory where gitweb.{pl,cgi} is installed.

Yes, this approach is simple and straightforward enough.
When upgrading, one only needs to do a "cp".

> We really need to separate out these config values
> from the gitweb.{pl,cgi} script itself.  We _need_ to
> be able to update the gitweb script independently,
> and easily.

That's exactly where I was going with this patch.
I don't want to have to:
  - configure httpd, or
  - configure the environment of user "apache", or
  - have a separate forked off branch in order to "configure"
    gitweb at compile time for each gitweb instance I'm running,
  - etc, etc, etc.

Configuration, especially of user space programs should be
completely dynamic.  Compilation for user space programs should
be a separate process from configuration.

> > I do not think there is much difference between any of the
> > customization proposed so far (yours, Martin's and the one from
> > Matthias Lederhofer) from functionality and ease-of-use point of
> > view.  They all try to make customization can be done in one
> > place, and the difference is mostly of taste, so I'd just pick
> > one from Martin.
> 
> Let's just make sure it is a separate config file, please.

I thing your and mine deployment are pretty similar, thus warranting
a more flexible approach, withouth having to recompile or reconfigure
completely unrelated programs and users.

    Luben
