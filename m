From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 05/14] Change fetch_pack() and friends to take
 string_list arguments
Date: Mon, 17 Sep 2012 15:10:07 -0700
Message-ID: <7vd31ks3ls.fsf@alter.siamese.dyndns.org>
References: <1347171589-13327-1-git-send-email-mhagger@alum.mit.edu>
 <1347171589-13327-6-git-send-email-mhagger@alum.mit.edu>
 <7vipblmwaq.fsf@alter.siamese.dyndns.org> <5057167A.6040403@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.org>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Sep 18 00:10:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDjWP-0006Xk-26
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 00:10:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757361Ab2IQWKQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 18:10:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64569 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757355Ab2IQWKL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 18:10:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F36FC9AED;
	Mon, 17 Sep 2012 18:10:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=maxZ6bxjeuE6g3gRpL5Z8dtOysc=; b=qPITkH
	sC36Uu2FwMSON4US2yBzIVg10FjInOs0uWUz7r/fXjFjZtA9t2Spz7KJKJ4GCblO
	vcPZZuZvp7bM0tloK8trXUOZgej1QwRZYxe91SDrHRKK58+/AETGAJBGv6ueupte
	vo9bjGvr9oXMIaGBv8sqly0+R03xaVoHR1Mqw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eALng5ENPJu1t3F5ZK+mxypBQ9sWm9ba
	Hl0z4DY5csGsycr6nJqgoIjlC69J5BYLKQydqoHk0AM3t/UqELBQFEW2bJ6jzs47
	HXonT+6cRdkSXOVgk5OlJFa33j3p/Jn7wEhIH3qfxPJubwziSZ9wxppXaKPj9t1l
	1OgOymW2HBU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E05939AEC;
	Mon, 17 Sep 2012 18:10:10 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5A8BA9AEA; Mon, 17 Sep 2012
 18:10:09 -0400 (EDT)
In-Reply-To: <5057167A.6040403@alum.mit.edu> (Michael Haggerty's message of
 "Mon, 17 Sep 2012 14:24:26 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 71BE2B9C-0114-11E2-997D-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205760>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> But how far should this policy be taken?  It seems to me that strict
> adherence to the policy would dictate that *.h files should *never*
> include other git project files.

I wouldn't call that a "policy".  It's something we think about when
adding a new "#include" to see if it is worth adding and/or if it is
the right place to add it to reduce code churn.

As I said, what policy to pick and stick to is open to discussion,
and I wanted to leave it outside the scope of this series.  As it
has been cooking in 'next', I do not think it is worth reverting the
inclusion of "string-list.h" to delay this topic.  It is something
that can and should be cleaned up when we decide to pick the
inclusion policy and enforce it.  If we choose to go in the other
direction, we would end up adding it back, so let's keep it as-is
for now.
