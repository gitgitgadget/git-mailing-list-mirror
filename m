From: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>
Subject: Re: [PATCH] guilt: add git commit level versioning
Date: Thu, 9 Oct 2008 11:54:45 -0400
Message-ID: <20081009155445.GF27647@josefsipek.net>
References: <1223431722-12259-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
X-From: git-owner@vger.kernel.org Thu Oct 09 17:57:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Knxrr-0004ov-D9
	for gcvg-git-2@gmane.org; Thu, 09 Oct 2008 17:55:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751812AbYJIPyr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2008 11:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752129AbYJIPyr
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Oct 2008 11:54:47 -0400
Received: from josefsipek.net ([141.211.133.196]:51051 "EHLO josefsipek.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750996AbYJIPyq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2008 11:54:46 -0400
Received: by josefsipek.net (Postfix, from userid 1000)
	id C67E11C00DEE; Thu,  9 Oct 2008 11:54:45 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1223431722-12259-1-git-send-email-paul.gortmaker@windriver.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97864>

On Tue, Oct 07, 2008 at 10:08:42PM -0400, Paul Gortmaker wrote:
> Shamelessly steal the dynamic versioning goodies from git
> itself.  Now when you do "guilt --version" you can expect to
> see things like:
> 
> 	Guilt version 0.31.2.14.gece1.dirty
> 
> assuming you've 14 commits since 0.31.2 and also some changes
> that you've not committed yet.

Good idea. I've been pondering how to do this a while back, but never got
around to actually do it.

One comment: Why not keep the default version in guilt? You're running sed
on it anyway.  This makes releasing identical to what it was before the
patch:
	<edit guilt to reflect new version, commit>
	git tag -u abcdef v0.xy
	git archive --tar v0.xy | gzip -9 > guilt-0.xy.tar.gz

Additionally, things won't "break" for folks running right out of the git
repo - I just add the git repo dir to my $PATH.

Josef 'Jeff' Sipek.

-- 
Keyboard not found!
Press F1 to enter Setup
