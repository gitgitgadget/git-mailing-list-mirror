From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH] RFC - Say goodbye to the rodent
Date: Wed, 05 Aug 2009 13:54:36 +0200
Message-ID: <vpqljlycw77.fsf@bauges.imag.fr>
References: <1249465906-3940-1-git-send-email-ayiehere@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nazri Ramliy <ayiehere@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 05 13:54:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYf50-0007ws-VD
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 13:54:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933503AbZHELyo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 07:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933321AbZHELyn
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 07:54:43 -0400
Received: from mx2.imag.fr ([129.88.30.17]:59319 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933301AbZHELym (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 07:54:42 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id n75Bron5018787
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 5 Aug 2009 13:53:50 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1MYf4m-0001La-HH; Wed, 05 Aug 2009 13:54:36 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1MYf4m-0008Sx-Ft; Wed, 05 Aug 2009 13:54:36 +0200
In-Reply-To: <1249465906-3940-1-git-send-email-ayiehere@gmail.com> (Nazri Ramliy's message of "Wed\,  5 Aug 2009 17\:51\:40 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 05 Aug 2009 13:53:50 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: n75Bron5018787
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1250078031.83593@Qz21yYuKI/6ivCOBrgZbyQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124899>

Nazri Ramliy <ayiehere@gmail.com> writes:

> Oftentimes I get tired of moving my hand away from the comfort of the home rows
> of my keybard in order to grab the mouse to highlight the files that I'd like
> to operate on.

Usually, when you cut-and-paste from $(git status), it's to run a
staging/unstaging command, or to view a diff.

Actually, "git add -i" is already a pretty good way of doing this,
with few keystrokes.
> Example:
>
> $ git status --id
> # On branch local
> # Changed but not updated:
> #   (use "git add <file>..." to update what will be committed)
> #   (use "git checkout -- <file>..." to discard changes in working directory)
> #
> #       modified:   builtin-write-tree.c (m1)
> #
> # Untracked files:
> #   (use "git add <file>..." to include in what will be committed)
> #
> #       file1.c (x1)
> #       file2.c (x2)

$ git add -i
           staged     unstaged path
  1:    unchanged        +1/-0 builtin-write-tree.c

*** Commands ***
  1: [s]tatus     2: [u]pdate     3: [r]evert     4: [a]dd untracked
  5: [p]atch      6: [d]iff       7: [q]uit       8: [h]elp

> Now we can do the following:
>
> $ git add --id m1

What now> u
           staged     unstaged path
  1:    unchanged        +1/-0 [b]uiltin-write-tree.c
Update>> 1
           staged     unstaged path
* 1:    unchanged        +1/-0 [b]uiltin-write-tree.c
Update>> 
updated one path

*** Commands ***
  1: [s]tatus     2: [u]pdate     3: [r]evert     4: [a]dd untracked
  5: [p]atch      6: [d]iff       7: [q]uit       8: [h]elp

> Ids are specified via the --id command line option, and can be separated with
> commas if you want to specify more than one of them:
>
> $ git add --id m1,x2

What now> a
  1: file1.c
  2: file2.c
Add untracked>> 1
* 1: file1.c
  2: file2.c
Add untracked>> 2
* 1: file1.c
* 2: file2.c
Add untracked>> 
added 2 paths

for these examples, I have far fewer keystrokes with "git add -i" than
you have. I don't think it's worth adding yet-another-option to most
Git commands since it doesn't really bring much IMHO.

-- 
Matthieu
