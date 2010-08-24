From: Junio C Hamano <gitster@pobox.com>
Subject: Re: reducing object store size with remote alternates or shallow
 clone?
Date: Tue, 24 Aug 2010 11:59:53 -0700
Message-ID: <7vfwy3vnti.fsf@alter.siamese.dyndns.org>
References: <14526ED4-F65C-4DF2-ABDD-BF1E76DAC2B0@kernel.crashing.org>
 <7vhbikx8lu.fsf@alter.siamese.dyndns.org>
 <2dePxmEZeCbs4IkjGd-Ig2cma8lknd0XEwVdaypeAxtQDY3EZeSEPA@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kumar Gala <galak@kernel.crashing.org>,
	Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Tue Aug 24 21:00:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnyjD-0001lP-3j
	for gcvg-git-2@lo.gmane.org; Tue, 24 Aug 2010 21:00:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755077Ab0HXTAE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Aug 2010 15:00:04 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39515 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755065Ab0HXTAC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Aug 2010 15:00:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E2C5D0AA7;
	Tue, 24 Aug 2010 15:00:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jLs9hVT2t5swjT+SKzmRRqG9ifM=; b=H8+h97
	i9JfeTSqTIswetQxdOigcOqeq7B25us7EeLzlK6awPOfidAL3kilUmZlYI085EH4
	wAhLLIyzwPcFjY48W5QB/knqiOq8xauXuyxFanAJbKwRM7xFWP6D5i8rWm+bUZy9
	1aemKCI2VI3+dlG2GRW1hEGovxjRiefSbmaXA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oE352cfp/SgtfZCxaN9pBamuM7wegOws
	j/E5oWCAEGFMC0CgxKNYQwrDs4fh4h3VBnSZk02Mtg6TMxcWJUrlLoE6tFlrqLbV
	PNCJAO4pEUmXwFLCs/wDw8miZC6qNuCKPgdAqsrhIt55l6gq/Sgnc2wepC+kJ4Ug
	E7Ux8WUYu0Y=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F1C2DD0AA6;
	Tue, 24 Aug 2010 14:59:58 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 396DFD0AA1; Tue, 24 Aug
 2010 14:59:55 -0400 (EDT)
In-Reply-To: <2dePxmEZeCbs4IkjGd-Ig2cma8lknd0XEwVdaypeAxtQDY3EZeSEPA@cipher.nrlssc.navy.mil> (Brandon Casey's message of "Tue\, 24 Aug 2010 13\:15\:58 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CAB921B8-AFB1-11DF-AE5F-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154334>

Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil> writes:

> On 08/24/2010 11:45 AM, Junio C Hamano wrote:
>
>> How about doing
>> 
>>     $ LINUS=git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
>
>>     $ git fetch $LINUS
>>     $ git bundle create myfork.bundle HEAD..master
>
> I think you mean
>
>       $ git fetch $LINUS master
>       $ git bundle create myfork.bundle FETCH_HEAD..master

Thanks, of course you are right.

Strictly speaking, as I know there is only one branch in the repository of
Linus, there is no need to say "master" when fetching, but it would be a
good discipline to explicitly specify what you mean on the command line.
