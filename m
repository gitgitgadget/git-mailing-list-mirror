From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFD/BUG?] git show with tree/commit
Date: Wed, 13 Apr 2016 11:41:00 +0200
Message-ID: <570E142C.8050200@drmicha.warpmail.net>
References: <570D154D.6090006@drmicha.warpmail.net>
 <xmqq4mb6sshz.fsf@gitster.mtv.corp.google.com>
 <570DFD29.9090100@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 11:41:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqHIX-0006n6-UW
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 11:41:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966097AbcDMJlI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2016 05:41:08 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:39608 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965886AbcDMJlE (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Apr 2016 05:41:04 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id A573B20AA0
	for <git@vger.kernel.org>; Wed, 13 Apr 2016 05:41:02 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute5.internal (MEProxy); Wed, 13 Apr 2016 05:41:02 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=IYR5hBkpkFxCf8285tkjUksnG5A=; b=V5qta8
	O6RY8g/83uxJD3J+gj9Zfbjk1O9di1cpqNBYZEMynVNN9B/YgffYhwzyq9HIs2T5
	E7zvKmSf+kzG9KcIjRIF4c7XHQiSHsTF63nX1ewiRG9WPZFbBXf4qQ0nvkRdxtkl
	yzz9G+HRmHtx1ysvSSHmr5LmIZ/8wuUoIr7Rg=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=IYR5hBkpkFxCf82
	85tkjUksnG5A=; b=hS1MYY656jV/qZZ6ifBf43YKOo4Oh62U4hQaNnc+QEB3NrC
	ZldxwlxA2Z8CE4TT39QBAKKzxUrMtgwhp38i9vu+fyGVAyvP9lItHQsppFgJIETy
	lKb4Cuu3BXcUUzm76L8rrujskdsAEh3xyqwzI/sf3s6rZBiapsM8UmKOu5jk=
X-Sasl-enc: D/1BcxVnsLeF529Qfc+zCRYS5faQEEPUkBllfbwlE/91 1460540462
Received: from skimbleshanks.math.uni-hannover.de (skimbleshanks.math.uni-hannover.de [130.75.46.4])
	by mail.messagingengine.com (Postfix) with ESMTPA id EF3AC680184;
	Wed, 13 Apr 2016 05:41:01 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.1
In-Reply-To: <570DFD29.9090100@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291384>

Michael J Gruber venit, vidit, dixit 13.04.2016 10:02:
> Junio C Hamano venit, vidit, dixit 12.04.2016 18:26:
>> Michael J Gruber <git@drmicha.warpmail.net> writes:
>>
>>> $ git show cab2cdadfda8e8e8631026443b11d3ed6e7ba517:
>>> tree cab2cdadfda8e8e8631026443b11d3ed6e7ba517:
>>>
>>> .gitattributes
>>> .gitignore
>>> .mailmap
>>> ...
>>>
>>> While it's clear to me what's going on, I'm wondering whether it's a
>>> good idea that "git show" says "tree" in front of the unresolved
>>> treeish, whether it's a tree, a commit or something else. I think it's
>>> pretty confusing.
>>
>> There is no "unresolved treeish" on the line that begins with
>> "tree", but I suspect it wasn't very clear to you because of the way
>> you gave the command its input; notice the line in question ends
>> with a colon, which is unfortunate, but it turns out that it is your
>> fault ;-).  Read on.
> 
> Guess what, I know the difference between "git show <commit>" and git
> show <commit>:"...
> 
>>> Alternatives would be:
>>>
>>> tree <resolved tree id> # here: 040...
>>> treeish <treeish>	# here: "treeish cab2c..."
>>> tree <treeish>^{tree} 	# here: "tree cab2c^{tree}"
>>
>> So, the three choices are
>>
>>  (1) resolve the tree object name to 40-hex and show it as
>>      "tree <object name in hex>"
>>
>>  (2) given an object that is not a tree, show it as "treeish <object
>>      name>" 
>>
>>  (3) do not do anything fancy, just show it as "tree <object name>"
>>      using what the user gave us.
> 
> (3) ist not quite what I'm after, but I guess when "git show" receives
> "<commit>:" there is no way it could trace back that tree reference to
> the commit. In fact, (3) is what we have now.
> 
>> I think the current output is doing the third one (notice the colon
>> at the end of the line).
>>
>>     $ git show master: | head -n 1
>>     $ git show master^{tree} | head -n 1
>>     $ git show cab2cdadf: | head -n 1
>>
> 
> I confess that I failed to copy the trailing ":" from the original
> output... So that one is my fault.
> 
> In fact, while specifying "<commit>:" knowingly to show the tree, I
> interpreted the ":" in the output as a simple colon introducing the
> following output, at least at first glance.
> 
> I guess (1) would be the only option that would help (because
> "<commit>:" is a tree, not a non-tree treeish).
> 
> Michael

... adding to that, "git show foo" shows

"commit <sha1 of foo>" for a commit object
"tree <verbatim foo>" for a tree object

nothing like that for tag objects and blobs (just the object contents)

So for 2 out of the 4 object types, it shows a "header line", and both
of them show the specified argument differently (resolved to sha1 resp.
verbatim). It's that inconsistency that I find confusing.

Michael
