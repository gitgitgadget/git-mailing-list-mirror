From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: Users of git-check-files?
Date: Wed, 3 Aug 2005 19:46:00 +0200
Message-ID: <200508031946.01017.Josef.Weidendorfer@gmx.de>
References: <Pine.LNX.4.63.0508030109210.21304@wgmdd8.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.58.0508031014070.3258@g5.osdl.org> <7virymdirb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Aug 03 19:47:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0NK6-0002Jr-P2
	for gcvg-git@gmane.org; Wed, 03 Aug 2005 19:46:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262369AbVHCRq2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Aug 2005 13:46:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262370AbVHCRq2
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Aug 2005 13:46:28 -0400
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:9437 "EHLO
	mailout1.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S262369AbVHCRq1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2005 13:46:27 -0400
To: git@vger.kernel.org
User-Agent: KMail/1.8.2
In-Reply-To: <7virymdirb.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay2.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wednesday 03 August 2005 19:37, you wrote:
> Linus Torvalds <torvalds@osdl.org> writes:
> > I started out to make the "-f" flag to send-file work around it, but I
> > never finished that, partly because it really ends up being the same
> > thing as "git-fetch-pack" in reverse, which was against the whole point
> > of git-send-pack. Send-pack is meant to be an "update remote tree" thing,
> > with the assumption that the remote tree is a subset - and exactly that
> > assumption is what makes send-pack much cheaper than fetch-pack.
>
> I think in addition to the existing ref_newer() check, which
> makes sure you are advancing the remote head, not just replacing
> with something unrelated, making sure that we have objects
> referenced by ref->old_sha1 we obtained from the remote on our
> end for all branches involved would be the only thing needed.
> The latter the users should not even be able to override with
> the --force flag, of course, but we would remind them to pull
> from the other end first.

But my example shows that the error happens even with 2 branches totally 
unrelated to each other: if branch1 got a new commit, you can not push to
branch2 from another clone.

Why is it not enough to have all the history of a remote branch in the local 
clone to be able to push to this branch?

Josef
