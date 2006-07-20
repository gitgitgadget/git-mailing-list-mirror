From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] tar-tree: add the "tar.applyUmask" config option
Date: Thu, 20 Jul 2006 10:14:02 +0200
Message-ID: <44BF3B4A.5040109@lsrfire.ath.cx>
References: <20060719214025.GA10997@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	torvalds@osdl.org
X-From: git-owner@vger.kernel.org Thu Jul 20 10:14:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G3Tfi-0002mU-SW
	for gcvg-git@gmane.org; Thu, 20 Jul 2006 10:14:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932569AbWGTIOM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Jul 2006 04:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932570AbWGTIOM
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Jul 2006 04:14:12 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:5072
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S932569AbWGTIOK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jul 2006 04:14:10 -0400
Received: from [10.0.1.3] (p508E5F3C.dip.t-dialin.net [80.142.95.60])
	by neapel230.server4you.de (Postfix) with ESMTP id 5F541801B;
	Thu, 20 Jul 2006 10:14:09 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
To: Willy Tarreau <w@1wt.eu>
In-Reply-To: <20060719214025.GA10997@1wt.eu>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24021>

Hi Willy,

I kind of like the change, because it gives the user more control.
Theoretically this would not be needed, because tar can apply the
umask at extract time just fine.  In practice I can't see why we
should forbid users from creating the archives just the way they
like them, no matter what their reasoning might be.

Willy Tarreau schrieb:
> +tar.applyUmask::
> +	By default, git-link:git-tar-tree[1] sets file and directories modes
> +	to 0666 or 0777. While this is both useful and acceptable for projects
> +	such as the Linux Kernel, it might be excessive for other projects.
> +	Setting this variable to true makes git-link:git-tar-tree[1] apply the
> +	umask to the modes above. This should be enough for most projects, as
> +	it will lead to the same permissions as git-link:git-checkout[1] would
> +	use. The default is false.

Comments about why this change is needed and that it is sufficient
should go into the commit message.  For the rest of the patch:

Acked-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
