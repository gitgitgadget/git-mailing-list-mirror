From: Wincent Colaiuta <win@wincent.com>
Subject: Re: A few usability question about git diff --cached
Date: Thu, 4 Oct 2007 16:09:20 +0200
Message-ID: <5159468E-C263-4F7B-AEBA-8392C4742C47@wincent.com>
References: <4d8e3fd30710040527j61152b2dh1b073504ba19d490@mail.gmail.com> <20071004125641.GE15339@genesis.frugalware.org> <7vy7ej9g38.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 04 16:10:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdRPB-0008OU-G3
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 16:10:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755966AbXJDOKL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Oct 2007 10:10:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756023AbXJDOKK
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 10:10:10 -0400
Received: from wincent.com ([72.3.236.74]:50947 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754803AbXJDOKJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Oct 2007 10:10:09 -0400
Received: from [192.168.0.129] (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id l94E9R7r017442;
	Thu, 4 Oct 2007 09:09:28 -0500
In-Reply-To: <7vy7ej9g38.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59954>

El 4/10/2007, a las 15:14, Junio C Hamano escribi=F3:

> Miklos Vajna <vmiklos@frugalware.org> writes:
>
>> On Thu, Oct 04, 2007 at 02:27:41PM +0200, Paolo Ciarrocchi =20
>> <paolo.ciarrocchi@gmail.com> wrote:
>>> Why do we have the option "--cached" and not "--index"?
>>
>> according to glossary.txt, 'cache' is an obsolete for 'index'. =20
>> probably
>> this is the reason
>>
>> probably cache.h will be never renamed to index.h, i don't know if =20
>> diff
>> --cached will be ever renamed to diff --index
>
> Probably never.
>
> Some commands support both --index and --cached and have
> different meanings.  For them,
>
>  * --index means work on both index and work tree;
>  * --cached means work only on index and ignore work tree.

Look at that with fresh eyes and you can see how it makes very little =20
sense.

The option named "--index" works on more than the index and the =20
option named "--cached" works only on the index. This sounds back-to-=20
front.

IMO, better names would be:

--index : means work only on the index (and ignore the work tree); =20
ie. it means what it says

--index-and-worktree : it also means what it says

The latter is more keystrokes but it's clearer.

Having said all this, I recognize that the likelihood of these option =20
names ever being changed is close to zero. Like Paolo says in his =20
other email, the documentation could be made clearer to avoid =20
possible confusion.

Cheers,
Wincent
