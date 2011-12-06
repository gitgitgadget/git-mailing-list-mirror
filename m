From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 13/13] t: add test harness for external credential
 helpers
Date: Tue, 06 Dec 2011 13:51:43 -0800
Message-ID: <7vvcpte5cg.fsf@alter.siamese.dyndns.org>
References: <20111206062127.GA29046@sigill.intra.peff.net>
 <20111206062313.GM29233@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 06 22:51:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RY2vX-0001Ec-8Q
	for gcvg-git-2@lo.gmane.org; Tue, 06 Dec 2011 22:51:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753454Ab1LFVvr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Dec 2011 16:51:47 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38654 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752937Ab1LFVvq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2011 16:51:46 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9D86E67BA;
	Tue,  6 Dec 2011 16:51:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nKHhpjQREYjdIAzWD7AX2ua/sTc=; b=b+skBj
	H/fYgvbdaT1AUDKLhTRTR/z8nuH1VM7QujCMh1QNs38c+JAMBIeSazPXXAN79wwu
	B7htIIJd3MOG9TPdIySheiap3hoR6i2B2zAOsL7iQXA/5FhNJnp1PBWSBZOi+nOY
	lwCVRlAj+4msjLo365wg1QOx+zZv/dcLTErT0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mIIrV6XLwbDbZohwFiQv1YVaiz9fFC5+
	eduuIQONumhUm2rPGqo8yoKihDgOhiXHuRnsSNhGVUQ8XaaVGwO+p1Q/xY4ArZWz
	ojK+tDshMnmQahkUO3MGgcYPYWfeWw5FSO9pBonFZP86mol6/ciPtgwVkLBKUh9b
	8uqL8UKpk/o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9549767B9;
	Tue,  6 Dec 2011 16:51:45 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2A0A367B8; Tue,  6 Dec 2011
 16:51:45 -0500 (EST)
In-Reply-To: <20111206062313.GM29233@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 6 Dec 2011 01:23:13 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7D7280A6-2054-11E1-AEF1-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186396>

Jeff King <peff@peff.net> writes:

> diff --git a/t/t0303-credential-external.sh b/t/t0303-credential-external.sh
> new file mode 100755
> index 0000000..79b046f
> --- /dev/null
> +++ b/t/t0303-credential-external.sh
> @@ -0,0 +1,23 @@
> ...
> +else
> +	helper_test_clean "$GIT_TEST_CREDENTIAL_HELPER"
> +	helper_test "$GIT_TEST_CREDENTIAL_HELPER"
> +#	helper_test_clean "$GIT_TEST_CREDENTIAL_HELPER"
> +fi

Huh? Leftover debugging cruft?
