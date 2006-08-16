From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: Re: [PATCH] git-mv: succeed even if source is a prefix of destination
Date: Wed, 16 Aug 2006 21:22:54 +0200
Message-ID: <20060816192254.GA9575@c165.ib.student.liu.se>
References: <20060815205150.GA467@c165.ib.student.liu.se> <Pine.LNX.4.63.0608151401510.3965@chino.corp.google.com> <Pine.LNX.4.63.0608160209150.28360@wbgn013.biozentrum.uni-wuerzburg.de> <20060816054944.GA5218@c165.ib.student.liu.se> <Pine.LNX.4.63.0608161041300.28360@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Kuivinen <freku045@student.liu.se>,
	David Rientjes <rientjes@google.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 16 21:23:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDQyj-00033C-AF
	for gcvg-git@gmane.org; Wed, 16 Aug 2006 21:23:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751035AbWHPTW6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Aug 2006 15:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbWHPTW5
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Aug 2006 15:22:57 -0400
Received: from mxfep02.bredband.com ([195.54.107.73]:30702 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S1751035AbWHPTW5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Aug 2006 15:22:57 -0400
Received: from c165 ([213.114.27.99] [213.114.27.99])
          by mxfep02.bredband.com with ESMTP
          id <20060816192255.FCMN11843.mxfep02.bredband.com@c165>;
          Wed, 16 Aug 2006 21:22:55 +0200
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1GDQyd-00032o-00; Wed, 16 Aug 2006 21:22:55 +0200
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0608161041300.28360@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25522>

On Wed, Aug 16, 2006 at 10:44:02AM +0200, Johannes Schindelin wrote:
> > 
> > It looks like we need some kind of path normalization before we do
> > those tests.
> 
> I kind of hoped it was not necessary to do this, since get_pathspec() does 
> a rudimentary version of it (BTW git-mv.perl got it wrong: it substituted 
> "./" by "", which would fail for a directory name like "endsWithADot.").
> 
> It was a little more involved:
> 
> -- 8< --
> [PATCH] git-mv: add more path normalization
> 
> We already use the normalization from get_pathspec(), but now we also
> remove a trailing slash. So,
> 
> 	git mv some_path/ into_some_path/
> 
> works now.
> 
> Also, move the "can not move directory into itself" test before the
> subdirectory expansion.
> 

It works as expected now. Thanks!

- Fredrik
