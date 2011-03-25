From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] HOME must be set before calling git-init when creating
 test repositories
Date: Fri, 25 Mar 2011 14:30:48 -0700
Message-ID: <7voc4y6g6v.fsf@alter.siamese.dyndns.org>
References: <20110325200528.GA7302@blimp.localdomain>
 <7vsjub53j2.fsf@alter.siamese.dyndns.org>
 <AANLkTimQzPVOWCUx1hr+DEmRfdFB8=UeY_xCaxzVSwFy@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 22:31:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q3Eb2-0003LQ-Ux
	for gcvg-git-2@lo.gmane.org; Fri, 25 Mar 2011 22:31:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755155Ab1CYVa7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2011 17:30:59 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45278 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755132Ab1CYVa6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2011 17:30:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0714C4279;
	Fri, 25 Mar 2011 17:32:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hbg6jilP0jYArvhF3bczhNE0cP0=; b=sVGEa0
	RDYapy7v5fA0ctV1thOGHw2buDtDXFYqFJBNF6r7GW4hAlMscxord402TYPABEbI
	iMQW1l6hALCZAVW7S4THCx1mJT5WYPrS2OefUp+q7bgg4UTHSyteIUcj58RpBz5L
	cEdomJMCCjFpJN0NJ3nDChHVEAGlKlyFzErak=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wP0qqbtHXIWslHuR7zdSHTreYC+oHueQ
	nbty0Q8dtgBTu2t6u97zzGzB0fFzlYpacOzFf3o2Ed5JJ6DqSdn3EOsCsmTLm/0q
	Ps2V2cu0DUmyI7eQZ1ErfCBvwtjVivblFiLOs+nJYRuRNwu9GvBE3rteLoLx3F6J
	/6gyEKtEL/0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CBD1A4277;
	Fri, 25 Mar 2011 17:32:37 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id BDE3F4275; Fri, 25 Mar 2011
 17:32:33 -0400 (EDT)
In-Reply-To: <AANLkTimQzPVOWCUx1hr+DEmRfdFB8=UeY_xCaxzVSwFy@mail.gmail.com>
 (Alex Riesen's message of "Fri, 25 Mar 2011 22:01:55 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 67C6213C-5727-11E0-A6C5-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170020>

Alex Riesen <raa.lkml@gmail.com> writes:

> On Fri, Mar 25, 2011 at 21:49, Junio C Hamano <gitster@pobox.com> wrote:
>
>> Doesn't this change the location of HOME used during the test as well?
>
> As long as the test only includes test-lib.sh only once - it doesn't.
> Why? Or rather, how?

I thought you moved HOME=$(pwd) across "cd somewhere-else".  Doesn't it
change what is returned from pwd?
