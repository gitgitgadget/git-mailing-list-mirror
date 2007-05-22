From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Prevent megablobs from gunking up git packs
Date: Tue, 22 May 2007 13:05:40 +0200
Organization: At home
Message-ID: <f2uigr$ufj$1@sea.gmane.org>
References: <46528A48.9050903@gmail.com> <7vtzu58i4c.fsf@assigned-by-dhcp.cox.net> <56b7f5510705220100h77e91196r1784b33772911660@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 22 13:01:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqS6z-0003ww-N4
	for gcvg-git@gmane.org; Tue, 22 May 2007 13:01:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758147AbXEVLBA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 22 May 2007 07:01:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758464AbXEVLBA
	(ORCPT <rfc822;git-outgoing>); Tue, 22 May 2007 07:01:00 -0400
Received: from main.gmane.org ([80.91.229.2]:51711 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758147AbXEVLA7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2007 07:00:59 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HqS6j-0001Co-9B
	for git@vger.kernel.org; Tue, 22 May 2007 13:00:49 +0200
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 22 May 2007 13:00:49 +0200
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 22 May 2007 13:00:49 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48091>

Dana How wrote:

> There's actually an even more extreme example from my day job.
> The software team has a project whose files/revisions would be
> similar to those in the linux kernel (larger commits, I'm sure).
> But they have *ONE* 500MB file they check in because it takes
> 2 or 3 days to generate and different people use different versions o=
f it.
> I'm sure it has 50+ revisions now. =A0If they converted to git and in=
cluded
> these blobs in their packfile, that's a 25GB uncompressed increase!
> *Every* git operation must wade through 10X -- 100X more packfile.
> Or it could be kept in 50+ loose objects in objects/xx ,
> requiring a few extra syscalls by each user to get a new version.

Or keeping those large objects in separate, _kept_ packfile, containing
only those objects (which can delta well, even if they are large).

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
