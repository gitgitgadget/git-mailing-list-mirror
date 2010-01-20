From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCHv8 00/10] git notes
Date: Wed, 20 Jan 2010 00:34:50 -0800
Message-ID: <7vhbqh5g45.fsf@alter.siamese.dyndns.org>
References: <1258681154-2167-1-git-send-email-johan@herland.net>
 <7vk4xl5y3z.fsf@alter.siamese.dyndns.org>
 <20091120192800.6117@nanako3.lavabit.com>
 <7vk4xl1nkl.fsf@alter.siamese.dyndns.org>
 <81b0412b1001190754m37ed01b0nd93b318d77d88a75@mail.gmail.com>
 <7vk4ve9dad.fsf@alter.siamese.dyndns.org>
 <7vska15u92.fsf@alter.siamese.dyndns.org> <4B56BC22.1040702@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Alex Riesen <raa.lkml@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	spearce@spearce.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Jan 20 09:35:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXW25-0006BP-1O
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 09:35:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460Ab0ATIfP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2010 03:35:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750775Ab0ATIfP
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 03:35:15 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40395 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751261Ab0ATIfN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2010 03:35:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C2BC192A87;
	Wed, 20 Jan 2010 03:35:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=J6q/NeIfA8JqS+7Y5LUtdGUHA40=; b=NmzjrV
	s+TGRrJqW6RqVBu0vBDmFXVlJ0a82MujjMTYaX5ENdYXGbNael7tvNM09EFvxGg4
	4iNDlsGFvMogXt+hOjIoAQAZfcp3nEtiUb/N4zuaEqlYs3rhIi1qYU/mJkjBkHxH
	mmgE95Ai1XIJoNTRKboWJuqwwG656YATJ8sUs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=a6p4P7xMlN0Tpf0XR4paOjZB3OlKZ7+Z
	SWxOEMPe/ifI2npejmuG4tq3m0HLPFC3unD5v74+rohT29dBErxJck4dbECRGcrv
	ihLmN1usUGdDN5Caz8YgxjTW2oLHwn3atkLtvu0372pSbM+fdXklnx7lXGuTm9bQ
	mCKsAq3cHOE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 196AA92A82;
	Wed, 20 Jan 2010 03:35:01 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B01C692A81; Wed, 20 Jan
 2010 03:34:51 -0500 (EST)
In-Reply-To: <4B56BC22.1040702@viscovery.net> (Johannes Sixt's message of
 "Wed\, 20 Jan 2010 09\:17\:38 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B303ED86-059E-11DF-A08B-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137525>

Johannes Sixt <j.sixt@viscovery.net> writes:

>> Subject: Fix "checkout A..." synonym for "checkout A...HEAD" on Windows
>> ...
>> Work this issue around by first calling check_ref_format(new.path) to see
>> if the string can possibly be a valid ref under "refs/heads/", before
>> asking resolve_ref().
>
> Your patch fixes the failure very nicely, thank you very much.
>
> BTW, calling 'git pack-refs --all' before 'git checkout master...'
> helps as well :-P

Thanks for a prompt response (given our timezone difference ;-)

I've been thinking about moving that check even further down, namely at
the beginning of resolve_ref(), as anything that is not valid cannot
possibly resolve correctly.

What do people think?
