From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH 2/4] Teach git-add--interactive to accept a file path to patch
Date: Wed, 21 Nov 2007 23:44:33 +0100
Message-ID: <C6E820C8-91E9-48B2-9219-377CA83163A7@wincent.com>
References: <1195648601-21736-1-git-send-email-win@wincent.com> <1195648601-21736-2-git-send-email-win@wincent.com> <1195648601-21736-3-git-send-email-win@wincent.com> <20071121152118.GG24108@sigill.intra.peff.net> <7vejejfi28.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 21 23:46:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuyL9-0001gi-D3
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 23:46:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753055AbXKUWqV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Nov 2007 17:46:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752978AbXKUWqV
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 17:46:21 -0500
Received: from wincent.com ([72.3.236.74]:55992 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752844AbXKUWqU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Nov 2007 17:46:20 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lALMiY5O029006;
	Wed, 21 Nov 2007 16:44:35 -0600
In-Reply-To: <7vejejfi28.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65710>

El 21/11/2007, a las 21:40, Junio C Hamano escribi=F3:

> Jeff King <peff@peff.net> writes:
>
>> ...
>> On top of that, it would be great to be able to do something like
>>
>>  git-add -i *.c
>>
>> and just get prompted for changed files (right now, you only get
>> prompted for changed files, but unchanged files seem to print a =20
>> spurious
>> newline).
>>
>> And at any rate, this would require fixing 3/4 to handle the multipl=
e
>> files from git-add.
>>
>> What do you think?
>
> If we are to add path limited behaviour, I think it should also
> grok "git-add -i sub/dir/".  IOW, you would want to have the
> same path selection semantics as git-add without the
> "interactive" bit.

I can work on adding support for dirs as well as files, but am =20
wondering what the desired behaviour is:

- Jeff would like to pass "*.c" and have it only add changed files, =20
not unchanged or untracked files

- Junio, do you mean to suggest with your comment that when passing =20
untracked files either directly or indirectly (ie. when passing a dir =20
containing untracked files) that they should be added (ie. invoked the =
=20
"add untracked" subcommand) in addition to running the "patch" =20
subcommand on the changed files?

Of these two approaches, I suspect that the latter would be more =20
"correct", because it would be consistent with the "not interactive" =20
version of git-add.

Cheers,
Wincent
