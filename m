From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tests: sanitize more git environment variables
Date: Wed, 26 Jan 2011 12:43:25 -0800
Message-ID: <7v39ofl7ki.fsf@alter.siamese.dyndns.org>
References: <20110126203331.GA27478@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 26 21:43:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PiCDK-0005X9-00
	for gcvg-git-2@lo.gmane.org; Wed, 26 Jan 2011 21:43:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754014Ab1AZUnd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Jan 2011 15:43:33 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33134 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753967Ab1AZUnd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jan 2011 15:43:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2F21B34D4;
	Wed, 26 Jan 2011 15:44:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=390v4VvJ/5RJnWRBFH5AHVSCo6k=; b=Sy8x0w
	DY0bjBGssyYERWGCMeqc8DoxhCFc8RUM2SfnF4oFnHJUq/8l/QEz+gxZgliaep4X
	kkCRF91fJXZxsWdSMmfwyBoMUEWkHp5Vtap1Fg9wGJuQGmMPjcEC2lB5BISxGP+V
	/FBUwGiBMjEViNDCUrfbHKxjC1l/ccjaCUy/4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=S/p22kKPrIHgF4R06cLQUbsittuD6b+i
	ayegeFAKKF8IOXpP9HDQDS3TpvaM+9KTM7LRjB2TImId5ppeoz+2tdzsufKS/Amg
	oqmbsmMSe8OMeYaLTtKRlBpu+9o1rSwe1MqKfD0cu0S9q/T9OlDHNGWG5xd1ukji
	3XQuVJxoW+E=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 04FE534D0;
	Wed, 26 Jan 2011 15:44:19 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1174E34CE; Wed, 26 Jan 2011
 15:44:15 -0500 (EST)
In-Reply-To: <20110126203331.GA27478@sigill.intra.peff.net> (Jeff King's
 message of "Wed\, 26 Jan 2011 15\:33\:32 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0C02A464-298D-11E0-B3DC-BC4EF3E828EC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165540>

Jeff King <peff@peff.net> writes:

> These variables should generally not be set in one's
> environment, but they do get set by rebase, which means
> doing an interactive rebase like:
>
>   pick abcd1234 foo
>   exec make test
>
> will cause false negatives in the test suite.

Cute.  Thanks.
