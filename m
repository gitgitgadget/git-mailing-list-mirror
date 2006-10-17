From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 13:19:08 +0200
Message-ID: <vpqejt76vgz.fsf@ecrins.imag.fr>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<Pine.LNX.4.64.0610161625370.3962@g5.osdl.org>
	<45345AEF.6070107@utoronto.ca> <200610171030.35854.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Aaron Bentley <aaron.bentley@utoronto.ca>,
	Linus Torvalds <torvalds@osdl.org>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 17 13:20:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZmzG-00074V-Nc
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 13:19:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423070AbWJQLTz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 07:19:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423072AbWJQLTz
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 07:19:55 -0400
Received: from imag.imag.fr ([129.88.30.1]:61091 "EHLO imag.imag.fr")
	by vger.kernel.org with ESMTP id S1423070AbWJQLTy (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Oct 2006 07:19:54 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.6/8.13.6) with ESMTP id k9HBJ9b6010407
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 17 Oct 2006 13:19:09 +0200 (CEST)
Received: from ecrins.imag.fr ([129.88.43.124])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1GZmyS-00063J-Ox; Tue, 17 Oct 2006 13:19:08 +0200
Received: from moy by ecrins.imag.fr with local (Exim 4.50)
	id 1GZmyS-0001v7-M0; Tue, 17 Oct 2006 13:19:08 +0200
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200610171030.35854.jnareb@gmail.com> (Jakub Narebski's message of "Tue\, 17 Oct 2006 10\:30\:35 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (imag.imag.fr [129.88.30.1]); Tue, 17 Oct 2006 13:19:10 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29058>

Jakub Narebski <jnareb@gmail.com> writes:

>> - you can use a checkout to maintain a local mirror of a read-only
>>   branch (I do this with http://bazaar-vcs.com/bzr/bzr.dev).
>
> In git you can access contents _without_ checkout/working area.

Bazaar can do this too. For example,
"bzr cat http://something -r some-revision" gets the content of a file
at a given revision. But that's not what Aaron was refering to.

In Bazaar, checkouts can be two things:

1) a working tree without any history information, pointing to some
   other location for the history itself (a la svn/CVS/...).
   (this is "light checkout")

2) a bound branch. It's not _very_ different from a normal branch, but
   mostly "commit" behaves differently:
   - it commits both on the local and the remote branch (equivalent to
     "commit" + "push", but in a transactional way).
   - it refuses to commit if you're out of date with the branch you're
     bound to.
   (this is "heavy checkout")

In both cases, this has the side effect that you can't commit if the
"upstream" branch is read-only. That's not fundamental, but handy.

I use it for example to have several "checkouts" of the same branch on
different machines. When I commit, bzr tells me "hey, boss, you're out
of date, why don't you update first" if I'm out of date. And if commit
succeeds, I'm sure it is already commited to the main branch. I'm sure
I won't pollute my history with merges which would only be the result
of forgetting to update.

Once more, that's not fundamental, but handy.

The more fundamental thing I suppose is that it allows people to work
in a centralized way (checkout/commit/update/...), and Bazaar was
designed to allow several different workflows, including the
centralized one.

-- 
Matthieu
