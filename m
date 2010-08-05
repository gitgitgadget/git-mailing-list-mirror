From: Junio C Hamano <gitster@pobox.com>
Subject: Re: jk/tag-contains: stalled
Date: Thu, 05 Aug 2010 15:15:49 -0700
Message-ID: <7v4of8d7u2.fsf@alter.siamese.dyndns.org>
References: <7v62zqf23s.fsf@alter.siamese.dyndns.org>
 <20100805190653.GA2942@sigill> <7vd3twdbny.fsf@alter.siamese.dyndns.org>
 <201008052338.16668.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Ted Ts'o <tytso@mit.edu>,
	<git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Aug 06 00:16:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oh8jS-0004IC-0D
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 00:16:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758974Ab0HEWQE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Aug 2010 18:16:04 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:35075 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758764Ab0HEWQB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 18:16:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1A4DCCB985;
	Thu,  5 Aug 2010 18:16:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=X1kOtgn5v/F3OKFVfC/fwJpIiUE=; b=eWdQPE
	wWGGx+myXz32D+N5cRrd5WbGIhIRq/gP+oitagqt06xJImYRHYRcdxBR3eztOf3+
	AeDUvtfkQh2BuQex59wiEPNWCHpGwZJahNL9l/9O+UP2U/0wMzlT2g5g/lswdS4s
	rXO4sI+pglY+Nw85dx646xFhh9gyAzkVUcPi8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=O+UKDjuPqqp+kFbGcMtlhBNhrcsOS92Q
	sQTBgzNQk0CvlkRWyDCmOm/vWUSx7vN3247xlEortz7IOlj6iRds6hgdoSRqOFof
	xrhPiWs0L9HXdHhZfj760W9X7+bO82gfYN7kw1ycygkw412KwKpbjRhcta8irzsv
	U1/Ns5xi04Q=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B5AEBCB983;
	Thu,  5 Aug 2010 18:15:55 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DD7ADCB982; Thu,  5 Aug
 2010 18:15:50 -0400 (EDT)
In-Reply-To: <201008052338.16668.trast@student.ethz.ch> (Thomas Rast's
 message of "Thu\, 5 Aug 2010 23\:38\:16 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0471964C-A0DF-11DF-A219-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152729>

Thomas Rast <trast@student.ethz.ch> writes:

> Junio C Hamano wrote:
>> *1* Also we would want to do something similar to the commit.util field so
>> that more than one utility libraries can attach their own stuff to each
>> commit.  It _might_ make sense to instead get rid of commit.util and
>> migrate the users to a separate "one object hash per one type of info",
>> though.  In any case it is a separate topic.
>
> I thought this already existed in decorate.c?

Yes, the point is that there may be cases where it may be better to
migrate some current commit.util users to that API.
