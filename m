From: Ed Tomlinson <tomlins@cam.org>
Subject: Re: GIT 0.99.8d
Date: Sun, 16 Oct 2005 18:15:33 -0400
Organization: me
Message-ID: <200510161815.33833.tomlins@cam.org>
References: <7vachadnmy.fsf@assigned-by-dhcp.cox.net> <7vll0txqwu.fsf@assigned-by-dhcp.cox.net> <20051016185540.GA27162@fiberbit.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 17 00:17:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ERGn0-00078F-CI
	for gcvg-git@gmane.org; Mon, 17 Oct 2005 00:15:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750766AbVJPWPb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 16 Oct 2005 18:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750951AbVJPWPa
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Oct 2005 18:15:30 -0400
Received: from mail.aei.ca ([206.123.6.14]:18663 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S1750766AbVJPWPa (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Oct 2005 18:15:30 -0400
Received: from grover (dsl-155-76.aei.ca [66.36.155.76])
	by aeimail.aei.ca (8.12.10/8.12.10) with ESMTP id j9GMFPdf023114;
	Sun, 16 Oct 2005 18:15:25 -0400 (EDT)
To: Marco Roeland <marco.roeland@xs4all.nl>
User-Agent: KMail/1.8.2
In-Reply-To: <20051016185540.GA27162@fiberbit.xs4all.nl>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10175>

Hi,

This explains things.  I am not building via the debian package.  What happened is that
sid (amd64) dropped libcurl3-dev and I did not add one of the other packages...

Thanks
Ed

On Sunday 16 October 2005 14:55, Marco Roeland wrote:
> On Sunday October 16th 2005 Junio C Hamano wrote:
> 
> > > Debian users beware.  This version introduces a dependency - package: 
> > > libcurl3-gnutls-dev
> > > is now needed to build git.
> > 
> > Is this really true?  The one I uploaded was built on this
> > machine:
> > 
> > : siamese; dpkg -l libcurl\* | sed -ne 's/^ii  //p'
> > libcurl3          7.14.0-2       Multi-protocol file transfer library, now wi
> > libcurl3-dev      7.14.0-2       Development files and documentation for libc
> > 
> > Having said that, a tested patch to debian/control to adjust
> > Build-Depends is much appreciated.
> 
> The present line is correct. In 'debian/control' the line reads
> (word-wrapped here):
> 
> Build-Depends-Indep: libz-dev, libssl-dev,
>  libcurl3-dev|libcurl3-gnutls-dev|libcurl3-openssl-dev, asciidoc (>=
>  6.0.3), xmlto, debhelper (>= 4.0.0), bc
> 
> So it works correct on 'stable' versions ('libcurl3-dev') and
> latest 'unstable' as well, where you have the choice of either
> 'libcurl3-gnutls-dev' or 'libcurl3-openssl-dev'.
