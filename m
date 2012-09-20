From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] completion: fix shell expansion of items
Date: Thu, 20 Sep 2012 09:52:49 -0700
Message-ID: <7vmx0kbpr2.fsf@alter.siamese.dyndns.org>
References: <1348107315-25095-1-git-send-email-felipe.contreras@gmail.com>
 <20120920014608.GA27782@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 20 18:53:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEjzo-0003r4-E2
	for gcvg-git-2@plane.gmane.org; Thu, 20 Sep 2012 18:53:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751526Ab2ITQww (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2012 12:52:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44587 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751322Ab2ITQwv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2012 12:52:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EFEC9998A;
	Thu, 20 Sep 2012 12:52:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5lRvBPBOP7+DulGItj6Srlr96i8=; b=L9XQyw
	nkkBwhP+6UzpdZbXS6nI3zUK8jol6q6kPpG//pGAkmfSge9pA3pOSpAmQP82/mCZ
	Fj43Czm43TKlpzZjpKG2YltZiWmaGlRXsQ6Ye6JAYcnYy4clkUxlzMORuHRm+xv6
	M7XhtahEcFT+A+GHagdqucQZ/5P3QuaiQsFBs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aVoAPARRkyAt8PdZVRZEg1ORSvn3n1OO
	gJ3btv/Z9fPJ1Vqpg7x8MXq6c5HK52e8ETYwV8NEYpuWV5m0UTbB71Qv98lPQw2I
	UQqDdpcQg/RYeh0nGmTGxEAxpv+aglisb3Rfr5BpBkM4V41b6rHku+zZrNHHkQo1
	NwC5pneIg4o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DE4229988;
	Thu, 20 Sep 2012 12:52:50 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5B0899987; Thu, 20 Sep 2012
 12:52:50 -0400 (EDT)
In-Reply-To: <20120920014608.GA27782@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 19 Sep 2012 21:46:08 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9CDABA9E-0343-11E2-91E2-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206055>

Jeff King <peff@peff.net> writes:

> On Thu, Sep 20, 2012 at 04:15:15AM +0200, Felipe Contreras wrote:
>
>> As reported by Jeroen Meijer[1]; the current code doesn't deal properly
>> with items (tags, branches, etc.) that have ${} in them because they get
>> expaned by bash while using compgen.
>> 
>> A simple solution is to quote the items so they get expanded properly
>> (\$\{\}).
>> 
>> In order to achieve that I took bash-completion's quote() function,
>> which is rather simple, and renamed it to __git_quote() as per Jeff
>> King's suggestion.
>> 
>> Solves the original problem for me.
>
> Me too. Thanks.

Thanks, both.  Will queue.
