From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/5] diff: allow --patch to override -s/--no-patch
Date: Mon, 15 Jul 2013 09:40:22 -0700
Message-ID: <7vppujbwuh.fsf@alter.siamese.dyndns.org>
References: <vpqa9lof2e4.fsf@anie.imag.fr>
	<1373893639-13413-1-git-send-email-Matthieu.Moy@imag.fr>
	<1373893639-13413-3-git-send-email-Matthieu.Moy@imag.fr>
	<7v61wbeuix.fsf@alter.siamese.dyndns.org>
	<vpqa9lnderb.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, stefanbeller@googlemail.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jul 15 18:40:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uylp7-00072Q-8W
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 18:40:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933402Ab3GOQkZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 12:40:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54165 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933394Ab3GOQkY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 12:40:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 26FFE3170E;
	Mon, 15 Jul 2013 16:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dzKK3Q3Ywned1k87j1V585dKvW4=; b=kGrDNH
	2TBr3Rlix+/FonLLB836BEYGczkscttJWwGFjbfJcWZE35XqWfQlE5NnyNeVEcgr
	kXaAW9PBnsGrpTmuAVaXUrgObTA5CZZkgFEkY5B8vj5uvKeUgc3yG/Mdb3EvmzYI
	CezKAM1lzo70yrr11WN3Kvqae6K9rMu6Te1bo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kOA9svhLTPDy/Ua4Ep6TAz9VX2JlJcDH
	TFDMC3CLkm7Ubpq1IFjG3BREYSSYKl4Z2DOoH2XnQ6+erDr1hC17pgXTCpG0eFH+
	azhySxJvuLo8Qw06SuoCUE7TBGUBdfrcjFF5oXMdR9FGEazHZwnudyANMImHmN0b
	PNViiYU6CO4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D5B23170D;
	Mon, 15 Jul 2013 16:40:24 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 775933170B;
	Mon, 15 Jul 2013 16:40:23 +0000 (UTC)
In-Reply-To: <vpqa9lnderb.fsf@anie.imag.fr> (Matthieu Moy's message of "Mon,
	15 Jul 2013 17:28:08 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3EC6ED96-ED6D-11E2-A636-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230487>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> I am wondering if the difference after this patch between "-p" and
>> "-U8" is deliberate, or just an accident coming from the way the
>> original was written in ee1e5412 (git diff: support "-U" and
>> "--unified" options properly, 2006-05-13).
>
> No, it isn't. I just didn't notice the -U case.
>
>> If the original were written in this way:
>>
>> 	if (!strcmp(arg, "-p") || !strcmp(arg, "-u") || !strcmp(arg, "--patch") ||
>>             opt_arg(arg, 'U', "unified", &options->context))
>>   		options->output_format |= DIFF_FORMAT_PATCH;
>
> Yes, this seems to be a better way.
>
> There are other cases like --patch-with-raw, I'll send a reroll.

Thanks.
