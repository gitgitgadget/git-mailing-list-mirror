From: Johan Herland <johan@herland.net>
Subject: Re: [RFC] cgit in git?
Date: Thu, 11 Dec 2008 23:40:57 +0100
Message-ID: <200812112340.57223.johan@herland.net>
References: <8c5c35580812111348iceaf30dyb55183017cff5b1d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: Lars Hjemli <hjemli@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Seth Vidal <skvidal@fedoraproject.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 11 23:42:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAuFF-0000nm-Hv
	for gcvg-git-2@gmane.org; Thu, 11 Dec 2008 23:42:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759266AbYLKWlW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2008 17:41:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759259AbYLKWlV
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Dec 2008 17:41:21 -0500
Received: from smtp.getmail.no ([84.208.20.33]:57043 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758088AbYLKWlT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2008 17:41:19 -0500
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0KBQ00E6WHOTAW00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Thu, 11 Dec 2008 23:41:17 +0100 (CET)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0KBQ00IOBHO9UC20@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Thu, 11 Dec 2008 23:40:57 +0100 (CET)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0KBQ00M19HO9Q8I0@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Thu, 11 Dec 2008 23:40:57 +0100 (CET)
In-reply-to: <8c5c35580812111348iceaf30dyb55183017cff5b1d@mail.gmail.com>
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102835>

On Thursday 11 December 2008, Lars Hjemli wrote:
> Background: I've been asked by the fedora project how to package cgit.
> The problem is basically that cgit is designed to be statically linked
> with a specific git release (i.e. libgit.a and xdiff/lib.a).
>
> When manually building cgit from a tarball this isn't a problem:
> 'make get-git' will download the required git sources from kernel.org.
> But the buildsystem/policy used by the fedora project does not allow
> network access during package builds, and since it is quite unlikely
> that the git package always will match the exact release needed by the
> cgit package, I only see four options:
> 1) the fedora project makes a 'git-for-cgit' package containing the
> needed release of the git sources
> 2) the cgit release tarballs includes the needed git sources
> 3) the cgit sources are subtree-merged into git
> 4) cgit is modified to link against libgit2
>
> Option 1 seems unlikely to happen since such a 'git-for-cgit' package
> would basically require the fedora project to support two git
> packages.
>
> Option 2 is doable but still requires the fedora project to support
> two git packages (but now the 'git-for-cgit' package is hidden inside
> the cgit source tree). The good thing about this option is that it
> only requires some minor modifications to the cgit releases.
>
> Option 3 would solve the problem for the fedora project but is not for
> me to decide - it might become an extra maintenance burden on the git
> maintainer and community.
>
> Option 4 is the correct solution but not a very practical one; it's
> currently hard to predict when libgit2 will be ready for general
> (c)git use.
>
> Personally I'd love for option 3 to happen, hence this rfc.

Option 5: Include cgit as a submodule in git.git. Then it's available to 
those who want it, but not cloned/built by default.

If that doesn't pan out, I also support option #3.

I've been a happy cgit user for a number of months, and have yet to find a 
single issue where cgit is not better than or equal to gitweb. I have 
nothing bad to say about gitweb per se, but cgit simply offers me a better 
user experience, not least because of its blazing speed.


Have fun!

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
