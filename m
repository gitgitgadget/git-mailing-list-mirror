From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] reflog: ignore expire-unreachable for "HEAD" reflog
Date: Thu, 15 Apr 2010 15:42:12 -0700
Message-ID: <7v7ho8ibi3.fsf@alter.siamese.dyndns.org>
References: <7vljcppycc.fsf@alter.siamese.dyndns.org>
 <7vfx2xpyam.fsf@alter.siamese.dyndns.org> <4BC6B5FF.6030406@viscovery.net>
 <7vochlkvtg.fsf@alter.siamese.dyndns.org> <4BC6D30F.5020004@viscovery.net>
 <7v4ojclwyu.fsf@alter.siamese.dyndns.org> <4BC70D75.70801@viscovery.net>
 <20100415163607.GA4279@coredump.intra.peff.net>
 <7vhbnck618.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1004151545240.7232@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Johannes Sixt <j.sixt@viscovery.net>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Fri Apr 16 00:42:30 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2XlW-0001jw-8q
	for gcvg-git-2@lo.gmane.org; Fri, 16 Apr 2010 00:42:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757858Ab0DOWmZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Apr 2010 18:42:25 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51310 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757820Ab0DOWmZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Apr 2010 18:42:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5BD97ABCA6;
	Thu, 15 Apr 2010 18:42:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zC1H+V3hX/tZo0yL/Kah+d1vUjc=; b=uGgJd8
	UDOpS3j7wTSrf9hmk148FXACqv5gl7Ur8+5pckY6IDD5xOUn3XCQ0Qb88WIbxjVP
	9m6ER5YfK31KiqagO8CiqJCVcaq3r4n1KGTBEEI0HUwNkOXWLCVQ9cJ3k7luUcS+
	ColzWtieMkFwpNs8ngTweNsVtSyKq2jgBUzSg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=e6wB77SHV7r2YorkGvwqriloYRfwgzMV
	hmGii6Bqnbz99OjVZFzkXW4jVkiVcT336+LLYGYeZyldNFF1TgqIzvvm/VZDStlH
	pGH53zuhNjUe5WqfPPKojc6WDrMDSztB2RAKn3KbLuPWL/FviJS+Brr2HMRHgh2t
	2T1MKdgjpKY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4BE86ABCA2;
	Thu, 15 Apr 2010 18:42:18 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7D6FAABC9E; Thu, 15 Apr
 2010 18:42:13 -0400 (EDT)
In-Reply-To: <alpine.LFD.2.00.1004151545240.7232@xanadu.home> (Nicolas
 Pitre's message of "Thu\, 15 Apr 2010 15\:48\:23 -0400 \(EDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 25769952-48E0-11DF-91D9-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145031>

Nicolas Pitre <nico@fluxnic.net> writes:

> I'm a bit worried about this discussion.
>
> What's the point of having a reflog for unreachable stuff if it is to be 
> pruned faster than stuff that is already reachable without any reflog?

To keep recently failed experiments alive for some time (30 days), but not
overly long (90 days)?
