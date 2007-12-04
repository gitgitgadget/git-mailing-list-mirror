From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [RFC] Introduce .git/BRANCH to point to the current branch
Date: Tue, 04 Dec 2007 21:19:00 +0100
Message-ID: <vpqbq96jjrf.fsf@bauges.imag.fr>
References: <4755B3B3.80704@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Salikh Zakirov <salikh@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 04 21:20:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzeFN-0008ON-M0
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 21:20:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751071AbXLDUTk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Dec 2007 15:19:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751103AbXLDUTk
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Dec 2007 15:19:40 -0500
Received: from imag.imag.fr ([129.88.30.1]:49331 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751071AbXLDUTj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Dec 2007 15:19:39 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id lB4KJ2md015615
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 4 Dec 2007 21:19:02 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1IzeEP-0007a8-2f; Tue, 04 Dec 2007 21:19:01 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1IzeEP-0006F5-05; Tue, 04 Dec 2007 21:19:01 +0100
In-Reply-To: <4755B3B3.80704@gmail.com> (Salikh Zakirov's message of "Wed\, 05 Dec 2007 05\:08\:19 +0900")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Tue, 04 Dec 2007 21:19:02 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67081>

Salikh Zakirov <salikh@gmail.com> writes:

> This combination leads to the confusing user experience
> if the branch changes independently of the working directory.
> This can happen in following cases:

There's another thing that your proposal could change: navigating back
in history without loosing track of the branch you're on.

Currently, I can do:

# Oh, what did this look like two commits ago?
$ git checkout HEAD^^
# Ah, OK, let's go back to the tip
$ git checkout branch-name
               ^^^^^^^^^^^
But I have to remember and re-type the branch name.

I can imagine (not tested with your patch) doing just:

$ git checkout HEAD^^
$ git checkout BRANCH

(that's one point in favor of your change, but I'm not familiar enough
with git's internal to say whether this is sufficient to justify the
change).

-- 
Matthieu
