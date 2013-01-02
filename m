From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/8] Use %B for Split Subject/Body
Date: Tue, 01 Jan 2013 16:30:52 -0800
Message-ID: <7vehi477er.fsf@alter.siamese.dyndns.org>
References: <1357012655-24974-1-git-send-email-greened@obbligato.org>
 <1357012655-24974-2-git-send-email-greened@obbligato.org>
 <7va9ssa94l.fsf@alter.siamese.dyndns.org>
 <87wqvwfsfm.fsf@waller.obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Techlive Zheng <techlivezheng@gmail.com>
To: greened@obbligato.org
X-From: git-owner@vger.kernel.org Wed Jan 02 01:31:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqCEt-0007Jd-Qi
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jan 2013 01:31:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752382Ab3ABAa5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jan 2013 19:30:57 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55452 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751976Ab3ABAaz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jan 2013 19:30:55 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1EF39B2C6;
	Tue,  1 Jan 2013 19:30:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=urqvXTO+6MrZ4o22MH2VwIgDPro=; b=ycbSqu
	oH+hpWqP9TpY7uIqU7JGpGf6hHL1auIngOoE220Qso3VmL/Ga6GlNkGkr/4KcVVa
	MlW8d7vIHVvDuPFQiwmIRtDthnWnsr6eQoK4YLY0adT5Y5vFYuwPIN2BNuN8Obs3
	yV4B6yYqmB9rgjYKL6ajAnGDaBKS8yC3oWx8w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Yh/tgWkKSgPxVwVqb6ScJITJ+FIuHWPU
	DBoeusftf2ZBA0JN9uzRkuVsEPaajnezpl8fMzfn8Ya5rowMQANkgvr2juKs378z
	EsZHYPYndLf98JeF8ipj7tPUBQlV0XkNjCxdMIYGPWN2mv71oNsKFQkqu4QJJ664
	kyIGEIl/jIs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E902B2C5;
	Tue,  1 Jan 2013 19:30:55 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 64C6AB2C1; Tue,  1 Jan 2013
 19:30:54 -0500 (EST)
In-Reply-To: <87wqvwfsfm.fsf@waller.obbligato.org> (greened@obbligato.org's
 message of "Tue, 01 Jan 2013 16:29:33 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AB2AB1B8-5473-11E2-A351-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212476>

greened@obbligato.org writes:

> Ack, of course.  I don't know how I missed that.
>
>>>  # 15
>>>  test_expect_success 'add main6' '
>>>          create main6 &&
>>
>> Why?
>
> It was in the original testsuite from Avery.  I didn't add or remove any
> tests when I first integrated git-subtree.

The question was about the lossage of the blank line, which does not
seem to be related to what this patch wants to do.

>>> -# 25
>>> +#25
>>
>> Why the lossage of a SP?
>
> I think this got fixed later in the series.

That is not a good excuse to introduce breakages in the first place, no?

>> It may make sense to lose these "# num" that will have to be touched
>> every time somebody inserts new test pieces in the middle, as a
>> preparatory step before any of these patches, by the way.  That will
>> reduce noise in the patches for real changes.
>
> Yeah, I know, but it makes it really easy to find a test when something
> goes wrong.

That is what "tXXXX-*.sh -i" is for, isn't it?
