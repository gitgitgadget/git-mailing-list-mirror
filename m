From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: several quick questions
Date: Tue, 14 Feb 2006 23:17:29 +0100
Message-ID: <200602142317.29626.Josef.Weidendorfer@gmx.de>
References: <43F20532.5000609@iaglans.de> <200602142230.11442.Josef.Weidendorfer@gmx.de> <7v7j7xr54u.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Feb 14 23:18:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F98Ue-0007Bn-Ix
	for gcvg-git@gmane.org; Tue, 14 Feb 2006 23:17:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422826AbWBNWRn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Feb 2006 17:17:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422829AbWBNWRn
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Feb 2006 17:17:43 -0500
Received: from tuminfo2.informatik.tu-muenchen.de ([131.159.0.81]:1781 "EHLO
	tuminfo2.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S1422826AbWBNWRm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2006 17:17:42 -0500
Received: from dhcp-3s-57.lrr.in.tum.de (dhcp-3s-57.lrr.in.tum.de [131.159.35.57])
	by mail.in.tum.de (Postfix) with ESMTP id 6751921B0
	for <git@vger.kernel.org>; Tue, 14 Feb 2006 23:17:41 +0100 (MET)
To: git <git@vger.kernel.org>
User-Agent: KMail/1.9.1
In-Reply-To: <7v7j7xr54u.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay2.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16184>

On Tuesday 14 February 2006 22:40, you wrote:
> Josef Weidendorfer <Josef.Weidendorfer@gmx.de> writes:
> 
> > Why not allow something like
> >
> > 	git-checkout master~5
> >
> > which implicitly does create a read-only branch "seek-point"?
> 
> Now what does "git-checkout branch" mean?  Does it switch to the
> branch, or does it force tip of seek-point to be the tip of
> branch and switch to seek-point branch?  More interestingly,
> what does "git-checkout seek-point" mean? 

You are right; it would get quite confusing.
But perhaps the current error message

  git checkout: you need to specify a new branch name

should be a little bit more explaining by appending

  "... to switch to for being able to checkout the requested revision"

> Having said that, I am not convinced in either way, though.

Me too. Specifying a branch name is easy enough.

> > And git-commit should refuse to commit on a readonly ref, telling
> > the user to create a writable branch before with "git-branch new".
> 
> Now, read-only ref does not interest me, but "do not commit on
> top of this yourself, only fast-forward from somewhere else is
> allowed" may be useful, for the reason why you mentioned
> "origin".

Yes. The idea to make the ref readonly to specify this intent was
a quick (not so good) idea.

Still, being able to specify that you can not commit on some branch
(as you said) is very useful to prohibit doing things by accident.
.git/config does not sound very good for such a thing, especially
if there could be other branch-specific properties in the future.

Josef
