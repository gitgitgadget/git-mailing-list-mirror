From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 0/2] gitweb: Add support for running gitweb as FastCGI
	script
Date: Sun, 9 May 2010 02:31:00 -0700
Message-ID: <20100509093100.GA7641@dcvr.yhbt.net>
References: <1273236845-6523-1-git-send-email-jnareb@gmail.com> <201005090041.11864.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Sam Vilain <sam.vilain@catalyst.net.nz>,
	Juan Jose Comellas <juanjo@comellas.org>,
	Peter Vereshagin <peter@vereshagin.org>,
	John Goerzen <jgoerzen@complete.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 09 11:31:39 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OB2rI-00013j-1A
	for gcvg-git-2@lo.gmane.org; Sun, 09 May 2010 11:31:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753087Ab0EIJbG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 May 2010 05:31:06 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:44136 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751722Ab0EIJbE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 May 2010 05:31:04 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0465E1F449;
	Sun,  9 May 2010 09:31:00 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <201005090041.11864.jnareb@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146716>

Jakub Narebski <jnareb@gmail.com> wrote:
> On Fri, 7 May 2010, Jakub Narebski wrote:
>=20
> > The alternate solution would be to add gitweb.fcgi wrapper, like e.=
g.:
> > in the following patch by Eric Wong
> >=20
> > =A0 "[PATCH 1/2] gitweb: add a simple wrapper for FCGI support"
> > =A0 http://thread.gmane.org/gmane.comp.version-control.git/35920/fo=
cus=3D35921
> >=20
> > which was part of the "[0/2 PATCH] FastCGI and nginx support for gi=
tweb"
> > series. =A0(Note that the patch does 'do $gitweb_cgi;' without chec=
king for
> > errors, see the bottom of `perldoc -f do` documentation on how it s=
hould
> > be done).
>=20
> I think a better solution here would be to use CGI::Compile instead
> of 'do $gitweb_cgi;'.

Possibly, now that CGI::Compile exists.  Can that be used with a
standalone Perl HTTP server?

It's 2010 now and I have long abandoned FastCGI in favor of using HTTP
to the application backends.  In my experience, having only one
plain-text protocol for both frontend web serving and backend
application RPC makes development/monitoring/testing much easier.

I just use Ruby WEBrick nowadays for any instaweb instances I run to
share with a few cow-orkers.  I do a reasonable amount of development i=
n
Ruby, so it's always installed and ready for me.  It would be nice if
there were something standalone and as ubiquitous as WEBrick in the Per=
l
world.

--=20
Eric Wong
