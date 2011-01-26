From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Updating a submodule with a compatible version from another submodule
 version using the parent meta-repository
Date: Wed, 26 Jan 2011 20:39:33 +0100
Message-ID: <4D407875.7080607@web.de>
References: <AANLkTinN1XVsAZXGLqkuhysrJ8-TCtGm4pOu2RfCEVVp@mail.gmail.com>	<AANLkTimvNaiieEw8-Y52xxDW6DQ6b16v9azCk+BDPxhe@mail.gmail.com>	<4D407099.4010805@web.de> <AANLkTinMhvBNrBMJ8vQpJdYxP_NgJU2L7JEW0KhXGjhf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Julian Ibarz <julian.ibarz@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 26 20:41:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PiBEt-0003ea-95
	for gcvg-git-2@lo.gmane.org; Wed, 26 Jan 2011 20:41:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753674Ab1AZTlF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Jan 2011 14:41:05 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:47551 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753531Ab1AZTlE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jan 2011 14:41:04 -0500
Received: from smtp03.web.de  ( [172.20.0.65])
	by fmmailgate01.web.de (Postfix) with ESMTP id E3658185B0230;
	Wed, 26 Jan 2011 20:39:33 +0100 (CET)
Received: from [93.246.34.225] (helo=[192.168.178.43])
	by smtp03.web.de with asmtp (WEB.DE 4.110 #2)
	id 1PiBDJ-0003VX-00; Wed, 26 Jan 2011 20:39:33 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <AANLkTinMhvBNrBMJ8vQpJdYxP_NgJU2L7JEW0KhXGjhf@mail.gmail.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1+WYiVuLjWuym2WxnU4bk9XQdSYc3VxzILCBm2I
	WmM/eJl6uTefYCsBKHYBS0fIdWeUwlS+f3wwKH/UTl/0VkX/dW
	L0hlT700i17D1AIrXviQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165533>

Am 26.01.2011 20:10, schrieb Julian Ibarz:
> On Wed, Jan 26, 2011 at 2:06 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>> Am 26.01.2011 19:32, schrieb Julian Ibarz:
>>> I am using git submodule in one of my professional projects and I am
>>> facing an issue when I am using git bisect in one of the submodules.
>>>
>>> Basically I have a meta repository which I will call A and two
>>> submodules B and C. Sometimes I use git bisect in B but it is
>>> dependent on C so when I go back too much in the history of B, C needs
>>> to change its version to a compatible one. Doing this manually is
>>> really time consuming for me and I guess a lot of people have this
>>> issue so I was a little bit surprise to not find easily anything on
>>> the net that permits to do this automatically.
>>
>> What about bisecting in A (doing "git submodule update" after every
>> step) to bisect to a smaller range of commits in B (which are then
>> not dependent on your submodule C anymore and can be bisected inside
>> B)? This of course assumes A properly records the dependencies
>> between B and C.
> 
> Yes but actually my real use case that made me write this mail was
> more I have a feature done in an old branch and to try it I never to
> revert back to this version. In this case, I have to find out the
> corresponding good version in A and C. In this case I cannot start
> like what you propose in A to find out the good version in B and C, I
> already know the version I want in B.

Hmm, looks like I lost you here ... you want to bisect in B although
you know what commit you want there? Care to explain a bit more?

>>> Is there anything existing to do that and I just didn't find it yet?
>>> If not I think I might have an implementation idea I would like to try
>>> out.
>>
>> The call to "git submodule update" after each bisect step in the
>> superproject will be obsolete as soon as the recursive checkout
>> I am currently working on is done, but that is not here yet.
> 
> Can you be more detailed about your recursive checkout feature? Is it
> what I proposed?

I don't think so, that will just get rid of the extra call to "git
submodule update" when bisecting in A.
