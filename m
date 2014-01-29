From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 17/17] Documentation: add documentation for 'git interpret-trailers'
Date: Wed, 29 Jan 2014 12:30:12 -0800
Message-ID: <xmqq1tzqjzu3.fsf@gitster.dls.corp.google.com>
References: <CAPig+cQgq_2h+n8OeDsrmk_NqAA4RDNzkBAtNCNjOAGMrFN4jg@mail.gmail.com>
	<20140127.213344.212708599170084659.chriscool@tuxfamily.org>
	<xmqqfvo9nmul.fsf@gitster.dls.corp.google.com>
	<20140129.210102.2157679962537036887.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: sunshine@sunshineco.com, git@vger.kernel.org, johan@herland.net,
	josh@joshtriplett.org, tr@thomasrast.ch, mhagger@alum.mit.edu,
	dan.carpenter@oracle.com, greg@kroah.com, peff@peff.net
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Wed Jan 29 21:30:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W8bmF-00075a-Vu
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jan 2014 21:30:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751967AbaA2UaX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jan 2014 15:30:23 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50734 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751831AbaA2UaW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jan 2014 15:30:22 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CC98A68873;
	Wed, 29 Jan 2014 15:30:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/EYSd0bxa4wOiEThiCWy2+UVbIU=; b=EfvLPl
	+rUl/XNrNtKs6b5/drMib0QHV5IIXPMU7u5qiiNxmUwpw6h8iII7wAhPNu3oViSr
	kpDFxedC509+SL0azrIWAw94kWaN+51H0blM3lYYY2mjkQbDQXYm6t1l31HjYsAX
	zdEuuNZLdE+Umxuy2Y7rpbZARSlP8xu9sZPq4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kO5ZTl+Y4WStjQeHsw6BeBRMxF7HpOOR
	RBBXL4QdF2pCogZ45xEUwMjAZyGpNUuVleZbTbbLU2VfOCFTt08Bc0CllWFr8TvV
	YKlPYGWN+jxbPR2Y4P4ccX3uN3dfjOU42G2M3s858swPWKxogJjpGBHZ6UbDkCeQ
	jMMbiHo2GIc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A01D26886C;
	Wed, 29 Jan 2014 15:30:19 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EFE1268868;
	Wed, 29 Jan 2014 15:30:17 -0500 (EST)
In-Reply-To: <20140129.210102.2157679962537036887.chriscool@tuxfamily.org>
	(Christian Couder's message of "Wed, 29 Jan 2014 21:01:02 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2AC6359C-8924-11E3-9DD1-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241223>

Christian Couder <chriscool@tuxfamily.org> writes:

>> I find it a bad taste to allow unbound set of <token> on the LHS of
>> '=' on the command line, but that is a separate issue in the design,
>> not in the documentation of the design.
>
> I don't understand this sentence, sorry.

It is a bad design taste to structure the command line argument in
such a way that it takes

	git cmd xyzzy=frotz nitfol=rezrov some other args

where these 'xyzzy', 'nitfol', etc. form an unbound set.  It
prevents future enhancements to the command from allowing anything
that contain '=' in "some other args" part.

Allowing not just '=' but also ':' makes it even worse.

But these are issues in the design itself.  Not the issue in the
patch 17/17 that is trying to document the design.  This patch under
discussion documents the bad design correctly ;-)
