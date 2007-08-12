From: Wincent Colaiuta <win@wincent.com>
Subject: Re: --exit-code (and --quiet) broken in git-diff?
Date: Sun, 12 Aug 2007 18:57:20 +0200
Message-ID: <8C80CB6C-83A5-437D-9360-AC93B73EAA54@wincent.com>
References: <17875.88.10.191.55.1186873960.squirrel@secure.wincent.com>	<46BED5AA.7050900@lsrfire.ath.cx>	<24332.88.10.191.55.1186917895.squirrel@secure.wincent.com> <85643lq99h.fsf@lola.goethe.zz> <46BF04F0.5020304@midwinter.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Kastrup <dak@gnu.org>,
	=?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Sun Aug 12 18:57:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKGlK-0008NL-F6
	for gcvg-git@gmane.org; Sun, 12 Aug 2007 18:57:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757802AbXHLQ5y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 12 Aug 2007 12:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752497AbXHLQ5y
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Aug 2007 12:57:54 -0400
Received: from wincent.com ([72.3.236.74]:58898 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757167AbXHLQ5x convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Aug 2007 12:57:53 -0400
Received: from [192.168.1.99] (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id l7CGvSBZ022745;
	Sun, 12 Aug 2007 11:57:42 -0500
In-Reply-To: <46BF04F0.5020304@midwinter.com>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55690>

El 12/8/2007, a las 15:02, Steven Grimm escribi=F3:

> David Kastrup wrote:
>> I think I would call that a mistake.  However, I don't see that =20
>> fixing
>> it would actually be useful: if a pager gets called, this means that
>> git-diff might die with SIGPIPE (when the user quits the pager), and
>> that in turn has pretty much no meaning.  So one really needs to
>> redirect the output, anyway.
>>
>
> It does sort of make one wonder, though, if there's much point ever =20
> launching a pager when git-diff is run with --quiet -- it will =20
> never produce any output to page, so running a pager is guaranteed =20
> to always be a waste of cycles.

Yes, I thought the same thing when I read in the initial release =20
notes (<http://www.kernel.org/pub/software/scm/git/docs/=20
RelNotes-1.5.1.txt>) that the "--quiet" option was explicitly "meant =20
for scripted use", where naturally you don't want or need a pager... =20
turns out I was writing a script, you see, and I wanted to test the =20
commands out manually to be sure they did what I thought they would...

But as you say, refactoring this to bypass the pager when "--quiet" =20
is passed may be unpleasantly complicated.

Cheers,
Wincent
