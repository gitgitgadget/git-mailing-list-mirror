From: Gerrit Pape <pape@smarden.org>
Subject: Re: pull-fetch-param.txt
Date: Fri, 13 Jul 2007 07:48:24 +0000
Message-ID: <20070713074824.9806.qmail@df2dc1a3890a6b.315fe32.mid.smarden.org>
References: <tkrat.4532d38d43e16a62@s5r6.in-berlin.de> <7vhcymt07a.fsf@assigned-by-dhcp.cox.net> <452211C2.8020402@s5r6.in-berlin.de> <7vven1rfpj.fsf@assigned-by-dhcp.cox.net> <45222B18.1090305@s5r6.in-berlin.de> <20070712130631.13667.qmail@594d46613ccd9b.315fe32.mid.smarden.org> <7vvecps2rz.fsf@assigned-by-dhcp.cox.net> <20070713055346.634.qmail@1e54e4f4e1041d.315fe32.mid.smarden.org> <7vejjcpyb5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 13 09:48:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9Fso-0000FY-CH
	for gcvg-git@gmane.org; Fri, 13 Jul 2007 09:48:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758421AbXGMHsG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jul 2007 03:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756544AbXGMHsF
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jul 2007 03:48:05 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:41675 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758197AbXGMHsE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2007 03:48:04 -0400
Received: (qmail 9807 invoked by uid 1000); 13 Jul 2007 07:48:24 -0000
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vejjcpyb5.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52369>

On Fri, Jul 13, 2007 at 12:17:34AM -0700, Junio C Hamano wrote:
> Gerrit Pape <pape@smarden.org> writes:
> >> Quick question.  Is the build done with "make
> >> ASCIIDOC8=YesPlease"?
> >
> > No, must have missed that.  This solves the first issue ...
> > ..., but not the second one with callout lists.
> 
> Sorry, does not reproduce for me, with asciidoc 8.2.1.  There
> must be something different between our environments.

Yes, I have docbook-xsl 1.72.0.

> Here is an excerpt from what I get for git-reset.txt in
> git-reset.1:
> 
> -- >8 --
> .\"     Title: git\-reset
> .\"    Author: 
> .\" Generator: DocBook XSL Stylesheets v1.71.0 <http://docbook.sf.net/>
> .\"      Date: 07/13/2007
> .\"    Manual: Git Manual
> .\"    Source: Git 1.5.3.rc1.4.gaf83
> 
>     ...
> 
> .SH "EXAMPLES"
> .PP
> Undo a commit and redo
> .RS 3n
> .sp
> .RS 3n
> .nf
> $ git commit ...
> $ git reset \-\-soft HEAD^      \fB(1)\fR
> $ edit                        \fB(2)\fR
> $ git commit \-a \-c ORIG_HEAD  \fB(3)\fR

I get the same with docbook-xsl 1.71.0, but with 1.72.0:

.\"     Title: git-reset
.\"    Author: 
.\" Generator: DocBook XSL Stylesheets v1.72.0 <http://docbook.sf.net/>
.\"      Date: 07/13/2007
.\"    Manual: Git Manual
.\"    Source: Git 1.5.3.rc0.104.g71f98
[...]
.SH "EXAMPLES"
.PP
Undo a commit and redo
.RS 4
.sp
.RS 4
.nf
$ git commit ...
$ git reset \-\-soft HEAD^      \efB(1)\efR
$ edit                        \efB(2)\efR
$ git commit \-a \-c ORIG_HEAD  \efB(3)\efR
.fi
.RE
\&.sp
\efB1. \efRThis is most often done when you remembered what you just committed is incomplete, or you misspelled your commit message, or both. Leaves working tree as it was before "reset".

\&.br
\efB2. \efRmake corrections to working tree files.

\&.br
\efB3. \efR"reset" copies the old head to .git/ORIG_HEAD; redo the commit by starting with its log message. If you do not need to edit the message further, you can give \-C option instead.


I'll check with the docbook-xsl Debian maintainer.

Thanks, Gerrit.
