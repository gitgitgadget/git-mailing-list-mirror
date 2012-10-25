From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Is git mktag supposed to accept git cat-file input?
Date: Thu, 25 Oct 2012 10:34:51 +0200
Message-ID: <5088F9AB.8090203@drmicha.warpmail.net>
References: <CAM1C4GneOnyBQyJRbhtuYNDsc4NxXgFcfHrQpziLpp_AY0TjbA@mail.gmail.com> <CA+sFfMdaaTwc82-J6a=wdjDzAFq6z8PS2rjSZ=tuyweOzuf4Kg@mail.gmail.com> <CAM1C4Gn6tr_bxG1De+kZecpJ7kLg7_hOO7q-aa7HwFkr9od6_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Brandon Casey <drafnel@gmail.com>, git@vger.kernel.org
To: Anand Kumria <akumria@acm.org>
X-From: git-owner@vger.kernel.org Thu Oct 25 10:35:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRIuh-0004gm-0B
	for gcvg-git-2@plane.gmane.org; Thu, 25 Oct 2012 10:35:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933419Ab2JYIfX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2012 04:35:23 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:34008 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933688Ab2JYIey (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Oct 2012 04:34:54 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 498312080A;
	Thu, 25 Oct 2012 04:34:53 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute3.internal (MEProxy); Thu, 25 Oct 2012 04:34:53 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=cq8ymCrolYKL8cNzrXdxOH
	R+5wo=; b=WvdwWd+pq8q2G/4Ed9X/0D/3R93mkfebYHp2Sxayg7OaOg5y/wnSVi
	5pFUtNjK4GvIv8LEdkNdDXz3C9ZXvtIkZw8UoocUy3+osizFGTRuIfRfywVEADc9
	Li7phZNfZ2NhLOyQnIR0q43n3FgzQ2f2mEHdnr71Fqvv46OMMjVA8=
X-Sasl-enc: x39uhZcTEhStBAf98kqOyTmNU1IVCi7i79yeo7EG4pWH 1351154093
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id ACDFE4825C2;
	Thu, 25 Oct 2012 04:34:52 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121011 Thunderbird/16.0.1
In-Reply-To: <CAM1C4Gn6tr_bxG1De+kZecpJ7kLg7_hOO7q-aa7HwFkr9od6_Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208364>

Anand Kumria venit, vidit, dixit 25.10.2012 02:58:
> Ahh, unix time. Of course.

That's the only difference *at the time being*, but this is not
guaranteed. Really, as Brandon says: "cat-file -p" is pretty printing
for human readability (which could be improved), and "cat-file <type>"
is the raw format which is the content being hashed to the sha1.

> 
> Thanks Brandon.
> 
> On 25 October 2012 01:18, Brandon Casey <drafnel@gmail.com> wrote:
>> On Wed, Oct 24, 2012 at 4:39 PM, Anand Kumria <akumria@acm.org> wrote:
>>> Hi,
>>>
>>> I am doing some experimenting with git-mktag, and was looking into the
>>> format it expects on input.
>>>
>>> Should this sequence of commands work?
>>
>> Yes, with a slight tweak...
>>
>>> kalki:[/tmp/gittest]% git tag -m "tag-test" tag-test
>>> kalki:[/tmp/gittest]% git cat-file -p e619
>>
>> '-p' means pretty-print, i.e. produce a human-readable format.  mktag
>> supports the raw format.  So you should invoke it like this:
>>
>>       $ git cat-file tag e619
>>
>> which should produce something like:
>>
>>    object c0ae36fee730f7034b1f76c1490fe6f46f7ecad5
>>    type commit
>>    tag tag-test
>>    tagger Anand Kumria <akumria@acm.org> 1351121552 +0100
>>
>>    tag-test
>>
>> and is the format expected by mktag.
>>
>> -Brandon
>>
> 
> 
> 
