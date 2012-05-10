From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Change error messages in ident.c...
Date: Thu, 10 May 2012 13:04:13 -0700
Message-ID: <7vipg3n6pu.fsf@alter.siamese.dyndns.org>
References: <1336676770-17965-1-git-send-email-angusgh@gmail.com>
 <20120510192339.GA32357@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Angus Hammond <angusgh@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 10 22:04:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSZb2-000704-Rc
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 22:04:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761153Ab2EJUEQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 May 2012 16:04:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36691 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754998Ab2EJUEP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 16:04:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 264DD8C4A;
	Thu, 10 May 2012 16:04:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1iBuD+YJGmcBoMd9y8h5NjWgBco=; b=VmYDIe
	mB5r1z/3cZuAy5PYL7o2tbj6GYVBuDYwDQ+3YlSXzpJ+Jd7BiX2XWYAtkyUc+ecd
	E0hpsrZHbmb/EuyeEnfX0EznC1Eo4mty9RJjnjOMgTV+pGm3yubZIsT7pbMV5d6u
	eKbTn7Pd2fZXS2pk3x8ApQrX9gnPsoJ6W2kVM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Pv2hj68WVozIi+ul1oj/T0JaRdQ289tm
	KM5Z6hjHhxQa9D+aWOgucipyrvqqWLN0HMN/go/a8CCrKzi8eMlomstrabO+ejlp
	/ptzukpxzIceMC+mOEc+XIr7/WGuklbQA9wcuW6wmZLYoz6XZbLSh/eBI+YCsv7D
	elZjNzcqlw4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1DCFC8C49;
	Thu, 10 May 2012 16:04:15 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A83808C48; Thu, 10 May 2012
 16:04:14 -0400 (EDT)
In-Reply-To: <20120510192339.GA32357@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 10 May 2012 15:23:39 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5119FEBA-9ADB-11E1-A3A0-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197624>

Jeff King <peff@peff.net> writes:

> I am also tempted to suggest that we simply replace the static buffers
> with dynamic strbufs.

Yeah, I think that is a proper approach for this issue, as it will make
two of these messages unnecessary (or all?  I couldn't think of a way
to deal with missing getpwent case myself, though).
