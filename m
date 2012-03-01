From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] t5510: ensure we stay in the toplevel test dir
Date: Thu, 01 Mar 2012 14:32:46 -0800
Message-ID: <7vaa40kl4h.fsf@alter.siamese.dyndns.org>
References: <cover.1330637923.git.trast@student.ethz.ch>
 <80204781996b200d08b73cf61fa50df468e4b51d.1330637923.git.trast@student.ethz.ch> <7vipiokmrz.fsf@alter.siamese.dyndns.org> <871upcht2h.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Mar 01 23:32:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3EYR-0006bk-KJ
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 23:32:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758114Ab2CAWcu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Mar 2012 17:32:50 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52322 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755999Ab2CAWct (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2012 17:32:49 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 96C0D6993;
	Thu,  1 Mar 2012 17:32:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=b1ZE8IYibdMlSAEIsaUN3tHAOXI=; b=ZzN/NZ
	zByjGOZ2zzvZySoCTlrj6FA+Hecz5QpUnK+8LohdD525vwGMdVT+gornqFU8GdV4
	PTnsxQl0rUCWCeHB9TMx/tHIlhgLRGOlUxcGWkjLR+D07Ho+gdrm3l7p2fTTnaGh
	8XqDBb7QxCpMMEfsfqlBSofZMlBnpC+yu4Oyw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nBrb+CKYfoDkKCxJw7wdwTuDczX+9wdI
	m27z6rSyARJq88HIKyIcnmqDdNdXxYeuEX9Vv8EF8evUZ4VHrtSeOLJu7+EO5bCy
	13xowZtTZcyD2raaWogdKG24J4VecMe5CsQ3v6+BJLLQdxhThyor7Vb0ynhlU16Z
	XWeI24hB1Pk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8CBC46992;
	Thu,  1 Mar 2012 17:32:48 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 215906990; Thu,  1 Mar 2012
 17:32:48 -0500 (EST)
In-Reply-To: <871upcht2h.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
 "Thu, 1 Mar 2012 23:09:26 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7903A35A-63EE-11E1-9FC3-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191984>

Thomas Rast <trast@inf.ethz.ch> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Thomas Rast <trast@student.ethz.ch> writes:
>>
>>> The last test descended into a subdir without ever re-emerging, which
>>> is not so nice to the next test writer.
>>
>> True.  Making the test suite more robust like this patch does is very much
>> appreciated.
>>
>> Is there a reason why we shouldn't be sticking to the more usual
>>
>> 	mkdir dups &&
>>         (
>>         	cd dups &&
>>                 do whatever in dups
>> 	)
>>
>> pattern?
>
> None in particular.  It would also perhaps reduce the churn since (as it
> touches every line anyway) it could be squashed with 2/4.  Should I reroll?

No. I was just curious.
