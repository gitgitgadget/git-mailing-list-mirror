From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: git annotate runs out of memory
Date: Wed, 12 Dec 2007 00:37:46 +0100
Message-ID: <vpq63z49511.fsf@bauges.imag.fr>
References: <4aca3dc20712110933i636342fbifb15171d3e3cafb3@mail.gmail.com>
	<alpine.LFD.0.9999.0712111018540.25032@woody.linux-foundation.org>
	<vpq4pepcaz5.fsf@bauges.imag.fr>
	<alpine.LFD.0.9999.0712111119310.25032@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Berlin <dberlin@dberlin.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Dec 12 00:38:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2Egh-0002B7-3T
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 00:38:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754201AbXLKXi1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 18:38:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753463AbXLKXi1
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 18:38:27 -0500
Received: from imag.imag.fr ([129.88.30.1]:48947 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752713AbXLKXi0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 18:38:26 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id lBBNbkEM007405
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 12 Dec 2007 00:37:46 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1J2Efa-00051z-Od; Wed, 12 Dec 2007 00:37:46 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1J2Efa-0005r2-MG; Wed, 12 Dec 2007 00:37:46 +0100
In-Reply-To: <alpine.LFD.0.9999.0712111119310.25032@woody.linux-foundation.org> (Linus Torvalds's message of "Tue\, 11 Dec 2007 11\:22\:20 -0800 \(PST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 12 Dec 2007 00:37:47 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67969>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Tue, 11 Dec 2007, Matthieu Moy wrote:
>> 
>> I've seen you pointing this kind of examples many times, but is that
>> really different from what even SVN does? "svn log drivers/char" will
>> also list atomic commits, and give me a filtered view of the global
>> log.
>
> Ok, BK and CVS both got this horribly wrong, which is why I care. Maybe 
> this is one of the things SVN gets right.
>
> I seriously doubt it, though. Do you get *history* right, or do you just 
> get a random list of commits?

Well, you don't get merge commit right with SVN, but that's a
different issue (svn 1.5 is supposed to have something about merge
history, I don't know how it's done ...). So, if by "history", you
mean how branches interferred together, obviously, SVN is bad at this.
But it's equally bad at "svn log dir/" and plain "svn log".

But to simplify, if you take a linear history (no merge commits),
"svn log dir/" give you the list of commits which changed something
inside "dir/". As pointed out in other messages, the way it's done is
really different from what git does. SVN does know a lot about
directories, and records a lot about them at commit time, while git
just considers them as file containers.

Year, CVS got this terribly wrong. IIRC, it just took the log for
individual messages, and mix them together, so a commit touching
multiple files would appear several times.

I've taken SVN as an extreme example, but at least bzr and mercurial
have an approach very similar to git.

So, to me, this particular point is something git obviously got right,
but not a point where git is so different from the others.

-- 
Matthieu
