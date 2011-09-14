From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] make-static: master
Date: Wed, 14 Sep 2011 12:03:36 -0700
Message-ID: <7vlitrt08n.fsf@alter.siamese.dyndns.org>
References: <4E6D0E3F.3090304@ramsay1.demon.co.uk>
 <7vhb4in4j7.fsf@alter.siamese.dyndns.org>
 <4E6FDE71.9050606@ramsay1.demon.co.uk>
 <7v62kwvwe9.fsf@alter.siamese.dyndns.org> <4E704EA2.8060307@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	GIT Mailing-list <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Sep 14 21:03:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3ukL-0004sA-0d
	for gcvg-git-2@lo.gmane.org; Wed, 14 Sep 2011 21:03:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932870Ab1INTDk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Sep 2011 15:03:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39057 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932462Ab1INTDj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2011 15:03:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2DE8F554F;
	Wed, 14 Sep 2011 15:03:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=voTrruRkLxs7DrPGxV/OKFuvrR0=; b=m9OUcm
	2sx1sS+hwlXQDmLEesl6SiQHN9CQsu7ddpQg3R+g8/bzDC95XaiidvtsCphmIDJO
	WJVUmYCrLmTB+EgOzZb4AD301IOGaS/r8njcfHqTWdkIZUiSftenklDWDlB8RU9U
	wPATuBYiSJobMzcfN+xjlzJuROSMVrqWb7p2M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OTafCaSPdhX5Zxrk9DnrQAe5o8UXRT48
	qZtlaz0dv17yxFM+PgKTOaDfh1akEVQNk9hUhIEB7ZbNeeu6nu0QDckPdkeG7Tkf
	oc9MRaQ6RCojggqe+X1EaA4xDbs86IR+yGh4Sno7DUFWZSgAIZavDBKC2B7k0eKR
	NPeUkIQ3zvM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2553D554E;
	Wed, 14 Sep 2011 15:03:38 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ADFD5554D; Wed, 14 Sep 2011
 15:03:37 -0400 (EDT)
In-Reply-To: <4E704EA2.8060307@viscovery.net> (Johannes Sixt's message of
 "Wed, 14 Sep 2011 08:50:10 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 40913772-DF04-11E0-B080-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181386>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Am 9/14/2011 1:46, schrieb Junio C Hamano:
>> This kind of breakage report was exactly what I was looking for by
>> merging it early to 'next'. Hopefully no other (function / platform) combo
>> has such dependencies...
>
> There is! prepare_git_cmd is used from the Windows section in run-command.c.
> Therefore, the following hunks of the patch should be reverted.

Sorry, I do not think it should just be "reverted".

Instead, a new comment should be added to explain why it needs to be
exposed, which was the _whole_ point of the message you are replying to,
in which I showed how it should be done by an example.
