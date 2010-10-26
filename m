From: Drew Northup <drew.northup@maine.edu>
Subject: Re: Why /var/cache/git?
Date: Tue, 26 Oct 2010 09:21:39 -0400
Message-ID: <1288099299.8291.6.camel@drew-northup.unet.maine.edu>
References: <20101025103006.GA18782@brong.net>
	 <4CC5A13F.2090702@eaglescrag.net>  <20101026012224.GA3360@brong.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: "J.H." <warthog19@eaglescrag.net>, git@vger.kernel.org,
	pape@smarden.org
To: Bron Gondwana <brong@fastmail.fm>
X-From: git-owner@vger.kernel.org Tue Oct 26 15:23:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PAjUs-0005X4-CE
	for gcvg-git-2@lo.gmane.org; Tue, 26 Oct 2010 15:23:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933234Ab0JZNXT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Oct 2010 09:23:19 -0400
Received: from basalt.its.maine.edu ([130.111.32.66]:53056 "EHLO
	basalt.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933165Ab0JZNXR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Oct 2010 09:23:17 -0400
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by basalt.its.maine.edu (8.13.8/8.13.8) with ESMTP id o9QDLgJD009901
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 26 Oct 2010 09:21:47 -0400
In-Reply-To: <20101026012224.GA3360@brong.net>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: basalt.its.maine.edu 1003; Body=4
	Fuz1=4 Fuz2=4
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: o9QDLgJD009901
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1288704119.20703@Yb8UVYWEsyaTcXpMeRIrTA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159988>


On Tue, 2010-10-26 at 12:22 +1100, Bron Gondwana wrote:
> On Mon, Oct 25, 2010 at 08:24:47AM -0700, J.H. wrote:
> > On 10/25/2010 03:30 AM, Bron Gondwana wrote:
> > > (resent - correct address for git list!)
> > > 
> > > (Gerrit: you're CC'd as the attribution in README.Debian
> > >  which in the one place I can see /var/cache/git mentioned
> > >  in the docs - without a justification for why it was
> > >  chosen...)
> > 
> > Couple of quick points:
> > 
> > $ grep -Ri "/var/git\|\/var\/git" *
> > Documentation/git-cvsserver.txt:     export
> > CVSROOT=:ext:user@server:/var/git/project.git
> > 
> > gitweb/README:    RewriteRule ^/var(/|/gitweb.cgi)?$	
> > /cgi-bin/gitweb.cgi [QSA,E=GITWEB_PROJECTROOT:/var/git/,L,PT]
> > 
> > gitweb/README:Second, repositories found in /pub/scm/ and /var/git/ will
> > be accesible
> > 
> > Are the only 3 instances where this is mentioned.  Looking at those
> > quick it was probably chosen based on the fact that it's a location that
> > likely exists on most machines.  Or just for explanatory reasons like
> > /example/dir/project.git could be used.
> 
> I have no problem with /var/git - it's /var/cache/git that worries
> me, since the FHS quite clearly says that blowing away /var/cache/*
> is not a problem.  It makes sense to back up /var/lib/ on any machine,
> since that's somewhere that contains application data.  We already
> back up a few things from /var/lib (like /var/lib/svn for example,
> at least until we finish this switchover!)

Bron,
Doing a 'git grep "/var"' on the git sources and then searching that
output for "cache" turns up nothing. I think you'd best bring this up
with the Debian package maintainer. Debian is well known for thinking it
knows better than the original authors where stuff should be--and that's
why I don't run Debian as a server (too much time spent transliterating
paths just to make stuff work properly--when I'm lucky; it makes an
excellent desktop for beginners).

-- 
-Drew Northup N1XIM
   AKA RvnPhnx on OPN
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
