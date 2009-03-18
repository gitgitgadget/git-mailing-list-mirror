From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH] contrib/difftool: use a separate config namespace for difftool commands
Date: Wed, 18 Mar 2009 11:53:31 +0100
Message-ID: <EBA0E851-C259-4CA7-BF59-302300C0C3DC@wincent.com>
References: <1236589956-13486-1-git-send-email-davvid@gmail.com> <76718490903090852se7fc756m818f5d8ba49278b5@mail.gmail.com> <20090310070122.GB4523@gmail.com> <200903172054.46063.markus.heidelberg@web.de> <7veiwvpvhp.fsf@gitster.siamese.dyndns.org> <20090318043543.GB13653@gmail.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, markus.heidelberg@web.de,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 11:58:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjtTs-0007RW-AG
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 11:58:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754020AbZCRKxj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Mar 2009 06:53:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753637AbZCRKxj
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 06:53:39 -0400
Received: from wincent1.inetu.net ([209.235.192.161]:40362 "EHLO
	wincent1.inetu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753453AbZCRKxi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Mar 2009 06:53:38 -0400
Received: from cuzco.lan (207.pool85-53-9.dynamic.orange.es [85.53.9.207])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id n2IArVWk028534
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Wed, 18 Mar 2009 06:53:33 -0400
In-Reply-To: <20090318043543.GB13653@gmail.com>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113609>

El 18/3/2009, a las 5:35, David Aguilar escribi=F3:

> Junio C Hamano <gitster@pobox.com> wrote:
>> Markus Heidelberg <markus.heidelberg@web.de> writes:
>>
>>> Jay Soffian <jaysoffian@gmail.com> wrote:
>>>>
>>>> Aside, (for Junio I guess...), what's the reason this command is i=
n
>>>> contrib, and by what criteria might it graduate to being installed
>>>> with the rest of the git commands?
>>>>
>>>> j.
>>>
>>> I'd like to see it as a general git tool, too.
>>> Maybe it can even share some common functionality with git-=20
>>> mergetool.
>>
>> The code was copied and pasted very heavily, and I think (IIRC) the =
=20
>> author
>> was a bit too ashamed to have it outside contrib/ before it is =20
>> properly
>> refactored or something like that.  Which I happen to agree with, =20
>> by the
>> way.
>
> I'll work on some patches to get the ball rolling on this.
>
>
> Here's what I see as the steps I would take:
>
> 1. move difftool into the root, update Makefile, etc.
>
> 2. factor out the similarities between merge/difftool and
> put them in maybe git-tool-lib.sh?

Given that git-difftool shares basically all the same options as "git =20
diff", I think a good long-term plan would be looking at adding the "--=
=20
tool" option to "git diff" itself so that users wouldn't have to learn =
=20
a new subcommand, just a new option.

(Whether this is done by rolling the functionality of "git-difftool" =20
into "git diff" itself, or delegating to a separate "git-difftool" =20
command doesn't matter so much, now that most commands are neatly =20
tucked away in $(git --exec-path) now.)

Cheers,
Wincent
