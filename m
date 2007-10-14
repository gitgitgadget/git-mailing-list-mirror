From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH] Add color to git-add--interactive diffs (Take 2: now without spurious line break!)
Date: Sun, 14 Oct 2007 23:01:27 +0200
Message-ID: <DFCD949F-2E7E-417A-9B58-A220A83695F5@wincent.com>
References: <1192351494.7226.18.camel@athena> <EFADE863-FC59-4A50-B165-9D30D9648B97@wincent.com> <Pine.LNX.4.64.0710141814100.25221@racer.site>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tom Tobin <korpios@korpios.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Oct 14 23:02:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhAbH-000296-8A
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 23:02:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759125AbXJNVCE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Oct 2007 17:02:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752924AbXJNVCD
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 17:02:03 -0400
Received: from wincent.com ([72.3.236.74]:48885 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753901AbXJNVCB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Oct 2007 17:02:01 -0400
Received: from [192.168.0.129] (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id l9EL1u4B024720;
	Sun, 14 Oct 2007 16:01:57 -0500
In-Reply-To: <Pine.LNX.4.64.0710141814100.25221@racer.site>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60905>

El 14/10/2007, a las 19:15, Johannes Schindelin escribi=F3:

> On Sun, 14 Oct 2007, Wincent Colaiuta wrote:
>
>>> +sub parse_color {
>>
>> You could simplify the manual escape sequence construction that =20
>> you're
>> doing here by using Term::ANSIColor like the other patches did. I se=
e
>> that git-send-email.perl uses that module too, so I guess =20
>> depending on
>> that module is ok.
>
> Wrong.  Depending on that module is not correct, you always have to =20
> wrap
> it into an "if (<is_color>) {...}".
>
> I use git add -i quite often, and I _never_ use git send-email.  My =20
> guess
> is that I am not alone with that.

In that case I propose factoring out the escape sequence generation =20
into git.pm, where it can be used by git-send-email, git-add--=20
interactive, or any other Perl script in Git. Do you think that's a =20
good idea? If so I'll try whipping up a patch along those lines.

Wincent
