From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: Running 'git pull' from an unnamed branch
Date: Sun, 5 Apr 2009 23:42:44 +0200
Message-ID: <200904052342.44856.markus.heidelberg@web.de>
References: <3f4fd2640904051433u199587c3wc9bf080d138944e7@mail.gmail.com>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Reece Dunn <msclrhd@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Apr 05 23:44:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lqa8S-00074y-AA
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 23:44:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754610AbZDEVmk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2009 17:42:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754023AbZDEVmk
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 17:42:40 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:56936 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753551AbZDEVmk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 17:42:40 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate03.web.de (Postfix) with ESMTP id BC5A8FA01E96;
	Sun,  5 Apr 2009 23:42:37 +0200 (CEST)
Received: from [89.59.118.104] (helo=.)
	by smtp08.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1Lqa6v-00013l-00; Sun, 05 Apr 2009 23:42:37 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <3f4fd2640904051433u199587c3wc9bf080d138944e7@mail.gmail.com>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1+Raelr0w4UWeH2cjkntV65Wr+oRMY60861Z26/
	M+5/VR50mx8XrfbyFyN8acoPMh+jYXwUsABfnpMewIqv4vxzPi
	fN6vH8yLbbIgW37Ryw1Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115721>

Reece Dunn, 05.04.2009:
> Hi,
> 
> Here is something I have just recently tripped up on.
> 
> $ git pull
> 
> [..]
> 
> $ git branch
> * (no branch)
>   master
> 
> Running `git checkout master && git pull` fixed the above issue. The
> patch below improves the error message for users that are in this
> state.
> 
> Also, is "branch..remote" valid? Should this be "branch.remote"?

The current branch has no name, so there is nothing between the two
dots. For clarification: branch.(no branch).remote

> +	echo "You may not be on a branch. In this case, you need to move"
> +	echo "onto the branch you want to pull to (usually master):"
> +	echo "    git checkout <branch>"
> +	echo

Not being on a branch is not the general case when you receive this
message. Maybe determining if you are not on a branch and adjusting the
message acordingly is an option.

Markus
