From: Greg KH <greg@kroah.com>
Subject: Re: git clone stable-2.6.25.y fails over HTTP
Date: Wed, 4 Jun 2008 08:45:23 -0700
Message-ID: <20080604154523.GA25747@kroah.com>
References: <200806041511.m54FBPL9006783@pogo.cesa.opbu.xerox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andrew Klossner <andrew@cesa.opbu.xerox.com>
X-From: git-owner@vger.kernel.org Wed Jun 04 17:47:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3vDP-0000Ss-F1
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 17:47:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755615AbYFDPrC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 11:47:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753813AbYFDPrB
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 11:47:01 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:59681 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751283AbYFDPrA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2008 11:47:00 -0400
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174] helo=localhost)
	by pentafluge.infradead.org with esmtpsa (Exim 4.68 #1 (Red Hat Linux))
	id 1K3vCH-0006TL-Q1; Wed, 04 Jun 2008 15:46:58 +0000
Content-Disposition: inline
In-Reply-To: <200806041511.m54FBPL9006783@pogo.cesa.opbu.xerox.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83790>

On Wed, Jun 04, 2008 at 08:11:24AM -0700, Andrew Klossner wrote:
> Greg wrote:
> 
> > I don't think I remembered to run 'git-update-server-info' on the
> > repository.  I just did it, let me know if that works better or not.
> 
> I get the same error.
> 
>   -=- Andrew
> 
> % git clone http://www.kernel.org/pub/scm/linux/kernel/git/stable/linux-2 .6.25.y.git
> Initialized empty Git repository in /work/andrew/http-git/linux-2.6.25.y/.git/
> Getting alternates list for http://www.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.25.y.git
> Also look at http://www.kernel.org/home/ftp/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/
> Getting pack list for http://www.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.25.y.git
> Getting index for pack 6506d57e29d10a0ed9cca269f97296606aeb0b5b
> Getting index for pack 067caec25377d65e503d626a6c4f3f7e392406a3
> Getting index for pack 5434817c4def8a894fe4d61f55e8e4117485cbe7
> Getting pack 067caec25377d65e503d626a6c4f3f7e392406a3
>  which contains a82a9bfebc74862798a3f6949fe6f6a959c1fd4e
> walk a82a9bfebc74862798a3f6949fe6f6a959c1fd4e
> walk 15c2419876173c417a119b5665ecc62520e50a6c
> Getting pack list for http://www.kernel.org/home/ftp/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/
> error: Unable to find fdcce40226d7d4273a08cc4ef84bb25755a710a4 under http://www.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.25.y.git
> Cannot obtain needed blob fdcce40226d7d4273a08cc4ef84bb25755a710a4
> while processing commit 15c2419876173c417a119b5665ecc62520e50a6c.


Hm, I really do not know, and I can duplicate this myself as well.

<adding the git mailing list>

Does anyone know what's going on here?  The stable git trees are created
by doing:
	git clone -s --bare
from Linus's main tree to the stable tree repo location.

It looks like git over http isn't following the link somehow to the main
repo?

Or is what is necessary to do is to clone Linus's tree and then pull
from the stable tree in this kind of situation (where the user can only
use git over http?)

thanks,

greg k-h
