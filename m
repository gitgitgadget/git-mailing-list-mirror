From: Junio C Hamano <gitster@pobox.com>
Subject: Re: format-patch on permission change gives empty patch
Date: Thu, 07 Oct 2010 13:29:29 -0700
Message-ID: <7vmxqpwxue.fsf@alter.siamese.dyndns.org>
References: <20101006.173714.245380201.davem@davemloft.net>
 <20101006.174008.70175671.davem@davemloft.net>
 <7vtykyy70w.fsf@alter.siamese.dyndns.org>
 <7vocb6y5sq.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1010071503210.3107@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Miller <davem@davemloft.net>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Thu Oct 07 22:29:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3x64-0005t6-VO
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 22:29:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755333Ab0JGU3k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Oct 2010 16:29:40 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:55240 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751822Ab0JGU3k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Oct 2010 16:29:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 44A26DBE54;
	Thu,  7 Oct 2010 16:29:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VK2T849sWGho0lL0YwqN5sqMcZI=; b=Y10SBT
	aSuuyeZzE0cSFC2xBPE6YtYIXQpdwU9AZZjpfO4HB12mNk9mNZQ3IvOipnUUBizf
	YGN7XfNaQPqoHb5Rp4EUDCQCyY7FXXODGtvZHAZjN/YJABOkXaTbSTtnDL/TUdFq
	44dOOOLvEowGNgi7pPane/5UpAgmBHMEYtyEA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BvyoIGUbGX+Jn1BBMsSgve2B7EDo3v1H
	7cghSX+t7EF2e1I4TIOihnoILnrtJrEIJT+BpA+hj6+HHH2MV+Ot62oPRkqq+RAL
	O0tF/xGhftv98CVxocGq20IFXtx2EpdEXQLGrF9Ry+kDN3EsfqUWxcDtu3hfpsOR
	d13qVQFCApY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 84D77DBE52;
	Thu,  7 Oct 2010 16:29:34 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C89A7DBE4E; Thu,  7 Oct
 2010 16:29:30 -0400 (EDT)
In-Reply-To: <alpine.LFD.2.00.1010071503210.3107@xanadu.home> (Nicolas
 Pitre's message of "Thu\, 07 Oct 2010 15\:06\:05 -0400 \(EDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 98F9C48A-D251-11DF-9B3E-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158453>

Nicolas Pitre <nico@fluxnic.net> writes:

> On Wed, 6 Oct 2010, Junio C Hamano wrote:
>
>> I have a mixed feeling about where to go next.
>> 
>>  (1) Treat "rebase" as a way to reproduce a reasonable history; the
>>      current behaviour to drop empty commits is consistent with this view,
>>      as a history with an empty commit is _not_ entirely reasonable.
>
> But a file mode change isn't exactly an empty commit, no?

The second message from DaveM:

    Message-ID: <20101006.174008.70175671.davem@davemloft.net>

    Ok it turns out that the commit in question was a NOP since the file
    permissions didn't change.
