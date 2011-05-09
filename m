From: Drew Northup <drew.northup@maine.edu>
Subject: Re: Question about PERL_PATH
Date: Mon, 09 May 2011 10:49:55 -0400
Message-ID: <1304952595.19245.9.camel@drew-northup.unet.maine.edu>
References: <4DC3F804.3080205@mev.co.uk>
	 <7v7ha33jd7.fsf@alter.siamese.dyndns.org>
	 <robbat2-20110507T174237-068953557Z@orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: abbotti@mev.co.uk
X-From: git-owner@vger.kernel.org Mon May 09 16:50:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJRmo-0001HA-RV
	for gcvg-git-2@lo.gmane.org; Mon, 09 May 2011 16:50:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753105Ab1EIOuJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2011 10:50:09 -0400
Received: from beryl.its.maine.edu ([130.111.32.94]:47096 "EHLO
	beryl.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752780Ab1EIOuI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2011 10:50:08 -0400
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by beryl.its.maine.edu (8.13.8/8.13.8) with ESMTP id p49Enxs1031964
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 9 May 2011 10:49:59 -0400
In-Reply-To: <robbat2-20110507T174237-068953557Z@orbis-terrarum.net>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: beryl.its.maine.edu 1003; Body=4 Fuz1=4
	Fuz2=4
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: p49Enxs1031964
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1305557400.53791@BopLNTkmr6EdGQdX7cFfZQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173237>


On Sat, 2011-05-07 at 18:02 +0000, Robin H. Johnson wrote:
> On Fri, May 06, 2011 at 09:05:08AM -0700,  Junio C Hamano wrote:
> > The variable is not PERL_COMMAND_LINE, but is PERL_PATH, so I think it
> > should expects the path to the program.
> > 
> > Our testsuite also rely on it being the path to the program by enclosing
> > the reference to it inside double quotes, to make sure that PERL_PATH set
> > to "/Program Files/Perl/perl.exe" works.  Didn't Gentoo folks see any test
> > breakage before shipping the ebuild procedure?
> The entire test suite completes fine with our
> PERL_PATH="${EPREFIX}/usr/bin/env perl" setting.
> 
> This was originally put into place because of our bug #326625 [1].
> >From that bug:
> ====
> Git does not compile if local::lib installed in user's home directory if
> 'sudo' is used to raise privileges. Local::lib exports environment
> variable PERL5_MM_OPTS, which contains string INSTALL_BASE='...'.
> Variable PREFIX is set in package's Makefile.pl. Package will not
> compile if both of these variables are set.
> ====
> (Full logs attached in the bug).
> 
> If you can suggest a better way to fix the user's bug, I'll revert the
> PERL_PATH change.
> 
> 1. https://bugs.gentoo.org/show_bug.cgi?id=326625

Robin,
What user are you running the ebuild as? All setting PERL_PATH this way
does is set Perl up to run with a modified environment (quite likely
completely trashing it in this case) which would explain why the ebuild
completes.

-- 
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
