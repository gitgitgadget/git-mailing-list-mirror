From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: git push to a non-bare repository
Date: Mon, 19 Mar 2007 10:19:47 +0100
Message-ID: <vpq8xdtpp3g.fsf@olympe.imag.fr>
References: <vpq648ye9w6.fsf@olympe.imag.fr>
	<20070319020053.GA11371@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 19 10:20:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTE2M-0005Rl-Cb
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 10:20:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752391AbXCSJT7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 05:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752607AbXCSJT6
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 05:19:58 -0400
Received: from imag.imag.fr ([129.88.30.1]:33642 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752391AbXCSJT6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 05:19:58 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l2J9JlhT018633
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Mon, 19 Mar 2007 10:19:47 +0100 (CET)
Received: from olympe.imag.fr ([129.88.43.60])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1HTE1r-0002ZL-Fb
	for git@vger.kernel.org; Mon, 19 Mar 2007 10:19:47 +0100
Received: from moy by olympe.imag.fr with local (Exim 4.50)
	id 1HTE1r-0007o7-D4
	for git@vger.kernel.org; Mon, 19 Mar 2007 10:19:47 +0100
Mail-Followup-To: git@vger.kernel.org
In-Reply-To: <20070319020053.GA11371@thunk.org> (Theodore Tso's message of "Sun\, 18 Mar 2007 22\:00\:54 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 19 Mar 2007 10:19:47 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42601>

Theodore Tso <tytso@mit.edu> writes:

> On Sun, Mar 18, 2007 at 06:31:21PM +0100, Matthieu Moy wrote:
>> I have a repository with a working tree on a machine A, did a clone to
>> another machine B and commited there locally.
>> 
>> I want my changes to get back into the first repository, so I did a
>> "push". The new commit is in the history, I can see it with "git log",
>> but the modifications are not in the working tree.
>
> The general answer (which you've already received) is to tell folks is
> to simply don't use "git push" to remote trees; basically, if you ever
> have a non-bare repository, it doesn't do what you expect, and it will
> leave the novice user horribly confused.  A much better answer is to
> simply go back to machine A, and pull from machine B.

It's not really an option in my case. A is a fixe-IP/fixe-DNS machine,
while B is my home machine, behind a NAT modem-router. So, I'd have to
figure out my home IP, port-forward the ssh port from the modem to my
machine, ...

If I understand correctly the other answers, I have two options:

* Git doesn't manage this case, and doesn't care about me loosing data
  if they're not commited, I'll have to do it myself with hooks.

* Create a bare repository on machine A, and clone it to a non-bare
  repo on which I'll work. But that means duplicating the repository
  on the same filesystem of the same machine. Not really satisfactory
  either. The "light checkout" feature would make it better, but I'm
  still worried about what will happen to my light checkout when
  someone pushes to the repository.

-- 
Matthieu
