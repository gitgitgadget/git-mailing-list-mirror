From: Jeff King <peff@peff.net>
Subject: Re: use git-daemon by git://IP/path?
Date: Fri, 12 Jun 2009 10:16:02 -0400
Message-ID: <20090612141602.GB14628@coredump.intra.peff.net>
References: <200906121213.13365.Karlis.Repsons@gmail.com> <4A325E00.6050504@dirk.my1.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ka-rlis Repsons <karlis.repsons@gmail.com>, git@vger.kernel.org
To: Dirk =?utf-8?Q?S=C3=BCsserott?= <newsletter@dirk.my1.cc>
X-From: git-owner@vger.kernel.org Fri Jun 12 16:16:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MF7YN-00044S-VO
	for gcvg-git-2@gmane.org; Fri, 12 Jun 2009 16:16:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753124AbZFLOQL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Jun 2009 10:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751384AbZFLOQJ
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jun 2009 10:16:09 -0400
Received: from peff.net ([208.65.91.99]:44487 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751376AbZFLOQI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2009 10:16:08 -0400
Received: (qmail 19495 invoked by uid 107); 12 Jun 2009 14:16:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 12 Jun 2009 10:16:21 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Jun 2009 10:16:02 -0400
Content-Disposition: inline
In-Reply-To: <4A325E00.6050504@dirk.my1.cc>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121423>

On Fri, Jun 12, 2009 at 03:54:08PM +0200, Dirk S=C3=BCsserott wrote:

>> Also, in general, how can it be set up, that >1 people have a write=20
>> access to the same repository? Only by using the same login?=20
>
> Have a look at the "--shared" option of "git init". That's supposed t=
o =20

I have also had good experiences with POSIX ACLs for sharing
repositories:

  setfacl -R -m d:u:$user:rwX -m u:$user:rwX /path/to/repo

which gets rid of dealing with group management.  Of course your
filesystem has to support them. :)

-Peff
