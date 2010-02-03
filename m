From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [BUG] - "git commit --amend" commits, when exiting the editor with no changes written
Date: Wed, 03 Feb 2010 08:34:23 +0100
Message-ID: <vpqaavqkc1s.fsf@bauges.imag.fr>
References: <394FB581-C9B9-40AB-AFB6-39B68ED5BEAD@wincent.com>
	<76c5b8581002021356m52bb1817k9a4a29da0d4b681d@mail.gmail.com>
	<77153A83-158D-4D36-A622-7AA3947C7D52@wincent.com>
	<76c5b8581002021431o2b5073a0s42b273b6d61893db@mail.gmail.com>
	<alpine.DEB.1.00.1002022356460.4985@pacific.mpi-cbg.de>
	<76c5b8581002021534i1f0dbd18y1b216233d282cd84@mail.gmail.com>
	<40aa078e1002021540i13e35776xd733a4e40f34b477@mail.gmail.com>
	<76c5b8581002021548n129b3997r48ee6f6df5a1a4eb@mail.gmail.com>
	<40aa078e1002021616s3098bf53la6af93ab0949e7e@mail.gmail.com>
	<76c5b8581002021655k5f63b81h1c55ae87625fbfc5@mail.gmail.com>
	<20100203015947.GA4280@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eugene Sajine <euguess@gmail.com>, kusmabite@gmail.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Wincent Colaiuta <win@wincent.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Jacob Helwig <jacob.helwig@gmail.com>, git@vger.kernel.org
To: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed Feb 03 08:37:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcZo9-0003Vm-EA
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 08:37:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754060Ab0BCHhs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Feb 2010 02:37:48 -0500
Received: from imag.imag.fr ([129.88.30.1]:35371 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752198Ab0BCHhs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 02:37:48 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o137YNBC022831
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 3 Feb 2010 08:34:23 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1NcZkl-0004GT-L3; Wed, 03 Feb 2010 08:34:23 +0100
In-Reply-To: <20100203015947.GA4280@neumann> ("SZEDER =?iso-8859-1?Q?G=E1b?=
 =?iso-8859-1?Q?or=22's?= message of "Wed\, 3 Feb 2010 02\:59\:47 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 03 Feb 2010 08:34:24 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138811>

SZEDER G=E1bor <szeder@ira.uka.de> writes:

> No.  In case of rebase -i, exiting the editor is being explicit in
> "the todo file now contains what you should do, so do it".  And if th=
e
> todo file happens to be empty, then there is nothing to do, so do
> nothing.

It's not true. The todolist is the list of things to do after you
rewind your branch to the destination branch. Strictly speaking, an
empty todolist should mean to drop all the patches (like a todolist
with just one line would mean to drop all the others). But a user
never wants to do that (otherwise, "git reset" would be the right
command), so "git rebase -i" considers it as a special case.

My 2 cents,

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
