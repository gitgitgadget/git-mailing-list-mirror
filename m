From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFD] Deepen the git directory structure a bit.
Date: Thu, 18 Feb 2010 12:24:02 -0800
Message-ID: <7vbpfm9tst.fsf@alter.siamese.dyndns.org>
References: <alpine.LFD.2.00.1002181010590.4141@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Feb 18 21:24:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiCv3-0003BY-BC
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 21:24:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945Ab0BRUYM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2010 15:24:12 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56213 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751255Ab0BRUYK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2010 15:24:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2AD889B879;
	Thu, 18 Feb 2010 15:24:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wDT/BvHE6LFw5xrnrbFK/pKWECk=; b=eclqYF
	pA7CrjYCRMA54QVsvg8iK9W5dqQF1QSkvsIgLnxsJXW3gOtwYUQF/aIPCmadGgc5
	6VcvMNjB8YQG7wLoLuCUITEykTN+l7o6LJaAqDNQ/YUPXHtM2mDYgnmwLM2KOlCK
	v8w9GzojA3D0dlFJGOWL6tG26EHWaPSq5xd5g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HXfFzBaVqw+RK7a4UjW1HLqmOXnjhHY0
	ZbdDM5ZvqPHVIVqXc9MpIl/oFlG4RRMCxkVpUlci03PW/xiTV6YmlG4wa8902NHn
	2C5L8qJc4Yo7O+nSXCrT5WKiAcAuK+wRB1n83i9oYdHZ5mfMuswXiKjFNMEj4siM
	K+PfCasgvH8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BA28F9B875;
	Thu, 18 Feb 2010 15:24:07 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EE0579B861; Thu, 18 Feb
 2010 15:24:04 -0500 (EST)
In-Reply-To: <alpine.LFD.2.00.1002181010590.4141@localhost.localdomain>
 (Linus Torvalds's message of "Thu\, 18 Feb 2010 10\:36\:29 -0800 \(PST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 90C55284-1CCB-11DF-8055-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140374>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> I think this coul probably be done differently (I'm not proud of that ugly 
> '-I. -Ibuiltin' addition to the CFLAGS, for example), and I think there 
> are _other_ things we could also try to do to move files into 
> subdirectories, but this was a fairly easy thing to basically script.
>
> What do people think?

I personally like the general direction you are going.  One minor detail I
do not know about is whether to move "builtin.h" with others, or leave it
at the top.  Also I don't particularly find "-I. -Ibuiltin/" ugly.  It
would make sense to use "-I." and rewrite our '#include "xyzzy.h"' into
'#include <xyzzy.h>' even if we were not doing this change.
