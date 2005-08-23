From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-ls-new-files & make patch, pull, etc.
Date: Tue, 23 Aug 2005 08:48:26 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0508230846180.26600@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <430A84D1.2050206@linuxmachines.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 23 08:49:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E7SaN-0003rW-5R
	for gcvg-git@gmane.org; Tue, 23 Aug 2005 08:48:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750791AbVHWGs0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Aug 2005 02:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750792AbVHWGs0
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Aug 2005 02:48:26 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:27084 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750791AbVHWGsZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Aug 2005 02:48:25 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id D4917137314; Tue, 23 Aug 2005 08:48:24 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id B9F63B0C0F; Tue, 23 Aug 2005 08:48:24 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 8508DB0C0D; Tue, 23 Aug 2005 08:48:24 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx67.rz.uni-wuerzburg.de [132.187.3.67])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 68B27137314; Tue, 23 Aug 2005 08:48:24 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Jeff Carr <jcarr@linuxmachines.com>
In-Reply-To: <430A84D1.2050206@linuxmachines.com>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, 22 Aug 2005, Jeff Carr wrote:

> patch:
> 	git-diff-files -p

"git diff"

> push:
> 	git-send-pack `cat .git/branches/origin`

"git push origin" (or maybe "git push HEAD:origin")

> pull:
> 	git-pull-script `cat .git/branches/origin`
> 	git-read-tree -m HEAD
> 	git-checkout-cache -q -f -u -a

"git pull origin"

> commit:
> 	vi changelog.txt
> 	GIT_AUTHOR_NAME="$(GIT_AUTHOR_NAME)" \
> 	GIT_AUTHOR_EMAIL="$(GIT_AUTHOR_EMAIL)" \
> 	git-commit-tree `git-write-tree` -p $(HEAD) < changelog.txt > .git/HEAD
> 	rm changelog.txt

"git commit"

> add_all:
> 	./git-ls-new-files |xargs -n 1 git-update-cache --add

"git add $(git ls-files --others)"

Ciao,
Dscho
