From: David Woodhouse <dwmw2@infradead.org>
Subject: git-mailinfo '-u' argument should be default.
Date: Fri, 12 May 2006 17:46:02 +0100
Message-ID: <1147452362.2794.452.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri May 12 18:47:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Feama-0007vo-Ne
	for gcvg-git@gmane.org; Fri, 12 May 2006 18:46:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbWELQqJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 May 2006 12:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932154AbWELQqJ
	(ORCPT <rfc822;git-outgoing>); Fri, 12 May 2006 12:46:09 -0400
Received: from canuck.infradead.org ([205.233.218.70]:39053 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S932159AbWELQqH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 May 2006 12:46:07 -0400
Received: from pmac.infradead.org ([81.187.2.168])
	by canuck.infradead.org with esmtpsa (Exim 4.62 #1 (Red Hat Linux))
	id 1FeamC-0002Ub-Te
	for git@vger.kernel.org; Fri, 12 May 2006 12:46:05 -0400
To: git@vger.kernel.org
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2.dwmw2.1) 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19919>

If you apply a patch with 'git-am', it takes the raw content of the
From: header, in whatever character set that happens to be, and puts
that content, untagged, into the commit object. 

That is almost _never_ the right thing to do, surely? Raw data in
untagged character sets is marginally better than line noise.

We should default to the '-u' behaviour, which converts to the character
set which the git repo is stored in. It's not just for converting to
UTF-8, although it looks like it was in the past. Now, however, it
converts to the character set defined in the configuration. So even if
it's a Luddite who for some reason is sticking with an obsolete
character set, it gets that right.

The only option which makes sense _other_ than that would be to just
stick the RFC2047-encoded original From: header into the commit, surely?

-- 
dwmw2
