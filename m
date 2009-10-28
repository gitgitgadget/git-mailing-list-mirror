From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: drawbacks to svn server + git-svn vs git server?
Date: Wed, 28 Oct 2009 13:19:35 +0100
Message-ID: <vpqbpjrhfs8.fsf@bauges.imag.fr>
References: <25994334.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dexter Riley <edbeaty@charter.net>
X-From: git-owner@vger.kernel.org Wed Oct 28 13:23:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N37YM-00028y-FP
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 13:23:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751763AbZJ1MWw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 08:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751646AbZJ1MWw
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 08:22:52 -0400
Received: from imag.imag.fr ([129.88.30.1]:33276 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751202AbZJ1MWv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 08:22:51 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n9SCJctl025585
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 28 Oct 2009 13:19:38 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1N37V1-0002CW-Og; Wed, 28 Oct 2009 13:19:35 +0100
In-Reply-To: <25994334.post@talk.nabble.com> (Dexter Riley's message of "Wed\, 21 Oct 2009 08\:05\:21 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 28 Oct 2009 13:19:38 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131457>

Dexter Riley <edbeaty@charter.net> writes:

> Hello.  My group is currently using subversion on our version control server,
> but would like to move to git as a client.  We are considering using
> git-svn, to avoid revalidating the server software.  My question is, are
> there any major disadvantages to using git-svn versus git?

One rather big drawback is that "git svn dcommit" has to do some
history-rewritting. In other words, if you have a local commit A in
your repository, and send it to the SVN server with "git svn dcommit",
then A is rewritten into A' (same tree content, but different commit
message at least, and maybe other details I'm not aware of). If you
use git-svn as a "better SVN client", it's not a problem, but if you
want to really use the Git part of git-svn, then this history
rewritting will break the local branches that reference your A.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
