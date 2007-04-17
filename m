From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Weird shallow-tree conversion state, and branches of shallow
 trees
Date: Tue, 17 Apr 2007 00:16:42 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0704162346550.27922@iabervon.org>
References: <20070412005336.GA18378@curie-int.orbis-terrarum.net>
 <fcaeb9bf0704142257x3761ef2cie3996420b3bcd24a@mail.gmail.com>
 <Pine.LNX.4.64.0704151115270.5473@woody.linux-foundation.org>
 <200704152051.35639.andyparkins@gmail.com> <Pine.LNX.4.64.0704151317180.5473@woody.linux-foundation.org>
 <20070416021729.GH2689@curie-int.orbis-terrarum.net> <20070416030103.GB27533@thunk.org>
 <20070416033209.GI2689@curie-int.orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Theodore Tso <tytso@mit.edu>,
	Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andy Parkins <andyparkins@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "Robin H. Johnson" <robbat2@gentoo.org>
X-From: git-owner@vger.kernel.org Tue Apr 17 06:16:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hdf7Y-0008WJ-0Q
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 06:16:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753644AbXDQEQp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 00:16:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753918AbXDQEQp
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 00:16:45 -0400
Received: from iabervon.org ([66.92.72.58]:4052 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753644AbXDQEQo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 00:16:44 -0400
Received: (qmail 29540 invoked by uid 1000); 17 Apr 2007 04:16:42 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 17 Apr 2007 04:16:42 -0000
In-Reply-To: <20070416033209.GI2689@curie-int.orbis-terrarum.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44719>

On Sun, 15 Apr 2007, Robin H. Johnson wrote:

> The checksum file (named Manifest) we are talking about is for a single
> subdirectory, and is signed as proof that it was not modified between
> the developer and submission to the tree. 

So the process has to be:

1. Developer commits changes to files.
2. Checksum utility finds the checksums of the files with IDs added where 
   the master site updater will add them.
3. Developer signs checksums.
4. Developer commits checksums.
5. Developer pushes changes to master site.
6. Master site checks out files, adds IDs, and updates live tree.
7. End user fetches tree.
8. End user checks checksums, which match, because the master site and the 
   developer checksum scripts agree on what the end user will see.

The only difference is that developers working out of the version control 
have to generate the checksums with a tool that knows how the IDs will be 
added, and check the checksums with this tool as well, because working 
directories don't have IDs in them.

Really, it's approximately the same as having the version control system 
do it, except that it's in the project-specific development tools instead 
of the version control system.

	-Daniel
*This .sig left intentionally blank*
