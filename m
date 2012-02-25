From: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
Subject: Re: [PATCH] grep -P: Fix matching ^ and $
Date: Sat, 25 Feb 2012 18:52:56 +0100
Message-ID: <4F491FF8.9070609@in.waw.pl>
References: <1330161868-7954-1-git-send-email-michal.kiedrowicz@gmail.com> <20120225103050.14f52a91@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?TWljaGHFgiBLaWVkcm93aWN6?= <michal.kiedrowicz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 25 18:53:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1LoM-0000PZ-78
	for gcvg-git-2@plane.gmane.org; Sat, 25 Feb 2012 18:53:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757353Ab2BYRxG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 Feb 2012 12:53:06 -0500
Received: from kawka.in.waw.pl ([178.63.212.103]:55146 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757233Ab2BYRxF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Feb 2012 12:53:05 -0500
Received: from 89-78-221-60.dynamic.chello.pl ([89.78.221.60] helo=[192.168.0.12])
	by kawka.in.waw.pl with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1S1Lnq-0004SA-7c; Sat, 25 Feb 2012 18:53:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:8.0) Gecko/20120104 Icedove/8.0
In-Reply-To: <20120225103050.14f52a91@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191540>

On 02/25/2012 10:30 AM, Micha=C5=82 Kiedrowicz wrote:
> Micha=C5=82 Kiedrowicz<michal.kiedrowicz@gmail.com>  wrote:
>
>> When `git-grep` is run with -P/--perl-regexp, it doesn't match ^ and=
 $ at
>> the beginning/end of the line.  This is because PCRE normally matche=
s ^
>> and $ at the beginning/end of the whole text, not for each line, and=
 git-grep
>> firstly passes a large chunk of text (possibly containing many lines=
) to
>> pcre_exec() before it splits the text into lines.  This makes `git-g=
rep -P`
>> behave differently from `git-grep -E` and also from `grep -P` and `p=
cregrep`:

Thanks! I can confirm that I now get the expected output.

Zbyszek

> Original report:
> http://permalink.gmane.org/gmane.comp.version-control.git/190830
