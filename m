From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] userdiff: match Pascal class methods
Date: Tue, 11 Jan 2011 11:13:01 -0800
Message-ID: <7vipxv45ky.fsf@alter.siamese.dyndns.org>
References: <1294736039-5912-1-git-send-email-zapped@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alexey Shumkin <zapped@mail.ru>
X-From: git-owner@vger.kernel.org Tue Jan 11 20:13:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pcjeh-0005Cq-9H
	for gcvg-git-2@lo.gmane.org; Tue, 11 Jan 2011 20:13:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932614Ab1AKTNM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jan 2011 14:13:12 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45506 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932543Ab1AKTNK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jan 2011 14:13:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B7827307A;
	Tue, 11 Jan 2011 14:13:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NUE2dioZcbVxLbhTNei8t96kmJ8=; b=oVI0+e
	HRqc7t5StpGCTvXMLJ2H/a3Ot2K/e1JWJqm8DmQR9mIJ5Vaq+HTvDC2DRe3sm7Tl
	8swUULRY7L0zns/9oDyWtlNFDdLEgmoNNXew408c3VRx+rnDAqURF46wmVUiPNSX
	Q2c1XcKITC+5WpEAtTlPdXZGkWVz0dAX5JPdA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KSGXZqihbVtz3fD78zEVEewCoKGqqUMF
	DhOTuBURMkYtRmPjyvzUKTE5JHpWrbOAWdQRcnvbB64pM5vWON1/siZi2gL/CpRO
	AD+R5T7S6Qqiz9OhYSN1ZS3a4mNP9STMv8JNKI5SC+h/OHeQi61mu0pVcSbdMns6
	8+B7ckKvcKY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 95F353079;
	Tue, 11 Jan 2011 14:13:47 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B6E3F3078; Tue, 11 Jan 2011
 14:13:44 -0500 (EST)
In-Reply-To: <1294736039-5912-1-git-send-email-zapped@mail.ru> (Alexey
 Shumkin's message of "Tue\, 11 Jan 2011 11\:53\:59 +0300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EA7294E4-1DB6-11E0-A830-CBB45B885003-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164976>

Alexey Shumkin <zapped@mail.ru> writes:

> Class declarations were already covered by the second pattern, but class methods have the 'class' keyword in front too. Account for it.

Too long a line (which I could re-wrap locally but I'd rather not be in
the business of doing that for everybody).

>  PATTERNS("pascal",
> -	 "^((procedure|function|constructor|destructor|interface|"
> +	 "^(((class[ \t]+)?(procedure|function)|constructor|destructor|interface|"
>  		"implementation|initialization|finalization)[ \t]*.*)$"

Earlier we took "^procedure frotz", "^function frotz", etc. and now we
also take "^class procedure frotz", "^class function frotz", but not
"^class constructor frotz"---am I reading the patterns correctly?
