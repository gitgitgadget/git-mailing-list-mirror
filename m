From: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
Subject: Re: [PATCH 3/3] fetch: Use the remote's ref name to decide how to
 describe new refs.
Date: Tue, 17 Apr 2012 10:39:44 +0200
Message-ID: <4F8D2C50.3060502@in.waw.pl>
References: <1334591542-25136-1-git-send-email-marcnarc@xiplink.com> <1334614130-31826-1-git-send-email-marcnarc@xiplink.com> <1334614130-31826-4-git-send-email-marcnarc@xiplink.com> <20120416223429.GA13440@burratino> <4F8D2195.9030507@in.waw.pl> <20120417075740.GE20017@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: marcnarc@xiplink.com, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 17 10:40:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SK3xL-0008IN-Ko
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 10:40:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755415Ab2DQIkE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Apr 2012 04:40:04 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:35024 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755313Ab2DQIkB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2012 04:40:01 -0400
Received: from [193.0.104.37]
	by kawka.in.waw.pl with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1SK3x2-0007o2-05; Tue, 17 Apr 2012 10:39:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.3) Gecko/20120324 Icedove/10.0.3
In-Reply-To: <20120417075740.GE20017@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195745>

On 04/17/2012 09:57 AM, Jonathan Nieder wrote:
> Zbigniew J=C4=99drzejewski-Szmek wrote:
>> On 04/17/2012 12:34 AM, Jonathan Nieder wrote:
>>> marcnarc@xiplink.com wrote:
>
>>>> +	echo "Nuts" >> crazy &&
>>>> +	git add crazy &&
>>>> +	git commit -a -m "descriptive commit" &&
>>>> +	git update-ref refs/others/crazy HEAD &&
>>>> +	(
>>>> +		cd descriptive &&
>>>> +		git fetch o 2> actual
>>
>> redirections should be without spaces between '>' and the filename
>> (>>crazy, 2>actual), for portability.
>
> I think you mean for consistency.  A space between the operator and
> filename is perfectly portable, though git's tests tend to use a
> style without the space.
Yes, you're right. I mixed up the motivation for two different rules...

Quoting Junio C Hamano:
>  - Strictly speaking, the target of I/O redirection (e.g. >"$name") d=
oes
>    not have to have quotes around it, but some versions of bash are k=
nown
>    to give misguided warnings against it;
>
>  - We do not write SP between the redirection and filename, but we do=
 have
>    one SP before the redirection; and
So rule #2 is for consistency, rule #1 for portability.

-
Zbyszek
