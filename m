From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [EGIT PATCH] Support linked resources
Date: Sat, 26 Jul 2008 17:07:18 +0200
Message-ID: <200807261707.18299.robin.rosenberg.lists@dewire.com>
References: <5a27b7b0807232034t564e8d45l9f6e4bc6429cda60@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Richie Vos" <jerry.vos@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 26 17:09:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMlOO-0002xK-2B
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 17:09:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752396AbYGZPII (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 11:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752182AbYGZPIG
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 11:08:06 -0400
Received: from av9-2-sn3.vrr.skanova.net ([81.228.9.186]:50499 "EHLO
	av9-2-sn3.vrr.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752332AbYGZPIG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 11:08:06 -0400
Received: by av9-2-sn3.vrr.skanova.net (Postfix, from userid 502)
	id AEA9F380F0; Sat, 26 Jul 2008 17:08:02 +0200 (CEST)
Received: from smtp3-1-sn3.vrr.skanova.net (smtp3-1-sn3.vrr.skanova.net [81.228.9.101])
	by av9-2-sn3.vrr.skanova.net (Postfix) with ESMTP
	id 5A28137E9A; Sat, 26 Jul 2008 17:08:02 +0200 (CEST)
Received: from [10.3.4.244] (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp3-1-sn3.vrr.skanova.net (Postfix) with ESMTP id E251F37E45;
	Sat, 26 Jul 2008 17:08:01 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <5a27b7b0807232034t564e8d45l9f6e4bc6429cda60@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90235>

torsdagen den 24 juli 2008 05.34.06 skrev Richie Vos:
> I have a project that outputs to a linked directory (for example the
> project is in /projects/foo and the project outputs to /projects/bar).
> This was causing egit to throw a bunch of "file is not in working
> path" errors whenever I rebuilt the project or otherwise interacted
> with that linked directory. I tracked it down to GitIndex's add/remove
> being called on these files even though these files are not part of
> the actual index.
> 
> It seems like egit shouldn't be trying to interact with the index on
> these files, and after looking at it, I decided the best solution
> would be to realize in the RepositoryMapping that these files do not
> point to a repository.

I'd be inclined to prefer ignoring any non-plain resource, always. Linked
resources are either absolute or relative to a variable. Other than that 
there is an analogy to symbolic links. Git manages the link, not its
content (unless handled elsewhere). The link in this case is in the
.project file and thus managed there.

EGit could still managed the resource, but not via the link, but rather at
the place it is located, iff that happens to be in a project managed by Egit.

-- robin
