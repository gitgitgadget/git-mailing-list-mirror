From: Junio C Hamano <gitster@pobox.com>
Subject: Re: pull-fetch-param.txt
Date: Fri, 13 Jul 2007 00:17:34 -0700
Message-ID: <7vejjcpyb5.fsf@assigned-by-dhcp.cox.net>
References: <tkrat.4532d38d43e16a62@s5r6.in-berlin.de>
	<7vhcymt07a.fsf@assigned-by-dhcp.cox.net>
	<452211C2.8020402@s5r6.in-berlin.de>
	<7vven1rfpj.fsf@assigned-by-dhcp.cox.net>
	<45222B18.1090305@s5r6.in-berlin.de>
	<20070712130631.13667.qmail@594d46613ccd9b.315fe32.mid.smarden.org>
	<7vvecps2rz.fsf@assigned-by-dhcp.cox.net>
	<20070713055346.634.qmail@1e54e4f4e1041d.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Fri Jul 13 09:17:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9FPJ-0000GL-L2
	for gcvg-git@gmane.org; Fri, 13 Jul 2007 09:17:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752074AbXGMHRg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jul 2007 03:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752752AbXGMHRg
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jul 2007 03:17:36 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:58593 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750937AbXGMHRf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2007 03:17:35 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070713071735.IRIT1393.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Fri, 13 Jul 2007 03:17:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id NvHa1X0031kojtg0000000; Fri, 13 Jul 2007 03:17:34 -0400
In-Reply-To: <20070713055346.634.qmail@1e54e4f4e1041d.315fe32.mid.smarden.org>
	(Gerrit Pape's message of "Fri, 13 Jul 2007 05:53:46 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52368>

Gerrit Pape <pape@smarden.org> writes:

>> Quick question.  Is the build done with "make
>> ASCIIDOC8=YesPlease"?
>
> No, must have missed that.  This solves the first issue ...
> ..., but not the second one with callout lists.

Sorry, does not reproduce for me, with asciidoc 8.2.1.  There
must be something different between our environments.

Here is an excerpt from what I get for git-reset.txt in
git-reset.1:

-- >8 --
.\"     Title: git\-reset
.\"    Author: 
.\" Generator: DocBook XSL Stylesheets v1.71.0 <http://docbook.sf.net/>
.\"      Date: 07/13/2007
.\"    Manual: Git Manual
.\"    Source: Git 1.5.3.rc1.4.gaf83

    ...

.SH "EXAMPLES"
.PP
Undo a commit and redo
.RS 3n
.sp
.RS 3n
.nf
$ git commit ...
$ git reset \-\-soft HEAD^      \fB(1)\fR
$ edit                        \fB(2)\fR
$ git commit \-a \-c ORIG_HEAD  \fB(3)\fR
.fi
.RE
.sp
\fB1. \fRThis is most often done when you remembered what you just committed is incomplete, or you misspelled your commit message, or both. Leaves working tree as it was before "reset".
.br
\fB2. \fRmake corrections to working tree files.
.br
\fB3. \fR"reset" copies the old head to .git/ORIG_HEAD; redo the commit by starting with its log message. If you do not need to edit the message further, you can give \-C option instead.

See also the \-\-amend option to \fBgit\-commit\fR(1).
.br
.RE
-- 8< --

and "man -l git-reset.1" seems to show the callouts just fine.

-- >8 --
 ...
EXAMPLES
       Undo a commit and redo

             $ git commit ...
             $ git reset --soft HEAD^      (1)
             $ edit                        (2)
             $ git commit -a -c ORIG_HEAD  (3)

          1. This is most often done when you remembered what you just
          committed is incomplete, or you misspelled your commit message,
          or both. Leaves working tree as it was before "reset".
          2. make corrections to working tree files.
          3. "reset" copies the old head to .git/ORIG_HEAD; redo the
          commit by starting with its log message. If you do not need to
          edit the message further, you can give -C option instead.

          See also the --amend option to git-commit(1).
-- 8< --
