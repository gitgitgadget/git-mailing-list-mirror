From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] log: decorate detached HEAD differently
Date: Tue, 10 Mar 2015 11:34:56 +0100
Message-ID: <54FEC8D0.2060304@drmicha.warpmail.net>
References: <CAPc5daWz-Xa7q6f9RzgTP4has8DcCG4QgK7SMGNbH6KGnEyr2Q@mail.gmail.com>	<015d6992d2c2165045117f763d9ce3131979c2db.1425658434.git.git@drmicha.warpmail.net>	<xmqq61aeymlv.fsf@gitster.dls.corp.google.com>	<54FD64D1.6080103@drmicha.warpmail.net> <xmqqh9tt623d.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Julien Cretel <j.cretel@umail.ucc.ie>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 10 11:35:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVHVC-0001LY-RD
	for gcvg-git-2@plane.gmane.org; Tue, 10 Mar 2015 11:35:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752242AbbCJKfA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2015 06:35:00 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:40379 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751666AbbCJKe7 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Mar 2015 06:34:59 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id F00A6210E6
	for <git@vger.kernel.org>; Tue, 10 Mar 2015 06:34:56 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute3.internal (MEProxy); Tue, 10 Mar 2015 06:34:58 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:cc:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=LgrS9dMzi+stM19OTengKY
	iguaI=; b=jSRxVQHR1mR3VQFrbVX5Z8dTS6Y86E3kR1aInriPmfYVwwECwPZPTy
	gWJv0wRzpZqXKTSlSMOdkiksj/rrFvO6yRoWQmo+lNw6nXQ8F4hJahsZSJb9+hxv
	LHRbSGMYbzXYnN3M6bVKImf4IcfaUGCKOzQsRfRWth42BOSEyiGrw=
X-Sasl-enc: +wkPOxe/spEo8j0AFdM7+yVrqjouNVbsAu5OdxfAkBxq 1425983698
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id CC5856800AA;
	Tue, 10 Mar 2015 06:34:57 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <xmqqh9tt623d.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265224>

Junio C Hamano venit, vidit, dixit 10.03.2015 03:03:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> Junio C Hamano venit, vidit, dixit 06.03.2015 20:03:
>>> Michael J Gruber <git@drmicha.warpmail.net> writes:
>>>>     
>>>>     Note that now a checked branch is listed twice, once as target of the
>>>>     HEAD, once as branch: They are two different refs and colored differently.
>>>
>>> The pointee of HEAD would always be branch and will always appear on
>>> the output when you show HEAD->$name_of_that_branch; is it feasible
>>> to drop the duplicate, I wonder?
>>
>> It's doable but not nice, because we cannot take the order in which refs
>> are processed for granted.
> 
> That is true, but when we format them into a single line in the
> header in response to --decorate (or %d), don't we have all of them
> already at hand---does the order still matter?
> 
> Here is an illustration of what I had in mind, made on a random
> commit I happened to have checked out that does not have your
> patches on this topic.  Half of the change is a new helper function,
> and the other half is mostly reindenting.

Yes, the patch illustrates pretty well what I meant by "doable but not
nice" :)

But I also said:

> Also, HEAD and foo are two different refs, so even if HEAD has the value
> "foo", I think we should really show them both anyways.
> 
> Alternatively, we could decorate by (HEAD, *foo, master, tag: release)
> if foo is checked out, just like branch does.

I guess I will have to apply your patch and feel what it's like in
practical use in order to change my mind...

Michael
