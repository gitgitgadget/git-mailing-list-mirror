From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [patch 13/15] no-socklen_t.patch
Date: Tue, 16 Mar 2010 00:25:07 -0700
Message-ID: <7vzl28lodo.fsf@alter.siamese.dyndns.org>
References: <20100316054220.075676000@mlists.thewrittenword.com>
 <20100316054403.034575000@mlists.thewrittenword.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
X-From: git-owner@vger.kernel.org Tue Mar 16 08:25:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrR9V-000409-Ih
	for gcvg-git-2@lo.gmane.org; Tue, 16 Mar 2010 08:25:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937518Ab0CPHZP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Mar 2010 03:25:15 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56290 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936263Ab0CPHZN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Mar 2010 03:25:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8C93FA2020;
	Tue, 16 Mar 2010 03:25:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=a1uC+hqfRGInUoT6uBiztw2ttWQ=; b=aRx22Nt5dEWNeM3oq8ZP73U
	o1taC7QEKdcK6X6wn0sKFLmCujglL/0rwRBSKJCeIaup/xfYJW2B7iZgJPEp+0Zn
	klCDLqeGLEuav+f07xtLgHTs1qbmkDB+GwwzL9OtQNhDhmHVvu9PWU83ZB3j/iAg
	9OUNN+HOLPk2WoM61huI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=VZVt4Zsnmg1QEeMQspIRxR8BmAaDuzuU6cwjHjmfjkGM00VDu
	fLlxVDHQABTWj9B/1gflC5vqOYdAp/QtVPUFpGJ92go50TiT5EBe75tOuaUnPnmf
	i+OCZryQKarAsK6lSDz1YKMP82M6UxpoDW9M0lHsBf/RH2mJjoqSoL2YH0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 695CBA201F;
	Tue, 16 Mar 2010 03:25:11 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CC6A9A201E; Tue, 16 Mar
 2010 03:25:08 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0E7EDB54-30CD-11DF-82A2-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142331>

"Gary V. Vaughan" <git@mlists.thewrittenword.com> writes:

> +ifneq (socklen_t,$(SOCKLEN_T))
> +	BASIC_CFLAGS += -Dsocklen_t=$(SOCKLEN_T)
> +endif

This looks like making use of configure mandatory to me?  Could you do
this patch without doing so?

The same comment applies to [15/15].

Thanks.
