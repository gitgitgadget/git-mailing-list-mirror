From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 5/7] Bisect: factorise some logging into "bisect_write".
Date: Sun, 14 Oct 2007 17:07:46 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710141706440.25221@racer.site>
References: <20071014142948.9f08b8ed.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio Hamano <junkio@cox.net>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sun Oct 14 18:08:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ih60e-0007Hp-0Q
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 18:08:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753065AbXJNQHw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2007 12:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754148AbXJNQHw
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 12:07:52 -0400
Received: from mail.gmx.net ([213.165.64.20]:36863 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752946AbXJNQHv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2007 12:07:51 -0400
Received: (qmail invoked by alias); 14 Oct 2007 16:07:49 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp052) with SMTP; 14 Oct 2007 18:07:49 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Qt3N6eAAQe8HygR5QowWwa0OdWZwZw1fWNScGNP
	iXrDpL9KgvVTj3
X-X-Sender: gene099@racer.site
In-Reply-To: <20071014142948.9f08b8ed.chriscool@tuxfamily.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60858>

Hi,

On Sun, 14 Oct 2007, Christian Couder wrote:

> diff --git a/git-bisect.sh b/git-bisect.sh
> index 847250c..e12125f 100755
> --- a/git-bisect.sh
> +++ b/git-bisect.sh
> @@ -132,6 +131,7 @@ bisect_write() {
>  	esac
>  	echo "$rev" >"$GIT_DIR/refs/bisect/$tag"
>  	echo "# $state: "$(git show-branch $rev) >>"$GIT_DIR/BISECT_LOG"
> +	test -z "$nolog" && echo "git-bisect $state $rev" >>"$GIT_DIR/BISECT_LOG"
>  }

Isn't a nolog="$3" missing from bisect_write()?

Ciao,
Dscho
