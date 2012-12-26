From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] make __git_ps1 accept a third parameter in pcmode
Date: Wed, 26 Dec 2012 12:54:49 -0800
Message-ID: <7v38yso7om.fsf@alter.siamese.dyndns.org>
References: <7vvcbpp846.fsf@alter.siamese.dyndns.org>
 <20121226191505.GA29210@simaj.xs4all.nl>
 <7vmwx0oavn.fsf@alter.siamese.dyndns.org> <20121226201944.GA15039@xs4all.nl>
 <7vfw2so8q3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: piotr.krukowiecki@gmail.com, git@vger.kernel.org
To: Simon Oosthoek <s.oosthoek@xs4all.nl>
X-From: git-owner@vger.kernel.org Wed Dec 26 21:55:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tny0N-0001ph-Cb
	for gcvg-git-2@plane.gmane.org; Wed, 26 Dec 2012 21:55:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193Ab2LZUyx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Dec 2012 15:54:53 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58776 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751032Ab2LZUyv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Dec 2012 15:54:51 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7BBBDA326;
	Wed, 26 Dec 2012 15:54:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oIXDjrEJ4ky/s6h223qCYJ/DkLM=; b=vIazIi
	7w3BthS/AI0QiKIyLUCT4er42JT18D0uH0RQRRQAVKRoBt3NlodZJzVNiwQjYr84
	eIvHptRSop53cUfoMWlk3PvBjxJu9wylnq/5ZM8WeZHtO6AqYAUqDmRjiwhzFq93
	tFO4264FCxE0TNJCNHz71VqV8/ty7k5bVLVDI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NQ7lzRTPlqusAtwbquZyLahk9RtzoW6J
	sR86KKE5aIMjkFQIBLiLnGL1uWMMrVF/83sKJprcal5Vs1YvK2MbBLvGVJi6DSoU
	19zCbXzOIJgFryfe6CQCODS8mPKaHeFafl39efS5kPCmfv8V6wIqB7ZN4rGSpyLl
	TeEkKcr3FBE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 66CD1A325;
	Wed, 26 Dec 2012 15:54:51 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CDC70A322; Wed, 26 Dec 2012
 15:54:50 -0500 (EST)
In-Reply-To: <7vfw2so8q3.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 26 Dec 2012 12:32:20 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7DCFEEBA-4F9E-11E2-8EA1-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212153>

Junio C Hamano <gitster@pobox.com> writes:

> But as I said, there probably is a reason why that approach does not
> work, that is why I said...
>
>>> I have a feeling that I am missing something major, though...

In any case, this was more like "if we were doing this from scratch"
conversation.

I think PROMPT_COMMAND mode that takes <pre> and <post> string has
been advertised throughout the pre-release freeze, which is long
enough in Git timescale to avoid backward incompatibility, so we are
already stuck with the function in two modes even if what I said in
the previous message (i.e. "why not just one mode") worked.

I am considering to fast-track the "optional third parameter" patch
to the 1.8.1 final, so that we can have the same degree of
customizability in both modes.

Thanks.
