From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [WIP PATCH 0/3] implement merge strategy for submodule links
Date: Wed, 16 Jun 2010 15:11:27 -0700
Message-ID: <7vy6eed3w0.fsf@alter.siamese.dyndns.org>
References: <cover.1276059473.git.hvoigt@hvoigt.net>
 <201006160205.20705.johan@herland.net> <4C1906FA.7010906@web.de>
 <201006162332.56700.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Jun 17 00:11:57 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OP0pr-0001CW-3b
	for gcvg-git-2@lo.gmane.org; Thu, 17 Jun 2010 00:11:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754445Ab0FPWLp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jun 2010 18:11:45 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56905 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752409Ab0FPWLo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jun 2010 18:11:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AE51FBC955;
	Wed, 16 Jun 2010 18:11:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FWQ6ScBgyeYGmWjZ0CEp1ID/B60=; b=qpJyWF
	CCB5CcFQ0hv/GvSb2PHRY8al4hsTrJZHOLBHcbKB9BcOXJlsKQyk5i9a8lYAsQUI
	Otn2AE0OzwcOAvRc95u6+gqnb12eIbcKEwPpb5Q8FkGvZKMdP7fn3LKrx2cke3ci
	BxqBDHOcS9kordLS8CpLFWq2LasftQ+900gug=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JNZUv65Ugy0v0WiLLNYBsDelH23gWtup
	7FCB1qBe6sZdE1QzCN1Qs1flZJldhQ59SBNR2Hlu04suiTQfr8Rqsrk+E6wVZ6aL
	Zy/YGbAuR4UIGIUcNcOVkWsx/5Ty+yN4l1EK4PcloKuE6Oe/qL5TYYF7gGndwyXV
	7S9m4HTMEpY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6547BBC94B;
	Wed, 16 Jun 2010 18:11:38 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6D87ABC945; Wed, 16 Jun
 2010 18:11:33 -0400 (EDT)
In-Reply-To: <201006162332.56700.johan@herland.net> (Johan Herland's message
 of "Wed\, 16 Jun 2010 23\:32\:56 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 22683B6E-7994-11DF-99EC-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149278>

Johan Herland <johan@herland.net> writes:

> On Wednesday 16 June 2010, Jens Lehmann wrote:
>> Am 16.06.2010 02:05, schrieb Johan Herland:
>> > - If the purpose is to re-use existing submodule merges then I'm afraid
>> > (as I've argued above) that this would happen too seldom to be useful
>> > in practice (and even then you would already have had to set up the
>> > appropriate config for your branch, to enable Git to find this
>> > pre-existing merge at all).
>> 
>> That this is all but happening seldom for us is the reason for this WIP
>> patch from Heiko. And other use cases won't be harmed by this change, no?
>> And if some are, we can add a config option to .gitmodules to control
>> that.
>
> Ok. I'm still not sure I see how this can happen frequently in practice, but 
> since you both probably use submodules more heavily than I do, I will not 
> stand in the way of progress.

At least it would be useful to learn how they manage to often produce the
submodule merge G.  Your scenario description was very clearly written and
in that particular workflow I didn't think it would be plausible to have
such a merge before it is needed.  IOW, their workflow must be quite
different from your scenario description, and I would like to see a
plausible scenario description that is as clearly written as yours;
perhaps that workflow can even be advertised as one of the BCP.

One possibility that comes to mind is perhaps Alice notices the presence
of F after she recorded D, merges D and F in the submodule to produce G in
the submodule repository, but does _not_ update the superproject to point
at it yet, for some reason.  Perhaps she hasn't tested the superproject
with the merged submodule yet.  Whatever the reason is, the tip of her
branch in the submodule would be ahead of what her superproject commit D
points at, but the commit is available to the maintainer to fetch.

Then the maintainer would see G in the submodule (after fetching both
superproject and submodule from Alice) already prepared to be used in a
merge between D and F.

I dunno.
