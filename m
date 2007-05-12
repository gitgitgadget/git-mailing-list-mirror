From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: [PATCH] t9400: Use the repository config and nothing else.
Date: Sat, 12 May 2007 18:28:20 +0200
Message-ID: <20070512162819.GA7184@planck.djpig.de>
References: <7v8xbvj5mx.fsf@arte.twinsun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 12 18:28:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmuSM-0002jU-Lq
	for gcvg-git@gmane.org; Sat, 12 May 2007 18:28:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754933AbXELQ2Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 May 2007 12:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755118AbXELQ2Z
	(ORCPT <rfc822;git-outgoing>); Sat, 12 May 2007 12:28:25 -0400
Received: from planck.djpig.de ([85.10.192.180]:2216 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754375AbXELQ2Y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2007 12:28:24 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id C4417274014;
	Sat, 12 May 2007 18:28:21 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at planck.djpig.de
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (planck.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fb+DjmuBx4Zs; Sat, 12 May 2007 18:28:20 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id B38A1274013; Sat, 12 May 2007 18:28:20 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v8xbvj5mx.fsf@arte.twinsun.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47061>

On Fri, May 11, 2007 at 04:35:18PM -0700, Junio Hamano wrote:
> This needs to be fixed, but thanks to that bug, a separate bug
> in t9400 test script was discovered.  The test discarded
> GIT_CONFIG instead of pointing at the proper one to be used in
> the exoprted repository.  This allowed user's .gitconfig and (if
> exists) systemwide /etc/gitconfig to affect the outcome of the
> test, which is a big no-no.

Shouldn't you also remove the "unset GIT_CONFIG" then?

> @@ -26,6 +26,7 @@ perl -e 'use DBI; use DBD::SQLite' >/dev/null 2>&1 || {
>  unset GIT_DIR GIT_CONFIG
>  WORKDIR=$(pwd)
>  SERVERDIR=$(pwd)/gitcvs.git
> +git_config=$SERVERDIR/config
>  CVSROOT=":fork:$SERVERDIR"
>  CVSWORK=$(pwd)/cvswork

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
