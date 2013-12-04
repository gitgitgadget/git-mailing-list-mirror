From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC 00/11] Make reference pruning more configurable
Date: Wed, 04 Dec 2013 12:25:41 -0800
Message-ID: <xmqq1u1sl5x6.fsf@gitster.dls.corp.google.com>
References: <1386135890-13954-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Dec 04 21:25:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoJ13-0002iX-AV
	for gcvg-git-2@plane.gmane.org; Wed, 04 Dec 2013 21:25:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933160Ab3LDUZp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Dec 2013 15:25:45 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65028 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932880Ab3LDUZo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Dec 2013 15:25:44 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1964956EA8;
	Wed,  4 Dec 2013 15:25:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dCKLuTtxWBHIU4wbpowv6OmDFVs=; b=PmqZPW
	+hzdhmnCJhWuOw4nUHLUlvUcvNf6+sytCo+D3zx+ZpgJm57XhZhi8anFcF4YWZh7
	7/mC/9RChuV2zqkdA7q/YBHWxdlUfok00fjZg/HFtard4MIy8qvUD3HW3eA8Nd/M
	Wox5RIJ452seNVyOjj1J83svZ42EmKweYF2Hk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=r6nrX+7FJym5jdcfGsvqvFyhXOE0R+XG
	CA+cVFBAu0ycnhTM2c7qu1JO82YCbzu0LMI1tAWPGXzWCW9UIyme4llSBRJTfhCJ
	tRdakanxYZzY3/52doL07VyBjih+HY/+rXeyZqeXDjBaKD3rgCM925+bzAxoi8pk
	FhsXjs86TA4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0017856EA7;
	Wed,  4 Dec 2013 15:25:43 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3DA1956EA6;
	Wed,  4 Dec 2013 15:25:43 -0500 (EST)
In-Reply-To: <1386135890-13954-1-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Wed, 4 Dec 2013 06:44:39 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3FD788C4-5D22-11E3-8E23-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238809>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> But even though "--prune=<pattern>" is no longer needed to prevent tag
> nuking, it might be useful to somebody for other purposes, and
> therefore I am submitting it to the list as an RFC.  Maybe there is a
> use case associated with non-branch, non-tag references, like perhaps
> Gerrit pull request-related references?
>
> Personally, I am -0 on this series.  I think it adds more complication
> (code, documentation, etc) than its usefulness justifies.

I tend to agree.  Even though selective "only prune these if the
other side no longer have corresponding refs" sounds like a great
flexibility as a concept, the user needs to know that the local refs
that match given patterns cannot come from remotes other than the
one that fetch is talking with, which is already too complicated for
the human user to grok ;-) "Don't mix refs from different sources in
a random hierarchy" is probably a good advice and when adhered to
there is no need for such a selective pruning.

> So, if anybody can think of a compelling use case for this feature,
> please make your case!

Thanks.
