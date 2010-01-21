From: Johan Herland <johan@herland.net>
Subject: Re: git notes: notes
Date: Thu, 21 Jan 2010 03:05:05 +0100
Message-ID: <201001210305.05309.johan@herland.net>
References: <20100120050343.GA12860@gnu.kitenet.net>
 <201001201148.11701.johan@herland.net> <20100120182438.GB31507@gnu.kitenet.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-15
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de
To: Joey Hess <joey@kitenet.net>
X-From: git-owner@vger.kernel.org Thu Jan 21 03:05:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXmQ8-0002Xi-IQ
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jan 2010 03:05:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753712Ab0AUCFL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2010 21:05:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753399Ab0AUCFJ
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 21:05:09 -0500
Received: from smtp.getmail.no ([84.208.15.66]:35932 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752398Ab0AUCFI (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Jan 2010 21:05:08 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KWK00GTRR4IMY80@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Thu, 21 Jan 2010 03:05:06 +0100 (MET)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KWK00JFCR4HCA10@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Thu, 21 Jan 2010 03:05:06 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.1.21.15722
User-Agent: KMail/1.12.4 (Linux/2.6.32-ARCH; KDE/4.3.4; x86_64; ; )
In-reply-to: <20100120182438.GB31507@gnu.kitenet.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137617>

On Wednesday 20 January 2010, Joey Hess wrote:
> Johan Herland wrote:
> > > PS, Has anyone thought about using notes to warn bisect away from
> > > commits that are known to be unbuildable or otherwise cause bisection
> > > trouble?
> >
> > No, I haven't thought of that specific use case. Great idea! :)
> 
> Only problem I see with doing it is it might be too easy to overwrite
> such a note with git notes edit -m

Well, you would have to run "git notes edit -m" with core.notesRef or 
$GIT_NOTES_REF set to the notes ref where bisect information is stored (e.g. 
"refs/notes/bisect").

In any case, I would not use "git notes" to maintain the bisect hints. 
Rather, I'd add subcommands to "git bisect" that would take care of 
maintaining the notes tree @ "refs/notes/bisect". Much more user-friendly 
than telling the user to write their own bisect-notes by hand.

> Did you consider having -m append a line to an existing note?

Hmm. Not really. The "git notes" porcelain was originally written by Dscho, 
and my builtin-ification of it (currently in 'pu') preserves the original 
semantics of "git notes edit -m". It might make sense to change the 
defaults; what do you think, Dscho?


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
