From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] tag: --force is quiet about new tags
Date: Wed, 13 Mar 2013 10:16:52 +0100
Message-ID: <51404404.4030005@drmicha.warpmail.net>
References: <1363130021-28624-1-git-send-email-hordp@cisco.com> <7vy5ds3re0.fsf@alter.siamese.dyndns.org> <CABURp0oT8ZN5fKtKh67Gm1P5rf_a3diqcYbw8mUga-gv5MPu6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Phil Hord <hordp@cisco.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 13 10:17:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFhoE-0005YO-4Y
	for gcvg-git-2@plane.gmane.org; Wed, 13 Mar 2013 10:17:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754870Ab3CMJQv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Mar 2013 05:16:51 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:59333 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754474Ab3CMJQu (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Mar 2013 05:16:50 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id C185720B85;
	Wed, 13 Mar 2013 05:16:49 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute6.internal (MEProxy); Wed, 13 Mar 2013 05:16:49 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=/7RQ3+H+Xik854KuR+rR44
	LUHlI=; b=l5GIrw3sovAimtaunnlQYow/GQ1H0DuEmN2JiCEKBbqvKJF21ZISFz
	QQIo5k/7dFdPRKB7qX+dOknzDs6cNot1SPceJLJGhGdsPfwAumIA9TLtTUgkGI6d
	oruv1KRnOjy8n4xZl+KzAB/XbRPoWONdeiI5vVBndCqCuqfEFG8ME=
X-Sasl-enc: 7NGUhdBha1qztvxtx1aQ6dr83A5W/mHC2kUgtn5b7KPn 1363166209
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 07494C80E8C;
	Wed, 13 Mar 2013 05:16:48 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130219 Thunderbird/17.0.3
In-Reply-To: <CABURp0oT8ZN5fKtKh67Gm1P5rf_a3diqcYbw8mUga-gv5MPu6Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218045>

Phil Hord venit, vidit, dixit 13.03.2013 05:21:
> On Tue, Mar 12, 2013 at 11:33 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Phil Hord <hordp@cisco.com> writes:
>>
>>> git tag --force is used to replace an existing tag with
>>> a new reference.  Git helpfully tells the user the old
>>> ref when this happens.  But if the tag name is new and does
>>> not exist, git tells the user the old ref anyway (000000).
>>>
>>> Teach git to ignore --force if the tag is new.  Add a test
>>> for this and also to ensure --force can replace tags at all.
>>>
>>> Signed-off-by: Phil Hord <hordp@cisco.com>
>>> ---
>>
>> I think we would still want to allow the operation to go through,
>> even when the --force option is given, to create a new tag.  I agree
>> that the message should not say "Updated".  So teaching Git not to
>> issue the "Updated" message makes perfect sense.  It is somewhat
>> misleading to say we are teaching Git to ignore the option, though.
>>
>> Thanks.
> 
> My phrasing was too ambiguous.  What you described is exactly what the
> patch does.  --force is superfluous when the tag does not already
> exist.  It is only checked in two places, and one of those is to
> decide whether to print the "Updated" message.  How's this?
> 
>    Teach 'git tag --force' to suppress the update message if
>    the tag is new.  Add a test for this and also to ensure
>    --force can replace tags at all.
> 
> Phil

Looks good to me, both the patch and the (updated) commit message.

Michael
