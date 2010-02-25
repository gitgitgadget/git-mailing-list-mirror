From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add `[decorate]' configuration section.
Date: Thu, 25 Feb 2010 15:12:21 -0800
Message-ID: <7vk4u0rju2.fsf@alter.siamese.dyndns.org>
References: <16c38171fc04cee7bdc607bb4c6586925b15278c.1266394059.git.sdrake@xnet.co.nz>
 <7vr5ojwy38.fsf@alter.siamese.dyndns.org>
 <alpine.LNX.2.00.1002261131190.19126@vqena.qenxr.bet.am>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steven Drake <sdrake@xnet.co.nz>
X-From: git-owner@vger.kernel.org Fri Feb 26 00:12:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nkmsl-0001G1-Bq
	for gcvg-git-2@lo.gmane.org; Fri, 26 Feb 2010 00:12:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934466Ab0BYXMa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2010 18:12:30 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:59213 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934449Ab0BYXM3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2010 18:12:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7BED19DADF;
	Thu, 25 Feb 2010 18:12:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=XLK08tRZ+KAmE8SsZ8+n6nsGrAk=; b=G2/yT5SY07rJLViOlS5Fo1X
	+dQv8b1DMqHDge2MoJFsJjppiwlG/pJ3umrssKMag37d18SctRkBZ1eFSUOINxSP
	UYlltMc8rEt1kdoffLqcDRYUp0W6ivh3aCP+Ge+2NBSgJSx7ZRjoXW2cp6a620sg
	mI6KvhcZAUDPu2nq2QP4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=OqbrWzVTAR17aMrPiJr0wCdag+5dv8HW8cOIsb4JwA86W+IpN
	rtx/tpQvQdArukOYfZO5ZRHULmbQr6P5SGw+jWC4wn2ocoeaX0YJ9fneYsEYO7RB
	qe5MDFr6clQK9edTCmzcNj/cLnMgNq/4ciCptn0lekMevboKODBZTij+TI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 53CE99DADE;
	Thu, 25 Feb 2010 18:12:25 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BB3339DADB; Thu, 25 Feb
 2010 18:12:22 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3C4C5D22-2263-11DF-8346-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141078>

Steven Drake <sdrake@xnet.co.nz> writes:

>   On Tue, 16 Feb 2010, Junio C Hamano wrote:
>   > I was not worried about what your change does.  I am worried about
>   > protecting what the code after your change currently does from future
>   > changes done by other people while you are not actively watching the
>   > patches in flight on this list.
>
> But that can easly be with the patch below.

What does that buy us?  "future changes" can revert your patch to
builtin-log.c easily.

I was talking about having tests in the test suite; any "future changes"
that breaks the output your series has established would not pass if you
specify what the expected output should be there.  Of course they can
change the test pattern in their patches, but then we will immediately
know they are changing the output.
