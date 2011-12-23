From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] i18n of multi-line messages
Date: Fri, 23 Dec 2011 12:54:51 -0800
Message-ID: <7v62h7c8kk.fsf@alter.siamese.dyndns.org>
References: <7vr4zxeaz5.fsf@alter.siamese.dyndns.org>
 <4EF2D436.3080303@viscovery.net> <7vaa6ldpk6.fsf@alter.siamese.dyndns.org>
 <4EF2E824.7020509@viscovery.net> <7v39cceay0.fsf@alter.siamese.dyndns.org>
 <4EF422D3.2050802@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Dec 23 21:55:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ReC8q-0002n1-8I
	for gcvg-git-2@lo.gmane.org; Fri, 23 Dec 2011 21:55:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757803Ab1LWUyz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Dec 2011 15:54:55 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40584 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757772Ab1LWUyy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Dec 2011 15:54:54 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9822653C3;
	Fri, 23 Dec 2011 15:54:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+a24zIAyghpguIBO1yaHtotq8PI=; b=pUOMif
	eWylV6fPSnRt8o/2VUisVDk0XNH7Kn7BvgDZRCzZu4vrzls9jaJ7JN60S6pJ0u4L
	UAJmEH+2AJkyrrFOHT2xTXD/PIb0fEuK8Bytmls5S3bYhpCEflhrFkiBfwpWl3yP
	MklpxGxVcBeSj7RKlWHW80/NJY9B3wOu6r5Kk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=l2zRbQviMjhObnzpwA8of4xvj1EReHA7
	b5Li6uss8lOdkScD5xlg2yaAAgZ6cE0uyE9QliGbbtazxfimL4y0bbBw9GSrfFw6
	n9ZoynlPgEkVIJdlqVF4eqqm1nf1/ot7hhu86jtYDOM3er5JW3UgPn28adFQvOLu
	fdLq8/B8slw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9021653C2;
	Fri, 23 Dec 2011 15:54:53 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2134553C1; Fri, 23 Dec 2011
 15:54:53 -0500 (EST)
In-Reply-To: <4EF422D3.2050802@viscovery.net> (Johannes Sixt's message of
 "Fri, 23 Dec 2011 07:42:27 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5CBD0992-2DA8-11E1-A26A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187640>

Johannes Sixt <j.sixt@viscovery.net> writes:

> IMO the solution to not translate plumbing messages is to omit the
> initialization of the gettext machinery.

That's clever, and might be a good approach. I didn't think things through
nor looked at the existing codepaths where we do that (and I won't be
looking at them over the holiday weekend).

> Anyway, here is a patch that modifies vreportf() in an i18n friendly way
> (I think). It is not necessarily meant for inclusion.

The test-part of the patch seems to match more or less what I tentatively
queued after I sent the "convert at vreportf() level" patch and then
discarded. You seem to have missed vwritef(), by the way.
