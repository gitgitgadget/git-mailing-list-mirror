From: Jon Loeliger <jdl@freescale.com>
Subject: Re: Some ASCII Art
Date: Fri, 07 Oct 2005 14:35:50 -0500
Message-ID: <1128713749.29904.84.camel@cashmere.sps.mot.com>
References: <1128621923.29904.30.camel@cashmere.sps.mot.com>
	 <7v8xx67559.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 07 21:36:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENy0e-0000w1-JT
	for gcvg-git@gmane.org; Fri, 07 Oct 2005 21:36:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030495AbVJGTf4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Oct 2005 15:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030514AbVJGTf4
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Oct 2005 15:35:56 -0400
Received: from az33egw01.freescale.net ([192.88.158.102]:61369 "EHLO
	az33egw01.freescale.net") by vger.kernel.org with ESMTP
	id S1030495AbVJGTf4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Oct 2005 15:35:56 -0400
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id j97JkV5P017245;
	Fri, 7 Oct 2005 12:46:31 -0700 (MST)
Received: from [10.82.19.2] (cashmere.am.freescale.net [10.82.19.2])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id j97Jg7uw002763;
	Fri, 7 Oct 2005 14:42:07 -0500 (CDT)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v8xx67559.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.ydl.1) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9812>

On Thu, 2005-10-06 at 15:38, Junio C Hamano wrote:
> Jon Loeliger <jdl@freescale.com> writes:
> 
> > Fundamental Git Index Operations
> > Git Index Operations
> 
> These two look almost the same.

Yeah, the first one was intended to capture the
operations discussed the first four points of the
"The Workflow" section of the main Git doc page.

The second is "more of same", but the one picture with
every ASCII arc on it was getting confusing and crowded.

> I find the label "commit-tree" on index -> odb in the second
> picture a bit misleading.  "commit-tree" takes a tree and zero
> or more commit objects to create a new commit object, so it
> works solely inside odb.

Ah!  Of course.  Thanks!

> It is good that you mention that "read-tree -u" form updates
> working tree in the second picture.

Discovering how this related was a key insight for me. :-)

>   In the same spirit, you
> might also want to mention that "checkout-index -u" updates the
> index (i.e. matches the stat information) in the same picture.

Ooh.  Yes!  Good idea.


> > Commit DAG Revision Naming
> > ==========================
> >
> > Both node B and C are a commit parents of node A.
> 
> I assume that parents are left to right in this picture, that
> is, B's first parent is D, second E, and third F.

Yeah, I even meant to add that sentence before
sending the mail. 

> > Is there a way to name node C, E, F, H, I or J?
> 
> C = A^2
> E = B^2 = A^^2
> F = B^3 = A^^3
> H = D^2 = B^^2 = A^^^2 = A~2^2
> I = F^ = B^3^ = A^^3^
> J = F^2 = B^3^2 = A^^3^2

Ah!

> They look like line noise ;-)

Indeed. :-)

Would it be a useful option to git-show-branch
that would state the commit SHA1s as well?

    % git show-branch --show-revs

    * [master] Merge paul's branch
     ! [origin] Fix drm 'debug' sysfs permissions
      ! [paul] powerpc: Fix idle.c compile warning
    ---
    +   [06a41091c93e529e6cef68ba60deeb1b9ceabc7f] Merge paul's branch
    + + [05f62a5c049845eab8dfb3aeda55c18a2d4396e3] powerpc: Fix idle.c compile warning
    + + [c16ff7e44883afc05cbf6fde0e6913bb10c66885] powerpc: Define a _sdata symbol
    + + [8dad3f9257414f151cd821bfe01f54d7f52d2507] powerpc: Merge traps.c a bit more
    + + [b3491269f5604e4265ee2f27b47a76ce1e3678b6] powerpc: Use the merged of_device.c with ARCH=powerpc


Thanks for your feedback!

jdl
