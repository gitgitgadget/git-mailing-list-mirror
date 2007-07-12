From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: Volume of commits
Date: Thu, 12 Jul 2007 16:03:04 +0200
Message-ID: <20070712140304.GB28310@diana.vm.bytemark.co.uk>
References: <m3ps2xu5hc.fsf@pc7.dolda2000.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Fredrik Tolf <fredrik@dolda2000.com>
X-From: git-owner@vger.kernel.org Thu Jul 12 16:03:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8zGC-00043G-K3
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 16:03:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764137AbXGLODJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 12 Jul 2007 10:03:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763821AbXGLODI
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 10:03:08 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4282 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760165AbXGLODH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 10:03:07 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1I8zG4-0007ef-00; Thu, 12 Jul 2007 15:03:04 +0100
Content-Disposition: inline
In-Reply-To: <m3ps2xu5hc.fsf@pc7.dolda2000.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52292>

On 2007-07-12 15:16:47 +0200, Fredrik Tolf wrote:

> Or do you somehow aggregate the smaller commits into larger patches
> and recommit them? Or is there some third possibility that I'm
> missing?

Aggregating commits and recommitting is easy, so that's a common tool,
I'd say. But it's equally possible to take a large commit and pick it
apart, for example by editing the patch by hand and reapplying it, or
by using the hunk selection feature of git-gui.

=46or example, if you have just committed several changes as one big
commit, you can do

  $ git reset HEAD^

to undo the commit but retain the changes in your working tree, and
then use git-gui to select a subset of the changes and commit them,
then select another subset and commit that, and so on.

If you need to edit a commit that isn't HEAD, you can use git-reset to
go back to the commit you want to edit, do the editing, and then use
git-rebase to reapply the other commits on top of the changed commit.

In general, there are a thousand ways to use git to rewrite history,
either "by hand" or by using tools such as StGIT. (StGIT is what I
personally use most of the time. I find it a good tool for producing
readable patch series.)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
