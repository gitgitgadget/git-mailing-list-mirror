From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Noob question on using branches
Date: Tue, 06 May 2008 18:00:15 +0200
Message-ID: <vpqiqxrctio.fsf@bauges.imag.fr>
References: <48207DA4.80502@robertsr.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Barry Roberts <blr@robertsr.us>
X-From: git-owner@vger.kernel.org Tue May 06 18:02:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtPcY-0000BC-00
	for gcvg-git-2@gmane.org; Tue, 06 May 2008 18:02:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764527AbYEFQBQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2008 12:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764630AbYEFQBQ
	(ORCPT <rfc822;git-outgoing>); Tue, 6 May 2008 12:01:16 -0400
Received: from harmonie.imag.fr ([147.171.130.40]:64011 "EHLO harmonie.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764506AbYEFQBN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2008 12:01:13 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by harmonie.imag.fr (8.13.8/8.13.8) with ESMTP id m46G0FR9006176;
	Tue, 6 May 2008 18:00:16 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1JtPaR-0003qv-8P; Tue, 06 May 2008 18:00:15 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1JtPaR-0005gY-6B; Tue, 06 May 2008 18:00:15 +0200
In-Reply-To: <48207DA4.80502@robertsr.us> (Barry Roberts's message of "Tue\, 06 May 2008 09\:47\:48 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (harmonie.imag.fr [147.171.130.40]); Tue, 06 May 2008 18:00:20 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81363>

Barry Roberts <blr@robertsr.us> writes:

> I have a branch in my git repository that is a "released" branch.  It
> only gets defect fixes as they are needed to patch our production
> servers.
>
> I want to get all those defect fixes back into the master, but I don't
> want changes from the master getting into the production branch, so I
> don't think I want to do:
> git checkout master
> git merge production

Why wouldn't you?

The "git merge production" will take all the changes in production and
put them in the current branch. You'll get a new revision that
contains both the stuff in master and the one in production. But
what's important is that the reference "master" is updated to that new
revision, but "production" stays where it is.

Just try it, then run "gitk --all" to see if the result is what you
wanted. If not, "git reset --hard HEAD^" will move back "master" to
where it used to be (read about "git reset" before you run it).

-- 
Matthieu
