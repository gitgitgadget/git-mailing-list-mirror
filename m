From: Wincent Colaiuta <win@wincent.com>
Subject: Re: gitweb bug: broken "next" and other links
Date: Tue, 12 Feb 2008 13:24:29 +0100
Message-ID: <E16BED2E-C146-44D8-BD90-ECF0DF89CA35@wincent.com>
References: <B0EC9FB3-DDDE-4BC5-92D8-20487CBD6725@wincent.com> <m3ve4vejdr.fsf@localhost.localdomain> <0811044D-4929-494F-8189-B0B4AFE2D373@wincent.com> <200802111630.29159.jnareb@gmail.com>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=UTF-8;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>, Petr Baudis <pasky@suse.cz>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 12 13:25:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOuCE-00029c-OB
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 13:25:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752869AbYBLMYg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Feb 2008 07:24:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752495AbYBLMYg
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 07:24:36 -0500
Received: from wincent.com ([72.3.236.74]:48160 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751892AbYBLMYf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Feb 2008 07:24:35 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id m1CCOUUN025368;
	Tue, 12 Feb 2008 06:24:31 -0600
In-Reply-To: <200802111630.29159.jnareb@gmail.com>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73657>

El 11/2/2008, a las 16:30, Jakub Narebski escribi=C3=B3:

> Dnia poniedzia=C5=82ek 11. lutego 2008 14:33, Wincent Colaiuta napisa=
=C5=82:
>> El 11/2/2008, a las 14:02, Jakub Narebski escribi=C3=B3:
>>> Wincent Colaiuta <win@wincent.com> writes:
>>>
>>>> Just noticed a bug (possibly bugs) in gitweb.
>>>>
>>>> Look at a shortlog page like this one:
>>>>
>>>> http://repo.or.cz/w/git.git?a=3Dshortlog
>>>>
>>>> Mouse over the "next" link at the bottom and you'll see this is th=
e
>>>> URL:
>>>>
>>>> http://repo.or.cz/w/ARRAY(0x85a5318)?a=3Dshortlog;pg=3D1
>>>>
>>>> Which obviously won't work...
>>>
>>> This is bug in repo.or.cz version of gitweb, which is slightly
>>> modified as compared to the "stock" version. Such error would be
>>> catched by the gitweb 'run as standalone script and check stderr'
>>> test script.
>>
>> Hmm. I don't know. I can reproduce all three of those bugs on my own
>> unmodified gitweb installation from 1.5.4.
>
> I'm sorry. You are right. I haven't seen breakage because it shows
> only when you use 'pathinfo' feature and pathinfo URLs.
>
> Below there is a fix for that; actully only second part mentioned
> (and first in patch) is needed, i.e. moving setting $params{'project'=
}
> before dealing with -replay is needed I think to fix this bug.
>
> Could you test it please?

Your patch fixes the "next" links in the shortlog and log views.

It doesn't fix the broken "raw" links in the commitdiff view. I'm =20
still seeing links like:

http://example.com/ARRAY(0x8c97f64)?a=3Dcommitdiff_plain;h=3Df29d56269a=
1c3bd4a970897397470f41553a64f9

Cheers,
Wincent
