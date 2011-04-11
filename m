From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 6/9] gettext.h: Avoid using a non-standard C construct
Date: Mon, 11 Apr 2011 18:15:33 +0100
Message-ID: <4DA33735.5070402@ramsay1.demon.co.uk>
References: <4D9E056C.1070906@ramsay1.demon.co.uk> <20110407221015.GA20080@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>, bebarino@gmail.com,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 11 20:25:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9LnR-0001Fz-6Y
	for gcvg-git-2@lo.gmane.org; Mon, 11 Apr 2011 20:25:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755189Ab1DKSZA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Apr 2011 14:25:00 -0400
Received: from lon1-post-3.mail.demon.net ([195.173.77.150]:62503 "EHLO
	lon1-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754851Ab1DKSZA (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Apr 2011 14:25:00 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-3.mail.demon.net with esmtp (Exim 4.69)
	id 1Q9LnG-0002rG-f6; Mon, 11 Apr 2011 18:24:59 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <20110407221015.GA20080@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171345>

Jonathan Nieder wrote:
>> +++ b/gettext.h
>> @@ -35,6 +35,6 @@ const char *Q_(const char *msgid, const char *plu, unsigned long n)
> [...]
>> -#define N_(msgid) (msgid)
>> +#define N_(msgid) msgid
> 
> Good catch.  Thanks!
> 
>> In particular, standard C does not allow a parenthesized string
>> as an array initializer.
> 
> The subject line seems unnecessarily vague.  Why not:
> 
> 	i18n: avoid parenthesized string as array initializer
> 
> 	The syntax
> 
> 		static const char ignore_error[] = ("something");
> 
> 	is invalid C.  GCC and MSVC can parse it, but for example
> 	tcc cannot.  So remove the parenthesis from the definition
> 	of the N_() macro.
> 
> 	Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> 	Acked-by: Jonathan Nieder <jrnieder@gmail.com>
> 

Sounds good to me. I'll re-roll and use your message verbatim.

Thanks!

ATB,
Ramsay Jones
