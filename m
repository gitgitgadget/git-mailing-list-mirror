From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 'next'ed --allow-unrelated-histories could cause lots of grief
Date: Thu, 21 Apr 2016 16:17:49 -0700
Message-ID: <xmqqk2jqr1pe.fsf@gitster.mtv.corp.google.com>
References: <20160421161043.GK7907@onerussian.com>
	<xmqqbn52ud6r.fsf@gitster.mtv.corp.google.com>
	<20160421185528.GJ23764@onerussian.com>
	<20160421225739.GA7508@kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Yaroslav Halchenko <yoh@onerussian.com>,
	Git Gurus hangout <git@vger.kernel.org>
To: Joey Hess <id@joeyh.name>
X-From: git-owner@vger.kernel.org Fri Apr 22 01:17:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atNrC-0006Ef-97
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 01:17:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752348AbcDUXRx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2016 19:17:53 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58288 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751603AbcDUXRw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2016 19:17:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0BDBD15008;
	Thu, 21 Apr 2016 19:17:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iAXDoNuYn9EI1esLzHCK5zvN764=; b=vTu6v0
	V2wC2P/aZApRmKjx5gJ6PLV4HIf/8C4RcgkQ1j2G+m9VeKp+TS+RhMf/gex+sw2x
	+oPBlulRmeAH+2VVVeAhQu7zEqRBFPgB1Rd/cQAFRIu0v4ipf686yaCG86we1jsU
	dVSYNBiOYG6xDIl9adradjihCL1t6r3XdeZqw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pamkvVeZj3m37EqKRx50cPBi/Y7/8nP1
	7v4TDjszWrKV8EGvVHgZN8Zv/rw3V733oGoZs7/sM1DrDJGB2WlLEJ+82AMmMeVj
	qYrpfxckNU7jm2wwupMj1ta4WWcbe+CQcIgjvilbuoa5XYTPL/s/uAGz9BlgYSKO
	PdZAuE/9C6E=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 04DC715007;
	Thu, 21 Apr 2016 19:17:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7139B15006;
	Thu, 21 Apr 2016 19:17:50 -0400 (EDT)
In-Reply-To: <20160421225739.GA7508@kitenet.net> (Joey Hess's message of "Thu,
	21 Apr 2016 18:57:39 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 44503958-0817-11E6-8FD4-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292163>

Joey Hess <id@joeyh.name> writes:

> Junio C Hamano wrote:
>>   merge: GIT_MERGE_ALLOW_UNRELATED_HISTORIES environment
>
> I hope this patch lands, it will save me a lot of bother.

Yup, it is somewhat ugly but the least bad option among command line
option (which would break with older versions of Git), configuration
variables (which would encourage users to opt out of safety
unconditionallly) and environment (which allows scripts to opt-in),
I would say.
