From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [ANNOUNCE] Git v2.8.0-rc2
Date: Thu, 17 Mar 2016 15:51:43 +0100
Message-ID: <56EAC47F.6000708@drmicha.warpmail.net>
References: <xmqqr3fiaq9f.fsf@gitster.mtv.corp.google.com>
 <56E6D8C4.2010205@drmicha.warpmail.net>
 <xmqqoaahaw99.fsf@gitster.mtv.corp.google.com>
 <xmqqziu19cjz.fsf@gitster.mtv.corp.google.com>
 <56E96096.4020108@drmicha.warpmail.net>
 <CACsJy8CyLGtYpPnwdhS-AD4d2pcU7RVv=OxPEePcHYhFpDh4pg@mail.gmail.com>
 <56E97CA8.8070400@drmicha.warpmail.net>
 <xmqqmvpy5qru.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 15:51:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agZHH-0003zZ-0u
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 15:51:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030468AbcCQOvr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2016 10:51:47 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:35910 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030338AbcCQOvq (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Mar 2016 10:51:46 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 20E5F2068E
	for <git@vger.kernel.org>; Thu, 17 Mar 2016 10:51:45 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute3.internal (MEProxy); Thu, 17 Mar 2016 10:51:45 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=8oHL29qi4e4kE8pyq8GkBmunPwU=; b=E9eLEU
	rzWcwXJ5TrOXTcFc/7LVHI3mzLVu/APB5u8R0n1aNMAdFGQ1hqrFAcdqVPsONzzP
	npKUHChIAu/8Am1qOlb3sFVdDvaTWqcJNbRphCfvNq4cb+9nw1kJNRoz08xmt3aA
	dSyJw1+5ru/Rv9vF450egSjYxsSx2XrfG6Ei0=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=8oHL29qi4e4kE8p
	yq8GkBmunPwU=; b=hsgMfYhHuJ2bbyQkMTajpL/1/eA1g0tdF/yA0M+p/hfES3/
	rSt/+kHXs4dx12N+sGMg+IFvNqs8dAVBKORsL/9S/Gp7HhcCIo4VXc0CLWGgUa47
	p18Mz0WultAqKnJdj7GjJTUbOb8H4rELR31FuGSxyZ4O2+3huxeJB0yxJMGA=
X-Sasl-enc: cxrKMu3MllzN0LmR/ncrub4wzSnAFQGR3UAJt+vm3IXf 1458226304
Received: from skimbleshanks.math.uni-hannover.de (skimbleshanks.math.uni-hannover.de [130.75.46.4])
	by mail.messagingengine.com (Postfix) with ESMTPA id 6600F6801A4;
	Thu, 17 Mar 2016 10:51:44 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <xmqqmvpy5qru.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289118>

Junio C Hamano venit, vidit, dixit 16.03.2016 17:30:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> echo '*.po diff=po' >>.gitattributes
>> echo '*.pot diff=po' >>.gitattributes
>> git config diff.po.textconv "msgcat --indent --no-location"
>>
>> With or without the indent, that gives a pretty clean diff. [It's
>> unfortunate that one half of that config is in-tree, one-half is not.]
> 
> That's a good tip. [By the way, it is not unfortunate that these are
> separated to two places, but quite the opposite.  Attributes define
> "what kind of things" they are, and configuration defines "how" each
> kind of things are handled.  "msgcat" may have to be invoked
> differently from yours on other people's systems, and one level of
> indirection is a reasonable way to allow customizing "how" part
> without forcing people to rewrite all of THIS in "for *.po do THIS,
> for *.pot do THIS too".  You should be thankful for this separation.]

I know why we have that. It's just unfortunate that we can't even
provide a default textconfig config easily - I know very well we can't
have that securely.

"Unfortunate" is meant in this context in the sense: I want to make it
easy and convenient for non-l10n-people to watch out for l10-affecting
changes.

>> So, really, the "actual coders" know best whether their changes should
>> affect l10n or not, so they should be made more aware of it. Forcing
>> "make pot" (and maybe more) on everyone sounds a bit harsh, but what
>> else can we do?
> 
> I am not sure what problem you are trying to solve.  Do you want to
> make sure mismarking such as N_(("foo")) is caught by the person who
> changes "foo" into N_(("foo"))?

Yes. That and similar ones.

> "make pot" alone would obviously not help, and you would definitely
> need "maybe more" but I'd imagine that would involve checking the
> diff in the code part i.e. "we have a new N_(...)" against the
> differences in git.pot files you would obtain by running "make pot"
> before the code change and after the code change, i.e. "there is no
> new mention of "foo"".
> 
> I do not think you are suggesting to commit the result of "make pot"
> along with code changes, but if you are, please don't ;-)

As I said: I assume there's a good reason we don't do that, and that's
why I'm not suggesting it.

On the other hand, it means that the in-tree git.pot does not correlate
with the in-tree source code at all, which feels really weird[*]. And it
makes it difficult to check the impact of your code changes: You can't
simply run "make pot" and check the diff - because the in-tree git.pot
does not reflect the state before your changes at all.

[*] It just feels wrong to me that a "make pot" in a clean checkout
leads to dirty index.

So, in short, I do believe there is a good reason for the "out of sync"
git.pot. That doesn't make the negative side effect that I describe any
less true, and I'm looking for ways to ammeliorate that. Something as
easy as "make check" or "make test-lint".

Michael
