From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: [RFC PATCH 2/2] Teach git-blame --gui how to start git-gui blame
Date: Fri, 22 Jun 2007 10:02:58 +0200
Organization: eudaptics software gmbh
Message-ID: <467B8232.B6BFDE4A@eudaptics.com>
References: <20070621045333.GB13977@spearce.org>
		<7vtzt13k4o.fsf@assigned-by-dhcp.pobox.com>
		<20070622035652.GD17393@spearce.org>
		<7vzm2sab63.fsf@assigned-by-dhcp.pobox.com>
		<20070622044716.GG17393@spearce.org> <7vps3oa7kf.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 22 10:32:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1eYw-0004vv-G9
	for gcvg-git@gmane.org; Fri, 22 Jun 2007 10:32:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752142AbXFVIcN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jun 2007 04:32:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752013AbXFVIcN
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jun 2007 04:32:13 -0400
Received: from main.gmane.org ([80.91.229.2]:59545 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751810AbXFVIcM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2007 04:32:12 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1I1eBN-0004Ip-Df
	for git@vger.kernel.org; Fri, 22 Jun 2007 10:07:53 +0200
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 22 Jun 2007 10:07:53 +0200
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 22 Jun 2007 10:07:53 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50683>

Junio C Hamano wrote:
> 
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > Junio C Hamano <gitster@pobox.com> wrote:
> >> This is only minor nuisance, but can we do something about this?
> >>
> >>  $ git gui --version
> >>  Application initialization failed: no display name and no $DISPLAY environment variable
> >>
> >> I know it is from wish, not you, so I wouldn't insist, though.
> >
> > Actually that should be fixable.
> >
> > Should be as simple as using a Bourne shell script up front to
> > check for "z$1" = zversion || "z$1" = z--version, and if so dump
> > back the version, otherwise exec wish.  This is actually quite easy
> > and won't change things for existing users.  I'll put a patch into
> > maint tonight for it.
> 
> If this makes life any harder to people on Windows, especially
> minGW, I would suggest against it.

The MinGW port's exec wrapper looks at the shbang line and runs the
shell. Hence, invocation as

  git gui --version

will work even from CMD.EXE. But

  git-gui --version

will only work from MSYS's rxvt.

-- Hannes
