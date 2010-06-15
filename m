From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mailinfo: parse From header more strictly when run from
 rebase
Date: Tue, 15 Jun 2010 09:14:37 -0700
Message-ID: <7vzkyw6zo2.fsf@alter.siamese.dyndns.org>
References: <1275885945-29241-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 15 18:15:07 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOYmz-0006oQ-Gw
	for gcvg-git-2@lo.gmane.org; Tue, 15 Jun 2010 18:15:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754843Ab0FOQOp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jun 2010 12:14:45 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46905 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753780Ab0FOQOo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jun 2010 12:14:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4FD06BA334;
	Tue, 15 Jun 2010 12:14:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=t93D5yFhtrbJgwLb5E74QpEz+CQ=; b=DN+h26
	qs32GpkPTRiSs11zwdDpDZJLRKPYHR1FDX2fyYM/XrlxZClZ2NHt4GxpYN6MjXrU
	z1DrC5v1RoTFuwizgf8TZ1N/hg14QaPYaLAFADIHvtcnjnj4vTa1OvrFoc/cStIv
	AtPAA23Zv1LF2qh8fBNoYSMtY/s2gJDNG6dAM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NJbqhdLTr6270V8wBo/HzIskEkMGgpZ5
	Om0V8PyM7U/pjI1bYChFa7uLm/kiPZSDEuFaK4AfmA10T+eSyWkJsE7mR+8C+5O5
	6jJugNpbzsovPcBQBkAD9oj8gT79a/BSeg1KLO2bEtiMtZNBuhViQECptHmHn8K7
	yd0ICnnH17I=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 28ECDBA331;
	Tue, 15 Jun 2010 12:14:42 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8315DBA32E; Tue, 15 Jun
 2010 12:14:39 -0400 (EDT)
In-Reply-To: <1275885945-29241-1-git-send-email-jaysoffian@gmail.com> (Jay
 Soffian's message of "Mon\,  7 Jun 2010 00\:45\:45 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1AEB1880-7899-11DF-A093-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149197>

Jay Soffian <jaysoffian@gmail.com> writes:

> Given an email address of the form:
>
>  author@example.com <author@example.com@11B4E7C6-762E-4CF5-B2EB-3F7BD596981D>
>
> results in "author@example.com" being used as both the name and the
> address. This is due to an assumption in handle_from() that the
> first '@' denotes the address portion. The remainder of the string
> is then assumed to be the name, which is rejected by
> get_sane_name(), resulting in address being used for the name as
> well.

Sorry, but it is unclear from your message what problem you are trying to
solve, what your desired outcome is, and why you think that outcome is
desired.  The bracketed one shown above does _not_ look like a valid email
address, so using

    name = "author@example.com"
    email = "author@example.com@11B4..."

does not sound like a good thing to do to begin with.
