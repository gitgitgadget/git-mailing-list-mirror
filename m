From: Junio C Hamano <gitster@pobox.com>
Subject: Re: t5800-*.sh: Intermittent test failures
Date: Tue, 01 Nov 2011 15:18:47 -0700
Message-ID: <7vfwi7lc54.fsf@alter.siamese.dyndns.org>
References: <4E417CB4.50007@ramsay1.demon.co.uk>
 <CAGdFq_jv_T-x7VGqm_j-fDfeW6TsBG95=1TWn91Yk9B3TGZdsQ@mail.gmail.com>
 <7vpqjgyvn1.fsf@alter.siamese.dyndns.org>
 <4E68FE73.4000005@ramsay1.demon.co.uk>
 <20110908182055.GA16500@sigill.intra.peff.net>
 <4E6D089C.4090006@ramsay1.demon.co.uk>
 <CALxABCbnZp-y0Fqzoa=Ab92P+hsT7hs3nXZsnA=ph3yGfkXhdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 01 23:18:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLMfX-0002ZC-V8
	for gcvg-git-2@lo.gmane.org; Tue, 01 Nov 2011 23:18:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932305Ab1KAWSv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Nov 2011 18:18:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37101 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753929Ab1KAWSu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Nov 2011 18:18:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 862716064;
	Tue,  1 Nov 2011 18:18:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=dYYCnmOmNeBU
	/2WhLcX6Qr/+OLA=; b=J5sfDhxNTtMfF9nfkMnI/9VdBnEBQs4GRqFrQL0C99kQ
	muqszGHmmQ7E60f1C7e0gphWNWIOEf4OFbRUjUbF0k/Y//etenWeIJyoqCUFlLYb
	LBsCABMvI2xgaOJiiJKUDHMJpBJJkgv6snAQYUTWnaLQvovTR/55K9R/peiytbU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=GoyY/V
	z9x7jFK4Y7fGTUUmu/n18YytkB9j8End5AXWu6RWWr1uAfUZ7AL6u7DR32sKbj98
	o9rH4CmHcTvjzIL8sdeVjASAx4Fe4+DMhIKpj+GzR/FmMd5GkK3gL3PYB8ehIKoh
	ovSI0UzjKlIcAXzgNfQj5VtHgZirK1UibrBDE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7DBEC6063;
	Tue,  1 Nov 2011 18:18:49 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 116E56062; Tue,  1 Nov 2011
 18:18:48 -0400 (EDT)
In-Reply-To: <CALxABCbnZp-y0Fqzoa=Ab92P+hsT7hs3nXZsnA=ph3yGfkXhdA@mail.gmail.com> (Alex
 Riesen's message of "Tue, 1 Nov 2011 22:57:21 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 78E8D762-04D7-11E1-8199-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184598>

Alex Riesen <raa.lkml@gmail.com> writes:

> On Sun, Sep 11, 2011 at 21:14, Ramsay Jones <ramsay@ramsay1.demon.co.=
uk> wrote:
>> ... these hangs *are* the failures of which I speak! =C2=A0Yes, the =
script
>> doesn't get to declare a failure, but AFAIAC a hanging test (and it
>> isn't the same test # each time) is a failing test. :-D
>
> Was there any outcome of this discussion? I'm asking because I
> can reproduce this very reliably on a little server here.

I do remember this discussion and recall seeing _no_ outcome.

I did see the hang myself once or twice but did not and do not have a
reliable reproduction. I have been waiting for somebody to raise the is=
sue
again ;-).
