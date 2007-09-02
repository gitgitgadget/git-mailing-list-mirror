From: David Kastrup <dak@gnu.org>
Subject: Re: Large-scale configuration backup with GIT?
Date: Sun, 02 Sep 2007 22:37:43 +0200
Message-ID: <85642spzvs.fsf@lola.goethe.zz>
References: <20070902201724.GB10567@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
X-From: git-owner@vger.kernel.org Sun Sep 02 22:38:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRwCf-0001Xg-M9
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 22:37:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753323AbXIBUhr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 16:37:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751696AbXIBUhq
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 16:37:46 -0400
Received: from mail-in-10.arcor-online.net ([151.189.21.50]:51852 "EHLO
	mail-in-10.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751302AbXIBUhq (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Sep 2007 16:37:46 -0400
Received: from mail-in-14-z2.arcor-online.net (mail-in-14-z2.arcor-online.net [151.189.8.31])
	by mail-in-10.arcor-online.net (Postfix) with ESMTP id C3DD51F5CDB;
	Sun,  2 Sep 2007 22:37:44 +0200 (CEST)
Received: from mail-in-11.arcor-online.net (mail-in-11.arcor-online.net [151.189.21.51])
	by mail-in-14-z2.arcor-online.net (Postfix) with ESMTP id AD48A201001;
	Sun,  2 Sep 2007 22:37:44 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-038-061.pools.arcor-ip.net [84.61.38.61])
	by mail-in-11.arcor-online.net (Postfix) with ESMTP id 34ABF13EF1;
	Sun,  2 Sep 2007 22:37:44 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 9F3421C15372; Sun,  2 Sep 2007 22:37:43 +0200 (CEST)
In-Reply-To: <20070902201724.GB10567@lug-owl.de> (Jan-Benedict Glaw's message of "Sun\, 2 Sep 2007 22\:17\:24 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/4133/Sun Sep  2 18:44:55 2007 on mail-in-11.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57387>

Jan-Benedict Glaw <jbglaw@lug-owl.de> writes:

> I'm just thinking about storing our whole company's configuration into
> GIT, because I'm all too used to it. That is, there are configuration
> dumps of n*10000 routers and switches, as well as "regular"
> configuration files on server machines (mostly Linux and Solaris.)
> While probably all of the server machines could run GIT natively, we
> already have some scripts to dump all router's/switch's configuration
> to a Solaris system, so we could it import/commit from there. There
> might be a small number of Windows machines, but I guess these will be
> done by exporting the interesting stuff to Linux/Solaris machines...
>
> I initially thought about running a git-init-db on each machine's root
> directory and adding all interesting files, but that might hurt GIT's
> usage for single software projects on those machines, no?

It could break shell scripts, since
cd /;echo `pwd`/filename
does not return /filename.

I don't think that the root directory is a good place for starting
git.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
