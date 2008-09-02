From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: Unexpected behaviour with git stash save --keep-index?
Date: Tue, 2 Sep 2008 09:45:16 +0200
Message-ID: <20080902074516.GA5402@diana.vm.bytemark.co.uk>
References: <B1185033-36D7-4504-92A3-6F75B6CE90DF@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonas =?iso-8859-1?Q?Flod=E9n?= <jonas.floden@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 02 09:24:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaQFP-00061e-CJ
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 09:24:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751675AbYIBHXM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Sep 2008 03:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751670AbYIBHXM
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 03:23:12 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4760 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751517AbYIBHXM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 03:23:12 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KaQZg-0001Wd-00; Tue, 02 Sep 2008 08:45:16 +0100
Content-Disposition: inline
In-Reply-To: <B1185033-36D7-4504-92A3-6F75B6CE90DF@gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94655>

On 2008-09-02 01:14:10 +0200, Jonas Flod=E9n wrote:

> while I was using StGit for the first time
[...]
> Also maybe someone could someone recommend a way to split an unclean
> working dir into several patches/commits?

This is what I usually do:

  1. Create a new StGit patch with all the changes.

  2. Pop that patch.

  3. View the patch in an emacs diff-mode buffer, and repeatedly

       a. apply one or more hunks, and

       b. create a new patch with just those changes

     until no more changes remain.

Another way to do it would be to

  1. Use e.g. git-gui to stage the changes you want in your first
     patch.

  2. Make an StGit patch out of just that (with e.g. stg new and stg
     refresh --index).

  3. If the worktree is still dirty, go to step 1.

A third method I usually make use of is to commit very often while
developing, and periodically clump these microcommits together into
larger commits. This sidesteps the whole problem of splitting up a
commit into pieces, which can be quite a chore if splitting on hunk
boundaries isn't enough. (stg coalesce will turn two or more smaller
patches into one large patch for you. And I'm pretty sure git-rebase
--interactive has some equivalent functions.)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
