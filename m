From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH] t9500: skip gitweb tests if perl version is too old
Date: Sat, 23 Jun 2007 10:57:51 +0200
Message-ID: <20070623085751.GX955MdfPADPa@greensroom.kotnet.org>
References: <20070622154908.GA7946MdfPADPa@greensroom.kotnet.org>
 <7vps3n89mb.fsf@assigned-by-dhcp.pobox.com>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 23 10:57:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I21RL-0005GJ-Qc
	for gcvg-git@gmane.org; Sat, 23 Jun 2007 10:57:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752987AbXFWI5y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Jun 2007 04:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752792AbXFWI5y
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jun 2007 04:57:54 -0400
Received: from psmtp04.wxs.nl ([195.121.247.13]:57881 "EHLO psmtp04.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752570AbXFWI5x (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jun 2007 04:57:53 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp04.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006))
 with SMTP id <0JK200EE2ZKFFC@psmtp04.wxs.nl> for git@vger.kernel.org; Sat,
 23 Jun 2007 10:57:51 +0200 (MEST)
Received: (qmail 13420 invoked by uid 500); Sat, 23 Jun 2007 08:57:51 +0000
In-reply-to: <7vps3n89mb.fsf@assigned-by-dhcp.pobox.com>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50723>

On Fri, Jun 22, 2007 at 11:31:40PM -0700, Junio C Hamano wrote:
> Sven Verdoolaege <skimo@kotnet.org> writes:
> > +perl -MEncode -e 'decode_utf8("", Encode::FB_CROAK)' >/dev/null 2>&1 || {
> > +    test_expect_success 'skipping gitweb tests, perl version is too old' :
> > +    test_done
> > +    exit
> > +}
> > +
> 
> Hmph.  Even something silly like:
> 
> 	perl -MEncode -e 'decode_utf8("", Encode::FB_CLUCK)'
> 
> seem to succeed for me with 5.8.8.
> 

Maybe I'm missing something, but it's supposed to succeed
for perl versions that are recent enough.


I get

bash-3.00$ perl -MEncode -e 'decode_utf8("", Encode::FB_CROAK)'
Too many arguments for Encode::decode_utf8 at -e line 1, at end of line
Execution of -e aborted due to compilation errors.
bash-3.00$ perl --version

This is perl, v5.8.0 built for i686-linux-thread-multi

Copyright 1987-2002, Larry Wall

Perl may be copied only under the terms of either the Artistic License or the
GNU General Public License, which may be found in the Perl 5 source kit.

Complete documentation for Perl, including FAQ lists, should be found on
this system using `man perl' or `perldoc perl'.  If you have access to the
Internet, point your browser at http://www.perl.com/, the Perl Home Page.

(See also http://article.gmane.org/gmane.comp.version-control.git/50354)

skimo
