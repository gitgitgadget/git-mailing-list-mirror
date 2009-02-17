From: Lars Noschinski <lars@public.noschinski.de>
Subject: Re: [PATCH v2] filter-branch -d: Export GIT_DIR earlier
Date: Tue, 17 Feb 2009 09:53:01 +0100
Message-ID: <20090217085301.GA7446@lars.home.noschinski.de>
References: <20090217083146.GA7338@lars.home.noschinski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 17 09:54:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZLiz-0002hW-SS
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 09:54:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110AbZBQIxI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 03:53:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751100AbZBQIxG
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 03:53:06 -0500
Received: from smtprelay08.ispgateway.de ([80.67.29.8]:37428 "EHLO
	smtprelay08.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751110AbZBQIxF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 03:53:05 -0500
Received: from [87.78.71.97] (helo=fruehjahrsmuede.home.noschinski.de)
	by smtprelay08.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <lars@public.noschinski.de>)
	id 1LZLhO-0004RK-4K; Tue, 17 Feb 2009 09:53:02 +0100
Received: from lars by fruehjahrsmuede.home.noschinski.de with local (Exim 4.69)
	(envelope-from <lars@public.noschinski.de>)
	id 1LZLhN-0001wJ-GG; Tue, 17 Feb 2009 09:53:01 +0100
Content-Disposition: inline
In-Reply-To: <20090217083146.GA7338@lars.home.noschinski.de>
User-Agent: mutt-ng/devel-r804 (Linux)
X-Df-Sender: 336680
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110338>

* Lars Noschinski <lars@public.noschinski.de> [09-02-17 09:31]:
>The improved error handling catches a bug in filter-branch when using
>-d pointing to a path outside any git repository:
>
>$ mkdir foo
>$ cd foo
>$ git init
>$ touch bar
>$ git add bar
>$ git commit -m bar
>$ cd ..
>$ git clone --bare foo
>$ cd foo.git
>$ git filter-branch -d /tmp/filter master
>fatal: Not a git repository (or any of the parent directories): .git
>
>This error message comes from git for-each-ref in line 224. GIT_DIR is
>set correctly by git-sh-setup (to the foo.git repository), but not
>exported (yet).

Ops, forgot the

Signed-off-by: Lars Noschinski <lars@public.noschinski.de>

Feel free to add it. I can also resend the patch.

   - Lars
