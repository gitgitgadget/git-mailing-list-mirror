From: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
Subject: Re: [eclipse7@gmx.net: [PATCH] diff: Only count lines in show_shortstats()]
Date: Thu, 14 Jun 2012 21:07:20 +0200
Message-ID: <4FDA3668.3000900@in.waw.pl>
References: <20120607122149.GA3070@akuma> <4FD0FB75.4090906@in.waw.pl> <20120607200434.GA2965@akuma> <7vk3zig92n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Alexander Strasser <eclipse7@gmx.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>, mj@ucw.cz,
	Johannes Sixt <j.sixt@viscovery.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 14 21:07:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SfFOU-0003mP-SQ
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jun 2012 21:07:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756585Ab2FNTHm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jun 2012 15:07:42 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:38558 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752265Ab2FNTHm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2012 15:07:42 -0400
Received: from 69-mo7-2.acn.waw.pl ([85.222.93.69] helo=[192.168.0.150])
	by kawka.in.waw.pl with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1SfFOO-0002zg-QS; Thu, 14 Jun 2012 21:07:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.3) Gecko/20120329 Icedove/10.0.3
In-Reply-To: <7vk3zig92n.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200028>

On 06/07/2012 10:29 PM, Junio C Hamano wrote:
>>>> >> > --- a/t/t4012-diff-binary.sh
>>>> >> > +++ b/t/t4012-diff-binary.sh
>>>> >> > @@ -36,6 +36,14 @@ test_expect_success '"apply --stat" output for binary file change' '
>>>> >> >  	test_i18ncmp expected current
>>>> >> >  '
>>>> >> >  
>>>> >> > +cat > expected <<\EOF
>>>> >> > + 4 files changed, 2 insertions(+), 2 deletions(-)
>>>> >> > +EOF
>>>> >> > +test_expect_success 'diff with --shortstat' '
>>>> >> > +	git diff --shortstat >current &&
>>>> >> > +	test_cmp expected current
>>>> >> > +'
>>>> >> > +
>>> >> The test is OK, and follows the style of surrounding tests, but current
>>> >> style is slightly different:
>>> >> - no space after '>'
>>> >> - expected output is inlined if it is short
>>> >> - test_i18ncmp is used, even if the message is not yet i18n-ized
>>> >> 
>>> >> Something like this:
>>> >> test_expect_success 'diff --shortstat output for binary file change' '
>>> >> 	echo " 4 files changed, 2 insertions(+), 2 deletions(-)" >expect &&
>>> >> 	git diff --shortstat >current &&
>>> >> 	test_i18ncmp expect current
>>> >> '
>> >
>> >   Should I rewrite the test for this patch? Or should it be changed for the
>> > whole file at once?
> Please keep a bugfix patch to only fixes with tests.  Style fixes
> should be done later after dust from more important changes (e.g. a
> bugfix) settles.
> 
> Thanks.
Does this need a v2?

Zbyszek
