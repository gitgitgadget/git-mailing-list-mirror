From: John Keeping <john@keeping.me.uk>
Subject: Re: .gitignore behavior on Mac
Date: Sat, 18 May 2013 19:41:36 +0100
Message-ID: <20130518184136.GH27005@serenity.lan>
References: <CAEe6bfD_1GjMBByaEFQ4RMTMaz8XZvd00mxyfaAHtXVpbUjj6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Peter Lauri <peterlauri@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 18 20:41:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Udm4j-0005yI-4n
	for gcvg-git-2@plane.gmane.org; Sat, 18 May 2013 20:41:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752956Ab3ERSln (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 May 2013 14:41:43 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:47742 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752738Ab3ERSlm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 May 2013 14:41:42 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id E135B606527;
	Sat, 18 May 2013 19:41:41 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -10.999
X-Spam-Level: 
X-Spam-Status: No, score=-10.999 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, URIBL_BLOCKED=0.001]
	autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w6wncZcMW5xu; Sat, 18 May 2013 19:41:41 +0100 (BST)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id C71916064D7;
	Sat, 18 May 2013 19:41:38 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <CAEe6bfD_1GjMBByaEFQ4RMTMaz8XZvd00mxyfaAHtXVpbUjj6A@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224802>

On Sat, May 18, 2013 at 08:36:42PM +0200, Peter Lauri wrote:
> Shouldn't this be valid? I would expect to NOT see the
> core/inc/config.inc.php in the "git status" output...
> 
> Peters-MacBook-Air:dt-git plauri$ cat .gitignore
> .buildpath
> .project
> .settings/
> web/pjotr.php
> core/inc/config.inc.php
> dt_error.log
> process_wrapper.sh
> 
> Peters-MacBook-Air:dt-git plauri$ git status
> # On branch local/DT-7_gantt
> # Changes not staged for commit:
> #   (use "git add <file>..." to update what will be committed)
> #   (use "git checkout -- <file>..." to discard changes in working directory)
> #
> # modified:   .gitignore
> # modified:   core/inc/config.inc.php

core/inc/config.inc.php is already in the repository.  Git won't ignore
files that are already tracked.

If you remove the file from the index:

    git rm --cached core/inc/config.inc.php

then you'll see it as deleted in "git status" but it won't appear in the
untracked files section even though it's still there in the working
tree.

> # Untracked files:
> #   (use "git add <file>..." to include in what will be committed)
> #
> # out.ionel
> # tree.py
> no changes added to commit (use "git add" and/or "git commit -a")
> Peters-MacBook-Air:dt-git plauri$
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
