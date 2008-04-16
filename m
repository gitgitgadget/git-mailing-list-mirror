From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Reporting bugs and bisection
Date: Wed, 16 Apr 2008 12:02:47 -0700
Message-ID: <20080416120247.c665859c.akpm@linux-foundation.org>
References: <20080413205406.GA9190@2ka.mipt.ru>
	<48028830.6020703@earthlink.net>
	<alpine.DEB.1.10.0804131546370.9318@asgard>
	<20080414043939.GA6862@1wt.eu>
	<20080414053943.GU9785@ZenIV.linux.org.uk>
	<20080413232441.e216a02c.akpm@linux-foundation.org>
	<20080414072328.GW9785@ZenIV.linux.org.uk>
	<Xine.LNX.4.64.0804150131300.4160@us.intercode.com.au>
	<4804765B.2070300@davidnewall.com>
	<bd6139dc0804160515s64a36748v49556c56d475dda4@mail.gmail.com>
	<20080416132634.GA545@cs181133002.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: sverre@rabbelier.nl, git@vger.kernel.org,
	linux-kernel@vger.kernel.org, jmorris@namei.org,
	viro@zeniv.linux.org.uk, w@1wt.eu, david@lang.hm,
	sclark46@earthlink.net, johnpol@2ka.mipt.ru, rjw@sisk.pl,
	tilman@imap.cc, Valdis.Kletnieks@vt.edu, lkml@rtr.ca,
	davem@davemloft.net, jesper.juhl@gmail.com,
	yoshfuji@linux-ipv6.org, jeff@garzik.org, netdev@vger.kernel.org,
	davidn@davidnewall.com
To: Adrian Bunk <bunk@kernel.org>
X-From: netdev-owner@vger.kernel.org Wed Apr 16 21:33:27 2008
connect(): Connection refused
Return-path: <netdev-owner@vger.kernel.org>
Envelope-to: linux-netdev-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmDDw-0005bA-VR
	for linux-netdev-2@gmane.org; Wed, 16 Apr 2008 21:23:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751828AbYDPTVy (ORCPT <rfc822;linux-netdev-2@m.gmane.org>);
	Wed, 16 Apr 2008 15:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751584AbYDPTVy
	(ORCPT <rfc822;netdev-outgoing>); Wed, 16 Apr 2008 15:21:54 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:49540 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751320AbYDPTVw (ORCPT
	<rfc822;netdev@vger.kernel.org>); Wed, 16 Apr 2008 15:21:52 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3GJ2ppF022206
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 16 Apr 2008 12:02:52 -0700
Received: from akpm.corp.google.com (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id m3GJ2lvv001652;
	Wed, 16 Apr 2008 12:02:47 -0700
In-Reply-To: <20080416132634.GA545@cs181133002.pp.htv.fi>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.20; i486-pc-linux-gnu)
X-Spam-Status: No, hits=-2.764 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: netdev-owner@vger.kernel.org
Precedence: bulk
List-ID: <netdev.vger.kernel.org>
X-Mailing-List: netdev@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79728>

On Wed, 16 Apr 2008 16:26:34 +0300
Adrian Bunk <bunk@kernel.org> wrote:

> On Wed, Apr 16, 2008 at 02:15:22PM +0200, Sverre Rabbelier wrote:
> > I'm not subscribed to the kernel mailing list, so please include me in
> > the cc if you don't reply to the git list (which I am subscribed to).
> > 
> > Git is participating in Google Summer of Code this year and I've
> > proposed to write a 'git statistics' command. This command would allow
> > the user to gather data about a repository, ranging from "how active
> > is dev x" to "what did x work on in the last 3 weeks". It's main
> > feature however, would be an algorithm that ranks commits as being
> > either 'buggy', 'bugfix' or 'enhancement'. (There are several clues
> > that can aid in determining this, a commit msg along the lines of
> > "fixes ..." being the most obvious.)
> >...

Sounds like an interesting project.

> At least with the data we have currently in git it's impossible to 
> figure that out automatically.
> 
> E.g. if you look at commit f743d04dcfbeda7439b78802d35305781999aa11 
> (ide/legacy/q40ide.c: add MODULE_LICENSE), how could you determine 
> automatically that it is a bugfix, and the commit that introduced
> the bug?
> 
> You can always get some data, but if you want to get usable statistics 
> you need explicit tags in the commits, not some algorithm that tries 
> to guess.

Well yes.  One outcome of the project would be to tell us what changes we'd
need to make to our processes to make such data gathering more effective.

Of course, we may not actually implement such changes.  That would depend
upon how useful the output is to us.
