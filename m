From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 6/6] sparse: Fix mingw_main() argument number/type errors
Date: Tue, 30 Apr 2013 00:30:57 +0100
Message-ID: <517F02B1.3030304@ramsay1.demon.co.uk>
References: <517C24D3.8080802@ramsay1.demon.co.uk> <517C6DEF.2050305@lsrfire.ath.cx> <7v38uaqwow.fsf@alter.siamese.dyndns.org> <517E9B88.1040807@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue Apr 30 01:33:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWxZe-0000W9-Gw
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 01:33:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932527Ab3D2XdY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Apr 2013 19:33:24 -0400
Received: from mdfmta009.mxout.tbr.inty.net ([91.221.168.50]:51202 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932637Ab3D2XdS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 19:33:18 -0400
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id C86A4384083;
	Tue, 30 Apr 2013 00:33:16 +0100 (BST)
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id 21AC8384081;
	Tue, 30 Apr 2013 00:33:16 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP;
	Tue, 30 Apr 2013 00:33:15 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <517E9B88.1040807@lsrfire.ath.cx>
X-MDF-HostID: 4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222886>

Ren=C3=A9 Scharfe wrote:
> Am 28.04.2013 21:31, schrieb Junio C Hamano:
>> Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>>
>>> Why not take the opposite direction with a patch like this?
>>> ...
>>> diff --git a/compat/mingw.h b/compat/mingw.h
>>> index 389ae01..74e7b87 100644
>>> --- a/compat/mingw.h
>>> +++ b/compat/mingw.h
>>> @@ -452,11 +452,11 @@ int xwcstoutf(char *utf, const wchar_t *wcs, =
size_t utflen);
>>>
>>>   void mingw_startup();
>>>   #define main(c,v) dummy_decl_mingw_main(); \
>>> -static int mingw_main(); \
>>> +static int mingw_main(int, const char **); \
>>>   int main(int argc, const char **argv) \
>>
>> But traditionally main is declared like
>>
>> 	int main(int argc, char *argv[]);
>>
>> without const, no?
>=20
> Yes, http://c-faq.com/ansi/maindecl.html and basically everybody else=
=20
> agree.  Now that I actually think about it, the only benefit of=20
> declaring argv constant I can find is that the const'ness could easil=
y=20
> spread to other variables and function arguments where it may actuall=
y=20
> matter.  So please ignore my interjection.  Or perhaps it might be wo=
rth=20
> mentioning in the commit message that removal of that "const" improve=
s=20
> the code's standard compliance.

Hmm, well, strictly speaking, I can't say that is true! (see previous
email). It is certainly true that it more closely follows the *spirit*
of the standard, if not the letter of the law.

ATB,
Ramsay Jones
