From: Charles Bailey <charles@hashpling.org>
Subject: Re: how to start with non-master branch?
Date: Sun, 19 Jul 2009 18:44:41 +0100
Message-ID: <20090719174441.GA14556@hashpling.org>
References: <f46c52560907190553x4e21ffbdn6d55c43f2d6b08ad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Rustom Mody <rustompmody@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 19 19:45:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSaRa-0005OL-Km
	for gcvg-git-2@gmane.org; Sun, 19 Jul 2009 19:45:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754910AbZGSRor (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jul 2009 13:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754856AbZGSRoq
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Jul 2009 13:44:46 -0400
Received: from relay.pcl-ipout02.plus.net ([212.159.7.100]:3299 "EHLO
	relay.pcl-ipout02.plus.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754851AbZGSRop (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Jul 2009 13:44:45 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApoEAMf3YkrUnw6S/2dsb2JhbADLFYQMBQ
Received: from ptb-relay02.plus.net ([212.159.14.146])
  by relay.pcl-ipout02.plus.net with ESMTP; 19 Jul 2009 18:44:44 +0100
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by ptb-relay02.plus.net with esmtp (Exim) id 1MSaRI-0002IV-3x; Sun, 19 Jul 2009 18:44:44 +0100
Received: from cayley.hashpling.org (cayley.hashpling.org [192.168.76.254])
	by hashpling.plus.com (8.14.2/8.14.2) with ESMTP id n6JHih0l015189
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 19 Jul 2009 18:44:43 +0100
Received: (from charles@localhost)
	by cayley.hashpling.org (8.14.2/8.14.2/Submit) id n6JHifIJ015188;
	Sun, 19 Jul 2009 18:44:41 +0100
Content-Disposition: inline
In-Reply-To: <f46c52560907190553x4e21ffbdn6d55c43f2d6b08ad@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Plusnet-Relay: fe185566a6813073b9e00afa8b6f44f2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123557>

On Sun, Jul 19, 2009 at 06:23:32PM +0530, Rustom Mody wrote:
> I want my first commit to be on a non-master branch.
> So after the git init I do
> $ git checkout -b newbranch
> 
> I get
> fatal: You are on a branch yet to be born
> 
> Of course I can get by with making the first commit on master and then
> switching.
> 
> But wondering if I am missing something basic?

The problem with git checkout -b newbranch is that it tries to create
a new branch based on your current HEAD. As you have no commits, your
HEAD doesn't point at a commit ant this can't work. To change the name
of your current branch before you've made any commits, you can use the
symbolic-ref command to update your HEAD to point to a differently
named branch (that also doesn't yet exist). Try this:

git symbolic-ref HEAD refs/heads/non-master

and then carry on adding and committing as before.

Charles.

-- 
Charles Bailey
http://ccgi.hashpling.plus.com/blog/
