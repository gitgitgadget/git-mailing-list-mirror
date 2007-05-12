From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: [PATCH] cvsserver: Complete rewrite of the configuration parser
Date: Sat, 12 May 2007 23:31:53 +0200
Message-ID: <20070512213153.GC7184@planck.djpig.de>
References: <7v8xbvj5mx.fsf@arte.twinsun.com> <11789982521112-git-send-email-frank@lichtenheld.de> <7v4pmhyfre.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Martin Langhoff <martin.langhoff@gmail.com>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat May 12 23:32:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmzCE-0005GZ-Hl
	for gcvg-git@gmane.org; Sat, 12 May 2007 23:32:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753154AbXELVb5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 May 2007 17:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752841AbXELVb5
	(ORCPT <rfc822;git-outgoing>); Sat, 12 May 2007 17:31:57 -0400
Received: from planck.djpig.de ([85.10.192.180]:4778 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753154AbXELVb5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2007 17:31:57 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id 7C7CD274014;
	Sat, 12 May 2007 23:31:54 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at planck.djpig.de
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (planck.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jDPzp1HvgMJg; Sat, 12 May 2007 23:31:53 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id 75EAF274013; Sat, 12 May 2007 23:31:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v4pmhyfre.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47096>

On Sat, May 12, 2007 at 12:59:49PM -0700, Junio C Hamano wrote:
> But all of this is post 1.5.2 material; we would want to have a
> minimal fixup on 'master' before 1.5.2, independent of this
> rewrite.

Fair enough. So far I see three very minimal solutions, but I can't
decide which one is the least ugly:

(For all we can begin by limiting the used variables to
^gitcvs.((ext|pserver).)? )

1) Drop variables named gitcvs.ext and gitcvs.pserver manually
2) Use the complete variable name as key to the hash instead of
   using a hash of hashes of hashes
   { "diff.color => "auto",
     "diff.color.whitespace" => "blue reverse" }
3) Make the second level always a hash, instead of using a string
   directly, so that Junio's example would look like this
   { diff => { color => { value => "auto",
   			  whitespace => "blue reverse" } } }


Opinions?

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
