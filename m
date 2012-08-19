From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [RFC/PATCH] t3300-*.sh: Fix a TAP parse error
Date: Sun, 19 Aug 2012 18:57:37 +0100
Message-ID: <50312911.30904@ramsay1.demon.co.uk>
References: <500AEB11.4050006@ramsay1.demon.co.uk> <20120721182049.GL19860@burratino> <500EEAAA.8030604@ramsay1.demon.co.uk> <7veho1exu6.fsf@alter.siamese.dyndns.org> <501043D9.70604@ramsay1.demon.co.uk> <20120725205120.GD4732@burratino> <7vk3wyxv6e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 19 21:17:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3B01-0008A0-12
	for gcvg-git-2@plane.gmane.org; Sun, 19 Aug 2012 21:17:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754600Ab2HSTRR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Aug 2012 15:17:17 -0400
Received: from mdfmta004.mxout.tbr.inty.net ([91.221.168.45]:40734 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754332Ab2HSTQm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Aug 2012 15:16:42 -0400
Received: from mdfmta004.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta004.tbr.inty.net (Postfix) with ESMTP id 8AD4CA0C07F;
	Sun, 19 Aug 2012 20:16:41 +0100 (BST)
Received: from mdfmta004.tbr.inty.net (unknown [127.0.0.1])	by mdfmta004.tbr.inty.net (Postfix) with ESMTP id B0453A0C084;	Sun, 19 Aug 2012 20:16:40 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta004.tbr.inty.net (Postfix) with ESMTP;	Sun, 19 Aug 2012 20:16:33 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:14.0) Gecko/20120713 Thunderbird/14.0
In-Reply-To: <7vk3wyxv6e.fsf@alter.siamese.dyndns.org>
X-MDF-HostID: 9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203732>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>> Ramsay Jones wrote:
>>> Junio C Hamano wrote:
>>
>>>> Observing that all well-written test scripts we have begin with this
>>>> boilerplate line:
>>>>
>>>> 	test_expect_success setup '
>>>>
>>>> I wouldn't mind introducing a new helper function test_setup that
>>>> behaves like test_expect_success but is meant to be used in the
>>>> first "set-up" phase of the tests in a test script.
>>
>> Neat.  This could be used for later set-up tests, too, perhaps with a
>> long-term goal of making non set-up tests independent of each other
>> (reorderable and skippable).
>>
>> [...]
>>> [1] For example, what should/will happen if someone uses test_must_fail,
>>> test_might_fail, etc., within the test_fixture script? Should they simply
>>> be banned within a text_fixture?
>>
>> Why wouldn't they act just like they do in test_expect_success blocks?
>>
>> FWIW I find Junio's test_setup name more self-explanatory.  What
>> mnemonic should I be using to remember the _fixture name?
> 
> I see that I was distracted by the "where does the fixture come
> from" and did not follow through.
> 
> I think what it does makes sense (I haven't checked all the
> redirections, though).  Do we want to resurrect the topic?  It needs
> a paragraph in the proposed commit log and t/README to explain the
> motivation and the usage.

Yes, this is on my TODO list.

I will name the function 'test_setup' rather than 'test_fixture'.

Also, the test_fixture function had a single script parameter, since
I didn't see the point of having a "title" like test_expect_success.
However, I'm now in two minds about this; if it were to take a title
it may be useful to include the title in the error message, if the
test contained multiple calls to test_setup. I'm still inclined to
*not* include a title parameter ...

ATB,
Ramsay Jones
