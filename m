From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add: introduce add.ignoreerrors synonym for
 add.ignore-errors
Date: Wed, 01 Dec 2010 11:56:15 -0800
Message-ID: <7vmxopuv1c.fsf@alter.siamese.dyndns.org>
References: <cover.1291207768.git.git@drmicha.warpmail.net>
 <7vd3pmw9n5.fsf@alter.siamese.dyndns.org>
 <b61288036e756c78709438491416d573459a732e.1291207768.git.git@drmicha.warpmail.net> <AANLkTi=cb0i28oGi9vrYfEyU_fPHhQGhNNtramtCpCHy@mail.gmail.com> <20101201160503.GB26120@burratino> <m3aakp4g5o.fsf@localhost.localdomain> <20101201163406.GD26120@burratino> <20101201175517.GA7774@sigill.intra.peff.net> <20101201183615.GA27024@burratino> <20101201184659.GA9147@sigill.intra.peff.net> <20101201185711.GD27024@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 01 20:56:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNsnD-0000ky-Ou
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 20:56:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756835Ab0LAT4f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 14:56:35 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50859 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756755Ab0LAT4e (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 14:56:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 529BF2DAC;
	Wed,  1 Dec 2010 14:56:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8LFBWQbcJ4/iogOhU4+IHavbifI=; b=n7XTxu
	ClWPVCnE3xVYu6FYS0OlTtHyGc2VxswoCerhA0vfha4I7aA3tazgANiS18UL7Nqa
	eayz3e5Gz55Gtzpbw0eFadNn07pbN9AJxD4oMk2i4NYWjaANhfp0SQpkTAVCbaA8
	0tXYXx+ra8dhdQFQuAeVippir+NNlGrNKRdLI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=G2/RfvZ6gegGsxJPuxvzaJjEOz8ZW0C/
	4R9etP1LWKVWVDP9tfVnPlj7R8BjIWh98q4yMhQOEX8bF4zkxMejCJfL1LgFqAaF
	csqEYMm7mYFflv81Y2KGroD0P9GkNKvIhCJzZJG/M6L2XBm0QuBBY1syy79IJbe+
	2Xe/nbxID5I=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E6D2F2DAB;
	Wed,  1 Dec 2010 14:56:44 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D01202DA6; Wed,  1 Dec 2010
 14:56:35 -0500 (EST)
In-Reply-To: <20101201185711.GD27024@burratino> (Jonathan Nieder's message of
 "Wed\, 1 Dec 2010 12\:57\:11 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1FB8C31E-FD85-11DF-BFFB-CDEAE6EC64FC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162591>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Jeff King wrote:
>
>> Yes, looks good to me. You could potentially drop the old one from the
>> config:
>>
>>> --- a/Documentation/config.txt
>>> +++ b/Documentation/config.txt
>>> @@ -553,6 +553,7 @@ core.sparseCheckout::
>>>  	Enable "sparse checkout" feature. See section "Sparse checkout" in
>>>  	linkgit:git-read-tree[1] for more information.
>>>  
>>> +add.ignoreErrors::
>>>  add.ignore-errors::
>>>  	Tells 'git add' to continue adding files when some files cannot be
>>>  	added due to indexing errors. Equivalent to the '--ignore-errors'
>>
>> which may be less confusing to new users (who might ask "is there a
>> difference between the two?").
>
> Right, I prefer to keep it documented for the old and forgetful users
> (who might ask "why does this configuration work?").
>
>> But I don't have a strong feeling on it, so either way:
>>
>> Acked-by: Jeff King <peff@peff.net>
>
> Thanks again for the help.

Thanks, will queue.
