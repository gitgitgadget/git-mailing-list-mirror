From: Gerrit Pape <pape@smarden.org>
Subject: Re: [ANNOUCNE] GIT 1.1.0
Date: Wed, 11 Jan 2006 09:25:00 +0000
Message-ID: <20060111092500.6041.qmail@6aae66343b5940.315fe32.mid.smarden.org>
References: <7v4q4eurgu.fsf@assigned-by-dhcp.cox.net> <20060109084930.GA560@localhost.localdomain> <7vr77hpwla.fsf@assigned-by-dhcp.cox.net> <7vbqylpty1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Jan 11 10:25:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwcDw-0003WF-5U
	for gcvg-git@gmane.org; Wed, 11 Jan 2006 10:24:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751391AbWAKJYx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jan 2006 04:24:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751392AbWAKJYx
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jan 2006 04:24:53 -0500
Received: from a.mx.smarden.org ([212.21.76.77]:55694 "HELO a.mx.smarden.org")
	by vger.kernel.org with SMTP id S1751391AbWAKJYw (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Jan 2006 04:24:52 -0500
Received: (qmail 6042 invoked by uid 1000); 11 Jan 2006 09:25:00 -0000
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vbqylpty1.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14483>

On Mon, Jan 09, 2006 at 02:38:30AM -0800, Junio C Hamano wrote:
> Junio C Hamano <junkio@cox.net> writes:
> > Coywolf Qi Hunt <qiyong@fc-cn.com> writes:
> >> Why not support debian? I see the debian directory is outdated.
> >
> > I think that was discussed already this year, so look in the
> > list archive for the past 10 days or so please before asking.
> 
> Especially, please see this thread:
> 
>     http://marc.theaimsgroup.com/?l=git&m=113576889301331 
> 
> I haven't received any patches to re-add debian/ directory from
> Gerrit since I removed it, and I do not expect nor wish to get
> one.  I respect Gerrit's request not to ship debian/ directory
> myself.

Thanks.  

> If you want to see deb packages at kernel.org built by me, you
> need to convince both Gerrit and me with a workable workflow
> that does not add extra burden on us and avoids confusion.

I'm afraid, I can't always keep up with the git development speed.  So
it's quite possible that a debian/ directory in the git repository gets
temporarily outdated and possibly broken, and I'm not available to
update immediately.

Starting with version 1.0.8-1, this should work if you want to build
Debian packages on sid or sarge from the maint or master branch (or the
v1.1.1 tag) yourself:

 $ git checkout maint
 $ wget -q -O- http://ftp.debian.org/debian/pool/main/g/git-core/git-core_1.0.8-1.diff.gz |
 gunzip |patch -p1
 patching file debian/changelog
 patching file debian/control
 patching file debian/copyright
 patching file debian/rules
 patching file debian/git-core.docs
 patching file debian/git-doc.docs
 patching file debian/implicit
 patching file debian/git-core.postinst
 patching file debian/git-core.prerm
 $ chmod 755 debian/rules
 $ debchange -v 1.1.1-0.maint20060111 'git maint 20060111'
 $ dpkg-buildpackage -b -rfakeroot -uc -us
 [...]
 $ 
 
HTH, Gerrit.
