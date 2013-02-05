From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 11/13] contrib/subtree: Make each test self-contained
Date: Tue, 05 Feb 2013 07:18:41 -0800
Message-ID: <7v4nhqwzzi.fsf@alter.siamese.dyndns.org>
References: <1360037173-23291-1-git-send-email-greened@obbligato.org>
 <1360037173-23291-12-git-send-email-greened@obbligato.org>
 <7vwqunwdfk.fsf@alter.siamese.dyndns.org>
 <87d2wfrnbe.fsf@waller.obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: James Nylen <jnylen@gmail.com>, git@vger.kernel.org,
	Techlive Zheng <techlivezheng@gmail.com>,
	Wayne Walter <wayne@tickzoom.com>,
	"Avery Pennarun" <apenwarr@gmail.com>,
	Jakub Suder <jakub.suder@gmail.com>,
	John Yani <vanuan@gmail.com>,
	"David A. Greene" <greened@obbligato.org>
To: greened@obbligato.org
X-From: git-owner@vger.kernel.org Tue Feb 05 16:19:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2kIe-0002oV-DN
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 16:19:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755116Ab3BEPSq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2013 10:18:46 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34284 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754777Ab3BEPSp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2013 10:18:45 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6B41FC6EF;
	Tue,  5 Feb 2013 10:18:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ggt0qkxSYJ/+9o5jhysZXlpJyh8=; b=mzDRCg
	t/74A7q95nUSruhk9VTBGguRIEx7gC1wpcKeXJW5w0YshWadLSCIkkfCNDPdef1/
	x7dAJwivIPuYKUJFLeplAlOBe33CzilYaIu6/TI2xv5SeA0StBwmsS79u5F1qP/Y
	8gYNtnsjKa8fsgYr1vaJEoTDJTVz83DyXyILk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Eo3IkK3CN5mtz272AW3YXTIIqwGHcU1Y
	qqZ/pUWDxOO8uSHl5V+miEvuhc4rWlUsK7jTLVoAmAo1RqJ7dvwxjiEyKlxZdBdI
	sUbiXCvcOb/mHnWrK8zyJEPuUIbrDSWSd8duVzNLIRQ1qqFRwob/tt8/d2DpXDQ8
	r+kx7uxL+hc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 55F7AC6EE;
	Tue,  5 Feb 2013 10:18:44 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C59B4C6EC; Tue,  5 Feb 2013
 10:18:43 -0500 (EST)
In-Reply-To: <87d2wfrnbe.fsf@waller.obbligato.org> (greened@obbligato.org's
 message of "Tue, 05 Feb 2013 05:51:17 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 54432EE4-6FA7-11E2-9385-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215504>

greened@obbligato.org writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> "David A. Greene" <greened@obbligato.org> writes:
>>
>>> +test_create_commit() (
>>> +	repo=$1
>>> +	commit=$2
>>> +	cd "$repo"
>>> +	mkdir -p "$(dirname "$commit")"
>>> +	echo "$commit" > "$commit"
>>
>> Style.
>
> I need a little more explanation.  :)  Is there a style guide somewhere?

Documentation/CodingGuidelines?

>
>>> +	git add "$commit"
>>> +	git commit -m "$commit"
>>> +)
>>
>> Very nice, but don't we want to check for possible errors in any of
>> the above commands?
>
> I'll fix that.  :)
> ...
> Ok.  I'll rework this.

Thanks.

I also think it would be a good idea for you to learn to push back
to the original authors; fixing problems in patches by others, while
is a good way to learn how their thinking process went, is not
necessarily fun.
