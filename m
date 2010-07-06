From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pack-refs: remove newly empty directories
Date: Mon, 05 Jul 2010 23:15:09 -0700
Message-ID: <7vbpal5e6q.fsf@alter.siamese.dyndns.org>
References: <1278368848-7037-1-git-send-email-price@ksplice.com>
 <4C32C8EB.1090104@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Greg Price <price@ksplice.com>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Jul 06 08:15:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OW1RF-0006zD-Ja
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 08:15:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752939Ab0GFGPV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jul 2010 02:15:21 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:50191 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752313Ab0GFGPU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jul 2010 02:15:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5E09EC015A;
	Tue,  6 Jul 2010 02:15:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wONzDqxYDeV8NTCwQuKdHFiwkEk=; b=gqg/Rf
	87E6XKHwkTroIDU3ucH/bwYwC2hM8gsDTUs8AvE7R8k5YMJUlDYvqUrB5N7AT+2Q
	tzHp6DDENFH1hXFBlJ9JdK9iAwa07x3nuKbdYP8l4BpDAQrH6kO8ED1OfszE8o76
	pSxMwcVsFFB8RvZace1+4kZT1iYqWbcRHbtj4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AAUCOq/IDByUf7KYHMgKfTYPFgA49Ywh
	Spvy2jp2kyta3yu/8GhbHkkPD6z64HX9FW1DN+z+9tHRT1+pcnUc5VBIgzFcIdGy
	sRXVbxEWml7t5yhuO/O08shNZIY2BRN4LLdxhsWFAGBgKKr+raD5EesCYLAgKLid
	d5ltmp4IGqU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 24D20C0158;
	Tue,  6 Jul 2010 02:15:16 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 50577C0152; Tue,  6 Jul
 2010 02:15:11 -0400 (EDT)
In-Reply-To: <4C32C8EB.1090104@viscovery.net> (Johannes Sixt's message of
 "Tue\, 06 Jul 2010 08\:10\:51 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D82DE31E-88C5-11DF-8F43-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150324>

Johannes Sixt <j.sixt@viscovery.net> writes:

> With your patch, is there any mechanism that inhibits that refs/heads/foo
> is created when directory refs/heads/foo does not exist, but a packed ref
> refs/heads/foo/bar is present?

$ git grep -e is_refname_available refs.c
