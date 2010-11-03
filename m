From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git stash and manually edited chunks
Date: Wed, 03 Nov 2010 11:53:44 +0100
Message-ID: <vpqr5f2ptjb.fsf@bauges.imag.fr>
References: <AANLkTik6esqP2EkA6SFmfS0zdokG1iTKXqivA2wnpq=9@mail.gmail.com>
	<vpqfwvlkmkv.fsf@bauges.imag.fr>
	<AANLkTi=O8oPjcPN1j8513Kp+OtY7Cs5WgdiVhHnyzX=C@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Olivier Verdier <zelbier@gmail.com>, git@vger.kernel.org
To: Gavin Guo <tuffkidtt@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 03 11:53:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDayb-0007Nd-V3
	for gcvg-git-2@lo.gmane.org; Wed, 03 Nov 2010 11:53:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754581Ab0KCKxw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Nov 2010 06:53:52 -0400
Received: from mx2.imag.fr ([129.88.30.17]:59450 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754307Ab0KCKxu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Nov 2010 06:53:50 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id oA3AlEik019351
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 3 Nov 2010 11:47:14 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PDayO-00075w-Jw; Wed, 03 Nov 2010 11:53:44 +0100
In-Reply-To: <AANLkTi=O8oPjcPN1j8513Kp+OtY7Cs5WgdiVhHnyzX=C@mail.gmail.com> (Gavin Guo's message of "Wed\, 3 Nov 2010 11\:06\:30 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 03 Nov 2010 11:47:14 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: oA3AlEik019351
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1289386037.39398@4OZqGf7TFvEbMJVI0VmZrg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160594>

Gavin Guo <tuffkidtt@gmail.com> writes:

>> Let's say the state of your working tree here is A (and last commit =
is
>> HEAD).
>>
>>> * git add -p my_file
>>> * I=A0edit a chunk *manually*=A0(using=A0e)
>>
>> Here, the index contains a state which is neither in the working tre=
e
>> nor in the last commit. Let's call this state B.
>>
>>> * git stash --keep-index
>>
>> Here, the working tree takes state B.
>>
>>> * git stash pop
>>
>> Here, you're trying to apply the stash, which is somehow a diff
>> between HEAD and A, on your tree which is in state B. Hence the
>> conflicts.
>
> I am confusing about the description here. Git stash --keep-index
> exist after editing the hunk, so why stash will save the difference
> between HEAD and A, I think it should be the state which is modified
> by git add -p(using e), and as a result of no conflict.

It's actually both. And indeed, "diff" is slightly oversimplified :
stash saves the state of HEAD and of the index, as two commits. Try
running "gitk --all" after stash to see what's going on.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
