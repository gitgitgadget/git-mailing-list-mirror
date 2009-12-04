From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 0/3] Add a "fix" command to "rebase --interactive"
Date: Fri, 04 Dec 2009 18:40:58 +0100
Message-ID: <vpqfx7qocwl.fsf@bauges.imag.fr>
References: <cover.1259934977.git.mhagger@alum.mit.edu>
	<4B192701.4000308@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	gitster@pobox.com, Johannes.Schindelin@gmx.de
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Dec 04 18:41:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGc9i-0007R7-I9
	for gcvg-git-2@lo.gmane.org; Fri, 04 Dec 2009 18:41:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932374AbZLDRlK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2009 12:41:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932363AbZLDRlJ
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Dec 2009 12:41:09 -0500
Received: from mx2.imag.fr ([129.88.30.17]:55526 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932372AbZLDRlF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2009 12:41:05 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id nB4HdJgB019396
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 4 Dec 2009 18:39:19 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1NGc9L-0004Y0-37; Fri, 04 Dec 2009 18:40:59 +0100
In-Reply-To: <4B192701.4000308@drmicha.warpmail.net> (Michael J. Gruber's message of "Fri\, 04 Dec 2009 16\:13\:05 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 04 Dec 2009 18:39:20 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: nB4HdJgB019396
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1260553160.75501@5g0yHEYzu1WjHUkGQCN7aw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134554>

Michael J Gruber <git@drmicha.warpmail.net> writes:

>> If the idea of a "fix" command is acceptable, then I would like to
>> implement a further convenience: if a group of commits to be folded
>> together includes *only* "fix" commits, then the first log message
>> should be used without even opening an editor.  But I would like to
>> get a reaction to the "fix" command in general before doing so.
>
> I'd say that would make a useful command ("fix") even more useful, being
> just the right counterpart to "reword" for trivial commit message fixes.

+1 for fix, and +1 for the "don't even launch the editor" too.

> OTOH, it would not be possible any more to squash in a few fixes and
> then edit the message. Maybe having to quit the editor is not that much
> work after all.

Well, it's still possible, by using "squash" and deleting the extra
part. In both cases, there's one scenario where one has a little more
to do than strictly required (either delete a bit of texte or close
the editor), but I think the senario "just want to fix the content
with another patch, but the commit message was good" is so common that
it deserves being optimized.

In particular, that would make a rebase -i with only reordering and
fixes non-interactive. With 3 fixes, you just wait for Git around a
second and it's done, smoothly, while it requires launching/closing
the editor 3 times ...

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
