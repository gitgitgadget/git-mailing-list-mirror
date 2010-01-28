From: Junio C Hamano <gitster@pobox.com>
Subject: Re: make install error
Date: Wed, 27 Jan 2010 18:53:33 -0800
Message-ID: <7v8wbjndn6.fsf@alter.siamese.dyndns.org>
References: <daef5be81001271658y4188445bofea2e3d576df91e5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: kap4lin <kap4lin@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 28 03:56:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaKYz-0000qA-B8
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jan 2010 03:56:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752232Ab0A1Cxn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2010 21:53:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752165Ab0A1Cxn
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 21:53:43 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40324 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752160Ab0A1Cxm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2010 21:53:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2412994E53;
	Wed, 27 Jan 2010 21:53:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gYn8vdbO4AkvTJrqrNA+qQlpizA=; b=qeSccH
	3tUQXgwnzBugeNkIK6I/CBX1+muDR7BQPDOeFQRS/AKvuQagjaN7yvP4zh1ZIVg1
	vJju3eI3gq31gfb9u/JMwcfO58UW1bjdJlHr3wTeHcPgwKtRHqqOZ/qOHtdDlyL8
	gxZIgkCes2AU2NRa0i9EYvn+QfyToDE6+QnfQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mN6NPyOXK2+KtxbyAWUZ/7/IZoQhii7U
	ggyM02o4qPM3Yk2Npym5NjwfAOGxQQ/jIr01c5BHM2yvecwwLIBDcu6N0lAWwwjW
	pdl/CUm2eNuhyDS6ouwyuCNlI94c0wnqQxSc7JnvXv8ZHBaYkNLlrjjwPGOm86/5
	lGvQDI+v668=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F383C94E51;
	Wed, 27 Jan 2010 21:53:37 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5CF8794E4D; Wed, 27 Jan
 2010 21:53:35 -0500 (EST)
In-Reply-To: <daef5be81001271658y4188445bofea2e3d576df91e5@mail.gmail.com>
 (kap4lin@gmail.com's message of "Wed\, 27 Jan 2010 19\:58\:42 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 556FB446-0BB8-11DF-9C3F-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138221>

kap4lin <kap4lin@gmail.com> writes:

> (cd blt && gtar cf - .) | \
>         (cd '/scratch/kap4lin/usr/share/git-core/templates' && umask
> 022 && gtar xof -)
> gtar: This does not look like a tar archive
> gtar: Skipping to next header
> gtar: Archive contains obsolescent base-64 headers
> gtar: Error exit delayed from previous errors
> make[1]: *** [install] Error 2
> make[1]: Leaving directory `/scratch/kap4lin/softwares/git-1.6.6.1/templates'
> make: *** [install] Error 2
>
> Any help?

Perhaps "unset CDPATH".

Also look for "export CDPATH" in your .bash_profile and remove it (and
either remove CDPATH=... from your .bashrc or make it conditional only to
interactive sessions).  Setting CDPATH for non-interactive sessions does
not make any sense and asking for troubles.
