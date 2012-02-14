From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/5] do not override receive-pack errors
Date: Tue, 14 Feb 2012 11:06:24 -0800
Message-ID: <7vzkcl6xqn.fsf@alter.siamese.dyndns.org>
References: <7vhazobto3.fsf@alter.siamese.dyndns.org>
 <1329164235-29955-1-git-send-email-drizzd@aon.at>
 <1329164235-29955-3-git-send-email-drizzd@aon.at>
 <7v8vk6csx9.fsf@alter.siamese.dyndns.org> <20120214083324.GA1762@ecki>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Tue Feb 14 20:06:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxNhv-0006QF-R0
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 20:06:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759293Ab2BNTG1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Feb 2012 14:06:27 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38248 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752976Ab2BNTG1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2012 14:06:27 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6DB3F65CC;
	Tue, 14 Feb 2012 14:06:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jUtadICpC6evGtXM2v1uuzTUt/w=; b=SyGNUG
	2WUl0V1mNHl2fZAfnRftDtC3tY5mfJfydDq++gr/jJAJIb6tK3owyahhNmimlTjG
	QZb0+6DpAbc3DhfeaqJwCPOiBQ0sPM04Q4tElEKtHNxwMF3gN99e5nA5JrCwXs5d
	TdJV1bt74G9iitArXRfAJkNl8NQDTlCZievg8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hiMPnT/wo13WufEJSl6+/TNI7oBryjge
	f2mpwAuF/dzSbTWtvKnZ/1wNT5DC4FySGQSNcj5tVSTBCuazow3Xyd9ApC6INmYA
	KJKAYa54yOZpiJVoFYIS1iqaU4yYhuY/QdOEfcjTvwJNhMC/UeepeCY6qodkUAxQ
	z7oHodGL3Po=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6461065CB;
	Tue, 14 Feb 2012 14:06:26 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ECB3665C9; Tue, 14 Feb 2012
 14:06:25 -0500 (EST)
In-Reply-To: <20120214083324.GA1762@ecki> (Clemens Buchacher's message of
 "Tue, 14 Feb 2012 09:33:24 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FE0ED8A6-573E-11E1-A80F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190735>

Clemens Buchacher <drizzd@aon.at> writes:

> Yes, it really is. For example, in t5504 rev-list --verify-objects (it
> was turned on for me if called from there) detects the corrupt object.
> But the error string is later overwritten with the return value of
> update, which is NULL in this case.
> ...
> Actually, check_alias_update searches for aliases of cmd in ref_list,
> which is a list of refs from all commands, irrespective of their error
> status. So this change is correct.

Ok, thanks for clarificatin on both counts.
