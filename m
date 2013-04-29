From: John Keeping <john@keeping.me.uk>
Subject: Re: Unexpected behavior of git-subtree
Date: Mon, 29 Apr 2013 19:20:52 +0100
Message-ID: <20130429182052.GN472@serenity.lan>
References: <1003348467.20130429193427@stzedn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steffen Jaeckel <steffen.jaeckel@stzedn.de>
X-From: git-owner@vger.kernel.org Mon Apr 29 20:21:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWshI-0002jC-Bc
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 20:21:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758572Ab3D2SVD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 14:21:03 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:42586 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758571Ab3D2SVB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 14:21:01 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 48C03606505;
	Mon, 29 Apr 2013 19:21:01 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.899
X-Spam-Level: 
X-Spam-Status: No, score=-12.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6Fi+mq10uUyP; Mon, 29 Apr 2013 19:21:00 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by coyote.aluminati.org (Postfix) with ESMTP id C0EA26064D7;
	Mon, 29 Apr 2013 19:21:00 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 3DC39161E48E;
	Mon, 29 Apr 2013 19:21:00 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jVF6F4Zh7P5y; Mon, 29 Apr 2013 19:20:57 +0100 (BST)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 868C3161E2F4;
	Mon, 29 Apr 2013 19:20:54 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <1003348467.20130429193427@stzedn.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222839>

On Mon, Apr 29, 2013 at 07:34:27PM +0200, Steffen Jaeckel wrote:
> lately I used git-subtree to integrate a submodule directly into a
> repository. Now I wanted to push the changes back to the original
> repository of the submodule and I was a bit surprised by what
> happened...
> 
> 
> ---- snip ----
> sjaeckel@T7400-003 /h/projects/my_project (develop)
> $ GIT_TRACE=2 git subtree push --prefix=lib/com_lib/ git@git.local:com_lib develop -b develop
> trace: exec: 'git-subtree' 'push' '--prefix=lib/com_lib/' 'git@git.local:com_lib' 'develop' '-b' 'develop'
> trace: run_command: 'git-subtree' 'push' '--prefix=lib/com_lib/' 'git@git.local:com_lib' 'develop' '-b' 'develop'
> trace: built-in: git 'rev-parse' '--parseopt' '--' 'push' '--prefix=lib/com_lib/' 'git@git.local:com_lib' 'develop' '-b' 'develop'
> trace: built-in: git 'rev-parse' '--git-dir'
> trace: built-in: git 'rev-parse' '--show-cdup'
> git push using:  git@git.local:com_lib develop
> trace: exec: 'git-subtree' 'split' '--prefix=lib/com_lib/'
> trace: run_command: 'git-subtree' 'split' '--prefix=lib/com_lib/'
> trace: built-in: git 'rev-parse' '--parseopt' '--' 'split' '--prefix=lib/com_lib/'
> trace: built-in: git 'rev-parse' '--git-dir'
> trace: built-in: git 'rev-parse' '--show-cdup'
> trace: built-in: git 'rev-parse' '--default' 'HEAD' '--revs-only'
> trace: built-in: git 'rev-parse' '--no-revs' '--no-flags'
> trace: built-in: git 'log' '--grep=^git-subtree-dir: lib/com_lib/*$' '--pretty=format:START %H%n%s%n%n%b%nEND%n' '8068a810709f6284b04a18ff38dbb72c36b8d9c6'
> trace: built-in: git 'rev-list' '--topo-order' '--reverse' '--parents' '8068a810709f6284b04a18ff38dbb72c36b8d9c6'
> trace: built-in: git 'rev-list' '--topo-order' '--reverse' '--parents' '8068a810709f6284b04a18ff38dbb72c36b8d9c6'
> 1/    102 (0)trace: built-in: git 'ls-tree' 'f6e1457d345029cf4d376ff3cf780cbb8c3080b4' '--' 'lib/com_lib'
> ..... loads of more git 'ls-tree'...
> 71/    102 (70)72/    102 (70)trace: built-in: git 'ls-tree' '48dc0efb9a148b1146b013554f8bf4635adf7a0d' '--' 'lib/com_lib'
> trace: built-in: git 'log' '-1' '--pretty=format:%T' '6299b48765e11302aca48cc9fca88735aeab7c54' '--'
> fatal: bad object 6299b48765e11302aca48cc9fca88735aeab7c54

Without knowing much about git-subtree, this looks like the culprit.  A
quick look at cmd_push in git-subtree.sh indicates that it doesn't check
for an error return from 'git subtree split --prefix=$prefix', so if
that goes wrong you end up doing:

    git push $repository :refs/heads/$refspec

which deletes the branch.

Can you try running this:

    git subtree split --prefix=lib/com_lib/

and see if that gives the same "fatal: bad object" message as above?
