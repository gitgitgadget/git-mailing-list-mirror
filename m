From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3] Makefile: implement help target
Date: Wed, 29 Sep 2010 13:39:57 -0700
Message-ID: <7vbp7gmggy.fsf@alter.siamese.dyndns.org>
References: <7vhbh8r1zj.fsf@alter.siamese.dyndns.org>
 <d2da07fe51a3aba727165b0a0de299c266097145.1285791283.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Stephen Boyd <bebarino@gmail.com>,
	Andreas Ericsson <ae@op5.se>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Sep 29 22:40:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P13Rt-0006C8-BD
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 22:40:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755295Ab0I2UkP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Sep 2010 16:40:15 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:50031 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753338Ab0I2UkO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Sep 2010 16:40:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 684801491;
	Wed, 29 Sep 2010 16:40:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=K3fOq1ONV3ESgr1CeG+OtEbWg9w=; b=axx6vn
	TQIzcQB/8UObuquZ3mcBUqeEZozkE2uQ9UqF1ek8TYjrszwV58JuUxKGYhDjJIar
	wKyDZwPtCH3Lr9hM2YP5NaD2nLGmPUJn7QV/STKXL95Oez7iWN7YpJCSjiYbR3zN
	IgacA40OVgHgLKadYksbgbfKJZv7QUAUE3CoQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=F9Nl8b05yk0dS7Tm+0WbGVFWY5jhiJJP
	ddzlxU5f18rsiya68WOpjfHUJdhNhmyMM/SCr5RIJtTZejMBETGl+2xCbj72SnxP
	9vi8E41IzHu8+ZYxvufLwPn90v3NviL/eoBZ55W6Z9kvIrj3CiM8K8sJIHev1sV2
	4fBzvMdxpIU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E1F971490;
	Wed, 29 Sep 2010 16:40:05 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B9C6C1487; Wed, 29 Sep
 2010 16:39:58 -0400 (EDT)
In-Reply-To: <d2da07fe51a3aba727165b0a0de299c266097145.1285791283.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Wed\, 29 Sep 2010 22\:15\:55 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BE00F3BE-CC09-11DF-AF46-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157604>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> diff --git a/Makefile b/Makefile
> index db2efd6..371214d 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1,4 +1,10 @@
>  # The default target of this Makefile is...
> +help-Build::

Heh, no way.  The default target of this Makefile should remain "all".

Even though letting phony double-colon rules to implicitly collect members
of groups and showing them is a neat idea, I do not think "make -j help"
would do what you are expecting ;-)
