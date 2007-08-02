From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: git-diff on touched files: bug or feature?
Date: Thu, 02 Aug 2007 17:45:20 +0200
Message-ID: <vpqtzrivt2n.fsf@bauges.imag.fr>
References: <vpqwswf8c1i.fsf@bauges.imag.fr>
	<7v4pjj5fp6.fsf@assigned-by-dhcp.cox.net>
	<vpqhcni47ek.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0708021050500.14781@racer.site>
	<vpqbqdq45ua.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0708021147110.14781@racer.site>
	<AF1190E2-A0F4-479F-B0A1-50B2C7278995@yahoo.ca>
	<Pine.LNX.4.64.0708021541520.14781@racer.site>
	<46B1F3F4.5030504@midwinter.com>
	<Pine.LNX.4.64.0708021614420.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Grimm <koreth@midwinter.com>,
	=?iso-8859-1?Q?Jean-Fran=E7ois?= Veillette 
	<jean_francois_veillette@yahoo.ca>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Aug 02 17:46:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGcsK-0003TW-2N
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 17:46:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753436AbXHBPpq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 11:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753387AbXHBPpq
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 11:45:46 -0400
Received: from imag.imag.fr ([129.88.30.1]:55514 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753339AbXHBPpp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 11:45:45 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l72FjK6V001915
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 2 Aug 2007 17:45:21 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1IGcrY-0007Zz-RV; Thu, 02 Aug 2007 17:45:20 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1IGcrY-0003cx-PA; Thu, 02 Aug 2007 17:45:20 +0200
Mail-Followup-To: Johannes Schindelin <Johannes.Schindelin@gmx.de>, Steven
 Grimm <koreth@midwinter.com>, =?iso-8859-1?Q?Jean-Fran=E7ois?= Veillette
 <jean_francois_veillette@yahoo.ca>, Junio C Hamano <gitster@pobox.com>,
  git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0708021614420.14781@racer.site> (Johannes Schindelin's message of "Thu\, 2 Aug 2007 16\:23\:38 +0100 \(BST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Thu, 02 Aug 2007 17:45:21 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54567>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Okay, I'll answer just this one, instead of pointing you to the thread 
> that I've been pointing to twice now

The link was probably not the right one since I saw only two [PATCH]
message, but yes, I remember a thread pointing out why git-status had
to update the index. I'm not arguing against that, I'm happy with the
current git-status behavior, but I find the git-diff one inconsistant
with git-status, and still don't understand any reason why a normal
user would want a difference.

> When is the time to say "git status"?
>
> It is just before committing.  I.e when you really think that you're done 
> editing, and want to have the end picture.  "git status" only gives you 
> names, and therefore it _has_ to update the index if it got out of sync, 
> to show meaningful results.
>
> When is the time to say "git diff"?
>
> Much more often.  In the middle of your work.  And there it would be 
> _disruptive_ if it updated the index all the time, especially if you have 
> a quite large working tree.

That's your point of view, but I do not share it. Depending on the
kind of things I'm doing, I usually run status regularly, because it's
short to read, and it shows me both staged and unstaged changes.
git-status tells me if I did something obviously totally wrong
(changing a file on which I was not working, deleting something
important ...), and after that, git-diff gives me a finer-grained
vision of what I did.

Does this really sound so much irreasonable to you?

-- 
Matthieu
