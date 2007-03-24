From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: [PATCH 1/2] Documentation: Allow @@GIT_VERSION@@ in asciidoc.conf
Date: Sat, 24 Mar 2007 13:04:22 +0100
Message-ID: <20070324120421.GL8017@planck.djpig.de>
References: <11746760451462-git-send-email-frank@lichtenheld.de> <7vejnfpqx5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Mar 24 13:04:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HV4zA-0004xT-QS
	for gcvg-git@gmane.org; Sat, 24 Mar 2007 13:04:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752080AbXCXMEZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Mar 2007 08:04:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752100AbXCXMEY
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Mar 2007 08:04:24 -0400
Received: from planck.djpig.de ([85.10.192.180]:41814 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752080AbXCXMEY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Mar 2007 08:04:24 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id C66CC88136;
	Sat, 24 Mar 2007 13:04:22 +0100 (CET)
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (smtp.lichtenheld.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 25776-02; Sat, 24 Mar 2007 13:04:22 +0100 (CET)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id 0AFE188137; Sat, 24 Mar 2007 13:04:22 +0100 (CET)
Mail-Followup-To: Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vejnfpqx5.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lichtenheld.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42995>

On Fri, Mar 23, 2007 at 02:53:58PM -0700, Junio C Hamano wrote:
> Frank Lichtenheld <frank@lichtenheld.de> writes:
> 
> > Rename asciidoc.conf to asciidoc.conf.in and create
> > the former on build time after piping it through sed.
> >
> > This is useful to allow us to include the git version
> > in the documentation.

> When sending a patch like this, please use "format-patch -M".

Ok.

> While this is attractive to some degree, *I* am grumpy.  Doesn't
> this patch make html and man branches update all files _every_
> time any small change is made to some documentation?

Not with my patch; which is a bug in the patch though because
asciidoc.conf should really depend on GIT-VERSION-FILE.

Another possibility would be to replace the @@GIT_VERSION@@ in the man pages
themself and not in the asciidoc.conf. This would mean perhaps slightly
bigger changes to the build system, but running sed on all the files is of
course a lot faster than regenerating them with asciidoc.

What do you think?

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
