From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 3/3] git-push: make git push --dry-run --porcelain
 exit with status 0 even if updates will be rejected
Date: Mon, 15 Feb 2010 12:42:17 -0800
Message-ID: <7vmxzaxmc6.fsf@alter.siamese.dyndns.org>
References: <214a0317f2e4707a866b2f5d10509296bc1479c1.1265661033.git.larry@elder-gods.org> <032264a40d15cb9f4a86885947ffa23a603bfb0e.1265661033.git.larry@elder-gods.org> <7vtytqyrlk.fsf@alter.siamese.dyndns.org> <20100215174013.GA12761@cthulhu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Larry D'Anna <larry@elder-gods.org>
X-From: git-owner@vger.kernel.org Mon Feb 15 21:42:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nh7m4-0000n4-7B
	for gcvg-git-2@lo.gmane.org; Mon, 15 Feb 2010 21:42:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755067Ab0BOUm1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2010 15:42:27 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:34328 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753422Ab0BOUm0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2010 15:42:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3DED19AEAF;
	Mon, 15 Feb 2010 15:42:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=jB07WyLnmlEehIm5k2T+CStJjh8=; b=CuEgKQRUhOOZMaS6h0bbQlj
	VtiqnbgZorC21iApZhKdlGfcT2b4q8oDkBV2eyW+98W/xoEvDEl2K+CBDu+gO+dF
	HeF544eD/rB8IHF1tAI9uNgQk8XKMRMPdo8XLCJbok6uwaxcS6ATMqfRha/q+m5U
	V6Htg60x/RwUIYX54CYc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=VihCibQLtRgtGgDAQyZTR+QJHC7q1UzBMTRQZrMX7VLR+3BxZ
	rzF6BwOuqYo/jMP9ldLMPaya4jub7+Oq1jrRv3SKJbd2e5ZqcXBvmSGeQ1Y53Bdb
	woK0SnSW5CldRAQ8xei93B3sQyswOcf1BB9JyATBzOe18wD+vupY6cao+U=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D1C19AEAE;
	Mon, 15 Feb 2010 15:42:22 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 50AB69AEAB; Mon, 15 Feb
 2010 15:42:19 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9DC7D9B2-1A72-11DF-90DE-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140030>

Larry D'Anna <larry@elder-gods.org> writes:

> Which version of the --quiet behavior do you want for the next version
> of this series?  My feeling is that "even if you asked for --quiet, we
> would report if there is an error" is the best policy, even under
> --dry-run --porcelain.

I think that is probably a sane and the least-surprising thing to do from
the end user's point of view.
