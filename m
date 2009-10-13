From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: backup git repo on every commit
Date: Tue, 13 Oct 2009 10:49:13 -0700
Message-ID: <20091013174913.GV9261@spearce.org>
References: <194a2c240910120641sccf0e55xef4226269df78864@mail.gmail.com> <20091012141544.GF9261@spearce.org> <194a2c240910120725u72cdb588p3c66bc730e6953d@mail.gmail.com> <20091012143043.GJ9261@spearce.org> <194a2c240910130943j40c12902o760e463e7a8ce8fa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Israel Garcia <igalvarez@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 13 19:55:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mxlag-0006ip-RH
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 19:55:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755080AbZJMRtu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2009 13:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753989AbZJMRtu
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Oct 2009 13:49:50 -0400
Received: from george.spearce.org ([209.20.77.23]:38211 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752991AbZJMRtt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2009 13:49:49 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id C93C4381FE; Tue, 13 Oct 2009 17:49:13 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <194a2c240910130943j40c12902o760e463e7a8ce8fa@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130171>

Israel Garcia <igalvarez@gmail.com> wrote:
> Sorry to ask again, but I'm a little confuse about how git work in my case.
> I use gitosis on a server where I have all repos
> (/usr/local/git/repositories/), so different people clone their repos
> on their computers. What I want is to backup, on gitosis server, all
> repos in /backups/git/repositories/ after every commit. So, my
> questions are:
> 
> Do I have to run these two comands on tha gitosis server?

Yes.

> The post-commit are execute on gitosis server or on the remote pc?

Actually, you need the post-update hook.  post-commit doesn't run
on the gitosis server.

I suggested post-commit because I thought you were talking about
backing up your local working directory each time you called
"git commit".  But since you are actually backing up every
"git push" you need to use the hooks invoked by that instead.
 
-- 
Shawn.
