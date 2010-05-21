From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Migrate an svn repo to git - Where did all the branches got? and tags?
Date: Fri, 21 May 2010 11:41:45 +0200
Message-ID: <201005211141.45664.trast@student.ethz.ch>
References: <CFE20E75-F23D-41EA-89AA-2FF59BFA5DF9@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Jack Moore <jhmoore719@verizon.net>
X-From: git-owner@vger.kernel.org Fri May 21 11:42:22 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFOkG-0008Rw-LP
	for gcvg-git-2@lo.gmane.org; Fri, 21 May 2010 11:42:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758230Ab0EUJmL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 May 2010 05:42:11 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:6038 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756193Ab0EUJmJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 May 2010 05:42:09 -0400
Received: from CAS02.d.ethz.ch (129.132.178.236) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Fri, 21 May
 2010 11:42:07 +0200
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.254.0; Fri, 21 May
 2010 11:41:45 +0200
User-Agent: KMail/1.13.3 (Linux/2.6.31.12-0.2-desktop; KDE/4.4.3; x86_64; ; )
In-Reply-To: <CFE20E75-F23D-41EA-89AA-2FF59BFA5DF9@verizon.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147443>

Jack Moore wrote:
>    git svn clone --no-metadata -t tags -b branches -T trunk <repo-url>
[...]
>   git-repo/.git/refs/tags
> 
> is empty.
[...]
> If I do a 
> 
> 	git branch -r
> 
> the branches and tags show up as remote branches.

That's how git-svn currently works.

To turn all remote branches into local branches you can use the
following trick (don't do this in any repo other than a fresh git-svn
clone unless you understand what it does!):

  git fetch . 'refs/remotes/*:refs/heads/*'

To further clean up history and turn svn tagging commits into real
tags, you can refer, e.g., to the last section of

  http://kb.curseforge.com/repositories/convert-svn-to-git/

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
