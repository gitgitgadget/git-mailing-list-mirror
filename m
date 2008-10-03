From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Broken index file - any hope?
Date: Fri, 3 Oct 2008 14:53:19 -0700
Message-ID: <20081003215319.GX21310@spearce.org>
References: <48E693E9.708@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jonas Schneider <JonasSchneider@gmx.de>
X-From: git-owner@vger.kernel.org Fri Oct 03 23:54:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Klsbb-0007vj-DK
	for gcvg-git-2@gmane.org; Fri, 03 Oct 2008 23:54:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753383AbYJCVxV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2008 17:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753376AbYJCVxV
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Oct 2008 17:53:21 -0400
Received: from george.spearce.org ([209.20.77.23]:43855 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753358AbYJCVxU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2008 17:53:20 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id DD3FE3835F; Fri,  3 Oct 2008 21:53:19 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <48E693E9.708@gmx.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97456>

Jonas Schneider <JonasSchneider@gmx.de> wrote:
> I come from the Ruby on Rails world, where Git is now spreading like ...  
> duh, something fast.
> Today I sadly lost my complete .git directory, only the working copy was  
> left behind.
> I reconstructed the directory, but the index file seems to be corrupt,  
> every command just tells me about a bad signature.
> I hope the rest of the repository is intanct. If it is, is there any  
> chance to restore/rebuild that index file from the rest?
> I don't have an idea of the internals of git, but I know the objects are  
> stored in different files, and maybe on top of that
> I could rebuild the index file.

Give this a shot:

  git read-tree --reset HEAD
  git status

at worst you lose staged changes.  At best you recover the index
file.

-- 
Shawn.
