From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] Threaded grep
Date: Tue, 26 Jan 2010 09:21:43 -0800
Message-ID: <7vaaw0234o.fsf@alter.siamese.dyndns.org>
References: <20100125225139.GA3048@fredrik-laptop>
 <7vpr4x1x20.fsf@alter.siamese.dyndns.org>
 <20100126114303.GA1854@fredrik-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Fredrik Kuivinen <frekui@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 26 18:22:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZp72-0002HN-5S
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jan 2010 18:22:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754210Ab0AZRV5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2010 12:21:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753706Ab0AZRV4
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jan 2010 12:21:56 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43314 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753358Ab0AZRV4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2010 12:21:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 76D4094C59;
	Tue, 26 Jan 2010 12:21:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HfyrXSfnKfJW1YEQr+q52cKZCWI=; b=e0qxoG
	B6AHxbAomMVfbX8QDaYeArf0pfAEdZLGY8fc82FUWDC9k7dA9sGgJhJuI94wTFYI
	ZfxiCun4XRd4b4VJBPLLSLQdpbrWn6am+5nkC8b3Vg3PGV/sQ4NoXNwSyZS+4BSY
	Bej8zkHIoQ9vxyS6Rzha/PBdqS82ILPsusxSg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aAcPDYWbLs29hZf6iYv4Hy0Sr9gSFyzR
	2Zoy5vj1zwI54BVQwAVkRGnHJt9UQ2KDAm1zofL5nv6IzAyNsZApKyZXBslep3Bm
	pJFywAOkEqvmY8CkJkF9lelM7Ltihc4QsF85b8OsAtoQ0pbX4ZRL89rlAJ+wno1Y
	JrZMdNar5Sg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 35C9194C58;
	Tue, 26 Jan 2010 12:21:50 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5EE5E94C53; Tue, 26 Jan
 2010 12:21:45 -0500 (EST)
In-Reply-To: <20100126114303.GA1854@fredrik-laptop> (Fredrik Kuivinen's
 message of "Tue\, 26 Jan 2010 12\:43\:03 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 49FEADC0-0A9F-11DF-8625-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138059>

Fredrik Kuivinen <frekui@gmail.com> writes:

> I just noticed that I forgot to take the read_sha1 lock in
> grep_tree. The result is a race condition in read_sha1_file.
>
> Here is a patch to fix this. It applies on top of ae35c68 (Threaded
> grep). Could you please squash it in?

Thanks; will do.
