From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-cvsimport: Add -A <author-conv-file> option
Date: Fri, 13 Jan 2006 00:45:51 -0800
Message-ID: <7v8xtkbjnk.fsf@assigned-by-dhcp.cox.net>
References: <20060112233859.3438F5BED0@nox.op5.se>
	<7vvewohoy0.fsf@assigned-by-dhcp.cox.net> <43C70D03.4040609@op5.se>
	<7vzmm0g45a.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 13 09:46:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ExKZJ-0007dh-30
	for gcvg-git@gmane.org; Fri, 13 Jan 2006 09:45:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161501AbWAMIpy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jan 2006 03:45:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161505AbWAMIpy
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jan 2006 03:45:54 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:11680 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1161501AbWAMIpx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jan 2006 03:45:53 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060113084335.TQRR17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 13 Jan 2006 03:43:35 -0500
To: Andreas Ericsson <ae@op5.se>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14619>

Junio C Hamano <junkio@cox.net> writes:

> Andreas Ericsson <ae@op5.se> writes:
>
>> Anyways, I can keep this separate if you don't want to accept it.
>
> Oh, I haven't formed an opinion on accept/reject yet.  I was
> just trying to see if you are aware of that (especially Pasky's
> message in that thread) and thought about issues like "if in
> some repositories CVSROOT/users is in usable form then perhaps
> making sure -A file has the same format and suggest its use in
> the documentation would be nicer".

OK, after a little googling around, I have formed an opinion.  I
agree to the patch in principle, but at least it would be nicer
to use "CVSROOT/users" compatible format before giving it to the
general public.

	http://computing.ee.ethz.ch/sepp/cvs-1.10-to/cvsbook/main_70.html

seems to indicate that:

 - colon ':' is used instead of your '='.

 - RHS, if it contains a whitespace, is quoted either with
   single or double quote.

It was a bit unclear to me how quote characters are to be
quoted, so the patch needs a bit of research, quoting (when
writing out new records) and unquoting (when reading) in the
script, but otherwise I think it is a welcome change.

Opinions from other heavy CVS users?
