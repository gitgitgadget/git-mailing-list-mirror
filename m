From: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
Subject: Re: [PATCH 3/3] fetch: Use the remote's ref name to decide how to
 describe new refs.
Date: Tue, 17 Apr 2012 09:53:57 +0200
Message-ID: <4F8D2195.9030507@in.waw.pl>
References: <1334591542-25136-1-git-send-email-marcnarc@xiplink.com> <1334614130-31826-1-git-send-email-marcnarc@xiplink.com> <1334614130-31826-4-git-send-email-marcnarc@xiplink.com> <20120416223429.GA13440@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: marcnarc@xiplink.com
X-From: git-owner@vger.kernel.org Tue Apr 17 09:54:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SK3FE-0000mP-F8
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 09:54:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754063Ab2DQHyJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Apr 2012 03:54:09 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:35012 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751793Ab2DQHyI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2012 03:54:08 -0400
Received: from [193.0.104.37]
	by kawka.in.waw.pl with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1SK3Eh-0007ZO-4C; Tue, 17 Apr 2012 09:54:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.3) Gecko/20120324 Icedove/10.0.3
In-Reply-To: <20120416223429.GA13440@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195739>

On 04/17/2012 12:34 AM, Jonathan Nieder wrote:
> marcnarc@xiplink.com wrote:
>
>> +		grep descriptive-branch actual | grep "[new branch]"&&
>> +		grep descriptive-tag actual | grep "[new tag]"&&
>> +		grep others/crazy actual | grep "[new ref]"
>
> Careful. :)  I suppose the simplest fix would be to leave out the
> brackets so the '[new ref]' tag is not misinterpreted as a character
> class, like so:
>
> 	grep "new branch.*descriptive-branch" actual&&
> 	grep "new tag.*descriptive-tag" actual&&
> 	grep "new ref.*others/crazy" actual

s/grep/test_i18ngrep/

Also:
>> +	echo "Nuts" >> crazy &&
>> +	git add crazy &&
>> +	git commit -a -m "descriptive commit" &&
>> +	git update-ref refs/others/crazy HEAD &&
>> +	(
>> +		cd descriptive &&
>> +		git fetch o 2> actual
redirections should be without spaces between '>' and the filename
(>>crazy, 2>actual), for portability.

Zbyszek
