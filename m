From: "Bernhard R. Link" <brl+git@mail.brlink.eu>
Subject: Re: [PATCH v5.5 1/5] gitweb: prepare git_get_projects_list for use
 outside 'forks'.
Date: Mon, 30 Jan 2012 17:29:32 +0100
Message-ID: <20120130162932.GA18773@server.brlink.eu>
References: <20120128165606.GA6770@server.brlink.eu>
 <201201301442.06707.jnareb@gmail.com>
 <20120130145538.GA2162@server.brlink.eu>
 <201201301640.35843.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 30 17:48:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RruP2-0003m0-5i
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 17:48:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753935Ab2A3QsT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jan 2012 11:48:19 -0500
Received: from pcpool00.mathematik.uni-freiburg.de ([132.230.30.150]:60867
	"EHLO pcpool00.mathematik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753861Ab2A3QsS (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Jan 2012 11:48:18 -0500
X-Greylist: delayed 1092 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 Jan 2012 11:48:18 EST
Received: from pcpool09.mathematik.uni-freiburg.de ([132.230.30.159])
	by pcpool00.mathematik.uni-freiburg.de with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <brl@pcpool00.mathematik.uni-freiburg.de>)
	id 1Rru7H-0000M5-AT; Mon, 30 Jan 2012 17:30:03 +0100
Received: from brl by pcpool09.mathematik.uni-freiburg.de with local (Exim 4.72)
	(envelope-from <brl@pcpool00.mathematik.uni-freiburg.de>)
	id 1Rru6m-0004vq-He; Mon, 30 Jan 2012 17:29:32 +0100
Content-Disposition: inline
In-Reply-To: <201201301640.35843.jnareb@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189373>

* Jakub Narebski <jnareb@gmail.com> [120130 16:40]:
> Perhaps there are other cases...
>  
> > @@ -2841,7 +2840,7 @@ sub git_get_projects_list {
> >  		my $pfxlen = length("$dir");
> >  		my $pfxdepth = ($dir =~ tr!/!!);
> >  		# when filtering, search only given subdirectory
> > -		if ($filter) {
> > +		if ($filter and not $paranoid) {
> 
> Hmmmm... ($filter and !$paranoid) or ($filter && !$paranoid)?
> Which would be more Perl-ish and fit current code style better...

I cannot say what is more perlish, but gitweb.perl seems to contain
only the combinations "and not" (1 time) and "&& !" (8 times).

	Bernhard R. Link
