From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 1/3] rebase: allow --merge option to handle patches merged upstream
Date: Sat, 24 Jun 2006 21:59:12 -0700
Message-ID: <20060625045912.GB17674@hand.yhbt.net>
References: <20060622110941.GA32261@hand.yhbt.net> <11511989902239-git-send-email-normalperson@yhbt.net> <Pine.LNX.4.63.0606250401490.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 25 06:59:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuMiM-0000bk-KD
	for gcvg-git@gmane.org; Sun, 25 Jun 2006 06:59:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367AbWFYE7O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Jun 2006 00:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751383AbWFYE7O
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jun 2006 00:59:14 -0400
Received: from hand.yhbt.net ([66.150.188.102]:64700 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751367AbWFYE7N (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Jun 2006 00:59:13 -0400
Received: by hand.yhbt.net (Postfix, from userid 500)
	id C78E67DC022; Sat, 24 Jun 2006 21:59:12 -0700 (PDT)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0606250401490.29667@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22588>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
> 
> On Sat, 24 Jun 2006, Eric Wong wrote:
> 
> > +		if test -n "`git-diff-index HEAD`"
> 
> This is not a sufficient test if the patch was already merged to upstream. 
> For example, you can have two patches which touched the same file, and one 
> of them was applied to upstream, the other not. The test fails to see 
> that. Or am I missing something?

This is just to tell if there's anything worth committing after a merge
is complete.  If not, then it assumes it's been a) merged upstream or b)
empty in the first place (very unlikely).

-- 
Eric Wong
