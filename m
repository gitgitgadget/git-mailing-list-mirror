From: Drew Northup <drew.northup@maine.edu>
Subject: Re: [PATCH] Fix wrong xhtml option to highlight
Date: Wed, 26 Jan 2011 20:44:06 -0500
Message-ID: <1296092646.23506.10.camel@drew-northup.unet.maine.edu>
References: <1295898298-9794-1-git-send-email-Jochen@herr-schmitt.de>
	 <7vvd1dlxza.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Jochen Schmitt <Jochen@herr-schmitt.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 27 02:51:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PiH1P-0000qk-J9
	for gcvg-git-2@lo.gmane.org; Thu, 27 Jan 2011 02:51:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754564Ab1A0Bvd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Jan 2011 20:51:33 -0500
Received: from beryl.its.maine.edu ([130.111.32.94]:37452 "EHLO
	beryl.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754413Ab1A0Bvc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jan 2011 20:51:32 -0500
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by beryl.its.maine.edu (8.13.8/8.13.8) with ESMTP id p0R1iDdU010574
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 26 Jan 2011 20:44:13 -0500
In-Reply-To: <7vvd1dlxza.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: p0R1iDdU010574
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1296697492.97056@ax4GMvTA7dE3UXHScfhZbA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165569>


On Mon, 2011-01-24 at 14:48 -0800, Junio C Hamano wrote:
> Jochen Schmitt <Jochen@herr-schmitt.de> writes:
> 
> > ---
> > Hallo,
> >
> > because I'm the maintainer of the highlight package in the
> > Fedora Project I was notified, that highlight doesn't works
> > properly with gitweb in BZ #672293.
> >
> > So I have create the following simple patch to solve the 
> > reported issue.
> >
> > Best Regards
> >
> > Jochen Schmitt
> >
> >  gitweb/gitweb.perl |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> > index 1025c2f..b662420 100755
> > --- a/gitweb/gitweb.perl
> > +++ b/gitweb/gitweb.perl
> > @@ -3468,7 +3468,7 @@ sub run_highlighter {
> >  	close $fd;
> >  	open $fd, quote_command(git_cmd(), "cat-file", "blob", $hash)." | ".
> >  	          quote_command($highlight_bin).
> > -	          " --xhtml --fragment --syntax $syntax |"
> > +	          " -xhtml --fragment --syntax $syntax |"
> 
> Curious.
> 
> Does the command take double-dash for the fragment and syntax options but
> a single dash for the xhtml option?  Really...
> 
> A few top hits returned by Google for "highlight manual page" tells me
> otherwise.

Certainly appears to be the case that "--xhtml" is the option in Ubuntu
10.04.1 LTS. 

Jochen,
Did you mean "-X" (which sets the same option)?

-- 
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
