From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH] auto-detect changed $prefix in Makefile and properly rebuild to avoid broken install
Date: Sun, 18 Jun 2006 13:24:04 +0200
Message-ID: <20060618112404.GA2446@diana.vm.bytemark.co.uk>
References: <0J0V00LDT7B9BU00@mxout2.netvision.net.il> <8aa486160606150426q19b0a661s@mail.gmail.com> <7vk67gbbe9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Santi <sbejar@gmail.com>, git@vger.kernel.org,
	Yakov Lerner <iler.ml@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 18 13:24:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrvO8-0002Dy-NQ
	for gcvg-git@gmane.org; Sun, 18 Jun 2006 13:24:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148AbWFRLYR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 18 Jun 2006 07:24:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751149AbWFRLYR
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jun 2006 07:24:17 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:62988 "EHLO
	diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP
	id S1751148AbWFRLYQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jun 2006 07:24:16 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1FrvNs-0000e2-00; Sun, 18 Jun 2006 12:24:04 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vk67gbbe9.fsf@assigned-by-dhcp.cox.net>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22072>

On 2006-06-16 22:26:38 -0700, Junio C Hamano wrote:

> I do not know what "stow" is about, but if it is to allow you to run
> make-install to install things in somewhere else, examine the
> result, and then move the result to the real location (implying that
> you should be able to nuke the "somewhere else" after you have done
> so), with the patch, the above sequence would install the binaries
> pointing at a wrong directory, because the second compilation would
> make them point at the temporary installation directory
> ~/usr/stow/git, not the final location ~/usr/.

GNU stow doesn't move installed programs, it just maintains symlinks
to them. You install programs under /usr/local/stow/foo-4.7.11, and
stow sets up symlinks to them under /usr/local. (So for example,
/usr/local/bin/foo would be a symlink to
/usr/local/stow/foo-4.7.11/bin/foo.) This gives you the ability to
nuke an installed program cleanly. And it just works, pathwise, since
the program remains in its original location.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
