From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Please default to 'commit -a' when no changes were added
Date: Fri, 23 Apr 2010 11:27:47 +0200
Message-ID: <vpqvdbi7c30.fsf@bauges.imag.fr>
References: <20100422151037.2310.2429.reportbug@frosties.localdomain>
	<20100422155806.GC4801@progeny.tock>
	<87wrvzs590.fsf@frosties.localdomain>
	<alpine.LFD.2.00.1004221445310.7232@xanadu.home>
	<87sk6n4426.fsf@frosties.localdomain>
	<7vsk6n2n48.fsf@alter.siamese.dyndns.org>
	<vpq7hnzcgjq.fsf@bauges.imag.fr> <87r5m6tu0l.fsf@frosties.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	Jonathan Nieder <jrnieder@gmail.com>, 578764@bugs.debian.org,
	git@vger.kernel.org
To: Goswin von Brederlow <goswin-v-b@web.de>
X-From: git-owner@vger.kernel.org Fri Apr 23 11:28:31 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5FBX-0007SX-7l
	for gcvg-git-2@lo.gmane.org; Fri, 23 Apr 2010 11:28:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756467Ab0DWJ2S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Apr 2010 05:28:18 -0400
Received: from mx1.imag.fr ([129.88.30.5]:52381 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756829Ab0DWJ2Q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Apr 2010 05:28:16 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o3N9MREh027450
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 23 Apr 2010 11:22:27 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1O5FAp-0005sm-Q7; Fri, 23 Apr 2010 11:27:47 +0200
In-Reply-To: <87r5m6tu0l.fsf@frosties.localdomain> (Goswin von Brederlow's message of "Fri\, 23 Apr 2010 11\:09\:30 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 23 Apr 2010 11:22:28 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o3N9MREh027450
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1272619348.126@PBi4PPslmldIJqG2vra/bw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145603>

Goswin von Brederlow <goswin-v-b@web.de> writes:

> For SVN users it gets much worse:
>
> vi existing-file.c # do some changes
> vi new-file.c      # create the file
> git add new-file.c
> vi new-file.c      # do some more changes
> git commit
>
> A SVN user would expect the current working copies of existing-file.c
> and new-file.c to be commited. Instead only new-file.c is commited and
> only the fist modification.
>
> While this case is still highly confusing to non git users I do see that
> it can't be easily changed. And my suggestion doesn't change it. The
> call to "git add" creates an index so the commit would only act on the
> index.

But then, you'd still have the confusion for people expecting the SVN
semantics. They'd use "git commit-without-dash-a" happily untill they
have to add a new file, and the day the do a "git add" on a new file,
commit doesn't add their changes to existing files, and ... WTF!?

Don't get me wrong: I do agree that not everybody have a use for the
index. Typically, I teach Git to students, who are light-years away
from understanding what "clean commit, small and related changes"
means. They have no use for the index, they just use Git as a way to
share code, and possibly as a backup mechanism. I just teach them
"always use the -a option of 'git commit' for now, you'll learn about
the power of 'git commit-without-dash-a' later". Unless when they
forget to say "-a", it just works. And it even works when they add new
files, when they resolve conflicts after a merge, ... which your
proposal does not solve.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
