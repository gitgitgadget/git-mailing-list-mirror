From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Aug 2013, #03; Tue, 13)
Date: Wed, 14 Aug 2013 09:56:57 -0700
Message-ID: <7vpptgtdly.fsf@alter.siamese.dyndns.org>
References: <7vvc39utxi.fsf@alter.siamese.dyndns.org>
	<520B27F3.3010508@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Aug 14 18:57:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9eNj-0003Ct-5Y
	for gcvg-git-2@plane.gmane.org; Wed, 14 Aug 2013 18:57:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932895Ab3HNQ5G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Aug 2013 12:57:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40382 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932867Ab3HNQ5E (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Aug 2013 12:57:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ADBB3363C6;
	Wed, 14 Aug 2013 16:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/yS4R+wBhQ48YXnxOMFD+fxvFfU=; b=xV0oVL
	AehZjs5mLfRGMRMCCxDhzm5e4T0m75AfcuAcGpG4ImdzaKT2rWqSgc+zpVLW17xF
	/wwRcUghcq4wDjM2KC5gZ15Zp14zJ6M9FlZDM9ruK+IG0MytqwmrRudeHYGdggug
	XbyZgPW+tXxpNVXRuC1JS+dXauNhMOjFIBNog=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hgC2fw/eUR5izBC5IrT680cJN7Xd+Uvl
	uCIuWCyBxQd6Sa7SUyULOwLehsjTN4RLCQxjf4JotNvU3elj+bI/TMoxtV/T0/AX
	oVw0oPoRaxdejwLMCD483lSEwW6g8/0FcIxo618Pu8sPcpikCIca9tT+EilI5PfP
	iGWuU5MqwuE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9B6A0363C5;
	Wed, 14 Aug 2013 16:57:02 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1E83B363B7;
	Wed, 14 Aug 2013 16:57:00 +0000 (UTC)
In-Reply-To: <520B27F3.3010508@googlemail.com> (Stefan Beller's message of
	"Wed, 14 Aug 2013 08:47:15 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 89428A72-0502-11E3-8CEB-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232296>

Stefan Beller <stefanbeller@googlemail.com> writes:

> On 08/14/2013 12:06 AM, Junio C Hamano wrote:
>> * sb/parseopt-boolean-removal (2013-08-07) 9 commits
>>   (merged to 'next' on 2013-08-08 at b138a2d)
>>  + revert: use the OPT_CMDMODE for parsing, reducing code
>>  + checkout-index: fix negations of even numbers of -n
>>  + config parsing options: allow one flag multiple times
>>  + hash-object: replace stdin parsing OPT_BOOLEAN by OPT_COUNTUP
>>  + branch, commit, name-rev: ease up boolean conditions
>>  + checkout: remove superfluous local variable
>>  + log, format-patch: parsing uses OPT__QUIET
>>  + Replace deprecated OPT_BOOLEAN by OPT_BOOL
>>  + Remove deprecated OPTION_BOOLEAN for parsing arguments
>>  (this branch uses jc/parseopt-command-modes.)
>> 
>>  Convert most uses of OPT_BOOLEAN/OPTION_BOOLEAN that can use
>>  OPT_BOOL/OPTION_BOOLEAN which have much saner semantics, and turn
>>  remaining ones into OPT_SET_INT, OPT_COUNTUP, etc. as necessary;
>>  there seems to be some misconversion that makes many tests fail,
>>  though.
>> 
>>  Will cook in 'next'.
>
> Locally here all tests succeed, when testing that branch alone.
> Which tests fail for you, so I can look into it?

It was a stale comment from the previous round.  Thanks for
noticing.

>> * sb/fsck-opt-bool (2013-07-29) 1 commit
>>  (merged to 'next' on 2013-07-30 at 8a9964c)
>> + fsck: Replace deprecated OPT_BOOLEAN by OPT_BOOL
>>
>> Will cook in 'next'.
>
> This one is completely included in sb/parseopt-boolean-removal,
> but doesn't need jc/parseopt-command-modes. So once we're
> confident with jc/parseopt-command-modes, we could drop this
> branch as well.

Thanks again.
