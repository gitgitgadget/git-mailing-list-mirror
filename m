From: Stefan Monnier <monnier@iro.umontreal.ca>
Subject: Feature request: Tracking info for remote branches
Date: Fri, 03 Oct 2014 10:32:32 -0400
Message-ID: <jwvy4sxqm1a.fsf-monnier+gmane.comp.version-control.git@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 03 16:32:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xa3ue-0008IF-J0
	for gcvg-git-2@plane.gmane.org; Fri, 03 Oct 2014 16:32:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753288AbaJCOcs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2014 10:32:48 -0400
Received: from plane.gmane.org ([80.91.229.3]:48203 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752632AbaJCOcr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2014 10:32:47 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Xa3uX-0008FJ-TL
	for git@vger.kernel.org; Fri, 03 Oct 2014 16:32:45 +0200
Received: from 69-196-168-232.dsl.teksavvy.com ([69.196.168.232])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 03 Oct 2014 16:32:45 +0200
Received: from monnier by 69-196-168-232.dsl.teksavvy.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 03 Oct 2014 16:32:45 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 69-196-168-232.dsl.teksavvy.com
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4.50 (gnu/linux)
Cancel-Lock: sha1:S8rjkL9y5YvksSygaLVuP011+Uc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257839>

I really like the way Git officializes the relation between branches via
the notion of "tracking".  I can see which local branch tracks which
remote branch easily, and that's very helpful.

But when I find a Git repository on the Web, I often have no idea about
the relationship between its branches, all I have instead is the
branches's names, which is often not sufficient.

Let's take for example https://bitbucket.org/emiliolopez/linux.git.
Among its branches I see "sunxi-codec" and "sunxi-codec-v0".

The repository name gives me a hint that these are really
branches of the Linux kernel (rather than, say, branches of Emacs).
And the branches's names gice me a hint that these are related to
support for sunxi (aka Allwinner SoCs) and more specifically support
for codecs.  I know from out-of-band info that these are for audio
codecs.

But I don't know if these branches track linux-next, sunxi-devel, or
some other branch.  I can manually try to find out, by comparing the
distance to each one of those branches.  But:
- it's costly.
- it can only be done manually, because a script wouldn't know that
  linux-next and sunxi-devel are better candidate branches than, say,
  emacs-24.
- as a consequence, front ends (bitbucket, cgit, gitweb, younameit)
  can't show this information.

So, I'd like to suggest that Git be changed so that the branch tracking
information is also maintained and made available for remote branches.
E.g. when you push a branch, the info about which is the corresponding
target branch (if any) be also pushed to the remote repository along
with the actual new commits.  Similarly, when cloning a remote
repository, that information should be copied locally so you can ask Git
about the relationship between those remote branches you just downloaded.


        Stefan
