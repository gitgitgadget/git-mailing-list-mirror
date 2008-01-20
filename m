From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH] Let "git svn" run "git gc --auto" occasionally
Date: Sun, 20 Jan 2008 10:34:36 +0100
Message-ID: <20080120093436.GA10924@diana.vm.bytemark.co.uk>
References: <20080119123557.GA30778@diana.vm.bytemark.co.uk> <20080119223249.8227.31460.stgit@yoghurt> <1200783050.5724.196.camel@brick> <20080120033737.GA7767@soma>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Harvey Harrison <harvey.harrison@gmail.com>, git@vger.kernel.org,
	Kevin Ballard <kevin@sb.org>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Jan 20 10:35:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGWaQ-0004KP-ED
	for gcvg-git-2@gmane.org; Sun, 20 Jan 2008 10:35:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751700AbYATJfB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Jan 2008 04:35:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751638AbYATJfA
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jan 2008 04:35:00 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2589 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751518AbYATJe7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2008 04:34:59 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1JGWZY-0002qd-00; Sun, 20 Jan 2008 09:34:36 +0000
Content-Disposition: inline
In-Reply-To: <20080120033737.GA7767@soma>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71166>

On 2008-01-19 19:37:37 -0800, Eric Wong wrote:

> Harvey Harrison <harvey.harrison@gmail.com> wrote:
>
> > I found 100 was a bit too low when doing some large repos, I've
> > been using 1000. I'd argue that --repack=3D1000 should be done by
> > default.
>
> I've found 100 for repack too low in the past, too, which is why
> repack defaults to 1000 if no number is specified. I think it should
> hold for gc --auto, too.

OK, I'll change it. But remember, gc --auto doesn't do _anything_
unless it's deemed necessary, so it should behave much better than
just plain repack. In theory at least.

> I consider --repack is out-of-date now that we have gc --auto. I'm
> in favor of ripping out repack support in git-svn and just using gc
> --auto.

Will do. What should I do with the repack commadline options? Keep
them for backwards compatibility but ignore them?

> > How about git gc always gets run at the very end of a git svn
> > fetch?
>
> I'd much prefer that we run gc --auto at the end of every fetch
> instead of doing so randomly for small fetches.

OK, will do. I'll just have to find a good spot to call it from. Hints
welcome.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
