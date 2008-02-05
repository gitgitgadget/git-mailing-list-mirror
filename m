From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH] git-stash: alias 'list' to 'ls' and 'clear' to 'rm'
Date: Tue, 5 Feb 2008 13:12:06 +0100
Message-ID: <773F09A7-0871-4950-BDE4-D54E822C8203@wincent.com>
References: <1202207899-28578-1-git-send-email-tim@stoakes.net> <D512F3C0-3354-40BB-BD8D-8B3A85196825@wincent.com> <20080205112000.GD29545@mail.stoakes.net>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Tim Stoakes <tim@stoakes.net>
X-From: git-owner@vger.kernel.org Tue Feb 05 13:13:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMMfz-0001qC-LH
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 13:13:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753442AbYBEMMa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Feb 2008 07:12:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751681AbYBEMM3
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 07:12:29 -0500
Received: from wincent.com ([72.3.236.74]:57766 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753046AbYBEMM2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Feb 2008 07:12:28 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id m15CC75u008555;
	Tue, 5 Feb 2008 06:12:08 -0600
In-Reply-To: <20080205112000.GD29545@mail.stoakes.net>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72650>

El 5/2/2008, a las 12:20, Tim Stoakes escribi=F3:

> Wincent Colaiuta(win@wincent.com)@050208-12:06:
>> El 5/2/2008, a las 11:38, Tim Stoakes escribi?:
>>
>>> clear::
>>> +rm::
>>> 	Remove all the stashed states. Note that those states will then
>>> 	be subject to pruning, and may be difficult or impossible to =20
>>> recover.
>>
>> Isn't "rm" a bit misleading here? Seeing as the clear subcommand =20
>> really
>> does an "rm -rf".
>
> $ git stash clear foo
> git stash clear with parameters is unimplemented
>
> It appears that 'clear' is intended to behave like 'rm', however, it
> isn't implemented yet.

No, I don't think it was ever _intended_ to behave like rm. It does =20
pretty much what the man page says, clears all stashed states and that =
=20
was always its intention.

But lots of people have said that they'd like to be able to pop only =20
to topmost stash off the stack, or delete a specific stash, and some =20
have reported being caught by surprise and clearing all stashes when =20
they only wanted to delete one of them. There were patch(es) to the =20
mailing list a while back teaching "git reflog" to delete specific =20
entries, and seeing as "git stash" is built on top of reflogs the idea =
=20
was that if someone wants to implement a subcommand for deleting =20
specific stashes (or a push/pop kind of thing) then the reflog stuff =20
would enable that. I think the refog patch(es) was/were from Dscho. I =20
can't remember who/if has followed up with push/pop/delete patches for =
=20
"git stash".

Cheers,
Wincent
