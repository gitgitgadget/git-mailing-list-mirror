From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] filter-branch: always export GIT_DIR if it is set
Date: Tue, 5 Jun 2007 18:27:15 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706051823140.4046@racer.site>
References: <20070603144401.GA9518@moooo.ath.cx> <20070603144714.GD20061@moooo.ath.cx>
 <7vodjudei2.fsf@assigned-by-dhcp.cox.net> <20070605164957.GA12358@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Matthias Lederhofer <matled@gmx.net>
X-From: git-owner@vger.kernel.org Tue Jun 05 19:29:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvcqY-0007AP-Tx
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 19:29:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753393AbXFER3X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jun 2007 13:29:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753396AbXFER3X
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jun 2007 13:29:23 -0400
Received: from mail.gmx.net ([213.165.64.20]:53530 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753393AbXFER3W (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2007 13:29:22 -0400
Received: (qmail invoked by alias); 05 Jun 2007 17:29:21 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp030) with SMTP; 05 Jun 2007 19:29:21 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+oBC9axHSobNyWt3pOdwbbLzS2ZBsgd/GnSkDHdM
	ITYs0x1vi7MZ7g
X-X-Sender: gene099@racer.site
In-Reply-To: <20070605164957.GA12358@moooo.ath.cx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49213>

Hi,

On Tue, 5 Jun 2007, Matthias Lederhofer wrote:

> diff --git a/git-filter-branch.sh b/git-filter-branch.sh
> index 0c8a7df..f4cfbea 100644
> --- a/git-filter-branch.sh
> +++ b/git-filter-branch.sh
> @@ -313,9 +313,12 @@ workdir="$(pwd)"
>  
>  case "$GIT_DIR" in
>  /*)
> +	export GIT_DIR
> +	export GIT_WORK_TREE=.
>  	;;

Doesn't it strike somebody else as intrusive, if GIT_WORK_TREE has to 
touch that many places?

IMHO there should be a less intrusive, and possibly simpler, way to do it. 
I am not at all interested in that feature, and I don't want to suffer 
bugs from it either.

Ciao,
Dscho
