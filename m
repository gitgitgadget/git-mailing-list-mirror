From: Jan =?UTF-8?B?S3LDvGdlcg==?= <jk@jk.gs>
Subject: Re: Hey - A Conceptual Simplication....
Date: Wed, 18 Nov 2009 14:25:12 +0100
Message-ID: <20091118142512.1313744e@perceptron>
References: <005a01ca684e$71a1d710$54e58530$@com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, torvalds@osdl.org
To: "George Dennie" <gdennie@pospeople.com>
X-From: git-owner@vger.kernel.org Wed Nov 18 14:25:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAkXI-00032o-FV
	for gcvg-git-2@lo.gmane.org; Wed, 18 Nov 2009 14:25:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756831AbZKRNZP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Nov 2009 08:25:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756689AbZKRNZO
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Nov 2009 08:25:14 -0500
Received: from zoidberg.org ([88.198.6.61]:52765 "EHLO cthulhu.zoidberg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756676AbZKRNZN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Nov 2009 08:25:13 -0500
Received: from perceptron (xdsl-78-35-161-253.netcologne.de [::ffff:78.35.161.253])
  (IDENT: unknown, AUTH: LOGIN jast, TLS: TLSv1/SSLv3,128bits,AES128-SHA)
  by cthulhu.zoidberg.org with esmtp; Wed, 18 Nov 2009 14:25:14 +0100
  id 004D0137.4B03F5BE.00000AAF
In-Reply-To: <005a01ca684e$71a1d710$54e58530$@com>
X-Mailer: Claws Mail 3.7.3 (GTK+ 2.18.3; i486-pc-linux-gnu)
X-Obscure-Spam: http://music-jk.net/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133167>

Hi,

> The result is conceptual complexity and rather counter-intuitive
> behavior. For example, adding and renaming files outside of Git is
> not considered editing the version until you subsequently do a "Git
> Add ." Contrast that with editing or deleting files outside of Git.
> Yet adding and renaming files and folders is a significant part of
> substantive projects, especially in the early stages and experimental
> branches.

yet even now, people routinely add huge amounts of files they didn't
actually want to add, and then have to expend a huge amount of effort
to get them out of the history again (particularly if that history has
already been published).

What you are describing is a workflow that is even fuller of potential
for wrong turns than the current standard workflow is. If simplicity
leads to a greater potential for errors, how is it a good thing?

This kind of workflow actually involves more work for the user. She now
has to meticulously maintain an accurate list of ignore patterns,
particularly because of this:

> Also can we augment checkout to totally CLEAN the working directory
> prior to a restore. If necessary we can augment .gitignore to
> stipulate those files or folders that should be excluded from the
> cleaning.

So if I forget to add a certain pattern, my file is lost forever? Uhh...

> This suggestion is in recognition of the fact that if you
> are not versioning the file, it is typically trash

Just how typical is that, though? I wouldn't want to be the one to
judge that.

In light of my concerns, I oppose adding your suggestions to the
official CLI of git and I suggest that you create your own commands to
enable this kind of workflow. For example:

git config --global alias.commitx '!git add . && git commit'
git config --global alias.checkoutx '!git clean && git checkout'

Jan
